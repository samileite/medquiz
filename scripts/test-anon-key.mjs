import dotenv from "dotenv";
import WebSocket from "ws";
import { createClient } from "@supabase/supabase-js";

dotenv.config({ path: ".env.local" });

console.log("\n" + "=".repeat(80));
console.log("DIAGNÓSTICO: ACESSO COM ANON_KEY (Frontend)");
console.log("=".repeat(80) + "\n");

const supabaseUrl = process.env.VITE_SUPABASE_URL;
const supabaseKey = process.env.VITE_SUPABASE_ANON_KEY;

const supabase = createClient(supabaseUrl, supabaseKey, {
  realtime: { transport: WebSocket }
});

console.log(`URL: ${supabaseUrl}\n`);

// Teste 1: Disciplines
console.log("1️⃣  Testando acesso a: disciplines");
const { data: disciplines, error: discError } = await supabase
  .from("disciplines")
  .select("*");
console.log(`   Resultado: ${disciplines ? "✅ " + disciplines.length : "❌"}`);
if (discError) console.log(`   Erro: ${discError.message}`);

// Teste 2: Topics
console.log("\n2️⃣  Testando acesso a: topics");
const { data: topics, error: topError } = await supabase
  .from("topics")
  .select("*");
console.log(`   Resultado: ${topics ? "✅ " + topics.length : "❌"}`);
if (topError) console.log(`   Erro: ${topError.message}`);

// Teste 3: Questions
console.log("\n3️⃣  Testando acesso a: questions");
const { data: questions, error: qError } = await supabase
  .from("questions")
  .select("*");
console.log(`   Resultado: ${questions ? "✅ " + questions.length : "❌"}`);
if (qError) console.log(`   Erro: ${qError.message}`);

// Teste 4: Alternatives
console.log("\n4️⃣  Testando acesso a: alternatives");
const { data: alternatives, error: altError } = await supabase
  .from("alternatives")
  .select("*");
console.log(`   Resultado: ${alternatives ? "✅ " + alternatives.length : "❌"}`);
if (altError) console.log(`   Erro: ${altError.message}`);

// Teste 5: Query com join (como o frontend faz)
console.log("\n5️⃣  Testando query com JOIN (como o frontend faz)");
const { data: joined, error: joinError } = await supabase
  .from("questions")
  .select(
    `
    id,
    difficulty,
    statement,
    correct_answer,
    active,
    topics(name),
    alternatives(letter, text)
  `
  )
  .eq("active", true)
  .limit(3);
console.log(`   Resultado: ${joined ? "✅ " + joined.length : "❌"}`);
if (joinError) console.log(`   Erro: ${joinError.message}`);

// Teste 6: Query exata do frontend
console.log(
  "\n6️⃣  Testando query EXATA do frontend fetchQuestionsByDisciplina"
);
const { data: discipline, error: discQueryError } = await supabase
  .from("disciplines")
  .select("id, name")
  .eq("name", "Endocrinologia")
  .single();

if (discQueryError) {
  console.log(`   ❌ Erro ao buscar disciplina: ${discQueryError.message}`);
} else {
  console.log(`   ✅ Disciplina encontrada: ${discipline.name}`);

  const { data: questionsData, error: questionsError } = await supabase
    .from("questions")
    .select(
      `
      id,
      difficulty,
      statement,
      correct_answer,
      general_comment,
      summary,
      memory_tip,
      trap,
      reference,
      topics(name),
      alternatives(letter, text, explanation)
    `
    )
    .eq("discipline_id", discipline.id)
    .eq("active", true)
    .order("created_at", { ascending: true });

  if (questionsError) {
    console.log(
      `   ❌ Erro ao buscar questões: ${questionsError.message}`
    );
  } else {
    console.log(`   ✅ Questões retornadas: ${questionsData?.length || 0}`);
  }
}

console.log("\n" + "=".repeat(80) + "\n");
