const VALID_ANSWERS = new Set(["A", "B", "C", "D", "E"]);

export async function saveAnswer({
  user,
  questionId,
  selectedAnswer,
  selectedAnswers,
  correctAnswer,
  correctAnswers,
}) {
  const normalizedSelectedAnswers = Array.isArray(selectedAnswers)
    ? selectedAnswers.map((v) => String(v).toUpperCase())
    : selectedAnswer
      ? [String(selectedAnswer).toUpperCase()]
      : [];
  const normalizedCorrectAnswers = Array.isArray(correctAnswers)
    ? correctAnswers.map((v) => String(v).toUpperCase())
    : correctAnswer
      ? [String(correctAnswer).toUpperCase()]
      : [];

  if (!user?.getIdToken) {
    console.error("Erro ao salvar resposta: usuário ausente");
    return null;
  }

  if (!questionId) {
    console.error("Erro ao salvar resposta: questionId ausente");
    return null;
  }

  if (normalizedSelectedAnswers.length === 0) {
    console.error("Erro ao salvar resposta: selectedAnswers ausente");
    return null;
  }

  if (!normalizedSelectedAnswers.every((answer) => VALID_ANSWERS.has(answer))) {
    console.error("Erro ao salvar resposta: selectedAnswers inválida", normalizedSelectedAnswers);
    return null;
  }

  if (normalizedCorrectAnswers.length === 0) {
    console.error("Erro ao salvar resposta: correctAnswers ausente");
    return null;
  }

  try {
    const token = await user.getIdToken();

    const response = await fetch("/api/save-answer", {
      method: "POST",
      headers: {
        "Content-Type": "application/json",
        Authorization: `Bearer ${token}`,
      },
      body: JSON.stringify({
        questionId,
        selectedAnswer: normalizedSelectedAnswers.length === 1 ? normalizedSelectedAnswers[0] : undefined,
        selectedAnswers: normalizedSelectedAnswers,
        correctAnswers: normalizedCorrectAnswers,
      }),
    });

    const result = await response.json();

    if (!response.ok) {
      console.error("Erro ao salvar resposta:", result);
      return null;
    }

    console.log("Resposta salva com sucesso:", result);
    return result;
  } catch (error) {
    console.error("Erro ao salvar resposta:", error);
    return null;
  }
}