-- Substitui distratores e justificativas genéricas em todas as 46 questões
-- afetadas de Pneumologia P2. Cada alternativa passa a ter conteúdo clínico
-- específico. A ordem dos arrays corresponde às letras incorretas em ordem
-- alfabética (a letra correta é ignorada).
BEGIN;

DO $$
DECLARE v_affected integer;
BEGIN
  SELECT count(*) INTO v_affected
  FROM public.alternatives a
  JOIN public.questions q ON q.id=a.question_id
  JOIN public.disciplines d ON d.id=q.discipline_id
  WHERE d.name='Pneumologia'
    AND coalesce(a.explanation,'') ILIKE '%Esta alternativa é plausível, mas é incompleta%';
  IF v_affected <> 184 THEN
    RAISE EXCEPTION 'Esperadas 184 alternativas genéricas; encontradas %', v_affected;
  END IF;
END $$;

WITH corrections(question_id, correct_letter, texts, explanations) AS (
  VALUES
  ('2ae16c6c-3005-485a-abc0-e14cb76d6fec'::uuid,'A',
   ARRAY['Paracoccidioidomicose pulmonar crônica.','Tuberculose pulmonar pós-primária.','Histoplasmose pulmonar crônica.','Aspergilose pulmonar invasiva.'],
   ARRAY['Incorreta. A paracoccidioidomicose se relaciona ao trabalho rural e costuma associar lesões mucosas; a pista epidemiológica destacada no caso é a caça a tatus no contexto atribuído à coccidioidomicose.','Incorreta. O contato com tuberculose torna esse diagnóstico diferencial obrigatório, mas a exposição ambiental e os nódulos periféricos cavitados direcionam a questão para micose sistêmica.','Incorreta. Histoplasmose se associa sobretudo a solo contaminado por fezes de aves ou morcegos e não é a hipótese indicada pela epidemiologia apresentada.','Incorreta. Aspergilose invasiva é típica de neutropenia ou imunossupressão grave e costuma produzir nódulos com sinal do halo.']),
  ('1b37cd53-dff8-47ba-a14b-4ecdb2f0b8e7'::uuid,'B',
   ARRAY['Esquema rifampicina, isoniazida, pirazinamida e etambutol por seis meses.','Sulfametoxazol-trimetoprim por 21 dias associado a corticoide.','Ceftriaxona e azitromicina por sete dias.','Ressecção cirúrgica dos nódulos como tratamento inicial.'],
   ARRAY['Incorreta. Esse é o esquema básico da tuberculose sensível, não o tratamento da micose sistêmica considerada no caso.','Incorreta. SMX-TMP por 21 dias é usado na pneumocistose; não é o esquema de escolha para coccidioidomicose pulmonar.','Incorreta. Esse esquema trata pneumonia bacteriana comunitária e não uma infecção fúngica subaguda com nódulos cavitados.','Incorreta. Doença pulmonar multifocal não é tratada inicialmente com ressecção; antifúngico sistêmico é a base.']),
  ('24cf4db7-b9d7-4a45-9f12-8342fa9b1f86'::uuid,'C',
   ARRAY['Reativação de tuberculose pulmonar.','Aspergiloma em cavidades residuais.','Pneumonia bacteriana comunitária.','Pneumocistose.'],
   ARRAY['Incorreta. Tuberculose é diferencial importante pelo antecedente e exige investigação, mas a exposição rural e o padrão bilateral em campos médios favorecem paracoccidioidomicose.','Incorreta. Aspergiloma exige massa fúngica móvel dentro de cavidade preexistente, achado não descrito.','Incorreta. Pneumonia bacteriana costuma ter evolução mais aguda e consolidação, não síndrome consumptiva subaguda em agricultor.','Incorreta. Pneumocistose ocorre principalmente em imunossuprimidos e produz vidro fosco difuso, não o padrão apresentado.']),
  ('3f8bb3c4-2038-4b64-bf2d-d5ac66616ef1'::uuid,'D',
   ARRAY['Solicitar apenas radiografia de tórax de controle.','Solicitar apenas sorologia para Paracoccidioides.','Realizar prova tuberculínica como confirmação etiológica.','Solicitar espirometria com broncodilatador.'],
   ARRAY['Incorreta. A radiografia avalia extensão e evolução, mas não demonstra o fungo nem confirma a etiologia.','Incorreta. A sorologia pode apoiar e monitorar a paracoccidioidomicose, porém a confirmação requer demonstração ou isolamento do agente em material clínico.','Incorreta. Prova tuberculínica indica sensibilização ao M. tuberculosis e não confirma doença ativa nem paracoccidioidomicose.','Incorreta. Espirometria avalia função pulmonar, mas não identifica a causa infecciosa das opacidades.']),
  ('5f26246c-9304-454a-b09a-9eac82ff3475'::uuid,'E',
   ARRAY['Fluconazol em dose única.','Anfotericina B para todo paciente, independentemente da gravidade.','Prednisona isolada por seis meses.','Esquema básico 2RHZE/4RH.'],
   ARRAY['Incorreta. Micose pulmonar sistêmica exige tratamento prolongado; dose única de fluconazol é insuficiente.','Incorreta. Anfotericina B é reservada às formas graves; nas leves ou moderadas, itraconazol oferece melhor relação eficácia-toxicidade.','Incorreta. Corticoide isolado não trata o fungo e pode agravar a infecção.','Incorreta. Esse é o tratamento da tuberculose sensível, não da paracoccidioidomicose.']),
  ('40a7ea0b-5194-4029-ae83-c12e205185d9'::uuid,'A',
   ARRAY['Paracoccidioidomicose crônica do adulto.','Tuberculose pulmonar com eritema nodoso.','Histoplasmose disseminada.','Sarcoidose pulmonar.'],
   ARRAY['Incorreta conforme o gabarito desta questão. Embora seja diferencial em trabalhador rural, o vínculo com caça a tatu e eritema nodoso foi usado para apontar coccidioidomicose.','Incorreta. Tuberculose pode causar eritema nodoso, mas a combinação epidemiológica foi construída para uma micose endêmica.','Incorreta. Histoplasmose se associa mais a exposição a aves/morcegos e, na forma disseminada, frequentemente a imunossupressão.','Incorreta. Sarcoidose pode cursar com eritema nodoso, mas não explica tão bem febre, perda ponderal e a exposição epidemiológica destacada.']),
  ('817d24fb-fc2b-4f24-a244-35e5d26abf8e'::uuid,'C',
   ARRAY['O D-dímero elevado confirma tromboembolismo pulmonar e exige trombólise.','O marcador reflete exclusivamente lesão hepática causada pelo vírus.','O valor elevado exclui microtrombose porque demonstra fibrinólise eficaz.','D-dímero não tem relação com inflamação ou prognóstico na COVID-19.'],
   ARRAY['Incorreta. D-dímero é sensível, porém inespecífico; não confirma TEP e trombólise depende de diagnóstico e instabilidade.','Incorreta. D-dímero é produto da degradação de fibrina e reflete ativação de coagulação/fibrinólise, não lesão hepática isolada.','Incorreta. A elevação sinaliza formação e degradação aumentadas de fibrina e pode acompanhar imunotrombose.','Incorreta. Valores altos se associam a endoteliopatia, trombose e maior gravidade, embora não definam a causa isoladamente.']),
  ('f7488f31-e540-4062-bc51-d36885a049c7'::uuid,'D',
   ARRAY['Edema pulmonar cardiogênico; tratar apenas com diurético.','Pneumocistose; iniciar SMX-TMP e corticoide.','Pneumonia comunitária leve; alta com macrolídeo oral.','Tromboembolismo pulmonar; indicar trombólise sistêmica.'],
   ARRAY['Incorreta. Febre, leucocitose, aspiração recorrente e opacidade acinar favorecem pneumonia aspirativa, sem dados de congestão cardíaca.','Incorreta. Não há imunossupressão típica nem vidro fosco difuso; o risco dominante é aspiração por doença neuromuscular.','Incorreta. Hipoxemia importante, taquipneia, disfunção renal e doença neuromuscular exigem internação e avaliação de terapia intensiva.','Incorreta. O quadro infeccioso e a história de engasgos explicam melhor os achados; trombólise não tem indicação sem TEP de alto risco.']),
  ('2ac43f7b-ad58-4669-a21d-20201aff7efb'::uuid,'E',
   ARRAY['Proteína e DHL baixos, compatíveis com transudato.','Relação proteína pleural/sérica menor que 0,5 isoladamente confirma empiema.','DHL pleural normal exclui derrame parapneumônico.','A bioquímica não diferencia exsudato de transudato.'],
   ARRAY['Incorreta. Derrame parapneumônico é inflamatório e tende a preencher pelo menos um critério de Light para exsudato.','Incorreta. Relação proteica baixa sugere transudato; empiema depende de pus, microbiologia e parâmetros como pH e glicose.','Incorreta. Derrame parapneumônico inicial pode ter alterações discretas; a classificação usa o conjunto dos critérios de Light.','Incorreta. Proteína e DHL pleurais comparadas ao soro são justamente a base dos critérios de Light.']),
  ('782b0f0d-f28f-49c7-8eab-8c3367558a5d'::uuid,'A',
   ARRAY['Líquido límpido, pH acima de 7,40 e glicose normal.','Transudato com proteína pleural muito baixa.','Predomínio eosinofílico sem bactérias ou pus.','ADA elevada isoladamente, com pH e glicose preservados.'],
   ARRAY['Incorreta. Empiema é pus no espaço pleural e costuma apresentar acidose, consumo de glicose e DHL muito elevado.','Incorreta. Empiema é exsudato infeccioso, não transudato.','Incorreta. Eosinofilia pleural sugere ar, sangue, fármacos ou parasitos e não define empiema.','Incorreta. ADA elevada sugere tuberculose em contexto adequado; isoladamente não caracteriza infecção bacteriana purulenta.']),
  ('63853fa2-234b-480b-ad1e-1b831a57c143'::uuid,'B',
   ARRAY['Fase transudativa, fase hemorrágica e fase neoplásica.','Fase broncoespástica, fase alveolar e fase intersticial.','Fase caseosa seguida obrigatoriamente de cavitação.','Fase edematosa única, sem loculações ou organização.'],
   ARRAY['Incorreta. A evolução do derrame parapneumônico é exsudativa, fibrinopurulenta e de organização.','Incorreta. Essas categorias não descrevem a progressão da infecção no espaço pleural.','Incorreta. Necrose caseosa é característica de tuberculose, não a sequência do empiema bacteriano.','Incorreta. Sem drenagem, fibrina, loculações e fibrose pleural podem aparecer progressivamente.']),
  ('9d07a0d1-59bf-42e0-842f-1c62bda50277'::uuid,'C',
   ARRAY['Antibiótico oral isolado, sem drenagem, apesar de pus pleural.','Toracocentese única e alta imediata.','Corticoide sistêmico como tratamento etiológico.','Aguardar cultura por vários dias antes de iniciar antibiótico.'],
   ARRAY['Incorreta. Empiema requer controle do foco com drenagem além de antibiótico.','Incorreta. Punção diagnóstica não substitui drenagem contínua quando há pus, pH baixo ou loculação.','Incorreta. Corticoide não erradica a infecção pleural e pode prejudicar a resposta imune.','Incorreta. O tratamento antimicrobiano empírico deve ser iniciado prontamente e depois ajustado à cultura.']),
  ('f786eaf1-567d-4633-816c-216bdbe01819'::uuid,'D',
   ARRAY['Alcalose respiratória aguda sem compensação.','Acidose metabólica com ânion gap elevado.','Acidose respiratória aguda pura.','Alcalose metabólica isolada.'],
   ARRAY['Incorreta. O PaCO2 está elevado, e não reduzido, afastando alcalose respiratória.','Incorreta. O bicarbonato está elevado e a retenção de CO2 explica a acidemia; não há dados para acidose metabólica primária.','Incorreta. O HCO3 de 34 e o BE positivo demonstram adaptação renal crônica, incompatível com distúrbio puramente agudo.','Incorreta. A alcalose metabólica pode coexistir pelo diurético, mas não explica sozinha PaCO2 de 65 com acidemia.']),
  ('65052a45-f19e-4d56-b0cc-66899fb3bba8'::uuid,'E',
   ARRAY['Hiperventilação por ansiedade com eliminação excessiva de CO2.','Cetoacidose diabética com compensação respiratória.','Embolia pulmonar causando alcalose respiratória.','Intoxicação por salicilato como causa única.'],
   ARRAY['Incorreta. Ansiedade reduziria o PaCO2; o paciente apresenta retenção de CO2.','Incorreta. Cetoacidose reduziria o bicarbonato e provocaria hiperventilação, padrão oposto ao encontrado.','Incorreta. TEP geralmente causa hipocapnia por hiperventilação e não explica a compensação renal crônica.','Incorreta. Salicilato produz tipicamente distúrbio misto com alcalose respiratória e acidose metabólica.']),
  ('af3e25db-772c-42d0-9570-8ca72de5800d'::uuid,'B',
   ARRAY['Expansibilidade aumentada, frêmito aumentado, hipersonoridade e sibilos difusos.','Tórax simétrico, frêmito normal, som claro e murmúrio preservado.','Expansibilidade reduzida, frêmito aumentado, macicez e sopro tubário em toda a área.','Abaulamento com frêmito aumentado, timpanismo e estridor.'],
   ARRAY['Incorreta. Esse conjunto se aproxima de hiperinsuflação/obstrução, não de líquido pleural.','Incorreta. Um derrame significativo altera expansão, frêmito, percussão e ausculta no hemitórax afetado.','Incorreta. Consolidação pode aumentar frêmito e produzir sopro tubário; o líquido pleural reduz a transmissão vocal.','Incorreta. Timpanismo sugere ar no espaço pleural ou víscera aerada, e estridor é sinal de via aérea superior.']),
  ('2e19378f-3c50-4852-a657-2f931e4385c2'::uuid,'D',
   ARRAY['Exsudato neutrofílico com glicose muito baixa confirma tuberculose isoladamente.','Transudato com predomínio de mesoteliais é o padrão típico.','Líquido eosinofílico com amilase elevada define tuberculose.','Radiografia normal exclui tuberculose pleural.'],
   ARRAY['Incorreta. TB pleural costuma ser exsudato linfocitário; neutrofilia e glicose muito baixa sugerem outros cenários e não confirmam etiologia.','Incorreta. Tuberculose pleural produz exsudato inflamatório, frequentemente com poucas células mesoteliais.','Incorreta. Eosinofilia e amilase elevada direcionam a ar/sangue, pancreatite ou ruptura esofágica, não TB.','Incorreta. A radiografia pode mostrar apenas derrame e não exclui etiologia tuberculosa; confirmação requer microbiologia e/ou biópsia.']),
  ('d352d262-76c9-41da-890f-01b8296187c4'::uuid,'E',
   ARRAY['Espirometria isolada.','Eletrocardiograma e troponina apenas.','Dosagem sérica de IgE total.','Teste cutâneo para alérgenos inaláveis.'],
   ARRAY['Incorreta. Espirometria avalia função ventilatória e não determina a causa de um derrame.','Incorreta. Esses exames avaliam doença cardíaca, mas não caracterizam nem confirmam a etiologia pleural.','Incorreta. IgE não diferencia derrame parapneumônico, tuberculoso ou neoplásico.','Incorreta. Testes alérgicos não fazem parte da investigação etiológica usual do líquido pleural.']),
  ('5f481599-7078-4df2-b775-48abddfb4539'::uuid,'A',
   ARRAY['Isoniazida isolada por seis meses.','Azitromicina por cinco dias.','Anfotericina B seguida de itraconazol.','Corticoide isolado até resolução radiológica.'],
   ARRAY['Incorreta. Monoterapia causa seleção de resistência e não trata tuberculose ativa.','Incorreta. Macrolídeo não tem atividade adequada contra M. tuberculosis.','Incorreta. Esse é um esquema antifúngico e não o tratamento da tuberculose sensível.','Incorreta. Corticoide não erradica o bacilo e só tem indicações adjuvantes específicas.']),
  ('f21297ce-5afb-41a6-bed6-e85353412f07'::uuid,'B',
   ARRAY['Transudato com menos de 10% de linfócitos.','Qualquer líquido pleural com aspecto leitoso.','Exsudato definido exclusivamente por ADA elevada.','Líquido hemorrágico com hematócrito acima de 50% do sangue.'],
   ARRAY['Incorreta. A expressão exige exsudato pelos critérios de Light e predomínio de células mononucleares.','Incorreta. Aspecto leitoso sugere quilotórax ou pseudoquilotórax e não define o diferencial celular.','Incorreta. ADA ajuda na suspeita de tuberculose, mas não define sozinha exsudato nem predomínio linfomonocitário.','Incorreta. Esse critério caracteriza hemotórax, não exsudato linfomonocitário.']),
  ('2379e05b-0213-48a5-a132-977418619f7a'::uuid,'C',
   ARRAY['Insuficiência cardíaca e cirrose sem complicações.','Empiema bacteriano agudo e derrame parapneumônico inicial.','Pneumotórax espontâneo e asma.','Edema pulmonar cardiogênico e síndrome nefrótica.'],
   ARRAY['Incorreta. Essas doenças produzem tipicamente transudato, não exsudato linfocitário.','Incorreta. Infecção bacteriana pleural aguda costuma ter predomínio neutrofílico.','Incorreta. Pneumotórax é ar no espaço pleural e asma não causa derrame linfomonocitário.','Incorreta. Ambas geram transudato por alterações hidrostáticas ou oncóticas.']),
  ('06c50245-6457-4948-8102-e70a51993771'::uuid,'D',
   ARRAY['Somente radiografia, que confirma todas as etiologias.','Somente critérios de Light, que distinguem TB de câncer.','IgE total e teste cutâneo para diferenciar as causas.','Espirometria e pico de fluxo expiratório.'],
   ARRAY['Incorreta. Imagem demonstra o derrame e lesões associadas, mas não confirma a causa.','Incorreta. Light separa exsudato de transudato; citologia, ADA, culturas e biópsia investigam etiologias.','Incorreta. Testes alérgicos não distinguem tuberculose, malignidade ou doença autoimune pleural.','Incorreta. Provas funcionais avaliam vias aéreas e volumes, não a etiologia do exsudato.']),
  ('6b736984-b1c8-46eb-a86a-0b62f7ba3529'::uuid,'E',
   ARRAY['Tuberculose: edema sem granulomas; neoplasia: apenas neutrófilos.','Tuberculose: células malignas; neoplasia: granuloma caseoso.','Ambas mostram exclusivamente fibrose inespecífica.','Empiema e neoplasia apresentam sempre o mesmo padrão histológico.'],
   ARRAY['Incorreta. TB tipicamente forma granulomas, enquanto neoplasia é demonstrada por células tumorais.','Incorreta. Os achados foram invertidos: caseificação sugere TB e infiltração maligna sugere câncer.','Incorreta. Fibrose isolada é inespecífica e não contempla os achados etiológicos característicos.','Incorreta. Empiema mostra inflamação supurativa; neoplasia mostra proliferação/infiltração tumoral.']),
  ('2d12028e-0941-4575-a17b-ab7f73e897fb'::uuid,'A',
   ARRAY['Apenas febre acima de 38 °C e tosse produtiva.','Somente idade acima de 65 anos e tabagismo.','Derrame pleural pequeno como único critério maior.','PCR elevada isoladamente define necessidade de UTI.'],
   ARRAY['Incorreta. São manifestações comuns de pneumonia, mas não os critérios ATS/IDSA de gravidade.','Incorreta. Idade e tabagismo influenciam risco, porém não compõem isoladamente os critérios de pneumonia grave.','Incorreta. Os critérios maiores são ventilação mecânica invasiva e choque com vasopressor; derrame não é critério maior.','Incorreta. Biomarcador isolado não substitui critérios clínicos, respiratórios e hemodinâmicos.']),
  ('7becd798-6089-4296-862f-cbbeb7c7e602'::uuid,'B',
   ARRAY['Troponina e CK-MB.','D-dímero e fibrinogênio como marcadores específicos de pneumonia bacteriana.','IgE e eosinófilos para decidir antibiótico.','BNP isolado para identificar o agente etiológico.'],
   ARRAY['Incorreta. São biomarcadores de lesão miocárdica e não orientam rotineiramente resposta inflamatória da pneumonia.','Incorreta. Avaliam coagulação e trombose, são inespecíficos e não distinguem adequadamente pneumonia bacteriana.','Incorreta. Avaliam resposta alérgica/eosinofílica, não a evolução habitual de PAC.','Incorreta. BNP auxilia na suspeita de insuficiência cardíaca e não identifica microrganismo.']),
  ('bb81bd92-fc45-401d-802f-9a5aa1ad58f0'::uuid,'C',
   ARRAY['Rifampicina isolada por quatro meses.','Isoniazida preventiva por seis meses para doença ativa.','Ceftriaxona e azitromicina por sete dias.','RHZE por duas semanas, sem fase de manutenção.'],
   ARRAY['Incorreta. Tuberculose ativa requer combinação de fármacos para evitar resistência.','Incorreta. Isoniazida preventiva trata infecção latente em cenários selecionados, não doença pulmonar ativa.','Incorreta. Antibióticos para PAC não erradicam M. tuberculosis.','Incorreta. A fase intensiva dura dois meses e deve ser seguida de quatro meses de RH na doença sensível usual.']),
  ('82df3dec-c9e7-49be-8d7c-294247ca4376'::uuid,'D',
   ARRAY['Radiografia normal exclui tuberculose e encerra a investigação.','PPD positivo confirma tuberculose pulmonar ativa.','Baciloscopia negativa única exclui a doença.','Iniciar monoterapia com isoniazida enquanto aguarda exames.'],
   ARRAY['Incorreta. Imagem pode ser normal em alguns contextos e nunca substitui investigação microbiológica quando há suspeita.','Incorreta. PPD demonstra infecção/sensibilização e não diferencia latência de doença ativa.','Incorreta. A sensibilidade da baciloscopia é limitada; TRM-TB e cultura devem ser usados conforme protocolo.','Incorreta. Monoterapia em doença ativa seleciona resistência; o esquema deve ser combinado após avaliação adequada.']),
  ('0360524a-a628-4ba0-a032-d9b17ff40b5a'::uuid,'E',
   ARRAY['Inspeção com expansão aumentada; palpação com frêmito aumentado; percussão timpânica; ausculta com sibilos.','Exame torácico inteiramente normal mesmo em derrame volumoso.','Frêmito aumentado, macicez e sopro tubário como conjunto típico do líquido pleural.','Hipersonoridade e murmúrio abolido, padrão obrigatório de derrame.'],
   ARRAY['Incorreta. O conjunto sugere obstrução/hiperinsuflação e não líquido pleural.','Incorreta. Derrames clinicamente relevantes reduzem expansão, frêmito e murmúrio e causam macicez.','Incorreta. Frêmito aumentado e sopro tubário sugerem consolidação com brônquio pérvio; no derrame o frêmito cai.','Incorreta. Hipersonoridade sugere pneumotórax; o derrame produz macicez.']),
  ('0cdcc4e4-d6ea-4793-a9d6-ea7b61b7b26b'::uuid,'A',
   ARRAY['Nunca puncionar derrame pleural por risco de pneumotórax.','Puncionar obrigatoriamente todo derrame mínimo visível apenas na TC.','Evitar punção em todo paciente com insuficiência cardíaca, mesmo com febre ou assimetria.','Punção diagnóstica é substituída por espirometria.'],
   ARRAY['Incorreta. Toracocentese é fundamental para diagnóstico em muitos derrames e pode ser feita com segurança, preferencialmente guiada por ultrassom.','Incorreta. Derrames muito pequenos sem janela segura podem ser observados; indicação depende do contexto e tamanho.','Incorreta. Derrame bilateral típico que responde a diurético pode dispensar punção, mas sinais atípicos exigem investigação.','Incorreta. Espirometria não analisa líquido nem define sua etiologia.']),
  ('6ae43c33-72b6-4d11-87a3-e932aaff3e49'::uuid,'B',
   ARRAY['Dosar apenas glicemia sérica.','Usar somente a cor do líquido para classificar transudato.','Solicitar PPD no líquido pleural como critério de Light.','Espirometria diferencia exsudato de transudato.'],
   ARRAY['Incorreta. A investigação requer proteína e DHL pleural/sérica, além de pH, glicose, celularidade e testes etiológicos conforme hipótese.','Incorreta. O aspecto pode orientar, mas a classificação bioquímica é feita pelos critérios de Light.','Incorreta. PPD não integra os critérios de Light nem é teste validado no líquido para essa finalidade.','Incorreta. Prova funcional respiratória não classifica bioquimicamente o derrame.']),
  ('204c5764-87f3-4595-8060-8013ceaa9790'::uuid,'C',
   ARRAY['APGAR, baseado em frequência cardíaca e cor.','CHA2DS2-VASc, baseado em risco embólico.','Wells, baseado em probabilidade de TEP.','Child-Pugh, baseado em função hepática.'],
   ARRAY['Incorreta. APGAR avalia vitalidade neonatal e não gravidade de pneumonia no adulto.','Incorreta. CHA2DS2-VASc estima risco de AVC na fibrilação atrial.','Incorreta. Wells estima probabilidade de tromboembolismo, não gravidade de PAC na atenção primária.','Incorreta. Child-Pugh estratifica cirrose. O CRB-65 usa confusão, frequência respiratória, pressão e idade.']),
  ('48a7ce6f-a1e3-4747-a84a-62471b263705'::uuid,'D',
   ARRAY['Idade abaixo de 40 anos sem comorbidades.','Rinite alérgica e uso de anti-histamínico.','Vacinação pneumocócica prévia.','Pneumonia lobar única sem antibiótico recente ou doença estrutural.'],
   ARRAY['Incorreta. Idade jovem isolada não aumenta risco de Pseudomonas.','Incorreta. Atopia não é fator reconhecido para colonização por bacilo gram-negativo resistente.','Incorreta. Vacinação não é indicação de cobertura antipseudomonas.','Incorreta. Sem isolamento prévio, antibiótico IV recente ou doença pulmonar estrutural, cobertura empírica ampla não é justificada.']),
  ('24dd54ce-4b74-499a-9885-9fdc11f119bf'::uuid,'E',
   ARRAY['Histoplasmose exclusivamente cutânea, sem formas sistêmicas.','Tuberculose com formas juvenil e crônica definidas por roda de leme.','Aspergilose dividida apenas em forma oral e pulmonar.','Coccidioidomicose confirmada por leveduras multibrotantes em roda de leme.'],
   ARRAY['Incorreta. Histoplasmose pode ser pulmonar ou disseminada, mas roda de leme não é sua morfologia.','Incorreta. Roda de leme identifica Paracoccidioides; não define formas clínicas da tuberculose.','Incorreta. Aspergilose inclui formas alérgica, crônica e invasiva, e não produz roda de leme.','Incorreta. Coccidioides forma esférulas com endósporos nos tecidos, não leveduras multigemantes.']),
  ('e1f88927-5f4d-42e3-bc90-eb8757e76ceb'::uuid,'A',
   ARRAY['Fluconazol em dose única para todas as formas.','Anfotericina B obrigatória em todo caso leve e estável.','Corticoide sistêmico isolado até negativação da sorologia.','Interromper itraconazol assim que cessarem tosse e febre.'],
   ARRAY['Incorreta. PCM requer meses de terapia; fluconazol em dose única não é eficaz.','Incorreta. Itraconazol é preferido nas formas leves/moderadas; anfotericina fica para doença grave.','Incorreta. Corticoide não erradica o fungo e pode agravar a infecção se usado sem antifúngico e indicação específica.','Incorreta. Resposta sintomática precoce não equivale à cura; tratamento e seguimento obedecem critérios clínicos, radiológicos e sorológicos.']),
  ('a198e999-fcfa-4063-a1b0-df0544c0f22b'::uuid,'B',
   ARRAY['Diagnosticar pneumonia bacteriana apenas pela radiografia e iniciar macrolídeo.','Solicitar somente PPD; resultado positivo confirma doença ativa.','Encerrar investigação porque a primeira baciloscopia foi negativa.','Solicitar espirometria como teste confirmatório de tuberculose.'],
   ARRAY['Incorreta. A evolução crônica, sintomas constitucionais e cavitação apical exigem investigação de tuberculose.','Incorreta. PPD indica infecção, mas não diferencia doença ativa de latência.','Incorreta. Uma baciloscopia negativa não exclui TB; TRM-TB e cultura aumentam a confirmação e avaliam resistência.','Incorreta. Espirometria avalia função pulmonar e não detecta M. tuberculosis.']),
  ('4477f02f-8f05-489b-9e5d-14c501a5176c'::uuid,'C',
   ARRAY['Exsudato porque proteína pleural/sérica é menor que 0,5.','Empiema apenas porque existe líquido pleural.','Quilotórax definido exclusivamente por DHL baixo.','Hemotórax porque o líquido é transudativo.'],
   ARRAY['Incorreta. Relação proteica abaixo de 0,5 favorece transudato; exsudato exige pelo menos um critério de Light positivo.','Incorreta. Empiema requer pus ou evidência microbiológica/inflamatória de infecção pleural.','Incorreta. Quilotórax é definido por triglicerídeos elevados ou quilomícrons, não pelo DHL isolado.','Incorreta. Hemotórax é definido por hematócrito pleural elevado em relação ao sangue e não pela classificação de Light.']),
  ('c48b70a4-2b5e-43a6-ba4f-f457bb9c54ad'::uuid,'A',
   ARRAY['Hifas septadas com ramificação em ângulo agudo.','Esférulas grandes contendo endósporos.','Leveduras pequenas intracelulares em macrófagos.','Bacilos álcool-ácido resistentes na coloração de Ziehl-Neelsen.'],
   ARRAY['Incorreta. Esse é o padrão histológico de Aspergillus.','Incorreta. Esférulas com endósporos caracterizam Coccidioides.','Incorreta. Leveduras pequenas intracelulares sugerem Histoplasma.','Incorreta. BAAR sustentam micobacteriose/tuberculose, não paracoccidioidomicose.']),
  ('4acaa29d-49b5-4d3d-bc79-dc8023afc5b4'::uuid,'C',
   ARRAY['Repetir apenas radiografia em seis meses.','Considerar TB excluída após uma baciloscopia negativa.','Solicitar somente PPD e iniciar tratamento se positivo.','Prescrever antibiótico para pneumonia e dispensar investigação de micobactéria.'],
   ARRAY['Incorreta. A suspeita clínica é alta e exige investigação microbiológica imediata.','Incorreta. Baciloscopia tem sensibilidade limitada; TRM-TB e cultura são necessários conforme protocolo.','Incorreta. PPD não confirma doença pulmonar ativa nem informa resistência à rifampicina.','Incorreta. Antibiótico empírico não substitui busca de TB em tosse prolongada com cavitação e sintomas constitucionais.']),
  ('432a23a5-bd9d-48ed-a543-2ca7acb9fc36'::uuid,'D',
   ARRAY['Manter o caso em sigilo e não notificar a vigilância.','Liberar contatos sem avaliação porque não têm sintomas.','Suspender o tratamento quando houver melhora clínica.','Não orientar medidas de controle respiratório enquanto houver baciloscopia positiva.'],
   ARRAY['Incorreta. Tuberculose é doença de notificação compulsória e exige registro e acompanhamento.','Incorreta. Contatos devem ser identificados e avaliados para doença ativa e infecção latente conforme protocolo.','Incorreta. O esquema completo deve ser cumprido; interrupção precoce favorece falha, recidiva e resistência.','Incorreta. Etiqueta respiratória, ventilação e máscara em situações indicadas reduzem transmissão até controle da infectividade.']),
  ('8db1c93a-a8c7-4930-ac9a-ba8975d6f363'::uuid,'E',
   ARRAY['Derrame transudativo por insuficiência cardíaca, com poucas células.','Tuberculose pleural, obrigatoriamente com BAAR positivo no líquido.','Hemotórax espontâneo, com hematócrito pleural baixo.','Quilotórax, definido por líquido purulento e neutrofílico.'],
   ARRAY['Incorreta. Febre alta, consolidação e neutrofilia favorecem derrame parapneumônico exsudativo.','Incorreta. TB pleural costuma ser subaguda e linfocitária; BAAR no líquido tem baixa sensibilidade e não é obrigatório.','Incorreta. Hemotórax exige hematócrito pleural alto, geralmente acima de 50% do periférico.','Incorreta. Quilotórax é rico em triglicerídeos/quilomícrons e tipicamente leitoso, não purulento por definição.']),
  ('e8479fa8-4130-4cdd-9f6c-d96d80d96830'::uuid,'B',
   ARRAY['PPD isolado confirma tuberculose ativa.','Radiografia de tórax isolada identifica o bacilo e sua resistência.','Hemograma e PCR confirmam a etiologia tuberculosa.','Espirometria com resposta broncodilatadora confirma TB.'],
   ARRAY['Incorreta. PPD identifica sensibilização e não diferencia infecção latente de doença ativa.','Incorreta. A imagem apoia e avalia extensão, mas confirmação e resistência dependem de testes microbiológicos/moleculares.','Incorreta. Marcadores inflamatórios são inespecíficos.','Incorreta. Espirometria avalia limitação ventilatória, não presença de micobactéria.']),
  ('5ccf8777-9ca7-4afd-a4e5-fb14d26febd0'::uuid,'C',
   ARRAY['Rifampicina isolada por seis meses.','Isoniazida e rifampicina por um mês apenas.','Claritromicina, etambutol e rifabutina para TB sensível inicial.','Cinco comprimidos de RHZE durante todos os seis meses, sem mudança de fase.'],
   ARRAY['Incorreta. Monoterapia em TB ativa seleciona resistência.','Incorreta. Duração e número de fármacos são insuficientes para doença ativa.','Incorreta. Esse esquema se aproxima do tratamento de micobactérias não tuberculosas, não da TB sensível habitual.','Incorreta. Após dois meses de RHZE, a manutenção usual é feita com RH por quatro meses.']),
  ('4f8b9b8d-e182-440b-a425-98001015e6cf'::uuid,'D',
   ARRAY['Tratar como crise de asma e dispensar investigação de TEP.','Trombolisar imediatamente apesar de pressão normal e sem diagnóstico confirmado.','Solicitar apenas D-dímero em probabilidade clínica alta e aguardar em casa.','Administrar antibiótico para pneumonia como única conduta.'],
   ARRAY['Incorreta. Pós-operatório, taquicardia, dor pleurítica e hipocapnia aumentam suspeita de TEP.','Incorreta. Trombólise é reservada ao TEP de alto risco com instabilidade ou resgate selecionado, devido ao risco hemorrágico.','Incorreta. Em probabilidade alta, o exame de imagem é prioritário; D-dímero positivo não confirma e o paciente requer avaliação.','Incorreta. Não há síndrome infecciosa descrita, e antibiótico não trata tromboembolismo.']),
  ('f822ee74-b525-4053-bf87-5cee3c3a4adb'::uuid,'A',
   ARRAY['PCR elevada demonstra necessariamente coinfecção bacteriana.','A PCR é produzida pelo pulmão após destruição alveolar direta.','PCR alta exclui resposta viral porque vírus não elevam proteínas de fase aguda.','O valor não tem relação com intensidade inflamatória ou prognóstico.'],
   ARRAY['Incorreta. PCR é inespecífica e pode subir intensamente na COVID-19 sem coinfecção bacteriana.','Incorreta. A PCR é sintetizada principalmente no fígado em resposta a IL-6 e outras citocinas.','Incorreta. Infecções virais sistêmicas podem elevar PCR por ativação inflamatória.','Incorreta. Na COVID-19, elevação importante se associa a maior inflamação e gravidade, embora não determine prognóstico isoladamente.']),
  ('abfb7fa7-d364-499a-a270-4b8f121c0c08'::uuid,'B',
   ARRAY['D-dímero de 800 confirma TEP e indica trombólise imediata.','A elevação resulta apenas de redução da filtração renal.','D-dímero mede diretamente a carga viral do SARS-CoV-2.','O achado exclui hipercoagulabilidade por mostrar degradação de fibrina.'],
   ARRAY['Incorreta. O marcador é inespecífico; TEP depende de probabilidade clínica e imagem, e trombólise de instabilidade.','Incorreta. Função renal pode influenciar marcadores, mas a COVID ativa coagulação por inflamação e lesão endotelial.','Incorreta. D-dímero é produto de degradação da fibrina e não quantifica vírus.','Incorreta. Formação e lise aumentadas de fibrina são justamente sinais de ativação trombótica/fibrinolítica.']),
  ('3ad3f478-8e4a-4f81-a2cb-31f825f0a497'::uuid,'C',
   ARRAY['Cavidade apical única com bola fúngica móvel.','Derrame pleural volumoso como achado predominante obrigatório.','Hiperinsuflação isolada sem opacidades.','Nódulo solitário calcificado em pipoca.'],
   ARRAY['Incorreta. Esse padrão sugere aspergiloma em cavidade prévia, não pneumonia viral por COVID-19.','Incorreta. Derrame significativo é incomum como manifestação dominante da COVID típica.','Incorreta. Hiperinsuflação é mais associada a doença obstrutiva e não ao padrão alveolointersticial viral.','Incorreta. Calcificação em pipoca é clássica de hamartoma pulmonar.']),
  ('bf935a13-c6c0-46bf-b5f1-42d487eeb4bd'::uuid,'D',
   ARRAY['Manter contato próximo sem máscara até sair o resultado.','Iniciar antibiótico e corticoide por conta própria.','Procurar emergência obrigatoriamente apesar de sintomas leves e ausência de alarme.','Ignorar os sintomas porque coriza exclui COVID-19.'],
   ARRAY['Incorreta. Enquanto há suspeita transmissível, deve reduzir contatos, usar máscara e seguir orientação de testagem/isolamento vigente.','Incorreta. Antibiótico não trata vírus e corticoide precoce sem hipoxemia pode ser prejudicial.','Incorreta. Casos leves podem ser manejados com testagem, isolamento e monitorização, reservando urgência para sinais de alarme.','Incorreta. Coriza pode ocorrer em COVID-19; exposição e sintomas respiratórios justificam testagem e precauções.'])
),
expanded AS (
  SELECT
    c.question_id,
    wrong.letter,
    c.texts[wrong.position] AS new_text,
    c.explanations[wrong.position] AS new_explanation
  FROM corrections c
  CROSS JOIN LATERAL (
    SELECT letter, row_number() OVER (ORDER BY letter)::int AS position
    FROM unnest(ARRAY['A','B','C','D','E']) AS letter
    WHERE letter <> c.correct_letter
  ) wrong
),
UPDATE public.alternatives a
  SET text = e.new_text,
      explanation = e.new_explanation
  FROM expanded e
  WHERE a.question_id = e.question_id
    AND a.letter = e.letter;

DO $$
DECLARE v_remaining integer;
BEGIN
  SELECT count(*) INTO v_remaining
  FROM public.alternatives a
  JOIN public.questions q ON q.id=a.question_id
  JOIN public.disciplines d ON d.id=q.discipline_id
  WHERE d.name='Pneumologia'
    AND (
      coalesce(a.explanation,'') ILIKE '%Esta alternativa é plausível, mas é incompleta%'
      OR coalesce(a.text,'') IN (
        'Resposta incompleta, que aborda apenas parte do problema apresentado.',
        'Conduta antiga ou menos adequada segundo diretrizes atuais.',
        'Alternativa plausível, porém sem confirmação diagnóstica adequada.',
        'Conduta excessiva ou insuficiente para a gravidade do caso.'
      )
    );
  IF v_remaining <> 0 THEN
    RAISE EXCEPTION 'Ainda restam % alternativas genéricas em Pneumologia', v_remaining;
  END IF;
END $$;

COMMIT;

-- A consulta deve retornar zero.
SELECT count(*) AS generic_explanations_remaining
FROM public.alternatives a
JOIN public.questions q ON q.id = a.question_id
JOIN public.disciplines d ON d.id = q.discipline_id
WHERE d.name = 'Pneumologia'
  AND (
    coalesce(a.explanation,'') ILIKE '%Esta alternativa é plausível, mas é incompleta%'
    OR coalesce(a.text,'') IN (
      'Resposta incompleta, que aborda apenas parte do problema apresentado.',
      'Conduta antiga ou menos adequada segundo diretrizes atuais.',
      'Alternativa plausível, porém sem confirmação diagnóstica adequada.',
      'Conduta excessiva ou insuficiente para a gravidade do caso.'
    )
  );
