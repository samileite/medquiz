import crypto from "node:crypto";
import fs from "node:fs/promises";
import path from "node:path";
import { fileURLToPath } from "node:url";
import dotenv from "dotenv";
import WebSocket from "ws";
import { createClient } from "@supabase/supabase-js";

dotenv.config({ path: ".env.import", quiet: true });

const currentDir = path.dirname(fileURLToPath(import.meta.url));
const importDir = path.resolve(currentDir, "../supabase/imports/pneumologia_p3");
const includeOpen = process.argv.includes("--include-open");
const sources = [
  {
    file: "01_questoes_fechadas.sql",
    kind: "closed",
    idPrefix: "pneumologia-p3-fechada-",
    active: true,
  },
  {
    file: "03_abertas_transformadas_em_fechadas.sql",
    kind: "converted",
    idPrefix: "pneumologia-p3-aberta-objetivada-",
    active: true,
  },
];

if (includeOpen) {
  sources.push({
    file: "02_questoes_abertas.sql",
    kind: "open",
    idPrefix: "pneumologia-p3-aberta-",
    active: false,
  });
}

if (!process.env.SUPABASE_URL || !process.env.SUPABASE_SERVICE_ROLE_KEY) {
  throw new Error("SUPABASE_URL e SUPABASE_SERVICE_ROLE_KEY são obrigatórios em .env.import");
}

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY,
  { realtime: { transport: WebSocket } }
);

function deterministicUuid(seed) {
  const hash = crypto.createHash("md5").update(seed).digest("hex");
  return `${hash.slice(0, 8)}-${hash.slice(8, 12)}-5${hash.slice(13, 16)}-a${hash.slice(17, 20)}-${hash.slice(20, 32)}`;
}

async function readPayload(source) {
  const sql = await fs.readFile(path.join(importDir, source.file), "utf8");
  const match = sql.match(/\$data\$([\s\S]*?)\$data\$/);
  if (!match) throw new Error(`Bloco $data$ não encontrado em ${source.file}`);
  return JSON.parse(match[1]);
}

function normalizeQuestion(raw, source) {
  if (source.kind === "open") {
    return {
      id: deterministicUuid(`${source.idPrefix}${raw.n}`),
      topic: raw.topic,
      difficulty: raw.difficulty,
      statement: raw.statement,
      questionType: "open",
      correctAnswer: null,
      correctAnswers: [],
      generalComment: raw.answer,
      summary: raw.summary,
      memoryTip: raw.memory,
      trap: raw.trap,
      active: source.active,
      alternatives: [],
    };
  }

  const alternatives = source.kind === "closed"
    ? Object.entries(raw.alts).map(([letter, text]) => ({
      letter,
      text,
      explanation: raw.exps[letter],
    }))
    : raw.alts.map((alternative) => ({
      letter: alternative.l,
      text: alternative.t,
      explanation: alternative.e,
    }));

  return {
    id: deterministicUuid(`${source.idPrefix}${raw.n}`),
    topic: raw.topic,
    difficulty: raw.difficulty,
    statement: raw.statement,
    questionType: "single",
    correctAnswer: raw.correct,
    correctAnswers: [raw.correct],
    generalComment: source.kind === "closed"
      ? `Resposta correta: ${raw.correct}. ${raw.summary}`
      : raw.general,
    summary: raw.summary,
    memoryTip: raw.memory,
    trap: raw.trap,
    active: source.active,
    alternatives,
  };
}

async function getDiscipline() {
  const { data, error } = await supabase
    .from("disciplines")
    .select("id, name")
    .eq("name", "Pneumologia")
    .single();
  if (error) throw error;
  return data;
}

async function getOrCreateTopic(disciplineId, name) {
  const { data: existing, error: selectError } = await supabase
    .from("topics")
    .select("id")
    .eq("discipline_id", disciplineId)
    .eq("name", name)
    .maybeSingle();
  if (selectError) throw selectError;
  if (existing) return existing.id;

  const { data, error } = await supabase
    .from("topics")
    .insert({ discipline_id: disciplineId, name })
    .select("id")
    .single();
  if (error) throw error;
  return data.id;
}

async function importQuestion(disciplineId, question) {
  const topicId = await getOrCreateTopic(disciplineId, question.topic);
  const reference = question.questionType === "open"
    ? "Prova 3 de Pneumologia — questão aberta e resposta-modelo revisada no padrão MedQuiz."
    : "Prova 3 de Pneumologia — questão objetiva revisada no padrão MedQuiz.";

  const { error: questionError } = await supabase.from("questions").upsert({
    id: question.id,
    discipline_id: disciplineId,
    topic_id: topicId,
    exam: "P3",
    difficulty: question.difficulty,
    statement: question.statement,
    question_type: question.questionType,
    correct_answer: question.correctAnswer,
    correct_answers: question.correctAnswers,
    general_comment: question.generalComment,
    summary: question.summary,
    memory_tip: question.memoryTip,
    trap: question.trap,
    reference,
    active: question.active,
    image_url: null,
  }, { onConflict: "id" });
  if (questionError) throw questionError;

  if (question.alternatives.length === 0) return;
  const rows = question.alternatives.map((alternative) => ({
    id: deterministicUuid(`${question.id}${alternative.letter}`),
    question_id: question.id,
    letter: alternative.letter,
    text: alternative.text,
    explanation: alternative.explanation,
  }));
  const { error: alternativesError } = await supabase
    .from("alternatives")
    .upsert(rows, { onConflict: "question_id,letter" });
  if (alternativesError) throw alternativesError;
}

async function verify(disciplineId, expectedIds) {
  const { data, error } = await supabase
    .from("questions")
    .select("id, active, exam, question_type, alternatives(letter)")
    .eq("discipline_id", disciplineId)
    .in("id", expectedIds);
  if (error) throw error;

  const active = data.filter((question) => question.active);
  const alternatives = data.reduce(
    (total, question) => total + (question.alternatives?.length || 0),
    0
  );
  return { questions: data.length, active: active.length, alternatives };
}

async function main() {
  const discipline = await getDiscipline();
  const questions = [];

  for (const source of sources) {
    const payload = await readPayload(source);
    questions.push(...payload.map((raw) => normalizeQuestion(raw, source)));
  }

  for (const question of questions) {
    await importQuestion(discipline.id, question);
  }

  const result = await verify(discipline.id, questions.map((question) => question.id));
  if (result.questions !== questions.length) {
    throw new Error(`Verificação falhou: esperado ${questions.length}, encontrado ${result.questions}`);
  }

  console.log(JSON.stringify({
    discipline: discipline.name,
    exam: "P3",
    imported: result.questions,
    active: result.active,
    alternatives: result.alternatives,
    includeOpen,
  }, null, 2));
}

main().catch((error) => {
  console.error("Falha ao importar Pneumologia P3:", error.message);
  process.exit(1);
});
