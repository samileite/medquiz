import dotenv from "dotenv";
dotenv.config({ path: ".env.local" });

import admin from "firebase-admin";
import { inflateRawSync } from "node:zlib";
import pdfParse from "pdf-parse";

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
    return { status: 403, error: "Apenas administradores podem importar questões" };
  }

  return null;
}

function readUInt16(buffer, offset) {
  return buffer.readUInt16LE(offset);
}

function readUInt32(buffer, offset) {
  return buffer.readUInt32LE(offset);
}

function findZipEntry(buffer, targetName) {
  for (let offset = buffer.length - 22; offset >= 0; offset--) {
    if (readUInt32(buffer, offset) !== 0x06054b50) continue;

    const centralDirectorySize = readUInt32(buffer, offset + 12);
    const centralDirectoryOffset = readUInt32(buffer, offset + 16);
    const end = centralDirectoryOffset + centralDirectorySize;
    let cursor = centralDirectoryOffset;

    while (cursor < end && readUInt32(buffer, cursor) === 0x02014b50) {
      const compression = readUInt16(buffer, cursor + 10);
      const compressedSize = readUInt32(buffer, cursor + 20);
      const fileNameLength = readUInt16(buffer, cursor + 28);
      const extraLength = readUInt16(buffer, cursor + 30);
      const commentLength = readUInt16(buffer, cursor + 32);
      const localHeaderOffset = readUInt32(buffer, cursor + 42);
      const fileName = buffer.toString("utf8", cursor + 46, cursor + 46 + fileNameLength);

      if (fileName === targetName) {
        const localNameLength = readUInt16(buffer, localHeaderOffset + 26);
        const localExtraLength = readUInt16(buffer, localHeaderOffset + 28);
        const dataStart = localHeaderOffset + 30 + localNameLength + localExtraLength;
        const compressedData = buffer.subarray(dataStart, dataStart + compressedSize);
        return compression === 0 ? compressedData : inflateRawSync(compressedData);
      }

      cursor += 46 + fileNameLength + extraLength + commentLength;
    }
  }

  return null;
}

function decodeXmlText(xml) {
  return xml
    .replace(/<w:tab\/>/g, "\t")
    .replace(/<\/w:p>/g, "\n")
    .replace(/<[^>]+>/g, "")
    .replace(/&lt;/g, "<")
    .replace(/&gt;/g, ">")
    .replace(/&amp;/g, "&")
    .replace(/&quot;/g, "\"")
    .replace(/&apos;/g, "'")
    .replace(/\n{3,}/g, "\n\n")
    .trim();
}

async function extractText({ fileName, mimeType, buffer }) {
  const name = String(fileName || "").toLowerCase();
  const type = String(mimeType || "").toLowerCase();

  if (type.includes("text") || name.endsWith(".txt")) {
    return buffer.toString("utf8");
  }

  if (type.includes("pdf") || name.endsWith(".pdf")) {
    const parsed = await pdfParse(buffer);
    return parsed.text || "";
  }

  if (
    type.includes("wordprocessingml") ||
    name.endsWith(".docx")
  ) {
    const documentXml = findZipEntry(buffer, "word/document.xml");
    if (!documentXml) {
      throw new Error("Não foi possível localizar o conteúdo do DOCX");
    }
    return decodeXmlText(documentXml.toString("utf8"));
  }

  if (name.endsWith(".doc")) {
    throw new Error("Arquivos .doc antigos não são suportados. Salve como .docx ou .txt.");
  }

  throw new Error("Formato não suportado. Use TXT, PDF ou DOCX.");
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

    const { fileName, mimeType, base64 } = req.body || {};
    if (!base64) {
      return res.status(400).json({ error: "Arquivo ausente" });
    }

    const buffer = Buffer.from(base64, "base64");
    const text = await extractText({ fileName, mimeType, buffer });
    return res.status(200).json({ text });
  } catch (error) {
    console.error("Erro ao extrair arquivo:", error);
    return res.status(500).json({ error: error?.message || "Erro interno" });
  }
}
