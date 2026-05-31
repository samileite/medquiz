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

export default async function handler(req, res) {
  if (req.method !== "POST") {
    return res.status(405).json({ error: "Method not allowed" });
  }

  try {
    const token = req.headers.authorization?.replace("Bearer ", "");

    if (!token) {
      return res.status(401).json({ error: "Token ausente" });
    }

    const decoded = await admin.auth().verifyIdToken(token);

    const {
      questionId,
      selectedAnswer,
      selectedAnswers,
      correctAnswer,
      correctAnswers,
    } = req.body;

    const normalizedSelectedAnswers = Array.isArray(selectedAnswers)
      ? selectedAnswers.map((v) => String(v).toUpperCase())
      : selectedAnswer
        ? [String(selectedAnswer).toUpperCase()]
        : [];
    const normalizedCorrectAnswers = Array.isArray(correctAnswers)
      ? correctAnswers.map((v) => String(v).toUpperCase())
      : correctAnswer
        ? [String(correctAnswer).toUpperCase()]
        : [];

    if (!questionId || normalizedSelectedAnswers.length === 0 || normalizedCorrectAnswers.length === 0) {
      return res.status(400).json({ error: "Dados incompletos" });
    }

    const sortedSelected = [...normalizedSelectedAnswers].sort();
    const sortedCorrect = [...normalizedCorrectAnswers].sort();
    const isCorrect = sortedSelected.length === sortedCorrect.length && sortedSelected.every((value, index) => value === sortedCorrect[index]);

    const { error } = await supabase
      .from("user_answers")
      .upsert(
        {
          firebase_user_id: decoded.uid,
          question_id: questionId,
          selected_answer: normalizedSelectedAnswers.length === 1 ? normalizedSelectedAnswers[0] : null,
          selected_answers: normalizedSelectedAnswers,
          correct_answers: normalizedCorrectAnswers,
          is_correct: isCorrect,
          answered_at: new Date().toISOString(),
        },
        {
          onConflict: "firebase_user_id,question_id",
        }
      );

    if (error) {
      console.error(error);
      return res.status(500).json({ error: "Erro ao salvar resposta" });
    }

    return res.status(200).json({ success: true, isCorrect });
  } catch (error) {
    console.error(error);
    return res.status(401).json({ error: "Token inválido" });
  }
}