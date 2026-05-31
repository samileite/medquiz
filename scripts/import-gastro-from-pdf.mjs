import dotenv from "dotenv";
import WebSocket from "ws";
import { createClient } from "@supabase/supabase-js";
import fs from "fs/promises";
import path from "path";

dotenv.config({ path: ".env.import" });

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY,
  {
    realtime: {
      transport: WebSocket,
    },
  }
);

const fileArg = process.argv[2] || "./scripts/gastro-from-pdf.json";
const filePath = path.resolve(process.cwd(), fileArg);

async function readSourceFile() {
  const content = await fs.readFile(filePath, "utf-8");
  return JSON.parse(content);
}

async function upsertDiscipline() {
  const { data, error } = await supabase
    .from("disciplines")
    .upsert({ name: "Gastroenterologia", slug: "gastroenterologia" }, { onConflict: "slug" })
    .select()
    .single();

  if (error) throw error;
  return data;
}

async function upsertTopic(disciplineId, name) {
  const { data: existing, error: existingError } = await supabase
    .from("topics")
    .select("*")
    .eq("discipline_id", disciplineId)
    .eq("name", name)
    .maybeSingle();

  if (existingError) throw existingError;
  if (existing) return existing;

  const { data, error } = await supabase
    .from("topics")
    .insert({ discipline_id: disciplineId, name })
    .select()
    .single();

  if (error) throw error;
  return data;
}

function normalizeQuestionRaw(question) {
  const questionType = (question.questionType || question.question_type || "single").toString().toLowerCase();
  if (questionType === "discursive") return null;

  const correctAnswers = question.correctAnswers || question.correct_answers ||
    (question.correctAnswer ? [question.correctAnswer] : []);

  if (questionType === "multiple" && correctAnswers.length === 0) {
    console.warn("Pulando questão múltipla sem respostas corretas:", question.statement?.slice(0, 80));
    return null;
  }

  if (questionType === "single" && correctAnswers.length === 0) {
    console.warn("Pulando questão única sem resposta correta:", question.statement?.slice(0, 80));
    return null;
  }

  const alternatives = (question.alternatives || [])
    .map((a) => ({
      letter: a.letter?.toString().toUpperCase(),
      text: a.text?.toString().trim(),
      explanation: a.explanation?.toString().trim() || null,
    }))
    .filter((a) => a.letter && a.text);

  if (alternatives.length === 0) {
    console.warn("Pulando questão sem alternativas válidas:", question.statement?.slice(0, 80));
    return null;
  }

  return {
    topic: question.topic || question.section || "Gastroenterologia",
    difficulty: question.difficulty || "médio",
    statement: question.statement,
    questionType,
    correctAnswers: correctAnswers.map((item) => item.toString().toUpperCase()),
    alternatives,
    generalComment: question.generalComment || question.general_comment || null,
    summary: question.summary || question.resumo || null,
    memoryTip: question.memoryTip || question.memory_tip || null,
    trap: question.trap || null,
    reference: question.reference || null,
  };
}

async function importQuestions() {
  const raw = await readSourceFile();
  const sections = raw.sections || [];
  const uploadedQuestions = raw.questions || [];

  const questions = [];

  if (uploadedQuestions.length > 0) {
    questions.push(...uploadedQuestions.map((q) => normalizeQuestionRaw(q)).filter(Boolean));
  }

  for (const section of sections) {
    const topicName = section.topic || section.title || "Gastroenterologia";
    if (!Array.isArray(section.questions)) continue;
    for (const question of section.questions) {
      const normalized = normalizeQuestionRaw({ ...question, topic: topicName });
      if (normalized) questions.push(normalized);
    }
  }

  if (questions.length === 0) {
    throw new Error(`Nenhuma questão valida encontrada em ${filePath}`);
  }

  const discipline = await upsertDiscipline();
  console.log(`Disciplina: ${discipline.name} (${discipline.id})`);
  console.log(`Questões para importar: ${questions.length}`);

  let imported = 0;

  for (const question of questions) {
    const topic = await upsertTopic(discipline.id, question.topic);

    const { data: createdQuestion, error: questionError } = await supabase
      .from("questions")
      .insert({
        discipline_id: discipline.id,
        topic_id: topic.id,
        difficulty: question.difficulty,
        statement: question.statement,
        question_type: question.questionType,
        correct_answer: question.questionType === "single" ? question.correctAnswers[0] : null,
        correct_answers: question.correctAnswers,
        general_comment: question.generalComment,
        summary: question.summary,
        memory_tip: question.memoryTip,
        trap: question.trap,
        reference: question.reference,
        active: true,
      })
      .select()
      .single();

    if (questionError) throw questionError;

    if (!createdQuestion?.id) {
      throw new Error("Falha ao criar a questão");
    }

    const alternatives = question.alternatives.map((alt) => ({
      question_id: createdQuestion.id,
      letter: alt.letter,
      text: alt.text,
      explanation: alt.explanation,
    }));

    const { error: altError } = await supabase.from("alternatives").insert(alternatives);
    if (altError) throw altError;

    imported += 1;
  }

  console.log(`Importadas com sucesso: ${imported}`);
}

importQuestions().catch((err) => {
  console.error("Erro na importação:", err);
  process.exit(1);
});
