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

export default async function handler(req, res) {
  if (req.method !== "POST") {
    return res.status(405).json({ error: "Method not allowed" });
  }

  try {
    const firebaseAdmin = getFirebaseAdmin();
    const supabase = getSupabaseAdmin();
    const token = req.headers.authorization?.replace("Bearer ", "");
    if (!token) {
      return res.status(401).json({ error: "Token ausente" });
    }

    let decoded;
    try {
      decoded = await firebaseAdmin.auth().verifyIdToken(token);
    } catch (err) {
      console.error("Token inválido:", err?.message || err);
      return res.status(401).json({ error: "Token inválido" });
    }

    const userSnap = await firebaseAdmin.firestore().collection("users").doc(decoded.uid).get();
    const userData = userSnap.exists ? userSnap.data() : null;
    if (userData?.role !== "admin") {
      return res.status(403).json({ error: "Apenas administradores podem editar questões" });
    }

    const {
      questionId,
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

    if (!questionId) {
      return res.status(400).json({ error: "questionId ausente" });
    }

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
    const isGroupedTrueFalse = questionType === "true_false"
      && normalizedCorrectAnswers.some((answer) => answer.includes(":"));
    const invalidAnswers = normalizedCorrectAnswers.filter((answer) => {
      if (isGroupedTrueFalse) {
        const [letter, value, extra] = answer.split(":");
        return Boolean(extra) || !alternativeLetters.has(letter) || !["V", "F"].includes(value);
      }
      return !VALID_ANSWER_LETTERS.has(answer) || !alternativeLetters.has(answer);
    });

    if (normalizedCorrectAnswers.length === 0 || invalidAnswers.length > 0) {
      return res.status(400).json({ error: "Resposta correta inválida para as alternativas informadas" });
    }

    if (questionType === "single" && normalizedCorrectAnswers.length !== 1) {
      return res.status(400).json({ error: "Questões single devem ter exatamente uma resposta correta" });
    }

    if (isGroupedTrueFalse && normalizedCorrectAnswers.length !== normalizedAlternatives.length) {
      return res.status(400).json({ error: "Questões V/F devem ter um gabarito para cada assertiva" });
    }

    if (questionType === "true_false" && !isGroupedTrueFalse && normalizedCorrectAnswers.length !== 1) {
      return res.status(400).json({ error: "Questões V/F legadas devem ter exatamente uma resposta correta" });
    }

    const payload = {
      discipline_id: disciplineId,
      exam: normalizeExamCode(exam),
      topic_id: emptyToNull(topicId),
      grand_theme_id: emptyToNull(grandThemeId),
      domain_id: emptyToNull(domainId),
      detail_id: emptyToNull(detailId),
      difficulty,
      question_type: questionType,
      active,
      statement: normalizedStatement,
      correct_answer: normalizedCorrectAnswers[0],
      correct_answers: normalizedCorrectAnswers,
      general_comment: normalizeNullableText(generalComment),
      summary: normalizeNullableText(summary),
      memory_tip: normalizeNullableText(memoryTip),
      trap: normalizeNullableText(trap),
      reference: normalizeNullableText(reference),
    };

    const { data, error } = await supabase
      .from("questions")
      .update(payload)
      .eq("id", questionId)
      .select(`
        id,
        exam,
        topic_id,
        grand_theme_id,
        domain_id,
        detail_id,
        difficulty,
        question_type,
        correct_answer,
        correct_answers,
        statement,
        general_comment,
        summary,
        memory_tip,
        trap,
        reference,
        active
      `)
      .single();

    if (error) {
      console.error("Supabase update error:", error);
      return res.status(500).json({ error: `Erro Supabase: ${error.message || JSON.stringify(error)}` });
    }

    for (const alternative of normalizedAlternatives) {
      const alternativePayload = {
        text: alternative.text,
        explanation: alternative.explanation,
      };

      const { data: updatedAlternatives, error: updateAlternativeError } = await supabase
        .from("alternatives")
        .update(alternativePayload)
        .eq("question_id", questionId)
        .eq("letter", alternative.letter)
        .select("letter");

      if (updateAlternativeError) {
        console.error("Supabase alternative update error:", updateAlternativeError);
        return res.status(500).json({ error: `Erro Supabase alternativas: ${updateAlternativeError.message || JSON.stringify(updateAlternativeError)}` });
      }

      if (!updatedAlternatives?.length) {
        const { error: insertAlternativeError } = await supabase
          .from("alternatives")
          .insert({
            question_id: questionId,
            letter: alternative.letter,
            text: alternative.text,
            explanation: alternative.explanation,
          });

        if (insertAlternativeError) {
          console.error("Supabase alternative insert error:", insertAlternativeError);
          return res.status(500).json({ error: `Erro Supabase alternativas: ${insertAlternativeError.message || JSON.stringify(insertAlternativeError)}` });
        }
      }
    }

    return res.status(200).json({ success: true, question: data });
  } catch (error) {
    console.error("Erro ao atualizar classificação:", error);
    return res.status(500).json({ error: error?.message || "Erro interno" });
  }
}
