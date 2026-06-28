import { useState, useEffect } from "react";
import { collection, getDocs, updateDoc, doc } from "firebase/firestore";
import { db } from "./firebase.js";
import { useAuth } from "./Auth.jsx";
import AdminQuestions from "./AdminQuestions.jsx";

export default function AdminPanel() {
  const { logout, user } = useAuth();
  const [users, setUsers] = useState([]);
  const [loading, setLoading] = useState(true);
  const [tab, setTab] = useState("todos");
  const [section, setSection] = useState("users");

  useEffect(() => {
    loadUsers();
  }, []);

  async function loadUsers() {
    setLoading(true);
    const snap = await getDocs(collection(db, "users"));
    const list = snap.docs.map(d => ({ id: d.id, ...d.data() }));
    setUsers(list);
    setLoading(false);
  }

  async function updateRole(userId, role) {
    await updateDoc(doc(db, "users", userId), { role });
    setUsers(prev => prev.map(u => u.id === userId ? { ...u, role } : u));
  }

  const pending = users.filter(u => u.role === "pending");
  const shown = tab === "pending" ? pending : users;

  const badgeStyle = (role) => {
    if (role === "admin") return { bg: "#e6f1fb", color: "#185fa5", label: "Admin" };
    if (role === "active") return { bg: "#e1f5ee", color: "#0f6e56", label: "Ativo" };
    if (role === "blocked") return { bg: "#fcebeb", color: "#a32d2d", label: "Bloqueado" };
    return { bg: "#faeeda", color: "#854f0b", label: "Pendente" };
  };

  return (
    <div style={{ maxWidth: 700, margin: "0 auto", padding: "1.5rem 1rem", fontFamily: "Inter,sans-serif" }}>
      <div style={{ display: "flex", justifyContent: "space-between", alignItems: "center", marginBottom: 24 }}>
        <div style={{ display: "flex", alignItems: "center", gap: 10 }}>
          <img src={user?.photoURL} width={36} height={36} style={{ borderRadius: "50%" }} alt="" />
          <div>
            <p style={{ fontSize: 14, fontWeight: 600, margin: 0 }}>{user?.displayName}</p>
            <span style={{ fontSize: 11, padding: "2px 7px", borderRadius: 999, background: "#e6f1fb", color: "#185fa5", fontWeight: 500 }}>Admin</span>
          </div>
        </div>
        <button onClick={logout} style={{ fontSize: 13, padding: "7px 14px", borderRadius: 8, border: "1px solid #e0e0e0", cursor: "pointer", color: "#aaa", background: "#fff" }}>Sair</button>
      </div>

      <div style={{ display: "flex", gap: 10, marginBottom: 20 }}>
        <button onClick={() => setSection("users")} style={{ padding: "8px 16px", borderRadius: 10, border: "none", background: section === "users" ? "#0f6e56" : "#f1f1f1", color: section === "users" ? "#fff" : "#555", fontWeight: 500, fontSize: 13, cursor: "pointer" }}>
          Usuários
        </button>
        <button onClick={() => setSection("questions")} style={{ padding: "8px 16px", borderRadius: 10, border: "none", background: section === "questions" ? "#0f6e56" : "#f1f1f1", color: section === "questions" ? "#fff" : "#555", fontWeight: 500, fontSize: 13, cursor: "pointer" }}>
          Questões
        </button>
      </div>

      {section === "questions" ? (
        <AdminQuestions />
      ) : (
        <>
      <div style={{ display: "flex", gap: 10, marginBottom: 20 }}>
        <button onClick={() => setTab("todos")} style={{ padding: "8px 16px", borderRadius: 10, border: "none", background: tab === "todos" ? "#0f6e56" : "#f1f1f1", color: tab === "todos" ? "#fff" : "#555", fontWeight: 500, fontSize: 13, cursor: "pointer" }}>
          Todos ({users.length})
        </button>
        <button onClick={() => setTab("pending")} style={{ padding: "8px 16px", borderRadius: 10, border: "none", background: tab === "pending" ? "#0f6e56" : "#f1f1f1", color: tab === "pending" ? "#fff" : "#555", fontWeight: 500, fontSize: 13, cursor: "pointer" }}>
          Pendentes ({pending.length})
        </button>
      </div>

      {pending.length > 0 && tab === "todos" && (
        <div style={{ background: "#faeeda", borderRadius: 12, padding: "12px 16px", marginBottom: 16, border: "1px solid #f5c97a" }}>
          <p style={{ fontSize: 13, color: "#854f0b", margin: 0, fontWeight: 500 }}>{pending.length} usuário(s) aguardando liberação</p>
        </div>
      )}

      {loading ? (
        <p style={{ color: "#aaa", textAlign: "center", padding: "2rem" }}>Carregando...</p>
      ) : shown.length === 0 ? (
        <p style={{ color: "#aaa", textAlign: "center", padding: "2rem" }}>Nenhum usuário encontrado</p>
      ) : (
        shown.map(u => {
          const b = badgeStyle(u.role);
          return (
            <div key={u.id} style={{ background: "#fff", borderRadius: 12, padding: "14px 16px", marginBottom: 10, border: "1px solid #e0e0e0", display: "flex", alignItems: "center", gap: 12, flexWrap: "wrap" }}>
              <img src={u.photo || ""} width={36} height={36} style={{ borderRadius: "50%", flexShrink: 0 }} alt="" />
              <div style={{ flex: 1, minWidth: 150 }}>
                <p style={{ fontSize: 14, fontWeight: 500, margin: 0 }}>{u.name}</p>
                <p style={{ fontSize: 12, color: "#aaa", margin: 0 }}>{u.email}</p>
              </div>
              <span style={{ fontSize: 11, padding: "3px 8px", borderRadius: 999, background: b.bg, color: b.color, fontWeight: 500 }}>{b.label}</span>
              {u.role !== "admin" && (
                <div style={{ display: "flex", gap: 6, flexWrap: "wrap" }}>
                  {u.role !== "active" && (
                    <button onClick={() => updateRole(u.id, "active")} style={{ fontSize: 12, padding: "5px 10px", borderRadius: 8, border: "none", background: "#0f6e56", color: "#fff", cursor: "pointer" }}>Liberar</button>
                  )}
                  {u.role !== "blocked" && (
                    <button onClick={() => updateRole(u.id, "blocked")} style={{ fontSize: 12, padding: "5px 10px", borderRadius: 8, border: "none", background: "#e24b4a", color: "#fff", cursor: "pointer" }}>Bloquear</button>
                  )}
                  {u.role !== "pending" && (
                    <button onClick={() => updateRole(u.id, "pending")} style={{ fontSize: 12, padding: "5px 10px", borderRadius: 8, border: "1px solid #e0e0e0", background: "#fff", color: "#aaa", cursor: "pointer" }}>Pendente</button>
                  )}
                </div>
              )}
            </div>
          );
        })
      )}
        </>
      )}
    </div>
  );
}
