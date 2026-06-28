import dotenv from "dotenv";
dotenv.config({ path: ".env.local" });

import admin from "firebase-admin";
import { createClient } from "@supabase/supabase-js";

const VALID_DIFFICULTIES = new Set(["fácil", "médio", "difícil"]);
const VALID_QUESTION_TYPES = new Set(["single", "multiple", "true_false"]);
const VALID_ANSWER_LETTERS = new Set(["A", "B", "C", "D", "E"]);

function getFirebaseAdmin() {
  const requiredEnv = [
    "FIREBASE_PROJECT_ID",
    "FIREBASE_CLIENT_EMAIL",
    "FIREBASE_PRIVATE_KEY",
  ];
  const missing = requiredEnv.filter((key) => !process.env[key]);
  if (missing.length > 0) {
    throw new Error(`Variáveis Firebase ausentes: ${missing.join(", ")}`);
  }

  if (!admin.apps.length) {
    admin.initializeApp({
      credential: admin.credential.cert({
        projectId: process.env.FIREBASE_PROJECT_ID,
        clientEmail: process.env.FIREBASE_CLIENT_EMAIL,
        privateKey: process.env.FIREBASE_PRIVATE_KEY?.replace(/\\n/g, "\n"),
      }),
    });
  }

  return admin;
}

function getSupabaseAdmin() {
  const requiredEnv = ["SUPABASE_URL", "SUPABASE_SERVICE_ROLE_KEY"];
  const missing = requiredEnv.filter((key) => !process.env[key]);
  if (missing.length > 0) {
    throw new Error(`Variáveis Supabase ausentes: ${missing.join(", ")}`);
  }

  return createClient(
    process.env.SUPABASE_URL,
    process.env.SUPABASE_SERVICE_ROLE_KEY
  );
}

function normalizeExamCode(value) {
  const raw = String(value || "").trim().toUpperCase();
  const directMatch = raw.match(/^P\s*(\d+)$/);
  if (directMatch) return `P${directMatch[1]}`;

  const labelMatch = raw.match(/^PROVA\s*(\d+)$/);
  if (labelMatch) return `P${labelMatch[1]}`;

  return raw || "P1";
}

function emptyToNull(value) {
  return value ? String(value) : null;
}

function normalizeNullableText(value) {
  const text = String(value || "").trim();
  return text || null;
}

function normalizeRequiredText(value, fieldLabel) {
  const text = String(value || "").trim();
  if (!text) {
    throw new Error(`${fieldLabel} é obrigatório`);
  }
  return text;
}

function normalizeCorrectAnswers(value) {
  const answers = Array.isArray(value)
    ? value
    : String(value || "").split(",");

  return [...new Set(
    answers
      .map((answer) => String(answer || "").trim().toUpperCase())
      .filter(Boolean)
  )];
}

function normalizeAlternatives(value) {
  if (!Array.isArray(value)) return [];

  return value
    .map((alternative) => ({
      letter: String(alternative?.letter || "").trim().toUpperCase(),
      text: String(alternative?.text || "").trim(),
      explanation: normalizeNullableText(alternative?.explanation),
    }))
    .filter((alternative) => alternative.letter && alternative.text);
}

async function assertAdmin(firebaseAdmin, token) {
  if (!token) {
    return { status: 401, error: "Token ausente" };
  }

  let decoded;
  try {
    decoded = await firebaseAdmin.auth().verifyIdToken(token);
  } catch (err) {
    console.error("Token inválido:", err?.message || err);
    return { status: 401, error: "Token inválido" };
  }

  const userSnap = await firebaseAdmin.firestore().collection("users").doc(decoded.uid).get();
  const userData = userSnap.exists ? userSnap.data() : null;
  if (userData?.role !== "admin") {
    return { status: 403, error: "Apenas administradores podem criar questões" };
  }

  return null;
}

export default async function handler(req, res) {
  if (req.method !== "POST") {
    return res.status(405).json({ error: "Method not allowed" });
  }

  try {
    const firebaseAdmin = getFirebaseAdmin();
    const supabase = getSupabaseAdmin();
    const authError = await assertAdmin(firebaseAdmin, req.headers.authorization?.replace("Bearer ", ""));
    if (authError) {
      return res.status(authError.status).json({ error: authError.error });
    }

    const {
      disciplineId,
      exam,
      topicId,
      grandThemeId,
      domainId,
      detailId,
      difficulty,
      questionType,
      active,
      statement,
      correctAnswers,
      generalComment,
      summary,
      memoryTip,
      trap,
      reference,
      alternatives,
    } = req.body || {};

    if (!disciplineId) {
      return res.status(400).json({ error: "Disciplina é obrigatória" });
    }

    if (!VALID_DIFFICULTIES.has(difficulty)) {
      return res.status(400).json({ error: "Dificuldade inválida" });
    }

    if (!VALID_QUESTION_TYPES.has(questionType)) {
      return res.status(400).json({ error: "Tipo de questão inválido" });
    }

    if (typeof active !== "boolean") {
      return res.status(400).json({ error: "Status active inválido" });
    }

    let normalizedStatement;
    let normalizedCorrectAnswers;
    let normalizedAlternatives;

    try {
      normalizedStatement = normalizeRequiredText(statement, "Enunciado");
      normalizedCorrectAnswers = normalizeCorrectAnswers(correctAnswers);
      normalizedAlternatives = normalizeAlternatives(alternatives);
    } catch (validationError) {
      return res.status(400).json({ error: validationError?.message || "Dados inválidos" });
    }

    if (normalizedAlternatives.length === 0) {
      return res.status(400).json({ error: "Informe pelo menos uma alternativa com texto" });
    }

    const alternativeLetters = new Set(normalizedAlternatives.map((alternative) => alternative.letter));
    const invalidAnswers = normalizedCorrectAnswers.filter(
      (answer) => !VALID_ANSWER_LETTERS.has(answer) || !alternativeLetters.has(answer)
    );

    if (normalizedCorrectAnswers.length === 0 || invalidAnswers.length > 0) {
      return res.status(400).json({ error: "Resposta correta inválida para as alternativas informadas" });
    }

    if (questionType === "single" && normalizedCorrectAnswers.length !== 1) {
      return res.status(400).json({ error: "Questões single devem ter exatamente uma resposta correta" });
    }

    const questionPayload = {
      discipline_id: disciplineId,
      topic_id: emptyToNull(topicId),
      exam: normalizeExamCode(exam),
      grand_theme_id: emptyToNull(grandThemeId),
      domain_id: emptyToNull(domainId),
      detail_id: emptyToNull(detailId),
      difficulty,
      question_type: questionType,
      correct_answer: normalizedCorrectAnswers[0],
      correct_answers: normalizedCorrectAnswers,
      statement: normalizedStatement,
      general_comment: normalizeNullableText(generalComment),
      summary: normalizeNullableText(summary),
      memory_tip: normalizeNullableText(memoryTip),
      trap: normalizeNullableText(trap),
      reference: normalizeNullableText(reference),
      active,
    };

    const { data: question, error: questionError } = await supabase
      .from("questions")
      .insert(questionPayload)
      .select("id")
      .single();

    if (questionError) {
      console.error("Supabase question insert error:", questionError);
      return res.status(500).json({ error: `Erro Supabase: ${questionError.message || JSON.stringify(questionError)}` });
    }

    const { error: alternativesError } = await supabase
      .from("alternatives")
      .insert(normalizedAlternatives.map((alternative) => ({
        question_id: question.id,
        letter: alternative.letter,
        text: alternative.text,
        explanation: alternative.explanation,
      })));

    if (alternativesError) {
      console.error("Supabase alternatives insert error:", alternativesError);
      return res.status(500).json({ error: `Questão criada, mas houve erro ao inserir alternativas: ${alternativesError.message || JSON.stringify(alternativesError)}` });
    }

    return res.status(200).json({ success: true, question });
  } catch (error) {
    console.error("Erro ao criar questão:", error);
    return res.status(500).json({ error: error?.message || "Erro interno" });
  }
}
