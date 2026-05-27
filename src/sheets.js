import { SHEET_IDS } from "./constants.js";

const SHEET_GIDS = {
  Endocrinologia: "1473029296",
};

async function fetchSheetData(sheetId, gid = "0") {
  const url = `https://docs.google.com/spreadsheets/d/${sheetId}/gviz/tq?tqx=out:json&gid=${gid}`;
  const res = await fetch(url);
  const text = await res.text();

  const jsonText = text.substring(text.indexOf("{"), text.lastIndexOf("}") + 1);
  return JSON.parse(jsonText);
}

export async function fetchQuestionsByDisciplina(disciplina) {
  const sheetId = SHEET_IDS[disciplina];

  if (!sheetId) return [];

  try {
    const gid = SHEET_GIDS[disciplina] || "0";
    const json = await fetchSheetData(sheetId, gid);
    const rows = json.table?.rows || [];

    return rows
      .map((row) => row.c?.map((cell) => cell?.v?.toString().trim() || "") || [])
      .filter((c) => c[3] && c[3].toLowerCase() !== "enunciado")
      .map((c, index) => {
        const alternativas = [];

        if (c[4]) alternativas.push({ id: "A", texto: c[4] });
        if (c[5]) alternativas.push({ id: "B", texto: c[5] });
        if (c[6]) alternativas.push({ id: "C", texto: c[6] });
        if (c[7]) alternativas.push({ id: "D", texto: c[7] });
        if (c[8]) alternativas.push({ id: "E", texto: c[8] });

        return {
          id: `${disciplina}-${index + 1}`,
          topic: c[0] || disciplina,
          subtopic: c[0] || disciplina,
          difficulty: c[1] || "médio",
          banca: c[2] || "",
          enunciado: c[3],
          alternativas,
          correta: (c[9] || "A").toUpperCase(),
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
  } catch (err) {
    console.error("Erro ao carregar planilha:", err);
    return [];
  }
}

export async function fetchQuestions() {
  const disciplinas = Object.keys(SHEET_IDS).filter((d) => SHEET_IDS[d]);

  let all = [];

  for (const d of disciplinas) {
    const qs = await fetchQuestionsByDisciplina(d);
    all = [...all, ...qs];
  }

  return all;
}