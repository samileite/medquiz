import { supabase } from "./lib/supabase.js";

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

      return {
        id: q.id,
        topic: q.topics?.name || disciplina,
        subtopic: q.topics?.name || disciplina,
        difficulty: q.difficulty || "médio",
        banca: "",
        enunciado: q.statement,
        alternativas,
        correta: q.correct_answer,
        explicacao: {
          geral: q.general_comment || "",
          porAlternativa,
          raciocinioCli: q.summary || "",
          dicaMemorizacao: q.memory_tip || "",
          pegadinha: q.trap || "",
          diretriz: q.reference || "",
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