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
      correct_answer,
      correct_answers,
      general_comment,
      summary,
      memory_tip,
      trap,
      reference,
      active,
      disciplines(id, name),
      topics(name),
      question_grand_themes(name),
      question_domains(name),
      question_details(name),
      alternatives(letter, text, explanation)
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
    correctAnswer: question.correct_answer || "",
    correctAnswers: Array.isArray(question.correct_answers) ? question.correct_answers : [],
    generalComment: question.general_comment || "",
    summary: question.summary || "",
    memoryTip: question.memory_tip || "",
    trap: question.trap || "",
    reference: question.reference || "",
    alternatives: (question.alternatives || [])
      .sort((a, b) => String(a.letter).localeCompare(String(b.letter)))
      .map((alternative) => ({
        letter: alternative.letter || "",
        text: alternative.text || "",
        explanation: alternative.explanation || "",
      })),
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

export async function updateAdminQuestion(questionId, values, user) {
  const payload = {
    questionId,
    exam: normalizeExamCode(values.exam),
    topicId: values.topicId || null,
    grandThemeId: values.grandThemeId || null,
    domainId: values.domainId || null,
    detailId: values.detailId || null,
    difficulty: values.difficulty,
    active: values.active,
    statement: values.statement,
    correctAnswers: values.correctAnswers,
    generalComment: values.generalComment,
    summary: values.summary,
    memoryTip: values.memoryTip,
    trap: values.trap,
    reference: values.reference,
    alternatives: values.alternatives,
  };

  if (!user?.getIdToken) {
    throw new Error("Usuário admin ausente");
  }

  const token = await user.getIdToken();
  const response = await fetch("/api/update-question-classification", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      Authorization: `Bearer ${token}`,
    },
    body: JSON.stringify(payload),
  });

  const responseText = await response.text();
  let result = null;

  if (responseText) {
    try {
      result = JSON.parse(responseText);
    } catch {
      const preview = responseText.slice(0, 160).replace(/\s+/g, " ").trim();
      throw new Error(
        response.status === 404
          ? "Endpoint /api/update-question-classification não encontrado. Em desenvolvimento local, rode com Vercel/servidor que suporte a pasta api."
          : `Resposta inválida da API (${response.status}): ${preview || "sem conteúdo JSON"}`
      );
    }
  }

  if (!response.ok) {
    throw new Error(result?.error || "Erro ao salvar classificação");
  }

  if (!result?.question) {
    throw new Error("A API salvou sem retornar a questão atualizada.");
  }

  return result.question;
}

export async function updateAdminQuestionClassification(questionId, values, user) {
  return updateAdminQuestion(questionId, values, user);
}

export async function createAdminQuestion(values, user) {
  const payload = {
    disciplineId: values.disciplineId,
    exam: normalizeExamCode(values.exam),
    topicId: values.topicId || null,
    grandThemeId: values.grandThemeId || null,
    domainId: values.domainId || null,
    detailId: values.detailId || null,
    difficulty: values.difficulty,
    questionType: values.questionType || "single",
    active: values.active,
    statement: values.statement,
    correctAnswers: values.correctAnswers,
    generalComment: values.generalComment,
    summary: values.summary,
    memoryTip: values.memoryTip,
    trap: values.trap,
    reference: values.reference,
    alternatives: values.alternatives,
  };

  if (!user?.getIdToken) {
    throw new Error("Usuário admin ausente");
  }

  const token = await user.getIdToken();
  const response = await fetch("/api/create-question", {
    method: "POST",
    headers: {
      "Content-Type": "application/json",
      Authorization: `Bearer ${token}`,
    },
    body: JSON.stringify(payload),
  });

  const responseText = await response.text();
  let result = null;

  if (responseText) {
    try {
      result = JSON.parse(responseText);
    } catch {
      const preview = responseText.slice(0, 160).replace(/\s+/g, " ").trim();
      throw new Error(
        response.status === 404
          ? "Endpoint /api/create-question não encontrado. Em desenvolvimento local, rode com Vercel/servidor que suporte a pasta api."
          : `Resposta inválida da API (${response.status}): ${preview || "sem conteúdo JSON"}`
      );
    }
  }

  if (!response.ok) {
    throw new Error(result?.error || "Erro ao criar questão");
  }

  if (!result?.question) {
    throw new Error("A API criou sem retornar a questão.");
  }

  return result.question;
}
