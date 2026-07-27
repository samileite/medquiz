-- Corrige questões de Pneumologia cujas imagens constavam no material-fonte,
-- mas não estavam vinculadas ao campo exibido pela plataforma.
BEGIN;

UPDATE public.questions AS q
SET image_url = fixes.image_url
FROM (
  VALUES
    ('ff9386e1-d5ca-4c7f-915f-a33365d728a1'::uuid, '/questions/pneumologia/q19.png'),
    ('23a6197a-bd1a-4072-8b2c-9e0393f9a7d6'::uuid, '/questions/pneumologia/q20.png'),
    ('85020354-d48c-4292-bc67-d5043b43ee48'::uuid, '/questions/pneumologia/q21.png'),
    ('11a7ac3b-103d-455f-b553-fda936f1f9b0'::uuid, '/questions/pneumologia/q22.png'),
    ('d88943a9-3c65-44b3-9f26-0ea73c4ca210'::uuid, '/questions/pneumologia/q23.png'),
    ('8945c9b2-dd55-4a81-8d5d-3269f343b239'::uuid, '/questions/pneumologia/q24.png'),
    ('85295f0f-4c12-4329-b9b3-17b988a16b02'::uuid, '/questions/pneumologia/q25.png'),
    ('eac7d9c9-94db-4583-b0d5-186fcb754d63'::uuid, '/questions/pneumologia/q26.png'),
    ('1964bf2c-efad-4f7b-9805-38293c1dd4fa'::uuid, '/questions/pneumologia/pneumologia_p2_abscesso_q10.png')
) AS fixes(question_id, image_url)
WHERE q.id = fixes.question_id;

DO $$
DECLARE
  v_updated integer;
BEGIN
  SELECT count(*) INTO v_updated
  FROM public.questions
  WHERE (id, image_url) IN (
    ('ff9386e1-d5ca-4c7f-915f-a33365d728a1'::uuid, '/questions/pneumologia/q19.png'),
    ('23a6197a-bd1a-4072-8b2c-9e0393f9a7d6'::uuid, '/questions/pneumologia/q20.png'),
    ('85020354-d48c-4292-bc67-d5043b43ee48'::uuid, '/questions/pneumologia/q21.png'),
    ('11a7ac3b-103d-455f-b553-fda936f1f9b0'::uuid, '/questions/pneumologia/q22.png'),
    ('d88943a9-3c65-44b3-9f26-0ea73c4ca210'::uuid, '/questions/pneumologia/q23.png'),
    ('8945c9b2-dd55-4a81-8d5d-3269f343b239'::uuid, '/questions/pneumologia/q24.png'),
    ('85295f0f-4c12-4329-b9b3-17b988a16b02'::uuid, '/questions/pneumologia/q25.png'),
    ('eac7d9c9-94db-4583-b0d5-186fcb754d63'::uuid, '/questions/pneumologia/q26.png'),
    ('1964bf2c-efad-4f7b-9805-38293c1dd4fa'::uuid, '/questions/pneumologia/pneumologia_p2_abscesso_q10.png')
  );

  IF v_updated <> 9 THEN
    RAISE EXCEPTION 'Esperadas 9 questões de Pneumologia com imagem; encontradas %', v_updated;
  END IF;
END $$;

COMMIT;

SELECT id, exam, active, image_url
FROM public.questions
WHERE id IN (
  'ff9386e1-d5ca-4c7f-915f-a33365d728a1'::uuid,
  '23a6197a-bd1a-4072-8b2c-9e0393f9a7d6'::uuid,
  '85020354-d48c-4292-bc67-d5043b43ee48'::uuid,
  '11a7ac3b-103d-455f-b553-fda936f1f9b0'::uuid,
  'd88943a9-3c65-44b3-9f26-0ea73c4ca210'::uuid,
  '8945c9b2-dd55-4a81-8d5d-3269f343b239'::uuid,
  '85295f0f-4c12-4329-b9b3-17b988a16b02'::uuid,
  'eac7d9c9-94db-4583-b0d5-186fcb754d63'::uuid,
  '1964bf2c-efad-4f7b-9805-38293c1dd4fa'::uuid
)
ORDER BY exam, id;
