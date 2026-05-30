-- Add column to store Firebase UID and create unique constraint for firebase_user_id + question_id
ALTER TABLE IF EXISTS user_answers
  ADD COLUMN IF NOT EXISTS firebase_user_id text;

DO $$
BEGIN
  IF NOT EXISTS (
    SELECT 1
    FROM pg_constraint
    WHERE conname = 'unique_user_question_firebase'
  ) THEN
    ALTER TABLE user_answers
    ADD CONSTRAINT unique_user_question_firebase UNIQUE (firebase_user_id, question_id);
  END IF;
END
$$;