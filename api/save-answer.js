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

    let decoded;
    try {
      decoded = await admin.auth().verifyIdToken(token);
    } catch (err) {
      console.error("Token inválido:", err?.message || err);
      return res.status(401).json({ error: "Token inválido" });
    }

    const {
      questionId,
      selectedAnswer,
      selectedAnswers,
      correctAnswer,
      correctAnswers,
    } = req.body || {};

    const normalizeAnswers = (arrOrSingle) => {
      if (Array.isArray(arrOrSingle)) return arrOrSingle.map((v) => String(v).toUpperCase());
      if (arrOrSingle || arrOrSingle === 0) return [String(arrOrSingle).toUpperCase()];
      return [];
    };

    const normalizedSelectedAnswers = Array.isArray(selectedAnswers)
      ? selectedAnswers.map((v) => String(v).toUpperCase())
      : normalizeAnswers(selectedAnswer);
    const normalizedCorrectAnswers = Array.isArray(correctAnswers)
      ? correctAnswers.map((v) => String(v).toUpperCase())
      : normalizeAnswers(correctAnswer);

    if (!questionId) {
      return res.status(400).json({ error: "Dados incompletos: questionId ausente" });
    }
    if (normalizedSelectedAnswers.length === 0) {
      return res.status(400).json({ error: "Dados incompletos: selectedAnswer(s) ausente(s)" });
    }
    if (normalizedCorrectAnswers.length === 0) {
      return res.status(400).json({ error: "Dados incompletos: correctAnswer(s) ausente(s)" });
    }

    function areAnswersEqual(a = [], b = []) {
      const A = [...a].map((v) => String(v).toUpperCase()).sort();
      const B = [...b].map((v) => String(v).toUpperCase()).sort();
      return A.length === B.length && A.every((value, index) => value === B[index]);
    }

    const isCorrect = areAnswersEqual(normalizedSelectedAnswers, normalizedCorrectAnswers);

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
      console.error("Supabase error:", error);
      return res.status(500).json({ error: "Erro Supabase: " + (error.message || JSON.stringify(error)) });
    }

    return res.status(200).json({ success: true, isCorrect });
  } catch (error) {
    console.error(error);
    return res.status(401).json({ error: "Token inválido" });
  }
}