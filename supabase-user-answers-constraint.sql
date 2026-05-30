DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM pg_constraint
    WHERE conname = 'unique_user_question'
  ) THEN
    ALTER TABLE user_answers
    ADD CONSTRAINT unique_user_question UNIQUE (user_id, question_id);
  END IF;
END
$$;