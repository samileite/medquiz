import dotenv from "dotenv";
import WebSocket from "ws";
import { createClient } from "@supabase/supabase-js";

// Carrega variáveis de ambiente
dotenv.config({ path: ".env.local" });
dotenv.config({ path: ".env" });

console.log("\n" + "=".repeat(80));
console.log("DIAGNÓSTICO COMPLETO - MIGRAÇÃO GOOGLE SHEETS → SUPABASE");
console.log("=".repeat(80) + "\n");

// ============================================================================
// PASSO 1: VERIFICAR VARIÁVEIS DE AMBIENTE
// ============================================================================
console.log("📋 PASSO 1: VERIFICAR VARIÁVEIS DE AMBIENTE\n");

const supabaseUrl = process.env.VITE_SUPABASE_URL || process.env.SUPABASE_URL;
const supabaseKey =
  process.env.VITE_SUPABASE_ANON_KEY || process.env.SUPABASE_ANON_KEY;
const serviceRoleKey = process.env.SUPABASE_SERVICE_ROLE_KEY;

console.log(`✓ VITE_SUPABASE_URL: ${supabaseUrl ? "✅ Carregada" : "❌ NÃO ENCONTRADA"}`);
console.log(`✓ VITE_SUPABASE_ANON_KEY: ${supabaseKey ? "✅ Carregada" : "❌ NÃO ENCONTRADA"}`);
console.log(`✓ SUPABASE_SERVICE_ROLE_KEY: ${serviceRoleKey ? "✅ Carregada" : "❌ NÃO ENCONTRADA"}`);

if (!supabaseUrl || !supabaseKey) {
  console.error("\n❌ ERRO: Variáveis de ambiente não encontradas!");
  console.error("Verifique .env.local ou .env");
  process.exit(1);
}

const supabase = createClient(supabaseUrl, supabaseKey, {
  realtime: { transport: WebSocket }
});

// ============================================================================
// PASSO 2: TESTAR CONEXÃO COM SUPABASE
// ============================================================================
console.log("\n📡 PASSO 2: TESTAR CONEXÃO COM SUPABASE\n");

try {
  const { data, error } = await supabase
    .from("disciplines")
    .select("count")
    .single();
  console.log("✅ Conexão com Supabase: OK\n");
} catch (err) {
  console.error("❌ Erro de conexão:", err.message);
  process.exit(1);
}

// ============================================================================
// PASSO 3: VERIFICAR ESTRUTURA DO BANCO
// ============================================================================
console.log("🏗️  PASSO 3: VERIFICAR ESTRUTURA DO BANCO\n");

// Disciplinas
const { data: disciplines, error: discError } = await supabase
  .from("disciplines")
  .select("*");
console.log(`Disciplinas encontradas: ${disciplines?.length || 0}`);
if (disciplines && disciplines.length > 0) {
  console.log("  Nomes:", disciplines.map((d) => d.name).join(", "));
}

// Topics
const { data: topics, error: topicError } = await supabase
  .from("topics")
  .select("*");
console.log(`Topics encontrados: ${topics?.length || 0}`);
if (topics && topics.length > 0) {
  console.log("  Primeiros 3:", topics.slice(0, 3).map((t) => `${t.name} (id: ${t.id})`).join(", "));
}

// Questions
const { data: questions, error: qError } = await supabase
  .from("questions")
  .select("count");
console.log(`Total de questões no banco: ${questions?.[0]?.count || 0}`);

// Alternatives
const { data: alternatives, error: altError } = await supabase
  .from("alternatives")
  .select("count");
console.log(`Total de alternativas no banco: ${alternatives?.[0]?.count || 0}\n`);

// ============================================================================
// PASSO 4: BUSCAR DISCIPLINA "ENDOCRINOLOGIA"
// ============================================================================
console.log("🔍 PASSO 4: BUSCAR DISCIPLINA 'ENDOCRINOLOGIA'\n");

const { data: endoDisc, error: endoDiscError } = await supabase
  .from("disciplines")
  .select("id, name")
  .eq("name", "Endocrinologia")
  .single();

if (endoDiscError) {
  console.error("❌ Erro ao buscar disciplina:", endoDiscError.message);
  console.log("  (Verifique a ortografia: maiúsculas, acentos, espaços)");
} else if (!endoDisc) {
  console.error("❌ Disciplina 'Endocrinologia' NÃO ENCONTRADA");
  console.log("  Disciplinas disponíveis:", disciplines.map((d) => d.name).join(", "));
} else {
  console.log(`✅ Disciplina encontrada:`);
  console.log(`   ID: ${endoDisc.id}`);
  console.log(`   Nome: ${endoDisc.name}\n`);

  // =========================================================================
  // PASSO 5: BUSCAR QUESTÕES DE ENDOCRINOLOGIA
  // =========================================================================
  console.log("📚 PASSO 5: BUSCAR QUESTÕES DE ENDOCRINOLOGIA\n");

  const { data: endoQuestions, error: endoQError } = await supabase
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
      active,
      created_at,
      topics(name),
      alternatives(letter, text, explanation)
    `
    )
    .eq("discipline_id", endoDisc.id);

  if (endoQError) {
    console.error("❌ Erro ao buscar questões:", endoQError.message);
  } else {
    console.log(`✅ Questões encontradas: ${endoQuestions?.length || 0}`);

    if (endoQuestions && endoQuestions.length > 0) {
      // =====================================================================
      // PASSO 6: VERIFICAR DADOS DA PRIMEIRA QUESTÃO
      // =====================================================================
      console.log("\n🔎 PASSO 6: VERIFICAR DADOS DA PRIMEIRA QUESTÃO\n");

      const q = endoQuestions[0];
      console.log(`Questão ID: ${q.id}`);
      console.log(`Ativo: ${q.active ? "✅ SIM" : "❌ NÃO"}`);
      console.log(`Dificuldade: ${q.difficulty}`);
      console.log(`Tema: ${q.topics?.name || "(vazio)"}`);
      console.log(`Topic ID vinculado: ${q.topic_id || "não encontrado"}`);
      console.log(`Enunciado (primeiros 100 chars): ${q.statement?.substring(0, 100)}...`);
      console.log(`Resposta correta: ${q.correct_answer}`);
      console.log(`Alternativas: ${q.alternatives?.length || 0}`);

      if (q.alternatives && q.alternatives.length > 0) {
        console.log("  Detalhes das alternativas:");
        q.alternatives.forEach((a) => {
          console.log(`    ${a.letter}: ${a.text?.substring(0, 50)}...`);
        });
      }

      // =====================================================================
      // PASSO 7: TESTAR FILTROS
      // =====================================================================
      console.log("\n🔧 PASSO 7: TESTAR FILTROS\n");

      // Filtro: active = true
      const { data: activeQuestions } = await supabase
        .from("questions")
        .select("id, active")
        .eq("discipline_id", endoDisc.id)
        .eq("active", true);
      console.log(`✓ Questões com active=true: ${activeQuestions?.length || 0}`);

      // Filtro: active = false
      const { data: inactiveQuestions } = await supabase
        .from("questions")
        .select("id, active")
        .eq("discipline_id", endoDisc.id)
        .eq("active", false);
      console.log(`✓ Questões com active=false: ${inactiveQuestions?.length || 0}`);

      // Verificar distribuição de dificuldades
      const difficulties = {};
      endoQuestions.forEach((q) => {
        difficulties[q.difficulty] =
          (difficulties[q.difficulty] || 0) + 1;
      });
      console.log(`✓ Distribuição por dificuldade:`, difficulties);

      // =====================================================================
      // PASSO 8: TESTAR QUERY EXATA DO FRONTEND
      // =====================================================================
      console.log("\n🎯 PASSO 8: TESTAR QUERY EXATA DO FRONTEND\n");

      const { data: frontendQueryResult, error: frontendQueryError } =
        await supabase
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
          .eq("discipline_id", endoDisc.id)
          .eq("active", true)
          .order("created_at", { ascending: true });

      if (frontendQueryError) {
        console.error("❌ Erro na query:", frontendQueryError.message);
      } else {
        console.log(
          `✅ Questões retornadas pela query: ${frontendQueryResult?.length || 0}`
        );

        if (frontendQueryResult && frontendQueryResult.length > 0) {
          console.log("\n✅ PRIMEIRA QUESTÃO (formato esperado pelo frontend):\n");

          const q = frontendQueryResult[0];
          const mappedQuestion = {
            id: q.id,
            topic: q.topics?.name || "Endocrinologia",
            subtopic: q.topics?.name || "Endocrinologia",
            difficulty: q.difficulty || "médio",
            banca: "",
            enunciado: q.statement,
            alternativas: (q.alternatives || [])
              .sort((a, b) => a.letter.localeCompare(b.letter))
              .map((a) => ({ id: a.letter, texto: a.text })),
            correta: q.correct_answer,
            explicacao: {
              geral: q.general_comment || "",
              porAlternativa: (q.alternatives || []).reduce((acc, a) => {
                acc[a.letter] = a.explanation || "";
                return acc;
              }, {}),
              raciocinioCli: q.summary || "",
              dicaMemorizacao: q.memory_tip || "",
              pegadinha: q.trap || "",
              diretriz: q.reference || "",
            },
          };

          console.log("Questão mapeada:");
          console.log(JSON.stringify(mappedQuestion, null, 2));
        }
      }
    } else {
      console.log("❌ NENHUMA QUESTÃO ENCONTRADA");
      console.log("\n🔍 PROCURANDO POR QUESTÕES SEM FILTRO:\n");

      const { data: allQuestions } = await supabase
        .from("questions")
        .select("id, discipline_id, active, difficulty")
        .limit(10);

      if (allQuestions && allQuestions.length > 0) {
        console.log("Primeiras 10 questões no banco:");
        allQuestions.forEach((q) => {
          console.log(
            `  - ID: ${q.id}, Discipline: ${q.discipline_id}, Active: ${q.active}, Diff: ${q.difficulty}`
          );
        });
      }
    }
  }
}

// ============================================================================
// PASSO 9: VERIFICAR RELACIONAMENTOS
// ============================================================================
console.log("\n🔗 PASSO 9: VERIFICAR RELACIONAMENTOS\n");

if (endoDisc && endoQuestions && endoQuestions.length > 0) {
  const q = endoQuestions[0];

  // Verificar topic_id
  if (q.topic_id) {
    const { data: topicData } = await supabase
      .from("topics")
      .select("*")
      .eq("id", q.topic_id)
      .single();

    if (topicData) {
      console.log(`✅ Topic encontrado:`);
      console.log(`   ID: ${topicData.id}`);
      console.log(`   Nome: ${topicData.name}`);
      console.log(`   Discipline ID: ${topicData.discipline_id}`);
    } else {
      console.log(`❌ Topic com ID ${q.topic_id} NÃO ENCONTRADO`);
    }
  } else {
    console.log("❌ Questão sem topic_id vinculado");
  }

  // Verificar alternatives
  if (q.alternatives && q.alternatives.length > 0) {
    console.log(`\n✅ Alternativas encontradas: ${q.alternatives.length}`);
  } else {
    console.log(`\n❌ Questão SEM ALTERNATIVAS`);
  }
}

// ============================================================================
// RESUMO FINAL
// ============================================================================
console.log("\n" + "=".repeat(80));
console.log("RESUMO FINAL");
console.log("=".repeat(80) + "\n");

if (endoDisc && endoQuestions && endoQuestions.length > 0) {
  console.log("✅ DIAGNÓSTICO: Sistema funcionando corretamente!");
  console.log(
    `   - Disciplina 'Endocrinologia' encontrada (ID: ${endoDisc.id})`
  );
  console.log(`   - ${endoQuestions.length} questões carregadas`);
  console.log("   - Dados estruturados corretamente");
} else if (endoDisc) {
  console.log("⚠️  DIAGNÓSTICO: Problema identificado!");
  console.log("   - Disciplina 'Endocrinologia' existe");
  console.log("   - MAS nenhuma questão foi encontrada");
  console.log("\nCausas possíveis:");
  console.log("   1. Questões não foram importadas");
  console.log("   2. Todas as questões estão com active=false");
  console.log("   3. As questões têm discipline_id diferente");
} else {
  console.log("❌ DIAGNÓSTICO: Erro crítico!");
  console.log("   - Disciplina 'Endocrinologia' NÃO EXISTE");
  console.log("   - Verificar se a importação foi executada com sucesso");
}

console.log("\n" + "=".repeat(80) + "\n");
