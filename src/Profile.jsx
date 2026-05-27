import { useState } from "react";
import { doc, updateDoc } from "firebase/firestore";
import { db } from "./firebase.js";
import { useAuth } from "./Auth.jsx";
import { PERIODOS } from "./constants.js";

export default function ProfilePage({ onClose }) {
  const { user, userData, logout } = useAuth();
  const [periodo, setPeriodo] = useState(userData?.periodo || 5);
  const [saving, setSaving] = useState(false);
  const [saved, setSaved] = useState(false);

  async function handleSave() {
    setSaving(true);
    await updateDoc(doc(db, "users", user.uid), { periodo });
    setSaving(false);
    setSaved(true);
    setTimeout(() => { setSaved(false); onClose(); }, 1000);
  }

  return (
    <div style={{ position: "fixed", top: 0, left: 0, right: 0, bottom: 0, background: "rgba(0,0,0,0.5)", display: "flex", alignItems: "center", justifyContent: "center", zIndex: 1000, padding: "1rem" }}>
      <div style={{ background: "#fff", borderRadius: 20, padding: "2rem", maxWidth: 400, width: "100%", boxShadow: "0 8px 32px rgba(0,0,0,0.15)" }}>
        <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: 24 }}>
          <h2 style={{ fontSize: 18, fontWeight: 600, margin: 0 }}>Configurações do perfil</h2>
          <button onClick={onClose} style={{ background: "none", border: "none", fontSize: 20, cursor: "pointer", color: "#aaa" }}>✕</button>
        </div>

        <div style={{ display: "flex", alignItems: "center", gap: 12, marginBottom: 24, background: "#f9f9f9", borderRadius: 12, padding: "12px 16px" }}>
          <img src={user?.photoURL} width={48} height={48} style={{ borderRadius: "50%" }} alt="" />
          <div>
            <p style={{ fontSize: 15, fontWeight: 600, margin: 0 }}>{user?.displayName}</p>
            <p style={{ fontSize: 13, color: "#aaa", margin: 0 }}>{user?.email}</p>
          </div>
        </div>

        <div style={{ marginBottom: 20 }}>
          <label style={{ fontSize: 13, fontWeight: 500, color: "#555", display: "block", marginBottom: 8 }}>Período atual</label>
          <select
            value={periodo}
            onChange={e => setPeriodo(Number(e.target.value))}
            style={{ width: "100%", padding: "10px 12px", borderRadius: 10, border: "1px solid #e0e0e0", fontSize: 14 }}>
            {PERIODOS.map(p => (
              <option key={p.id} value={p.id}>{p.label}</option>
            ))}
          </select>
        </div>

        <div style={{ display: "flex", gap: 10 }}>
          <button
            onClick={handleSave}
            disabled={saving}
            style={{ flex: 1, padding: "11px", borderRadius: 10, border: "none", background: "#0f6e56", color: "#fff", fontWeight: 600, fontSize: 14, cursor: "pointer" }}>
            {saving ? "Salvando..." : saved ? "Salvo! ✓" : "Salvar"}
          </button>
          <button
            onClick={logout}
            style={{ padding: "11px 18px", borderRadius: 10, border: "1px solid #e0e0e0", background: "#fff", color: "#e24b4a", fontSize: 14, cursor: "pointer" }}>
            Sair
          </button>
        </div>
      </div>
    </div>
  );
}
