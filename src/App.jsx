import { useState, useEffect, useRef } from "react";
import { fetchQuestionsByDisciplina } from "./sheets.js";
import { useAuth } from "./Auth.jsx";
import { doc, setDoc, getDoc } from "firebase/firestore";
import { db } from "./firebase.js";
import { DISCIPLINAS_POR_PERIODO, DIFFICULTIES, SHEET_IDS } from "./constants.js";
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
  const [timerKey, setTimerKey] = useState(0);
  const [savingProgress, setSavingProgress] = useState(false);
  const [showProfile, setShowProfile] = useState(false);
  const [lastSaveStatus, setLastSaveStatus] = useState(null);

  useEffect(() => { loadProgress(); }, []);

  useEffect(() => {
    if (selectedDisciplina) loadDisciplina(selectedDisciplina);
  }, [selectedDisciplina]);

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

  const disciplinaStats = disciplinasDoPeriodo.reduce((acc, d) => {
    const qs = Object.values(answers).filter(a => a.disciplina === d);
    acc[d] = { total: qs.length, correct: qs.filter(a => a.correct).length };
    return acc;
  }, {});

  function startQuiz(mode) {
    let qs = [...questions];
    if (selectedSubtopics.length > 0) qs = qs.filter(q => selectedSubtopics.includes(q.subtopic));
    if (filterDiff !== "Todas") qs = qs.filter(q => q.difficulty === filterDiff);
    if (mode === "errors") qs = qs.filter(q => answers[q.id] && !answers[q.id].correct);
    if (mode === "favorites") qs = qs.filter(q => favorites.has(q.id));
    if (qs.length === 0) { alert("Nenhuma questão encontrada com esses filtros!"); return; }
    setFilteredQs(qs); setIdx(0); setSelected(null); setRevealed(false);
    setTimerOn(true); setTimerKey(k => k + 1); setView("quiz");
  }

  async function handleConfirm() {
    if (!selected || revealed) return;
    const correct = selected === correta;
    const newAnswers = { ...answers, [q.id]: { selected, correct, disciplina: selectedDisciplina } };
    setAnswers(newAnswers);
    setTimes(prev => ({ ...prev, [q.id]: curTime }));
    setRevealed(true); setTimerOn(false);

    // Log de diagnóstico: confirmar que a ação de responder foi disparada
    console.log("handleConfirm: preparando para salvar resposta", {
      userUid: user?.uid,
      questionId: q?.id,
      selected,
      correta,
      curTime,
    });

    setLastSaveStatus({ status: "saving", message: "Enviando resposta..." });
    try {
      const result = await saveAnswer({
        user,
        questionId: q?.id,
        selectedAnswer: selected,
        correctAnswer: correta?.toString().toUpperCase(),
      });
      if (result) {
        setLastSaveStatus({ status: "saved", message: "Resposta salva com sucesso" });
      } else {
        setLastSaveStatus({ status: "error", message: "Resposta não salva (ver console)" });
      }
    } catch (err) {
      console.error("saveAnswer lançou um erro:", err);
      setLastSaveStatus({ status: "error", message: String(err) });
    }

    await saveProgress(newAnswers, null, null);
  }

  function handleNext() {
    if (idx < filteredQs.length - 1) { setIdx(idx + 1); setSelected(null); setRevealed(false); setTimerOn(true); setTimerKey(k => k + 1); setCurTime(0); }
    else { setTimerOn(false); setView("result"); }
  }

  async function toggleFavorite(id) {
    const n = new Set(favorites);
    n.has(id) ? n.delete(id) : n.add(id);
    setFavorites(n);
    await saveProgress(null, n, null);
  }

  async function handleNote(id, value) {
    const newNotes = { ...notes, [id]: value };
    setNotes(newNotes);
    await saveProgress(null, null, newNotes);
  }

  function altStyle(id) {
    const base = { border: "1px solid #e0e0e0", borderRadius: 12, padding: "13px 16px", cursor: revealed ? "default" : "pointer", transition: "all 0.15s", display: "flex", alignItems: "flex-start", gap: 12, marginBottom: 8, background: "#fff" };
    if (!revealed) { if (selected === id) return { ...base, border: "1.5px solid #185fa5", background: "#e6f1fb" }; return base; }
    if (id === correta) return { ...base, border: "1.5px solid #0f6e56", background: "#e1f5ee" };
    if (id === selected && id !== correta) return { ...base, border: "1.5px solid #e24b4a", background: "#fcebeb" };
    return { ...base, opacity: 0.45 };
  }

  function circleStyle(id) {
    const base = { minWidth: 28, height: 28, borderRadius: "50%", border: "1px solid #e0e0e0", display: "flex", alignItems: "center", justifyContent: "center", fontSize: 12, fontWeight: 600, flexShrink: 0, color: "#555" };
    if (!revealed) { if (selected === id) return { ...base, border: "1.5px solid #185fa5", background: "#185fa5", color: "#fff" }; return base; }
    if (id === correta) return { ...base, border: "none", background: "#0f6e56", color: "#fff" };
    if (id === selected && id !== correta) return { ...base, border: "none", background: "#e24b4a", color: "#fff" };
    return { ...base, color: "#aaa" };
  }

  const answered = answers[q?.id];
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
      <div style={{ marginBottom: 16 }}>
        {alts.map(alt => (
          <div key={alt.id} onClick={() => !revealed && setSelected(alt.id)} style={altStyle(alt.id)}>
            <span style={circleStyle(alt.id)}>{alt.id}</span>
            <span style={{ fontSize: 14, lineHeight: 1.6, flex: 1 }}>{alt.texto}</span>
            {revealed && alt.id === correta && <span style={{ color: "#0f6e56", fontSize: 18 }}>✓</span>}
            {revealed && alt.id === selected && alt.id !== correta && <span style={{ color: "#e24b4a", fontSize: 18 }}>✗</span>}
          </div>
        ))}
      </div>
      {!revealed && (
        <button onClick={handleConfirm} disabled={!selected} style={{ width: "100%", padding: 13, borderRadius: 12, fontWeight: 600, fontSize: 15, background: selected ? "#0f6e56" : "#e0e0e0", color: selected ? "#fff" : "#aaa", border: "none", cursor: selected ? "pointer" : "not-allowed", marginBottom: 16, transition: "all 0.2s" }}>
          Confirmar resposta
        </button>
      )}
      {revealed && (
        <div>
          <div style={{ border: `1.5px solid ${answered?.correct ? "#0f6e56" : "#e24b4a"}`, borderRadius: 14, padding: "1rem 1.25rem", marginBottom: 16, background: answered?.correct ? "#e1f5ee" : "#fcebeb", display: "flex", alignItems: "flex-start", gap: 12 }}>
            <span style={{ fontSize: 22 }}>{answered?.correct ? "✅" : "❌"}</span>
            <div>
              <p style={{ fontWeight: 600, margin: 0, color: answered?.correct ? "#0f6e56" : "#a32d2d", fontSize: 15 }}>{answered?.correct ? "Resposta correta!" : "Resposta incorreta"}</p>
              <p style={{ margin: "4px 0 0", fontSize: 13, lineHeight: 1.6, color: answered?.correct ? "#085041" : "#711b13" }}>{q.explicacao.geral}</p>
            </div>
          </div>
          <div style={{ background: "#f9f9f9", borderRadius: 14, padding: "1rem 1.25rem", marginBottom: 12 }}>
            <p style={{ fontSize: 12, fontWeight: 600, color: "#aaa", textTransform: "uppercase", letterSpacing: "0.06em", marginBottom: 12 }}>Análise por alternativa</p>
            {Object.entries(q.explicacao.porAlternativa).map(([id, txt]) => txt ? (
              <div key={id} style={{ marginBottom: 10, paddingLeft: 10, borderLeft: `3px solid ${id === correta ? "#0f6e56" : "#e0e0e0"}` }}>
                <span style={{ fontSize: 12, fontWeight: 600, color: id === correta ? "#0f6e56" : "#aaa" }}>({id}) </span>
                <span style={{ fontSize: 13, lineHeight: 1.6 }}>{txt}</span>
              </div>
            ) : null)}
          </div>
          <div style={{ display: "grid", gridTemplateColumns: "1fr 1fr", gap: 10, marginBottom: 12 }}>
            <div style={{ background: "#f9f9f9", borderRadius: 12, padding: "12px 14px" }}>
              <p style={{ fontSize: 11, fontWeight: 600, color: "#aaa", textTransform: "uppercase", letterSpacing: "0.06em", marginBottom: 6 }}>Raciocínio clínico</p>
              <p style={{ fontSize: 13, lineHeight: 1.5, margin: 0 }}>{q.explicacao.raciocinioCli}</p>
            </div>
            <div style={{ background: "#faeeda", borderRadius: 12, padding: "12px 14px" }}>
              <p style={{ fontSize: 11, fontWeight: 600, color: "#633806", textTransform: "uppercase", letterSpacing: "0.06em", marginBottom: 6 }}>Memorização</p>
              <p style={{ fontSize: 13, lineHeight: 1.5, margin: 0, color: "#412402" }}>{q.explicacao.dicaMemorizacao}</p>
            </div>
          </div>
          <div style={{ display: "grid", gridTemplateColumns: "1fr 1fr", gap: 10, marginBottom: 16 }}>
            <div style={{ background: "#fcebeb", borderRadius: 12, padding: "12px 14px" }}>
              <p style={{ fontSize: 11, fontWeight: 600, color: "#711b13", textTransform: "uppercase", letterSpacing: "0.06em", marginBottom: 6 }}>Pegadinha</p>
              <p style={{ fontSize: 13, lineHeight: 1.5, margin: 0, color: "#501313" }}>{q.explicacao.pegadinha}</p>
            </div>
            <div style={{ background: "#e6f1fb", borderRadius: 12, padding: "12px 14px" }}>
              <p style={{ fontSize: 11, fontWeight: 600, color: "#185fa5", textTransform: "uppercase", letterSpacing: "0.06em", marginBottom: 6 }}>Diretriz</p>
              <p style={{ fontSize: 13, lineHeight: 1.5, margin: 0, color: "#0c447c" }}>{q.explicacao.diretriz}</p>
            </div>
          </div>
          <textarea placeholder="Sua anotação pessoal..." value={notes[q.id] || ""} onChange={e => handleNote(q.id, e.target.value)} style={{ width: "100%", marginBottom: 16, fontSize: 13, padding: "10px 12px", borderRadius: 10, border: "1px solid #e0e0e0", minHeight: 70, resize: "vertical" }} />
          <div style={{ display: "flex", gap: 10, justifyContent: "space-between" }}>
            <button onClick={() => { if (idx > 0) { setIdx(idx - 1); setSelected(null); setRevealed(false); setCurTime(0); } }} disabled={idx === 0} style={{ borderRadius: 10, padding: "10px 18px", fontSize: 14, cursor: "pointer" }}>← Anterior</button>
            <button onClick={handleNext} style={{ background: "#0f6e56", color: "#fff", border: "none", borderRadius: 10, padding: "10px 24px", fontWeight: 600, fontSize: 14, cursor: "pointer" }}>{idx < filteredQs.length - 1 ? "Próxima →" : "Ver resultado"}</button>
          </div>
        </div>
      )}

      {lastSaveStatus && (
        <div style={{ position: "fixed", right: 18, bottom: 18, zIndex: 9999 }}>
          <div style={{ padding: "10px 14px", borderRadius: 10, background: lastSaveStatus.status === "saved" ? "#e6ffef" : lastSaveStatus.status === "saving" ? "#fff7e6" : "#ffe6e6", color: "#111", boxShadow: "0 6px 20px rgba(0,0,0,0.08)", fontSize: 13 }}>
            <strong>{lastSaveStatus.status === "saved" ? "✓ Salvo" : lastSaveStatus.status === "saving" ? "Enviando" : "Erro"}</strong>
            <div style={{ fontSize: 12 }}>{lastSaveStatus.message}</div>
          </div>
        </div>
      )}
    </div>
  );

  if (view === "result") return (
    <div style={{ maxWidth: 660, margin: "0 auto", padding: "2rem 1rem", fontFamily: "Inter,sans-serif" }}>
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
        <button onClick={() => startQuiz(null)} style={{ background: "#0f6e56", color: "#fff", border: "none", borderRadius: 10, padding: "11px 22px", fontWeight: 600, fontSize: 14, cursor: "pointer" }}>Nova sessão</button>
        <button onClick={() => setView("disciplina")} style={{ borderRadius: 10, padding: "11px 18px", fontSize: 14, cursor: "pointer" }}>Voltar</button>
        {totalErros > 0 && <button onClick={() => startQuiz("errors")} style={{ borderRadius: 10, padding: "11px 18px", fontSize: 14, color: "#a32d2d", cursor: "pointer" }}>Revisar {totalErros} erro(s)</button>}
      </div>
    </div>
  );

  if (view === "disciplina" && selectedDisciplina) return (
    <div style={{ maxWidth: 660, margin: "0 auto", padding: "1.5rem 1rem", fontFamily: "Inter,sans-serif" }}>
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
          <p style={{ color: "#aaa", marginBottom: 16 }}>Planilha não encontrada ou vazia</p>
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
            <button onClick={() => startQuiz(null)} style={{ background: "#0f6e56", color: "#fff", border: "none", borderRadius: 10, padding: "11px 22px", fontWeight: 600, fontSize: 14, cursor: "pointer" }}>Iniciar sessão</button>
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
          {disciplinasDoPeriodo.map(d => {
            const hasSheet = !!SHEET_IDS[d];
            const stat = disciplinaStats[d];
            const dpct = stat?.total > 0 ? Math.round((stat.correct / stat.total) * 100) : null;
            return (
              <button
                key={d}
                onClick={() => { if (hasSheet) { setSelectedDisciplina(d); setView("disciplina"); } }}
                style={{
                  background: "#fff", borderRadius: 14, padding: "16px", border: "1px solid #e0e0e0",
                  textAlign: "left", cursor: hasSheet ? "pointer" : "default",
                  opacity: hasSheet ? 1 : 0.5, transition: "all 0.15s",
                  boxShadow: hasSheet ? "none" : "none",
                }}>
                <p style={{ fontSize: 14, fontWeight: 500, margin: "0 0 6px", color: "#1a1a1a" }}>{d}</p>
                {hasSheet ? (
                  dpct !== null ? (
                    <div>
                      <div style={{ height: 4, background: "#e0e0e0", borderRadius: 999, overflow: "hidden", marginBottom: 4 }}>
                        <div style={{ height: "100%", width: `${dpct}%`, background: dpct >= 70 ? "#1d9e75" : dpct >= 50 ? "#ef9f27" : "#e24b4a", borderRadius: 999 }} />
                      </div>
                      <span style={{ fontSize: 11, color: "#aaa" }}>{stat.correct}/{stat.total} ({dpct}%)</span>
                    </div>
                  ) : <span style={{ fontSize: 11, color: "#0f6e56" }}>Disponível →</span>
                ) : <span style={{ fontSize: 11, color: "#aaa" }}>Em breve</span>}
              </button>
            );
          })}
        </div>
      </div>

      <div style={{ marginTop: 24, background: "#f0f9ff", borderRadius: 14, padding: "1rem 1.25rem", border: "1px solid #bfdbfe" }}>
        <p style={{ fontSize: 12, fontWeight: 600, color: "#185fa5", marginBottom: 6 }}>Como adicionar questões</p>
        <p style={{ fontSize: 13, color: "#1e40af", lineHeight: 1.6, margin: 0 }}>
          Crie uma planilha Google para cada disciplina. Cada aba = um assunto. Adicione o ID da planilha no arquivo <strong>constants.js</strong>.
        </p>
      </div>
    </div>
  );
}
