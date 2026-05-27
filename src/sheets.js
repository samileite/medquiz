import { SHEET_IDS } from "./constants.js";

async function fetchSheetData(sheetId, sheetName) {
  const url = `https://docs.google.com/spreadsheets/d/${sheetId}/gviz/tq?tqx=out:json&sheet=${encodeURIComponent(sheetName)}`;
  const res = await fetch(url);
  const text = await res.text();
  return JSON.parse(text.substring(47).slice(0, -2));
}

async function getSheetTabs(sheetId) {
  try {
    const url = `https://docs.google.com/spreadsheets/d/${sheetId}/gviz/tq?tqx=out:json`;
    const res = await fetch(url);
    const text = await res.text();
    const matches = [...text.matchAll(/"name":"([^"]+)"/g)];
    const names = matches.map(m => m[1]).filter((v, i, a) => a.indexOf(v) === i);
    `return names.filter(n => n !== "Página1" && n !== "Sheet1");`
    return names;
  } catch {
    return [];
  }
}

export async function fetchQuestionsByDisciplina(disciplina) {
  const sheetId = SHEET_IDS[disciplina];
  if (!sheetId) return [];

  try {
    const tabs = await getSheetTabs(sheetId);
    if (tabs.length === 0) return [];

    let allQuestions = [];
    let globalId = 1;

    for (const tab of tabs) {
      try {
        const json = await fetchSheetData(sheetId, tab);
        const rows = json.table?.rows || [];
        const questions = rows
          .filter(row => row.c && row.c[3]?.v)
          .map((row, i) => {
            const c = row.c.map(cell => cell?.v?.toString().trim() || "");
            const alternativas = [];
            if (c[4]) alternativas.push({ id: "A", texto: c[4] });
            if (c[5]) alternativas.push({ id: "B", texto: c[5] });
            if (c[6]) alternativas.push({ id: "C", texto: c[6] });
            if (c[7]) alternativas.push({ id: "D", texto: c[7] });
            if (c[8]) alternativas.push({ id: "E", texto: c[8] });
            return {
              id: `${disciplina}-${tab}-${globalId + i}`,
              topic: disciplina,
              subtopic: tab,
              difficulty: c[1] || "médio",
              banca: c[2] || "",
              enunciado: c[3] || "",
              alternativas,
              correta: c[9] || "A",
              explicacao: {
                geral: c[10] || "",
                porAlternativa: {
                  A: c[11] || "",
                  B: c[12] || "",
                  C: c[13] || "",
                  D: c[14] || "",
                  E: c[15] || "",
                },
                raciocinioCli: c[16] || "",
                dicaMemorizacao: c[17] || "",
                pegadinha: c[18] || "",
                diretriz: c[19] || "",
              },
            };
          });
        allQuestions = [...allQuestions, ...questions];
        globalId += questions.length;
      } catch (err) {
        console.warn(`Aba ${tab} não encontrada.`);
      }
    }
    return allQuestions;
  } catch (err) {
    console.error("Erro ao carregar planilha:", err);
    return [];
  }
}

export async function fetchQuestions() {
  const disciplinas = Object.keys(SHEET_IDS).filter(d => SHEET_IDS[d]);
  let all = [];
  for (const d of disciplinas) {
    const qs = await fetchQuestionsByDisciplina(d);
    all = [...all, ...qs];
  }
  return all;
}
