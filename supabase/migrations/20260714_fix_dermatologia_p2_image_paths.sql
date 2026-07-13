-- Ajusta as imagens da Dermatologia P2 para os assets públicos do frontend.

ALTER TABLE public.questions
ADD COLUMN IF NOT EXISTS image_url text;

UPDATE public.questions
SET image_url = '/questions/dermatologia/dermatologia_p2_q069.png'
WHERE id = 'f636acf8-3883-5929-a91a-b0aba1595d5a'::uuid;

UPDATE public.questions
SET image_url = '/questions/dermatologia/dermatologia_p2_q100.png'
WHERE id = 'c1b65260-6ea1-55c5-9178-9c234cf2e9d5'::uuid;
