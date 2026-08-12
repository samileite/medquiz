/* eslint-env node */
import fs from "node:fs";
import path from "node:path";

const sourcePath = process.argv[2];
if (!sourcePath) throw new Error("Informe o caminho do texto-fonte.");
const source = fs.readFileSync(sourcePath, "utf8").replace(/\r/g, "");
fs.writeFileSync("scripts/endocrino-p4-source.txt", source);
const lines = source.split("\n");
const p3Sql = fs.readFileSync("supabase/migrations/20260731_import_endocrinologia_prova_3.sql", "utf8");
let singles = JSON.parse(p3Sql.match(/\$data\$([\s\S]*?)\$data\$/)[1]);

const normalize = (value) => String(value || "").normalize("NFD").replace(/[\u0300-\u036f]/g, "")
  .toLowerCase().replace(/[^a-z0-9]+/g, " ").trim();
const clean = (value) => String(value || "").replace(/^\s*\(\s*[VF]?\s*\)\s*/i, "").replace(/\s+/g, " ").trim();

function extractMcqBlocks() {
  const result = [];
  for (let answerIndex = 0; answerIndex < lines.length; answerIndex++) {
    if (!/^Gabarito\.\s*Justificativa:/i.test(lines[answerIndex].trim())) continue;
    let start = answerIndex - 1;
    while (start >= 0 && !/^Explicação geral:/i.test(lines[start].trim())) start--;
    let end = answerIndex + 1;
    while (end < lines.length && !/^Explicação geral:/i.test(lines[end].trim())) end++;
    const markers = [];
    for (let i = start + 1; i < end; i++) if (/^(?:Gabarito\.\s*)?Justificativa:/i.test(lines[i].trim())) markers.push(i);
    if (markers.length !== 5) continue;
    const alts = markers.map((marker, position) => {
      let textIndex = marker - 1;
      while (textIndex > start && !lines[textIndex].trim()) textIndex--;
      const nextTextIndex = position + 1 < markers.length
        ? (() => { let n = markers[position + 1] - 1; while (n > marker && !lines[n].trim()) n--; return n; })()
        : end;
      const first = lines[marker].replace(/^\s*(?:Gabarito\.\s*)?Justificativa:\s*/i, "");
      const continuation = lines.slice(marker + 1, nextTextIndex).join("\n").trimEnd();
      return { l: String.fromCharCode(65 + position), t: lines[textIndex].trim(), e: first + (continuation ? `\n${continuation}` : "") };
    });
    const correct = String.fromCharCode(65 + markers.indexOf(answerIndex));
    result.push({ alts, correct });
  }
  return result;
}

const sourceMcqs = extractMcqBlocks();
const sourceOrderForLegacySingles = [0, 1, 2, 3, 8, 9, 13, 5, 6, 7, 10, 11, 12, 13, 14, 15, 16, 17];
singles = singles
  .filter((_, index) => index !== 13)
  .map((question, index) => {
    const legacyIndex = index < 13 ? index : index + 1;
    const sourceQuestion = sourceMcqs[sourceOrderForLegacySingles[legacyIndex]];
    return { ...question, correct: sourceQuestion.correct, alts: sourceQuestion.alts };
  });
const topicFor = (text) => {
  const n = normalize(text);
  if (/adrenal|cushing|feocrom|aldoster|addison|21 hidrox|hipercort/.test(n)) return "Suprarrenal";
  if (/acromeg|hormonio de crescimento|\bgh\b/.test(n)) return "Hipófise — Hiperfunção";
  if (/prolact|galactor|amenorre/.test(n)) return "Hipófise — Hiperfunção";
  if (/hipopit|sheehan|hipofun|hipofis|macroadenoma|incidentaloma hipofis/.test(n)) return "Hipófise — Hipofunção";
  if (/osseo|ossea|osteopor|parat|\bpth\b|calcio|fosforo/.test(n)) return "Metabolismo ósseo e paratireoide";
  return "Endocrinologia geral";
};

const chunks = source.split(/\nExplicação geral:\s*/i);
const blocks = [];
for (const chunk of chunks) {
  if (!/(assinale|julgue)[^\n]{0,100}\bV\b[^\n]{0,40}\bF\b|verdadeiro[^\n]{0,40}falso/i.test(chunk)) continue;
  const chunkLines = chunk.split("\n");
  const items = [];
  for (let i = 0; i < chunkLines.length; i++) {
    if (!/^Justificativa:\s*/i.test(chunkLines[i].trim())) continue;
    let j = i - 1;
    while (j >= 0 && !chunkLines[j].trim()) j--;
    if (j < 0) continue;
    const raw = chunkLines[j].trim();
    if (/^(Gabarito|Dica|Explicação|Caso)/i.test(raw)) continue;
    let reason = chunkLines[i].trim().replace(/^Justificativa:\s*/i, "");
    let k = i + 1;
    while (k < chunkLines.length && chunkLines[k].trim() && !/^Justificativa:/i.test(chunkLines[k].trim()) && !/^\s*\(\s*[VF]?\s*\)/i.test(chunkLines[k])) {
      if (/^(Explicação geral|Dica de memorização)/i.test(chunkLines[k].trim())) break;
      reason += "\n" + chunkLines[k].trim(); k++;
    }
    const explicit = raw.match(/^\(\s*([VF])\s*\)/i)?.[1]?.toUpperCase();
    let verdict = explicit || (/^Verdadeir[ao]\b/i.test(reason) ? "V" : /^Fals[ao]\b/i.test(reason) ? "F" : null);
    if (!verdict) continue;
    const assertion = clean(raw);
    if (assertion.length < 12 || /Gabarito/i.test(assertion)) continue;
    reason = reason.trim();
    items.push({ l: String.fromCharCode(65 + items.length), t: assertion, v: verdict, e: reason });
  }
  if (items.length < 2 || items.length > 8) continue;
  const firstItemIndex = chunkLines.findIndex((line) => clean(line) === items[0].t);
  let headerIndex = -1;
  for (let i = 0; i < firstItemIndex; i++) if (/assinale|julgue/i.test(chunkLines[i])) headerIndex = i;
  let contextStart = headerIndex - 1;
  while (contextStart >= 0 && chunkLines[contextStart].trim()) contextStart--;
  const prefix = chunkLines.slice(contextStart + 1, headerIndex)
    .filter((line) => line.trim() && !/turma|lista/i.test(line)).map(clean).join(" ");
  const signature = items.map((item) => normalize(item.t)).sort().join("|");
  blocks.push({ signature, stem: prefix || "Considere as afirmações endocrinológicas a seguir.", items });
}

const uniqueBlocks = [];
const signatures = new Set();
for (const block of blocks) {
  if (signatures.has(block.signature)) continue;
  signatures.add(block.signature);
  uniqueBlocks.push(block);
}

const grouped = uniqueBlocks.map((block, index) => {
  const context = `${block.stem} ${block.items.map((item) => item.t).join(" ")}`;
  const topic = topicFor(block.items.map((item) => item.t).join(" "));
  const usableStem = block.stem.length > 20 && !/^Dica de memorização/i.test(block.stem) && !/^Considere as afirmações/i.test(block.stem);
  return {
    n: index + 1,
    topic,
    difficulty: "médio",
    statement: (usableStem ? clean(block.stem).replace(/[:.]?$/, ".") : `Bloco ${index + 1} — ${topic}.`) + " Julgue cada assertiva como verdadeira ou falsa.",
    correct: block.items.map((item) => `${item.l}:${item.v}`),
    general: "Analise cada assertiva de forma independente, relacionando o padrão clínico e laboratorial à fisiologia e à conduta endocrinológica.",
    summary: "Bloco de verdadeiro ou falso revisado e consolidado a partir das listas da prova.",
    memory: "Julgue cada frase pelo mecanismo fisiológico e evite generalizações absolutas.",
    trap: "Todas as assertivas devem ser respondidas antes da submissão.",
    alts: block.items.map(({ l, t, e }) => ({ l, t, e }))
  };
});

const output = { singles, grouped };
const outputPath = path.resolve("scripts/endocrino-p4-payload.json");
fs.writeFileSync(outputPath, JSON.stringify(output, null, 2) + "\n");
const migrationPath = path.resolve("supabase/migrations/20260812020000_correct_endocrinologia_p4_source_fidelity.sql");
const payload = [...singles.map((q) => ({ ...q, type: "single", correct: [q.correct] })), ...grouped.map((q) => ({ ...q, n: q.n + singles.length, type: "true_false" }))];
const sql = `-- Payload MedQuiz — Prova 4 de Endocrinologia, deduplicado e revisado.\nBEGIN;\n\nCREATE OR REPLACE FUNCTION pg_temp.endo_p4_uuid(seed text) RETURNS uuid\nLANGUAGE sql IMMUTABLE AS $$\n  SELECT (substr(md5(seed),1,8)||'-'||substr(md5(seed),9,4)||'-5'||substr(md5(seed),14,3)||'-a'||substr(md5(seed),18,3)||'-'||substr(md5(seed),21,12))::uuid\n$$;\n\nDO $$\nDECLARE d uuid; t uuid; qid uuid; q record; a jsonb; letters text[];\nBEGIN\n  SELECT id INTO d FROM public.disciplines WHERE name='Endocrinologia' LIMIT 1;\n  IF d IS NULL THEN RAISE EXCEPTION 'Disciplina Endocrinologia não encontrada'; END IF;\n  FOR q IN SELECT * FROM jsonb_to_recordset($data$${JSON.stringify(payload)}$data$::jsonb)\n    AS x(n integer,topic text,difficulty text,statement text,type text,correct jsonb,general text,summary text,memory text,trap text,alts jsonb)\n  LOOP\n    SELECT id INTO t FROM public.topics WHERE discipline_id=d AND name=q.topic LIMIT 1;\n    IF t IS NULL THEN\n      t:=pg_temp.endo_p4_uuid('endocrinologia-topic-'||q.topic);\n      INSERT INTO public.topics(id,discipline_id,name) VALUES(t,d,q.topic) ON CONFLICT(id) DO UPDATE SET name=EXCLUDED.name;\n    END IF;\n    qid:=pg_temp.endo_p4_uuid('endocrinologia-prova-4-q'||q.n);\n    letters:=ARRAY(SELECT jsonb_array_elements_text(q.correct));\n    INSERT INTO public.questions(id,discipline_id,topic_id,exam,difficulty,statement,question_type,correct_answer,correct_answers,general_comment,summary,memory_tip,trap,reference,active,image_url)\n    VALUES(qid,d,t,'P4',q.difficulty,q.statement,q.type,split_part(letters[1],':',1),letters,q.general,q.summary,q.memory,q.trap,'Prova 4 de Endocrinologia — listas consolidadas, deduplicadas e revisadas em 2026.',true,NULL)\n    ON CONFLICT(id) DO UPDATE SET topic_id=EXCLUDED.topic_id,exam='P4',difficulty=EXCLUDED.difficulty,statement=EXCLUDED.statement,question_type=EXCLUDED.question_type,correct_answer=EXCLUDED.correct_answer,correct_answers=EXCLUDED.correct_answers,general_comment=EXCLUDED.general_comment,summary=EXCLUDED.summary,memory_tip=EXCLUDED.memory_tip,trap=EXCLUDED.trap,reference=EXCLUDED.reference,active=true,image_url=NULL;\n    FOR a IN SELECT value FROM jsonb_array_elements(q.alts) LOOP\n      INSERT INTO public.alternatives(id,question_id,letter,text,explanation) VALUES(pg_temp.endo_p4_uuid(qid::text||(a->>'l')),qid,a->>'l',a->>'t',a->>'e')\n      ON CONFLICT(question_id,letter) DO UPDATE SET text=EXCLUDED.text,explanation=EXCLUDED.explanation;\n    END LOOP;\n    DELETE FROM public.alternatives WHERE question_id=qid AND NOT(letter=ANY(ARRAY(SELECT value->>'l' FROM jsonb_array_elements(q.alts))));\n  END LOOP;\nEND $$;\n\nDO $$ DECLARE n integer; BEGIN\n SELECT count(*) INTO n FROM public.questions WHERE reference='Prova 4 de Endocrinologia — listas consolidadas, deduplicadas e revisadas em 2026.';\n IF n<>${payload.length} THEN RAISE EXCEPTION 'Payload P4 incompleto: % questões',n; END IF;\n IF EXISTS(SELECT 1 FROM public.questions q WHERE q.reference='Prova 4 de Endocrinologia — listas consolidadas, deduplicadas e revisadas em 2026.' AND (NOT q.active OR q.correct_answer !~ '^[A-E]$')) THEN RAISE EXCEPTION 'Questão P4 inválida'; END IF;\nEND $$;\n\nCOMMIT;\n`;
const correctiveSql = sql
  .replace("  FOR q IN SELECT * FROM", "  UPDATE public.questions SET active=false WHERE discipline_id=d AND exam='P4' AND reference='Prova 4 de Endocrinologia — listas consolidadas, deduplicadas e revisadas em 2026.';\n  FOR q IN SELECT * FROM")
  .replace("WHERE reference='Prova 4 de Endocrinologia — listas consolidadas, deduplicadas e revisadas em 2026.';\n IF n<>", "WHERE reference='Prova 4 de Endocrinologia — listas consolidadas, deduplicadas e revisadas em 2026.' AND active=true;\n IF n<>")
  .replace("Payload P4 incompleto: % questões'", "Payload P4 incompleto: % questões ativas'")
  .replace("AND (NOT q.active OR q.correct_answer", "AND q.active=true AND (q.correct_answer");
fs.writeFileSync(migrationPath, correctiveSql);
console.log(JSON.stringify({ singles: singles.length, grouped: grouped.length, assertions: grouped.reduce((n, q) => n + q.alts.length, 0), questions: payload.length, alternatives: payload.reduce((n, q) => n + q.alts.length, 0), outputPath, migrationPath }, null, 2));
