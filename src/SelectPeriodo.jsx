import { useState } from "react";
import { doc, updateDoc } from "firebase/firestore";
import { db } from "./firebase.js";
import { useAuth } from "./Auth.jsx";
import { PERIODOS } from "./constants.js";

export default function SelectPeriodo() {
  const { user, refreshUserData } = useAuth();
  const [selected, setSelected] = useState(null);
  const [saving, setSaving] = useState(false);
  const [error, setError] = useState("");

  async function handleConfirm() {
    if (!selected || !user?.uid) return;
    setSaving(true);
    setError("");

    try {
      await updateDoc(doc(db, "users", user.uid), { periodo: selected });
      await refreshUserData(user.uid);
    } catch (err) {
      console.error("Erro ao salvar período:", err);
      setError("Não foi possível salvar seu período. Tente novamente.");
    } finally {
      setSaving(false);
    }
  }

  return (
    <div style={{minHeight:"100vh",display:"flex",alignItems:"center",justifyContent:"center",background:"#f9f9f9",fontFamily:"Inter,sans-serif",padding:"1rem"}}>
      <div style={{maxWidth:480,width:"100%",background:"#fff",borderRadius:20,padding:"2.5rem 2rem",boxShadow:"0 4px 24px rgba(0,0,0,0.08)"}}>
        <div style={{textAlign:"center",marginBottom:28}}>
          <div style={{fontSize:44,marginBottom:12}}>🎓</div>
          <h1 style={{fontSize:22,fontWeight:700,marginBottom:8}}>Bem-vindo ao MedQuiz!</h1>
          <p style={{color:"#aaa",fontSize:14,lineHeight:1.6}}>Qual período você está cursando atualmente?</p>
        </div>
        <div style={{display:"grid",gridTemplateColumns:"1fr 1fr 1fr",gap:10,marginBottom:24}}>
          {PERIODOS.map(p => (
            <button key={p.id} onClick={() => setSelected(p.id)} style={{
              padding:"14px 8px",borderRadius:12,border:"1.5px solid",
              borderColor:selected===p.id?"#0f6e56":"#e0e0e0",
              background:selected===p.id?"#e1f5ee":"#fff",
              color:selected===p.id?"#0f6e56":"#555",
              fontWeight:selected===p.id?600:400,
              fontSize:14,cursor:"pointer",transition:"all 0.15s",
            }}>
              {p.label}
            </button>
          ))}
        </div>
        <button onClick={handleConfirm} disabled={!selected||saving} style={{
          width:"100%",padding:13,borderRadius:12,border:"none",
          background:selected?"#0f6e56":"#e0e0e0",
          color:selected?"#fff":"#aaa",
          fontWeight:600,fontSize:15,cursor:selected?"pointer":"not-allowed",
          transition:"all 0.2s"
        }}>
          {saving?"Salvando...":"Confirmar e entrar"}
        </button>
        {error ? <p style={{marginTop:12,color:"#c2410c",fontSize:13,textAlign:"center"}}>{error}</p> : null}
      </div>
    </div>
  );
}
