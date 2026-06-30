import { useState } from "react";
import { AuthProvider, useAuth, LoginPage, PendingPage } from "./Auth.jsx";
import App from "./App.jsx";
import AdminPanel from "./Admin.jsx";
import SelectPeriodo from "./SelectPeriodo.jsx";

function AppRouter() {
  const { user, userData, loading } = useAuth();
  const [adminMode, setAdminMode] = useState(true);

  if (loading) return (
    <div style={{minHeight:"100vh",display:"flex",alignItems:"center",justifyContent:"center",fontFamily:"Inter,sans-serif"}}>
      <div style={{textAlign:"center"}}>
        <div style={{fontSize:40,marginBottom:16}}>⏳</div>
        <p style={{color:"#aaa",fontSize:14}}>Carregando...</p>
      </div>
    </div>
  );

  if (!user) return <LoginPage />;

  if (userData?.role === "pending") return <PendingPage />;

  if (userData?.role === "blocked" || userData?.role === "revoked") return (
    <div style={{minHeight:"100vh",display:"flex",alignItems:"center",justifyContent:"center",fontFamily:"Inter,sans-serif",padding:"1rem"}}>
      <div style={{maxWidth:400,width:"100%",background:"#fff",borderRadius:20,padding:"2.5rem 2rem",boxShadow:"0 4px 24px rgba(0,0,0,0.08)",textAlign:"center"}}>
        <div style={{fontSize:48,marginBottom:16}}>🚫</div>
        <h2 style={{fontSize:20,fontWeight:600,marginBottom:8}}>Acesso bloqueado</h2>
        <p style={{color:"#aaa",fontSize:14,lineHeight:1.6}}>Seu acesso foi bloqueado. Entre em contato com a administração.</p>
      </div>
    </div>
  );

  if (!userData?.periodo) return <SelectPeriodo />;

  if (userData?.role === "admin") return (
    <div>
      <div style={{background:"#1a1a1a",padding:"8px 16px",display:"flex",alignItems:"center",gap:10,justifyContent:"center"}}>
        <button onClick={()=>setAdminMode(true)} style={{padding:"6px 16px",borderRadius:8,border:"none",background:adminMode?"#0f6e56":"transparent",color:adminMode?"#fff":"#aaa",fontSize:13,fontWeight:500,cursor:"pointer"}}>
          Painel Admin
        </button>
        <button onClick={()=>setAdminMode(false)} style={{padding:"6px 16px",borderRadius:8,border:"none",background:!adminMode?"#0f6e56":"transparent",color:!adminMode?"#fff":"#aaa",fontSize:13,fontWeight:500,cursor:"pointer"}}>
          Ir para o Quiz
        </button>
      </div>
      {adminMode ? <AdminPanel /> : <App />}
    </div>
  );

  return <App />;
}

export default function Root() {
  return (
    <AuthProvider>
      <AppRouter />
    </AuthProvider>
  );
}
