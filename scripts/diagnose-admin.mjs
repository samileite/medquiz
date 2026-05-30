import dotenv from "dotenv";
import WebSocket from "ws";
import { createClient } from "@supabase/supabase-js";

// Carrega variáveis de ambiente
dotenv.config({ path: ".env.import" });

console.log("\n" + "=".repeat(80));
console.log("DIAGNÓSTICO COM SERVICE_ROLE_KEY");
console.log("=".repeat(80) + "\n");

const supabaseUrl = process.env.SUPABASE_URL;
const serviceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

if (!supabaseUrl || !serviceRoleKey) {
  console.error("❌ Credenciais não encontradas em .env.import");
  process.exit(1);
}

const supabase = createClient(supabaseUrl, serviceRoleKey, {
  realtime: { transport: WebSocket }
});

console.log(`✅ Conectado com SERVICE_ROLE_KEY\n`);

// Verificar estrutura
const { data: disciplines } = await supabase
  .from("disciplines")
  .select("*");
console.log(`📦 Disciplinas: ${disciplines?.length || 0}`);
if (disciplines && disciplines.length > 0) {
  disciplines.forEach((d) => {
    console.log(`   - ${d.name} (ID: ${d.id})`);
  });
}

const { data: topics } = await supabase
  .from("topics")
  .select("*");
console.log(`\n📦 Topics: ${topics?.length || 0}`);
if (topics && topics.length > 0) {
  console.log(`   Primeiros 5:`);
  topics.slice(0, 5).forEach((t) => {
    console.log(`   - ${t.name} (ID: ${t.id}, Discipline: ${t.discipline_id})`);
  });
}

const { data: questions } = await supabase
  .from("questions")
  .select("*");
console.log(`\n📦 Questões: ${questions?.length || 0}`);
if (questions && questions.length > 0) {
  console.log(`   Primeiras 3:`);
  questions.slice(0, 3).forEach((q) => {
    console.log(
      `   - ID: ${q.id}, Discipline: ${q.discipline_id}, Active: ${q.active}, Diff: ${q.difficulty}`
    );
  });
}

const { data: alternatives } = await supabase
  .from("alternatives")
  .select("*");
console.log(`\n📦 Alternativas: ${alternatives?.length || 0}`);

// Buscar Endocrinologia especificamente
console.log("\n" + "=".repeat(80));
console.log("DETALHES: ENDOCRINOLOGIA");
console.log("=".repeat(80) + "\n");

const { data: endoDisc, error: endoDiscError } = await supabase
  .from("disciplines")
  .select("*")
  .eq("name", "Endocrinologia")
  .single();

if (endoDiscError || !endoDisc) {
  console.error("❌ Disciplina 'Endocrinologia' não encontrada");
  console.log(`   Erro: ${endoDiscError?.message || "Nenhuma correspondência"}`);
} else {
  console.log(`✅ Encontrada:`);
  console.log(`   ID: ${endoDisc.id}`);
  console.log(`   Nome: ${endoDisc.name}`);

  // Buscar questões
  const { data: endoQs, error: endoQsError } = await supabase
    .from("questions")
    .select(
      `
      id,
      active,
      difficulty,
      discipline_id,
      topic_id,
      statement,
      correct_answer,
      topics(name),
      alternatives(letter, text)
    `
    )
    .eq("discipline_id", endoDisc.id);

  if (endoQsError) {
    console.error(`\n❌ Erro ao buscar questões:`, endoQsError.message);
  } else {
    console.log(`\n✅ Questões de Endocrinologia: ${endoQs?.length || 0}`);

    if (endoQs && endoQs.length > 0) {
      console.log("\n   Primeiras 3 questões:");
      endoQs.slice(0, 3).forEach((q, i) => {
        console.log(`\n   ${i + 1}. ID: ${q.id}`);
        console.log(`      Active: ${q.active}`);
        console.log(`      Difficulty: ${q.difficulty}`);
        console.log(`      Topic: ${q.topics?.name || "(sem topic)"}`);
        console.log(`      Correct Answer: ${q.correct_answer}`);
        console.log(`      Alternatives: ${q.alternatives?.length || 0}`);
        console.log(
          `      Enunciado: ${q.statement?.substring(0, 80)}...`
        );
      });

      // Filtrar por active
      const active = endoQs.filter((q) => q.active).length;
      const inactive = endoQs.filter((q) => !q.active).length;
      console.log(`\n   Status: ${active} ativas, ${inactive} inativas`);
    } else {
      console.log("   Nenhuma questão encontrada!");

      // Verificar se há questões sem filtro
      const { data: allQs } = await supabase
        .from("questions")
        .select("id, discipline_id, active")
        .limit(5);

      if (allQs && allQs.length > 0) {
        console.log("\n   Questões no banco (amostra):");
        allQs.forEach((q) => {
          console.log(
            `   - ID: ${q.id}, Discipline: ${q.discipline_id}, Active: ${q.active}`
          );
        });
      }
    }
  }
}

console.log("\n" + "=".repeat(80) + "\n");
