-- Converte as questões discursivas da coletânea de Gastro P3 em questões
-- objetivas, sem duplicar os enunciados equivalentes das turmas 108/Louyse.
BEGIN;

CREATE OR REPLACE FUNCTION pg_temp.gastro_disc_uuid(seed text) RETURNS uuid
LANGUAGE sql IMMUTABLE AS $$
  SELECT (substr(md5(seed),1,8)||'-'||substr(md5(seed),9,4)||'-5'||substr(md5(seed),14,3)||'-a'||substr(md5(seed),18,3)||'-'||substr(md5(seed),21,12))::uuid
$$;

DO $$
DECLARE
  v_discipline_id uuid;
  v_topic_id uuid;
  v_question_id uuid;
  q record;
  a jsonb;
BEGIN
  SELECT id INTO v_discipline_id FROM public.disciplines
  WHERE slug='gastroenterologia' LIMIT 1;
  IF v_discipline_id IS NULL THEN
    RAISE EXCEPTION 'Disciplina Gastroenterologia não encontrada';
  END IF;

  FOR q IN SELECT * FROM jsonb_to_recordset($data$[
    {"k":"disc-iep-nutricao","topic":"Pancreatite crônica","d":"médio","s":"Paciente com suspeita de insuficiência pancreática exócrina leve apresenta perda ponderal discreta, sem esteatorreia evidente. Qual conjunto é mais apropriado para avaliar repercussão nutricional subclínica?","c":"A","g":"A insuficiência exócrina pode causar deficiência de vitaminas lipossolúveis e outros micronutrientes antes de esteatorreia exuberante.","sum":"Avalie peso, vitaminas lipossolúveis, B12, magnésio e parâmetros hematológicos.","mem":"IEP rouba gordura e vitaminas ADEK.","trap":"Amilase e lipase séricas não medem adequadamente a repercussão nutricional crônica.","alts":[["A","Peso e composição corporal, vitaminas A/D/E/K, vitamina B12, magnésio e hemograma/ferritina","Correta. O conjunto avalia estado corporal, micronutrientes e anemia associados à má digestão crônica."],["B","Somente amilase, lipase e proteína C-reativa","Incorreta. Esses exames não caracterizam o impacto nutricional da insuficiência exócrina."],["C","Apenas glicemia de jejum e hemoglobina glicada","Incorreta. Avaliam função endócrina, não o espectro da desnutrição exócrina."],["D","CEA, CA 19-9 e alfa-fetoproteína","Incorreta. Marcadores tumorais não fazem o diagnóstico nutricional de IEP."],["E","Bilirrubinas e fosfatase alcalina isoladamente","Incorreta. Avaliam colestase, não a repercussão nutricional global."]]},
    {"k":"disc-pc-imagem","topic":"Pancreatite crônica","d":"médio","s":"Qual conjunto reúne alterações morfológicas típicas de pancreatite crônica detectáveis por métodos de imagem?","c":"B","g":"A imagem pode mostrar calcificações, cálculos intraductais, irregularidade e dilatação ductal, atrofia ou aumento focal e pseudocistos.","sum":"Calcificação + ducto irregular/dilatado + atrofia são pistas fortes.","mem":"Pâncreas crônico: pedra, ducto torto e glândula atrófica.","trap":"Imagem normal não exclui doença inicial.","alts":[["A","Edema difuso isolado, líquido peripancreático e necrose aguda","Incorreta. O conjunto descreve sobretudo pancreatite aguda."],["B","Calcificações, cálculos intraductais, irregularidade/dilatação ductal, atrofia e pseudocistos","Correta. São alterações estruturais clássicas de pancreatite crônica."],["C","Espessamento da parede vesicular, cálculo impactado e sinal de Murphy ultrassonográfico","Incorreta. São achados de colecistite aguda."],["D","Dilatação exclusiva das vias biliares sem alteração pancreática","Incorreta. Não caracteriza pancreatite crônica."],["E","Pneumoperitônio e extravasamento de contraste gastrointestinal","Incorreta. Indicam perfuração de víscera oca."]]},
    {"k":"disc-crohn-diagnostico","topic":"Doença de Crohn","d":"médio","s":"Homem jovem apresenta dor em fossa ilíaca direita, diarreia crônica, perda ponderal e suspeita de Crohn do íleo terminal. Qual estratégia estabelece melhor o diagnóstico?","c":"C","g":"O diagnóstico de Crohn resulta da integração clínica, laboratorial, endoscópica, histológica e de imagem; nenhum achado isolado é obrigatório.","sum":"Ileocolonoscopia com biópsias e enterografia avaliam mucosa, extensão e complicações.","mem":"Crohn se confirma juntando peças.","trap":"Granuloma não caseoso é específico quando presente, porém pouco sensível.","alts":[["A","Diagnóstico exclusivamente clínico, sem necessidade de excluir infecções","Incorreta. Infecções e outros mimetizadores precisam ser avaliados."],["B","Cápsula endoscópica como primeiro exame mesmo diante de estenose","Incorreta. Há risco de retenção; primeiro se avalia patência e estenose."],["C","Ileocolonoscopia com biópsias associada a enterografia por TC ou RM e exames laboratoriais","Correta. Integra avaliação mucosa, histológica e transmural."],["D","Sorologia isolada para ASCA","Incorreta. Marcadores sorológicos não estabelecem isoladamente o diagnóstico."],["E","Laparotomia exploradora em todos os casos","Incorreta. Cirurgia não é método diagnóstico inicial rotineiro."]]},
    {"k":"disc-roma-iv","topic":"Síndrome do intestino irritável","d":"fácil","s":"Qual alternativa descreve corretamente os critérios de Roma IV para síndrome do intestino irritável?","c":"D","g":"Roma IV exige dor abdominal recorrente, em média, ao menos um dia por semana nos últimos três meses, associada à defecação e/ou mudança da frequência ou forma das fezes, com início há pelo menos seis meses.","sum":"Dor semanal por 3 meses; início há 6 meses; relação com evacuação, frequência ou forma.","mem":"SII: 1 dia/semana, 3 meses, começou há 6.","trap":"A dor pode melhorar ou piorar com a defecação; não precisa necessariamente aliviar.","alts":[["A","Diarreia diária por quatro semanas, independentemente de dor","Incorreta. Dor abdominal recorrente é elemento central."],["B","Dor mensal por três meses obrigatoriamente aliviada pela evacuação","Incorreta. A frequência mínima é maior e a relação não exige alívio."],["C","Distensão após refeições com colonoscopia normal","Incorreta. Não preenche, por si, os critérios clínicos."],["D","Dor abdominal ao menos um dia por semana nos últimos três meses, relacionada à defecação e/ou à mudança da frequência ou forma das fezes, com início há seis meses","Correta. Resume os critérios de Roma IV."],["E","Constipação ou diarreia por seis meses, mesmo sem dor","Incorreta. Isso pode corresponder a outro distúrbio funcional intestinal."]]},
    {"k":"disc-rcu-crohn-histo","topic":"Doenças inflamatórias intestinais","d":"médio","s":"Qual alternativa diferencia corretamente os padrões histopatológicos típicos da retocolite ulcerativa e da doença de Crohn?","c":"A","g":"RCU apresenta inflamação mucosa contínua e distorção arquitetural; Crohn é segmentar, transmural e pode ter granulomas não caseosos.","sum":"RCU: mucosa e criptas; Crohn: transmural e granuloma.","mem":"Crohn cruza camadas; RCU corre pela mucosa.","trap":"Ausência de granuloma não exclui Crohn.","alts":[["A","RCU: inflamação predominantemente mucosa com distorção de criptas; Crohn: inflamação transmural e granulomas não caseosos possíveis","Correta. É a distinção histopatológica clássica."],["B","RCU: granulomas caseosos; Crohn: inflamação exclusivamente epitelial","Incorreta. Granulomas caseosos sugerem tuberculose, e Crohn é transmural."],["C","RCU: lesões salteadas; Crohn: comprometimento contínuo obrigatório desde o reto","Incorreta. A distribuição típica está invertida."],["D","As duas doenças são histologicamente idênticas em todos os casos","Incorreta. Pode haver sobreposição, mas existem padrões distintos."],["E","Células caliciformes sempre ausentes em Crohn e preservadas na RCU ativa","Incorreta. Essa regra absoluta não é válida."]]},
    {"k":"disc-sii-epidemiologia","topic":"Síndrome do intestino irritável","d":"fácil","s":"Qual perfil epidemiológico é mais compatível com síndrome do intestino irritável?","c":"B","g":"SII é comum em adultos jovens e de meia-idade e é diagnosticada mais frequentemente em mulheres, embora possa ocorrer em qualquer sexo e idade.","sum":"Comum, início frequentemente jovem e maior procura/diagnóstico entre mulheres.","mem":"SII costuma começar cedo, mas não tem idade exclusiva.","trap":"Não transforme predominância estatística em critério diagnóstico.","alts":[["A","Doença exclusiva de homens idosos","Incorreta. Pode ocorrer em idosos, mas não é exclusiva nem predominante nesse grupo."],["B","Condição comum, frequentemente iniciada antes dos 50 anos e mais diagnosticada em mulheres","Correta. É o perfil epidemiológico habitual."],["C","Doença rara restrita à infância","Incorreta. É comum na população adulta."],["D","Síndrome limitada a pessoas com doença inflamatória intestinal","Incorreta. SII é um distúrbio da interação cérebro-intestino distinto da DII."],["E","Condição necessariamente pós-infecciosa","Incorreta. Existe SII pós-infecciosa, mas não é a única forma."]]},
    {"k":"disc-dii-pele","topic":"Doenças inflamatórias intestinais","d":"médio","s":"Qual conjunto contém manifestações cutâneas reconhecidas das doenças inflamatórias intestinais?","c":"E","g":"Eritema nodoso e pioderma gangrenoso são associações clássicas; também podem ocorrer síndrome de Sweet, aftas e lesões relacionadas a deficiências ou terapias.","sum":"Eritema nodoso e pioderma gangrenoso são as duas associações de prova.","mem":"DII na pele: nódulo vermelho e úlcera dolorosa.","trap":"Dermatite herpetiforme aponta principalmente para doença celíaca.","alts":[["A","Herpes-zóster e vitiligo exclusivamente","Incorreta. Não são o conjunto clássico específico de DII."],["B","Dermatite herpetiforme e acantose nigricans","Incorreta. Dermatite herpetiforme associa-se fortemente à doença celíaca."],["C","Melasma e queratose seborreica","Incorreta. Não são manifestações típicas de DII."],["D","Psoríase pustulosa e impetigo obrigatoriamente","Incorreta. A formulação absoluta é inadequada."],["E","Eritema nodoso e pioderma gangrenoso","Correta. Ambas são manifestações cutâneas clássicas de DII."]]},
    {"k":"disc-diarreia-funcional-organica","topic":"Diarreia crônica","d":"médio","s":"Qual achado favorece diarreia orgânica, em vez de síndrome do intestino irritável com diarreia?","c":"C","g":"Diarreia noturna, sangue, febre, anemia, perda ponderal, hipoalbuminemia e marcadores inflamatórios elevados são sinais de alarme.","sum":"Orgânica acorda, sangra, inflama e emagrece.","mem":"SII não causa anemia nem inflamação estrutural.","trap":"Muco claro e piora pós-prandial podem ocorrer na SII.","alts":[["A","Piora após refeições e em períodos de estresse","Incorreta. É comum em distúrbios funcionais."],["B","Melhora após evacuar, sem perda ponderal","Incorreta. Favorece SII."],["C","Evacuações noturnas com anemia e perda ponderal","Correta. É um conjunto de sinais de alarme orgânicos."],["D","Exame físico normal e sintomas flutuantes","Incorreta. Pode ocorrer na SII."],["E","Presença ocasional de muco transparente","Incorreta. Não distingue, isoladamente, doença orgânica."]]},
    {"k":"disc-constipacao-tratamento","topic":"Constipação intestinal","d":"médio","s":"Adulto jovem com constipação crônica, sem sinais de alarme, não melhorou com orientação inicial. Qual estratégia é mais apropriada?","c":"A","g":"O manejo começa com educação, rotina evacuatória, fibra quando tolerada e atividade; polietilenoglicol é opção farmacológica bem sustentada.","sum":"Hábitos e fibra; depois PEG; investigar refratariedade ou sinais de alarme.","mem":"Constipação: rotina, fibra, água adequada e PEG.","trap":"Aumentar fibra pode piorar distensão em alguns pacientes e deve ser individualizado.","alts":[["A","Revisar medicamentos, orientar hábitos e fibra solúvel e considerar polietilenoglicol","Correta. É abordagem inicial escalonada e baseada em evidência."],["B","Solicitar colectomia antes de tentativa medicamentosa","Incorreta. Cirurgia é excepcional e exige investigação funcional extensa."],["C","Prescrever opioide para reduzir a dor evacuatória","Incorreta. Opioides pioram constipação."],["D","Indicar colonoscopia mensal até normalizar as fezes","Incorreta. Não há indicação sem critérios de rastreio ou alarme."],["E","Restringir líquidos e suspender atividade física","Incorreta. Não contribui para o manejo adequado."]]},
    {"k":"disc-diarreia-mecanismos","topic":"Diarreia crônica","d":"médio","s":"Qual associação entre mecanismo de diarreia e exemplo clínico está correta?","c":"D","g":"Osmótica decorre de solutos não absorvidos; secretora persiste no jejum; inflamatória exsuda sangue/proteína; motora altera o tempo de trânsito.","sum":"Lactose osmótica; toxina secretora; DII inflamatória; hipertireoidismo motora.","mem":"O-S-I-M: osmose, secreção, inflamação, movimento.","trap":"Uma doença pode combinar mais de um mecanismo.","alts":[["A","Intolerância à lactose — diarreia secretora que persiste no jejum","Incorreta. É predominantemente osmótica e melhora com jejum."],["B","Colite ulcerativa — diarreia motora sem inflamação","Incorreta. É diarreia inflamatória/exsudativa."],["C","Cólera — diarreia osmótica causada por má absorção de lactose","Incorreta. É secretora mediada por toxina."],["D","Hipertireoidismo — diarreia motora por trânsito acelerado","Correta. O aumento da motilidade reduz o tempo de absorção."],["E","Insuficiência pancreática — diarreia puramente inflamatória","Incorreta. Causa má digestão e esteatorreia."]]},
    {"k":"disc-sii-estresse","topic":"Síndrome do intestino irritável","d":"médio","s":"Como o estresse pode exacerbar sintomas da síndrome do intestino irritável?","c":"B","g":"A comunicação bidirecional cérebro-intestino modula motilidade, secreção, percepção visceral, barreira e microbiota; estresse não implica lesão estrutural obrigatória.","sum":"Estresse amplifica sinal visceral e altera motilidade pelo eixo cérebro-intestino.","mem":"O cérebro aumenta o volume do sinal intestinal.","trap":"SII não é imaginária: há alterações neurogastroenterológicas mensuráveis.","alts":[["A","Produz ulceração transmural progressiva do íleo","Incorreta. Isso sugeriria doença orgânica como Crohn."],["B","Modula o eixo cérebro-intestino, aumentando hipersensibilidade visceral e alterando motilidade e secreção","Correta. É o mecanismo central aceito."],["C","Bloqueia permanentemente a produção de enzimas pancreáticas","Incorreta. Não é mecanismo de SII."],["D","Causa autoanticorpos contra a transglutaminase","Incorreta. Isso se relaciona à doença celíaca."],["E","Provoca obstrução mecânica recorrente do cólon","Incorreta. SII não causa obstrução estrutural."]]},
    {"k":"disc-crohn-grave","topic":"Doença de Crohn","d":"difícil","s":"Paciente com Crohn ileal apresenta estenose sintomática e fístula, com atividade inflamatória importante. Qual princípio terapêutico é mais adequado?","c":"E","g":"Doença penetrante ou estenosante exige avaliação multidisciplinar; abscessos devem ser drenados, inflamação tratada com terapia avançada e fibrose fixa pode exigir dilatação ou cirurgia.","sum":"Inflamação responde a fármacos; fibrose e complicações mecânicas podem exigir procedimento.","mem":"Crohn complicado: drene, controle inflamação e corrija mecânica.","trap":"Corticoide não fecha fístula nem reverte estenose fibrótica.","alts":[["A","Mesalazina isolada é suficiente para toda doença fistulizante","Incorreta. Não é tratamento adequado para doença penetrante moderada/grave."],["B","Corticoide deve ser mantido indefinidamente","Incorreta. Corticoide induz, mas não mantém remissão e causa toxicidade."],["C","Toda estenose responde completamente a anti-inflamatório","Incorreta. Estenose fibrótica não regride de forma confiável com fármacos."],["D","Abscesso deve receber imunossupressão imediata sem drenagem ou antibiótico","Incorreta. Primeiro controla-se a sepse, frequentemente com drenagem e antibióticos."],["E","Avaliar imagem e sepse; drenar abscesso, usar terapia avançada para inflamação e indicar dilatação/cirurgia para complicação fibrótica selecionada","Correta. Individualiza componentes inflamatórios, sépticos e mecânicos."]]},
    {"k":"disc-rcu-grave","topic":"Retocolite ulcerativa","d":"difícil","s":"Homem de 32 anos apresenta mais de dez evacuações sanguinolentas ao dia, febre, prostração, anemia e perda ponderal. Confirmada colite ulcerativa aguda grave, qual conduta inicial é mais apropriada?","c":"C","g":"Colite ulcerativa aguda grave exige internação, exclusão de infecção, profilaxia tromboembólica, corticoide intravenoso e reavaliação precoce para resgate ou colectomia.","sum":"ASUC: interne, pesquise C. difficile, dê corticoide IV e reavalie no dia 3.","mem":"Grave no hospital; dia 3 decide resgate.","trap":"Antidiarreicos, opioides e anticolinérgicos aumentam risco de megacólon.","alts":[["A","Loperamida em alta dose e alta domiciliar","Incorreta. Pode precipitar dilatação colônica e o quadro exige internação."],["B","Mesalazina tópica isolada por oito semanas","Incorreta. É insuficiente para colite aguda grave."],["C","Internação, investigação infecciosa, profilaxia de trombose e corticoide intravenoso, com avaliação de resposta em três dias","Correta. É o manejo inicial padrão."],["D","Antibiótico amplo de rotina como único tratamento","Incorreta. Antibiótico não é rotina sem suspeita de infecção/complicação."],["E","Nutrição parenteral obrigatória para repouso intestinal","Incorreta. Não é recomendada apenas para repouso intestinal."]]},
    {"k":"disc-diverticulite-idoso","topic":"Doença diverticular","d":"médio","s":"Homem de 65 anos apresenta dor em fossa ilíaca esquerda, febre, calafrios, leucocitose e episódio semelhante prévio. Qual abordagem melhor esclarece e conduz o caso?","c":"A","g":"Diverticulite é hipótese principal; TC com contraste estratifica complicações. Tratamento depende de gravidade, com cirurgia urgente em peritonite ou falha do controle séptico.","sum":"FIE + febre: TC para confirmar e classificar.","mem":"Diverticulite vê-se na TC.","trap":"Colonoscopia é evitada na fase aguda e feita após resolução quando indicada.","alts":[["A","Suspeitar diverticulite, solicitar TC de abdome/pelve e tratar conforme presença de abscesso, perfuração ou instabilidade","Correta. Confirma diagnóstico e orienta tratamento ambulatorial, internação, drenagem ou cirurgia."],["B","Realizar colonoscopia imediatamente durante a crise","Incorreta. Aumenta risco de perfuração e não é exame inicial da fase aguda."],["C","Diagnosticar SII e prescrever apenas fibra","Incorreta. Febre e leucocitose indicam processo inflamatório orgânico."],["D","Solicitar somente radiografia simples e descartar doença se normal","Incorreta. Radiografia normal não exclui diverticulite."],["E","Indicar colectomia total para todo primeiro episódio","Incorreta. Cirurgia é individualizada conforme complicações e evolução."]]}
  ]$data$::jsonb) AS x(k text,topic text,d text,s text,c text,g text,sum text,mem text,trap text,alts jsonb)
  LOOP
    SELECT id INTO v_topic_id FROM public.topics
    WHERE discipline_id=v_discipline_id AND name=q.topic LIMIT 1;
    IF v_topic_id IS NULL THEN
      v_topic_id:=pg_temp.gastro_disc_uuid('gastro-topic-'||q.topic);
      INSERT INTO public.topics(id,discipline_id,name)
      VALUES(v_topic_id,v_discipline_id,q.topic)
      ON CONFLICT(id) DO UPDATE SET name=EXCLUDED.name;
    END IF;

    v_question_id:=pg_temp.gastro_disc_uuid('gastro-p3-'||q.k);
    INSERT INTO public.questions(
      id,discipline_id,topic_id,exam,difficulty,statement,question_type,
      correct_answer,correct_answers,general_comment,summary,memory_tip,trap,
      reference,active,image_url
    ) VALUES(
      v_question_id,v_discipline_id,v_topic_id,'P3',q.d,q.s,'single',
      q.c,ARRAY[q.c],q.g,q.sum,q.mem,q.trap,
      'Prova 3 de Gastroenterologia — payload deduplicado e revisado em 2026.',true,NULL
    ) ON CONFLICT(id) DO UPDATE SET
      topic_id=EXCLUDED.topic_id,exam='P3',difficulty=EXCLUDED.difficulty,
      statement=EXCLUDED.statement,question_type='single',
      correct_answer=EXCLUDED.correct_answer,correct_answers=EXCLUDED.correct_answers,
      general_comment=EXCLUDED.general_comment,summary=EXCLUDED.summary,
      memory_tip=EXCLUDED.memory_tip,trap=EXCLUDED.trap,reference=EXCLUDED.reference,
      active=true,image_url=NULL;

    DELETE FROM public.alternatives WHERE question_id=v_question_id;
    FOR a IN SELECT value FROM jsonb_array_elements(q.alts)
    LOOP
      INSERT INTO public.alternatives(id,question_id,letter,text,explanation)
      VALUES(pg_temp.gastro_disc_uuid(v_question_id::text||(a->>0)),v_question_id,a->>0,a->>1,a->>2);
    END LOOP;
  END LOOP;
END $$;

DO $$
DECLARE
  v_discursive_conversions integer;
  v_blank integer;
BEGIN
  SELECT count(*) INTO v_discursive_conversions
  FROM public.questions
  WHERE id IN (
    SELECT pg_temp.gastro_disc_uuid('gastro-p3-'||key)
    FROM unnest(ARRAY[
      'disc-iep-nutricao','disc-pc-imagem','disc-crohn-diagnostico','disc-roma-iv',
      'disc-rcu-crohn-histo','disc-sii-epidemiologia','disc-dii-pele',
      'disc-diarreia-funcional-organica','disc-constipacao-tratamento',
      'disc-diarreia-mecanismos','disc-sii-estresse','disc-crohn-grave',
      'disc-rcu-grave','disc-diverticulite-idoso'
    ]) AS keys(key)
  );

  SELECT count(*) INTO v_blank
  FROM public.alternatives a JOIN public.questions q ON q.id=a.question_id
  WHERE q.id IN (
    SELECT pg_temp.gastro_disc_uuid('gastro-p3-'||key)
    FROM unnest(ARRAY[
      'disc-iep-nutricao','disc-pc-imagem','disc-crohn-diagnostico','disc-roma-iv',
      'disc-rcu-crohn-histo','disc-sii-epidemiologia','disc-dii-pele',
      'disc-diarreia-funcional-organica','disc-constipacao-tratamento',
      'disc-diarreia-mecanismos','disc-sii-estresse','disc-crohn-grave',
      'disc-rcu-grave','disc-diverticulite-idoso'
    ]) AS keys(key)
  ) AND (coalesce(trim(a.text),'')='' OR coalesce(trim(a.explanation),'')='');

  IF v_discursive_conversions<>14 OR v_blank<>0 THEN
    RAISE EXCEPTION 'Auditoria das discursivas falhou: convertidas=%, campos vazios=%',
      v_discursive_conversions,v_blank;
  END IF;
END $$;

COMMIT;
