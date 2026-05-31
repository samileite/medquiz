import { useState, useEffect, useRef } from "react";
import { fetchQuestionsByDisciplina, fetchDisciplineAvailability } from "./sheets.js";
import { useAuth } from "./Auth.jsx";
import { doc, setDoc, getDoc } from "firebase/firestore";
import { db } from "./firebase.js";
import { DISCIPLINAS_POR_PERIODO, DIFFICULTIES } from "./constants.js";
import { saveAnswer } from "./services/answers.js";
import ProfilePage from "./Profile.jsx";

function Timer({ active, onTick, resetKey }) {
  const [secs, setSecs] = useState(0);
  const ref = useRef(null);
  useEffect(() => { setSecs(0); }, [resetKey]);
  useEffect(() => {
    if (active) { ref.current = setInterval(() => setSecs(s => { onTick(s + 1); return s + 1; }), 1000); }
    else clearInterval(ref.current);
    return () => clearInterval(ref.current);
  }, [active, resetKey]);
  const m = String(Math.floor(secs / 60)).padStart(2, "0");
  const s = String(secs % 60).padStart(2, "0");
  return <span style={{fontVariantNumeric:"tabular-nums",color:secs>120?"#e24b4a":"#aaa",fontSize:13}}>{m}:{s}</span>;
}

function Badge({ label, color }) {
  const colors = {green:{bg:"#e1f5ee",color:"#0f6e56"},amber:{bg:"#faeeda",color:"#854f0b"},red:{bg:"#fcebeb",color:"#a32d2d"},blue:{bg:"#e6f1fb",color:"#185fa5"},gray:{bg:"#f1f1f1",color:"#555"}};
  const c = colors[color]||colors.gray;
  return <span style={{fontSize:11,padding:"3px 9px",borderRadius:999,background:c.bg,color:c.color,fontWeight:500}}>{label}</span>;
}

function StatCard({ label, value, color }) {
  return (
    <div style={{background:"#f1f1f1",borderRadius:12,padding:"14px 16px",textAlign:"center",flex:1,minWidth:80}}>
      <div style={{fontSize:11,color:"#aaa",textTransform:"uppercase",letterSpacing:"0.06em",marginBottom:6}}>{label}</div>
      <div style={{fontSize:24,fontWeight:600,color:color||"#1a1a1a"}}>{value}</div>
    </div>
  );
}

function InfoCard({ icon, title, subtitle, children, borderColor, background }) {
  return (
    <div style={{ background: background || "#fff", border: `1px solid ${borderColor || "#e0e0e0"}`, borderRadius:18, padding:"1.1rem 1.25rem", marginBottom:16, boxShadow:"0 18px 40px rgba(15, 110, 86, 0.08)" }}>
      <div style={{ display:"flex", alignItems:"flex-start", gap:12, marginBottom: subtitle ? 10 : 0 }}>
        <div style={{ width:38, height:38, borderRadius:12, display:"grid", placeItems:"center", background: borderColor ? `${borderColor}22` : "#f1f1f1", fontSize:20 }}>{icon}</div>
        <div style={{ flex:1 }}>
          <div style={{ fontSize:15, fontWeight:700, color:"#1a1a1a", marginBottom:4 }}>{title}</div>
          {subtitle && <div style={{ fontSize:13, color:"#555", lineHeight:1.6 }}>{subtitle}</div>}
        </div>
      </div>
      {children}
    </div>
  );
}

function AlternativeAnalysisCard({ letter, text, justification, status, badgeColor, active }) {
  const border = active ? (badgeColor === "green" ? "#0f6e56" : badgeColor === "red" ? "#e24b4a" : "#e0e0e0") : "#e0e0e0";
  const background = active ? (badgeColor === "green" ? "#eaf7f0" : badgeColor === "red" ? "#fff1f1" : "#fff") : "#fff";
  const iconBg = badgeColor === "green" ? "#d3f0e4" : badgeColor === "red" ? "#f9d3d3" : "#f4f4f5";
  const iconColor = badgeColor === "green" ? "#0f6e56" : badgeColor === "red" ? "#a32d2d" : "#555";

  return (
    <div style={{ borderRadius:16, border:`1px solid ${border}`, background, padding:"14px 16px", marginBottom:12 }}>
      <div style={{ display:"flex", alignItems:"flex-start", gap:12, marginBottom: justification ? 10 : 0 }}>
        <div style={{ minWidth:32, height:32, borderRadius:"50%", display:"grid", placeItems:"center", background:iconBg, color:iconColor, fontWeight:700 }}>{letter}</div>
        <div style={{ flex:1 }}>
          <div style={{ display:"flex", alignItems:"center", gap:10, flexWrap:"wrap" }}>
            <div style={{ fontSize:14, fontWeight:600, color:"#1a1a1a", lineHeight:1.5 }}>{text}</div>
            <Badge label={status} color={badgeColor} />
          </div>
        </div>
      </div>
      {justification && <div style={{ fontSize:13, lineHeight:1.7, color:"#333" }}>{justification}</div>}
    </div>
  );
}

function RestartStudyModal({ disciplina, answeredCount, onCancel, onConfirm }) {
  return (
    <div style={{ position: "fixed", inset: 0, zIndex: 20, background: "rgba(0,0,0,0.36)", display: "grid", placeItems: "center", padding: 20 }}>
      <div style={{ width: "100%", maxWidth: 440, background: "#fff", borderRadius: 20, padding: "1.35rem", boxShadow: "0 24px 70px rgba(0,0,0,0.22)" }}>
        <div style={{ width: 42, height: 42, borderRadius: 14, background: "#fff1f1", display: "grid", placeItems: "center", fontSize: 22, marginBottom: 14 }}>⚠️</div>
        <h3 style={{ margin: "0 0 8px", fontSize: 18, color: "#1a1a1a" }}>Reiniciar estudos?</h3>
        <p style={{ margin: "0 0 12px", fontSize: 14, lineHeight: 1.7, color: "#444" }}>
          Você já iniciou os estudos de {disciplina}. Ao iniciar uma nova sessão, todo o histórico dessa disciplina será perdido.
        </p>
        <p style={{ margin: "0 0 18px", fontSize: 13, lineHeight: 1.6, color: "#777" }}>
          Sugerimos clicar em “Continuar estudo”. Tem certeza que deseja reiniciar os estudos de {disciplina}? {answeredCount > 0 ? `${answeredCount} resposta(s) serão removidas do progresso.` : ""}
        </p>
        <div style={{ display: "flex", gap: 10, justifyContent: "flex-end", flexWrap: "wrap" }}>
          <button onClick={onCancel} style={{ borderRadius: 10, padding: "10px 16px", fontSize: 14, cursor: "pointer", border: "1px solid #e0e0e0", background: "#fff", color: "#555" }}>Cancelar</button>
          <button onClick={onConfirm} style={{ borderRadius: 10, padding: "10px 16px", fontSize: 14, cursor: "pointer", border: "none", background: "#e24b4a", color: "#fff", fontWeight: 700 }}>Sim, reiniciar</button>
        </div>
      </div>
    </div>
  );
}

export default function App() {
  const { user, userData } = useAuth();
  const periodo = userData?.periodo || 5;
  const disciplinasDoPeriodo = DISCIPLINAS_POR_PERIODO[periodo] || [];

  const [selectedDisciplina, setSelectedDisciplina] = useState(null);
  const [selectedSubtopics, setSelectedSubtopics] = useState([]);
  const [availableSubtopics, setAvailableSubtopics] = useState([]);
  const [questions, setQuestions] = useState([]);
  const [loading, setLoading] = useState(false);
  const [error, setError] = useState(false);
  const [view, setView] = useState("home");
  const [filterDiff, setFilterDiff] = useState("Todas");
  const [filteredQs, setFilteredQs] = useState([]);
  const [idx, setIdx] = useState(0);
  const [selected, setSelected] = useState(null);
  const [revealed, setRevealed] = useState(false);
  const [answers, setAnswers] = useState({});
  const [times, setTimes] = useState({});
  const [curTime, setCurTime] = useState(0);
  const [timerOn, setTimerOn] = useState(false);
  const [favorites, setFavorites] = useState(new Set());
  const [notes, setNotes] = useState({});
  const [availableDisciplines, setAvailableDisciplines] = useState({});
  const [timerKey, setTimerKey] = useState(0);
  const [savingProgress, setSavingProgress] = useState(false);
  const [showProfile, setShowProfile] = useState(false);
  const [showRestartConfirm, setShowRestartConfirm] = useState(false);

  useEffect(() => { loadProgress(); }, []);

  useEffect(() => {
    if (selectedDisciplina) loadDisciplina(selectedDisciplina);
  }, [selectedDisciplina]);

  useEffect(() => {
    if (!disciplinasDoPeriodo.length) return;
    async function loadAvailability() {
      const availability = await fetchDisciplineAvailability(disciplinasDoPeriodo);
      setAvailableDisciplines(availability);
    }
    loadAvailability();
  }, [disciplinasDoPeriodo]);

  async function loadProgress() {
    if (!user) return;
    try {
      const ref = doc(db, "progress", user.uid);
      const snap = await getDoc(ref);
      if (snap.exists()) {
        const data = snap.data();
        if (data.answers) setAnswers(data.answers);
        if (data.favorites) setFavorites(new Set(data.favorites));
        if (data.notes) setNotes(data.notes);
      }
    } catch (err) {
      console.warn("Erro ao carregar progresso:", err);
    }
  }

  async function saveProgress(newAnswers, newFavorites, newNotes) {
    if (!user) return;
    try {
      setSavingProgress(true);
      await setDoc(doc(db, "progress", user.uid), {
        answers: newAnswers || answers,
        favorites: [...(newFavorites || favorites)],
        notes: newNotes || notes,
        updatedAt: new Date().toISOString(),
      });
    } catch (err) {
      console.warn("Erro ao salvar:", err);
    } finally {
      setSavingProgress(false);
    }
  }

  async function loadDisciplina(disciplina) {
    setLoading(true); setError(false); setQuestions([]);
    try {
      const qs = await fetchQuestionsByDisciplina(disciplina);
      setQuestions(qs);
      const subs = [...new Set(qs.map(q => q.subtopic))];
      setAvailableSubtopics(subs);
      setSelectedSubtopics(subs);
      setLoading(false);
    } catch {
      setError(true); setLoading(false);
    }
  }

  const q = filteredQs[idx];
  const correta = q?.correta;
  const alts = q?.alternativas || [];
  const totalAns = Object.keys(answers).length;
  const totalAcertos = Object.values(answers).filter(a => a.correct).length;
  const avgTime = totalAns > 0 ? Math.round(Object.values(times).reduce((a, b) => a + b, 0) / totalAns) : 0;
  const pct = totalAns > 0 ? Math.round((totalAcertos / totalAns) * 100) : 0;
  const totalErros = totalAns - totalAcertos;
  const selectedDisciplinaAnswers = Object.entries(answers)
    .filter(([, answer]) => answer.disciplina === selectedDisciplina);
  const selectedDisciplinaHistoryCount = selectedDisciplinaAnswers.length;

  const disciplinaStats = disciplinasDoPeriodo.reduce((acc, d) => {
    const qs = Object.values(answers).filter(a => a.disciplina === d);
    acc[d] = { total: qs.length, correct: qs.filter(a => a.correct).length };
    return acc;
  }, {});

  function getSessionQuestions(mode, answerSource = answers) {
    let qs = [...questions];
    if (selectedSubtopics.length > 0) qs = qs.filter((q) => selectedSubtopics.includes(q.subtopic));
    if (filterDiff !== "Todas") qs = qs.filter((q) => q.difficulty === filterDiff);
    if (mode === "continue") qs = qs.filter((q) => !answerSource[q.id]);
    if (mode === "errors") qs = qs.filter((q) => answerSource[q.id] && !answerSource[q.id].correct);
    if (mode === "favorites") qs = qs.filter((q) => favorites.has(q.id));
    return qs;
  }

  function startQuiz(mode, answerSource = answers) {
    const qs = getSessionQuestions(mode, answerSource);
    if (qs.length === 0) {
      const message = mode === "continue"
        ? "Você concluiu todas as questões com esses filtros. Você pode revisar erros ou reiniciar os estudos."
        : "Nenhuma questão encontrada com esses filtros!";
      alert(message);
      return;
    }
    const initialSelected = qs[0]?.questionType === "multiple" ? [] : null;
    setFilteredQs(qs);
    setIdx(0);
    setSelected(initialSelected);
    setRevealed(false);
    setTimerOn(true);
    setTimerKey((k) => k + 1);
    setView("quiz");
  }

  function requestStartSession() {
    if (selectedDisciplinaHistoryCount > 0) {
      setShowRestartConfirm(true);
      return;
    }
    startQuiz(null);
  }

  function continueStudy() {
    startQuiz("continue");
  }

  async function resetDisciplineProgressAndStart() {
    const removedQuestionIds = new Set(selectedDisciplinaAnswers.map(([questionId]) => questionId));
    const nextAnswers = Object.fromEntries(
      Object.entries(answers).filter(([, answer]) => answer.disciplina !== selectedDisciplina)
    );
    setAnswers(nextAnswers);
    setTimes((prev) => Object.fromEntries(
      Object.entries(prev).filter(([questionId]) => !removedQuestionIds.has(questionId))
    ));
    setShowRestartConfirm(false);
    await saveProgress(nextAnswers, null, null);
    startQuiz(null, nextAnswers);
  }

  function areAnswersEqual(selectedAnswers, correctAnswers) {
    const a = [...selectedAnswers].map((v) => String(v).toUpperCase()).sort();
    const b = [...correctAnswers].map((v) => String(v).toUpperCase()).sort();
    return a.length === b.length && a.every((value, index) => value === b[index]);
  }

  async function handleConfirm() {
    if (!selected || revealed) return;
    const selectedValues = Array.isArray(selected) ? selected : [selected];
    const correctValues = q.corretas || (correta ? [correta] : []);
    if (selectedValues.length === 0) return;

    const correct = areAnswersEqual(selectedValues, correctValues);
    const newAnswers = {
      ...answers,
      [q.id]: {
        selected: Array.isArray(selected) ? selected : selected,
        selectedAnswers: selectedValues,
        correct,
        disciplina: selectedDisciplina,
      },
    };

    setAnswers(newAnswers);
    setTimes((prev) => ({ ...prev, [q.id]: curTime }));
    setRevealed(true);
    setTimerOn(false);

    try {
      const isMultiple = q?.questionType === "multiple";
    const result = await saveAnswer({
        user,
        questionId: q?.id,
        selectedAnswer: !isMultiple && selectedValues.length === 1 ? selectedValues[0] : undefined,
        selectedAnswers: selectedValues,
        correctAnswer: !isMultiple ? correta?.toString().toUpperCase() : undefined,
        correctAnswers: correctValues,
      });
      if (!result) {
        console.error("saveAnswer não retornou sucesso ao salvar a resposta");
      }
    } catch (err) {
      console.error("saveAnswer lançou um erro:", err);
    }

    await saveProgress(newAnswers, null, null);
  }

  function handleNext() {
    if (idx < filteredQs.length - 1) {
      const nextQuestion = filteredQs[idx + 1];
      setIdx(idx + 1);
      setSelected(nextQuestion?.questionType === "multiple" ? [] : null);
      setRevealed(false);
      setTimerOn(true);
      setTimerKey((k) => k + 1);
      setCurTime(0);
    } else {
      setTimerOn(false);
      setView("result");
    }
  }

  async function toggleFavorite(id) {
    const n = new Set(favorites);
    n.has(id) ? n.delete(id) : n.add(id);
    setFavorites(n);
    await saveProgress(null, n, null);
  }

  function altStyle(id, isSelected, isCorrect) {
    const base = {
      border: "1px solid #e0e0e0",
      borderRadius: 16,
      padding: "16px",
      cursor: revealed ? "default" : "pointer",
      transition: "all 0.15s",
      display: "flex",
      alignItems: "flex-start",
      gap: 12,
      marginBottom: 12,
      background: "#fff",
      boxShadow: "0 6px 18px rgba(15, 110, 86, 0.06)",
    };

    if (!revealed) {
      if (isSelected) return { ...base, border: "1.5px solid #185fa5", background: "#e6f1fb" };
      return base;
    }

    if (isCorrect) return { ...base, border: "1.5px solid #0f6e56", background: "#eaf7f0" };
    if (isSelected) return { ...base, border: "1.5px solid #e24b4a", background: "#fff1f1" };
    return { ...base, border: "1px solid #d9d9d9", background: "#fafafa" };
  }

  function circleStyle(id, isSelected, isCorrect) {
    const base = {
      minWidth: 28,
      height: 28,
      borderRadius: "50%",
      border: "1px solid #e0e0e0",
      display: "flex",
      alignItems: "center",
      justifyContent: "center",
      fontSize: 12,
      fontWeight: 600,
      flexShrink: 0,
      color: "#555",
    };
    if (!revealed) {
      if (isSelected) return { ...base, border: "1.5px solid #185fa5", background: "#185fa5", color: "#fff" };
      return base;
    }
    if (isCorrect) return { ...base, border: "none", background: "#0f6e56", color: "#fff" };
    if (isSelected) return { ...base, border: "none", background: "#e24b4a", color: "#fff" };
    return { ...base, color: "#aaa" };
  }

  function cleanExplanationPrefix(text) {
    return String(text || "").replace(/^(CORRETA|CORRETO|INCORRETA|INCORRETO)\s*[:.]?\s*/i, "").trim();
  }

  const selectedAnswer = selected;
  const correctAnswers = q?.corretas || (correta ? [correta] : []);
  const hasSelection = Array.isArray(selected) ? selected.length > 0 : !!selected;
  const extraExplanationCards = [
    { key: "raciocinioCli", label: "Raciocínio clínico", value: q?.explicacao?.raciocinioCli, color: "#185fa5", bg: "#e6f1fb", textColor: "#0c447c" },
    { key: "dicaMemorizacao", label: "Memorização", value: q?.explicacao?.dicaMemorizacao, color: "#633806", bg: "#faeeda", textColor: "#412402" },
    { key: "pegadinha", label: "Pegadinha", value: q?.explicacao?.pegadinha, color: "#711b13", bg: "#fcebeb", textColor: "#501313" },
    { key: "diretriz", label: "Diretriz", value: q?.explicacao?.diretriz, color: "#185fa5", bg: "#e6f1fb", textColor: "#0c447c" },
  ].filter(card => card.value?.trim());
  const diffColor = { "fácil": "green", "médio": "amber", "difícil": "red" };

  if (view === "quiz" && !q) return null;

  if (view === "quiz") return (
    <div style={{ maxWidth: 660, margin: "0 auto", padding: "1.5rem 1rem", fontFamily: "Inter,sans-serif" }}>
      <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: 16 }}>
        <button onClick={() => { setTimerOn(false); setView("disciplina"); }} style={{ background: "none", border: "none", color: "#aaa", fontSize: 13, cursor: "pointer", padding: 0 }}>← Voltar</button>
        <div style={{ display: "flex", alignItems: "center", gap: 10 }}>
          {savingProgress && <span style={{ fontSize: 11, color: "#aaa" }}>Salvando...</span>}
          <Timer active={timerOn} onTick={setCurTime} resetKey={timerKey} />
        </div>
      </div>
      <div style={{ display: "flex", alignItems: "center", gap: 10, marginBottom: 16 }}>
        <div style={{ flex: 1, height: 5, background: "#e0e0e0", borderRadius: 999, overflow: "hidden" }}>
          <div style={{ height: "100%", width: `${((idx + 1) / filteredQs.length) * 100}%`, background: "#0f6e56", borderRadius: 999, transition: "width 0.4s ease" }} />
        </div>
        <span style={{ fontSize: 12, color: "#aaa" }}>{idx + 1}/{filteredQs.length}</span>
      </div>
      <div style={{ display: "flex", gap: 6, flexWrap: "wrap", alignItems: "center", marginBottom: 14 }}>
        <Badge label={q.topic} color="blue" />
        <Badge label={q.subtopic} color="gray" />
        <Badge label={q.difficulty} color={diffColor[q.difficulty]} />
        <button onClick={() => toggleFavorite(q.id)} style={{ marginLeft: "auto", background: "none", border: "none", fontSize: 20, cursor: "pointer", color: favorites.has(q.id) ? "#ef9f27" : "#ddd" }}>{favorites.has(q.id) ? "★" : "☆"}</button>
      </div>
      <div style={{ background: "#f9f9f9", borderRadius: 14, padding: "1.1rem 1.25rem", marginBottom: 18, lineHeight: 1.7, fontSize: 15 }}>{q.enunciado}</div>
      {q.imageUrl && (
        <div style={{ background: "#111", borderRadius: 16, padding: 10, marginBottom: 18, boxShadow: "0 10px 24px rgba(0,0,0,0.12)" }}>
          <img
            src={q.imageUrl}
            alt={`Imagem da questão ${idx + 1}`}
            style={{ width: "100%", display: "block", borderRadius: 10, objectFit: "contain", maxHeight: 520 }}
          />
        </div>
      )}
      <div style={{ marginBottom: 16 }}>
        {alts.map((alt) => {
          const rawJustification = q?.explicacao?.porAlternativa?.[alt.id];
          const justification = revealed ? cleanExplanationPrefix(rawJustification) : rawJustification?.trim();
          const isCorrect = correctAnswers.includes(alt.id);
          const isSelected = Array.isArray(selectedAnswer) ? selectedAnswer.includes(alt.id) : selectedAnswer === alt.id;
          const label = revealed ? (isCorrect ? "Resposta correta" : isSelected ? "Sua resposta" : null) : null;
          const explanationStyle = isCorrect
            ? { background: "#eaf7f0", border: "1px solid #c8e8d8", color: "#0f6e56" }
            : isSelected
              ? { background: "#fff1f1", border: "1px solid #f4d2d2", color: "#6f1f1f" }
              : { background: "#fff", border: "1px solid #e0e0e0", color: "#555" };
          return (
            <div
              key={alt.id}
              onClick={() => {
                if (revealed) return;
                if (q.questionType === "multiple") {
                  setSelected((prev) => {
                    const current = Array.isArray(prev) ? prev : [];
                    return current.includes(alt.id)
                      ? current.filter((item) => item !== alt.id)
                      : [...current, alt.id];
                  });
                } else {
                  setSelected(alt.id);
                }
              }}
              style={altStyle(alt.id, isSelected, isCorrect)}
            >
              <div style={{ display: "flex", alignItems: "flex-start", gap: 12, width: "100%" }}>
                <span style={circleStyle(alt.id, isSelected, isCorrect)}>{alt.id}</span>
                {q.questionType === "multiple" && (
                  <span style={{ fontSize: 12, color: isSelected ? "#0f6e56" : "#999", minWidth: 22, lineHeight: "28px" }}>
                    {isSelected ? "☑" : "☐"}
                  </span>
                )}
                <div style={{ flex: 1 }}>
                  <div style={{ fontSize: 14, lineHeight: 1.6, color: "#1a1a1a" }}>{alt.texto}</div>
                  {label && (
                    <div style={{ marginTop: 10, display: "inline-flex", alignItems: "center", padding: "6px 10px", borderRadius: 999, background: isCorrect ? "#e1f5ee" : "#ffe5e5", color: isCorrect ? "#0f6e56" : "#a32d2d", fontSize: 12, fontWeight: 700, letterSpacing: "0.01em" }}>
                      {label}
                    </div>
                  )}
                  {revealed && justification && (
                    <div style={{ marginTop: 12, padding: "12px 14px", borderRadius: 14, fontSize: 13, lineHeight: 1.7, ...explanationStyle }}>
                      {justification}
                    </div>
                  )}
                </div>
                {revealed && isCorrect && <span style={{ color: "#0f6e56", fontSize: 18 }}>✓</span>}
                {revealed && isSelected && !isCorrect && <span style={{ color: "#e24b4a", fontSize: 18 }}>✗</span>}
              </div>
            </div>
          );
        })}
      </div>
      {!revealed && (
        <button onClick={handleConfirm} disabled={!hasSelection} style={{ width: "100%", padding: 13, borderRadius: 12, fontWeight: 600, fontSize: 15, background: hasSelection ? "#0f6e56" : "#e0e0e0", color: hasSelection ? "#fff" : "#aaa", border: "none", cursor: hasSelection ? "pointer" : "not-allowed", marginBottom: 16, transition: "all 0.2s" }}>
          Confirmar resposta
        </button>
      )}
      {revealed && (
        <div>
          {q.explicacao.geral && (
            <InfoCard
              icon="💡"
              title="Explicação geral"
              subtitle="Reforce o fundamento por trás da resposta correta."
              borderColor="#185fa5"
              background="#eef5ff"
            >
              <p style={{ margin: 0, fontSize: 14, lineHeight: 1.75, color: "#333" }}>{q.explicacao.geral}</p>
            </InfoCard>
          )}
          {extraExplanationCards.length > 0 && (
            <div style={{ display: "grid", gridTemplateColumns: "repeat(auto-fit, minmax(240px, 1fr))", gap: 12, marginBottom: 16 }}>
              {extraExplanationCards.map(card => (
                <div key={card.key} style={{ background: card.bg, borderRadius: 16, border: `1px solid ${card.color}33`, padding: "14px 16px" }}>
                  <p style={{ fontSize: 11, fontWeight: 700, color: card.color, textTransform: "uppercase", letterSpacing: "0.06em", marginBottom: 8 }}>{card.label}</p>
                  <p style={{ fontSize: 13, lineHeight: 1.7, margin: 0, color: card.textColor }}>{card.value}</p>
                </div>
              ))}
            </div>
          )}
          <div style={{ display: "flex", gap: 10, justifyContent: "space-between" }}>
            <button onClick={() => { if (idx > 0) { setIdx(idx - 1); setSelected(null); setRevealed(false); setCurTime(0); } }} disabled={idx === 0} style={{ borderRadius: 10, padding: "10px 18px", fontSize: 14, cursor: "pointer" }}>← Anterior</button>
            <button onClick={handleNext} style={{ background: "#0f6e56", color: "#fff", border: "none", borderRadius: 10, padding: "10px 24px", fontWeight: 600, fontSize: 14, cursor: "pointer" }}>{idx < filteredQs.length - 1 ? "Próxima →" : "Ver resultado"}</button>
          </div>
        </div>
      )}

    </div>
  );

  if (view === "result") return (
    <div style={{ maxWidth: 660, margin: "0 auto", padding: "2rem 1rem", fontFamily: "Inter,sans-serif" }}>
      {showRestartConfirm && (
        <RestartStudyModal
          disciplina={selectedDisciplina}
          answeredCount={selectedDisciplinaHistoryCount}
          onCancel={() => setShowRestartConfirm(false)}
          onConfirm={resetDisciplineProgressAndStart}
        />
      )}
      <h2 style={{ fontSize: 22, fontWeight: 600, marginBottom: 4 }}>Sessão concluída! 🎉</h2>
      <p style={{ color: "#aaa", fontSize: 14, marginBottom: 24 }}>Veja seu desempenho</p>
      <div style={{ display: "flex", gap: 10, marginBottom: 24, flexWrap: "wrap" }}>
        <StatCard label="Total" value={filteredQs.length} />
        <StatCard label="Acertos" value={totalAcertos} color="#0f6e56" />
        <StatCard label="Erros" value={totalErros} color="#e24b4a" />
        <StatCard label="Aproveit." value={`${pct}%`} color={pct >= 70 ? "#0f6e56" : "#e24b4a"} />
        <StatCard label="Tempo médio" value={`${avgTime}s`} />
      </div>
      <div style={{ display: "flex", gap: 10, flexWrap: "wrap" }}>
        <button onClick={requestStartSession} style={{ background: "#0f6e56", color: "#fff", border: "none", borderRadius: 10, padding: "11px 22px", fontWeight: 600, fontSize: 14, cursor: "pointer" }}>Nova sessão</button>
        {selectedDisciplinaHistoryCount > 0 && <button onClick={continueStudy} style={{ borderRadius: 10, padding: "11px 18px", fontSize: 14, cursor: "pointer" }}>Continuar estudando</button>}
        <button onClick={() => setView("disciplina")} style={{ borderRadius: 10, padding: "11px 18px", fontSize: 14, cursor: "pointer" }}>Voltar</button>
        {totalErros > 0 && <button onClick={() => startQuiz("errors")} style={{ borderRadius: 10, padding: "11px 18px", fontSize: 14, color: "#a32d2d", cursor: "pointer" }}>Revisar {totalErros} erro(s)</button>}
      </div>
    </div>
  );

  if (view === "disciplina" && selectedDisciplina) return (
    <div style={{ maxWidth: 660, margin: "0 auto", padding: "1.5rem 1rem", fontFamily: "Inter,sans-serif" }}>
      {showRestartConfirm && (
        <RestartStudyModal
          disciplina={selectedDisciplina}
          answeredCount={selectedDisciplinaHistoryCount}
          onCancel={() => setShowRestartConfirm(false)}
          onConfirm={resetDisciplineProgressAndStart}
        />
      )}
      <button onClick={() => { setSelectedDisciplina(null); setView("home"); }} style={{ background: "none", border: "none", color: "#aaa", fontSize: 13, cursor: "pointer", padding: 0, marginBottom: 20 }}>← Disciplinas</button>
      <h2 style={{ fontSize: 20, fontWeight: 600, marginBottom: 4 }}>{selectedDisciplina}</h2>
      <p style={{ color: "#aaa", fontSize: 14, marginBottom: 20 }}>{questions.length} questões disponíveis</p>

      {loading ? (
        <div style={{ textAlign: "center", padding: "3rem" }}>
          <div style={{ fontSize: 32, marginBottom: 12 }}>⏳</div>
          <p style={{ color: "#aaa" }}>Carregando questões...</p>
        </div>
      ) : error ? (
        <div style={{ textAlign: "center", padding: "3rem" }}>
          <div style={{ fontSize: 32, marginBottom: 12 }}>⚠️</div>
          <p style={{ color: "#aaa", marginBottom: 16 }}>Conteúdo não encontrado ou indisponível</p>
          <button onClick={() => loadDisciplina(selectedDisciplina)} style={{ background: "#0f6e56", color: "#fff", border: "none", borderRadius: 10, padding: "10px 20px", cursor: "pointer" }}>Tentar novamente</button>
        </div>
      ) : (
        <>
          <div style={{ background: "#f9f9f9", borderRadius: 14, padding: "1rem 1.25rem", marginBottom: 20 }}>
            <p style={{ fontSize: 12, fontWeight: 600, color: "#aaa", textTransform: "uppercase", letterSpacing: "0.06em", marginBottom: 12 }}>Filtros</p>
            <div style={{ marginBottom: 14 }}>
              <label style={{ fontSize: 12, color: "#aaa", display: "block", marginBottom: 8 }}>Assuntos</label>
              <div style={{ display: "flex", flexWrap: "wrap", gap: 8 }}>
                <button
                  onClick={() => setSelectedSubtopics(selectedSubtopics.length === availableSubtopics.length ? [] : availableSubtopics)}
                  style={{ fontSize: 12, padding: "5px 12px", borderRadius: 999, border: "1px solid", borderColor: selectedSubtopics.length === availableSubtopics.length ? "#0f6e56" : "#e0e0e0", background: selectedSubtopics.length === availableSubtopics.length ? "#e1f5ee" : "#fff", color: selectedSubtopics.length === availableSubtopics.length ? "#0f6e56" : "#555", cursor: "pointer" }}>
                  Todos
                </button>
                {availableSubtopics.map(sub => (
                  <button key={sub}
                    onClick={() => setSelectedSubtopics(prev => prev.includes(sub) ? prev.filter(s => s !== sub) : [...prev, sub])}
                    style={{ fontSize: 12, padding: "5px 12px", borderRadius: 999, border: "1px solid", borderColor: selectedSubtopics.includes(sub) ? "#0f6e56" : "#e0e0e0", background: selectedSubtopics.includes(sub) ? "#e1f5ee" : "#fff", color: selectedSubtopics.includes(sub) ? "#0f6e56" : "#555", cursor: "pointer" }}>
                    {sub}
                  </button>
                ))}
              </div>
            </div>
            <div>
              <label style={{ fontSize: 12, color: "#aaa", display: "block", marginBottom: 8 }}>Dificuldade</label>
              <select value={filterDiff} onChange={e => setFilterDiff(e.target.value)} style={{ padding: "8px 12px", borderRadius: 8, border: "1px solid #e0e0e0", fontSize: 14 }}>
                {DIFFICULTIES.map(d => <option key={d}>{d}</option>)}
              </select>
            </div>
          </div>

          <div style={{ display: "flex", gap: 10, flexWrap: "wrap" }}>
            <button onClick={requestStartSession} style={{ background: "#0f6e56", color: "#fff", border: "none", borderRadius: 10, padding: "11px 22px", fontWeight: 600, fontSize: 14, cursor: "pointer" }}>Iniciar sessão</button>
            {selectedDisciplinaHistoryCount > 0 && (
              <button onClick={continueStudy} style={{ background: "#e6f1fb", color: "#185fa5", border: "1px solid #bdd9f0", borderRadius: 10, padding: "11px 18px", fontWeight: 600, fontSize: 14, cursor: "pointer" }}>
                Continuar estudando ({getSessionQuestions("continue").length})
              </button>
            )}
            {Object.values(answers).filter(a => a.disciplina === selectedDisciplina && !a.correct).length > 0 && (
              <button onClick={() => startQuiz("errors")} style={{ borderRadius: 10, padding: "11px 18px", fontSize: 14, border: "1px solid #f09595", color: "#a32d2d", cursor: "pointer" }}>
                Revisar erros ({Object.values(answers).filter(a => a.disciplina === selectedDisciplina && !a.correct).length})
              </button>
            )}
            {favorites.size > 0 && <button onClick={() => startQuiz("favorites")} style={{ borderRadius: 10, padding: "11px 18px", fontSize: 14, cursor: "pointer" }}>★ Favoritos</button>}
          </div>
        </>
      )}
    </div>
  );

  return (
    <div style={{ maxWidth: 660, margin: "0 auto", padding: "1.5rem 1rem", fontFamily: "Inter,sans-serif" }}>
      {showProfile && <ProfilePage onClose={() => setShowProfile(false)} />}

      <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: 24 }}>
        <div>
          <h1 style={{ fontSize: 22, fontWeight: 600, marginBottom: 2 }}>MedQuiz 🩺</h1>
          <p style={{ color: "#aaa", fontSize: 13 }}>{userData?.periodo ? `${userData.periodo}º Período` : ""} · Medicina</p>
        </div>
        <button onClick={() => setShowProfile(true)} style={{ display: "flex", alignItems: "center", gap: 8, background: "none", border: "1px solid #e0e0e0", borderRadius: 10, padding: "6px 10px", cursor: "pointer" }}>
          <img src={user?.photoURL} width={28} height={28} style={{ borderRadius: "50%" }} alt="" />
          <span style={{ fontSize: 12, color: "#555" }}>⚙️</span>
        </button>
      </div>

      <div style={{ display: "flex", gap: 10, marginBottom: 24, flexWrap: "wrap" }}>
        <StatCard label="Respondidas" value={totalAns} />
        <StatCard label="Acertos" value={totalAcertos} color="#0f6e56" />
        <StatCard label="Erros" value={totalErros} color="#e24b4a" />
        <StatCard label="Aproveitamento" value={`${pct}%`} color={pct >= 70 ? "#0f6e56" : pct >= 50 ? "#854f0b" : "#e24b4a"} />
      </div>

      <div style={{ marginBottom: 8 }}>
        <p style={{ fontSize: 12, fontWeight: 600, color: "#aaa", textTransform: "uppercase", letterSpacing: "0.06em", marginBottom: 14 }}>
          Disciplinas do {userData?.periodo || 5}º Período
        </p>
        <div style={{ display: "grid", gridTemplateColumns: "repeat(auto-fill, minmax(180px, 1fr))", gap: 10 }}>
          {disciplinasDoPeriodo.map((d) => {
            const hasContent = !!availableDisciplines[d];
            const stat = disciplinaStats[d];
            const progressPct = stat?.total > 0 ? Math.round((stat.correct / stat.total) * 100) : null;
            const hasProgress = hasContent && progressPct !== null;
            return (
              <button
                key={d}
                onClick={() => { if (hasContent) { setSelectedDisciplina(d); setView("disciplina"); } }}
                style={{
                  background: "#fff", borderRadius: 14, padding: "16px", border: "1px solid #e0e0e0",
                  textAlign: "left", cursor: hasContent ? "pointer" : "default",
                  opacity: hasContent ? 1 : 0.5, transition: "all 0.15s",
                }}>
                <p style={{ fontSize: 14, fontWeight: 500, margin: "0 0 12px", color: "#1a1a1a" }}>{d}</p>
                {hasContent ? (
                  hasProgress ? (
                    <div>
                      <div style={{ height: 6, background: "#edf3f7", borderRadius: 999, overflow: "hidden", marginBottom: 8 }}>
                        <div style={{ height: "100%", width: `${progressPct}%`, background: progressPct >= 70 ? "#1d9e75" : progressPct >= 50 ? "#ef9f27" : "#e24b4a", borderRadius: 999 }} />
                      </div>
                      <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", gap: 10 }}>
                        <span style={{ fontSize: 11, color: "#555" }}>{stat.total} respondidas</span>
                        <span style={{ fontSize: 11, color: progressPct >= 70 ? "#0f6e56" : progressPct >= 50 ? "#854f0b" : "#e24b4a" }}>{progressPct}%</span>
                      </div>
                    </div>
                  ) : (
                    <div style={{ display: "flex", flexDirection: "column", gap: 4 }}>
                      <span style={{ fontSize: 11, color: "#0f6e56", fontWeight: 600 }}>Conteúdo disponível</span>
                      <span style={{ fontSize: 11, color: "#777" }}>Comece a praticar</span>
                    </div>
                  )
                ) : (
                  <span style={{ fontSize: 11, color: "#aaa" }}>Em breve</span>
                )}
              </button>
            );
          })}
        </div>
      </div>
    </div>
  );
}
