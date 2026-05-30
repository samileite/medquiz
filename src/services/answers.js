const VALID_ANSWERS = new Set(["A", "B", "C", "D", "E"]);

export async function saveAnswer({
  user,
  questionId,
  selectedAnswer,
  correctAnswer,
}) {
  const normalizedAnswer = selectedAnswer?.toString().toUpperCase();
  const normalizedCorrect = correctAnswer?.toString().toUpperCase();

  if (!user?.getIdToken) {
    console.error("Erro ao salvar resposta: usuário ausente");
    return null;
  }

  if (!questionId) {
    console.error("Erro ao salvar resposta: questionId ausente");
    return null;
  }

  if (!VALID_ANSWERS.has(normalizedAnswer)) {
    console.error("Erro ao salvar resposta: selectedAnswer inválida", normalizedAnswer);
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
        selectedAnswer: normalizedAnswer,
        correctAnswer: normalizedCorrect,
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