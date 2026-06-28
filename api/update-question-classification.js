import dotenv from "dotenv";
dotenv.config({ path: ".env.local" });

import admin from "firebase-admin";
import { createClient } from "@supabase/supabase-js";

const VALID_DIFFICULTIES = new Set(["fácil", "médio", "difícil"]);

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
      exam,
      topicId,
      grandThemeId,
      domainId,
      detailId,
      difficulty,
      active,
    } = req.body || {};

    if (!questionId) {
      return res.status(400).json({ error: "questionId ausente" });
    }

    if (!VALID_DIFFICULTIES.has(difficulty)) {
      return res.status(400).json({ error: "Dificuldade inválida" });
    }

    if (typeof active !== "boolean") {
      return res.status(400).json({ error: "Status active inválido" });
    }

    const payload = {
      exam: normalizeExamCode(exam),
      topic_id: emptyToNull(topicId),
      grand_theme_id: emptyToNull(grandThemeId),
      domain_id: emptyToNull(domainId),
      detail_id: emptyToNull(detailId),
      difficulty,
      active,
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
        active
      `)
      .single();

    if (error) {
      console.error("Supabase update error:", error);
      return res.status(500).json({ error: `Erro Supabase: ${error.message || JSON.stringify(error)}` });
    }

    return res.status(200).json({ success: true, question: data });
  } catch (error) {
    console.error("Erro ao atualizar classificação:", error);
    return res.status(500).json({ error: error?.message || "Erro interno" });
  }
}
