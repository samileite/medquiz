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
        question_type,
        correct_answer,
        correct_answers,
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

      const imageUrl = q.reference?.startsWith("image:")
        ? q.reference.replace(/^image:/, "")
        : "";

      return {
        id: q.id,
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
      .select("discipline_id")
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
