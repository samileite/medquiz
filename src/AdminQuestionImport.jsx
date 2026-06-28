import { useEffect, useMemo, useState } from "react";
import { createAdminQuestion, fetchAdminQuestionOptions, parseAdminQuestionFile, suggestAdminQuestionTaxonomy } from "./services/adminQuestions.js";
import { useAuth } from "./Auth.jsx";
import { buildImportDraft, parseQuestionsFromText } from "./utils/questionImportParser.js";

const inputStyle = {
  border: "1px solid #d9d9d9",
  borderRadius: 8,
  padding: "9px 10px",
  fontSize: 13,
  background: "#fff",
  color: "#222",
};

const textAreaStyle = {
  ...inputStyle,
  minHeight: 84,
  resize: "vertical",
  lineHeight: 1.45,
};

function FormField({ label, children }) {
  return (
    <label style={{ display: "flex", flexDirection: "column", gap: 6 }}>
      <span style={{ fontSize: 11, color: "#777", fontWeight: 700, textTransform: "uppercase", letterSpacing: "0.06em" }}>{label}</span>
      {children}
    </label>
  );
}

function sortByOrderAndName(a, b) {
  const orderDiff = (a.order ?? 0) - (b.order ?? 0);
  if (orderDiff !== 0) return orderDiff;
  return a.name.localeCompare(b.name);
}

function uniqueTaxonomyOptions(rows, idKey, nameKey, orderKey) {
  const byId = new Map();
  rows.forEach((row) => {
    const id = row[idKey];
    const name = row[nameKey];
    if (!id || !name || byId.has(id)) return;
    byId.set(id, { id, name, order: row[orderKey] ?? 0 });
  });
  return [...byId.values()].sort(sortByOrderAndName);
}

function correctAnswersToText(answers) {
  return (answers || []).join(", ");
}

function textToCorrectAnswers(value) {
  return String(value || "")
    .split(",")
    .map((answer) => answer.trim().toUpperCase())
    .filter(Boolean);
}

function normalizePreviewQuestion(question, index) {
  return {
    id: `preview-${index}`,
    statement: question.statement || "",
    alternatives: question.alternatives || [],
    correctAnswersText: correctAnswersToText(question.correctAnswers),
    generalComment: question.generalComment || "",
    grandThemeId: "",
    domainId: "",
    detailId: "",
    suggestion: null,
    selected: true,
  };
}

export default function AdminQuestionImport() {
  const { user } = useAuth();
  const [options, setOptions] = useState({ disciplines: [], topics: [], taxonomy: [] });
  const [defaults, setDefaults] = useState({
    disciplineId: "",
    exam: "P1",
    topicId: "",
    difficulty: "médio",
    reference: "",
  });
  const [rawText, setRawText] = useState("");
  const [previewQuestions, setPreviewQuestions] = useState([]);
  const [loading, setLoading] = useState(false);
  const [importing, setImporting] = useState(false);
  const [error, setError] = useState("");
  const [success, setSuccess] = useState("");

  useEffect(() => {
    async function loadOptions() {
      try {
        const adminOptions = await fetchAdminQuestionOptions();
        setOptions(adminOptions);
        setDefaults((current) => ({
          ...current,
          disciplineId: current.disciplineId || adminOptions.disciplines[0]?.id || "",
        }));
      } catch (err) {
        console.error("Erro ao carregar opções de importação:", err);
        setError("Não foi possível carregar disciplinas e taxonomia.");
      }
    }

    loadOptions();
  }, []);

  const topics = useMemo(
    () => options.topics
      .filter((topic) => topic.discipline_id === defaults.disciplineId)
      .sort((a, b) => a.name.localeCompare(b.name)),
    [defaults.disciplineId, options.topics]
  );

  const taxonomyRows = useMemo(
    () => options.taxonomy.filter((row) => row.discipline_id === defaults.disciplineId),
    [defaults.disciplineId, options.taxonomy]
  );

  const grandThemes = useMemo(
    () => uniqueTaxonomyOptions(taxonomyRows, "grand_theme_id", "grand_theme_name", "grand_theme_order"),
    [taxonomyRows]
  );

  function updateDefault(name, value) {
    setDefaults((current) => ({
      ...current,
      [name]: value,
      ...(name === "disciplineId" ? { topicId: "" } : {}),
    }));
    if (name === "disciplineId") {
      setPreviewQuestions((current) => current.map((question) => ({
        ...question,
        grandThemeId: "",
        domainId: "",
        detailId: "",
        suggestion: null,
      })));
    }
  }

  function parsePreview(text) {
    const parsed = parseQuestionsFromText(text).map(normalizePreviewQuestion);
    setPreviewQuestions(parsed);
    setSuccess(parsed.length ? `${parsed.length} questão(ões) detectada(s).` : "");
    setError(parsed.length ? "" : "Nenhuma questão foi detectada no texto.");
  }

  async function handleFile(event) {
    const file = event.target.files?.[0];
    if (!file) return;

    try {
      setLoading(true);
      setError("");
      setSuccess("");
      const text = file.name.toLowerCase().endsWith(".txt")
        ? await file.text()
        : await parseAdminQuestionFile(file, user);
      setRawText(text);
      parsePreview(text);
    } catch (err) {
      console.error("Erro ao processar arquivo:", err);
      setError(err?.message || "Não foi possível processar o arquivo.");
    } finally {
      setLoading(false);
      event.target.value = "";
    }
  }

  async function suggestTaxonomy() {
    if (!defaults.disciplineId) {
      setError("Selecione uma disciplina antes de sugerir taxonomia.");
      return;
    }

    try {
      setLoading(true);
      setError("");
      const suggestions = await suggestAdminQuestionTaxonomy({
        disciplineId: defaults.disciplineId,
        questions: previewQuestions.map((question) => ({
          statement: question.statement,
          alternatives: question.alternatives,
          generalComment: question.generalComment,
        })),
      }, user);

      setPreviewQuestions((current) => current.map((question, index) => {
        const suggestion = suggestions[index] || {};
        return {
          ...question,
          suggestion,
          grandThemeId: suggestion.grandThemeId || question.grandThemeId,
          domainId: suggestion.domainId || question.domainId,
          detailId: suggestion.detailId || question.detailId,
        };
      }));
      setSuccess("Sugestões de taxonomia aplicadas ao preview.");
    } catch (err) {
      console.error("Erro ao sugerir taxonomia:", err);
      setError(err?.message || "Não foi possível sugerir taxonomia.");
    } finally {
      setLoading(false);
    }
  }

  function updatePreviewQuestion(id, changes) {
    setPreviewQuestions((current) => current.map((question) => (
      question.id === id ? { ...question, ...changes } : question
    )));
  }

  function updateGrandTheme(question, value) {
    updatePreviewQuestion(question.id, {
      grandThemeId: value,
      domainId: "",
      detailId: "",
    });
  }

  function updateDomain(question, value) {
    updatePreviewQuestion(question.id, {
      domainId: value,
      detailId: "",
    });
  }

  async function importSelectedQuestions() {
    const selected = previewQuestions.filter((question) => question.selected);
    if (!selected.length) {
      setError("Selecione pelo menos uma questão para importar.");
      return;
    }

    try {
      setImporting(true);
      setError("");
      setSuccess("");
      for (const question of selected) {
        await createAdminQuestion({
          ...buildImportDraft({
            ...question,
            correctAnswers: textToCorrectAnswers(question.correctAnswersText),
          }, defaults),
          grandThemeId: question.grandThemeId,
          domainId: question.domainId,
          detailId: question.detailId,
        }, user);
      }
      setPreviewQuestions([]);
      setRawText("");
      setSuccess(`${selected.length} questão(ões) importada(s) com sucesso.`);
    } catch (err) {
      console.error("Erro ao importar questões:", err);
      setError(err?.message || "Não foi possível importar as questões.");
    } finally {
      setImporting(false);
    }
  }

  return (
    <div>
      <div style={{ marginBottom: 16 }}>
        <h2 style={{ fontSize: 18, margin: "0 0 4px", color: "#1a1a1a" }}>Importar questões</h2>
        <p style={{ margin: 0, color: "#777", fontSize: 13 }}>Upload, parser, pré-visualização, sugestão de taxonomia e importação</p>
      </div>

      <div style={{ background: "#f9f9f9", border: "1px solid #ededed", borderRadius: 12, padding: 14, display: "grid", gap: 12, marginBottom: 16 }}>
        <div style={{ display: "grid", gridTemplateColumns: "repeat(auto-fit, minmax(180px, 1fr))", gap: 12 }}>
          <FormField label="Disciplina">
            <select value={defaults.disciplineId} onChange={(event) => updateDefault("disciplineId", event.target.value)} style={inputStyle}>
              <option value="">Selecione</option>
              {options.disciplines.map((discipline) => <option key={discipline.id} value={discipline.id}>{discipline.name}</option>)}
            </select>
          </FormField>
          <FormField label="Exam">
            <input value={defaults.exam} onChange={(event) => updateDefault("exam", event.target.value.toUpperCase())} style={inputStyle} />
          </FormField>
          <FormField label="Topic legado">
            <select value={defaults.topicId} onChange={(event) => updateDefault("topicId", event.target.value)} style={inputStyle}>
              <option value="">Sem assunto</option>
              {topics.map((topic) => <option key={topic.id} value={topic.id}>{topic.name}</option>)}
            </select>
          </FormField>
          <FormField label="Dificuldade">
            <select value={defaults.difficulty} onChange={(event) => updateDefault("difficulty", event.target.value)} style={inputStyle}>
              <option value="fácil">fácil</option>
              <option value="médio">médio</option>
              <option value="difícil">difícil</option>
            </select>
          </FormField>
        </div>
        <FormField label="Arquivo Word/TXT/PDF">
          <input type="file" accept=".txt,.pdf,.doc,.docx,text/plain,application/pdf,application/vnd.openxmlformats-officedocument.wordprocessingml.document" onChange={handleFile} style={inputStyle} />
        </FormField>
        <FormField label="Texto extraído">
          <textarea value={rawText} onChange={(event) => setRawText(event.target.value)} style={{ ...textAreaStyle, minHeight: 120 }} />
        </FormField>
        <div style={{ display: "flex", gap: 8, flexWrap: "wrap", justifyContent: "flex-end" }}>
          <button onClick={() => parsePreview(rawText)} disabled={loading || !rawText.trim()} style={{ fontSize: 12, padding: "8px 12px", borderRadius: 8, border: "1px solid #d9d9d9", background: "#fff", color: "#555", cursor: loading ? "not-allowed" : "pointer" }}>
            Gerar preview
          </button>
          <button onClick={suggestTaxonomy} disabled={loading || previewQuestions.length === 0} style={{ fontSize: 12, padding: "8px 12px", borderRadius: 8, border: "1px solid #bdd9f0", background: "#e6f1fb", color: "#185fa5", fontWeight: 700, cursor: loading ? "not-allowed" : "pointer" }}>
            {loading ? "Processando..." : "IA sugerir taxonomia"}
          </button>
          <button onClick={importSelectedQuestions} disabled={importing || previewQuestions.length === 0} style={{ fontSize: 12, padding: "8px 14px", borderRadius: 8, border: "none", background: importing ? "#8bbcaf" : "#0f6e56", color: "#fff", fontWeight: 700, cursor: importing ? "not-allowed" : "pointer" }}>
            {importing ? "Importando..." : "Importar selecionadas"}
          </button>
        </div>
      </div>

      {error && (
        <div style={{ background: "#fcebeb", border: "1px solid #f2c4c4", borderRadius: 12, padding: "12px 14px", color: "#a32d2d", fontSize: 13, marginBottom: 16 }}>
          {error}
        </div>
      )}

      {success && (
        <div style={{ background: "#e1f5ee", border: "1px solid #bfe6d7", borderRadius: 12, padding: "12px 14px", color: "#0f6e56", fontSize: 13, marginBottom: 16 }}>
          {success}
        </div>
      )}

      {previewQuestions.length > 0 && (
        <div style={{ display: "grid", gap: 12 }}>
          {previewQuestions.map((question, index) => {
            const domains = question.grandThemeId
              ? uniqueTaxonomyOptions(taxonomyRows.filter((row) => row.grand_theme_id === question.grandThemeId), "domain_id", "domain_name", "domain_order")
              : [];
            const details = question.domainId
              ? uniqueTaxonomyOptions(taxonomyRows.filter((row) => row.domain_id === question.domainId), "detail_id", "detail_name", "detail_order")
              : [];

            return (
              <div key={question.id} style={{ border: "1px solid #e0e0e0", borderRadius: 12, background: "#fff", padding: 14 }}>
                <div style={{ display: "flex", justifyContent: "space-between", gap: 12, alignItems: "center", marginBottom: 12 }}>
                  <strong style={{ color: "#1a1a1a", fontSize: 14 }}>Questão {index + 1}</strong>
                  <label style={{ display: "flex", gap: 6, alignItems: "center", color: "#555", fontSize: 12 }}>
                    <input type="checkbox" checked={question.selected} onChange={(event) => updatePreviewQuestion(question.id, { selected: event.target.checked })} />
                    Importar
                  </label>
                </div>
                <div style={{ display: "grid", gap: 10 }}>
                  <FormField label="Enunciado">
                    <textarea value={question.statement} onChange={(event) => updatePreviewQuestion(question.id, { statement: event.target.value })} style={{ ...textAreaStyle, minHeight: 96 }} />
                  </FormField>
                  <FormField label="Resposta correta">
                    <input value={question.correctAnswersText} onChange={(event) => updatePreviewQuestion(question.id, { correctAnswersText: event.target.value.toUpperCase() })} style={inputStyle} />
                  </FormField>
                  <div style={{ display: "grid", gridTemplateColumns: "repeat(auto-fit, minmax(180px, 1fr))", gap: 10 }}>
                    <FormField label="Grande tema">
                      <select value={question.grandThemeId} onChange={(event) => updateGrandTheme(question, event.target.value)} style={inputStyle}>
                        <option value="">Sem grande tema</option>
                        {grandThemes.map((theme) => <option key={theme.id} value={theme.id}>{theme.name}</option>)}
                      </select>
                    </FormField>
                    <FormField label="Domínio">
                      <select value={question.domainId} onChange={(event) => updateDomain(question, event.target.value)} disabled={!question.grandThemeId} style={{ ...inputStyle, opacity: question.grandThemeId ? 1 : 0.6 }}>
                        <option value="">Sem domínio</option>
                        {domains.map((domain) => <option key={domain.id} value={domain.id}>{domain.name}</option>)}
                      </select>
                    </FormField>
                    <FormField label="Detalhe">
                      <select value={question.detailId} onChange={(event) => updatePreviewQuestion(question.id, { detailId: event.target.value })} disabled={!question.domainId} style={{ ...inputStyle, opacity: question.domainId ? 1 : 0.6 }}>
                        <option value="">Sem detalhe</option>
                        {details.map((detail) => <option key={detail.id} value={detail.id}>{detail.name}</option>)}
                      </select>
                    </FormField>
                  </div>
                  {question.suggestion?.reason && (
                    <p style={{ margin: 0, color: "#777", fontSize: 12 }}>
                      Sugestão: {question.suggestion.reason} ({question.suggestion.confidence || 0}%)
                    </p>
                  )}
                  <details>
                    <summary style={{ cursor: "pointer", color: "#555", fontSize: 12, fontWeight: 700 }}>Alternativas e comentários</summary>
                    <div style={{ display: "grid", gap: 8, marginTop: 10 }}>
                      {question.alternatives.map((alternative) => (
                        <div key={alternative.letter} style={{ display: "grid", gridTemplateColumns: "32px 1fr", gap: 8, alignItems: "start" }}>
                          <strong style={{ color: "#0f6e56" }}>{alternative.letter}</strong>
                          <textarea readOnly value={alternative.text} style={{ ...textAreaStyle, minHeight: 52, background: "#f9f9f9" }} />
                        </div>
                      ))}
                    </div>
                  </details>
                </div>
              </div>
            );
          })}
        </div>
      )}
    </div>
  );
}
