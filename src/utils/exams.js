export const DEFAULT_EXAM_CODE = "P1";

export function normalizeExamCode(value, fallback = DEFAULT_EXAM_CODE) {
  const raw = String(value || "").trim().toUpperCase();
  const directMatch = raw.match(/^P\s*(\d+)$/);
  if (directMatch) return `P${directMatch[1]}`;

  const labelMatch = raw.match(/^PROVA\s*(\d+)$/);
  if (labelMatch) return `P${labelMatch[1]}`;

  return fallback;
}

export function formatExamLabel(exam) {
  const match = String(exam || "").trim().toUpperCase().match(/^P\s*(\d+)$/);
  return match ? `Prova ${match[1]}` : String(exam || "");
}

export function compareExamCodes(a, b) {
  const aMatch = String(a || "").trim().toUpperCase().match(/^P\s*(\d+)$/);
  const bMatch = String(b || "").trim().toUpperCase().match(/^P\s*(\d+)$/);

  if (aMatch && bMatch) return Number(aMatch[1]) - Number(bMatch[1]);
  if (aMatch) return -1;
  if (bMatch) return 1;

  return String(a || "").localeCompare(String(b || ""));
}
