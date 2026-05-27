import { initializeApp } from "firebase/app";
import { getAuth, GoogleAuthProvider } from "firebase/auth";
import { getFirestore } from "firebase/firestore";

const firebaseConfig = {
  apiKey: "AIzaSyCMrHPutXS7HPEsmVCNTM7Xf0yEDk-Nh08",
  authDomain: "medquiz-a04d9.firebaseapp.com",
  projectId: "medquiz-a04d9",
  storageBucket: "medquiz-a04d9.firebasestorage.app",
  messagingSenderId: "131319198239",
  appId: "1:131319198239:web:ef44fb2c2c5819ff0c1b2a"
};

const app = initializeApp(firebaseConfig);
export const auth = getAuth(app);
export const provider = new GoogleAuthProvider();
export const db = getFirestore(app);
export const ADMIN_EMAIL = "samileleite77@gmail.com";

export const PERIODOS = [
  { id: 1, label: "1º Período" },
  { id: 2, label: "2º Período" },
  { id: 3, label: "3º Período" },
  { id: 4, label: "4º Período" },
  { id: 5, label: "5º Período" },
  { id: 6, label: "6º Período" },
  { id: 7, label: "7º Período" },
  { id: 8, label: "8º Período" },
  { id: 9, label: "9º Período" },
  { id: 10, label: "10º Período" },
  { id: 11, label: "11º Período" },
  { id: 12, label: "12º Período" },
];

export const DISCIPLINAS_POR_PERIODO = {
  1: ["Anatomia", "Histologia", "Bioquímica", "Biofísica", "Citologia"],
  2: ["Fisiologia", "Anatomia II", "Bioquímica II", "Embriologia", "Genética"],
  3: ["Patologia Geral", "Microbiologia", "Imunologia", "Farmacologia", "Semiologia"],
  4: ["Patologia Especial", "Parasitologia", "Farmacologia II", "Semiologia II", "Saúde Coletiva"],
  5: ["Gastroenterologia", "Endocrinologia", "Dermatologia", "Pneumologia", "CASF", "Relação Médico-Paciente", "Anatomia Patológica", "Anestesia"],
  6: ["Cardiologia", "Nefrologia", "Reumatologia", "Hematologia", "Infectologia"],
  7: ["Neurologia", "Psiquiatria", "Oftalmologia", "Otorrinolaringologia", "Ortopedia"],
  8: ["Ginecologia", "Obstetrícia", "Pediatria", "Cirurgia Geral", "Urologia"],
  9: ["Medicina Intensiva", "Emergência", "Cirurgia Vascular", "Neurocirurgia", "Cirurgia Pediátrica"],
  10: ["Medicina de Família", "Saúde Mental", "Geriatria", "Medicina do Trabalho", "Epidemiologia"],
  11: ["Internato Clínica Médica", "Internato Cirurgia", "Internato Pediatria", "Internato GO"],
  12: ["Internato Medicina de Família", "Internato Urgência", "TCC", "Ética Médica"],
};

export const SHEET_IDS = {
  "Gastroenterologia": "1luwDPQpASADazaUxwDb0wksAaJuugcX7DWnjr2a94es",
};
