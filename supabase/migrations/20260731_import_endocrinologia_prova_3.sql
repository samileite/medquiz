-- Payload MedQuiz — Prova 3 de Endocrinologia (18 questões objetivas).
-- A questão originalmente aberta foi objetivada e o gabarito inconsistente da
-- questão 4 foi corrigido conforme diretriz da Endocrine Society.
BEGIN;

CREATE OR REPLACE FUNCTION pg_temp.endo_p3_uuid(seed text) RETURNS uuid
LANGUAGE sql IMMUTABLE AS $$
  SELECT (substr(md5(seed),1,8)||'-'||substr(md5(seed),9,4)||'-5'||substr(md5(seed),14,3)||'-a'||substr(md5(seed),18,3)||'-'||substr(md5(seed),21,12))::uuid
$$;

DO $$
DECLARE
  v_discipline_id uuid;
  v_topic_id uuid;
  v_question_id uuid;
  r record;
  a jsonb;
BEGIN
  SELECT id INTO v_discipline_id FROM public.disciplines
  WHERE name='Endocrinologia' LIMIT 1;
  IF v_discipline_id IS NULL THEN
    RAISE EXCEPTION 'Disciplina Endocrinologia não encontrada';
  END IF;

  FOR r IN
    SELECT * FROM jsonb_to_recordset($data$[
      {
        "n":1,"topic":"Hipófise — Hipofunção","difficulty":"fácil",
        "statement":"Considere A = hipotálamo, B = adeno-hipófise e C = órgão-alvo. Sabendo que lesões no órgão-alvo são primárias, na hipófise são secundárias e no hipotálamo são terciárias, qual correlação está correta?",
        "correct":"B",
        "general":"A classificação acompanha o nível anatômico da falha endócrina: órgão-alvo é primário, hipófise é secundário e hipotálamo é terciário. Logo, A3B2C1.",
        "summary":"Órgão-alvo = primário; hipófise = secundário; hipotálamo = terciário.",
        "memory":"Do periférico para o central: 1 → 2 → 3.",
        "trap":"Não numerar o eixo pela ordem anatômica de cima para baixo.",
        "alts":[
          {"l":"A","t":"A1B2C3","e":"Incorreta. O hipotálamo não corresponde ao nível primário, e o órgão-alvo não corresponde ao terciário."},
          {"l":"B","t":"A3B2C1","e":"Correta. A falha hipotalâmica é terciária, a hipofisária é secundária e a do órgão-alvo é primária."},
          {"l":"C","t":"A2B3C1","e":"Incorreta. Embora C1 esteja correto, hipotálamo e hipófise foram trocados."},
          {"l":"D","t":"A3B1C2","e":"Incorreta. A3 está correto, mas hipófise não é primária e órgão-alvo não é secundário."},
          {"l":"E","t":"A2B1C3","e":"Incorreta. As três estruturas foram associadas a níveis inadequados."}
        ]
      },
      {
        "n":2,"topic":"Suprarrenal","difficulty":"médio",
        "statement":"Sobre o hiperaldosteronismo primário, assinale a alternativa correta.",
        "correct":"E",
        "general":"As causas mais frequentes são adenoma produtor de aldosterona e hiperplasia adrenal bilateral. Doença unilateral pode ser tratada cirurgicamente; doença bilateral costuma receber antagonista do receptor mineralocorticoide.",
        "summary":"APA e hiperplasia bilateral são as principais etiologias do hiperaldosteronismo primário.",
        "memory":"Unilateral: cirurgia; bilateral: espironolactona ou eplerenona.",
        "trap":"Hipocalemia não está presente em todos os casos.",
        "alts":[
          {"l":"A","t":"A hiperplasia adrenal bilateral deve ser tratada com adrenalectomia bilateral.","e":"Incorreta. A retirada bilateral causaria insuficiência adrenal; o tratamento usual é antagonista mineralocorticoide."},
          {"l":"B","t":"A aldosterona elevada provoca retenção de sódio e hipercalemia.","e":"Incorreta. A aldosterona aumenta a excreção renal de potássio, podendo causar hipocalemia."},
          {"l":"C","t":"A maioria dos pacientes com hiperaldosteronismo primário é normotensa.","e":"Incorreta. Hipertensão é manifestação central, embora possa variar em gravidade."},
          {"l":"D","t":"O adenoma produtor de aldosterona é tipicamente grande e maligno.","e":"Incorreta. O APA costuma ser pequeno e benigno; carcinoma produtor de aldosterona é raro."},
          {"l":"E","t":"As duas principais etiologias são adenoma produtor de aldosterona e hiperplasia adrenal bilateral.","e":"Correta. Essas entidades respondem pela maior parte dos casos e exigem estratégias terapêuticas diferentes."}
        ]
      },
      {
        "n":3,"topic":"Metabolismo ósseo e paratireoide","difficulty":"médio",
        "statement":"Mulher de 70 anos apresenta fratura de quadril, PTH de 542 pg/mL, cálcio de 11,3 mg/dL, fósforo baixo e microcálculos renais. Qual diagnóstico e mecanismo explicam melhor o quadro?",
        "correct":"C",
        "general":"Hipercalcemia com PTH inapropriadamente alto e hipofosfatemia aponta para hiperparatireoidismo primário. O PTH aumenta reabsorção tubular de cálcio, fosfatúria, calcitriol e reabsorção óssea mediada por osteoclastos.",
        "summary":"PTH alto com hipercalcemia sugere hiperparatireoidismo primário.",
        "memory":"PTH sobe cálcio e derruba fósforo.",
        "trap":"Na hipercalcemia não mediada por PTH, o PTH deveria estar suprimido.",
        "alts":[
          {"l":"A","t":"Hipercalcemia da malignidade por PTHrP, com supressão do PTH endógeno.","e":"Incorreta. O PTH está marcadamente elevado, enquanto na hipercalcemia por PTHrP ele tende a estar suprimido."},
          {"l":"B","t":"Hipoparatireoidismo, por redução da reabsorção renal de cálcio.","e":"Incorreta. Hipoparatireoidismo produz PTH baixo, hipocalcemia e hiperfosfatemia."},
          {"l":"C","t":"Hiperparatireoidismo primário, com aumento da reabsorção óssea, retenção renal de cálcio e fosfatúria.","e":"Correta. O conjunto hipercalcemia, PTH alto, fósforo baixo, litíase e fragilidade óssea é típico."},
          {"l":"D","t":"Deficiência isolada de vitamina D, com elevação primária do cálcio sérico.","e":"Incorreta. Deficiência de vitamina D costuma reduzir ou normalizar o cálcio e causar hiperparatireoidismo secundário."},
          {"l":"E","t":"Síndrome de lise tumoral, por liberação de cálcio do conteúdo intracelular.","e":"Incorreta. Lise tumoral associa-se mais a hiperfosfatemia, hipocalcemia, hiperuricemia e lesão renal."}
        ]
      },
      {
        "n":4,"topic":"Suprarrenal","difficulty":"médio",
        "statement":"Qual situação, isoladamente, NÃO constitui indicação clássica para rastreamento bioquímico da síndrome de Cushing?",
        "correct":"A",
        "general":"Rastreia-se Cushing em pacientes com sinais múltiplos e progressivos, manifestações incomuns para a idade, criança com queda de crescimento e ganho de peso e incidentaloma adrenal. Incidentaloma hipofisário isolado não é indicação clássica.",
        "summary":"O rastreamento deve ser dirigido pela probabilidade clínica e pelo incidentaloma adrenal.",
        "memory":"Cushing: progressão, sinais discriminatórios, idade atípica e adrenal incidental.",
        "trap":"O gabarito histórico marcava incidentaloma adrenal, mas diretrizes o incluem entre as indicações.",
        "alts":[
          {"l":"A","t":"Incidentaloma hipofisário sem sinais clínicos de hipercortisolismo.","e":"Correta. A presença isolada de lesão hipofisária não justifica rastrear Cushing sem contexto clínico ou funcional."},
          {"l":"B","t":"Criança com redução da velocidade de crescimento e ganho progressivo de peso.","e":"Incorreta. Essa combinação é indicação importante, pois obesidade simples geralmente preserva crescimento linear."},
          {"l":"C","t":"Obesidade central associada a hipertensão, diabetes e sinais progressivos sugestivos.","e":"Incorreta. A multiplicidade e progressão de manifestações aumentam a probabilidade pré-teste e justificam avaliação."},
          {"l":"D","t":"Osteoporose ou hipertensão incomuns para a idade.","e":"Incorreta. Manifestações desproporcionais à idade são indicação recomendada de rastreamento."},
          {"l":"E","t":"Incidentaloma adrenal compatível com adenoma.","e":"Incorreta. Incidentaloma adrenal requer avaliação de secreção autônoma de cortisol, geralmente com dexametasona 1 mg."}
        ]
      },
      {
        "n":5,"topic":"Suprarrenal","difficulty":"fácil",
        "statement":"Qual das condições abaixo causa síndrome de Cushing ACTH-independente?",
        "correct":"C",
        "general":"Tumores e hiperplasias adrenais podem secretar cortisol autonomamente, suprimindo ACTH. Doença de Cushing e secreção ectópica são ACTH-dependentes.",
        "summary":"Cortisol adrenal autônomo suprime o ACTH.",
        "memory":"Adrenal produz cortisol sozinho: ACTH baixo.",
        "trap":"Doença de Cushing significa adenoma hipofisário produtor de ACTH.",
        "alts":[
          {"l":"A","t":"Pseudo-Cushing associado a álcool ou depressão.","e":"Incorreta. É ativação funcional do eixo, não produção adrenal autônoma verdadeira."},
          {"l":"B","t":"Tumor carcinoide produtor de ACTH.","e":"Incorreta. Secreção ectópica de ACTH é, por definição, ACTH-dependente."},
          {"l":"C","t":"Tumor adrenal produtor de cortisol.","e":"Correta. A secreção autônoma adrenal eleva cortisol e suprime o ACTH hipofisário."},
          {"l":"D","t":"Adenoma hipofisário corticotrófico.","e":"Incorreta. A doença de Cushing hipofisária depende de ACTH."},
          {"l":"E","t":"Carcinoma medular da tireoide produtor de ACTH.","e":"Incorreta. Quando há produção ectópica de ACTH, o mecanismo continua sendo ACTH-dependente."}
        ]
      },
      {
        "n":6,"topic":"Suprarrenal","difficulty":"médio",
        "statement":"Mulher de 38 anos com feocromocitoma e pressão arterial de 190×105 mmHg será preparada para cirurgia. Qual classe anti-hipertensiva deve ser iniciada primeiro?",
        "correct":"E",
        "general":"O preparo começa com bloqueio alfa para controlar vasoconstrição e permitir expansão volêmica. Betabloqueador, se necessário para taquicardia, só deve ser acrescentado após alfa-bloqueio adequado.",
        "summary":"No feocromocitoma, alfa antes de beta.",
        "memory":"Nunca beta primeiro: alfa → volume → beta se necessário.",
        "trap":"Betabloqueio isolado deixa vasoconstrição alfa sem oposição.",
        "alts":[
          {"l":"A","t":"Diurético tiazídico.","e":"Incorreta. Pode agravar a contração volêmica e não bloqueia o efeito catecolaminérgico principal."},
          {"l":"B","t":"Nifedipina como única preparação obrigatória.","e":"Incorreta. Bloqueador de cálcio pode complementar ou ser alternativa selecionada, mas alfa-bloqueio é a estratégia clássica inicial."},
          {"l":"C","t":"Losartana.","e":"Incorreta. Bloquear o receptor de angiotensina não neutraliza adequadamente as crises catecolaminérgicas."},
          {"l":"D","t":"Betabloqueador antes de qualquer outra droga.","e":"Incorreta. Pode causar crise hipertensiva por estimulação alfa-adrenérgica sem oposição."},
          {"l":"E","t":"Alfa-1 bloqueador, como doxazosina ou prazosina.","e":"Correta. Promove controle da vasoconstrição antes de eventual betabloqueio e da cirurgia."}
        ]
      },
      {
        "n":7,"topic":"Suprarrenal","difficulty":"médio",
        "statement":"Mulher de 19 anos apresenta ganho de peso, estrias violáceas, cortisol livre urinário elevado e ausência de supressão após dexametasona. Qual alternativa está correta?",
        "correct":"C",
        "general":"Após confirmar hipercortisolismo, mede-se ACTH para orientar a etiologia. A causa endógena mais comum é doença de Cushing por adenoma hipofisário corticotrófico.",
        "summary":"A doença de Cushing hipofisária é a causa mais comum de Cushing endógeno.",
        "memory":"Endógeno: pense primeiro em ACTH hipofisário.",
        "trap":"Não indicar adrenalectomia antes de localizar e classificar a origem.",
        "alts":[
          {"l":"A","t":"O quadro está confirmado como pseudo-Cushing por depressão.","e":"Incorreta. O fenótipo e testes anormais exigem investigação; depressão isolada não confirma pseudo-Cushing."},
          {"l":"B","t":"A próxima conduta obrigatória é adrenalectomia direita.","e":"Incorreta. Ainda é necessário medir ACTH e localizar a fonte antes de qualquer cirurgia."},
          {"l":"C","t":"A causa mais comum de Cushing endógeno é adenoma hipofisário produtor de ACTH.","e":"Correta. A doença de Cushing responde pela maior parcela dos casos endógenos."},
          {"l":"D","t":"Cateterismo de seios petrosos é o padrão-ouro para diagnosticar pseudo-Cushing.","e":"Incorreta. O exame diferencia fonte hipofisária de ectópica em casos ACTH-dependentes selecionados."},
          {"l":"E","t":"Tumor adrenal produtor de cortisol é ACTH-dependente.","e":"Incorreta. Produção adrenal autônoma suprime ACTH e é ACTH-independente."}
        ]
      },
      {
        "n":8,"topic":"Hipófise — Hiperfunção","difficulty":"fácil",
        "statement":"Alan, 39 anos, apresenta hipertensão, cefaleia, fadiga, artralgia, cirurgia prévia por túnel do carpo, aumento de anel e calçado, redução da libido, sudorese e ronco. Diante da suspeita de acromegalia, qual é o primeiro exame?",
        "correct":"D",
        "general":"O IGF-1 ajustado para idade é o melhor teste inicial, pois integra a secreção de GH e não sofre a mesma pulsatilidade do GH aleatório. Resultado elevado ou equívoco requer confirmação apropriada.",
        "summary":"Suspeita de acromegalia começa com IGF-1.",
        "memory":"IGF-1 rastreia; TOTG confirma; RNM localiza.",
        "trap":"Não pedir imagem antes da confirmação bioquímica.",
        "alts":[
          {"l":"A","t":"Teste oral de tolerância à glicose com GH.","e":"Incorreta. É usado para confirmação quando IGF-1 está elevado ou equívoco, não como primeiro passo habitual."},
          {"l":"B","t":"Ressonância magnética de hipófise.","e":"Incorreta. A imagem localiza o adenoma após estabelecer evidência bioquímica."},
          {"l":"C","t":"Dosagem de GHRH.","e":"Incorreta. Tumores ectópicos produtores de GHRH são raros e a dosagem não é rastreio inicial."},
          {"l":"D","t":"Dosagem sérica de IGF-1 ajustada para idade.","e":"Correta. O IGF-1 é mais estável que o GH aleatório e constitui o teste inicial recomendado."},
          {"l":"E","t":"Dosagem isolada de IGFBP-3.","e":"Incorreta. IGFBP-3 não substitui IGF-1 no rastreamento de acromegalia em adultos."}
        ]
      },
      {
        "n":9,"topic":"Hipófise — Hiperfunção","difficulty":"médio",
        "statement":"Mulher de 34 anos apresenta fadiga, ganho de peso, ciclos irregulares, galactorreia, bócio pequeno e pele seca. TSH 72 mUI/L, T4 livre 0,3 ng/dL e prolactina 55 ng/mL, confirmados. Qual é o próximo passo?",
        "correct":"A",
        "general":"Hipotireoidismo primário grave aumenta TRH, que estimula prolactina. O tratamento com levotiroxina corrige a causa e frequentemente normaliza a hiperprolactinemia.",
        "summary":"Hipotireoidismo primário pode elevar prolactina por excesso de TRH.",
        "memory":"TSH muito alto + T4L baixo + PRL moderada: trate a tireoide.",
        "trap":"Não diagnosticar prolactinoma antes de corrigir causa secundária evidente.",
        "alts":[
          {"l":"A","t":"Iniciar levotiroxina e reavaliar TSH, T4 livre e prolactina.","e":"Correta. Trata a causa primária e permite verificar a reversão da hiperprolactinemia."},
          {"l":"B","t":"Solicitar imediatamente ressonância de hipófise.","e":"Incorreta. A causa secundária está evidente e deve ser corrigida antes de imagem, salvo sinais compressivos relevantes."},
          {"l":"C","t":"Iniciar estrogênio para regularizar os ciclos.","e":"Incorreta. Não corrige o hipotireoidismo e pode interferir no eixo reprodutivo e na interpretação clínica."},
          {"l":"D","t":"Iniciar agonista dopaminérgico.","e":"Incorreta. Cabergolina não é a primeira medida quando a elevação decorre de hipotireoidismo primário."},
          {"l":"E","t":"Repetir apenas a prolactina sem tratar.","e":"Incorreta. O resultado já foi confirmado e há hipotireoidismo franco que exige terapia."}
        ]
      },
      {
        "n":10,"topic":"Hipófise — Hiperfunção","difficulty":"fácil",
        "statement":"Sobre as causas de hiperprolactinemia, assinale a alternativa correta.",
        "correct":"D",
        "general":"Prolactinoma é o adenoma hipofisário funcionante mais frequente. Antes de diagnosticá-lo, excluem-se gestação, fármacos, hipotireoidismo, doença renal/hepática e macroprolactina conforme o contexto.",
        "summary":"Prolactinoma é o adenoma hipofisário funcionante mais comum.",
        "memory":"PRL: gestação, remédios, tireoide, rim/fígado, macroprolactina e prolactinoma.",
        "trap":"No hipotireoidismo primário, o TRH aumenta.",
        "alts":[
          {"l":"A","t":"A cirrose eleva prolactina por aumentar a depuração renal.","e":"Incorreta. Hepatopatia pode reduzir depuração e alterar regulação hormonal; não há aumento de clearance renal."},
          {"l":"B","t":"Macroprolactina responde por mais de 90% dos casos em homens.","e":"Incorreta. Essa proporção não corresponde à epidemiologia da macroprolactinemia."},
          {"l":"C","t":"Produção ectópica é a causa mais frequente de hiperprolactinemia.","e":"Incorreta. Produção ectópica é rara; causas fisiológicas, farmacológicas e hipofisárias são muito mais comuns."},
          {"l":"D","t":"Prolactinoma é o adenoma hipofisário funcionante mais frequente.","e":"Correta. É a neoplasia hipofisária secretora mais comum."},
          {"l":"E","t":"Hipotireoidismo primário eleva prolactina por diminuir TRH.","e":"Incorreta. A queda de T4 reduz retroalimentação e eleva TRH, que pode estimular prolactina."}
        ]
      },
      {
        "n":11,"topic":"Hipófise — Hipofunção","difficulty":"difícil",
        "statement":"JVCJ, 42 anos, com queda de libido, apresenta aumento difuso da hipófise e espessamento da haste, sugerindo hipofisite linfocítica. Qual alternativa integra corretamente diagnóstico e reposição?",
        "correct":"E",
        "general":"Hipofisite pode causar déficits centrais de eixos gonadal, tireoidiano e adrenal. A insuficiência adrenal deve ser tratada antes de iniciar levotiroxina para evitar crise adrenal.",
        "summary":"Hipofisite pode causar hipopituitarismo combinado; glicocorticoide vem antes de T4.",
        "memory":"No hipopituitarismo: cortisol primeiro, tireoide depois.",
        "trap":"Não repor levotiroxina antes de proteger o eixo adrenal.",
        "alts":[
          {"l":"A","t":"Hipogonadismo hipergonadotrófico, tratado apenas com testosterona.","e":"Incorreta. Lesão hipotálamo-hipofisária causa hipogonadismo hipogonadotrófico e pode comprometer outros eixos."},
          {"l":"B","t":"Insuficiência adrenal central isolada, sem necessidade de avaliar os demais eixos.","e":"Incorreta. Hipofisite frequentemente causa deficiências combinadas, exigindo avaliação hipofisária completa."},
          {"l":"C","t":"Hipertireoidismo central por liberação excessiva de TSH.","e":"Incorreta. O padrão esperado é hipotireoidismo central, com T4 livre baixo e TSH inadequadamente baixo ou normal."},
          {"l":"D","t":"Não há necessidade de reposição porque a lesão é inflamatória.","e":"Incorreta. Deficiências hormonais clinicamente relevantes devem ser repostas independentemente da etiologia inflamatória."},
          {"l":"E","t":"Hipogonadismo hipogonadotrófico, hipotireoidismo e insuficiência adrenal centrais; repor glicocorticoide, depois levotiroxina e testosterona quando indicada.","e":"Correta. Reconhece os déficits centrais e a sequência segura de reposição."}
        ]
      },
      {
        "n":12,"topic":"Hipófise — Hipofunção","difficulty":"fácil",
        "statement":"Criança de 10 anos, após cirurgia de tumor hipofisário, evolui com suspeita de diabetes insípido central. Qual achado é esperado?",
        "correct":"E",
        "general":"Deficiência de ADH reduz a reabsorção de água nos ductos coletores, causando grande volume de urina diluída, polidipsia e tendência a hipernatremia se a reposição hídrica for insuficiente.",
        "summary":"Diabetes insípido central causa poliúria hipotônica.",
        "memory":"Sem ADH: perde água livre.",
        "trap":"DI tende a hipernatremia, não hiponatremia.",
        "alts":[
          {"l":"A","t":"Pouco ADH aumenta a reabsorção renal de água.","e":"Incorreta. A deficiência de ADH reduz inserção de aquaporina-2 e diminui reabsorção de água."},
          {"l":"B","t":"Osmolalidade urinária inapropriadamente elevada.","e":"Incorreta. A urina fica diluída, com osmolalidade inadequadamente baixa."},
          {"l":"C","t":"Sódio urinário obrigatoriamente muito elevado como achado definidor.","e":"Incorreta. O achado definidor é perda de água livre com urina hipotônica, não sódio urinário alto."},
          {"l":"D","t":"Hiponatremia por retenção de água.","e":"Incorreta. Retenção de água é típica de excesso de ADH; no DI há risco de hipernatremia."},
          {"l":"E","t":"Poliúria com urina diluída.","e":"Correta. É a manifestação direta da incapacidade de concentrar a urina por deficiência de ADH."}
        ]
      },
      {
        "n":13,"topic":"Metabolismo ósseo e paratireoide","difficulty":"fácil",
        "statement":"Qual alternativa identifica corretamente uma célula responsável pela formação da matriz óssea?",
        "correct":"E",
        "general":"Osteoblastos, derivados de células mesenquimais, sintetizam osteoide e promovem mineralização. Osteoclastos são hematopoiéticos e reabsorvem osso; osteócitos derivam de osteoblastos.",
        "summary":"Osteoblasto forma; osteoclasto reabsorve; osteócito mantém.",
        "memory":"Blasto constrói, clasto quebra.",
        "trap":"O osteócito é o estágio maduro do osteoblasto.",
        "alts":[
          {"l":"A","t":"O osteócito é o estágio final do osteoclasto.","e":"Incorreta. Osteócito deriva de osteoblasto aprisionado na matriz mineralizada."},
          {"l":"B","t":"Osteoclastos sintetizam a matriz osteoide.","e":"Incorreta. Osteoclastos degradam matriz por acidificação e enzimas proteolíticas."},
          {"l":"C","t":"Osteoblastos derivam diretamente da linhagem hematopoiética monócito-macrófago.","e":"Incorreta. Essa é a origem dos osteoclastos; osteoblastos vêm de células-tronco mesenquimais."},
          {"l":"D","t":"A formação óssea ocorre sem relação espacial com a reabsorção prévia.","e":"Incorreta. Na remodelação, formação e reabsorção são processos acoplados nas unidades multicelulares ósseas."},
          {"l":"E","t":"Osteoblastos sintetizam osteoide e participam da formação óssea.","e":"Correta. Produzem matriz orgânica e coordenam sua mineralização."}
        ]
      },
      {
        "n":14,"topic":"Suprarrenal","difficulty":"médio",
        "statement":"Mulher de 19 anos apresenta ganho de peso, estrias violáceas, cortisol livre urinário elevado e ausência de supressão à dexametasona. Qual afirmação é correta?",
        "correct":"C",
        "general":"O quadro confirma necessidade de investigação etiológica do hipercortisolismo. A doença de Cushing, causada por adenoma hipofisário produtor de ACTH, é a etiologia endógena mais frequente.",
        "summary":"Cushing endógeno é mais frequentemente hipofisário e ACTH-dependente.",
        "memory":"Confirme cortisol, meça ACTH, depois localize.",
        "trap":"Cateterismo petroso não é exame para pseudo-Cushing.",
        "alts":[
          {"l":"A","t":"A depressão confirma pseudo-Cushing e encerra a investigação.","e":"Incorreta. Condições de pseudo-Cushing exigem diferenciação clínica e bioquímica; não se conclui apenas por depressão."},
          {"l":"B","t":"Deve-se realizar adrenalectomia direita antes de medir ACTH.","e":"Incorreta. A lateralização cirúrgica depende de demonstrar origem adrenal e localizar a lesão."},
          {"l":"C","t":"A causa mais comum de Cushing endógeno é adenoma hipofisário produtor de ACTH.","e":"Correta. A doença de Cushing é a principal etiologia do hipercortisolismo endógeno."},
          {"l":"D","t":"Cateterismo de seios petrosos diagnostica pseudo-Cushing.","e":"Incorreta. É usado para diferenciar origem hipofisária de ectópica em Cushing ACTH-dependente selecionado."},
          {"l":"E","t":"Tumores adrenais produtores de cortisol são ACTH-dependentes.","e":"Incorreta. Eles produzem cortisol autonomamente e suprimem ACTH."}
        ]
      },
      {
        "n":15,"topic":"Hipófise — Hipofunção","difficulty":"médio",
        "statement":"Sobre hipopituitarismo, assinale a alternativa INCORRETA.",
        "correct":"B",
        "general":"O quadro depende da causa, velocidade e extensão. Em lesões compressivas, GH e gonadotrofinas costumam ser perdidos antes; TSH e ACTH geralmente são preservados até fases posteriores.",
        "summary":"GH e LH/FSH tendem a falhar antes de TSH e ACTH.",
        "memory":"Ordem típica: GH → gonadotrofinas → TSH → ACTH.",
        "trap":"ACTH e TSH são vitais, mas não costumam ser os primeiros eixos perdidos.",
        "alts":[
          {"l":"A","t":"O quadro clínico depende da etiologia, do tipo e da gravidade dos déficits.","e":"Correta como afirmação. Início agudo e perda de ACTH são mais graves que déficits lentos e parciais."},
          {"l":"B","t":"Os eixos de ACTH e TSH são habitualmente os primeiros afetados.","e":"Incorreta e resposta da questão. GH e gonadotrofinas geralmente são os primeiros comprometidos."},
          {"l":"C","t":"Tumores hipofisários e seu tratamento estão entre as principais causas adquiridas.","e":"Correta como afirmação. Cirurgia e radioterapia também podem causar perda progressiva de eixos."},
          {"l":"D","t":"Mutações em PIT1 ou PROP1 podem causar deficiências hormonais combinadas.","e":"Correta como afirmação. Esses fatores de transcrição participam do desenvolvimento e diferenciação hipofisária."},
          {"l":"E","t":"Síndrome de Sheehan decorre de necrose hipofisária após hemorragia obstétrica.","e":"Correta como afirmação. Hipoperfusão de hipófise aumentada na gestação pode causar hipopituitarismo pós-parto."}
        ]
      },
      {
        "n":16,"topic":"Hipófise — Hiperfunção","difficulty":"médio",
        "statement":"Mulher de 47 anos apresenta aumento de extremidades, macroglossia, prognatismo, hipertensão e diabetes. Sobre acromegalia, assinale a alternativa INCORRETA.",
        "correct":"E",
        "general":"Acromegalia quase sempre decorre de adenoma somatotrófico hipofisário. IGF-1 é o teste inicial, TOTG com GH confirma quando necessário, RNM localiza e cirurgia transesfenoidal é primeira escolha para a maioria dos tumores ressecáveis.",
        "summary":"Acromegalia usualmente é adenoma hipofisário secretor de GH.",
        "memory":"IGF-1 → TOTG → RNM → transesfenoidal.",
        "trap":"Hipersecreção hipotalâmica de GHRH é causa excepcional.",
        "alts":[
          {"l":"A","t":"Complicações cardiovasculares são importante causa de mortalidade.","e":"Correta como afirmação. Hipertensão, cardiomiopatia, arritmias e doença valvar elevam o risco cardiovascular."},
          {"l":"B","t":"Se IGF-1 estiver elevado ou equívoco, a supressão do GH no TOTG pode confirmar o diagnóstico.","e":"Correta como afirmação. Falha de supressão do GH diante de hiperglicemia apoia acromegalia."},
          {"l":"C","t":"Cirurgia transesfenoidal é tratamento de primeira escolha para tumor hipofisário ressecável.","e":"Correta como afirmação. Oferece controle hormonal e descompressão com equipe experiente."},
          {"l":"D","t":"Ao diagnóstico, a ressonância frequentemente evidencia macroadenoma.","e":"Correta como afirmação. O diagnóstico tardio faz com que muitos tumores já tenham pelo menos 10 mm."},
          {"l":"E","t":"O mecanismo habitual é hipersecreção hipotalâmica de GHRH.","e":"Incorreta e resposta da questão. A causa usual é adenoma hipofisário produtor de GH; GHRH ectópico ou hipotalâmico é raro."}
        ]
      },
      {
        "n":17,"topic":"Hipófise — Hiperfunção","difficulty":"médio",
        "statement":"Mulher de 24 anos apresenta amenorreia e hiperprolactinemia. Assinale a alternativa INCORRETA.",
        "correct":"A",
        "general":"A intensidade da elevação ajuda na etiologia: valores muito altos favorecem prolactinoma, embora haja sobreposição e efeito gancho em macroadenomas. Sempre se investigam sintomas, fármacos, gestação, tireoide, rim e fígado.",
        "summary":"Quanto maior a prolactina, maior a suspeita de prolactinoma, com exceções.",
        "memory":"PRL muito alta aponta para prolactinoma; confirme contexto e diluição se necessário.",
        "trap":"Fármacos geralmente causam elevações moderadas, não as maiores concentrações.",
        "alts":[
          {"l":"A","t":"A magnitude da prolactina não ajuda na etiologia, e os valores mais altos são tipicamente farmacológicos.","e":"Incorreta e resposta da questão. A magnitude é útil e concentrações muito elevadas favorecem prolactinoma."},
          {"l":"B","t":"Medicamentos psicoativos podem causar hiperprolactinemia.","e":"Correta como afirmação. Antagonismo dopaminérgico e alguns antidepressivos podem elevar prolactina."},
          {"l":"C","t":"Insuficiência renal, hepatopatia, hipotireoidismo, desconexão da haste e prolactinoma são causas possíveis.","e":"Correta como afirmação. Esses mecanismos alteram depuração, TRH, inibição dopaminérgica ou produção tumoral."},
          {"l":"D","t":"Amenorreia, galactorreia e infertilidade devem ser investigadas.","e":"Correta como afirmação. São manifestações do hipogonadismo induzido por prolactina e da secreção mamária."},
          {"l":"E","t":"Hipotireoidismo primário descompensado pode elevar prolactina por aumento de TRH.","e":"Correta como afirmação. O TRH estimula tireotrofos e também lactotrofos."}
        ]
      },
      {
        "n":18,"topic":"Metabolismo ósseo e paratireoide","difficulty":"médio",
        "statement":"Mulher de 63 anos, com embolia pulmonar prévia, diabetes, hipertensão, fratura de colo de fêmur e T-scores de -4,8 na coluna e -2,9 no fêmur, necessita tratamento para osteoporose. Assinale a alternativa correta.",
        "correct":"E",
        "general":"Fratura de quadril e T-score ≤-2,5 estabelecem alto ou muito alto risco. Bisfosfonatos são opção de primeira linha em muitos pacientes por reduzirem reabsorção osteoclástica; risco muito alto pode exigir avaliação de terapia anabólica.",
        "summary":"Bisfosfonatos reduzem reabsorção óssea e são primeira linha frequente.",
        "memory":"Fratura de quadril já indica tratamento, independentemente do T-score.",
        "trap":"Radiografia não substitui densitometria para medir massa óssea.",
        "alts":[
          {"l":"A","t":"Osteoporose acomete especialmente adultos jovens.","e":"Incorreta. A prevalência aumenta com idade e é particularmente relevante após a menopausa e em idosos."},
          {"l":"B","t":"Radiografia simples é o melhor exame para diagnóstico densitométrico.","e":"Incorreta. DXA é o método padrão para mensurar densidade mineral; radiografia detecta perda apenas tardiamente."},
          {"l":"C","t":"As principais fontes alimentares de vitamina D são leite e derivados não fortificados.","e":"Incorreta. Fontes naturais relevantes incluem peixes gordurosos, gema e fígado; alimentos fortificados dependem do país."},
          {"l":"D","t":"Atividade física aeróbica é fator de risco para osteoporose.","e":"Incorreta. Exercícios com sustentação de peso e resistência ajudam massa óssea, força e prevenção de quedas."},
          {"l":"E","t":"Bisfosfonatos são opção de primeira linha e inibem a reabsorção mediada por osteoclastos.","e":"Correta. Têm eficácia antifratura e são amplamente usados quando não há contraindicação."}
        ]
      }
    ]$data$::jsonb)
    AS x(n integer,topic text,difficulty text,statement text,correct text,general text,summary text,memory text,trap text,alts jsonb)
  LOOP
    SELECT id INTO v_topic_id FROM public.topics
    WHERE discipline_id=v_discipline_id AND name=r.topic LIMIT 1;

    IF v_topic_id IS NULL THEN
      v_topic_id := pg_temp.endo_p3_uuid('endocrinologia-topic-'||r.topic);
      INSERT INTO public.topics(id,discipline_id,name)
      VALUES(v_topic_id,v_discipline_id,r.topic)
      ON CONFLICT(id) DO UPDATE SET name=EXCLUDED.name;
    END IF;

    v_question_id := pg_temp.endo_p3_uuid('endocrinologia-prova-3-q'||r.n);
    INSERT INTO public.questions(
      id,discipline_id,topic_id,exam,difficulty,statement,question_type,
      correct_answer,correct_answers,general_comment,summary,memory_tip,trap,
      reference,active,image_url
    ) VALUES(
      v_question_id,v_discipline_id,v_topic_id,'P3',r.difficulty,r.statement,'single',
      r.correct,ARRAY[r.correct],r.general,r.summary,r.memory,r.trap,
      'Prova 3 de Endocrinologia — compilado de provas anteriores, revisado no padrão MedQuiz conforme diretrizes endocrinológicas atuais.',
      true,NULL
    )
    ON CONFLICT(id) DO UPDATE SET
      topic_id=EXCLUDED.topic_id,exam='P3',difficulty=EXCLUDED.difficulty,
      statement=EXCLUDED.statement,question_type='single',
      correct_answer=EXCLUDED.correct_answer,correct_answers=EXCLUDED.correct_answers,
      general_comment=EXCLUDED.general_comment,summary=EXCLUDED.summary,
      memory_tip=EXCLUDED.memory_tip,trap=EXCLUDED.trap,
      reference=EXCLUDED.reference,active=true,image_url=NULL;

    FOR a IN SELECT value FROM jsonb_array_elements(r.alts)
    LOOP
      INSERT INTO public.alternatives(id,question_id,letter,text,explanation)
      VALUES(
        pg_temp.endo_p3_uuid(v_question_id::text||(a->>'l')),
        v_question_id,a->>'l',a->>'t',a->>'e'
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
  v_blank_explanations integer;
BEGIN
  SELECT count(*) INTO v_questions FROM public.questions
  WHERE id IN (SELECT pg_temp.endo_p3_uuid('endocrinologia-prova-3-q'||n) FROM generate_series(1,18) n)
    AND active=true AND exam='P3' AND question_type='single';
  SELECT count(*) INTO v_alternatives FROM public.alternatives
  WHERE question_id IN (SELECT pg_temp.endo_p3_uuid('endocrinologia-prova-3-q'||n) FROM generate_series(1,18) n);
  SELECT count(*) INTO v_blank_explanations FROM public.alternatives
  WHERE question_id IN (SELECT pg_temp.endo_p3_uuid('endocrinologia-prova-3-q'||n) FROM generate_series(1,18) n)
    AND coalesce(trim(explanation),'')='';

  IF v_questions<>18 OR v_alternatives<>90 OR v_blank_explanations<>0 THEN
    RAISE EXCEPTION 'Validação falhou: questões=%, alternativas=%, justificativas vazias=%',
      v_questions,v_alternatives,v_blank_explanations;
  END IF;
END $$;

COMMIT;

SELECT q.id,q.exam,q.active,q.correct_answer,count(a.id) AS alternatives
FROM public.questions q
JOIN public.alternatives a ON a.question_id=q.id
WHERE q.id IN (SELECT pg_temp.endo_p3_uuid('endocrinologia-prova-3-q'||n) FROM generate_series(1,18) n)
GROUP BY q.id,q.exam,q.active,q.correct_answer
ORDER BY q.id;
