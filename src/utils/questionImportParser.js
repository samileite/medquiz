const LETTER_PATTERN = /^([A-E])[).:-]\s*(.+)$/i;
const ANSWER_PATTERN = /(?:resposta|gabarito|correta)\s*[:-]\s*([A-E](?:\s*,\s*[A-E])*)/i;

function cleanText(value) {
  return String(value || "").replace(/\r/g, "").trim();
}

function normalizeQuestionBlock(block) {
  const lines = cleanText(block)
    .split("\n")
    .map((line) => line.trim())
    .filter(Boolean);

  const statementLines = [];
  const alternatives = [];
  const comments = [];
  let currentAlternative = null;
  let correctAnswers = [];
  let parsingAlternatives = false;

  lines.forEach((line) => {
    const answerMatch = line.match(ANSWER_PATTERN);
    if (answerMatch) {
      correctAnswers = answerMatch[1]
        .split(",")
        .map((answer) => answer.trim().toUpperCase())
        .filter(Boolean);
      return;
    }

    const alternativeMatch = line.match(LETTER_PATTERN);
    if (alternativeMatch) {
      parsingAlternatives = true;
      currentAlternative = {
        letter: alternativeMatch[1].toUpperCase(),
        text: alternativeMatch[2].trim(),
        explanation: "",
      };
      alternatives.push(currentAlternative);
      return;
    }

    if (parsingAlternatives && currentAlternative) {
      currentAlternative.text = `${currentAlternative.text} ${line}`.trim();
      return;
    }

    if (/^(coment[aá]rio|justificativa|explica[cç][aã]o|resumo|refer[eê]ncia)/i.test(line)) {
      comments.push(line.replace(/^[^:]+:\s*/i, ""));
      return;
    }

    statementLines.push(line.replace(/^\d+[).:-]\s*/, ""));
  });

  const filledAlternatives = ["A", "B", "C", "D", "E"].map((letter) => {
    const found = alternatives.find((alternative) => alternative.letter === letter);
    return found || { letter, text: "", explanation: "" };
  });

  return {
    statement: statementLines.join(" ").trim(),
    alternatives: filledAlternatives,
    correctAnswers,
    generalComment: comments.join("\n"),
  };
}

export function parseQuestionsFromText(rawText) {
  const text = cleanText(rawText);
  if (!text) return [];

  const blocks = [];
  const normalized = text.replace(/\n{3,}/g, "\n\n");
  const numberedParts = normalized.split(/\n(?=\s*\d+[).:-]\s+)/g);

  if (numberedParts.length > 1) {
    blocks.push(...numberedParts);
  } else {
    blocks.push(...normalized.split(/\n\s*\n/g));
  }

  return blocks
    .map(normalizeQuestionBlock)
    .filter((question) => question.statement || question.alternatives.some((alternative) => alternative.text));
}

export function buildImportDraft(parsedQuestion, defaults) {
  return {
    disciplineId: defaults.disciplineId,
    exam: defaults.exam || "P1",
    topicId: defaults.topicId || "",
    grandThemeId: parsedQuestion.grandThemeId || "",
    domainId: parsedQuestion.domainId || "",
    detailId: parsedQuestion.detailId || "",
    difficulty: defaults.difficulty || "médio",
    questionType: parsedQuestion.correctAnswers.length > 1 ? "multiple" : "single",
    active: true,
    statement: parsedQuestion.statement,
    correctAnswers: parsedQuestion.correctAnswers,
    generalComment: parsedQuestion.generalComment || "",
    summary: "",
    memoryTip: "",
    trap: "",
    reference: defaults.reference || "",
    alternatives: parsedQuestion.alternatives.filter((alternative) => alternative.text.trim()),
  };
}
