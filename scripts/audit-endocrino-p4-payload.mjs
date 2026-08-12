/* eslint-env node */
import fs from "node:fs";
const payload = JSON.parse(fs.readFileSync("scripts/endocrino-p4-payload.json", "utf8"));
const source = fs.readFileSync("scripts/endocrino-p4-source.txt", "utf8").replace(/\r/g, "");
const normalizedSource = source.replace(/\s+/g, " ").trim();
const questions = [...payload.singles.map((q) => ({ ...q, type: "single", correct: [q.correct] })), ...payload.grouped.map((q) => ({ ...q, type: "true_false" }))];
const errors = [];
const statements = new Set();
for (const [index, q] of questions.entries()) {
  const key = q.statement.normalize("NFD").replace(/[\u0300-\u036f]/g, "").toLowerCase().replace(/[^a-z0-9]+/g, " ").trim();
  if (statements.has(key)) errors.push(`Questão ${index + 1}: enunciado duplicado`);
  statements.add(key);
  const letters = new Set(q.alts.map((a) => a.l));
  if (letters.size !== q.alts.length) errors.push(`Questão ${index + 1}: letra duplicada`);
  if (q.type === "single" && (!/^[A-E]$/.test(q.correct[0]) || !letters.has(q.correct[0]))) errors.push(`Questão ${index + 1}: gabarito simples inválido`);
  if (q.type === "true_false" && (q.correct.length !== q.alts.length || !q.correct.every((v) => /^[A-E]:[VF]$/.test(v) && letters.has(v[0])))) errors.push(`Questão ${index + 1}: gabarito V/F inválido`);
  if (!q.alts.every((a) => a.t && a.e)) errors.push(`Questão ${index + 1}: alternativa sem texto/explicação`);
  for (const a of q.alts) if (!normalizedSource.includes(a.e.replace(/\s+/g, " ").trim())) errors.push(`Questão ${index + 1}${a.l}: justificativa não literal`);
}
const report = { questions: questions.length, single: payload.singles.length, trueFalse: payload.grouped.length, alternativesOrAssertions: questions.reduce((n, q) => n + q.alts.length, 0), errors };
console.log(JSON.stringify(report, null, 2));
if (errors.length) process.exit(1);
