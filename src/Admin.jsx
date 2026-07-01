import { useCallback, useState, useEffect } from "react";
import { useAuth } from "./Auth.jsx";
import AdminQuestionImport from "./AdminQuestionImport.jsx";
import AdminQuestions from "./AdminQuestions.jsx";
import { getAccessStateLabel, isAccessRestricted } from "./utils/access.js";

export default function AdminPanel() {
  const { logout, user } = useAuth();
  const [users, setUsers] = useState([]);
  const [loading, setLoading] = useState(true);
  const [usersError, setUsersError] = useState("");
  const [tab, setTab] = useState("todos");
  const [section, setSection] = useState("users");

  const loadUsers = useCallback(async () => {
    try {
      setLoading(true);
      setUsersError("");
      const token = await user.getIdToken();
      const response = await fetch("/api/admin-users", {
        headers: { Authorization: `Bearer ${token}` },
      });
      const result = await response.json().catch(() => null);
      if (!response.ok) {
        throw new Error(result?.error || "Não foi possível carregar usuários.");
      }
      setUsers(result?.users || []);
    } catch (err) {
      console.warn("Erro ao carregar usuários:", err);
      setUsersError(err?.message || "Não foi possível carregar usuários.");
    } finally {
      setLoading(false);
    }
  }, [user]);

  useEffect(() => {
    loadUsers();
  }, [loadUsers]);

  async function updateRole(userId, role) {
    try {
      setUsersError("");
      const token = await user.getIdToken();
      const response = await fetch("/api/admin-users", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
        body: JSON.stringify({ action: "updateRole", userId, role }),
      });
      const result = await response.json().catch(() => null);
      if (!response.ok) {
        throw new Error(result?.error || "Não foi possível atualizar usuário.");
      }
      setUsers(prev => prev.map(u => u.id === userId ? { ...u, role } : u));
    } catch (err) {
      console.warn("Erro ao atualizar usuário:", err);
      setUsersError(err?.message || "Não foi possível atualizar usuário.");
      throw err;
    }
  }

  const [confirm, setConfirm] = useState(null);

  async function authorizeUser(userId, userEmail) {
    await updateRole(userId, "active");
    console.info("Usuário autorizado:", userEmail);
  }

  async function revokeUser(userId, userEmail) {
    await updateRole(userId, "revoked");
    console.info("Acesso revogado:", userEmail);
  }

  async function removeUser(userId, userEmail) {
    try {
      const token = await user.getIdToken();
      const response = await fetch("/api/admin-users", {
        method: "POST",
        headers: {
          "Content-Type": "application/json",
          Authorization: `Bearer ${token}`,
        },
        body: JSON.stringify({ action: "delete", userId }),
      });
      const result = await response.json().catch(() => null);
      if (!response.ok) {
        throw new Error(result?.error || "Não foi possível remover usuário.");
      }
      setUsers(prev => prev.filter(u => u.id !== userId));
      console.info("Usuário removido:", userEmail);
    } catch (err) {
      console.warn("Erro ao remover usuário:", err);
      setUsersError(err?.message || "Não foi possível remover usuário.");
    }
  }

  const pending = users.filter(u => !u.role || u.role === "pending");
  const shown = tab === "pending" ? pending : users;

  const badgeStyle = (role) => {
    const label = getAccessStateLabel(role);
    if (role === "admin") return { bg: "#e6f1fb", color: "#185fa5", label };
    if (role === "active") return { bg: "#e1f5ee", color: "#0f6e56", label };
    if (isAccessRestricted(role)) return { bg: "#fcebeb", color: "#a32d2d", label };
    return { bg: "#faeeda", color: "#854f0b", label };
  };

  const authorizeButtonLabel = (role) => {
    if (!role || role === "pending") return "Autorizar pagamento";
    return "Ativar";
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
        <button onClick={() => setSection("import")} style={{ padding: "8px 16px", borderRadius: 10, border: "none", background: section === "import" ? "#0f6e56" : "#f1f1f1", color: section === "import" ? "#fff" : "#555", fontWeight: 500, fontSize: 13, cursor: "pointer" }}>
          Importar
        </button>
      </div>

      {section === "import" ? (
        <AdminQuestionImport />
      ) : section === "questions" ? (
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

      {usersError && (
        <div style={{ background: "#fcebeb", borderRadius: 12, padding: "12px 16px", marginBottom: 16, border: "1px solid #f2c4c4" }}>
          <p style={{ fontSize: 13, color: "#a32d2d", margin: 0, fontWeight: 500 }}>{usersError}</p>
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
                    <button onClick={() => authorizeUser(u.id, u.email)} style={{ fontSize: 12, padding: "5px 10px", borderRadius: 8, border: "none", background: "#0f6e56", color: "#fff", cursor: "pointer" }}>{authorizeButtonLabel(u.role)}</button>
                  )}
                  {u.role !== "revoked" && (
                    <button onClick={() => setConfirm({ type: 'revoke', id: u.id, email: u.email, name: u.name })} style={{ fontSize: 12, padding: "5px 10px", borderRadius: 8, border: "none", background: "#e24b4a", color: "#fff", cursor: "pointer" }}>Revogar acesso</button>
                  )}
                  {u.role !== "blocked" && (
                    <button onClick={() => setConfirm({ type: 'block', id: u.id, email: u.email, name: u.name })} style={{ fontSize: 12, padding: "5px 10px", borderRadius: 8, border: "1px solid #e0e0e0", background: "#fff", color: "#aaa", cursor: "pointer" }}>Bloquear</button>
                  )}
                  <button onClick={() => setConfirm({ type: 'remove', id: u.id, email: u.email, name: u.name })} style={{ fontSize: 12, padding: "5px 10px", borderRadius: 8, border: "1px solid #f3c2c2", background: "#fff", color: "#a32d2d", cursor: "pointer" }}>Remover</button>
                  {u.role !== "pending" && (
                    <button onClick={() => updateRole(u.id, "pending")} style={{ fontSize: 12, padding: "5px 10px", borderRadius: 8, border: "1px solid #e0e0e0", background: "#fff", color: "#aaa", cursor: "pointer" }}>Pendente</button>
                  )}
                </div>
              )}
            </div>
          );
        })
      )}
      {confirm && (
        <div style={{ position: "fixed", inset: 0, zIndex: 30, background: "rgba(0,0,0,0.36)", display: "grid", placeItems: "center" }}>
          <div style={{ width: "100%", maxWidth: 520, background: "#fff", borderRadius: 12, padding: 20 }}>
            <h3 style={{ margin: 0, marginBottom: 8 }}>{confirm.type === 'remove' ? 'Remover usuário' : confirm.type === 'revoke' ? 'Revogar acesso' : 'Confirmar ação'}</h3>
            <p style={{ marginTop: 8 }}>{confirm.type === 'remove' ? `Tem certeza que deseja remover ${confirm.name || confirm.email}? Isso apagará os dados do usuário.` : confirm.type === 'revoke' ? `Revogar acesso de ${confirm.name || confirm.email}?` : `Executar ação ${confirm.type} para ${confirm.name || confirm.email}?`}</p>
            <div style={{ display: 'flex', gap: 10, justifyContent: 'flex-end', marginTop: 16 }}>
              <button onClick={() => setConfirm(null)} style={{ padding: '8px 12px', borderRadius: 8, border: '1px solid #e0e0e0', background: '#fff', cursor: 'pointer' }}>Cancelar</button>
              <button onClick={async () => {
                if (confirm.type === 'revoke') await revokeUser(confirm.id, confirm.email);
                if (confirm.type === 'block') await updateRole(confirm.id, 'blocked');
                if (confirm.type === 'remove') await removeUser(confirm.id, confirm.email);
                setConfirm(null);
              }} style={{ padding: '8px 12px', borderRadius: 8, border: 'none', background: '#e24b4a', color: '#fff', cursor: 'pointer' }}>{confirm.type === 'remove' ? 'Remover' : confirm.type === 'revoke' ? 'Revogar' : 'Confirmar'}</button>
            </div>
          </div>
        </div>
      )}
        </>
      )}
    </div>
  );
}
