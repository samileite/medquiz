import { supabase } from "./lib/supabase.js";
import { normalizeExamCode } from "./utils/exams.js";

export async function fetchQuestionsByDisciplina(disciplina) {
  try {
    const { data: discipline, error: disciplineError } = await supabase
      .from("disciplines")
      .select("id, name")
      .eq("name", disciplina)
      .single();

    if (disciplineError) throw disciplineError;

    const { data, error } = await supabase
      .from("questions")
      .select(`
        id,
        exam,
        grand_theme_id,
        domain_id,
        detail_id,
        difficulty,
        statement,
        question_type,
        correct_answer,
        correct_answers,
        general_comment,
        summary,
        memory_tip,
        trap,
        reference,
        image_url,
        topics(name),
        alternatives(letter, text, explanation)
      `)
      .eq("discipline_id", discipline.id)
      .eq("active", true)
      .order("created_at", { ascending: true });

    if (error) throw error;

    console.log("Questões Supabase:", data);

    return (data || []).map((q) => {
      const alternativas = (q.alternatives || [])
        .sort((a, b) => a.letter.localeCompare(b.letter))
        .map((a) => ({
          id: a.letter,
          texto: a.text,
        }));

      const porAlternativa = {};

      (q.alternatives || []).forEach((a) => {
        porAlternativa[a.letter] = a.explanation || "";
      });

      const imageUrl = q.image_url || (q.reference?.startsWith("image:")
        ? q.reference.replace(/^image:/, "")
        : "");

      return {
        id: q.id,
        exam: normalizeExamCode(q.exam),
        grandThemeId: q.grand_theme_id || null,
        domainId: q.domain_id || null,
        detailId: q.detail_id || null,
        topic: q.topics?.name || disciplina,
        subtopic: q.topics?.name || disciplina,
        difficulty: q.difficulty || "médio",
        questionType: q.question_type || "single",
        corretas: (q.correct_answers && q.correct_answers.length > 0)
          ? q.correct_answers
          : q.correct_answer ? [q.correct_answer] : [],
        banca: "",
        enunciado: q.statement,
        imageUrl,
        alternativas,
        correta: q.correct_answer,
        explicacao: {
          geral: q.general_comment || "",
          porAlternativa,
          raciocinioCli: q.summary || "",
          dicaMemorizacao: q.memory_tip || "",
          pegadinha: q.trap || "",
          diretriz: imageUrl ? "" : q.reference || "",
        },
      };
    });
  } catch (err) {
    console.error("Erro ao carregar questões do Supabase:", err);
    return [];
  }
}

export async function fetchQuestions() {
  return fetchQuestionsByDisciplina("Endocrinologia");
}

export async function fetchTaxonomyTreeByDisciplina(disciplina) {
  try {
    const { data, error } = await supabase
      .from("v_taxonomy_tree")
      .select(`
        discipline_id,
        discipline_name,
        grand_theme_id,
        grand_theme_name,
        grand_theme_order,
        domain_id,
        domain_name,
        domain_order,
        detail_id,
        detail_name,
        detail_order
      `)
      .eq("discipline_name", disciplina)
      .order("grand_theme_order", { ascending: true })
      .order("domain_order", { ascending: true })
      .order("detail_order", { ascending: true });

    if (error) throw error;
    return data || [];
  } catch (err) {
    console.error("Erro ao carregar árvore de taxonomia:", err);
    return [];
  }
}

export async function fetchDisciplineAvailability(names = []) {
  try {
    const { data: disciplines, error: disciplineError } = await supabase
      .from("disciplines")
      .select("id, name")
      .in("name", names);

    if (disciplineError) throw disciplineError;

    const disciplineIds = disciplines.map((d) => d.id);
    if (disciplineIds.length === 0) return {};

    const { data: questions, error: questionsError } = await supabase
      .from("questions")
      .select("discipline_id, exam")
      .in("discipline_id", disciplineIds)
      .eq("active", true);

    if (questionsError) throw questionsError;

    return disciplines.reduce((acc, d) => {
      acc[d.name] = questions.some((q) => q.discipline_id === d.id);
      return acc;
    }, {});
  } catch (err) {
    console.error("Erro ao carregar disponibilidade de disciplinas:", err);
    return {};
  }
}
