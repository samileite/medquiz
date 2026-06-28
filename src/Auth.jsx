import { useState, useEffect, createContext, useContext } from "react";
import { signInWithPopup, signOut, onAuthStateChanged } from "firebase/auth";
import { doc, getDoc, setDoc } from "firebase/firestore";
import { auth, provider, db, ADMIN_EMAIL } from "./firebase.js";

const AuthContext = createContext(null);

export function useAuth() {
  return useContext(AuthContext);
}

export function AuthProvider({ children }) {
  const [user, setUser] = useState(null);
  const [userData, setUserData] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    const unsub = onAuthStateChanged(auth, async (firebaseUser) => {
      if (firebaseUser) {
        const ref = doc(db, "users", firebaseUser.uid);
        const snap = await getDoc(ref);
        if (!snap.exists()) {
          const isAdmin = firebaseUser.email === ADMIN_EMAIL;
          await setDoc(ref, {
            name: firebaseUser.displayName,
            email: firebaseUser.email,
            photo: firebaseUser.photoURL,
            role: isAdmin ? "admin" : "pending",
            createdAt: new Date().toISOString(),
          });
          setUserData({ role: isAdmin ? "admin" : "pending", email: firebaseUser.email, name: firebaseUser.displayName, photo: firebaseUser.photoURL });
        } else {
          setUserData(snap.data());
        }
        setUser(firebaseUser);
      } else {
        setUser(null);
        setUserData(null);
      }
      setLoading(false);
    });
    return unsub;
  }, []);

  async function login() {
    await signInWithPopup(auth, provider);
  }

  async function logout() {
    await signOut(auth);
  }

  return (
    <AuthContext.Provider value={{ user, userData, loading, login, logout }}>
      {children}
    </AuthContext.Provider>
  );
}

export function LoginPage() {
  const { login } = useAuth();
  return (
    <div style={{minHeight:"100vh",display:"flex",alignItems:"center",justifyContent:"center",background:"#f9f9f9",fontFamily:"Inter,sans-serif",padding:"1rem"}}>
      <div style={{maxWidth:400,width:"100%",background:"#fff",borderRadius:20,padding:"2.5rem 2rem",boxShadow:"0 4px 24px rgba(0,0,0,0.08)",textAlign:"center"}}>
        <div style={{fontSize:48,marginBottom:16}}>🩺</div>
        <h1 style={{fontSize:24,fontWeight:700,marginBottom:8,color:"#1a1a1a"}}>MedQuiz</h1>
        <p style={{color:"#aaa",fontSize:14,marginBottom:32,lineHeight:1.6}}>Plataforma de questões para Residência Médica</p>
        <button onClick={login} style={{width:"100%",padding:"13px 20px",borderRadius:12,border:"1px solid #e0e0e0",background:"#fff",fontSize:15,fontWeight:500,cursor:"pointer",display:"flex",alignItems:"center",justifyContent:"center",gap:10,transition:"all 0.15s"}}>
          <img src="https://www.google.com/favicon.ico" width={18} height={18} alt="Google"/>
          Entrar com Google
        </button>
        <p style={{marginTop:24,fontSize:12,color:"#ccc"}}>Após o login seu acesso será analisado</p>
      </div>
    </div>
  );
}

export function PendingPage() {
  const { logout, user } = useAuth();
  return (
    <div style={{minHeight:"100vh",display:"flex",alignItems:"center",justifyContent:"center",background:"#f9f9f9",fontFamily:"Inter,sans-serif",padding:"1rem"}}>
      <div style={{maxWidth:400,width:"100%",background:"#fff",borderRadius:20,padding:"2.5rem 2rem",boxShadow:"0 4px 24px rgba(0,0,0,0.08)",textAlign:"center"}}>
        <div style={{fontSize:48,marginBottom:16}}>⏳</div>
        <h2 style={{fontSize:20,fontWeight:600,marginBottom:8}}>Aguardando liberação</h2>
        <p style={{color:"#666",fontSize:14,lineHeight:1.6,marginBottom:8}}>Olá, <strong>{user?.displayName}</strong>!</p>
        <p style={{color:"#aaa",fontSize:14,lineHeight:1.6,marginBottom:32}}>Seu cadastro foi recebido. Após a confirmação do pagamento seu acesso será liberado pela administração.</p>
        <div style={{background:"#f0f9ff",borderRadius:12,padding:"1rem",marginBottom:24,border:"1px solid #bfdbfe"}}>
          <p style={{fontSize:13,color:"#185fa5",margin:0}}>Entre em contato para liberar seu acesso após o pagamento.</p>
        </div>
        <button onClick={logout} style={{width:"100%",padding:"11px",borderRadius:10,border:"1px solid #e0e0e0",background:"#fff",fontSize:14,cursor:"pointer",color:"#aaa"}}>Sair</button>
      </div>
    </div>
  );
}
