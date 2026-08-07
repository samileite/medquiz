-- Questões V/F agrupadas usam uma alternativa por assertiva e codificam o
-- gabarito em questions.correct_answers como A:V, B:F, etc. Isso mantém a
-- persistência já existente em user_answers sem criar dados paralelos.
BEGIN;

DO $$
DECLARE
  v_invalid integer;
BEGIN
  SELECT count(*) INTO v_invalid
  FROM public.questions q
  WHERE q.question_type = 'true_false'
    AND (
      cardinality(q.correct_answers) = 0
      OR EXISTS (
        SELECT 1
        FROM unnest(q.correct_answers) answer
        WHERE answer !~ '^[A-E]:(V|F)$'
      )
    );

  IF v_invalid > 0 THEN
    RAISE EXCEPTION 'Há % questões true_false com gabarito inválido', v_invalid;
  END IF;
END $$;

COMMENT ON COLUMN public.questions.question_type IS
  'single, multiple ou true_false. Em true_false, cada alternativa é uma assertiva e correct_answers usa tokens como A:V.';

COMMIT;
