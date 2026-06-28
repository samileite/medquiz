import dotenv from "dotenv";
dotenv.config({ path: ".env.local" });

import admin from "firebase-admin";
import { createClient } from "@supabase/supabase-js";

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
    return { status: 403, error: "Apenas administradores podem sugerir taxonomia" };
  }

  return null;
}

function normalizeText(value) {
  return String(value || "")
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .toLowerCase();
}

function tokenizeName(value) {
  return normalizeText(value)
    .split(/[^a-z0-9]+/g)
    .filter((token) => token.length >= 3);
}

function scoreName(searchableText, name, weight) {
  const normalizedName = normalizeText(name);
  let score = searchableText.includes(normalizedName) ? weight * 4 : 0;
  tokenizeName(name).forEach((token) => {
    if (searchableText.includes(token)) score += weight;
  });
  return score;
}

function uniqueTargets(rows) {
  const targets = new Map();
  rows.forEach((row) => {
    if (row.grand_theme_id) {
      targets.set(`gt:${row.grand_theme_id}`, {
        grandThemeId: row.grand_theme_id,
        grandThemeName: row.grand_theme_name,
        domainId: "",
        domainName: "",
        detailId: "",
        detailName: "",
        scoreName: row.grand_theme_name,
        weight: 1,
      });
    }

    if (row.domain_id) {
      targets.set(`d:${row.domain_id}`, {
        grandThemeId: row.grand_theme_id,
        grandThemeName: row.grand_theme_name,
        domainId: row.domain_id,
        domainName: row.domain_name,
        detailId: "",
        detailName: "",
        scoreName: `${row.grand_theme_name} ${row.domain_name}`,
        weight: 2,
      });
    }

    if (row.detail_id) {
      targets.set(`dt:${row.detail_id}`, {
        grandThemeId: row.grand_theme_id,
        grandThemeName: row.grand_theme_name,
        domainId: row.domain_id,
        domainName: row.domain_name,
        detailId: row.detail_id,
        detailName: row.detail_name,
        scoreName: `${row.grand_theme_name} ${row.domain_name} ${row.detail_name}`,
        weight: 3,
      });
    }
  });

  return [...targets.values()];
}

function questionText(question) {
  return normalizeText([
    question.statement,
    question.generalComment,
    question.summary,
    question.memoryTip,
    question.trap,
    question.reference,
    ...(question.alternatives || []).flatMap((alternative) => [alternative.text, alternative.explanation]),
  ].join(" "));
}

function suggestForQuestion(question, targets) {
  const searchableText = questionText(question);
  const ranked = targets
    .map((target) => ({
      ...target,
      score: scoreName(searchableText, target.scoreName, target.weight),
    }))
    .filter((target) => target.score > 0)
    .sort((a, b) => b.score - a.score);

  const best = ranked[0];
  if (!best) {
    return {
      grandThemeId: "",
      domainId: "",
      detailId: "",
      confidence: 0,
      reason: "Sem correspondência clara",
    };
  }

  return {
    grandThemeId: best.grandThemeId,
    grandThemeName: best.grandThemeName,
    domainId: best.domainId,
    domainName: best.domainName,
    detailId: best.detailId,
    detailName: best.detailName,
    confidence: Math.min(100, best.score * 8),
    reason: `Correspondência com ${best.detailName || best.domainName || best.grandThemeName}`,
  };
}

export default async function handler(req, res) {
  if (req.method !== "POST") {
    return res.status(405).json({ error: "Method not allowed" });
  }

  try {
    const firebaseAdmin = getFirebaseAdmin();
    const authError = await assertAdmin(firebaseAdmin, req.headers.authorization?.replace("Bearer ", ""));
    if (authError) {
      return res.status(authError.status).json({ error: authError.error });
    }

    const { disciplineId, questions } = req.body || {};
    if (!disciplineId) {
      return res.status(400).json({ error: "Disciplina é obrigatória" });
    }

    if (!Array.isArray(questions)) {
      return res.status(400).json({ error: "Questões ausentes" });
    }

    const supabase = getSupabaseAdmin();
    const { data, error } = await supabase
      .from("v_taxonomy_tree")
      .select(`
        discipline_id,
        grand_theme_id,
        grand_theme_name,
        domain_id,
        domain_name,
        detail_id,
        detail_name
      `)
      .eq("discipline_id", disciplineId);

    if (error) {
      console.error("Supabase taxonomy error:", error);
      return res.status(500).json({ error: `Erro Supabase: ${error.message || JSON.stringify(error)}` });
    }

    const targets = uniqueTargets(data || []);
    const suggestions = questions.map((question) => suggestForQuestion(question, targets));

    return res.status(200).json({ suggestions });
  } catch (error) {
    console.error("Erro ao sugerir taxonomia:", error);
    return res.status(500).json({ error: error?.message || "Erro interno" });
  }
}
