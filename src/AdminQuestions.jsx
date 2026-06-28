import { useEffect, useMemo, useState } from "react";
import { fetchAdminQuestions } from "./services/adminQuestions.js";
import { compareExamCodes } from "./utils/exams.js";

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

export default function AdminQuestions() {
  const [questions, setQuestions] = useState([]);
  const [loading, setLoading] = useState(true);
  const [error, setError] = useState("");
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
        const list = await fetchAdminQuestions();
        setQuestions(list);
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

  return (
    <div>
      <div style={{ display: "flex", alignItems: "flex-end", justifyContent: "space-between", gap: 12, marginBottom: 16, flexWrap: "wrap" }}>
        <div>
          <h2 style={{ fontSize: 18, margin: "0 0 4px", color: "#1a1a1a" }}>Questões</h2>
          <p style={{ margin: 0, color: "#777", fontSize: 13 }}>{shownQuestions.length} de {questions.length} questão(ões)</p>
        </div>
        <button onClick={clearFilters} style={{ fontSize: 12, padding: "8px 12px", borderRadius: 8, border: "1px solid #e0e0e0", background: "#fff", color: "#555", cursor: "pointer" }}>
          Limpar filtros
        </button>
      </div>

      <div style={{ background: "#f9f9f9", border: "1px solid #ededed", borderRadius: 12, padding: 14, display: "flex", flexWrap: "wrap", gap: 10, marginBottom: 16 }}>
        <SelectFilter label="Disciplina" value={filters.discipline} options={filterOptions.disciplines} onChange={(value) => updateFilter("discipline", value)} />
        <SelectFilter label="Exam" value={filters.exam} options={filterOptions.exams} onChange={(value) => updateFilter("exam", value)} />
        <SelectFilter label="Grande tema" value={filters.grandTheme} options={filterOptions.grandThemes} onChange={(value) => updateFilter("grandTheme", value)} />
        <SelectFilter label="Domínio" value={filters.domain} options={filterOptions.domains} onChange={(value) => updateFilter("domain", value)} />
        <SelectFilter label="Detalhe" value={filters.detail} options={filterOptions.details} onChange={(value) => updateFilter("detail", value)} />
        <SelectFilter label="Status" value={filters.active} options={["Ativas", "Inativas"]} onChange={(value) => updateFilter("active", value)} />
      </div>

      {loading ? (
        <p style={{ color: "#aaa", textAlign: "center", padding: "2rem" }}>Carregando questões...</p>
      ) : error ? (
        <div style={{ background: "#fcebeb", border: "1px solid #f2c4c4", borderRadius: 12, padding: "14px 16px", color: "#a32d2d", fontSize: 13 }}>{error}</div>
      ) : shownQuestions.length === 0 ? (
        <p style={{ color: "#aaa", textAlign: "center", padding: "2rem" }}>Nenhuma questão encontrada</p>
      ) : (
        <div style={{ overflowX: "auto", border: "1px solid #e0e0e0", borderRadius: 12, background: "#fff" }}>
          <table style={{ width: "100%", minWidth: 980, borderCollapse: "collapse", fontSize: 12 }}>
            <thead>
              <tr style={{ background: "#f5f7f8", color: "#555", textAlign: "left" }}>
                <th style={{ padding: "10px 12px", width: "28%" }}>Enunciado</th>
                <th style={{ padding: "10px 12px" }}>Disciplina</th>
                <th style={{ padding: "10px 12px" }}>Exam</th>
                <th style={{ padding: "10px 12px" }}>Dificuldade</th>
                <th style={{ padding: "10px 12px" }}>Tipo</th>
                <th style={{ padding: "10px 12px" }}>Topic legado</th>
                <th style={{ padding: "10px 12px" }}>Grande tema</th>
                <th style={{ padding: "10px 12px" }}>Domínio</th>
                <th style={{ padding: "10px 12px" }}>Detalhe</th>
                <th style={{ padding: "10px 12px" }}>Status</th>
              </tr>
            </thead>
            <tbody>
              {shownQuestions.map((question) => (
                <tr key={question.id} style={{ borderTop: "1px solid #ededed", verticalAlign: "top" }}>
                  <td style={{ padding: "11px 12px", lineHeight: 1.5, color: "#222" }}>{summarizeStatement(question.statement)}</td>
                  <td style={{ padding: "11px 12px", color: "#555" }}>{question.discipline}</td>
                  <td style={{ padding: "11px 12px", color: "#555", fontWeight: 700 }}>{question.exam}</td>
                  <td style={{ padding: "11px 12px", color: "#555" }}>{question.difficulty}</td>
                  <td style={{ padding: "11px 12px", color: "#555" }}>{question.questionType}</td>
                  <td style={{ padding: "11px 12px", color: "#555" }}>{question.legacyTopic}</td>
                  <td style={{ padding: "11px 12px", color: "#555" }}>{question.grandTheme || "Sem grande tema"}</td>
                  <td style={{ padding: "11px 12px", color: "#555" }}>{question.domain || "Sem domínio"}</td>
                  <td style={{ padding: "11px 12px", color: "#555" }}>{question.detail || "Sem detalhe"}</td>
                  <td style={{ padding: "11px 12px" }}><StatusBadge active={question.active} /></td>
                </tr>
              ))}
            </tbody>
          </table>
        </div>
      )}
    </div>
  );
}
