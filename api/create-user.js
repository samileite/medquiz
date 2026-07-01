import dotenv from "dotenv";
dotenv.config({ path: ".env.local" });

import admin from "firebase-admin";

if (!admin.apps.length) {
  admin.initializeApp({
    credential: admin.credential.cert({
      projectId: process.env.FIREBASE_PROJECT_ID,
      clientEmail: process.env.FIREBASE_CLIENT_EMAIL,
      privateKey: process.env.FIREBASE_PRIVATE_KEY?.replace(/\\n/g, "\n"),
    }),
  });
}

export default async function handler(req, res) {
  if (req.method !== "POST") return res.status(405).json({ error: "Method not allowed" });

  const token = req.headers.authorization?.replace("Bearer ", "");
  if (!token) return res.status(401).json({ error: "Token ausente" });

  let decoded;
  try {
    decoded = await admin.auth().verifyIdToken(token);
  } catch (err) {
    console.error("Token inválido:", err?.message || err);
    return res.status(401).json({ error: "Token inválido" });
  }

  const { name, email, photo, periodo } = req.body || {};
  if (!decoded || !decoded.uid) return res.status(401).json({ error: "Usuário inválido" });

  try {
    const ref = admin.firestore().doc(`users/${decoded.uid}`);
    const snap = await ref.get();
    const current = snap.exists ? snap.data() : {};
    const now = new Date().toISOString();
    const adminEmail = process.env.ADMIN_EMAIL || "samileleite77@gmail.com";
    const isAdmin = decoded.email === adminEmail;
    const nextRole = isAdmin ? "admin" : current?.role || "pending";
    const payload = {
      name: name || decoded.name || current?.name || "",
      email: email || decoded.email || current?.email || "",
      photo: photo || decoded.picture || current?.photo || "",
      role: nextRole,
      updatedAt: now,
      ...(!snap.exists ? { createdAt: now } : {}),
      ...(periodo ? { periodo } : {}),
    };

    await ref.set(payload, { merge: true });
    const updated = await ref.get();
    return res.status(200).json({ success: true, user: updated.data() });
  } catch (err) {
    console.error("Erro ao criar/atualizar usuário via admin:", err);
    return res.status(500).json({ error: "Erro ao criar usuário" });
  }
}
