import { supabase } from "../lib/supabase.js";
import { normalizeExamCode } from "../utils/exams.js";

export async function fetchAdminQuestions() {
  const { data, error } = await supabase
    .from("questions")
    .select(`
      id,
      statement,
      exam,
      topic_id,
      grand_theme_id,
      domain_id,
      detail_id,
      difficulty,
      question_type,
      active,
      disciplines(id, name),
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
    disciplineId: question.disciplines?.id || "",
    discipline: question.disciplines?.name || "Sem disciplina",
    exam: normalizeExamCode(question.exam),
    topicId: question.topic_id || "",
    grandThemeId: question.grand_theme_id || "",
    domainId: question.domain_id || "",
    detailId: question.detail_id || "",
    difficulty: question.difficulty || "Sem dificuldade",
    questionType: question.question_type || "single",
    legacyTopic: question.topics?.name || "Sem assunto",
    grandTheme: question.question_grand_themes?.name || "",
    domain: question.question_domains?.name || "",
    detail: question.question_details?.name || "",
    active: question.active === true,
  }));
}

export async function fetchAdminQuestionOptions() {
  const [
    disciplinesResult,
    topicsResult,
    taxonomyResult,
  ] = await Promise.all([
    supabase
      .from("disciplines")
      .select("id, name")
      .order("name", { ascending: true }),
    supabase
      .from("topics")
      .select("id, name, discipline_id")
      .order("name", { ascending: true }),
    supabase
      .from("v_taxonomy_tree")
      .select(`
        discipline_id,
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
      .order("grand_theme_order", { ascending: true })
      .order("domain_order", { ascending: true })
      .order("detail_order", { ascending: true }),
  ]);

  if (disciplinesResult.error) throw disciplinesResult.error;
  if (topicsResult.error) throw topicsResult.error;
  if (taxonomyResult.error) throw taxonomyResult.error;

  return {
    disciplines: disciplinesResult.data || [],
    topics: topicsResult.data || [],
    taxonomy: taxonomyResult.data || [],
  };
}

export async function updateAdminQuestionClassification(questionId, values) {
  const payload = {
    exam: normalizeExamCode(values.exam),
    topic_id: values.topicId || null,
    grand_theme_id: values.grandThemeId || null,
    domain_id: values.domainId || null,
    detail_id: values.detailId || null,
    difficulty: values.difficulty,
    active: values.active,
  };

  const { error } = await supabase
    .from("questions")
    .update(payload)
    .eq("id", questionId);

  if (error) throw error;
}
