import { supabase } from "../lib/supabase.js";
import { normalizeExamCode } from "../utils/exams.js";

export async function fetchAdminQuestions() {
  const { data, error } = await supabase
    .from("questions")
    .select(`
      id,
      statement,
      exam,
      difficulty,
      question_type,
      active,
      disciplines(name),
      topics(name),
      question_grand_themes(name),
      question_domains(name),
      question_details(name)
    `)
    .order("created_at", { ascending: false });

  if (error) throw error;

  return (data || []).map((question) => ({
    id: question.id,
    statement: question.statement || "",
    discipline: question.disciplines?.name || "Sem disciplina",
    exam: normalizeExamCode(question.exam),
    difficulty: question.difficulty || "Sem dificuldade",
    questionType: question.question_type || "single",
    legacyTopic: question.topics?.name || "Sem assunto",
    grandTheme: question.question_grand_themes?.name || "",
    domain: question.question_domains?.name || "",
    detail: question.question_details?.name || "",
    active: question.active === true,
  }));
}
