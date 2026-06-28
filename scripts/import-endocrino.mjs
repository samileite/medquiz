import dotenv from "dotenv";
import WebSocket from "ws";
import { createClient } from "@supabase/supabase-js";
import { normalizeExamCode } from "../src/utils/exams.js";

dotenv.config({
  path: ".env.import"
});
console.log("Script iniciou");
console.log("SUPABASE_URL existe?", !!process.env.SUPABASE_URL);
console.log("SERVICE_ROLE existe?", !!process.env.SUPABASE_SERVICE_ROLE_KEY);

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY,
  {
    realtime: {
      transport: WebSocket,
    },
  }
);
const SHEET_ID = "1fzeNk72BIBS0e10O07KzdE5AnnsBNwuAUMPy4x8YCv4";
const GID = "1473029296";

async function fetchSheetRows() {
  const url = `https://docs.google.com/spreadsheets/d/${SHEET_ID}/gviz/tq?tqx=out:json&gid=${GID}`;
  const res = await fetch(url);
  const text = await res.text();
  const jsonText = text.substring(text.indexOf("{"), text.lastIndexOf("}") + 1);
  const json = JSON.parse(jsonText);

  return json.table.rows
    .map((row) => row.c?.map((cell) => cell?.v?.toString().trim() || "") || [])
    .filter((c) => c[3] && c[3].toLowerCase() !== "enunciado");
}

async function upsertDiscipline() {
  const { data, error } = await supabase
    .from("disciplines")
    .upsert(
      { name: "Endocrinologia", slug: "endocrinologia" },
      { onConflict: "slug" }
    )
    .select()
    .single();

  if (error) throw error;
  return data;
}

async function upsertTopic(disciplineId, name) {
  const { data: existing } = await supabase
    .from("topics")
    .select("*")
    .eq("discipline_id", disciplineId)
    .eq("name", name)
    .maybeSingle();

  if (existing) return existing;

  const { data, error } = await supabase
    .from("topics")
    .insert({ discipline_id: disciplineId, name })
    .select()
    .single();

  if (error) throw error;
  return data;
}

async function importQuestions() {
  const rows = await fetchSheetRows();
  const discipline = await upsertDiscipline();

  console.log(`Linhas encontradas: ${rows.length}`);

  let imported = 0;

  for (const c of rows) {
    const tema = c[0] || "Endocrinologia";
    const exam = normalizeExamCode(c[2]);
    const dificuldade = c[1] || "médio";
    const enunciado = c[3];
    const resposta = (c[9] || "").toUpperCase();

    if (!["A", "B", "C", "D", "E"].includes(resposta)) {
      console.warn(`Pulando questão sem resposta válida: ${enunciado.slice(0, 80)}`);
      continue;
    }

    const topic = await upsertTopic(discipline.id, tema);

    const { data: question, error: questionError } = await supabase
      .from("questions")
      .insert({
        discipline_id: discipline.id,
        topic_id: topic.id,
        exam,
        difficulty: dificuldade,
        statement: enunciado,
        correct_answer: resposta,
        general_comment: c[10] || null,
        summary: c[16] || null,
        memory_tip: c[17] || null,
        trap: c[18] || null,
        reference: c[19] || null,
        active: true,
      })
      .select()
      .single();

    if (questionError) throw questionError;

    const alternatives = [
      { letter: "A", text: c[4], explanation: c[11] },
      { letter: "B", text: c[5], explanation: c[12] },
      { letter: "C", text: c[6], explanation: c[13] },
      { letter: "D", text: c[7], explanation: c[14] },
      { letter: "E", text: c[8], explanation: c[15] },
    ].filter((a) => a.text);

    const { error: altError } = await supabase
      .from("alternatives")
      .insert(
        alternatives.map((a) => ({
          question_id: question.id,
          letter: a.letter,
          text: a.text,
          explanation: a.explanation || null,
        }))
      );

    if (altError) throw altError;

    imported++;
  }

  console.log(`Importadas com sucesso: ${imported}`);
}

importQuestions().catch((err) => {
  console.error("Erro na importação:", err);
  process.exit(1);
});
