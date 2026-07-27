-- Divide duas versões compostas do mesmo caso de COVID-19 em três questões.
BEGIN;

CREATE OR REPLACE FUNCTION pg_temp.pneumo_split_uuid(seed text) RETURNS uuid
LANGUAGE sql IMMUTABLE AS $$
  SELECT (substr(md5(seed),1,8)||'-'||substr(md5(seed),9,4)||'-5'||substr(md5(seed),14,3)||'-a'||substr(md5(seed),18,3)||'-'||substr(md5(seed),21,12))::uuid
$$;

DO $$
DECLARE
  v_discipline_id uuid;
  v_topic_id uuid;
  v_source_count integer;
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

  SELECT count(*) INTO v_source_count
  FROM public.questions
  WHERE id IN (
    '817d24fb-fc2b-4f24-a244-35e5d26abf8e'::uuid,
    'abfb7fa7-d364-499a-a270-4b8f121c0c08'::uuid
  )
  AND discipline_id=v_discipline_id;

  IF v_source_count <> 2 THEN
    RAISE EXCEPTION 'Esperadas duas versões compostas do caso; encontradas %', v_source_count;
  END IF;

  SELECT topic_id INTO v_topic_id
  FROM public.questions
  WHERE id='817d24fb-fc2b-4f24-a244-35e5d26abf8e'::uuid;

  -- As versões compostas permanecem preservadas no banco, mas deixam de aparecer no quiz.
  UPDATE public.questions
  SET active=false
  WHERE id IN (
    '817d24fb-fc2b-4f24-a244-35e5d26abf8e'::uuid,
    'abfb7fa7-d364-499a-a270-4b8f121c0c08'::uuid
  );

  FOR r IN
    SELECT *
    FROM jsonb_to_recordset($data$[
      {
        "key":"interpretacao",
        "difficulty":"médio",
        "statement":"Paciente do sexo masculino, 70 anos, com história de síndrome gripal há 12 dias. Relata HAS e tabagismo. Há 3 dias evolui com tosse, febre e dispneia. Chegou à UPA, onde foi colhida gasometria arterial que mostrou relação PaO₂/FiO₂ de 190. O hemograma evidenciou linfopenia; PCR de 180 mg/L, ferritina de 1.800 ng/mL e D-dímero de 800 ng/mL. Ao exame físico: discretamente dispneico, frequência respiratória de 30 irpm, crepitações em bases pulmonares, ritmo cardíaco regular em dois tempos, bulhas normofonéticas, frequência cardíaca de 100 bpm e SpO₂ de 90%. Nesse contexto, como deve ser interpretado o D-dímero de 800 ng/mL?",
        "correct":"B",
        "general":"O D-dímero é um produto da degradação da fibrina estabilizada. Sua elevação demonstra aumento da formação e lise de coágulos e, na COVID-19, associa-se a inflamação, lesão endotelial, imunotrombose e maior gravidade. Entretanto, é um marcador inespecífico: não confirma tromboembolismo pulmonar isoladamente e não determina, sozinho, anticoagulação terapêutica ou trombólise.",
        "summary":"D-dímero elevado indica maior turnover de fibrina, mas não confirma TEP.",
        "memory":"D-dímero ajuda a excluir trombose em baixa probabilidade; valor elevado exige contexto clínico.",
        "trap":"Não transformar um marcador sensível e inespecífico em diagnóstico de TEP.",
        "alts":[
          {"l":"A","t":"Confirma tromboembolismo pulmonar agudo e indica trombólise sistêmica imediata.","e":"Incorreta. D-dímero elevado é inespecífico e pode ocorrer pela própria inflamação da COVID-19, idade, infecção e internação. TEP exige probabilidade clínica e confirmação por imagem; trombólise é reservada a situações de alto risco com instabilidade."},
          {"l":"B","t":"Indica aumento da formação e degradação de fibrina, sendo marcador de ativação da coagulação e fibrinólise, mas não confirma trombose isoladamente.","e":"Correta. O D-dímero resulta da lise da fibrina estabilizada e sinaliza maior turnover trombótico. Na COVID-19 associa-se à imunotrombose e pior prognóstico, porém sua baixa especificidade impede utilizá-lo isoladamente para diagnosticar TEP."},
          {"l":"C","t":"Representa exclusivamente resposta inflamatória hepática, sem relação com coagulação.","e":"Incorreta. A proteína C-reativa é produzida pelo fígado como proteína de fase aguda; o D-dímero, por sua vez, deriva da degradação da fibrina e está diretamente relacionado à ativação coagulação-fibrinólise."},
          {"l":"D","t":"Demonstra fibrinólise eficaz e, por isso, exclui microtrombose pulmonar.","e":"Incorreta. A elevação ocorre porque houve formação e degradação aumentadas de fibrina; portanto, pode acompanhar microtrombose e tromboembolismo, não excluí-los."},
          {"l":"E","t":"É específico de coagulação intravascular disseminada e não se eleva na COVID-19 sem essa complicação.","e":"Incorreta. D-dímero sobe em diversas condições, incluindo infecção, inflamação, câncer, idade avançada, cirurgia e trombose. Coagulação intravascular disseminada é apenas uma das possibilidades."}
        ]
      },
      {
        "key":"fisiopatologia",
        "difficulty":"difícil",
        "statement":"Paciente do sexo masculino, 70 anos, com história de síndrome gripal há 12 dias. Relata HAS e tabagismo. Há 3 dias evolui com tosse, febre e dispneia. Chegou à UPA, onde foi colhida gasometria arterial que mostrou relação PaO₂/FiO₂ de 190. O hemograma evidenciou linfopenia; PCR de 180 mg/L, ferritina de 1.800 ng/mL e D-dímero de 800 ng/mL. Ao exame físico: discretamente dispneico, frequência respiratória de 30 irpm, crepitações em bases pulmonares, ritmo cardíaco regular em dois tempos, bulhas normofonéticas, frequência cardíaca de 100 bpm e SpO₂ de 90%. Qual mecanismo fisiopatológico explica melhor a elevação do D-dímero na COVID-19?",
        "correct":"D",
        "general":"Na COVID-19, a infecção e a resposta imune causam lesão e ativação endotelial, liberação de citocinas, ativação de monócitos, plaquetas e fator tecidual, redução de mecanismos anticoagulantes e formação de fibrina na microcirculação. A fibrinólise subsequente degrada essa fibrina e libera D-dímero. Esse processo é denominado imunotrombose e pode ocorrer mesmo sem macro-TEP.",
        "summary":"Inflamação e endoteliopatia ativam coagulação; a lise da fibrina formada eleva D-dímero.",
        "memory":"COVID grave: citocinas + endotélio + plaquetas → fibrina → D-dímero.",
        "trap":"A elevação não depende necessariamente de trombo visível em grandes vasos.",
        "alts":[
          {"l":"A","t":"Supressão da coagulação pelo vírus, com redução da formação de fibrina e aumento compensatório do D-dímero.","e":"Incorreta. A COVID-19 grave promove estado pró-coagulante, e não supressão da coagulação. Sem formação de fibrina estabilizada não haveria substrato para gerar D-dímero."},
          {"l":"B","t":"Produção direta de D-dímero pelos pneumócitos infectados após ligação viral ao receptor ACE2.","e":"Incorreta. Pneumócitos não produzem D-dímero. O marcador surge da ação da plasmina sobre fibrina estabilizada formada durante ativação da coagulação."},
          {"l":"C","t":"Hemólise intravascular causada pela febre, liberando fragmentos de hemoglobina medidos como D-dímero.","e":"Incorreta. D-dímero é fragmento de fibrina, não de hemoglobina. Hemólise é investigada com marcadores como DHL, bilirrubina indireta, haptoglobina e reticulócitos."},
          {"l":"D","t":"Inflamação sistêmica e lesão endotelial ativam fator tecidual, plaquetas e coagulação, formando fibrina; sua degradação pela fibrinólise libera D-dímero.","e":"Correta. A interação entre resposta imune e coagulação produz imunotrombose na microcirculação pulmonar e sistêmica. A plasmina degrada a fibrina estabilizada desses trombos, elevando o D-dímero."},
          {"l":"E","t":"Redução isolada da síntese hepática de fatores de coagulação, sem formação de trombos ou ativação endotelial.","e":"Incorreta. Insuficiência sintética hepática pode alterar coagulação, mas não é o mecanismo central apresentado. Na COVID-19, a elevação decorre principalmente de inflamação, endoteliopatia e maior formação/degradação de fibrina."}
        ]
      },
      {
        "key":"fatores_risco",
        "difficulty":"médio",
        "statement":"Paciente do sexo masculino, 70 anos, com história de síndrome gripal há 12 dias. Relata HAS e tabagismo. Há 3 dias evolui com tosse, febre e dispneia. Chegou à UPA, onde foi colhida gasometria arterial que mostrou relação PaO₂/FiO₂ de 190. O hemograma evidenciou linfopenia; PCR de 180 mg/L, ferritina de 1.800 ng/mL e D-dímero de 800 ng/mL. Ao exame físico: discretamente dispneico, frequência respiratória de 30 irpm, crepitações em bases pulmonares, ritmo cardíaco regular em dois tempos, bulhas normofonéticas, frequência cardíaca de 100 bpm e SpO₂ de 90%. Qual alternativa apresenta quatro fatores clínicos associados a maior risco de evolução grave por COVID-19?",
        "correct":"C",
        "general":"O risco de COVID-19 grave aumenta com idade avançada, obesidade, diabetes, doenças cardiovasculares, hipertensão, doença renal crônica, doença pulmonar crônica, câncer e imunossupressão. Marcadores como PCR, ferritina, linfopenia e D-dímero ajudam na avaliação prognóstica, mas são achados laboratoriais, não fatores clínicos prévios.",
        "summary":"Idade e comorbidades metabólicas, cardiovasculares, renais, pulmonares ou imunológicas aumentam gravidade.",
        "memory":"COVID grave: idade + obesidade + diabetes + doença orgânica crônica.",
        "trap":"Não confundir fatores clínicos de risco com biomarcadores laboratoriais de gravidade.",
        "alts":[
          {"l":"A","t":"PCR elevada, ferritina elevada, D-dímero elevado e linfopenia.","e":"Incorreta. Esses são marcadores laboratoriais associados à gravidade e presentes no caso, mas a pergunta solicita fatores clínicos do paciente."},
          {"l":"B","t":"Coriza, odinofagia, anosmia e cefaleia.","e":"Incorreta. São manifestações possíveis da infecção, porém não constituem quatro fatores estabelecidos de maior risco para evolução grave."},
          {"l":"C","t":"Idade avançada, obesidade, diabetes mellitus e doença cardiovascular.","e":"Correta. Esses quatro fatores aumentam consistentemente o risco de hospitalização, insuficiência respiratória e morte por COVID-19. Hipertensão, doença renal, doença pulmonar crônica, câncer e imunossupressão são outros fatores relevantes."},
          {"l":"D","t":"Sexo feminino, idade inferior a 40 anos, vacinação completa e ausência de comorbidades.","e":"Incorreta. Esse conjunto se associa, em geral, a menor risco de evolução grave; vacinação reduz hospitalização e mortalidade."},
          {"l":"E","t":"Rinite alérgica, miopia, dermatite de contato e apendicectomia prévia.","e":"Incorreta. Essas condições não são reconhecidas como fatores clínicos principais de gravidade para COVID-19."}
        ]
      }
    ]$data$::jsonb)
    AS x(key text,difficulty text,statement text,correct text,general text,summary text,memory text,trap text,alts jsonb)
  LOOP
    v_question_id := pg_temp.pneumo_split_uuid('pneumologia-p2-covid-ddimer-'||r.key);

    INSERT INTO public.questions(
      id,discipline_id,topic_id,difficulty,statement,question_type,
      correct_answer,correct_answers,general_comment,summary,memory_tip,
      trap,reference,active,exam,image_url
    )
    VALUES(
      v_question_id,v_discipline_id,v_topic_id,r.difficulty,r.statement,'single',
      r.correct,ARRAY[r.correct],r.general,r.summary,r.memory,r.trap,
      'Prova 2 de Pneumologia — caso de COVID-19 dividido em questões objetivas no padrão MedQuiz.',
      true,'P2',NULL
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
      exam='P2';

    FOR a IN SELECT value FROM jsonb_array_elements(r.alts)
    LOOP
      INSERT INTO public.alternatives(id,question_id,letter,text,explanation)
      VALUES(
        pg_temp.pneumo_split_uuid(v_question_id::text||(a->>'l')),
        v_question_id,a->>'l',a->>'t',a->>'e'
      )
      ON CONFLICT(question_id,letter) DO UPDATE SET
        text=EXCLUDED.text,
        explanation=EXCLUDED.explanation;
    END LOOP;
  END LOOP;
END $$;

COMMIT;

SELECT q.id,q.exam,q.active,count(a.id) AS alternatives
FROM public.questions q
LEFT JOIN public.alternatives a ON a.question_id=q.id
WHERE q.id IN (
  pg_temp.pneumo_split_uuid('pneumologia-p2-covid-ddimer-interpretacao'),
  pg_temp.pneumo_split_uuid('pneumologia-p2-covid-ddimer-fisiopatologia'),
  pg_temp.pneumo_split_uuid('pneumologia-p2-covid-ddimer-fatores_risco')
)
GROUP BY q.id,q.exam,q.active
ORDER BY q.id;
