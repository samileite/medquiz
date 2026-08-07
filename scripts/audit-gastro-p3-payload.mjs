/* eslint-env node */
import fs from "node:fs";
import path from "node:path";

const projectRoot = process.cwd();
const migrationFiles = [
  "supabase/migrations/20260806_import_gastroenterologia_prova_3.sql",
  "supabase/migrations/20260807_import_gastroenterologia_p3_discursivas.sql",
  "supabase/migrations/20260807_import_gastroenterologia_p3_monitoria_1.sql",
  "supabase/migrations/20260807_import_gastroenterologia_p3_monitoria_2.sql",
  "supabase/migrations/20260807_import_gastroenterologia_p3_monitoria_3.sql",
  "supabase/migrations/20260807_import_gastroenterologia_p3_complementos.sql",
].map((file) => path.join(projectRoot, file));

function normalizeText(value) {
  return String(value || "")
    .normalize("NFD")
    .replace(/[\u0300-\u036f]/g, "")
    .toLowerCase()
    .replace(/[^a-z0-9]+/g, " ")
    .trim();
}

function readPayloads(file) {
  const sql = fs.readFileSync(file, "utf8");
  return [...sql.matchAll(/\$data\$([\s\S]*?)\$data\$/g)]
    .flatMap((match) => JSON.parse(match[1]));
}

const questions = migrationFiles.flatMap(readPayloads);
const errors = [];
const keyOwners = new Map();
const statementOwners = new Map();

for (const question of questions) {
  const key = question.k;
  const statement = question.s;
  const type = question.type || "single";
  const correct = Array.isArray(question.c) ? question.c : [question.c];
  const alternatives = question.alts || [];
  const letters = new Set(alternatives.map((alternative) => alternative[0]));

  if (!key) errors.push("Questão sem chave estável");
  if (!statement) errors.push(`${key}: enunciado vazio`);
  if (keyOwners.has(key)) errors.push(`${key}: chave duplicada`);
  keyOwners.set(key, true);

  const normalizedStatement = normalizeText(statement);
  if (statementOwners.has(normalizedStatement)) {
    errors.push(`${key}: enunciado duplicado de ${statementOwners.get(normalizedStatement)}`);
  }
  statementOwners.set(normalizedStatement, key);

  for (const field of ["g", "sum", "mem", "trap"]) {
    if (!String(question[field] || "").trim()) errors.push(`${key}: campo ${field} vazio`);
  }
  if (alternatives.length < 2) errors.push(`${key}: menos de duas alternativas/assertivas`);
  alternatives.forEach((alternative) => {
    if (!alternative[0] || !alternative[1] || !alternative[2]) {
      errors.push(`${key}: alternativa incompleta`);
    }
  });

  if (type === "true_false") {
    if (correct.length !== alternatives.length) errors.push(`${key}: V/F sem um gabarito por assertiva`);
    correct.forEach((answer) => {
      const match = String(answer).match(/^([A-E]):([VF])$/);
      if (!match || !letters.has(match?.[1])) errors.push(`${key}: gabarito V/F inválido (${answer})`);
    });
  } else {
    if (type === "single" && correct.length !== 1) errors.push(`${key}: single sem gabarito único`);
    correct.forEach((answer) => {
      if (!letters.has(answer)) errors.push(`${key}: gabarito ausente nas alternativas (${answer})`);
    });
  }
}

const byType = Object.groupBy(questions, (question) => question.type || "single");
const summary = {
  questions: questions.length,
  single: byType.single?.length || 0,
  multiple: byType.multiple?.length || 0,
  trueFalse: byType.true_false?.length || 0,
  alternativesOrAssertions: questions.reduce((total, question) => total + (question.alts?.length || 0), 0),
  errors: errors.length,
};

console.log(JSON.stringify(summary, null, 2));
if (errors.length > 0) {
  errors.forEach((error) => console.error(`- ${error}`));
  process.exitCode = 1;
}
