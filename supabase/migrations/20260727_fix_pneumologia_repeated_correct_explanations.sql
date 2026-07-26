-- Corrige alternativas corretas cuja justificativa apenas repetia o próprio texto.
-- As alternativas incorretas destas questões foram detalhadas na migration 20260726.
BEGIN;

DO $$
DECLARE v_repeated integer;
BEGIN
  SELECT count(*) INTO v_repeated
  FROM public.alternatives a
  JOIN public.questions q ON q.id=a.question_id
  JOIN public.disciplines d ON d.id=q.discipline_id
  WHERE d.name='Pneumologia' AND a.explanation='Correta. '||a.text;
  IF v_repeated <> 44 THEN
    RAISE EXCEPTION 'Esperadas 44 justificativas corretas repetidas; encontradas %', v_repeated;
  END IF;
END $$;

WITH corrections(question_id, letter, explanation) AS (
  VALUES
  ('2ae16c6c-3005-485a-abc0-e14cb76d6fec'::uuid,'A','Correta conforme o gabarito da questão. O vínculo epidemiológico enfatizado é a exposição durante a caça a tatus, associado no material à coccidioidomicose, e os nódulos pulmonares periféricos cavitados são compatíveis com micose pulmonar. Tuberculose e paracoccidioidomicose permanecem diferenciais que exigem confirmação etiológica.'),
  ('1b37cd53-dff8-47ba-a14b-4ecdb2f0b8e7'::uuid,'B','Correta no princípio de tratar a micose com azólico nas formas não graves e anfotericina B na doença grave. A escolha depende da extensão, repercussão clínica e imunossupressão; o tratamento é sistêmico e prolongado, não um esquema antibacteriano curto.'),
  ('24cf4db7-b9d7-4a45-9f12-8342fa9b1f86'::uuid,'C','Correta. Exposição rural, sintomas constitucionais subagudos e opacidades bilaterais em campos médios formam um padrão típico de paracoccidioidomicose crônica do adulto. O antecedente de tuberculose não elimina nova doença e a confirmação deve demonstrar o fungo.'),
  ('3f8bb3c4-2038-4b64-bf2d-d5ac66616ef1'::uuid,'D','Correta. O diagnóstico etiológico de paracoccidioidomicose requer visualização de leveduras multigemantes e/ou isolamento do fungo em escarro, lavado, raspado ou tecido. Imagem e sorologia apoiam a investigação, mas não substituem a demonstração do agente quando material está disponível.'),
  ('5f26246c-9304-454a-b09a-9eac82ff3475'::uuid,'E','Correta quanto ao uso prolongado de itraconazol nas formas leves ou moderadas. A duração deve ser individualizada por gravidade e resposta clínica, radiológica e sorológica; formas graves requerem indução com anfotericina B seguida de consolidação oral.'),
  ('40a7ea0b-5194-4029-ae83-c12e205185d9'::uuid,'A','Correta conforme o gabarito utilizado. A exposição ambiental durante caça, a síndrome consumptiva pulmonar e o eritema nodoso sustentam micose endêmica, atribuída no material à coccidioidomicose. A epidemiologia geográfica deve sempre ser confirmada, pois no Brasil outras micoses sistêmicas são diferenciais importantes.'),
  ('817d24fb-fc2b-4f24-a244-35e5d26abf8e'::uuid,'C','Correta no mecanismo central: inflamação sistêmica e infecção endotelial ativam plaquetas e cascata de coagulação, gerando formação e degradação de fibrina e elevação do D-dímero. O marcador associa-se à gravidade, mas isoladamente não confirma TEP nem indica anticoagulação terapêutica.'),
  ('f7488f31-e540-4062-bc51-d36885a049c7'::uuid,'D','Correta. Doença neuromuscular, engasgos e vômitos favorecem aspiração, sobretudo para segmentos dependentes do pulmão direito. Hipoxemia, taquipneia, ureia elevada e infiltrado extenso indicam pneumonia grave e necessidade de internação, suporte respiratório e antibiótico ajustado ao cenário de aspiração.'),
  ('2ac43f7b-ad58-4669-a21d-20201aff7efb'::uuid,'E','Correta. Derrame parapneumônico é exsudativo porque a inflamação aumenta permeabilidade capilar e concentra proteína e DHL no espaço pleural. Basta um critério de Light positivo: proteína pleural/sérica >0,5, DHL pleural/sérico >0,6 ou DHL pleural >2/3 do limite superior sérico.'),
  ('782b0f0d-f28f-49c7-8eab-8c3367558a5d'::uuid,'A','Correta. Pus pleural ou cultura/bacterioscopia positiva define empiema. O metabolismo bacteriano e neutrofílico consome glicose e acidifica o líquido, enquanto lise celular eleva muito o DHL; esses achados indicam infecção pleural complicada e necessidade de drenagem.'),
  ('63853fa2-234b-480b-ad1e-1b831a57c143'::uuid,'B','Correta. Na fase exsudativa o líquido ainda é livre e estéril; na fibrinopurulenta surgem invasão bacteriana, queda de pH/glicose e septações; na organização, fibroblastos formam uma capa pleural que pode encarcerar o pulmão. Essa progressão explica a necessidade de controle precoce do foco.'),
  ('9d07a0d1-59bf-42e0-842f-1c62bda50277'::uuid,'C','Correta. Empiema exige simultaneamente antibiótico e controle do foco por drenagem. Loculações ou falha da drenagem podem requerer fibrinolítico intrapleural ou videotoracoscopia; a cobertura antimicrobiana deve alcançar pneumococo, estafilococo, gram-negativos e anaeróbios conforme aquisição e risco.'),
  ('f786eaf1-567d-4633-816c-216bdbe01819'::uuid,'D','Correta. A acidemia com PaCO2 elevado identifica acidose respiratória, e o bicarbonato de 34 mEq/L/BE positivo demonstra retenção renal crônica de base. A infecção precipitou piora ventilatória sobre fraqueza muscular crônica; o uso de diurético pode acrescentar componente alcalótico.'),
  ('65052a45-f19e-4d56-b0cc-66899fb3bba8'::uuid,'E','Correta. A distrofia reduz força inspiratória e ventilação alveolar; a infecção aumenta demanda e secreções, precipitando fadiga e retenção de CO2. A elevação crônica do bicarbonato é a compensação renal à hipercapnia persistente.'),
  ('af3e25db-772c-42d0-9570-8ca72de5800d'::uuid,'B','Correta. O líquido pleural separa pulmão e parede torácica, reduzindo expansibilidade, frêmito tóraco-vocal e murmúrio vesicular. Como líquido conduz som de percussão sem ressonância aérea, produz macicez; derrames volumosos podem desviar mediastino contralateralmente.'),
  ('2e19378f-3c50-4852-a657-2f931e4385c2'::uuid,'D','Correta no enfoque de confirmar tuberculose com método molecular e cultura. O TRM-TB detecta DNA do complexo M. tuberculosis e resistência à rifampicina; cultura e teste de sensibilidade aumentam confirmação e orientam resistência. Em derrame pleural, ADA, biópsia e cultura do tecido/líquido também podem ser necessários.'),
  ('d352d262-76c9-41da-890f-01b8296187c4'::uuid,'E','Correta. Imagem em decúbito ou ultrassonografia confirma mobilidade e janela segura, enquanto toracocentese permite bioquímica, celularidade, pH, microbiologia e citologia. Quando a suspeita persiste, biópsia pleural aumenta o rendimento para tuberculose e neoplasia.'),
  ('5f481599-7078-4df2-b775-48abddfb4539'::uuid,'A','Correta. O esquema básico combina quatro fármacos na fase intensiva para reduzir rapidamente a carga bacilar e prevenir resistência, seguido de rifampicina e isoniazida na manutenção. Notificação, avaliação de contatos, adesão e TDO quando indicado fazem parte do tratamento da tuberculose.'),
  ('f21297ce-5afb-41a6-bed6-e85353412f07'::uuid,'B','Correta. Primeiro o líquido deve preencher pelo menos um critério de Light para ser exsudato; depois a citometria demonstra predomínio de linfócitos/monócitos. Esse padrão traduz inflamação pleural subaguda ou crônica e orienta hipóteses como tuberculose e malignidade.'),
  ('2379e05b-0213-48a5-a132-977418619f7a'::uuid,'C','Correta. Tuberculose pleural e malignidade são causas clássicas de exsudato linfocitário; doenças autoimunes, quilotórax e algumas infecções crônicas também entram no diferencial. A celularidade orienta, mas não confirma a etiologia sem testes adicionais.'),
  ('06c50245-6457-4948-8102-e70a51993771'::uuid,'D','Correta no uso de microbiologia molecular e cultura para tuberculose. A avaliação completa do exsudato linfocitário deve ainda ser dirigida à hipótese: ADA e biópsia para TB; citologia e biópsia para neoplasia; autoanticorpos e complemento para serosites selecionadas.'),
  ('6b736984-b1c8-46eb-a86a-0b62f7ba3529'::uuid,'E','Correta. Granulomas epitelioides com necrose caseosa favorecem tuberculose, embora cultura ou TRM sejam necessários para confirmação microbiológica. Na malignidade, a identificação de células neoplásicas infiltrando pleura/mesotélio estabelece a natureza tumoral e permite imunohistoquímica.'),
  ('2d12028e-0941-4575-a17b-ab7f73e897fb'::uuid,'A','Correta como conjunto de critérios menores de pneumonia grave: infiltrado multilobar, P/F ≤250, ureia elevada, FR ≥30, hipotensão e confusão. A ATS/IDSA considera pneumonia grave com um critério maior ou pelo menos três menores, incluindo ainda leucopenia, trombocitopenia e hipotermia.'),
  ('7becd798-6089-4296-862f-cbbeb7c7e602'::uuid,'B','Correta. PCR acompanha intensidade inflamatória, enquanto procalcitonina tende a elevar-se mais em infecção bacteriana sistêmica e pode apoiar decisões de suspensão de antibiótico em conjunto com a clínica. Nenhum dos dois deve, isoladamente, iniciar ou excluir antibiótico em PAC confirmada.'),
  ('bb81bd92-fc45-401d-802f-9a5aa1ad58f0'::uuid,'C','Correta. Dois meses de RHZE reduzem carga bacilar e protegem contra resistência; quatro meses de RH completam a esterilização na tuberculose pulmonar sensível habitual. O tratamento deve seguir dose por peso, notificação, avaliação de interações e monitorização de toxicidade e adesão.'),
  ('82df3dec-c9e7-49be-8d7c-294247ca4376'::uuid,'D','Correta no princípio de combinar baciloscopia, TRM-TB, cultura e imagem, embora a sequência deva seguir o protocolo vigente. TRM-TB é exame inicial importante por detectar o bacilo e resistência à rifampicina; resultado negativo não encerra investigação quando a suspeita clínica permanece alta.'),
  ('0360524a-a628-4ba0-a032-d9b17ff40b5a'::uuid,'E','Correta. Derrame reduz expansão e transmissão das vibrações vocais, causa macicez à percussão e abole ou reduz murmúrio vesicular na área ocupada. Atrito pleural pode surgir quando superfícies inflamadas ainda entram em contato, mas desaparece sobre derrame volumoso.'),
  ('0cdcc4e4-d6ea-4793-a9d6-ea7b61b7b26b'::uuid,'A','Correta. A toracocentese diagnóstica é indicada em derrame novo sem causa evidente ou com características atípicas. Pode ser dispensada inicialmente em pequeno derrame bilateral típico de insuficiência cardíaca que responde ao tratamento; ausência de janela segura e coagulopatia relevante exigem ponderação e ultrassom.'),
  ('6ae43c33-72b6-4d11-87a3-e932aaff3e49'::uuid,'B','Correta apenas no componente de investigação de tuberculose quando essa é a hipótese do exsudato. Para distinguir transudato de exsudato são indispensáveis proteína e DHL pleurais/séricos; pH, glicose, celularidade, ADA, triglicerídeos, citologia e culturas refinam etiologia e prognóstico.'),
  ('204c5764-87f3-4595-8060-8013ceaa9790'::uuid,'C','Correta. O CRB-65 pode ser calculado na atenção primária sem ureia: confusão, FR ≥30, pressão sistólica <90 ou diastólica ≤60 e idade ≥65. Pontuação crescente indica maior mortalidade e favorece encaminhamento hospitalar, sempre complementado por julgamento clínico e oxigenação.'),
  ('48a7ce6f-a1e3-4747-a84a-62471b263705'::uuid,'D','Correta. Isolamento respiratório prévio de Pseudomonas e internação recente com antibiótico IV são os fatores mais fortes; bronquiectasias e doença estrutural aumentam plausibilidade. Cobertura empírica deve ser individualizada à epidemiologia local e descalonada conforme culturas.'),
  ('24dd54ce-4b74-499a-9885-9fdc11f119bf'::uuid,'E','Correta. Levedura multigemante em roda de leme é característica de Paracoccidioides. A forma aguda/subaguda predomina em jovens e sistema mononuclear-fagocítico; a crônica do adulto é principalmente pulmonar e mucocutânea, refletindo reativação após exposição rural.'),
  ('e1f88927-5f4d-42e3-bc90-eb8757e76ceb'::uuid,'A','Correta. Itraconazol é preferido em paracoccidioidomicose leve ou moderada por eficácia e tolerabilidade; SMX-TMP é alternativa de curso mais longo. Doença grave exige anfotericina B para controle inicial, seguida de consolidação oral até critérios de cura clínica, radiológica e sorológica.'),
  ('4477f02f-8f05-489b-9e5d-14c501a5176c'::uuid,'C','Correta. Para ser transudato, nenhum critério de Light pode ser positivo: relações proteína <0,5 e DHL <0,6, além de DHL pleural abaixo de 2/3 do limite superior sérico. O mecanismo usual é desequilíbrio hidrostático/oncótico sem inflamação pleural primária.'),
  ('c48b70a4-2b5e-43a6-ba4f-f457bb9c54ad'::uuid,'A','Correta. Paracoccidioides apresenta levedura de parede dupla com múltiplos brotamentos ao redor da célula-mãe, formando a clássica roda de leme em Grocott. O achado no tecido, associado ao quadro pulmonar e mucoso rural, confirma a hipótese etiológica.'),
  ('4acaa29d-49b5-4d3d-bc79-dc8023afc5b4'::uuid,'C','Correta. Uma baciloscopia negativa não exclui tuberculose. O TRM-TB deve ser realizado para detectar DNA do bacilo e resistência à rifampicina; cultura com teste de sensibilidade aumenta rendimento, sobretudo diante de forte suspeita, cavitação ou resultado molecular negativo.'),
  ('432a23a5-bd9d-48ed-a543-2ca7acb9fc36'::uuid,'D','Correta no uso de TRM-TB, cultura e baciloscopia como investigação, mas o comando também exige ações após confirmação: notificação compulsória, início rápido do esquema, avaliação de contatos, testagem para HIV, orientação de controle de transmissão e acompanhamento da adesão.'),
  ('8db1c93a-a8c7-4930-ac9a-ba8975d6f363'::uuid,'E','Correta. Consolidação bacteriana adjacente com derrame e síndrome febril indica derrame parapneumônico. O líquido é exsudato inicialmente neutrofílico; pH <7,20, glicose baixa, cultura positiva, pus ou loculações indicam complicação e necessidade de drenagem.'),
  ('e8479fa8-4130-4cdd-9f6c-d96d80d96830'::uuid,'B','Correta. TRM-TB oferece confirmação molecular rápida e pesquisa resistência à rifampicina; baciloscopia identifica bacilíferos e cultura é mais sensível, além de permitir teste de sensibilidade. Radiografia sustenta a suspeita e avalia extensão, mas não confirma isoladamente.'),
  ('5ccf8777-9ca7-4afd-a4e5-fb14d26febd0'::uuid,'C','Correta. Adulto com tuberculose pulmonar sensível e sem tratamento prévio recebe dois meses de RHZE e quatro meses de RH, com dose fixa combinada ajustada ao peso. A estratégia ataca populações bacilares distintas e reduz seleção de resistência; adesão e hepatotoxicidade devem ser monitoradas.'),
  ('f822ee74-b525-4053-bf87-5cee3c3a4adb'::uuid,'A','Correta. Na COVID-19, IL-6 e outras citocinas estimulam síntese hepática de PCR como proteína de fase aguda. Valor muito elevado traduz resposta inflamatória intensa e associa-se a maior acometimento pulmonar, mas deve ser interpretado com evolução clínica e pesquisa de coinfecção.'),
  ('abfb7fa7-d364-499a-a270-4b8f121c0c08'::uuid,'B','Correta. Lesão endotelial, inflamação e ativação plaquetária promovem imunotrombose; a degradação da fibrina formada eleva D-dímero. Idade, hipertensão, diabetes e obesidade aumentam risco de evolução grave, porém o marcador isolado não confirma macro-TEP.'),
  ('3ad3f478-8e4a-4f81-a2cb-31f825f0a497'::uuid,'C','Correta. O padrão típico da pneumonia por COVID-19 é vidro fosco bilateral, periférico e posterior, frequentemente basal. Progressão pode acrescentar consolidação e crazy paving; distribuição unilateral focal, cavitação e derrame volumoso sugerem diagnósticos alternativos ou complicações.'),
  ('bf935a13-c6c0-46bf-b5f1-42d487eeb4bd'::uuid,'D','Correta. Contato sintomático deve reduzir exposição a terceiros, usar máscara, testar na janela recomendada e acompanhar dispneia, queda de saturação ou piora. Casos leves recebem suporte e orientação conforme norma sanitária vigente; antibiótico e corticoide não são automáticos.')
)
UPDATE public.alternatives a
SET explanation=c.explanation
FROM corrections c
WHERE a.question_id=c.question_id AND a.letter=c.letter;

DO $$
DECLARE v_remaining integer;
BEGIN
  SELECT count(*) INTO v_remaining
  FROM public.alternatives a
  JOIN public.questions q ON q.id=a.question_id
  JOIN public.disciplines d ON d.id=q.discipline_id
  WHERE d.name='Pneumologia' AND a.explanation='Correta. '||a.text;
  IF v_remaining <> 0 THEN
    RAISE EXCEPTION 'Ainda restam % justificativas que apenas repetem a alternativa', v_remaining;
  END IF;
END $$;

COMMIT;

SELECT count(*) AS repeated_correct_explanations_remaining
FROM public.alternatives a
JOIN public.questions q ON q.id=a.question_id
JOIN public.disciplines d ON d.id=q.discipline_id
WHERE d.name='Pneumologia' AND a.explanation='Correta. '||a.text;
