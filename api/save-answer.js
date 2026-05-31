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
      correctAnswer,
    } = req.body;

    if (!questionId || !selectedAnswer || !correctAnswer) {
      return res.status(400).json({ error: "Dados incompletos" });
    }

    const isCorrect = selectedAnswer === correctAnswer;

    const { error } = await supabase
      .from("user_answers")
      .upsert(
        {
          firebase_user_id: decoded.uid,
          question_id: questionId,
          selected_answer: selectedAnswer,
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