-- Completa a separação do caso 23: divide PCR em duas perguntas, padroniza o
-- enunciado integral nas sete questões e vincula a tomografia original.
BEGIN;

CREATE OR REPLACE FUNCTION pg_temp.pneumo_case23_uuid(seed text) RETURNS uuid
LANGUAGE sql IMMUTABLE AS $$
  SELECT (substr(md5(seed),1,8)||'-'||substr(md5(seed),9,4)||'-5'||substr(md5(seed),14,3)||'-a'||substr(md5(seed),18,3)||'-'||substr(md5(seed),21,12))::uuid
$$;

DO $$
DECLARE
  v_discipline_id uuid;
  v_topic_id uuid;
  v_stem text :=
    'Paciente do sexo masculino, 70 anos, com história de síndrome gripal há 12 dias. Relata HAS e tabagismo. Há 3 dias evolui com tosse, febre e dispneia. Chegou à UPA, onde foi colhida gasometria arterial que mostrou relação PaO₂/FiO₂ de 190. O hemograma evidenciou linfopenia; PCR de 180 mg/L, ferritina de 1.800 ng/mL e D-dímero de 800 ng/mL. Ao exame físico: discretamente dispneico, frequência respiratória de 30 irpm, crepitações em bases pulmonares, ritmo cardíaco regular em dois tempos, bulhas normofonéticas, frequência cardíaca de 100 bpm e SpO₂ de 90%.';
  v_image_url text := '/questions/pneumologia/pneumologia_p2_covid_q23.png';
  r record;
  v_question_id uuid;
  a jsonb;
BEGIN
  SELECT id INTO v_discipline_id
  FROM public.disciplines
  WHERE name='Pneumologia'
  LIMIT 1;
  IF v_discipline_id IS NULL THEN
    RAISE EXCEPTION 'Disciplina Pneumologia não encontrada';
  END IF;

  SELECT topic_id INTO v_topic_id
  FROM public.questions
  WHERE id='f822ee74-b525-4053-bf87-5cee3c3a4adb'::uuid
    AND discipline_id=v_discipline_id;
  IF v_topic_id IS NULL THEN
    RAISE EXCEPTION 'Questão composta de PCR não encontrada';
  END IF;

  -- Preserva, mas retira do quiz, a questão que reunia interpretação e mecanismo.
  UPDATE public.questions
  SET active=false
  WHERE id='f822ee74-b525-4053-bf87-5cee3c3a4adb'::uuid;

  FOR r IN
    SELECT *
    FROM jsonb_to_recordset($data$[
      {
        "key":"pcr_interpretacao",
        "difficulty":"médio",
        "question":"Nesse contexto, como deve ser interpretada a PCR de 180 mg/L?",
        "correct":"B",
        "general":"A proteína C-reativa é uma proteína de fase aguda produzida principalmente pelo fígado sob estímulo de IL-6. Uma PCR de 180 mg/L indica resposta inflamatória sistêmica intensa e, na COVID-19, associa-se a maior extensão pulmonar e risco de evolução grave. Entretanto, é inespecífica e não confirma, isoladamente, coinfecção bacteriana.",
        "summary":"PCR muito elevada sinaliza inflamação intensa, mas não determina sozinha sua causa.",
        "memory":"PCR mede intensidade inflamatória; procalcitonina pode apoiar avaliação bacteriana, sempre com a clínica.",
        "trap":"Não concluir coinfecção bacteriana apenas pelo valor elevado da PCR.",
        "alts":[
          {"l":"A","t":"Confirma pneumonia bacteriana associada e obriga antibioticoterapia de amplo espectro.","e":"Incorreta. PCR elevada pode ocorrer pela própria resposta inflamatória da COVID-19. Coinfecção bacteriana deve ser sustentada por evolução clínica, culturas, imagem e outros marcadores; o valor isolado não define antibiótico."},
          {"l":"B","t":"Indica resposta inflamatória sistêmica intensa e maior risco de gravidade, mas é um marcador inespecífico.","e":"Correta. A PCR acompanha a intensidade da resposta de fase aguda e se associa a pior evolução na COVID-19. Como também aumenta em infecções, trauma e doenças inflamatórias, precisa ser interpretada no contexto clínico."},
          {"l":"C","t":"É marcador específico de lesão pulmonar e sua concentração mede diretamente a extensão do vidro fosco.","e":"Incorreta. A PCR é um marcador sistêmico inespecífico; pode correlacionar-se com gravidade, mas não mede diretamente volume ou padrão das opacidades pulmonares."},
          {"l":"D","t":"Representa ativação da fibrinólise e confirma presença de microtrombos pulmonares.","e":"Incorreta. Formação e degradação de fibrina são avaliadas indiretamente pelo D-dímero. PCR reflete resposta inflamatória de fase aguda e não confirma trombose."},
          {"l":"E","t":"É esperada apenas em doença autoimune e torna improvável uma infecção viral.","e":"Incorreta. Infecções virais graves, inclusive COVID-19, podem provocar grande elevação da PCR por liberação de citocinas. O marcador não é exclusivo de autoimunidade."}
        ]
      },
      {
        "key":"pcr_fisiopatologia",
        "difficulty":"difícil",
        "question":"Qual mecanismo fisiopatológico explica melhor a elevação da PCR nesse paciente?",
        "correct":"D",
        "general":"O SARS-CoV-2 ativa células epiteliais e imunes, com liberação de citocinas pró-inflamatórias. A IL-6 circulante atua nos hepatócitos e aumenta a transcrição e síntese de proteínas de fase aguda, entre elas a PCR. Assim, a elevação reflete a intensidade da sinalização inflamatória sistêmica, não produção direta pelo pulmão ou pelo vírus.",
        "summary":"Citocinas, especialmente IL-6, estimulam hepatócitos a produzir PCR.",
        "memory":"Inflamação → IL-6 → fígado → PCR.",
        "trap":"A PCR é sintetizada no fígado, embora o estímulo inflamatório possa começar no pulmão.",
        "alts":[
          {"l":"A","t":"O vírus sintetiza PCR durante sua replicação dentro dos pneumócitos.","e":"Incorreta. PCR é uma proteína humana de fase aguda, não um produto viral. Sua síntese ocorre predominantemente nos hepatócitos."},
          {"l":"B","t":"A destruição de hemácias libera PCR pré-formada para o plasma.","e":"Incorreta. Hemácias não armazenam PCR. Hemólise libera hemoglobina e altera marcadores como haptoglobina, bilirrubina indireta e DHL."},
          {"l":"C","t":"A ativação da plasmina degrada fibrina e produz fragmentos identificados laboratorialmente como PCR.","e":"Incorreta. A degradação de fibrina produz D-dímero. PCR é sintetizada pelo fígado em resposta à sinalização inflamatória."},
          {"l":"D","t":"Citocinas pró-inflamatórias, especialmente IL-6, estimulam os hepatócitos a aumentar a síntese de proteínas de fase aguda, incluindo PCR.","e":"Correta. A resposta imune ao SARS-CoV-2 libera IL-6 e outras citocinas; o fígado responde aumentando PCR, que funciona como marcador da intensidade inflamatória sistêmica."},
          {"l":"E","t":"A hipóxia reduz a produção hepática de PCR, causando acúmulo compensatório do marcador no pulmão.","e":"Incorreta. A elevação não ocorre por redução de produção ou acúmulo pulmonar; decorre do aumento de síntese hepática induzido por citocinas."}
        ]
      }
    ]$data$::jsonb)
    AS x(key text,difficulty text,question text,correct text,general text,summary text,memory text,trap text,alts jsonb)
  LOOP
    v_question_id := pg_temp.pneumo_case23_uuid('pneumologia-p2-covid-case23-'||r.key);

    INSERT INTO public.questions(
      id,discipline_id,topic_id,difficulty,statement,question_type,
      correct_answer,correct_answers,general_comment,summary,memory_tip,
      trap,reference,active,exam,image_url
    )
    VALUES(
      v_question_id,v_discipline_id,v_topic_id,r.difficulty,
      v_stem||' '||r.question,'single',r.correct,ARRAY[r.correct],
      r.general,r.summary,r.memory,r.trap,
      'Prova 2 de Pneumologia — caso 23 de COVID-19; tomografia extraída do PDF original.',
      true,'P2',v_image_url
    )
    ON CONFLICT(id) DO UPDATE SET
      topic_id=EXCLUDED.topic_id,
      difficulty=EXCLUDED.difficulty,
      statement=EXCLUDED.statement,
      correct_answer=EXCLUDED.correct_answer,
      correct_answers=EXCLUDED.correct_answers,
      general_comment=EXCLUDED.general_comment,
      summary=EXCLUDED.summary,
      memory_tip=EXCLUDED.memory_tip,
      trap=EXCLUDED.trap,
      reference=EXCLUDED.reference,
      active=true,
      exam='P2',
      image_url=EXCLUDED.image_url;

    FOR a IN SELECT value FROM jsonb_array_elements(r.alts)
    LOOP
      INSERT INTO public.alternatives(id,question_id,letter,text,explanation)
      VALUES(
        pg_temp.pneumo_case23_uuid(v_question_id::text||(a->>'l')),
        v_question_id,a->>'l',a->>'t',a->>'e'
      )
      ON CONFLICT(question_id,letter) DO UPDATE SET
        text=EXCLUDED.text,
        explanation=EXCLUDED.explanation;
    END LOOP;
  END LOOP;

  -- Padroniza o mesmo caso clínico e a mesma imagem nas cinco questões já
  -- separadas pelas migrations anteriores.
  UPDATE public.questions
  SET statement=v_stem||' Nesse contexto, como deve ser interpretado o D-dímero de 800 ng/mL?',
      image_url=v_image_url
  WHERE id='48a3c8df-9ec9-5cd4-a18b-538e943915e7'::uuid;

  UPDATE public.questions
  SET statement=v_stem||' Qual mecanismo fisiopatológico explica melhor a elevação do D-dímero na COVID-19?',
      image_url=v_image_url
  WHERE id='b77dc51a-05fd-5338-aa47-653a6de3b2b5'::uuid;

  UPDATE public.questions
  SET statement=v_stem||' Qual alternativa apresenta quatro fatores clínicos associados a maior risco de evolução grave por COVID-19?',
      image_url=v_image_url
  WHERE id='2a8d3736-6ecc-5a05-a20e-f0c5868ab06f'::uuid;

  UPDATE public.questions
  SET statement=v_stem||' Qual é o principal achado observado na tomografia de tórax?',
      image_url=v_image_url
  WHERE id='3ad3f478-8e4a-4f81-a2cb-31f825f0a497'::uuid;

  UPDATE public.questions
  SET statement=v_stem||' A filha do paciente, de 40 anos, que o acompanha no atendimento, relata tosse seca e coriza há um dia. Qual é a orientação mais adequada para ela?',
      image_url=v_image_url
  WHERE id='bf935a13-c6c0-46bf-b5f1-42d487eeb4bd'::uuid;
END $$;

COMMIT;

-- Deve retornar sete questões, todas ativas, com imagem e cinco alternativas.
SELECT q.id,q.active,q.image_url,count(a.id) AS alternatives
FROM public.questions q
LEFT JOIN public.alternatives a ON a.question_id=q.id
WHERE q.id IN (
  pg_temp.pneumo_case23_uuid('pneumologia-p2-covid-case23-pcr_interpretacao'),
  pg_temp.pneumo_case23_uuid('pneumologia-p2-covid-case23-pcr_fisiopatologia'),
  '48a3c8df-9ec9-5cd4-a18b-538e943915e7'::uuid,
  'b77dc51a-05fd-5338-aa47-653a6de3b2b5'::uuid,
  '2a8d3736-6ecc-5a05-a20e-f0c5868ab06f'::uuid,
  '3ad3f478-8e4a-4f81-a2cb-31f825f0a497'::uuid,
  'bf935a13-c6c0-46bf-b5f1-42d487eeb4bd'::uuid
)
GROUP BY q.id,q.active,q.image_url
ORDER BY q.id;
