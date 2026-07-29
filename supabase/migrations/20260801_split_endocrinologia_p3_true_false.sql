-- Converte os nove blocos V/F da 3ª avaliação de Endocrinologia em
-- 40 questões binárias independentes. Cada questão repete o caso-base.
BEGIN;

CREATE OR REPLACE FUNCTION pg_temp.endo_p3_vf_uuid(seed text) RETURNS uuid
LANGUAGE sql IMMUTABLE AS $$
  SELECT (substr(md5(seed),1,8)||'-'||substr(md5(seed),9,4)||'-5'||substr(md5(seed),14,3)||'-a'||substr(md5(seed),18,3)||'-'||substr(md5(seed),21,12))::uuid
$$;

DO $$
DECLARE
  v_discipline_id uuid;
  v_topic_id uuid;
  v_question_id uuid;
  b record;
  item jsonb;
  v_correct text;
  v_reason text;
BEGIN
  SELECT id INTO v_discipline_id FROM public.disciplines
  WHERE name='Endocrinologia' LIMIT 1;
  IF v_discipline_id IS NULL THEN
    RAISE EXCEPTION 'Disciplina Endocrinologia não encontrada';
  END IF;

  FOR b IN
    SELECT * FROM jsonb_to_recordset($data$[
      {
        "key":"hiperprolactinemia_24a","topic":"Hipófise — Hiperfunção","difficulty":"médio",
        "stem":"Mulher de 24 anos, solteira, apresenta exames de rotina normais, prolactina de 76 ng/mL, beta-hCG negativo e TSH de 0,8 mUI/L.",
        "items":[
          {"i":1,"t":"Deve-se questionar a presença de amenorreia ou irregularidade menstrual e galactorreia.","v":true,"r":"Esses sintomas refletem hipogonadismo induzido pela prolactina e ação mamária, sendo essenciais na avaliação clínica."},
          {"i":2,"t":"Insuficiência renal, hepatopatia, hipotireoidismo, desconexão da haste hipofisária e prolactinoma podem causar hiperprolactinemia patológica.","v":true,"r":"Essas condições alteram depuração, estímulo por TRH, inibição dopaminérgica ou produção tumoral de prolactina."},
          {"i":3,"t":"O próximo passo obrigatório é ressonância da sela túrcica, pois adenoma hipofisário é a causa mais comum de qualquer hiperprolactinemia.","v":false,"r":"Antes da imagem devem ser excluídas causas fisiológicas, farmacológicas, sistêmicas e macroprolactina conforme o contexto; nem toda elevação decorre de adenoma."},
          {"i":4,"t":"Macroprolactina responde por mais de 90% dos casos de hiperprolactinemia em homens.","v":false,"r":"Macroprolactinemia não apresenta essa frequência e deve ser pesquisada sobretudo quando há discordância entre sintomas e valor laboratorial."},
          {"i":5,"t":"A magnitude da prolactina não ajuda na etiologia, e os valores mais altos são tipicamente farmacológicos.","v":false,"r":"A magnitude auxilia: elevações muito acentuadas favorecem prolactinoma, embora existam sobreposição e efeito gancho."}
        ]
      },
      {
        "key":"acromegalia_47a","topic":"Hipófise — Hiperfunção","difficulty":"médio",
        "stem":"Mulher de 47 anos apresenta parestesia e alodinia palmar, aumento de extremidades, macroglossia, prognatismo, pressão arterial de 160×100 mmHg, glicemia de 128 mg/dL e HbA1c de 7,3%, sugerindo acromegalia.",
        "items":[
          {"i":1,"t":"Complicações respiratórias são, isoladamente, a primeira causa de mortalidade em todos os pacientes com acromegalia.","v":false,"r":"A mortalidade decorre principalmente de complicações cardiovasculares, respiratórias e neoplásicas, com peso variável; a afirmação absoluta não é adequada."},
          {"i":2,"t":"Se IGF-1 estiver elevado ou equívoco, pode-se avaliar a supressão do GH durante teste oral de tolerância à glicose.","v":true,"r":"A falha de supressão do GH após sobrecarga de glicose é utilizada para confirmação bioquímica em cenário apropriado."},
          {"i":3,"t":"A cirurgia transesfenoidal é tratamento de primeira escolha para a maioria dos adenomas hipofisários ressecáveis causadores de acromegalia.","v":true,"r":"A cirurgia pode controlar a hipersecreção e descomprimir estruturas, especialmente quando realizada por equipe experiente."},
          {"i":4,"t":"O mecanismo habitual da acromegalia é a hipersecreção hipotalâmica de GHRH.","v":false,"r":"A causa usual é adenoma somatotrófico hipofisário produtor de GH; produção excessiva de GHRH é rara."},
          {"i":5,"t":"A ressonância geralmente evidencia microadenoma ao diagnóstico da acromegalia.","v":false,"r":"Devido ao diagnóstico frequentemente tardio, muitos pacientes já apresentam macroadenoma, definido por diâmetro de pelo menos 10 mm."}
        ]
      },
      {
        "key":"hipopituitarismo_geral","topic":"Hipófise — Hipofunção","difficulty":"médio",
        "stem":"Considere os conceitos gerais, causas e manifestações do hipopituitarismo.",
        "items":[
          {"i":1,"t":"Pan-hipopituitarismo corresponde à redução de dois ou mais hormônios hipofisários por condições hipotálamo-hipofisárias.","v":true,"r":"O termo descreve comprometimento de múltiplos eixos, embora a extensão completa deva ser documentada individualmente."},
          {"i":2,"t":"O hipopituitarismo pode ter causas congênitas ou adquiridas.","v":true,"r":"Alterações genéticas e do desenvolvimento, assim como tumores, trauma, cirurgia, radiação e inflamação, podem comprometer a função hipofisária."},
          {"i":3,"t":"Tumor hipofisário, traumatismo cranioencefálico, doenças inflamatórias ou infiltrativas e síndrome de Sheehan são causas adquiridas.","v":true,"r":"Todas podem lesar a hipófise ou sua conexão hipotalâmica e provocar perda de um ou mais eixos."},
          {"i":4,"t":"Efeito de massa hipofisário pode causar cefaleia, alteração do campo visual e paralisias de nervos cranianos.","v":true,"r":"Compressão do quiasma e invasão parasselar explicam alterações visuais e oculomotoras, além de cefaleia."},
          {"i":5,"t":"O diagnóstico pode ser tardio porque várias manifestações hormonais são inespecíficas.","v":true,"r":"Fadiga, redução de libido, alterações de peso e fraqueza podem evoluir lentamente e ser atribuídas a outras condições."}
        ]
      },
      {
        "key":"hipopituitarismo_deficiencias","topic":"Hipófise — Hipofunção","difficulty":"fácil",
        "stem":"Considere as manifestações das deficiências hormonais no hipopituitarismo.",
        "items":[
          {"i":1,"t":"Deficiência de GH em crianças pode causar baixa estatura e redução da velocidade de crescimento.","v":true,"r":"GH e IGF-1 são fundamentais para crescimento linear; sua deficiência compromete velocidade de crescimento e estatura final."},
          {"i":2,"t":"Deficiência central de TSH pode produzir quadro semelhante ao hipotireoidismo primário, por vezes mais insidioso ou leve.","v":true,"r":"A falta de estímulo tireotrófico reduz T4 livre; o TSH pode estar baixo, normal ou discretamente elevado, mas biologicamente inadequado."}
        ]
      },
      {
        "key":"suprarrenal_rastreio","topic":"Suprarrenal","difficulty":"médio",
        "stem":"Considere o diagnóstico das principais doenças da suprarrenal associadas à hipertensão secundária.",
        "items":[
          {"i":1,"t":"Em paciente hipertenso com suspeita de feocromocitoma, a investigação bioquímica inicial utiliza metanefrinas plasmáticas livres ou urinárias fracionadas.","v":true,"r":"Metanefrinas são produzidas continuamente pelo metabolismo das catecolaminas e oferecem elevada sensibilidade diagnóstica."},
          {"i":2,"t":"Feocromocitoma pode cursar com hipertensão, palpitações, sudorese e cefaleia.","v":true,"r":"A secreção catecolaminérgica produz manifestações paroxísticas ou sustentadas, incluindo a tríade clássica."},
          {"i":3,"t":"Hipertensão associada a hipocalemia persistente e expansão volêmica levanta suspeita de hiperaldosteronismo primário.","v":true,"r":"A aldosterona autônoma retém sódio, aumenta pressão e promove perda renal de potássio, embora muitos casos sejam normocalêmicos."},
          {"i":4,"t":"Hiperaldosteronismo primário e feocromocitoma são causas endócrinas de hipertensão secundária.","v":true,"r":"Ambas produzem hipertensão por mecanismos hormonais específicos e têm tratamento direcionado."},
          {"i":5,"t":"Na suspeita de síndrome de Cushing, o primeiro passo é localizar a lesão por tomografia de tórax ou crânio.","v":false,"r":"Primeiro confirma-se hipercortisolismo com testes bioquímicos; ACTH e exames de imagem são utilizados depois para determinar a etiologia."}
        ]
      },
      {
        "key":"suprarrenal_etiologia","topic":"Suprarrenal","difficulty":"médio",
        "stem":"Considere a interpretação etiológica e radiológica das doenças da suprarrenal.",
        "items":[
          {"i":1,"t":"ACTH elevado após confirmação de Cushing aponta para produção autônoma primária da suprarrenal.","v":false,"r":"Tumor adrenal produtor de cortisol costuma suprimir ACTH; ACTH alto ou inadequadamente normal sugere fonte hipofisária ou ectópica."},
          {"i":2,"t":"Feocromocitomas são raros, mas podem causar elevada morbimortalidade se não reconhecidos.","v":true,"r":"Crises catecolaminérgicas podem provocar arritmia, cardiomiopatia, AVC e colapso hemodinâmico."},
          {"i":3,"t":"Lesão adrenal maior que 6 cm, com margens irregulares e necrose, apresenta características suspeitas para malignidade.","v":true,"r":"Tamanho elevado, heterogeneidade, necrose e contornos irregulares aumentam a preocupação com carcinoma, embora avaliação seja multiparamétrica."},
          {"i":4,"t":"No adenoma produtor de aldosterona, hipertensão com hipocalemia é apresentação clássica, mas existe forma normocalêmica.","v":true,"r":"A hipocalemia aparece especialmente em doença mais intensa; rastreamento ampliado identifica muitos pacientes com potássio normal."},
          {"i":5,"t":"Feocromocitomas são, na maioria, bilaterais e malignos.","v":false,"r":"A maioria é unilateral; potencial metastático não pode ser definido apenas pela histologia, mas doença bilateral ou metastática não é majoritária."}
        ]
      },
      {
        "key":"osso_prevencao","topic":"Metabolismo ósseo e paratireoide","difficulty":"fácil",
        "stem":"Considere prevenção de osteoporose, risco de fratura e interpretação da densitometria óssea.",
        "items":[
          {"i":1,"t":"Exercício físico regular pode aumentar ou preservar densidade mineral óssea, melhorar equilíbrio e força e reduzir quedas.","v":true,"r":"Exercícios com impacto tolerado, resistência e treino de equilíbrio integram prevenção de fraturas."},
          {"i":2,"t":"Tabagismo e consumo excessivo de álcool aumentam o risco de fratura.","v":true,"r":"Essas exposições prejudicam saúde óssea e aumentam risco de quedas e fraturas."},
          {"i":3,"t":"Em homens com mais de 50 anos e mulheres pós-menopausa, Z-score de -2,5 define osteoporose.","v":false,"r":"Nesses grupos utiliza-se T-score; valor de -2,5 ou menor define osteoporose densitométrica. Z-score compara com pessoas da mesma idade."}
        ]
      },
      {
        "key":"osteoporose_conceitos","topic":"Metabolismo ósseo e paratireoide","difficulty":"médio",
        "stem":"Considere definição, causas secundárias, fatores de risco e tratamento da osteoporose.",
        "items":[
          {"i":1,"t":"Osteoporose caracteriza-se por baixa resistência óssea, relacionada a redução de massa e deterioração da microarquitetura.","v":true,"r":"A combinação compromete a resistência mecânica e aumenta suscetibilidade a fraturas por baixo trauma."},
          {"i":2,"t":"Cushing e hipogonadismo são causas secundárias possíveis, mas não há necessidade de investigação clínica de causas secundárias.","v":false,"r":"A avaliação de causas secundárias é importante, sobretudo em apresentação precoce, grave, atípica ou com resposta inadequada."},
          {"i":3,"t":"IMC abaixo de 18 kg/m² aumenta risco, enquanto glicocorticoide sistêmico crônico protege o osso.","v":false,"r":"Baixo peso é fator de risco, mas glicocorticoides promovem perda óssea e aumentam fraturas."},
          {"i":4,"t":"Bisfosfonatos podem ser usados continuamente por mais de dez anos sem necessidade de reavaliar risco ou eventos adversos.","v":false,"r":"A duração deve ser individualizada; reavalia-se risco de fratura e complicações raras para decidir continuidade ou pausa."},
          {"i":5,"t":"Bisfosfonatos são agentes anabólicos que estimulam a reabsorção óssea.","v":false,"r":"São anti-reabsortivos: reduzem atividade e sobrevivência de osteoclastos; não são terapias anabólicas."}
        ]
      },
      {
        "key":"acromegalia_55a","topic":"Hipófise — Hiperfunção","difficulty":"médio",
        "stem":"Homem de 55 anos, hipertenso, apresenta fraqueza crônica, dores articulares, anel apertado, aumento do calçado e prognatismo, sugerindo acromegalia.",
        "items":[
          {"i":1,"t":"GH basal aleatório não é bom exame isolado de confirmação porque sua secreção é pulsátil.","v":true,"r":"A concentração varia ao longo do dia; IGF-1 é mais estável e a supressão do GH no TOTG pode ser necessária."},
          {"i":2,"t":"Complicações sistêmicas da acromegalia aumentam morbimortalidade e podem reduzir a expectativa de vida.","v":true,"r":"Doenças cardiovasculares, respiratórias, metabólicas e neoplásicas contribuem para o excesso de risco."},
          {"i":3,"t":"Diabetes, hiperinsulinemia, ganho ponderal e hipertensão podem acompanhar a acromegalia.","v":true,"r":"GH antagoniza a ação da insulina e a doença associa-se a alterações metabólicas e cardiovasculares."},
          {"i":4,"t":"Gigantismo ocorre na maioria dos adultos com tumor secretor de GH.","v":false,"r":"Gigantismo exige excesso de GH antes do fechamento das cartilagens de crescimento; no adulto ocorre acromegalia."},
          {"i":5,"t":"Cirurgia transcraniana é a primeira escolha, enquanto a via transesfenoidal fica reservada por causar mais complicações.","v":false,"r":"A via transesfenoidal é a abordagem padrão para a maioria dos adenomas; a transcraniana é reservada a anatomias selecionadas."}
        ]
      }
    ]$data$::jsonb)
    AS x(key text,topic text,difficulty text,stem text,items jsonb)
  LOOP
    SELECT id INTO v_topic_id FROM public.topics
    WHERE discipline_id=v_discipline_id AND name=b.topic LIMIT 1;
    IF v_topic_id IS NULL THEN
      v_topic_id:=pg_temp.endo_p3_vf_uuid('endocrinologia-topic-'||b.topic);
      INSERT INTO public.topics(id,discipline_id,name)
      VALUES(v_topic_id,v_discipline_id,b.topic)
      ON CONFLICT(id) DO UPDATE SET name=EXCLUDED.name;
    END IF;

    FOR item IN SELECT value FROM jsonb_array_elements(b.items)
    LOOP
      v_question_id:=pg_temp.endo_p3_vf_uuid(
        'endocrinologia-prova-3-vf-'||b.key||'-'||(item->>'i')
      );
      v_correct:=CASE WHEN (item->>'v')::boolean THEN 'A' ELSE 'B' END;
      v_reason:=item->>'r';

      INSERT INTO public.questions(
        id,discipline_id,topic_id,exam,difficulty,statement,question_type,
        correct_answer,correct_answers,general_comment,summary,memory_tip,trap,
        reference,active,image_url
      ) VALUES(
        v_question_id,v_discipline_id,v_topic_id,'P3',b.difficulty,
        b.stem||' Avalie a afirmação: “'||(item->>'t')||'” Essa afirmação é verdadeira ou falsa?',
        'single',v_correct,ARRAY[v_correct],
        v_reason,
        'Cada afirmação do bloco V/F deve ser julgada de forma independente.',
        'Leia o valor absoluto da frase: termos como “sempre”, “todos” e “obrigatório” podem torná-la falsa.',
        'Não tente responder uma sequência: avalie apenas a afirmação apresentada.',
        'Prova 3 de Endocrinologia — bloco V/F separado em questões binárias no padrão MedQuiz.',
        true,NULL
      )
      ON CONFLICT(id) DO UPDATE SET
        topic_id=EXCLUDED.topic_id,exam='P3',difficulty=EXCLUDED.difficulty,
        statement=EXCLUDED.statement,question_type='single',
        correct_answer=EXCLUDED.correct_answer,correct_answers=EXCLUDED.correct_answers,
        general_comment=EXCLUDED.general_comment,summary=EXCLUDED.summary,
        memory_tip=EXCLUDED.memory_tip,trap=EXCLUDED.trap,
        reference=EXCLUDED.reference,active=true,image_url=NULL;

      INSERT INTO public.alternatives(id,question_id,letter,text,explanation)
      VALUES
        (
          pg_temp.endo_p3_vf_uuid(v_question_id::text||'A'),v_question_id,'A','Verdadeiro',
          CASE WHEN v_correct='A'
            THEN 'Correta. '||v_reason
            ELSE 'Incorreta. '||v_reason
          END
        ),
        (
          pg_temp.endo_p3_vf_uuid(v_question_id::text||'B'),v_question_id,'B','Falso',
          CASE WHEN v_correct='B'
            THEN 'Correta. '||v_reason
            ELSE 'Incorreta. '||v_reason
          END
        )
      ON CONFLICT(question_id,letter) DO UPDATE SET
        text=EXCLUDED.text,explanation=EXCLUDED.explanation;
    END LOOP;
  END LOOP;
END $$;

DO $$
DECLARE
  v_questions integer;
  v_alternatives integer;
  v_blank integer;
BEGIN
  SELECT count(*) INTO v_questions FROM public.questions
  WHERE reference='Prova 3 de Endocrinologia — bloco V/F separado em questões binárias no padrão MedQuiz.'
    AND active=true AND exam='P3' AND question_type='single';
  SELECT count(*) INTO v_alternatives FROM public.alternatives a
  JOIN public.questions q ON q.id=a.question_id
  WHERE q.reference='Prova 3 de Endocrinologia — bloco V/F separado em questões binárias no padrão MedQuiz.';
  SELECT count(*) INTO v_blank FROM public.alternatives a
  JOIN public.questions q ON q.id=a.question_id
  WHERE q.reference='Prova 3 de Endocrinologia — bloco V/F separado em questões binárias no padrão MedQuiz.'
    AND coalesce(trim(a.explanation),'')='';

  IF v_questions<>40 OR v_alternatives<>80 OR v_blank<>0 THEN
    RAISE EXCEPTION 'Validação V/F falhou: questões=%, alternativas=%, vazias=%',
      v_questions,v_alternatives,v_blank;
  END IF;
END $$;

COMMIT;

SELECT count(*) AS questions, count(a.id) AS alternatives
FROM public.questions q
JOIN public.alternatives a ON a.question_id=q.id
WHERE q.reference='Prova 3 de Endocrinologia — bloco V/F separado em questões binárias no padrão MedQuiz.';
