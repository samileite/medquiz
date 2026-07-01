import dotenv from "dotenv";
dotenv.config({ path: ".env.local" });

import admin from "firebase-admin";

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

async function verifyAdmin(firebaseAdmin, token) {
  if (!token) {
    return { error: { status: 401, message: "Token ausente" } };
  }

  let decoded;
  try {
    decoded = await firebaseAdmin.auth().verifyIdToken(token);
  } catch (err) {
    console.error("Token inválido:", err?.message || err);
    return { error: { status: 401, message: "Token inválido" } };
  }

  const snap = await firebaseAdmin.firestore().doc(`users/${decoded.uid}`).get();
  const data = snap.exists ? snap.data() : {};
  const adminEmail = process.env.ADMIN_EMAIL || "samileleite77@gmail.com";
  if (data?.role !== "admin" && decoded.email !== adminEmail) {
    return { error: { status: 403, message: "Apenas administradores podem gerenciar usuários" } };
  }

  return { decoded };
}

async function writeAudit(db, decoded, entry) {
  try {
    await db.collection("user_audit").add({
      ...entry,
      adminId: decoded.uid,
      adminEmail: decoded.email || "",
      createdAt: new Date().toISOString(),
    });
  } catch (err) {
    console.warn("Erro ao gravar audit log:", err);
  }
}

export default async function handler(req, res) {
  try {
    const firebaseAdmin = getFirebaseAdmin();
    const auth = await verifyAdmin(firebaseAdmin, req.headers.authorization?.replace("Bearer ", ""));
    if (auth.error) {
      return res.status(auth.error.status).json({ error: auth.error.message });
    }

    const db = firebaseAdmin.firestore();

    if (req.method === "GET") {
      const snap = await db.collection("users").get();
      const users = snap.docs.map((doc) => ({ id: doc.id, ...doc.data() }));
      users.sort((a, b) => String(b.createdAt || "").localeCompare(String(a.createdAt || "")));
      return res.status(200).json({ users });
    }

    if (req.method !== "POST") {
      return res.status(405).json({ error: "Method not allowed" });
    }

    const { action, userId, role } = req.body || {};
    if (!userId) {
      return res.status(400).json({ error: "userId ausente" });
    }

    const userRef = db.doc(`users/${userId}`);
    const userSnap = await userRef.get();
    const userData = userSnap.exists ? userSnap.data() : {};

    if (action === "updateRole") {
      const allowedRoles = new Set(["pending", "active", "blocked", "revoked", "admin"]);
      if (!allowedRoles.has(role)) {
        return res.status(400).json({ error: "Role inválida" });
      }

      await userRef.set({ role, updatedAt: new Date().toISOString() }, { merge: true });
      await writeAudit(db, auth.decoded, {
        action: "update_role",
        targetUserId: userId,
        targetEmail: userData?.email || "",
        details: `role=${role}`,
      });
      return res.status(200).json({ success: true });
    }

    if (action === "delete") {
      await userRef.delete();
      try {
        await db.doc(`progress/${userId}`).delete();
      } catch {
        // progress may not exist
      }
      await writeAudit(db, auth.decoded, {
        action: "remove_user",
        targetUserId: userId,
        targetEmail: userData?.email || "",
        details: "removed user and progress via admin panel",
      });
      return res.status(200).json({ success: true });
    }

    return res.status(400).json({ error: "Ação inválida" });
  } catch (err) {
    console.error("Erro no gerenciamento de usuários:", err);
    return res.status(500).json({ error: err?.message || "Erro interno" });
  }
}
