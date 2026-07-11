import dotenv from "dotenv";
dotenv.config({ path: ".env.local" });

import admin from "firebase-admin";
import { createClient } from "@supabase/supabase-js";

if (!admin.apps.length) {
  admin.initializeApp({
    credential: admin.credential.cert({
      projectId: process.env.FIREBASE_PROJECT_ID,
      clientEmail: process.env.FIREBASE_CLIENT_EMAIL,
      privateKey: process.env.FIREBASE_PRIVATE_KEY?.replace(/\\n/g, "\n"),
    }),
  });
}

const supabase = createClient(
  process.env.SUPABASE_URL,
  process.env.SUPABASE_SERVICE_ROLE_KEY
);

async function verifyUser(req) {
  const token = req.headers.authorization?.replace("Bearer ", "");
  if (!token) {
    const error = new Error("Token ausente");
    error.status = 401;
    throw error;
  }
  try {
    return await admin.auth().verifyIdToken(token);
  } catch (err) {
    const error = new Error("Token inválido");
    error.status = 401;
    error.cause = err;
    throw error;
  }
}

async function getQuestionDisciplines(questionIds) {
  if (questionIds.length === 0) return new Map();

  const { data: questions, error } = await supabase
    .from("questions")
    .select("id, disciplines(name)")
    .in("id", questionIds);

  if (error) throw error;

  return new Map(
    (questions || []).map((question) => [
      question.id,
      question.disciplines?.name || "",
    ])
  );
}

async function getProgress(req, res, userId) {
  const { data, error } = await supabase
    .from("user_answers")
    .select("question_id, selected_answer, selected_answers, is_correct, answered_at")
    .eq("firebase_user_id", userId)
    .order("answered_at", { ascending: true });

  if (error) throw error;

  const rows = data || [];
  const questionIds = rows.map((answer) => answer.question_id).filter(Boolean);
  const disciplinesByQuestionId = await getQuestionDisciplines(questionIds);

  const answers = rows.reduce((acc, answer) => {
    const selectedAnswers = Array.isArray(answer.selected_answers) && answer.selected_answers.length > 0
      ? answer.selected_answers
      : answer.selected_answer ? [answer.selected_answer] : [];

    acc[answer.question_id] = {
      selected: selectedAnswers.length > 1 ? selectedAnswers : selectedAnswers[0] || null,
      selectedAnswers,
      correct: !!answer.is_correct,
      disciplina: disciplinesByQuestionId.get(answer.question_id) || "",
      answeredAt: answer.answered_at,
    };
    return acc;
  }, {});

  return res.status(200).json({ answers });
}

async function deleteDisciplineProgress(req, res, userId) {
  const { disciplineName } = req.body || {};
  if (!disciplineName) {
    return res.status(400).json({ error: "disciplineName ausente" });
  }

  const { data: discipline, error: disciplineError } = await supabase
    .from("disciplines")
    .select("id")
    .eq("name", disciplineName)
    .single();

  if (disciplineError) throw disciplineError;

  const { data: questions, error: questionsError } = await supabase
    .from("questions")
    .select("id")
    .eq("discipline_id", discipline.id);

  if (questionsError) throw questionsError;

  const questionIds = (questions || []).map((question) => question.id);
  if (questionIds.length === 0) {
    return res.status(200).json({ success: true, deleted: 0 });
  }

  const { error: deleteError, count } = await supabase
    .from("user_answers")
    .delete({ count: "exact" })
    .eq("firebase_user_id", userId)
    .in("question_id", questionIds);

  if (deleteError) throw deleteError;

  return res.status(200).json({ success: true, deleted: count || 0 });
}

export default async function handler(req, res) {
  try {
    const decoded = await verifyUser(req);

    if (req.method === "GET") {
      return getProgress(req, res, decoded.uid);
    }

    if (req.method === "DELETE") {
      return deleteDisciplineProgress(req, res, decoded.uid);
    }

    return res.status(405).json({ error: "Method not allowed" });
  } catch (error) {
    console.error("Erro em /api/progress:", error?.cause || error);
    return res.status(error.status || 500).json({ error: error.message || "Erro ao carregar progresso" });
  }
}
