-- Questões V/F agrupadas usam uma alternativa por assertiva e codificam o
-- gabarito em questions.correct_answers como A:V, B:F, etc. Isso mantém a
-- persistência já existente em user_answers sem criar dados paralelos.
BEGIN;

COMMENT ON COLUMN public.questions.question_type IS
  'single, multiple ou true_false. V/F legado usa A/B; V/F agrupado usa uma assertiva por alternativa e tokens como A:V.';

COMMIT;
