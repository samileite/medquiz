import { useEffect, useMemo, useState } from "react";
import { createAdminQuestion, fetchAdminQuestions, fetchAdminQuestionOptions, updateAdminQuestion } from "./services/adminQuestions.js";
import { compareExamCodes } from "./utils/exams.js";
import { useAuth } from "./Auth.jsx";

const ALL = "Todos";

function uniqueSorted(items, selector, compare = (a, b) => a.localeCompare(b)) {
  return [...new Set(items.map(selector).filter(Boolean))].sort(compare);
}

function summarizeStatement(statement) {
  const text = String(statement || "").replace(/\s+/g, " ").trim();
  if (text.length <= 140) return text;
  return `${text.slice(0, 137)}...`;
}

function SelectFilter({ label, value, options, onChange }) {
  return (
    <label style={{ display: "flex", flexDirection: "column", gap: 6, minWidth: 150, flex: "1 1 150px" }}>
      <span style={{ fontSize: 11, color: "#777", fontWeight: 700, textTransform: "uppercase", letterSpacing: "0.06em" }}>{label}</span>
      <select
        value={value}
        onChange={(event) => onChange(event.target.value)}
        style={{ width: "100%", border: "1px solid #e0e0e0", borderRadius: 8, padding: "8px 10px", fontSize: 13, background: "#fff", color: "#333" }}
      >
        <option value={ALL}>{ALL}</option>
        {options.map((option) => (
          <option key={option} value={option}>{option}</option>
        ))}
      </select>
    </label>
  );
}

function StatusBadge({ active }) {
  const style = active
    ? { background: "#e1f5ee", color: "#0f6e56", label: "Ativa" }
    : { background: "#fcebeb", color: "#a32d2d", label: "Inativa" };

  return (
    <span style={{ display: "inline-flex", alignItems: "center", justifyContent: "center", minWidth: 58, fontSize: 11, padding: "3px 8px", borderRadius: 999, background: style.background, color: style.color, fontWeight: 700 }}>
      {style.label}
    </span>
  );
}

function QuestionMeta({ label, value, children }) {
  return (
    <div style={{ minWidth: 0 }}>
      <p style={{ fontSize: 10, color: "#999", fontWeight: 700, textTransform: "uppercase", letterSpacing: "0.06em", margin: "0 0 5px" }}>{label}</p>
      <div style={{ fontSize: 12, color: "#444", lineHeight: 1.45, overflowWrap: "anywhere" }}>{children || value || "Sem informação"}</div>
    </div>
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

function FormField({ label, children }) {
  return (
    <label style={{ display: "flex", flexDirection: "column", gap: 6 }}>
      <span style={{ fontSize: 11, color: "#777", fontWeight: 700, textTransform: "uppercase", letterSpacing: "0.06em" }}>{label}</span>
      {children}
    </label>
  );
}

function FormSection({ title, children }) {
  return (
    <section style={{ display: "grid", gap: 12 }}>
      <h4 style={{ fontSize: 12, fontWeight: 800, color: "#555", textTransform: "uppercase", letterSpacing: "0.06em", margin: 0 }}>{title}</h4>
      {children}
    </section>
  );
}

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
  minHeight: 86,
  resize: "vertical",
  lineHeight: 1.45,
};

const ALTERNATIVE_LETTERS = ["A", "B", "C", "D", "E"];

function normalizeDraftAlternatives(alternatives = []) {
  const byLetter = new Map(
    alternatives.map((alternative) => [alternative.letter, alternative])
  );

  return ALTERNATIVE_LETTERS.map((letter) => ({
    letter,
    text: byLetter.get(letter)?.text || "",
    explanation: byLetter.get(letter)?.explanation || "",
  }));
}

function correctAnswersToText(question) {
  const answers = question.correctAnswers?.length
    ? question.correctAnswers
    : question.correctAnswer ? [question.correctAnswer] : [];

  return answers.join(", ");
}

function textToCorrectAnswers(value) {
  return String(value || "")
    .split(",")
    .map((answer) => answer.trim().toUpperCase())
    .filter(Boolean);
}

function createEmptyQuestion(options) {
  const firstDiscipline = options.disciplines[0];

  return {
    id: "",
    disciplineId: firstDiscipline?.id || "",
    exam: "P1",
    topicId: "",
    grandThemeId: "",
    domainId: "",
    detailId: "",
    difficulty: "médio",
    questionType: "single",
    active: true,
    statement: "",
    correctAnswer: "",
    correctAnswers: [],
    generalComment: "",
    summary: "",
    memoryTip: "",
    trap: "",
    reference: "",
    alternatives: normalizeDraftAlternatives(),
  };
}

function QuestionEditor({ question, options, saving, onCancel, onSave }) {
  const isNew = !question.id;
  const [draft, setDraft] = useState({
    disciplineId: question.disciplineId,
    exam: question.exam,
    topicId: question.topicId,
    grandThemeId: question.grandThemeId,
    domainId: question.domainId,
    detailId: question.detailId,
    difficulty: question.difficulty,
    questionType: question.questionType,
    active: question.active,
    statement: question.statement,
    correctAnswersText: correctAnswersToText(question),
    generalComment: question.generalComment,
    summary: question.summary,
    memoryTip: question.memoryTip,
    trap: question.trap,
    reference: question.reference,
    alternatives: normalizeDraftAlternatives(question.alternatives),
  });

  const topics = useMemo(
    () => options.topics
      .filter((topic) => topic.discipline_id === draft.disciplineId)
      .sort((a, b) => a.name.localeCompare(b.name)),
    [draft.disciplineId, options.topics]
  );
  const grandThemes = useMemo(
    () => uniqueTaxonomyOptions(
      options.taxonomy.filter((row) => row.discipline_id === draft.disciplineId),
      "grand_theme_id",
      "grand_theme_name",
      "grand_theme_order"
    ),
    [draft.disciplineId, options.taxonomy]
  );
  const domains = useMemo(() => {
    if (!draft.grandThemeId) return [];
    return uniqueTaxonomyOptions(
      options.taxonomy.filter((row) => row.grand_theme_id === draft.grandThemeId),
      "domain_id",
      "domain_name",
      "domain_order"
    );
  }, [draft.grandThemeId, options.taxonomy]);
  const details = useMemo(() => {
    if (!draft.domainId) return [];
    return uniqueTaxonomyOptions(
      options.taxonomy.filter((row) => row.domain_id === draft.domainId),
      "detail_id",
      "detail_name",
      "detail_order"
    );
  }, [draft.domainId, options.taxonomy]);

  function updateDraft(name, value) {
    setDraft((current) => ({ ...current, [name]: value }));
  }

  function updateAlternative(letter, name, value) {
    setDraft((current) => ({
      ...current,
      alternatives: current.alternatives.map((alternative) => (
        alternative.letter === letter ? { ...alternative, [name]: value } : alternative
      )),
    }));
  }

  function updateDiscipline(value) {
    setDraft((current) => ({
      ...current,
      disciplineId: value,
      topicId: "",
      grandThemeId: "",
      domainId: "",
      detailId: "",
    }));
  }

  function updateGrandTheme(value) {
    setDraft((current) => ({
      ...current,
      grandThemeId: value,
      domainId: "",
      detailId: "",
    }));
  }

  function updateDomain(value) {
    setDraft((current) => ({
      ...current,
      domainId: value,
      detailId: "",
    }));
  }

  return (
    <div style={{ background: "#fbfcfc", border: "1px solid #d9ece5", borderRadius: 12, padding: 14 }}>
      <div style={{ display: "grid", gap: 12, marginBottom: 16 }}>
          <FormField label="Enunciado">
            <textarea value={draft.statement} onChange={(event) => updateDraft("statement", event.target.value)} style={{ ...textAreaStyle, minHeight: 120 }} />
          </FormField>
          <FormSection title="Conteúdo da questão">
            <div style={{ display: "grid", gridTemplateColumns: "repeat(auto-fit, minmax(220px, 1fr))", gap: 12 }}>
            <FormField label="Resposta correta">
              <input
                value={draft.correctAnswersText}
                onChange={(event) => updateDraft("correctAnswersText", event.target.value.toUpperCase())}
                placeholder="A ou A, C"
                style={inputStyle}
              />
            </FormField>
            <FormField label="Tipo">
              <select value={draft.questionType} onChange={(event) => updateDraft("questionType", event.target.value)} style={inputStyle}>
                <option value="single">single</option>
                <option value="multiple">multiple</option>
                <option value="true_false">true_false</option>
              </select>
            </FormField>
            </div>
          </FormSection>
          <FormSection title="Alternativas e comentários por alternativa">
          <div style={{ display: "grid", gap: 10 }}>
            {draft.alternatives.map((alternative) => (
              <div key={alternative.letter} style={{ border: "1px solid #ededed", borderRadius: 10, padding: 10, background: "#fff" }}>
                <div style={{ display: "grid", gridTemplateColumns: "44px minmax(180px, 1fr)", gap: 10, alignItems: "start" }}>
                  <strong style={{ display: "inline-flex", alignItems: "center", justifyContent: "center", width: 34, height: 34, borderRadius: 8, background: "#eef4f1", color: "#0f6e56" }}>{alternative.letter}</strong>
                  <div style={{ display: "grid", gap: 8 }}>
                    <textarea
                      value={alternative.text}
                      onChange={(event) => updateAlternative(alternative.letter, "text", event.target.value)}
                      placeholder={`Alternativa ${alternative.letter}`}
                      style={{ ...textAreaStyle, minHeight: 58 }}
                    />
                    <textarea
                      value={alternative.explanation}
                      onChange={(event) => updateAlternative(alternative.letter, "explanation", event.target.value)}
                      placeholder={`Comentário da alternativa ${alternative.letter}`}
                      style={{ ...textAreaStyle, minHeight: 58 }}
                    />
                  </div>
                </div>
              </div>
            ))}
          </div>
          </FormSection>
          <FormSection title="Explicações exibidas ao usuário">
          <div style={{ display: "grid", gridTemplateColumns: "repeat(auto-fit, minmax(220px, 1fr))", gap: 12 }}>
            <FormField label="Comentários">
              <textarea value={draft.generalComment} onChange={(event) => updateDraft("generalComment", event.target.value)} style={textAreaStyle} />
            </FormField>
            <FormField label="Resumo">
              <textarea value={draft.summary} onChange={(event) => updateDraft("summary", event.target.value)} style={textAreaStyle} />
            </FormField>
            <FormField label="Memory tip">
              <textarea value={draft.memoryTip} onChange={(event) => updateDraft("memoryTip", event.target.value)} style={textAreaStyle} />
            </FormField>
            <FormField label="Trap">
              <textarea value={draft.trap} onChange={(event) => updateDraft("trap", event.target.value)} style={textAreaStyle} />
            </FormField>
            <FormField label="Referência">
              <textarea value={draft.reference} onChange={(event) => updateDraft("reference", event.target.value)} style={textAreaStyle} />
            </FormField>
          </div>
          </FormSection>
      </div>
      <FormSection title="Dados de classificação e publicação">
      <div style={{ display: "grid", gridTemplateColumns: "repeat(auto-fit, minmax(180px, 1fr))", gap: 12, marginBottom: 14 }}>
          <FormField label="Disciplina">
            <select value={draft.disciplineId} onChange={(event) => updateDiscipline(event.target.value)} style={inputStyle}>
              <option value="">Selecione</option>
              {options.disciplines.map((discipline) => <option key={discipline.id} value={discipline.id}>{discipline.name}</option>)}
            </select>
          </FormField>
          <FormField label="Exam">
            <input value={draft.exam} onChange={(event) => updateDraft("exam", event.target.value.toUpperCase())} style={inputStyle} />
          </FormField>
          <FormField label="Topic legado">
            <select value={draft.topicId} onChange={(event) => updateDraft("topicId", event.target.value)} style={inputStyle}>
              <option value="">Sem assunto</option>
              {topics.map((topic) => <option key={topic.id} value={topic.id}>{topic.name}</option>)}
            </select>
          </FormField>
          <FormField label="Grande tema">
            <select value={draft.grandThemeId} onChange={(event) => updateGrandTheme(event.target.value)} style={inputStyle}>
              <option value="">Sem grande tema</option>
              {grandThemes.map((theme) => <option key={theme.id} value={theme.id}>{theme.name}</option>)}
            </select>
          </FormField>
          <FormField label="Domínio">
            <select value={draft.domainId} onChange={(event) => updateDomain(event.target.value)} disabled={!draft.grandThemeId} style={{ ...inputStyle, opacity: draft.grandThemeId ? 1 : 0.6 }}>
              <option value="">Sem domínio</option>
              {domains.map((domain) => <option key={domain.id} value={domain.id}>{domain.name}</option>)}
            </select>
          </FormField>
          <FormField label="Detalhe">
            <select value={draft.detailId} onChange={(event) => updateDraft("detailId", event.target.value)} disabled={!draft.domainId} style={{ ...inputStyle, opacity: draft.domainId ? 1 : 0.6 }}>
              <option value="">Sem detalhe</option>
              {details.map((detail) => <option key={detail.id} value={detail.id}>{detail.name}</option>)}
            </select>
          </FormField>
          <FormField label="Dificuldade">
            <select value={draft.difficulty} onChange={(event) => updateDraft("difficulty", event.target.value)} style={inputStyle}>
              <option value="fácil">fácil</option>
              <option value="médio">médio</option>
              <option value="difícil">difícil</option>
            </select>
          </FormField>
          <FormField label="Status">
            <select value={draft.active ? "active" : "inactive"} onChange={(event) => updateDraft("active", event.target.value === "active")} style={inputStyle}>
              <option value="active">Ativa</option>
              <option value="inactive">Inativa</option>
            </select>
          </FormField>
      </div>
      </FormSection>
      <div style={{ display: "flex", gap: 8, justifyContent: "flex-end", flexWrap: "wrap" }}>
          <button onClick={onCancel} disabled={saving} style={{ fontSize: 12, padding: "8px 12px", borderRadius: 8, border: "1px solid #d9d9d9", background: "#fff", color: "#555", cursor: saving ? "not-allowed" : "pointer" }}>
            Cancelar
          </button>
          <button
            onClick={() => onSave({
              ...draft,
              correctAnswers: textToCorrectAnswers(draft.correctAnswersText),
              alternatives: draft.alternatives.filter((alternative) => alternative.text.trim()),
            })}
            disabled={saving}
            style={{ fontSize: 12, padding: "8px 14px", borderRadius: 8, border: "none", background: saving ? "#8bbcaf" : "#0f6e56", color: "#fff", fontWeight: 700, cursor: saving ? "not-allowed" : "pointer" }}
          >
            {saving ? "Salvando..." : isNew ? "Cadastrar questão" : "Salvar questão"}
          </button>
      </div>
    </div>
  );
}

export default function AdminQuestions() {
  const { user } = useAuth();
  const [questions, setQuestions] = useState([]);
  const [options, setOptions] = useState({ disciplines: [], topics: [], taxonomy: [] });
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");
  const [saveError, setSaveError] = useState("");
  const [saveSuccess, setSaveSuccess] = useState("");
  const [creating, setCreating] = useState(false);
  const [editingId, setEditingId] = useState("");
  const [savingId, setSavingId] = useState("");
  const [filters, setFilters] = useState({
    discipline: ALL,
    exam: ALL,
    grandTheme: ALL,
    domain: ALL,
    detail: ALL,
    active: ALL,
  });

  useEffect(() => {
    async function loadQuestions() {
      try {
        setLoading(true);
        setError("");
        const [list, adminOptions] = await Promise.all([
          fetchAdminQuestions(),
          fetchAdminQuestionOptions(),
        ]);
        setQuestions(list);
        setOptions(adminOptions);
      } catch (err) {
        console.error("Erro ao carregar questões administrativas:", err);
        setError("Não foi possível carregar as questões.");
      } finally {
        setLoading(false);
      }
    }

    loadQuestions();
  }, []);

  const filterOptions = useMemo(() => ({
    disciplines: uniqueSorted(questions, (question) => question.discipline),
    exams: uniqueSorted(questions, (question) => question.exam, compareExamCodes),
    grandThemes: uniqueSorted(questions, (question) => question.grandTheme),
    domains: uniqueSorted(questions, (question) => question.domain),
    details: uniqueSorted(questions, (question) => question.detail),
  }), [questions]);

  const shownQuestions = useMemo(() => questions.filter((question) => {
    if (filters.discipline !== ALL && question.discipline !== filters.discipline) return false;
    if (filters.exam !== ALL && question.exam !== filters.exam) return false;
    if (filters.grandTheme !== ALL && question.grandTheme !== filters.grandTheme) return false;
    if (filters.domain !== ALL && question.domain !== filters.domain) return false;
    if (filters.detail !== ALL && question.detail !== filters.detail) return false;
    if (filters.active === "Ativas" && !question.active) return false;
    if (filters.active === "Inativas" && question.active) return false;
    return true;
  }), [filters, questions]);

  function updateFilter(name, value) {
    setFilters((current) => ({ ...current, [name]: value }));
  }

  function clearFilters() {
    setFilters({
      discipline: ALL,
      exam: ALL,
      grandTheme: ALL,
      domain: ALL,
      detail: ALL,
      active: ALL,
    });
  }

  async function saveQuestion(question, draft) {
    try {
      setSavingId(question.id);
      setSaveError("");
      setSaveSuccess("");
      await updateAdminQuestion(question.id, draft, user);
      const list = await fetchAdminQuestions();
      setQuestions(list);
      setEditingId("");
      setSaveSuccess("Questão salva com sucesso.");
    } catch (err) {
      console.error("Erro ao salvar questão:", err);
      setSaveError(err?.message || "Não foi possível salvar a questão.");
    } finally {
      setSavingId("");
    }
  }

  async function createQuestion(draft) {
    try {
      setSavingId("new");
      setSaveError("");
      setSaveSuccess("");
      await createAdminQuestion(draft, user);
      const list = await fetchAdminQuestions();
      setQuestions(list);
      setCreating(false);
      setSaveSuccess("Questão cadastrada com sucesso.");
    } catch (err) {
      console.error("Erro ao cadastrar questão:", err);
      setSaveError(err?.message || "Não foi possível cadastrar a questão.");
    } finally {
      setSavingId("");
    }
  }

  return (
    <div>
      <div style={{ display: "flex", alignItems: "flex-end", justifyContent: "space-between", gap: 12, marginBottom: 16, flexWrap: "wrap" }}>
        <div>
          <h2 style={{ fontSize: 18, margin: "0 0 4px", color: "#1a1a1a" }}>Questões</h2>
          <p style={{ margin: 0, color: "#777", fontSize: 13 }}>{shownQuestions.length} de {questions.length} questão(ões)</p>
        </div>
        <div style={{ display: "flex", gap: 8, flexWrap: "wrap" }}>
          <button
            onClick={() => {
              setCreating((current) => !current);
              setEditingId("");
              setSaveError("");
              setSaveSuccess("");
            }}
            style={{ fontSize: 12, padding: "8px 12px", borderRadius: 8, border: "none", background: "#0f6e56", color: "#fff", fontWeight: 700, cursor: "pointer" }}
          >
            {creating ? "Fechar cadastro" : "Nova questão"}
          </button>
          <button onClick={clearFilters} style={{ fontSize: 12, padding: "8px 12px", borderRadius: 8, border: "1px solid #e0e0e0", background: "#fff", color: "#555", cursor: "pointer" }}>
            Limpar filtros
          </button>
        </div>
      </div>

      {creating && (
        <div style={{ border: "1px solid #d9ece5", borderRadius: 12, background: "#fff", marginBottom: 16, overflow: "hidden" }}>
          <div style={{ padding: "12px 16px", borderBottom: "1px solid #ededed", background: "#f5faf8" }}>
            <h3 style={{ margin: 0, fontSize: 15, color: "#1a1a1a" }}>Cadastrar nova questão</h3>
          </div>
          <div style={{ padding: 14 }}>
            <QuestionEditor
              question={createEmptyQuestion(options)}
              options={options}
              saving={savingId === "new"}
              onCancel={() => setCreating(false)}
              onSave={createQuestion}
            />
          </div>
        </div>
      )}

      <div style={{ background: "#f9f9f9", border: "1px solid #ededed", borderRadius: 12, padding: 14, display: "flex", flexWrap: "wrap", gap: 10, marginBottom: 16 }}>
        <SelectFilter label="Disciplina" value={filters.discipline} options={filterOptions.disciplines} onChange={(value) => updateFilter("discipline", value)} />
        <SelectFilter label="Exam" value={filters.exam} options={filterOptions.exams} onChange={(value) => updateFilter("exam", value)} />
        <SelectFilter label="Grande tema" value={filters.grandTheme} options={filterOptions.grandThemes} onChange={(value) => updateFilter("grandTheme", value)} />
        <SelectFilter label="Domínio" value={filters.domain} options={filterOptions.domains} onChange={(value) => updateFilter("domain", value)} />
        <SelectFilter label="Detalhe" value={filters.detail} options={filterOptions.details} onChange={(value) => updateFilter("detail", value)} />
        <SelectFilter label="Status" value={filters.active} options={["Ativas", "Inativas"]} onChange={(value) => updateFilter("active", value)} />
      </div>

      {saveError && (
        <div style={{ background: "#fcebeb", border: "1px solid #f2c4c4", borderRadius: 12, padding: "12px 14px", color: "#a32d2d", fontSize: 13, marginBottom: 16 }}>
          {saveError}
        </div>
      )}

      {saveSuccess && (
        <div style={{ background: "#e1f5ee", border: "1px solid #bfe6d7", borderRadius: 12, padding: "12px 14px", color: "#0f6e56", fontSize: 13, marginBottom: 16 }}>
          {saveSuccess}
        </div>
      )}

      {loading ? (
        <p style={{ color: "#aaa", textAlign: "center", padding: "2rem" }}>Carregando questões...</p>
      ) : error ? (
        <div style={{ background: "#fcebeb", border: "1px solid #f2c4c4", borderRadius: 12, padding: "14px 16px", color: "#a32d2d", fontSize: 13 }}>{error}</div>
      ) : shownQuestions.length === 0 ? (
        <p style={{ color: "#aaa", textAlign: "center", padding: "2rem" }}>Nenhuma questão encontrada</p>
      ) : (
        <div style={{ display: "grid", gap: 12 }}>
          {shownQuestions.map((question) => (
            <article key={question.id} style={{ background: "#fff", border: "1px solid #e0e0e0", borderRadius: 12, overflow: "hidden" }}>
              <div style={{ padding: "14px 16px" }}>
                <div style={{ display: "flex", alignItems: "flex-start", justifyContent: "space-between", gap: 12, marginBottom: 12 }}>
                  <div style={{ minWidth: 0 }}>
                    <p style={{ fontSize: 13, lineHeight: 1.55, color: "#222", fontWeight: 600, margin: "0 0 8px", overflowWrap: "anywhere" }}>
                      {summarizeStatement(question.statement)}
                    </p>
                    <div style={{ display: "flex", alignItems: "center", gap: 8, flexWrap: "wrap" }}>
                      <StatusBadge active={question.active} />
                      <span style={{ fontSize: 11, padding: "3px 8px", borderRadius: 999, background: "#f1f1f1", color: "#555", fontWeight: 700 }}>{question.exam}</span>
                      <span style={{ fontSize: 11, padding: "3px 8px", borderRadius: 999, background: "#f7f7f7", color: "#555" }}>{question.difficulty}</span>
                    </div>
                  </div>
                  <button onClick={() => setEditingId(editingId === question.id ? "" : question.id)} style={{ fontSize: 12, padding: "7px 12px", borderRadius: 8, border: "1px solid #bdd9f0", background: "#e6f1fb", color: "#185fa5", fontWeight: 700, cursor: "pointer", flexShrink: 0 }}>
                    {editingId === question.id ? "Fechar" : "Editar"}
                  </button>
                </div>

                <div style={{ display: "grid", gridTemplateColumns: "repeat(auto-fit, minmax(140px, 1fr))", gap: 12, borderTop: "1px solid #f0f0f0", paddingTop: 12 }}>
                  <QuestionMeta label="Disciplina" value={question.discipline} />
                  <QuestionMeta label="Tipo" value={question.questionType} />
                  <QuestionMeta label="Topic legado" value={question.legacyTopic} />
                  <QuestionMeta label="Grande tema" value={question.grandTheme || "Sem grande tema"} />
                  <QuestionMeta label="Domínio" value={question.domain || "Sem domínio"} />
                  <QuestionMeta label="Detalhe" value={question.detail || "Sem detalhe"} />
                </div>
              </div>

              {editingId === question.id && (
                <div style={{ padding: "0 14px 14px" }}>
                  <QuestionEditor
                    question={question}
                    options={options}
                    saving={savingId === question.id}
                    onCancel={() => setEditingId("")}
                    onSave={(draft) => saveQuestion(question, draft)}
                  />
                </div>
              )}
            </article>
          ))}
        </div>
      )}
    </div>
  );
}
