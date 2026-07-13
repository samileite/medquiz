-- Migration de dados: Dermatologia — Prova 2
-- Gerada a partir do documento fornecido, preservando enunciados, alternativas, justificativas, dicas e explicações gerais.
-- Total de questões: 125
-- Questões com imagem: 2
-- Observação: as imagens são publicadas pelo frontend em /questions/dermatologia/.

ALTER TABLE public.questions
ADD COLUMN IF NOT EXISTS image_url text;

BEGIN;

DO $migration$
DECLARE
    v_discipline_id uuid;
BEGIN
    SELECT id INTO v_discipline_id FROM public.disciplines WHERE name = 'Dermatologia' LIMIT 1;
    IF v_discipline_id IS NULL THEN
        RAISE EXCEPTION 'Disciplina Dermatologia não encontrada em public.disciplines';
    END IF;

    -- Questão 001 | Turma 115 -T1- Transformada em objetiva
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '7401f5a3-58a6-56c7-ba4a-0fcb2a45602e'::uuid, v_discipline_id, NULL, 'médio',
        'REC, 33 anos, jardineiro, chega ao atendimento com lesões que se iniciam como nódulos, amolecem, tornam-se ulceradas, localizadas nos membros superiores em cordões linfáticos. Ao exame de cultura, observou-se hifas septadas com conídios em cacho ("margarida"), em relação ao caso acima, responda qual o diagnóstico e forma clínica.', 'single',
        'C', ARRAY[]::text[],
        'A esporotricose é uma micose subcutânea causada por fungos do complexo Sporothrix, geralmente adquirida por inoculação traumática durante o contato com solo, vegetais, madeira ou gatos infectados. A forma cutâneo-linfática representa cerca de 70–80% dos casos e caracteriza-se pelo surgimento de um nódulo no local da inoculação, seguido de novos nódulos que acompanham os vasos linfáticos e podem ulcerar. A cultura é o padrão-ouro diagnóstico e evidencia hifas septadas com conídios em arranjo típico de "flor de margarida". O tratamento de primeira escolha é o itraconazol, sendo a solução saturada de iodeto de potássio uma alternativa clássica em casos selecionados.
Para a Esporotricose cutâneo-linfática, qual alternativa contém 2 drogas de primeiras escolhas.
Fluconazol + Terbinafina.
Justificativa: Incorreta. O fluconazol apresenta baixa eficácia contra Sporothrix spp. A terbinafina pode ser utilizada em situações específicas, mas essa associação não representa a primeira escolha.
Itraconazol + Solução saturada de iodeto de potássio (SSKI).
Justificativa: Correta. O itraconazol é o tratamento de primeira escolha para a esporotricose cutâneo-linfática. A solução saturada de iodeto de potássio (SSKI) permanece como alternativa clássica e também é considerada uma opção de primeira linha em diversos protocolos.
Anfotericina B lipossomal + Voriconazol.
Justificativa: Incorreta. A anfotericina B é reservada para formas graves, disseminadas ou extracutâneas. O voriconazol não faz parte do tratamento habitual da esporotricose.
Griseofulvina + Cetoconazol.
Justificativa: Incorreta. A griseofulvina é indicada principalmente para dermatofitoses, enquanto o cetoconazol não é recomendado como tratamento de escolha devido à sua toxicidade e menor eficácia.
🧠 Dica de memorização
Esporotricose leve/moderada → Itraconazol.
Alternativa clássica → Solução saturada de iodeto de potássio (SSKI).
Anfotericina B → apenas formas graves, disseminadas ou gestantes com doença grave.
Fluconazol e griseofulvina → não são drogas de primeira escolha para esporotricose.
📚 Explicação geral
O tratamento da esporotricose cutâneo-linfática é realizado preferencialmente com itraconazol, devido à elevada eficácia e boa tolerabilidade. A solução saturada de iodeto de potássio (SSKI) continua sendo uma alternativa eficaz, especialmente em locais com poucos recursos ou quando o itraconazol não está disponível. A anfotericina B fica reservada para pacientes com formas disseminadas, extracutâneas, gestantes com doença grave ou imunossuprimidos com acometimento sistêmico. O tratamento deve ser mantido até a resolução clínica das lesões e por mais 2 a 4 semanas para reduzir o risco de recidiva.
Na esporotricose cutâneo-linfática, as lesões iniciam-se como nódulos que evoluem para ulceração ao longo do trajeto linfático. Qual alternativa apresenta a lesão elementar característica desse caso?
Pústula → coleção purulenta superficial restrita à epiderme.
Justificativa: Incorreta. A pústula é uma lesão purulenta superficial, característica de infecções bacterianas e algumas dermatoses, não da apresentação inicial da esporotricose cutâneo-linfática.
Nódulo → lesão sólida, profunda, que pode amolecer e ulcerar durante a evolução.
Justificativa: Correta. A lesão elementar inicial é o nódulo, que corresponde a uma lesão sólida e profunda. Com a evolução, pode amolecer, ulcerar e originar novos nódulos ao longo dos vasos linfáticos.
Vesícula → pequena elevação contendo líquido claro, localizada na epiderme.
Justificativa: Incorreta. A vesícula contém líquido seroso e é típica de doenças como herpes simples, herpes-zóster, varicela e dermatite de contato.
Placa verrucosa → lesão elevada de superfície áspera, típica da cromoblastomicose
Justificativa: Incorreta. A placa verrucosa é característica da cromoblastomicose, e não da esporotricose.
🧠 Dica de memorização
Esporotricose → começa com nódulo → evolui para úlcera → segue vasos linfáticos.
Pústula = pus.
Vesícula = líquido claro.
Placa verrucosa = cromoblastomicose.
📚 Explicação geral
A lesão elementar inicial da esporotricose cutâneo-linfática é o nódulo, resultante da inoculação traumática do Sporothrix spp. Esse nódulo torna-se progressivamente amolecido, podendo ulcerar e dar origem a novos nódulos ao longo da drenagem linfática, formando o clássico trajeto em cordão linfático. A identificação correta da lesão elementar é importante porque muitas doenças infecciosas apresentam úlceras na fase tardia, mas diferem na lesão inicial. Na esporotricose, o reconhecimento do nódulo linfangítico associado à história epidemiológica (jardineiros, espinhos, contato com gatos) é um dos principais indícios diagnósticos.', 'A esporotricose é uma micose subcutânea causada por fungos do complexo Sporothrix, geralmente adquirida por inoculação traumática durante o contato com solo, vegetais, madeira ou gatos infectados.',
        'Jardineiro + espinho + rosa → pense em Sporothrix.
"Cordão linfático" ou "rosário linfático" → forma cutâneo-linfática.
Conídios em "margarida" (cultura) → esporotricose.
Corpos fumagoides → cromoblastomicose.
Forma fixa = lesão única; forma cutâneo-linfática = múltiplos nódulos ao longo dos vasos linfáticos.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '302e46ca-3f7e-5d6d-bd44-bdf99a3a6bbb'::uuid, '7401f5a3-58a6-56c7-ba4a-0fcb2a45602e'::uuid,
        'A', 'Esporotricose cutânea fixa → inoculação localizada → lesão única restrita ao local do trauma.', 'Incorreta. A forma cutânea fixa apresenta lesão única, limitada ao sítio de inoculação, sem disseminação pelos vasos linfáticos.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '5b8a0665-656e-51f9-8302-0ba33da53796'::uuid, '7401f5a3-58a6-56c7-ba4a-0fcb2a45602e'::uuid,
        'B', 'Cromoblastomicose verrucosa → infecção por fungos demáceos → lesões verrucosas com corpos fumagoides ao exame micológico direto.', 'Incorreta. A cromoblastomicose cursa com lesões verrucosas e corpos fumagoides (escleróticos) no exame micológico direto, não com nódulos ulcerados em trajeto linfático nem conídios em "margarida".'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'a18d7e8c-7a7d-5dd0-8c8f-02baaf4d45b7'::uuid, '7401f5a3-58a6-56c7-ba4a-0fcb2a45602e'::uuid,
        'C', 'Esporotricose cutâneo-linfática → infecção por Sporothrix spp. → nódulos ulcerados distribuídos ao longo dos vasos linfáticos ("rosário linfático").', 'Correta. O quadro é clássico de esporotricose cutâneo-linfática, a forma clínica mais frequente. A disposição dos nódulos ao longo dos vasos linfáticos e os conídios em "margarida" na cultura são característicos de Sporothrix spp.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'ae2dc31b-a444-5640-9c54-80a58b2ebc5c'::uuid, '7401f5a3-58a6-56c7-ba4a-0fcb2a45602e'::uuid,
        'D', 'Leishmaniose cutânea disseminada → úlceras múltiplas decorrentes de disseminação hematogênica do protozoário.', 'Incorreta. A leishmaniose cutânea pode causar úlceras, porém não apresenta disseminação linfática nodular típica nem crescimento do fungo com conídios em "margarida".'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 002 | Turma 115 -T1- Transformada em objetiva
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        'cfa23db5-66a3-541c-a678-856f9a7ff007'::uuid, v_discipline_id, NULL, 'médio',
        'Para a Esporotricose cutâneo-linfática, qual alternativa contém 2 drogas de primeiras escolhas.', 'single',
        'B', ARRAY[]::text[],
        'O tratamento da esporotricose cutâneo-linfática é realizado preferencialmente com itraconazol, devido à elevada eficácia e boa tolerabilidade. A solução saturada de iodeto de potássio (SSKI) continua sendo uma alternativa eficaz, especialmente em locais com poucos recursos ou quando o itraconazol não está disponível. A anfotericina B fica reservada para pacientes com formas disseminadas, extracutâneas, gestantes com doença grave ou imunossuprimidos com acometimento sistêmico. O tratamento deve ser mantido até a resolução clínica das lesões e por mais 2 a 4 semanas para reduzir o risco de recidiva.
Na esporotricose cutâneo-linfática, as lesões iniciam-se como nódulos que evoluem para ulceração ao longo do trajeto linfático. Qual alternativa apresenta a lesão elementar característica desse caso?
Pústula → coleção purulenta superficial restrita à epiderme.
Justificativa: Incorreta. A pústula é uma lesão purulenta superficial, característica de infecções bacterianas e algumas dermatoses, não da apresentação inicial da esporotricose cutâneo-linfática.
Nódulo → lesão sólida, profunda, que pode amolecer e ulcerar durante a evolução.
Justificativa: Correta. A lesão elementar inicial é o nódulo, que corresponde a uma lesão sólida e profunda. Com a evolução, pode amolecer, ulcerar e originar novos nódulos ao longo dos vasos linfáticos.
Vesícula → pequena elevação contendo líquido claro, localizada na epiderme.
Justificativa: Incorreta. A vesícula contém líquido seroso e é típica de doenças como herpes simples, herpes-zóster, varicela e dermatite de contato.
Placa verrucosa → lesão elevada de superfície áspera, típica da cromoblastomicose
Justificativa: Incorreta. A placa verrucosa é característica da cromoblastomicose, e não da esporotricose.
🧠 Dica de memorização
Esporotricose → começa com nódulo → evolui para úlcera → segue vasos linfáticos.
Pústula = pus.
Vesícula = líquido claro.
Placa verrucosa = cromoblastomicose.
📚 Explicação geral
A lesão elementar inicial da esporotricose cutâneo-linfática é o nódulo, resultante da inoculação traumática do Sporothrix spp. Esse nódulo torna-se progressivamente amolecido, podendo ulcerar e dar origem a novos nódulos ao longo da drenagem linfática, formando o clássico trajeto em cordão linfático. A identificação correta da lesão elementar é importante porque muitas doenças infecciosas apresentam úlceras na fase tardia, mas diferem na lesão inicial. Na esporotricose, o reconhecimento do nódulo linfangítico associado à história epidemiológica (jardineiros, espinhos, contato com gatos) é um dos principais indícios diagnósticos.', 'O tratamento da esporotricose cutâneo-linfática é realizado preferencialmente com itraconazol, devido à elevada eficácia e boa tolerabilidade.',
        'Esporotricose leve/moderada → Itraconazol.
Alternativa clássica → Solução saturada de iodeto de potássio (SSKI).
Anfotericina B → apenas formas graves, disseminadas ou gestantes com doença grave.
Fluconazol e griseofulvina → não são drogas de primeira escolha para esporotricose.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'bfe001d7-7141-50e0-b012-57615e6a5821'::uuid, 'cfa23db5-66a3-541c-a678-856f9a7ff007'::uuid,
        'A', 'Fluconazol + Terbinafina.', 'Incorreta. O fluconazol apresenta baixa eficácia contra Sporothrix spp. A terbinafina pode ser utilizada em situações específicas, mas essa associação não representa a primeira escolha.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '749b55d3-e41a-557d-9d7c-81fb72db89c1'::uuid, 'cfa23db5-66a3-541c-a678-856f9a7ff007'::uuid,
        'B', 'Itraconazol + Solução saturada de iodeto de potássio (SSKI).', 'Correta. O itraconazol é o tratamento de primeira escolha para a esporotricose cutâneo-linfática. A solução saturada de iodeto de potássio (SSKI) permanece como alternativa clássica e também é considerada uma opção de primeira linha em diversos protocolos.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '85cbfd1b-0795-5c86-b1c6-6c06881483fc'::uuid, 'cfa23db5-66a3-541c-a678-856f9a7ff007'::uuid,
        'C', 'Anfotericina B lipossomal + Voriconazol.', 'Incorreta. A anfotericina B é reservada para formas graves, disseminadas ou extracutâneas. O voriconazol não faz parte do tratamento habitual da esporotricose.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'b662cf1e-d5e9-5b4a-b2d0-0702b1237c30'::uuid, 'cfa23db5-66a3-541c-a678-856f9a7ff007'::uuid,
        'D', 'Griseofulvina + Cetoconazol.', 'Incorreta. A griseofulvina é indicada principalmente para dermatofitoses, enquanto o cetoconazol não é recomendado como tratamento de escolha devido à sua toxicidade e menor eficácia.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 003 | Turma 115 -T1- Transformada em objetiva
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '0ff69de8-35b8-5785-a842-1af6c4b91747'::uuid, v_discipline_id, NULL, 'médio',
        'Na esporotricose cutâneo-linfática, as lesões iniciam-se como nódulos que evoluem para ulceração ao longo do trajeto linfático. Qual alternativa apresenta a lesão elementar característica desse caso?', 'single',
        'B', ARRAY[]::text[],
        'A lesão elementar inicial da esporotricose cutâneo-linfática é o nódulo, resultante da inoculação traumática do Sporothrix spp. Esse nódulo torna-se progressivamente amolecido, podendo ulcerar e dar origem a novos nódulos ao longo da drenagem linfática, formando o clássico trajeto em cordão linfático. A identificação correta da lesão elementar é importante porque muitas doenças infecciosas apresentam úlceras na fase tardia, mas diferem na lesão inicial. Na esporotricose, o reconhecimento do nódulo linfangítico associado à história epidemiológica (jardineiros, espinhos, contato com gatos) é um dos principais indícios diagnósticos.', 'A lesão elementar inicial da esporotricose cutâneo-linfática é o nódulo, resultante da inoculação traumática do Sporothrix spp.',
        'Esporotricose → começa com nódulo → evolui para úlcera → segue vasos linfáticos.
Pústula = pus.
Vesícula = líquido claro.
Placa verrucosa = cromoblastomicose.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'c67f3202-bf26-5459-a39c-4f8b61b02014'::uuid, '0ff69de8-35b8-5785-a842-1af6c4b91747'::uuid,
        'A', 'Pústula → coleção purulenta superficial restrita à epiderme.', 'Incorreta. A pústula é uma lesão purulenta superficial, característica de infecções bacterianas e algumas dermatoses, não da apresentação inicial da esporotricose cutâneo-linfática.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '29f2fe73-e92c-50cf-97a2-59b31c07d130'::uuid, '0ff69de8-35b8-5785-a842-1af6c4b91747'::uuid,
        'B', 'Nódulo → lesão sólida, profunda, que pode amolecer e ulcerar durante a evolução.', 'Correta. A lesão elementar inicial é o nódulo, que corresponde a uma lesão sólida e profunda. Com a evolução, pode amolecer, ulcerar e originar novos nódulos ao longo dos vasos linfáticos.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'acaf9ded-601d-52a9-9052-f5ce2fc54d5b'::uuid, '0ff69de8-35b8-5785-a842-1af6c4b91747'::uuid,
        'C', 'Vesícula → pequena elevação contendo líquido claro, localizada na epiderme.', 'Incorreta. A vesícula contém líquido seroso e é típica de doenças como herpes simples, herpes-zóster, varicela e dermatite de contato.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '29425860-e88d-57a7-bcdb-964ef254a0a5'::uuid, '0ff69de8-35b8-5785-a842-1af6c4b91747'::uuid,
        'D', 'Placa verrucosa → lesão elevada de superfície áspera, típica da cromoblastomicose', 'Incorreta. A placa verrucosa é característica da cromoblastomicose, e não da esporotricose.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 004 | Turma 115 -T1- Transformada em objetiva
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        'd605ab3b-7e1e-5d10-9fa4-c9254d0e7b49'::uuid, v_discipline_id, NULL, 'médio',
        'LCF, médico, praticante de esportes radicais, 38 anos, refere surgimento há 6 meses de lesão verrucosa em membro inferior, atualmente com odor fétido. O exame micológico direto evidenciou corpos fumagoides. Qual alternativa apresenta o principal agente etiológico desse caso?', 'single',
        'B', ARRAY[]::text[],
        'A cromoblastomicose é uma micose subcutânea crônica causada por fungos demáceos inoculados após trauma com madeira, espinhos ou solo contaminado. A doença evolui lentamente, formando placas ou lesões verrucosas, frequentemente localizadas nos membros inferiores. O exame micológico direto evidencia corpos fumagóides (corpos escleróticos ou de Medlar), considerados praticamente patognomônicos da doença. No Brasil, o principal agente etiológico é Fonsecaea pedrosoi.
Na cromoblastomicose, qual alternativa apresenta corretamente duas possibilidades terapêuticas farmacológicas e duas possibilidades terapêuticas não farmacológicas?
Itraconazol + Terbinafina → Crioterapia + Excisão cirúrgica.
Justificativa: Correta. O itraconazol e a terbinafina são os principais antifúngicos utilizados na cromoblastomicose. Entre as medidas não farmacológicas, destacam-se crioterapia, excisão cirúrgica e outras terapias físicas em lesões localizadas.
Fluconazol + Griseofulvina → Radioterapia + Laserterapia.
Justificativa: Incorreta. Fluconazol e griseofulvina apresentam baixa eficácia na cromoblastomicose. Radioterapia não faz parte do tratamento da doença.
Anfotericina B + Voriconazol → Drenagem cirúrgica + Compressas mornas.
Justificativa: Incorreta. A anfotericina B não é tratamento habitual da cromoblastomicose, sendo reservada para situações excepcionais. Drenagem e compressas não possuem papel terapêutico na doença.
Cetoconazol + Nistatina → Curetagem + Debridamento superficial.
Justificativa: Incorreta. A nistatina não possui atividade contra fungos demáceos, e curetagem isolada não é considerada tratamento efetivo da cromoblastomicose.
🧠 Dica de memorização
Cromoblastomicose = Itraconazol ou Terbinafina.
Lesões pequenas → Crioterapia e cirurgia podem curar.
Corpos fumagoides → diagnóstico.
Esporotricose → Itraconazol + iodeto de potássio.
Conídios em margarida ≠ corpos fumagoides.
📚 Explicação geral
A cromoblastomicose é uma micose subcutânea de difícil tratamento devido à intensa fibrose e ao crescimento lento dos fungos demáceos. O tratamento costuma ser prolongado, sendo itraconazol e terbinafina as principais opções farmacológicas. Em lesões pequenas e localizadas, a associação com crioterapia, excisão cirúrgica ou termoterapia aumenta significativamente as taxas de cura. Casos extensos frequentemente necessitam da combinação entre terapia medicamentosa e procedimentos físicos, reduzindo recidivas e melhorando a resposta clínica.
MMA, com 2 semanas de idade, apresentou infecção de orofaringe e, alguns dias depois, evoluiu com febre, eritema difuso e bolhas flácidas que se romperam facilmente. Qual alternativa apresenta o principal agente etiológico desse quadro?
Streptococcus pyogenes → principal agente da erisipela e da escarlatina.
Justificativa: Incorreta. Streptococcus pyogenes está associado à escarlatina e à erisipela, mas não à Síndrome da Pele Escaldada Estafilocócica.
Staphylococcus aureus produtor das toxinas esfoliativas A e B → promove clivagem intraepidérmica por ação sobre a desmogleína 1.
Justificativa: Correta. A SSSS é causada por cepas de Staphylococcus aureus produtoras das toxinas esfoliativas A e/ou B, responsáveis pela clivagem da desmogleína 1 e formação de bolhas flácidas.
Pseudomonas aeruginosa → bacilo Gram-negativo frequentemente associado a queimaduras.
Justificativa: Incorreta. Pseudomonas aeruginosa pode causar infecções cutâneas graves, porém não produz a síndrome da pele escaldada.
Staphylococcus epidermidis → bactéria comensal da pele, relacionada principalmente a infecções de dispositivos médicos.
Justificativa: Incorreta. Staphylococcus epidermidis não produz toxinas esfoliativas e não causa SSSS.
🧠 Dica de memorização
Recém-nascido + bolhas flácidas + febre → SSSS.
SSSS → Staphylococcus aureus.
Toxinas esfoliativas A e B → Desmogleína 1.
Escarlatina → Streptococcus pyogenes.
Pênfigo foliáceo também acomete desmogleína 1, mas por autoanticorpos.
📚 Explicação geral
A Síndrome da Pele Escaldada Estafilocócica (SSSS) acomete principalmente recém-nascidos e crianças pequenas, devido à imaturidade renal, que dificulta a eliminação das toxinas. O agente é o Staphylococcus aureus produtor das toxinas esfoliativas ETA e ETB, que promovem clivagem da desmogleína 1, localizada na camada granulosa da epiderme. Clinicamente, observa-se febre, eritema difuso, bolhas flácidas e descamação extensa, geralmente sem acometimento de mucosas.
Qual técnica semiológica pode ser encontrada durante o exame físico de um caso de Síndrome da Pele Escaldada Estafilocócica?
Sinal de Nikolsky → descolamento da epiderme após fricção tangencial da pele aparentemente íntegra.
Justificativa: Correta. O sinal de Nikolsky é tipicamente positivo na SSSS devido à clivagem superficial da epiderme provocada pelas toxinas estafilocócicas.
Sinal de Auspitz → sangramento puntiforme após remoção de escamas.
Justificativa: Incorreta. O sinal de Auspitz é característico da psoríase.
Fenômeno de Koebner → surgimento de lesões em áreas de trauma.
Justificativa: Incorreta. O fenômeno de Koebner ocorre em doenças como psoríase, líquen plano e vitiligo.
Diascopia → desaparecimento do eritema à compressão com lâmina de vidro.
Justificativa: Incorreta. A diascopia é utilizada para avaliação de lesões vasculares e granulomatosas, não sendo um achado característico da SSSS.
🧠 Dica de memorização
SSSS → Nikolsky positivo.
Psoríase → Auspitz + Koebner.
Diascopia → diferencia eritema vascular de púrpura.
Bolha flácida + Nikolsky → pensar em doenças acantolíticas ou clivagem epidérmica (SSSS e pênfigos).
📚 Explicação geral
O sinal de Nikolsky consiste no descolamento da epiderme após fricção tangencial sobre pele aparentemente normal. Na SSSS, ele é positivo porque as toxinas esfoliativas degradam a desmogleína 1, reduzindo a adesão entre os queratinócitos da camada granulosa. Esse sinal também pode estar presente nos pênfigos, especialmente no pênfigo vulgar, porém o acometimento das mucosas é um importante diferencial: na SSSS as mucosas geralmente são poupadas, enquanto no pênfigo vulgar elas são frequentemente acometidas.
VGI, 8 anos, refere que há 4 dias surgiu uma bolha com pus que, após o dessecamento, evoluiu para crostas amareladas, com algumas lesões satélites ao exame físico. Qual alternativa apresenta corretamente o diagnóstico clínico?
Erisipela → infecção da derme profunda e vasos linfáticos → placa eritematosa bem delimitada, dolorosa e de rápida evolução.
Justificativa: Incorreta. A erisipela cursa com placa eritematosa infiltrada, edema e dor, sem formação de bolhas purulentas seguidas de crostas melicéricas.
Impetigo bolhoso → infecção superficial por Staphylococcus aureus → bolhas flácidas que se rompem facilmente, formando crostas melicéricas.
Justificativa: Correta. O quadro clínico é típico de impetigo bolhoso, caracterizado por bolhas superficiais que evoluem para crostas amareladas ("melicéricas"), acometendo principalmente crianças.
Ectima → infecção bacteriana ulcerada que acomete derme profunda → úlcera com crosta espessa e aderida.
Justificativa: Incorreta. O ectima é uma forma ulcerada do impetigo, acomete camadas mais profundas da pele e deixa cicatriz, diferente do quadro apresentado.
Herpes simples → vesículas agrupadas sobre base eritematosa → evolução recorrente.
Justificativa: Incorreta. O herpes simples caracteriza-se por vesículas agrupadas contendo líquido claro, geralmente dolorosas, e não por bolhas purulentas com crostas melicéricas.
🧠 Dica de memorização
Crosta melicérica = Impetigo.
Bolha flácida → pensar em impetigo bolhoso.
Úlcera profunda com cicatriz → Ectima.
Placa eritematosa dolorosa → Erisipela.
Vesículas agrupadas → Herpes simples.
📚 Explicação geral
O impetigo bolhoso é uma infecção bacteriana superficial causada quase exclusivamente pelo Staphylococcus aureus, produtor de toxinas esfoliativas. As bolhas são flácidas porque a clivagem ocorre na camada granulosa da epiderme. Após sua ruptura, surgem as características crostas melicéricas, consideradas um dos principais achados clínicos da doença. É mais comum em crianças e altamente contagioso.
Nos pacientes com impetigo, qual das alternativas apresenta uma possível complicação da doença?
Glomerulonefrite pós-estreptocócica → complicação imunológica que pode ocorrer após infecção por cepas nefritogênicas de Streptococcus pyogenes.
Justificativa: Correta. A glomerulonefrite pós-estreptocócica é uma complicação clássica do impetigo estreptocócico e pode surgir semanas após a infecção cutânea.
Febre reumática → complicação autoimune típica da faringoamigdalite estreptocócica.
Justificativa: Incorreta. A febre reumática está relacionada à faringite por Streptococcus pyogenes, não ao impetigo.
Neuralgia pós-herpética → dor neuropática persistente após infecção pelo vírus Varicela-Zóster.
Justificativa: Incorreta. Trata-se de complicação do herpes-zóster, sem relação com impetigo.
Síndrome de Ramsay Hunt → acometimento do nervo facial pelo vírus Varicela-Zóster.
Justificativa: Incorreta. A síndrome de Ramsay Hunt é uma complicação do herpes-zóster otológico e não do impetigo.
🧠 Dica de memorização
Impetigo estreptocócico → Glomerulonefrite pós-estreptocócica.
Faringite estreptocócica → Febre reumática.
Herpes-zóster → Neuralgia pós-herpética e Ramsay Hunt.
Crosta melicérica = lembrar do impetigo.
📚 Explicação geral
O impetigo é uma piodermite superficial causada por Staphylococcus aureus, Streptococcus pyogenes ou ambos. Embora a maioria dos casos evolua de forma benigna, quando há participação de cepas nefritogênicas de S. pyogenes, pode ocorrer glomerulonefrite pós-estreptocócica, uma complicação imunomediada decorrente da deposição de imunocomplexos nos glomérulos. Diferentemente da faringite estreptocócica, o impetigo não está associado ao desenvolvimento de febre reumática, o que constitui uma pegadinha frequente em provas de Dermatologia e Infectologia.
ADF, masculino, 14 anos, apresenta comedões abertos, intensa reação inflamatória, nódulos furunculoides e lesões purulentas na face. Qual alternativa apresenta corretamente o diagnóstico e a classificação da doença?
Acne comedoniana (Grau I) → predominam comedões abertos e fechados, sem lesões inflamatórias.
Justificativa: Incorreta. A acne grau I é exclusivamente comedoniana, sem nódulos ou lesões purulentas.
Acne papulopustulosa (Grau II) → presença de pápulas e pústulas superficiais, sem nódulos profundos.
Justificativa: Incorreta. A acne grau II apresenta inflamação leve a moderada, mas não cursa com nódulos furunculoides.
Acne conglobata (Grau IV) → forma inflamatória grave com nódulos, abscessos, fístulas e tendência à formação de cicatrizes.
Justificativa: Correta. A associação de comedões, nódulos furunculoides e lesões purulentas caracteriza acne conglobata, classificada como grau IV.
Acne fulminante (Grau V) → forma ulceronecrosante associada a febre, mal-estar e alterações laboratoriais sistêmicas.
Justificativa: Incorreta. A acne fulminante cursa com manifestações sistêmicas importantes, como febre, artralgias e mal-estar, ausentes no caso clínico.
🧠 Dica de memorização
Grau I → apenas comedões.
Grau II → pápulas e pústulas.
Grau III → nódulos e cistos.
Grau IV → acne conglobata = nódulos furunculoides + abscessos + fístulas.
Grau V → acne fulminante = acne grave + sintomas sistêmicos.
📚 Explicação geral
A acne vulgar é classificada conforme a intensidade da inflamação. A acne conglobata (grau IV) é uma das formas mais graves, predominando em adolescentes do sexo masculino. Caracteriza-se por comedões numerosos, nódulos inflamatórios profundos, abscessos, fístulas e intensa produção de secreção purulenta, evoluindo frequentemente com cicatrizes permanentes. Deve ser diferenciada da acne fulminante, que apresenta quadro sistêmico importante.
Nos casos de acne conglobata, qual alternativa apresenta duas medidas importantes para o manejo da doença?
Higienização frequente da pele + antibioticoterapia tópica isolada.
Justificativa: Incorreta. A higiene auxilia no controle da oleosidade, porém não controla formas graves, e a monoterapia com antibióticos deve ser evitada devido ao risco de resistência bacteriana.
Isotretinoína oral + acompanhamento clínico com monitorização laboratorial e orientação quanto ao risco de cicatrizes.
Justificativa: Correta. A isotretinoína é o tratamento de escolha da acne conglobata. O acompanhamento clínico e laboratorial é essencial devido aos efeitos adversos do medicamento e ao elevado risco de cicatrizes permanentes.
Apenas extração de comedões + peelings químicos seriados.
Justificativa: Incorreta. Esses procedimentos podem complementar o tratamento após o controle da inflamação, mas são insuficientes para tratar acne conglobata.
Corticoide tópico + suspensão definitiva de alimentos gordurosos.
Justificativa: Incorreta. Corticoides tópicos não fazem parte do tratamento da acne conglobata, e a exclusão de alimentos gordurosos isoladamente não controla a doença.
🧠 Dica de memorização
Acne grave → Isotretinoína oral.
Antibiótico nunca em monoterapia.
Peelings e extração de comedões → apenas adjuvantes, após controle da inflamação.
Acne fulminante → pode necessitar corticoterapia sistêmica antes da isotretinoína.
Quanto mais grave a acne, maior o risco de cicatrizes permanentes.
📚 Explicação geral
O tratamento da acne depende da gravidade das lesões. Na acne conglobata, a isotretinoína oral é considerada o tratamento de escolha por atuar sobre os quatro pilares fisiopatológicos da doença: redução da produção sebácea, normalização da queratinização folicular, diminuição da colonização por Cutibacterium acnes e ação anti-inflamatória. Durante o tratamento é necessária monitorização clínica e laboratorial, além de orientação sobre efeitos adversos, risco de cicatrizes e importância da adesão terapêutica. Antibióticos sistêmicos podem ser utilizados em situações específicas, mas não devem ser empregados como monoterapia.
AMM, 42 anos, HIV positivo, em tratamento com TARV iniciado há 2 semanas, relata febre baixa (37,9°C), adinamia e lesões dolorosas em mucosa oral e vaginal há 15 dias, caracterizadas por vesículas agrupadas sobre base eritematosa. Qual alternativa apresenta corretamente o diagnóstico clínico?
Herpes-zóster → reativação do vírus Varicela-Zóster → lesões vesiculares em distribuição dermatomérica unilateral.
Justificativa: Incorreta. O herpes-zóster apresenta distribuição ao longo de um dermátomo, geralmente unilateral, e não acomete simultaneamente mucosa oral e genital.
Herpes simples → infecção pelo vírus Herpes simplex (HSV-1/HSV-2) → vesículas agrupadas sobre base eritematosa, dolorosas, com frequente acometimento de mucosas.
Justificativa: Correta. O quadro é típico de herpes simples, caracterizado por lesões vesiculares dolorosas sobre base eritematosa, frequentemente envolvendo mucosas, especialmente em pacientes imunossuprimidos.
Síndrome da pele escaldada estafilocócica → toxinas esfoliativas do Staphylococcus aureus → bolhas flácidas difusas.
Justificativa: Incorreta. A SSSS acomete principalmente recém-nascidos e crianças pequenas, cursando com bolhas flácidas e descamação difusa, sem vesículas agrupadas em mucosas.
Doença de Behçet → vasculite multissistêmica → úlceras orais e genitais recorrentes.
Justificativa: Incorreta. Embora a doença de Behçet apresente úlceras orais e genitais, as lesões são ulceradas desde o início, sem fase típica de vesículas agrupadas sobre base eritematosa.
🧠 Dica de memorização
HSV → Vesículas agrupadas + dor + base eritematosa.
HSV-1 → predominância oral.
HSV-2 → predominância genital (embora ambos possam acometer qualquer sítio).
Herpes-zóster → dermátomo unilateral.
Behçet → úlceras recorrentes, não vesículas.
📚 Explicação geral
O herpes simples é causado pelos vírus HSV-1 e HSV-2, permanecendo latente nos gânglios sensitivos após a infecção primária. A reativação ocorre principalmente em situações de imunossupressão, estresse ou trauma. As lesões iniciam-se como vesículas agrupadas sobre base eritematosa, que rapidamente se rompem formando erosões dolorosas. Em pacientes com HIV, as lesões podem ser extensas, persistentes e acometer simultaneamente diferentes mucosas.
Embora o diagnóstico do herpes simples seja predominantemente clínico, qual alternativa apresenta dois exames complementares que podem auxiliar na confirmação diagnóstica?
PCR para HSV + Citologia de Tzanck → detecta DNA viral e evidencia células gigantes multinucleadas, respectivamente.
Justificativa: Correta. O PCR é o método mais sensível para confirmação do HSV, enquanto o esfregaço de Tzanck demonstra células gigantes multinucleadas, auxiliando no diagnóstico.
Cultura bacteriana + Pesquisa de corpos fumagoides.
Justificativa: Incorreta. A cultura bacteriana não diagnostica herpes simples, e corpos fumagoides são característicos da cromoblastomicose.
Pesquisa de BAAR + Teste de Montenegro.
Justificativa: Incorreta. O BAAR é utilizado para micobactérias, e o teste de Montenegro auxilia no diagnóstico da leishmaniose tegumentar.
Exame micológico direto + Cultura para Sporothrix spp.
Justificativa: Incorreta. Esses exames são utilizados para micoses, como dermatofitoses e esporotricose, não para infecções pelo HSV.
🧠 Dica de memorização
Herpes simples → diagnóstico geralmente clínico.
PCR → exame mais sensível para HSV.
Tzanck → células gigantes multinucleadas (não diferencia HSV de VZV).
Cultura viral → pode ser utilizada, porém tem menor sensibilidade que o PCR.
Corpos fumagoides = cromoblastomicose | Conídios em "margarida" = esporotricose.
📚 Explicação geral
O diagnóstico do herpes simples é, na maioria das vezes, clínico, baseado na presença de vesículas agrupadas dolorosas sobre base eritematosa. Quando há necessidade de confirmação, especialmente em pacientes imunossuprimidos ou apresentações atípicas, o PCR para HSV é o exame de maior sensibilidade e especificidade. A citologia de Tzanck é um método rápido e de baixo custo, demonstrando células gigantes multinucleadas e acantólise, embora não diferencie HSV do vírus Varicela-Zóster. A cultura viral e testes de imunofluorescência também podem ser utilizados, mas atualmente o PCR é considerado o método de escolha para confirmação laboratorial.', 'A cromoblastomicose é uma micose subcutânea crônica causada por fungos demáceos inoculados após trauma com madeira, espinhos ou solo contaminado.',
        'Corpos fumagoides (escleróticos) → Cromoblastomicose.
Principal agente no Brasil → Fonsecaea pedrosoi.
Conídios em "margarida" → Esporotricose.
Roda de leme → Paracoccidioidomicose.
Dermatófitos → Micoses superficiais.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '03ca10dc-6fbd-5414-a685-9a70bd5941a3'::uuid, 'd605ab3b-7e1e-5d10-9fa4-c9254d0e7b49'::uuid,
        'A', 'Sporothrix schenckii → fungo dimórfico causador da esporotricose.', 'Incorreta. Sporothrix schenckii causa esporotricose, cuja apresentação típica é nodular com disseminação linfática, e não lesões verrucosas com corpos fumagoides.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '41d9121f-fa74-53e1-915a-509f8a27465c'::uuid, 'd605ab3b-7e1e-5d10-9fa4-c9254d0e7b49'::uuid,
        'B', 'Fonsecaea pedrosoi → fungo demáceo, principal agente etiológico da cromoblastomicose no Brasil.', 'Correta. Fonsecaea pedrosoi é o principal agente etiológico da cromoblastomicose no Brasil. A presença de lesão verrucosa crônica e corpos fumagoides (corpos escleróticos) é característica dessa micose.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '4d7f57c9-4db8-519a-910b-815dc7c29ec9'::uuid, 'd605ab3b-7e1e-5d10-9fa4-c9254d0e7b49'::uuid,
        'C', 'Paracoccidioides brasiliensis → fungo dimórfico causador da paracoccidioidomicose.', 'Incorreta. A paracoccidioidomicose acomete principalmente pulmões e mucosas, apresentando leveduras com brotamentos múltiplos ("roda de leme"), e não corpos fumagoides.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '85cefbff-8d61-5763-934e-d42914dfcb99'::uuid, 'd605ab3b-7e1e-5d10-9fa4-c9254d0e7b49'::uuid,
        'D', 'Trichophyton rubrum → dermatófito frequentemente associado às dermatofitoses.', 'Incorreta. Trichophyton rubrum causa dermatofitoses superficiais, sem formação de corpos fumagoides ou lesões verrucosas profundas.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 005 | Turma 115 -T1- Transformada em objetiva
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        'deda69f3-0463-589d-a7b8-8f5e79f2f40f'::uuid, v_discipline_id, NULL, 'médio',
        'Na cromoblastomicose, qual alternativa apresenta corretamente duas possibilidades terapêuticas farmacológicas e duas possibilidades terapêuticas não farmacológicas?', 'single',
        'A', ARRAY[]::text[],
        'A cromoblastomicose é uma micose subcutânea de difícil tratamento devido à intensa fibrose e ao crescimento lento dos fungos demáceos. O tratamento costuma ser prolongado, sendo itraconazol e terbinafina as principais opções farmacológicas. Em lesões pequenas e localizadas, a associação com crioterapia, excisão cirúrgica ou termoterapia aumenta significativamente as taxas de cura. Casos extensos frequentemente necessitam da combinação entre terapia medicamentosa e procedimentos físicos, reduzindo recidivas e melhorando a resposta clínica.
MMA, com 2 semanas de idade, apresentou infecção de orofaringe e, alguns dias depois, evoluiu com febre, eritema difuso e bolhas flácidas que se romperam facilmente. Qual alternativa apresenta o principal agente etiológico desse quadro?
Streptococcus pyogenes → principal agente da erisipela e da escarlatina.
Justificativa: Incorreta. Streptococcus pyogenes está associado à escarlatina e à erisipela, mas não à Síndrome da Pele Escaldada Estafilocócica.
Staphylococcus aureus produtor das toxinas esfoliativas A e B → promove clivagem intraepidérmica por ação sobre a desmogleína 1.
Justificativa: Correta. A SSSS é causada por cepas de Staphylococcus aureus produtoras das toxinas esfoliativas A e/ou B, responsáveis pela clivagem da desmogleína 1 e formação de bolhas flácidas.
Pseudomonas aeruginosa → bacilo Gram-negativo frequentemente associado a queimaduras.
Justificativa: Incorreta. Pseudomonas aeruginosa pode causar infecções cutâneas graves, porém não produz a síndrome da pele escaldada.
Staphylococcus epidermidis → bactéria comensal da pele, relacionada principalmente a infecções de dispositivos médicos.
Justificativa: Incorreta. Staphylococcus epidermidis não produz toxinas esfoliativas e não causa SSSS.
🧠 Dica de memorização
Recém-nascido + bolhas flácidas + febre → SSSS.
SSSS → Staphylococcus aureus.
Toxinas esfoliativas A e B → Desmogleína 1.
Escarlatina → Streptococcus pyogenes.
Pênfigo foliáceo também acomete desmogleína 1, mas por autoanticorpos.
📚 Explicação geral
A Síndrome da Pele Escaldada Estafilocócica (SSSS) acomete principalmente recém-nascidos e crianças pequenas, devido à imaturidade renal, que dificulta a eliminação das toxinas. O agente é o Staphylococcus aureus produtor das toxinas esfoliativas ETA e ETB, que promovem clivagem da desmogleína 1, localizada na camada granulosa da epiderme. Clinicamente, observa-se febre, eritema difuso, bolhas flácidas e descamação extensa, geralmente sem acometimento de mucosas.
Qual técnica semiológica pode ser encontrada durante o exame físico de um caso de Síndrome da Pele Escaldada Estafilocócica?
Sinal de Nikolsky → descolamento da epiderme após fricção tangencial da pele aparentemente íntegra.
Justificativa: Correta. O sinal de Nikolsky é tipicamente positivo na SSSS devido à clivagem superficial da epiderme provocada pelas toxinas estafilocócicas.
Sinal de Auspitz → sangramento puntiforme após remoção de escamas.
Justificativa: Incorreta. O sinal de Auspitz é característico da psoríase.
Fenômeno de Koebner → surgimento de lesões em áreas de trauma.
Justificativa: Incorreta. O fenômeno de Koebner ocorre em doenças como psoríase, líquen plano e vitiligo.
Diascopia → desaparecimento do eritema à compressão com lâmina de vidro.
Justificativa: Incorreta. A diascopia é utilizada para avaliação de lesões vasculares e granulomatosas, não sendo um achado característico da SSSS.
🧠 Dica de memorização
SSSS → Nikolsky positivo.
Psoríase → Auspitz + Koebner.
Diascopia → diferencia eritema vascular de púrpura.
Bolha flácida + Nikolsky → pensar em doenças acantolíticas ou clivagem epidérmica (SSSS e pênfigos).
📚 Explicação geral
O sinal de Nikolsky consiste no descolamento da epiderme após fricção tangencial sobre pele aparentemente normal. Na SSSS, ele é positivo porque as toxinas esfoliativas degradam a desmogleína 1, reduzindo a adesão entre os queratinócitos da camada granulosa. Esse sinal também pode estar presente nos pênfigos, especialmente no pênfigo vulgar, porém o acometimento das mucosas é um importante diferencial: na SSSS as mucosas geralmente são poupadas, enquanto no pênfigo vulgar elas são frequentemente acometidas.
VGI, 8 anos, refere que há 4 dias surgiu uma bolha com pus que, após o dessecamento, evoluiu para crostas amareladas, com algumas lesões satélites ao exame físico. Qual alternativa apresenta corretamente o diagnóstico clínico?
Erisipela → infecção da derme profunda e vasos linfáticos → placa eritematosa bem delimitada, dolorosa e de rápida evolução.
Justificativa: Incorreta. A erisipela cursa com placa eritematosa infiltrada, edema e dor, sem formação de bolhas purulentas seguidas de crostas melicéricas.
Impetigo bolhoso → infecção superficial por Staphylococcus aureus → bolhas flácidas que se rompem facilmente, formando crostas melicéricas.
Justificativa: Correta. O quadro clínico é típico de impetigo bolhoso, caracterizado por bolhas superficiais que evoluem para crostas amareladas ("melicéricas"), acometendo principalmente crianças.
Ectima → infecção bacteriana ulcerada que acomete derme profunda → úlcera com crosta espessa e aderida.
Justificativa: Incorreta. O ectima é uma forma ulcerada do impetigo, acomete camadas mais profundas da pele e deixa cicatriz, diferente do quadro apresentado.
Herpes simples → vesículas agrupadas sobre base eritematosa → evolução recorrente.
Justificativa: Incorreta. O herpes simples caracteriza-se por vesículas agrupadas contendo líquido claro, geralmente dolorosas, e não por bolhas purulentas com crostas melicéricas.
🧠 Dica de memorização
Crosta melicérica = Impetigo.
Bolha flácida → pensar em impetigo bolhoso.
Úlcera profunda com cicatriz → Ectima.
Placa eritematosa dolorosa → Erisipela.
Vesículas agrupadas → Herpes simples.
📚 Explicação geral
O impetigo bolhoso é uma infecção bacteriana superficial causada quase exclusivamente pelo Staphylococcus aureus, produtor de toxinas esfoliativas. As bolhas são flácidas porque a clivagem ocorre na camada granulosa da epiderme. Após sua ruptura, surgem as características crostas melicéricas, consideradas um dos principais achados clínicos da doença. É mais comum em crianças e altamente contagioso.
Nos pacientes com impetigo, qual das alternativas apresenta uma possível complicação da doença?
Glomerulonefrite pós-estreptocócica → complicação imunológica que pode ocorrer após infecção por cepas nefritogênicas de Streptococcus pyogenes.
Justificativa: Correta. A glomerulonefrite pós-estreptocócica é uma complicação clássica do impetigo estreptocócico e pode surgir semanas após a infecção cutânea.
Febre reumática → complicação autoimune típica da faringoamigdalite estreptocócica.
Justificativa: Incorreta. A febre reumática está relacionada à faringite por Streptococcus pyogenes, não ao impetigo.
Neuralgia pós-herpética → dor neuropática persistente após infecção pelo vírus Varicela-Zóster.
Justificativa: Incorreta. Trata-se de complicação do herpes-zóster, sem relação com impetigo.
Síndrome de Ramsay Hunt → acometimento do nervo facial pelo vírus Varicela-Zóster.
Justificativa: Incorreta. A síndrome de Ramsay Hunt é uma complicação do herpes-zóster otológico e não do impetigo.
🧠 Dica de memorização
Impetigo estreptocócico → Glomerulonefrite pós-estreptocócica.
Faringite estreptocócica → Febre reumática.
Herpes-zóster → Neuralgia pós-herpética e Ramsay Hunt.
Crosta melicérica = lembrar do impetigo.
📚 Explicação geral
O impetigo é uma piodermite superficial causada por Staphylococcus aureus, Streptococcus pyogenes ou ambos. Embora a maioria dos casos evolua de forma benigna, quando há participação de cepas nefritogênicas de S. pyogenes, pode ocorrer glomerulonefrite pós-estreptocócica, uma complicação imunomediada decorrente da deposição de imunocomplexos nos glomérulos. Diferentemente da faringite estreptocócica, o impetigo não está associado ao desenvolvimento de febre reumática, o que constitui uma pegadinha frequente em provas de Dermatologia e Infectologia.
ADF, masculino, 14 anos, apresenta comedões abertos, intensa reação inflamatória, nódulos furunculoides e lesões purulentas na face. Qual alternativa apresenta corretamente o diagnóstico e a classificação da doença?
Acne comedoniana (Grau I) → predominam comedões abertos e fechados, sem lesões inflamatórias.
Justificativa: Incorreta. A acne grau I é exclusivamente comedoniana, sem nódulos ou lesões purulentas.
Acne papulopustulosa (Grau II) → presença de pápulas e pústulas superficiais, sem nódulos profundos.
Justificativa: Incorreta. A acne grau II apresenta inflamação leve a moderada, mas não cursa com nódulos furunculoides.
Acne conglobata (Grau IV) → forma inflamatória grave com nódulos, abscessos, fístulas e tendência à formação de cicatrizes.
Justificativa: Correta. A associação de comedões, nódulos furunculoides e lesões purulentas caracteriza acne conglobata, classificada como grau IV.
Acne fulminante (Grau V) → forma ulceronecrosante associada a febre, mal-estar e alterações laboratoriais sistêmicas.
Justificativa: Incorreta. A acne fulminante cursa com manifestações sistêmicas importantes, como febre, artralgias e mal-estar, ausentes no caso clínico.
🧠 Dica de memorização
Grau I → apenas comedões.
Grau II → pápulas e pústulas.
Grau III → nódulos e cistos.
Grau IV → acne conglobata = nódulos furunculoides + abscessos + fístulas.
Grau V → acne fulminante = acne grave + sintomas sistêmicos.
📚 Explicação geral
A acne vulgar é classificada conforme a intensidade da inflamação. A acne conglobata (grau IV) é uma das formas mais graves, predominando em adolescentes do sexo masculino. Caracteriza-se por comedões numerosos, nódulos inflamatórios profundos, abscessos, fístulas e intensa produção de secreção purulenta, evoluindo frequentemente com cicatrizes permanentes. Deve ser diferenciada da acne fulminante, que apresenta quadro sistêmico importante.
Nos casos de acne conglobata, qual alternativa apresenta duas medidas importantes para o manejo da doença?
Higienização frequente da pele + antibioticoterapia tópica isolada.
Justificativa: Incorreta. A higiene auxilia no controle da oleosidade, porém não controla formas graves, e a monoterapia com antibióticos deve ser evitada devido ao risco de resistência bacteriana.
Isotretinoína oral + acompanhamento clínico com monitorização laboratorial e orientação quanto ao risco de cicatrizes.
Justificativa: Correta. A isotretinoína é o tratamento de escolha da acne conglobata. O acompanhamento clínico e laboratorial é essencial devido aos efeitos adversos do medicamento e ao elevado risco de cicatrizes permanentes.
Apenas extração de comedões + peelings químicos seriados.
Justificativa: Incorreta. Esses procedimentos podem complementar o tratamento após o controle da inflamação, mas são insuficientes para tratar acne conglobata.
Corticoide tópico + suspensão definitiva de alimentos gordurosos.
Justificativa: Incorreta. Corticoides tópicos não fazem parte do tratamento da acne conglobata, e a exclusão de alimentos gordurosos isoladamente não controla a doença.
🧠 Dica de memorização
Acne grave → Isotretinoína oral.
Antibiótico nunca em monoterapia.
Peelings e extração de comedões → apenas adjuvantes, após controle da inflamação.
Acne fulminante → pode necessitar corticoterapia sistêmica antes da isotretinoína.
Quanto mais grave a acne, maior o risco de cicatrizes permanentes.
📚 Explicação geral
O tratamento da acne depende da gravidade das lesões. Na acne conglobata, a isotretinoína oral é considerada o tratamento de escolha por atuar sobre os quatro pilares fisiopatológicos da doença: redução da produção sebácea, normalização da queratinização folicular, diminuição da colonização por Cutibacterium acnes e ação anti-inflamatória. Durante o tratamento é necessária monitorização clínica e laboratorial, além de orientação sobre efeitos adversos, risco de cicatrizes e importância da adesão terapêutica. Antibióticos sistêmicos podem ser utilizados em situações específicas, mas não devem ser empregados como monoterapia.
AMM, 42 anos, HIV positivo, em tratamento com TARV iniciado há 2 semanas, relata febre baixa (37,9°C), adinamia e lesões dolorosas em mucosa oral e vaginal há 15 dias, caracterizadas por vesículas agrupadas sobre base eritematosa. Qual alternativa apresenta corretamente o diagnóstico clínico?
Herpes-zóster → reativação do vírus Varicela-Zóster → lesões vesiculares em distribuição dermatomérica unilateral.
Justificativa: Incorreta. O herpes-zóster apresenta distribuição ao longo de um dermátomo, geralmente unilateral, e não acomete simultaneamente mucosa oral e genital.
Herpes simples → infecção pelo vírus Herpes simplex (HSV-1/HSV-2) → vesículas agrupadas sobre base eritematosa, dolorosas, com frequente acometimento de mucosas.
Justificativa: Correta. O quadro é típico de herpes simples, caracterizado por lesões vesiculares dolorosas sobre base eritematosa, frequentemente envolvendo mucosas, especialmente em pacientes imunossuprimidos.
Síndrome da pele escaldada estafilocócica → toxinas esfoliativas do Staphylococcus aureus → bolhas flácidas difusas.
Justificativa: Incorreta. A SSSS acomete principalmente recém-nascidos e crianças pequenas, cursando com bolhas flácidas e descamação difusa, sem vesículas agrupadas em mucosas.
Doença de Behçet → vasculite multissistêmica → úlceras orais e genitais recorrentes.
Justificativa: Incorreta. Embora a doença de Behçet apresente úlceras orais e genitais, as lesões são ulceradas desde o início, sem fase típica de vesículas agrupadas sobre base eritematosa.
🧠 Dica de memorização
HSV → Vesículas agrupadas + dor + base eritematosa.
HSV-1 → predominância oral.
HSV-2 → predominância genital (embora ambos possam acometer qualquer sítio).
Herpes-zóster → dermátomo unilateral.
Behçet → úlceras recorrentes, não vesículas.
📚 Explicação geral
O herpes simples é causado pelos vírus HSV-1 e HSV-2, permanecendo latente nos gânglios sensitivos após a infecção primária. A reativação ocorre principalmente em situações de imunossupressão, estresse ou trauma. As lesões iniciam-se como vesículas agrupadas sobre base eritematosa, que rapidamente se rompem formando erosões dolorosas. Em pacientes com HIV, as lesões podem ser extensas, persistentes e acometer simultaneamente diferentes mucosas.
Embora o diagnóstico do herpes simples seja predominantemente clínico, qual alternativa apresenta dois exames complementares que podem auxiliar na confirmação diagnóstica?
PCR para HSV + Citologia de Tzanck → detecta DNA viral e evidencia células gigantes multinucleadas, respectivamente.
Justificativa: Correta. O PCR é o método mais sensível para confirmação do HSV, enquanto o esfregaço de Tzanck demonstra células gigantes multinucleadas, auxiliando no diagnóstico.
Cultura bacteriana + Pesquisa de corpos fumagoides.
Justificativa: Incorreta. A cultura bacteriana não diagnostica herpes simples, e corpos fumagoides são característicos da cromoblastomicose.
Pesquisa de BAAR + Teste de Montenegro.
Justificativa: Incorreta. O BAAR é utilizado para micobactérias, e o teste de Montenegro auxilia no diagnóstico da leishmaniose tegumentar.
Exame micológico direto + Cultura para Sporothrix spp.
Justificativa: Incorreta. Esses exames são utilizados para micoses, como dermatofitoses e esporotricose, não para infecções pelo HSV.
🧠 Dica de memorização
Herpes simples → diagnóstico geralmente clínico.
PCR → exame mais sensível para HSV.
Tzanck → células gigantes multinucleadas (não diferencia HSV de VZV).
Cultura viral → pode ser utilizada, porém tem menor sensibilidade que o PCR.
Corpos fumagoides = cromoblastomicose | Conídios em "margarida" = esporotricose.
📚 Explicação geral
O diagnóstico do herpes simples é, na maioria das vezes, clínico, baseado na presença de vesículas agrupadas dolorosas sobre base eritematosa. Quando há necessidade de confirmação, especialmente em pacientes imunossuprimidos ou apresentações atípicas, o PCR para HSV é o exame de maior sensibilidade e especificidade. A citologia de Tzanck é um método rápido e de baixo custo, demonstrando células gigantes multinucleadas e acantólise, embora não diferencie HSV do vírus Varicela-Zóster. A cultura viral e testes de imunofluorescência também podem ser utilizados, mas atualmente o PCR é considerado o método de escolha para confirmação laboratorial.', 'A cromoblastomicose é uma micose subcutânea de difícil tratamento devido à intensa fibrose e ao crescimento lento dos fungos demáceos.',
        'Cromoblastomicose = Itraconazol ou Terbinafina.
Lesões pequenas → Crioterapia e cirurgia podem curar.
Corpos fumagoides → diagnóstico.
Esporotricose → Itraconazol + iodeto de potássio.
Conídios em margarida ≠ corpos fumagoides.', 'Atenção ao comando: apenas uma alternativa deve corresponder integralmente ao enunciado.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'c50f250e-2a33-5eee-a7b4-ba20609a5706'::uuid, 'deda69f3-0463-589d-a7b8-8f5e79f2f40f'::uuid,
        'A', 'Itraconazol + Terbinafina → Crioterapia + Excisão cirúrgica.', 'Correta. O itraconazol e a terbinafina são os principais antifúngicos utilizados na cromoblastomicose. Entre as medidas não farmacológicas, destacam-se crioterapia, excisão cirúrgica e outras terapias físicas em lesões localizadas.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'c1aea4de-af10-54bc-b5c8-21e0d36d6bbc'::uuid, 'deda69f3-0463-589d-a7b8-8f5e79f2f40f'::uuid,
        'B', 'Fluconazol + Griseofulvina → Radioterapia + Laserterapia.', 'Incorreta. Fluconazol e griseofulvina apresentam baixa eficácia na cromoblastomicose. Radioterapia não faz parte do tratamento da doença.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'e961a087-49ad-540f-ac03-488b84d4ab86'::uuid, 'deda69f3-0463-589d-a7b8-8f5e79f2f40f'::uuid,
        'C', 'Anfotericina B + Voriconazol → Drenagem cirúrgica + Compressas mornas.', 'Incorreta. A anfotericina B não é tratamento habitual da cromoblastomicose, sendo reservada para situações excepcionais. Drenagem e compressas não possuem papel terapêutico na doença.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '086a3763-8c12-5356-8413-5c28d4fed924'::uuid, 'deda69f3-0463-589d-a7b8-8f5e79f2f40f'::uuid,
        'D', 'Cetoconazol + Nistatina → Curetagem + Debridamento superficial.', 'Incorreta. A nistatina não possui atividade contra fungos demáceos, e curetagem isolada não é considerada tratamento efetivo da cromoblastomicose.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 006 | Turma 115 -T1- Transformada em objetiva
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '73c82ea7-99e4-5d34-b88d-dc2475f4cf39'::uuid, v_discipline_id, NULL, 'médio',
        'MMA, com 2 semanas de idade, apresentou infecção de orofaringe e, alguns dias depois, evoluiu com febre, eritema difuso e bolhas flácidas que se romperam facilmente. Qual alternativa apresenta o principal agente etiológico desse quadro?', 'single',
        'B', ARRAY[]::text[],
        'A Síndrome da Pele Escaldada Estafilocócica (SSSS) acomete principalmente recém-nascidos e crianças pequenas, devido à imaturidade renal, que dificulta a eliminação das toxinas. O agente é o Staphylococcus aureus produtor das toxinas esfoliativas ETA e ETB, que promovem clivagem da desmogleína 1, localizada na camada granulosa da epiderme. Clinicamente, observa-se febre, eritema difuso, bolhas flácidas e descamação extensa, geralmente sem acometimento de mucosas.
Qual técnica semiológica pode ser encontrada durante o exame físico de um caso de Síndrome da Pele Escaldada Estafilocócica?
Sinal de Nikolsky → descolamento da epiderme após fricção tangencial da pele aparentemente íntegra.
Justificativa: Correta. O sinal de Nikolsky é tipicamente positivo na SSSS devido à clivagem superficial da epiderme provocada pelas toxinas estafilocócicas.
Sinal de Auspitz → sangramento puntiforme após remoção de escamas.
Justificativa: Incorreta. O sinal de Auspitz é característico da psoríase.
Fenômeno de Koebner → surgimento de lesões em áreas de trauma.
Justificativa: Incorreta. O fenômeno de Koebner ocorre em doenças como psoríase, líquen plano e vitiligo.
Diascopia → desaparecimento do eritema à compressão com lâmina de vidro.
Justificativa: Incorreta. A diascopia é utilizada para avaliação de lesões vasculares e granulomatosas, não sendo um achado característico da SSSS.
🧠 Dica de memorização
SSSS → Nikolsky positivo.
Psoríase → Auspitz + Koebner.
Diascopia → diferencia eritema vascular de púrpura.
Bolha flácida + Nikolsky → pensar em doenças acantolíticas ou clivagem epidérmica (SSSS e pênfigos).
📚 Explicação geral
O sinal de Nikolsky consiste no descolamento da epiderme após fricção tangencial sobre pele aparentemente normal. Na SSSS, ele é positivo porque as toxinas esfoliativas degradam a desmogleína 1, reduzindo a adesão entre os queratinócitos da camada granulosa. Esse sinal também pode estar presente nos pênfigos, especialmente no pênfigo vulgar, porém o acometimento das mucosas é um importante diferencial: na SSSS as mucosas geralmente são poupadas, enquanto no pênfigo vulgar elas são frequentemente acometidas.
VGI, 8 anos, refere que há 4 dias surgiu uma bolha com pus que, após o dessecamento, evoluiu para crostas amareladas, com algumas lesões satélites ao exame físico. Qual alternativa apresenta corretamente o diagnóstico clínico?
Erisipela → infecção da derme profunda e vasos linfáticos → placa eritematosa bem delimitada, dolorosa e de rápida evolução.
Justificativa: Incorreta. A erisipela cursa com placa eritematosa infiltrada, edema e dor, sem formação de bolhas purulentas seguidas de crostas melicéricas.
Impetigo bolhoso → infecção superficial por Staphylococcus aureus → bolhas flácidas que se rompem facilmente, formando crostas melicéricas.
Justificativa: Correta. O quadro clínico é típico de impetigo bolhoso, caracterizado por bolhas superficiais que evoluem para crostas amareladas ("melicéricas"), acometendo principalmente crianças.
Ectima → infecção bacteriana ulcerada que acomete derme profunda → úlcera com crosta espessa e aderida.
Justificativa: Incorreta. O ectima é uma forma ulcerada do impetigo, acomete camadas mais profundas da pele e deixa cicatriz, diferente do quadro apresentado.
Herpes simples → vesículas agrupadas sobre base eritematosa → evolução recorrente.
Justificativa: Incorreta. O herpes simples caracteriza-se por vesículas agrupadas contendo líquido claro, geralmente dolorosas, e não por bolhas purulentas com crostas melicéricas.
🧠 Dica de memorização
Crosta melicérica = Impetigo.
Bolha flácida → pensar em impetigo bolhoso.
Úlcera profunda com cicatriz → Ectima.
Placa eritematosa dolorosa → Erisipela.
Vesículas agrupadas → Herpes simples.
📚 Explicação geral
O impetigo bolhoso é uma infecção bacteriana superficial causada quase exclusivamente pelo Staphylococcus aureus, produtor de toxinas esfoliativas. As bolhas são flácidas porque a clivagem ocorre na camada granulosa da epiderme. Após sua ruptura, surgem as características crostas melicéricas, consideradas um dos principais achados clínicos da doença. É mais comum em crianças e altamente contagioso.
Nos pacientes com impetigo, qual das alternativas apresenta uma possível complicação da doença?
Glomerulonefrite pós-estreptocócica → complicação imunológica que pode ocorrer após infecção por cepas nefritogênicas de Streptococcus pyogenes.
Justificativa: Correta. A glomerulonefrite pós-estreptocócica é uma complicação clássica do impetigo estreptocócico e pode surgir semanas após a infecção cutânea.
Febre reumática → complicação autoimune típica da faringoamigdalite estreptocócica.
Justificativa: Incorreta. A febre reumática está relacionada à faringite por Streptococcus pyogenes, não ao impetigo.
Neuralgia pós-herpética → dor neuropática persistente após infecção pelo vírus Varicela-Zóster.
Justificativa: Incorreta. Trata-se de complicação do herpes-zóster, sem relação com impetigo.
Síndrome de Ramsay Hunt → acometimento do nervo facial pelo vírus Varicela-Zóster.
Justificativa: Incorreta. A síndrome de Ramsay Hunt é uma complicação do herpes-zóster otológico e não do impetigo.
🧠 Dica de memorização
Impetigo estreptocócico → Glomerulonefrite pós-estreptocócica.
Faringite estreptocócica → Febre reumática.
Herpes-zóster → Neuralgia pós-herpética e Ramsay Hunt.
Crosta melicérica = lembrar do impetigo.
📚 Explicação geral
O impetigo é uma piodermite superficial causada por Staphylococcus aureus, Streptococcus pyogenes ou ambos. Embora a maioria dos casos evolua de forma benigna, quando há participação de cepas nefritogênicas de S. pyogenes, pode ocorrer glomerulonefrite pós-estreptocócica, uma complicação imunomediada decorrente da deposição de imunocomplexos nos glomérulos. Diferentemente da faringite estreptocócica, o impetigo não está associado ao desenvolvimento de febre reumática, o que constitui uma pegadinha frequente em provas de Dermatologia e Infectologia.
ADF, masculino, 14 anos, apresenta comedões abertos, intensa reação inflamatória, nódulos furunculoides e lesões purulentas na face. Qual alternativa apresenta corretamente o diagnóstico e a classificação da doença?
Acne comedoniana (Grau I) → predominam comedões abertos e fechados, sem lesões inflamatórias.
Justificativa: Incorreta. A acne grau I é exclusivamente comedoniana, sem nódulos ou lesões purulentas.
Acne papulopustulosa (Grau II) → presença de pápulas e pústulas superficiais, sem nódulos profundos.
Justificativa: Incorreta. A acne grau II apresenta inflamação leve a moderada, mas não cursa com nódulos furunculoides.
Acne conglobata (Grau IV) → forma inflamatória grave com nódulos, abscessos, fístulas e tendência à formação de cicatrizes.
Justificativa: Correta. A associação de comedões, nódulos furunculoides e lesões purulentas caracteriza acne conglobata, classificada como grau IV.
Acne fulminante (Grau V) → forma ulceronecrosante associada a febre, mal-estar e alterações laboratoriais sistêmicas.
Justificativa: Incorreta. A acne fulminante cursa com manifestações sistêmicas importantes, como febre, artralgias e mal-estar, ausentes no caso clínico.
🧠 Dica de memorização
Grau I → apenas comedões.
Grau II → pápulas e pústulas.
Grau III → nódulos e cistos.
Grau IV → acne conglobata = nódulos furunculoides + abscessos + fístulas.
Grau V → acne fulminante = acne grave + sintomas sistêmicos.
📚 Explicação geral
A acne vulgar é classificada conforme a intensidade da inflamação. A acne conglobata (grau IV) é uma das formas mais graves, predominando em adolescentes do sexo masculino. Caracteriza-se por comedões numerosos, nódulos inflamatórios profundos, abscessos, fístulas e intensa produção de secreção purulenta, evoluindo frequentemente com cicatrizes permanentes. Deve ser diferenciada da acne fulminante, que apresenta quadro sistêmico importante.
Nos casos de acne conglobata, qual alternativa apresenta duas medidas importantes para o manejo da doença?
Higienização frequente da pele + antibioticoterapia tópica isolada.
Justificativa: Incorreta. A higiene auxilia no controle da oleosidade, porém não controla formas graves, e a monoterapia com antibióticos deve ser evitada devido ao risco de resistência bacteriana.
Isotretinoína oral + acompanhamento clínico com monitorização laboratorial e orientação quanto ao risco de cicatrizes.
Justificativa: Correta. A isotretinoína é o tratamento de escolha da acne conglobata. O acompanhamento clínico e laboratorial é essencial devido aos efeitos adversos do medicamento e ao elevado risco de cicatrizes permanentes.
Apenas extração de comedões + peelings químicos seriados.
Justificativa: Incorreta. Esses procedimentos podem complementar o tratamento após o controle da inflamação, mas são insuficientes para tratar acne conglobata.
Corticoide tópico + suspensão definitiva de alimentos gordurosos.
Justificativa: Incorreta. Corticoides tópicos não fazem parte do tratamento da acne conglobata, e a exclusão de alimentos gordurosos isoladamente não controla a doença.
🧠 Dica de memorização
Acne grave → Isotretinoína oral.
Antibiótico nunca em monoterapia.
Peelings e extração de comedões → apenas adjuvantes, após controle da inflamação.
Acne fulminante → pode necessitar corticoterapia sistêmica antes da isotretinoína.
Quanto mais grave a acne, maior o risco de cicatrizes permanentes.
📚 Explicação geral
O tratamento da acne depende da gravidade das lesões. Na acne conglobata, a isotretinoína oral é considerada o tratamento de escolha por atuar sobre os quatro pilares fisiopatológicos da doença: redução da produção sebácea, normalização da queratinização folicular, diminuição da colonização por Cutibacterium acnes e ação anti-inflamatória. Durante o tratamento é necessária monitorização clínica e laboratorial, além de orientação sobre efeitos adversos, risco de cicatrizes e importância da adesão terapêutica. Antibióticos sistêmicos podem ser utilizados em situações específicas, mas não devem ser empregados como monoterapia.
AMM, 42 anos, HIV positivo, em tratamento com TARV iniciado há 2 semanas, relata febre baixa (37,9°C), adinamia e lesões dolorosas em mucosa oral e vaginal há 15 dias, caracterizadas por vesículas agrupadas sobre base eritematosa. Qual alternativa apresenta corretamente o diagnóstico clínico?
Herpes-zóster → reativação do vírus Varicela-Zóster → lesões vesiculares em distribuição dermatomérica unilateral.
Justificativa: Incorreta. O herpes-zóster apresenta distribuição ao longo de um dermátomo, geralmente unilateral, e não acomete simultaneamente mucosa oral e genital.
Herpes simples → infecção pelo vírus Herpes simplex (HSV-1/HSV-2) → vesículas agrupadas sobre base eritematosa, dolorosas, com frequente acometimento de mucosas.
Justificativa: Correta. O quadro é típico de herpes simples, caracterizado por lesões vesiculares dolorosas sobre base eritematosa, frequentemente envolvendo mucosas, especialmente em pacientes imunossuprimidos.
Síndrome da pele escaldada estafilocócica → toxinas esfoliativas do Staphylococcus aureus → bolhas flácidas difusas.
Justificativa: Incorreta. A SSSS acomete principalmente recém-nascidos e crianças pequenas, cursando com bolhas flácidas e descamação difusa, sem vesículas agrupadas em mucosas.
Doença de Behçet → vasculite multissistêmica → úlceras orais e genitais recorrentes.
Justificativa: Incorreta. Embora a doença de Behçet apresente úlceras orais e genitais, as lesões são ulceradas desde o início, sem fase típica de vesículas agrupadas sobre base eritematosa.
🧠 Dica de memorização
HSV → Vesículas agrupadas + dor + base eritematosa.
HSV-1 → predominância oral.
HSV-2 → predominância genital (embora ambos possam acometer qualquer sítio).
Herpes-zóster → dermátomo unilateral.
Behçet → úlceras recorrentes, não vesículas.
📚 Explicação geral
O herpes simples é causado pelos vírus HSV-1 e HSV-2, permanecendo latente nos gânglios sensitivos após a infecção primária. A reativação ocorre principalmente em situações de imunossupressão, estresse ou trauma. As lesões iniciam-se como vesículas agrupadas sobre base eritematosa, que rapidamente se rompem formando erosões dolorosas. Em pacientes com HIV, as lesões podem ser extensas, persistentes e acometer simultaneamente diferentes mucosas.
Embora o diagnóstico do herpes simples seja predominantemente clínico, qual alternativa apresenta dois exames complementares que podem auxiliar na confirmação diagnóstica?
PCR para HSV + Citologia de Tzanck → detecta DNA viral e evidencia células gigantes multinucleadas, respectivamente.
Justificativa: Correta. O PCR é o método mais sensível para confirmação do HSV, enquanto o esfregaço de Tzanck demonstra células gigantes multinucleadas, auxiliando no diagnóstico.
Cultura bacteriana + Pesquisa de corpos fumagoides.
Justificativa: Incorreta. A cultura bacteriana não diagnostica herpes simples, e corpos fumagoides são característicos da cromoblastomicose.
Pesquisa de BAAR + Teste de Montenegro.
Justificativa: Incorreta. O BAAR é utilizado para micobactérias, e o teste de Montenegro auxilia no diagnóstico da leishmaniose tegumentar.
Exame micológico direto + Cultura para Sporothrix spp.
Justificativa: Incorreta. Esses exames são utilizados para micoses, como dermatofitoses e esporotricose, não para infecções pelo HSV.
🧠 Dica de memorização
Herpes simples → diagnóstico geralmente clínico.
PCR → exame mais sensível para HSV.
Tzanck → células gigantes multinucleadas (não diferencia HSV de VZV).
Cultura viral → pode ser utilizada, porém tem menor sensibilidade que o PCR.
Corpos fumagoides = cromoblastomicose | Conídios em "margarida" = esporotricose.
📚 Explicação geral
O diagnóstico do herpes simples é, na maioria das vezes, clínico, baseado na presença de vesículas agrupadas dolorosas sobre base eritematosa. Quando há necessidade de confirmação, especialmente em pacientes imunossuprimidos ou apresentações atípicas, o PCR para HSV é o exame de maior sensibilidade e especificidade. A citologia de Tzanck é um método rápido e de baixo custo, demonstrando células gigantes multinucleadas e acantólise, embora não diferencie HSV do vírus Varicela-Zóster. A cultura viral e testes de imunofluorescência também podem ser utilizados, mas atualmente o PCR é considerado o método de escolha para confirmação laboratorial.', 'A Síndrome da Pele Escaldada Estafilocócica (SSSS) acomete principalmente recém-nascidos e crianças pequenas, devido à imaturidade renal, que dificulta a eliminação das toxinas.',
        'Recém-nascido + bolhas flácidas + febre → SSSS.
SSSS → Staphylococcus aureus.
Toxinas esfoliativas A e B → Desmogleína 1.
Escarlatina → Streptococcus pyogenes.
Pênfigo foliáceo também acomete desmogleína 1, mas por autoanticorpos.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '5edcfee5-702b-50d1-ac82-42d81976e021'::uuid, '73c82ea7-99e4-5d34-b88d-dc2475f4cf39'::uuid,
        'A', 'Streptococcus pyogenes → principal agente da erisipela e da escarlatina.', 'Incorreta. Streptococcus pyogenes está associado à escarlatina e à erisipela, mas não à Síndrome da Pele Escaldada Estafilocócica.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '3133ce8b-9cf6-5a43-bd8d-8a5b07950692'::uuid, '73c82ea7-99e4-5d34-b88d-dc2475f4cf39'::uuid,
        'B', 'Staphylococcus aureus produtor das toxinas esfoliativas A e B → promove clivagem intraepidérmica por ação sobre a desmogleína 1.', 'Correta. A SSSS é causada por cepas de Staphylococcus aureus produtoras das toxinas esfoliativas A e/ou B, responsáveis pela clivagem da desmogleína 1 e formação de bolhas flácidas.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '5f8296e2-245a-596c-b500-168dbbf340aa'::uuid, '73c82ea7-99e4-5d34-b88d-dc2475f4cf39'::uuid,
        'C', 'Pseudomonas aeruginosa → bacilo Gram-negativo frequentemente associado a queimaduras.', 'Incorreta. Pseudomonas aeruginosa pode causar infecções cutâneas graves, porém não produz a síndrome da pele escaldada.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '66766d8f-dd78-5e4d-9799-985c1d654c47'::uuid, '73c82ea7-99e4-5d34-b88d-dc2475f4cf39'::uuid,
        'D', 'Staphylococcus epidermidis → bactéria comensal da pele, relacionada principalmente a infecções de dispositivos médicos.', 'Incorreta. Staphylococcus epidermidis não produz toxinas esfoliativas e não causa SSSS.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 007 | Turma 115 -T1- Transformada em objetiva
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '28b94538-3575-51b5-bfd8-ab0e99938975'::uuid, v_discipline_id, NULL, 'médio',
        'Qual técnica semiológica pode ser encontrada durante o exame físico de um caso de Síndrome da Pele Escaldada Estafilocócica?', 'single',
        'A', ARRAY[]::text[],
        'O sinal de Nikolsky consiste no descolamento da epiderme após fricção tangencial sobre pele aparentemente normal. Na SSSS, ele é positivo porque as toxinas esfoliativas degradam a desmogleína 1, reduzindo a adesão entre os queratinócitos da camada granulosa. Esse sinal também pode estar presente nos pênfigos, especialmente no pênfigo vulgar, porém o acometimento das mucosas é um importante diferencial: na SSSS as mucosas geralmente são poupadas, enquanto no pênfigo vulgar elas são frequentemente acometidas.
VGI, 8 anos, refere que há 4 dias surgiu uma bolha com pus que, após o dessecamento, evoluiu para crostas amareladas, com algumas lesões satélites ao exame físico. Qual alternativa apresenta corretamente o diagnóstico clínico?
Erisipela → infecção da derme profunda e vasos linfáticos → placa eritematosa bem delimitada, dolorosa e de rápida evolução.
Justificativa: Incorreta. A erisipela cursa com placa eritematosa infiltrada, edema e dor, sem formação de bolhas purulentas seguidas de crostas melicéricas.
Impetigo bolhoso → infecção superficial por Staphylococcus aureus → bolhas flácidas que se rompem facilmente, formando crostas melicéricas.
Justificativa: Correta. O quadro clínico é típico de impetigo bolhoso, caracterizado por bolhas superficiais que evoluem para crostas amareladas ("melicéricas"), acometendo principalmente crianças.
Ectima → infecção bacteriana ulcerada que acomete derme profunda → úlcera com crosta espessa e aderida.
Justificativa: Incorreta. O ectima é uma forma ulcerada do impetigo, acomete camadas mais profundas da pele e deixa cicatriz, diferente do quadro apresentado.
Herpes simples → vesículas agrupadas sobre base eritematosa → evolução recorrente.
Justificativa: Incorreta. O herpes simples caracteriza-se por vesículas agrupadas contendo líquido claro, geralmente dolorosas, e não por bolhas purulentas com crostas melicéricas.
🧠 Dica de memorização
Crosta melicérica = Impetigo.
Bolha flácida → pensar em impetigo bolhoso.
Úlcera profunda com cicatriz → Ectima.
Placa eritematosa dolorosa → Erisipela.
Vesículas agrupadas → Herpes simples.
📚 Explicação geral
O impetigo bolhoso é uma infecção bacteriana superficial causada quase exclusivamente pelo Staphylococcus aureus, produtor de toxinas esfoliativas. As bolhas são flácidas porque a clivagem ocorre na camada granulosa da epiderme. Após sua ruptura, surgem as características crostas melicéricas, consideradas um dos principais achados clínicos da doença. É mais comum em crianças e altamente contagioso.
Nos pacientes com impetigo, qual das alternativas apresenta uma possível complicação da doença?
Glomerulonefrite pós-estreptocócica → complicação imunológica que pode ocorrer após infecção por cepas nefritogênicas de Streptococcus pyogenes.
Justificativa: Correta. A glomerulonefrite pós-estreptocócica é uma complicação clássica do impetigo estreptocócico e pode surgir semanas após a infecção cutânea.
Febre reumática → complicação autoimune típica da faringoamigdalite estreptocócica.
Justificativa: Incorreta. A febre reumática está relacionada à faringite por Streptococcus pyogenes, não ao impetigo.
Neuralgia pós-herpética → dor neuropática persistente após infecção pelo vírus Varicela-Zóster.
Justificativa: Incorreta. Trata-se de complicação do herpes-zóster, sem relação com impetigo.
Síndrome de Ramsay Hunt → acometimento do nervo facial pelo vírus Varicela-Zóster.
Justificativa: Incorreta. A síndrome de Ramsay Hunt é uma complicação do herpes-zóster otológico e não do impetigo.
🧠 Dica de memorização
Impetigo estreptocócico → Glomerulonefrite pós-estreptocócica.
Faringite estreptocócica → Febre reumática.
Herpes-zóster → Neuralgia pós-herpética e Ramsay Hunt.
Crosta melicérica = lembrar do impetigo.
📚 Explicação geral
O impetigo é uma piodermite superficial causada por Staphylococcus aureus, Streptococcus pyogenes ou ambos. Embora a maioria dos casos evolua de forma benigna, quando há participação de cepas nefritogênicas de S. pyogenes, pode ocorrer glomerulonefrite pós-estreptocócica, uma complicação imunomediada decorrente da deposição de imunocomplexos nos glomérulos. Diferentemente da faringite estreptocócica, o impetigo não está associado ao desenvolvimento de febre reumática, o que constitui uma pegadinha frequente em provas de Dermatologia e Infectologia.
ADF, masculino, 14 anos, apresenta comedões abertos, intensa reação inflamatória, nódulos furunculoides e lesões purulentas na face. Qual alternativa apresenta corretamente o diagnóstico e a classificação da doença?
Acne comedoniana (Grau I) → predominam comedões abertos e fechados, sem lesões inflamatórias.
Justificativa: Incorreta. A acne grau I é exclusivamente comedoniana, sem nódulos ou lesões purulentas.
Acne papulopustulosa (Grau II) → presença de pápulas e pústulas superficiais, sem nódulos profundos.
Justificativa: Incorreta. A acne grau II apresenta inflamação leve a moderada, mas não cursa com nódulos furunculoides.
Acne conglobata (Grau IV) → forma inflamatória grave com nódulos, abscessos, fístulas e tendência à formação de cicatrizes.
Justificativa: Correta. A associação de comedões, nódulos furunculoides e lesões purulentas caracteriza acne conglobata, classificada como grau IV.
Acne fulminante (Grau V) → forma ulceronecrosante associada a febre, mal-estar e alterações laboratoriais sistêmicas.
Justificativa: Incorreta. A acne fulminante cursa com manifestações sistêmicas importantes, como febre, artralgias e mal-estar, ausentes no caso clínico.
🧠 Dica de memorização
Grau I → apenas comedões.
Grau II → pápulas e pústulas.
Grau III → nódulos e cistos.
Grau IV → acne conglobata = nódulos furunculoides + abscessos + fístulas.
Grau V → acne fulminante = acne grave + sintomas sistêmicos.
📚 Explicação geral
A acne vulgar é classificada conforme a intensidade da inflamação. A acne conglobata (grau IV) é uma das formas mais graves, predominando em adolescentes do sexo masculino. Caracteriza-se por comedões numerosos, nódulos inflamatórios profundos, abscessos, fístulas e intensa produção de secreção purulenta, evoluindo frequentemente com cicatrizes permanentes. Deve ser diferenciada da acne fulminante, que apresenta quadro sistêmico importante.
Nos casos de acne conglobata, qual alternativa apresenta duas medidas importantes para o manejo da doença?
Higienização frequente da pele + antibioticoterapia tópica isolada.
Justificativa: Incorreta. A higiene auxilia no controle da oleosidade, porém não controla formas graves, e a monoterapia com antibióticos deve ser evitada devido ao risco de resistência bacteriana.
Isotretinoína oral + acompanhamento clínico com monitorização laboratorial e orientação quanto ao risco de cicatrizes.
Justificativa: Correta. A isotretinoína é o tratamento de escolha da acne conglobata. O acompanhamento clínico e laboratorial é essencial devido aos efeitos adversos do medicamento e ao elevado risco de cicatrizes permanentes.
Apenas extração de comedões + peelings químicos seriados.
Justificativa: Incorreta. Esses procedimentos podem complementar o tratamento após o controle da inflamação, mas são insuficientes para tratar acne conglobata.
Corticoide tópico + suspensão definitiva de alimentos gordurosos.
Justificativa: Incorreta. Corticoides tópicos não fazem parte do tratamento da acne conglobata, e a exclusão de alimentos gordurosos isoladamente não controla a doença.
🧠 Dica de memorização
Acne grave → Isotretinoína oral.
Antibiótico nunca em monoterapia.
Peelings e extração de comedões → apenas adjuvantes, após controle da inflamação.
Acne fulminante → pode necessitar corticoterapia sistêmica antes da isotretinoína.
Quanto mais grave a acne, maior o risco de cicatrizes permanentes.
📚 Explicação geral
O tratamento da acne depende da gravidade das lesões. Na acne conglobata, a isotretinoína oral é considerada o tratamento de escolha por atuar sobre os quatro pilares fisiopatológicos da doença: redução da produção sebácea, normalização da queratinização folicular, diminuição da colonização por Cutibacterium acnes e ação anti-inflamatória. Durante o tratamento é necessária monitorização clínica e laboratorial, além de orientação sobre efeitos adversos, risco de cicatrizes e importância da adesão terapêutica. Antibióticos sistêmicos podem ser utilizados em situações específicas, mas não devem ser empregados como monoterapia.
AMM, 42 anos, HIV positivo, em tratamento com TARV iniciado há 2 semanas, relata febre baixa (37,9°C), adinamia e lesões dolorosas em mucosa oral e vaginal há 15 dias, caracterizadas por vesículas agrupadas sobre base eritematosa. Qual alternativa apresenta corretamente o diagnóstico clínico?
Herpes-zóster → reativação do vírus Varicela-Zóster → lesões vesiculares em distribuição dermatomérica unilateral.
Justificativa: Incorreta. O herpes-zóster apresenta distribuição ao longo de um dermátomo, geralmente unilateral, e não acomete simultaneamente mucosa oral e genital.
Herpes simples → infecção pelo vírus Herpes simplex (HSV-1/HSV-2) → vesículas agrupadas sobre base eritematosa, dolorosas, com frequente acometimento de mucosas.
Justificativa: Correta. O quadro é típico de herpes simples, caracterizado por lesões vesiculares dolorosas sobre base eritematosa, frequentemente envolvendo mucosas, especialmente em pacientes imunossuprimidos.
Síndrome da pele escaldada estafilocócica → toxinas esfoliativas do Staphylococcus aureus → bolhas flácidas difusas.
Justificativa: Incorreta. A SSSS acomete principalmente recém-nascidos e crianças pequenas, cursando com bolhas flácidas e descamação difusa, sem vesículas agrupadas em mucosas.
Doença de Behçet → vasculite multissistêmica → úlceras orais e genitais recorrentes.
Justificativa: Incorreta. Embora a doença de Behçet apresente úlceras orais e genitais, as lesões são ulceradas desde o início, sem fase típica de vesículas agrupadas sobre base eritematosa.
🧠 Dica de memorização
HSV → Vesículas agrupadas + dor + base eritematosa.
HSV-1 → predominância oral.
HSV-2 → predominância genital (embora ambos possam acometer qualquer sítio).
Herpes-zóster → dermátomo unilateral.
Behçet → úlceras recorrentes, não vesículas.
📚 Explicação geral
O herpes simples é causado pelos vírus HSV-1 e HSV-2, permanecendo latente nos gânglios sensitivos após a infecção primária. A reativação ocorre principalmente em situações de imunossupressão, estresse ou trauma. As lesões iniciam-se como vesículas agrupadas sobre base eritematosa, que rapidamente se rompem formando erosões dolorosas. Em pacientes com HIV, as lesões podem ser extensas, persistentes e acometer simultaneamente diferentes mucosas.
Embora o diagnóstico do herpes simples seja predominantemente clínico, qual alternativa apresenta dois exames complementares que podem auxiliar na confirmação diagnóstica?
PCR para HSV + Citologia de Tzanck → detecta DNA viral e evidencia células gigantes multinucleadas, respectivamente.
Justificativa: Correta. O PCR é o método mais sensível para confirmação do HSV, enquanto o esfregaço de Tzanck demonstra células gigantes multinucleadas, auxiliando no diagnóstico.
Cultura bacteriana + Pesquisa de corpos fumagoides.
Justificativa: Incorreta. A cultura bacteriana não diagnostica herpes simples, e corpos fumagoides são característicos da cromoblastomicose.
Pesquisa de BAAR + Teste de Montenegro.
Justificativa: Incorreta. O BAAR é utilizado para micobactérias, e o teste de Montenegro auxilia no diagnóstico da leishmaniose tegumentar.
Exame micológico direto + Cultura para Sporothrix spp.
Justificativa: Incorreta. Esses exames são utilizados para micoses, como dermatofitoses e esporotricose, não para infecções pelo HSV.
🧠 Dica de memorização
Herpes simples → diagnóstico geralmente clínico.
PCR → exame mais sensível para HSV.
Tzanck → células gigantes multinucleadas (não diferencia HSV de VZV).
Cultura viral → pode ser utilizada, porém tem menor sensibilidade que o PCR.
Corpos fumagoides = cromoblastomicose | Conídios em "margarida" = esporotricose.
📚 Explicação geral
O diagnóstico do herpes simples é, na maioria das vezes, clínico, baseado na presença de vesículas agrupadas dolorosas sobre base eritematosa. Quando há necessidade de confirmação, especialmente em pacientes imunossuprimidos ou apresentações atípicas, o PCR para HSV é o exame de maior sensibilidade e especificidade. A citologia de Tzanck é um método rápido e de baixo custo, demonstrando células gigantes multinucleadas e acantólise, embora não diferencie HSV do vírus Varicela-Zóster. A cultura viral e testes de imunofluorescência também podem ser utilizados, mas atualmente o PCR é considerado o método de escolha para confirmação laboratorial.', 'O sinal de Nikolsky consiste no descolamento da epiderme após fricção tangencial sobre pele aparentemente normal.',
        'SSSS → Nikolsky positivo.
Psoríase → Auspitz + Koebner.
Diascopia → diferencia eritema vascular de púrpura.
Bolha flácida + Nikolsky → pensar em doenças acantolíticas ou clivagem epidérmica (SSSS e pênfigos).', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'a12f6bff-f111-5c4e-9605-2779f58711b9'::uuid, '28b94538-3575-51b5-bfd8-ab0e99938975'::uuid,
        'A', 'Sinal de Nikolsky → descolamento da epiderme após fricção tangencial da pele aparentemente íntegra.', 'Correta. O sinal de Nikolsky é tipicamente positivo na SSSS devido à clivagem superficial da epiderme provocada pelas toxinas estafilocócicas.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'c514a379-308f-580e-8993-95cf1b85a50f'::uuid, '28b94538-3575-51b5-bfd8-ab0e99938975'::uuid,
        'B', 'Sinal de Auspitz → sangramento puntiforme após remoção de escamas.', 'Incorreta. O sinal de Auspitz é característico da psoríase.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '2ce8a268-a2ba-537d-981c-0ea84f3166cf'::uuid, '28b94538-3575-51b5-bfd8-ab0e99938975'::uuid,
        'C', 'Fenômeno de Koebner → surgimento de lesões em áreas de trauma.', 'Incorreta. O fenômeno de Koebner ocorre em doenças como psoríase, líquen plano e vitiligo.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'd3603a3d-8465-5ec3-8834-f88b7022c4e5'::uuid, '28b94538-3575-51b5-bfd8-ab0e99938975'::uuid,
        'D', 'Diascopia → desaparecimento do eritema à compressão com lâmina de vidro.', 'Incorreta. A diascopia é utilizada para avaliação de lesões vasculares e granulomatosas, não sendo um achado característico da SSSS.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 008 | Turma 115 -T1- Transformada em objetiva
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '89eb0725-ddcc-5e6f-85bd-f3ec0768530c'::uuid, v_discipline_id, NULL, 'médio',
        'VGI, 8 anos, refere que há 4 dias surgiu uma bolha com pus que, após o dessecamento, evoluiu para crostas amareladas, com algumas lesões satélites ao exame físico. Qual alternativa apresenta corretamente o diagnóstico clínico?', 'single',
        'B', ARRAY[]::text[],
        'O impetigo bolhoso é uma infecção bacteriana superficial causada quase exclusivamente pelo Staphylococcus aureus, produtor de toxinas esfoliativas. As bolhas são flácidas porque a clivagem ocorre na camada granulosa da epiderme. Após sua ruptura, surgem as características crostas melicéricas, consideradas um dos principais achados clínicos da doença. É mais comum em crianças e altamente contagioso.
Nos pacientes com impetigo, qual das alternativas apresenta uma possível complicação da doença?
Glomerulonefrite pós-estreptocócica → complicação imunológica que pode ocorrer após infecção por cepas nefritogênicas de Streptococcus pyogenes.
Justificativa: Correta. A glomerulonefrite pós-estreptocócica é uma complicação clássica do impetigo estreptocócico e pode surgir semanas após a infecção cutânea.
Febre reumática → complicação autoimune típica da faringoamigdalite estreptocócica.
Justificativa: Incorreta. A febre reumática está relacionada à faringite por Streptococcus pyogenes, não ao impetigo.
Neuralgia pós-herpética → dor neuropática persistente após infecção pelo vírus Varicela-Zóster.
Justificativa: Incorreta. Trata-se de complicação do herpes-zóster, sem relação com impetigo.
Síndrome de Ramsay Hunt → acometimento do nervo facial pelo vírus Varicela-Zóster.
Justificativa: Incorreta. A síndrome de Ramsay Hunt é uma complicação do herpes-zóster otológico e não do impetigo.
🧠 Dica de memorização
Impetigo estreptocócico → Glomerulonefrite pós-estreptocócica.
Faringite estreptocócica → Febre reumática.
Herpes-zóster → Neuralgia pós-herpética e Ramsay Hunt.
Crosta melicérica = lembrar do impetigo.
📚 Explicação geral
O impetigo é uma piodermite superficial causada por Staphylococcus aureus, Streptococcus pyogenes ou ambos. Embora a maioria dos casos evolua de forma benigna, quando há participação de cepas nefritogênicas de S. pyogenes, pode ocorrer glomerulonefrite pós-estreptocócica, uma complicação imunomediada decorrente da deposição de imunocomplexos nos glomérulos. Diferentemente da faringite estreptocócica, o impetigo não está associado ao desenvolvimento de febre reumática, o que constitui uma pegadinha frequente em provas de Dermatologia e Infectologia.
ADF, masculino, 14 anos, apresenta comedões abertos, intensa reação inflamatória, nódulos furunculoides e lesões purulentas na face. Qual alternativa apresenta corretamente o diagnóstico e a classificação da doença?
Acne comedoniana (Grau I) → predominam comedões abertos e fechados, sem lesões inflamatórias.
Justificativa: Incorreta. A acne grau I é exclusivamente comedoniana, sem nódulos ou lesões purulentas.
Acne papulopustulosa (Grau II) → presença de pápulas e pústulas superficiais, sem nódulos profundos.
Justificativa: Incorreta. A acne grau II apresenta inflamação leve a moderada, mas não cursa com nódulos furunculoides.
Acne conglobata (Grau IV) → forma inflamatória grave com nódulos, abscessos, fístulas e tendência à formação de cicatrizes.
Justificativa: Correta. A associação de comedões, nódulos furunculoides e lesões purulentas caracteriza acne conglobata, classificada como grau IV.
Acne fulminante (Grau V) → forma ulceronecrosante associada a febre, mal-estar e alterações laboratoriais sistêmicas.
Justificativa: Incorreta. A acne fulminante cursa com manifestações sistêmicas importantes, como febre, artralgias e mal-estar, ausentes no caso clínico.
🧠 Dica de memorização
Grau I → apenas comedões.
Grau II → pápulas e pústulas.
Grau III → nódulos e cistos.
Grau IV → acne conglobata = nódulos furunculoides + abscessos + fístulas.
Grau V → acne fulminante = acne grave + sintomas sistêmicos.
📚 Explicação geral
A acne vulgar é classificada conforme a intensidade da inflamação. A acne conglobata (grau IV) é uma das formas mais graves, predominando em adolescentes do sexo masculino. Caracteriza-se por comedões numerosos, nódulos inflamatórios profundos, abscessos, fístulas e intensa produção de secreção purulenta, evoluindo frequentemente com cicatrizes permanentes. Deve ser diferenciada da acne fulminante, que apresenta quadro sistêmico importante.
Nos casos de acne conglobata, qual alternativa apresenta duas medidas importantes para o manejo da doença?
Higienização frequente da pele + antibioticoterapia tópica isolada.
Justificativa: Incorreta. A higiene auxilia no controle da oleosidade, porém não controla formas graves, e a monoterapia com antibióticos deve ser evitada devido ao risco de resistência bacteriana.
Isotretinoína oral + acompanhamento clínico com monitorização laboratorial e orientação quanto ao risco de cicatrizes.
Justificativa: Correta. A isotretinoína é o tratamento de escolha da acne conglobata. O acompanhamento clínico e laboratorial é essencial devido aos efeitos adversos do medicamento e ao elevado risco de cicatrizes permanentes.
Apenas extração de comedões + peelings químicos seriados.
Justificativa: Incorreta. Esses procedimentos podem complementar o tratamento após o controle da inflamação, mas são insuficientes para tratar acne conglobata.
Corticoide tópico + suspensão definitiva de alimentos gordurosos.
Justificativa: Incorreta. Corticoides tópicos não fazem parte do tratamento da acne conglobata, e a exclusão de alimentos gordurosos isoladamente não controla a doença.
🧠 Dica de memorização
Acne grave → Isotretinoína oral.
Antibiótico nunca em monoterapia.
Peelings e extração de comedões → apenas adjuvantes, após controle da inflamação.
Acne fulminante → pode necessitar corticoterapia sistêmica antes da isotretinoína.
Quanto mais grave a acne, maior o risco de cicatrizes permanentes.
📚 Explicação geral
O tratamento da acne depende da gravidade das lesões. Na acne conglobata, a isotretinoína oral é considerada o tratamento de escolha por atuar sobre os quatro pilares fisiopatológicos da doença: redução da produção sebácea, normalização da queratinização folicular, diminuição da colonização por Cutibacterium acnes e ação anti-inflamatória. Durante o tratamento é necessária monitorização clínica e laboratorial, além de orientação sobre efeitos adversos, risco de cicatrizes e importância da adesão terapêutica. Antibióticos sistêmicos podem ser utilizados em situações específicas, mas não devem ser empregados como monoterapia.
AMM, 42 anos, HIV positivo, em tratamento com TARV iniciado há 2 semanas, relata febre baixa (37,9°C), adinamia e lesões dolorosas em mucosa oral e vaginal há 15 dias, caracterizadas por vesículas agrupadas sobre base eritematosa. Qual alternativa apresenta corretamente o diagnóstico clínico?
Herpes-zóster → reativação do vírus Varicela-Zóster → lesões vesiculares em distribuição dermatomérica unilateral.
Justificativa: Incorreta. O herpes-zóster apresenta distribuição ao longo de um dermátomo, geralmente unilateral, e não acomete simultaneamente mucosa oral e genital.
Herpes simples → infecção pelo vírus Herpes simplex (HSV-1/HSV-2) → vesículas agrupadas sobre base eritematosa, dolorosas, com frequente acometimento de mucosas.
Justificativa: Correta. O quadro é típico de herpes simples, caracterizado por lesões vesiculares dolorosas sobre base eritematosa, frequentemente envolvendo mucosas, especialmente em pacientes imunossuprimidos.
Síndrome da pele escaldada estafilocócica → toxinas esfoliativas do Staphylococcus aureus → bolhas flácidas difusas.
Justificativa: Incorreta. A SSSS acomete principalmente recém-nascidos e crianças pequenas, cursando com bolhas flácidas e descamação difusa, sem vesículas agrupadas em mucosas.
Doença de Behçet → vasculite multissistêmica → úlceras orais e genitais recorrentes.
Justificativa: Incorreta. Embora a doença de Behçet apresente úlceras orais e genitais, as lesões são ulceradas desde o início, sem fase típica de vesículas agrupadas sobre base eritematosa.
🧠 Dica de memorização
HSV → Vesículas agrupadas + dor + base eritematosa.
HSV-1 → predominância oral.
HSV-2 → predominância genital (embora ambos possam acometer qualquer sítio).
Herpes-zóster → dermátomo unilateral.
Behçet → úlceras recorrentes, não vesículas.
📚 Explicação geral
O herpes simples é causado pelos vírus HSV-1 e HSV-2, permanecendo latente nos gânglios sensitivos após a infecção primária. A reativação ocorre principalmente em situações de imunossupressão, estresse ou trauma. As lesões iniciam-se como vesículas agrupadas sobre base eritematosa, que rapidamente se rompem formando erosões dolorosas. Em pacientes com HIV, as lesões podem ser extensas, persistentes e acometer simultaneamente diferentes mucosas.
Embora o diagnóstico do herpes simples seja predominantemente clínico, qual alternativa apresenta dois exames complementares que podem auxiliar na confirmação diagnóstica?
PCR para HSV + Citologia de Tzanck → detecta DNA viral e evidencia células gigantes multinucleadas, respectivamente.
Justificativa: Correta. O PCR é o método mais sensível para confirmação do HSV, enquanto o esfregaço de Tzanck demonstra células gigantes multinucleadas, auxiliando no diagnóstico.
Cultura bacteriana + Pesquisa de corpos fumagoides.
Justificativa: Incorreta. A cultura bacteriana não diagnostica herpes simples, e corpos fumagoides são característicos da cromoblastomicose.
Pesquisa de BAAR + Teste de Montenegro.
Justificativa: Incorreta. O BAAR é utilizado para micobactérias, e o teste de Montenegro auxilia no diagnóstico da leishmaniose tegumentar.
Exame micológico direto + Cultura para Sporothrix spp.
Justificativa: Incorreta. Esses exames são utilizados para micoses, como dermatofitoses e esporotricose, não para infecções pelo HSV.
🧠 Dica de memorização
Herpes simples → diagnóstico geralmente clínico.
PCR → exame mais sensível para HSV.
Tzanck → células gigantes multinucleadas (não diferencia HSV de VZV).
Cultura viral → pode ser utilizada, porém tem menor sensibilidade que o PCR.
Corpos fumagoides = cromoblastomicose | Conídios em "margarida" = esporotricose.
📚 Explicação geral
O diagnóstico do herpes simples é, na maioria das vezes, clínico, baseado na presença de vesículas agrupadas dolorosas sobre base eritematosa. Quando há necessidade de confirmação, especialmente em pacientes imunossuprimidos ou apresentações atípicas, o PCR para HSV é o exame de maior sensibilidade e especificidade. A citologia de Tzanck é um método rápido e de baixo custo, demonstrando células gigantes multinucleadas e acantólise, embora não diferencie HSV do vírus Varicela-Zóster. A cultura viral e testes de imunofluorescência também podem ser utilizados, mas atualmente o PCR é considerado o método de escolha para confirmação laboratorial.', 'O impetigo bolhoso é uma infecção bacteriana superficial causada quase exclusivamente pelo Staphylococcus aureus, produtor de toxinas esfoliativas.',
        'Crosta melicérica = Impetigo.
Bolha flácida → pensar em impetigo bolhoso.
Úlcera profunda com cicatriz → Ectima.
Placa eritematosa dolorosa → Erisipela.
Vesículas agrupadas → Herpes simples.', 'Atenção ao comando: apenas uma alternativa deve corresponder integralmente ao enunciado.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '44b34a8f-57f5-5502-bc07-7d864bafaa66'::uuid, '89eb0725-ddcc-5e6f-85bd-f3ec0768530c'::uuid,
        'A', 'Erisipela → infecção da derme profunda e vasos linfáticos → placa eritematosa bem delimitada, dolorosa e de rápida evolução.', 'Incorreta. A erisipela cursa com placa eritematosa infiltrada, edema e dor, sem formação de bolhas purulentas seguidas de crostas melicéricas.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '0a8a091a-c5d3-506f-83cb-426485063646'::uuid, '89eb0725-ddcc-5e6f-85bd-f3ec0768530c'::uuid,
        'B', 'Impetigo bolhoso → infecção superficial por Staphylococcus aureus → bolhas flácidas que se rompem facilmente, formando crostas melicéricas.', 'Correta. O quadro clínico é típico de impetigo bolhoso, caracterizado por bolhas superficiais que evoluem para crostas amareladas ("melicéricas"), acometendo principalmente crianças.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'baf50872-510f-59fd-8770-4b0bde32ee9d'::uuid, '89eb0725-ddcc-5e6f-85bd-f3ec0768530c'::uuid,
        'C', 'Ectima → infecção bacteriana ulcerada que acomete derme profunda → úlcera com crosta espessa e aderida.', 'Incorreta. O ectima é uma forma ulcerada do impetigo, acomete camadas mais profundas da pele e deixa cicatriz, diferente do quadro apresentado.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '96e4dd69-d050-51ee-bac4-3f818461a4f7'::uuid, '89eb0725-ddcc-5e6f-85bd-f3ec0768530c'::uuid,
        'D', 'Herpes simples → vesículas agrupadas sobre base eritematosa → evolução recorrente.', 'Incorreta. O herpes simples caracteriza-se por vesículas agrupadas contendo líquido claro, geralmente dolorosas, e não por bolhas purulentas com crostas melicéricas.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 009 | Turma 115 -T1- Transformada em objetiva
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '42aa62e1-3a35-5f90-b0a0-ff0d45f9a6f5'::uuid, v_discipline_id, NULL, 'médio',
        'Nos pacientes com impetigo, qual das alternativas apresenta uma possível complicação da doença?', 'single',
        'A', ARRAY[]::text[],
        'O impetigo é uma piodermite superficial causada por Staphylococcus aureus, Streptococcus pyogenes ou ambos. Embora a maioria dos casos evolua de forma benigna, quando há participação de cepas nefritogênicas de S. pyogenes, pode ocorrer glomerulonefrite pós-estreptocócica, uma complicação imunomediada decorrente da deposição de imunocomplexos nos glomérulos. Diferentemente da faringite estreptocócica, o impetigo não está associado ao desenvolvimento de febre reumática, o que constitui uma pegadinha frequente em provas de Dermatologia e Infectologia.
ADF, masculino, 14 anos, apresenta comedões abertos, intensa reação inflamatória, nódulos furunculoides e lesões purulentas na face. Qual alternativa apresenta corretamente o diagnóstico e a classificação da doença?
Acne comedoniana (Grau I) → predominam comedões abertos e fechados, sem lesões inflamatórias.
Justificativa: Incorreta. A acne grau I é exclusivamente comedoniana, sem nódulos ou lesões purulentas.
Acne papulopustulosa (Grau II) → presença de pápulas e pústulas superficiais, sem nódulos profundos.
Justificativa: Incorreta. A acne grau II apresenta inflamação leve a moderada, mas não cursa com nódulos furunculoides.
Acne conglobata (Grau IV) → forma inflamatória grave com nódulos, abscessos, fístulas e tendência à formação de cicatrizes.
Justificativa: Correta. A associação de comedões, nódulos furunculoides e lesões purulentas caracteriza acne conglobata, classificada como grau IV.
Acne fulminante (Grau V) → forma ulceronecrosante associada a febre, mal-estar e alterações laboratoriais sistêmicas.
Justificativa: Incorreta. A acne fulminante cursa com manifestações sistêmicas importantes, como febre, artralgias e mal-estar, ausentes no caso clínico.
🧠 Dica de memorização
Grau I → apenas comedões.
Grau II → pápulas e pústulas.
Grau III → nódulos e cistos.
Grau IV → acne conglobata = nódulos furunculoides + abscessos + fístulas.
Grau V → acne fulminante = acne grave + sintomas sistêmicos.
📚 Explicação geral
A acne vulgar é classificada conforme a intensidade da inflamação. A acne conglobata (grau IV) é uma das formas mais graves, predominando em adolescentes do sexo masculino. Caracteriza-se por comedões numerosos, nódulos inflamatórios profundos, abscessos, fístulas e intensa produção de secreção purulenta, evoluindo frequentemente com cicatrizes permanentes. Deve ser diferenciada da acne fulminante, que apresenta quadro sistêmico importante.
Nos casos de acne conglobata, qual alternativa apresenta duas medidas importantes para o manejo da doença?
Higienização frequente da pele + antibioticoterapia tópica isolada.
Justificativa: Incorreta. A higiene auxilia no controle da oleosidade, porém não controla formas graves, e a monoterapia com antibióticos deve ser evitada devido ao risco de resistência bacteriana.
Isotretinoína oral + acompanhamento clínico com monitorização laboratorial e orientação quanto ao risco de cicatrizes.
Justificativa: Correta. A isotretinoína é o tratamento de escolha da acne conglobata. O acompanhamento clínico e laboratorial é essencial devido aos efeitos adversos do medicamento e ao elevado risco de cicatrizes permanentes.
Apenas extração de comedões + peelings químicos seriados.
Justificativa: Incorreta. Esses procedimentos podem complementar o tratamento após o controle da inflamação, mas são insuficientes para tratar acne conglobata.
Corticoide tópico + suspensão definitiva de alimentos gordurosos.
Justificativa: Incorreta. Corticoides tópicos não fazem parte do tratamento da acne conglobata, e a exclusão de alimentos gordurosos isoladamente não controla a doença.
🧠 Dica de memorização
Acne grave → Isotretinoína oral.
Antibiótico nunca em monoterapia.
Peelings e extração de comedões → apenas adjuvantes, após controle da inflamação.
Acne fulminante → pode necessitar corticoterapia sistêmica antes da isotretinoína.
Quanto mais grave a acne, maior o risco de cicatrizes permanentes.
📚 Explicação geral
O tratamento da acne depende da gravidade das lesões. Na acne conglobata, a isotretinoína oral é considerada o tratamento de escolha por atuar sobre os quatro pilares fisiopatológicos da doença: redução da produção sebácea, normalização da queratinização folicular, diminuição da colonização por Cutibacterium acnes e ação anti-inflamatória. Durante o tratamento é necessária monitorização clínica e laboratorial, além de orientação sobre efeitos adversos, risco de cicatrizes e importância da adesão terapêutica. Antibióticos sistêmicos podem ser utilizados em situações específicas, mas não devem ser empregados como monoterapia.
AMM, 42 anos, HIV positivo, em tratamento com TARV iniciado há 2 semanas, relata febre baixa (37,9°C), adinamia e lesões dolorosas em mucosa oral e vaginal há 15 dias, caracterizadas por vesículas agrupadas sobre base eritematosa. Qual alternativa apresenta corretamente o diagnóstico clínico?
Herpes-zóster → reativação do vírus Varicela-Zóster → lesões vesiculares em distribuição dermatomérica unilateral.
Justificativa: Incorreta. O herpes-zóster apresenta distribuição ao longo de um dermátomo, geralmente unilateral, e não acomete simultaneamente mucosa oral e genital.
Herpes simples → infecção pelo vírus Herpes simplex (HSV-1/HSV-2) → vesículas agrupadas sobre base eritematosa, dolorosas, com frequente acometimento de mucosas.
Justificativa: Correta. O quadro é típico de herpes simples, caracterizado por lesões vesiculares dolorosas sobre base eritematosa, frequentemente envolvendo mucosas, especialmente em pacientes imunossuprimidos.
Síndrome da pele escaldada estafilocócica → toxinas esfoliativas do Staphylococcus aureus → bolhas flácidas difusas.
Justificativa: Incorreta. A SSSS acomete principalmente recém-nascidos e crianças pequenas, cursando com bolhas flácidas e descamação difusa, sem vesículas agrupadas em mucosas.
Doença de Behçet → vasculite multissistêmica → úlceras orais e genitais recorrentes.
Justificativa: Incorreta. Embora a doença de Behçet apresente úlceras orais e genitais, as lesões são ulceradas desde o início, sem fase típica de vesículas agrupadas sobre base eritematosa.
🧠 Dica de memorização
HSV → Vesículas agrupadas + dor + base eritematosa.
HSV-1 → predominância oral.
HSV-2 → predominância genital (embora ambos possam acometer qualquer sítio).
Herpes-zóster → dermátomo unilateral.
Behçet → úlceras recorrentes, não vesículas.
📚 Explicação geral
O herpes simples é causado pelos vírus HSV-1 e HSV-2, permanecendo latente nos gânglios sensitivos após a infecção primária. A reativação ocorre principalmente em situações de imunossupressão, estresse ou trauma. As lesões iniciam-se como vesículas agrupadas sobre base eritematosa, que rapidamente se rompem formando erosões dolorosas. Em pacientes com HIV, as lesões podem ser extensas, persistentes e acometer simultaneamente diferentes mucosas.
Embora o diagnóstico do herpes simples seja predominantemente clínico, qual alternativa apresenta dois exames complementares que podem auxiliar na confirmação diagnóstica?
PCR para HSV + Citologia de Tzanck → detecta DNA viral e evidencia células gigantes multinucleadas, respectivamente.
Justificativa: Correta. O PCR é o método mais sensível para confirmação do HSV, enquanto o esfregaço de Tzanck demonstra células gigantes multinucleadas, auxiliando no diagnóstico.
Cultura bacteriana + Pesquisa de corpos fumagoides.
Justificativa: Incorreta. A cultura bacteriana não diagnostica herpes simples, e corpos fumagoides são característicos da cromoblastomicose.
Pesquisa de BAAR + Teste de Montenegro.
Justificativa: Incorreta. O BAAR é utilizado para micobactérias, e o teste de Montenegro auxilia no diagnóstico da leishmaniose tegumentar.
Exame micológico direto + Cultura para Sporothrix spp.
Justificativa: Incorreta. Esses exames são utilizados para micoses, como dermatofitoses e esporotricose, não para infecções pelo HSV.
🧠 Dica de memorização
Herpes simples → diagnóstico geralmente clínico.
PCR → exame mais sensível para HSV.
Tzanck → células gigantes multinucleadas (não diferencia HSV de VZV).
Cultura viral → pode ser utilizada, porém tem menor sensibilidade que o PCR.
Corpos fumagoides = cromoblastomicose | Conídios em "margarida" = esporotricose.
📚 Explicação geral
O diagnóstico do herpes simples é, na maioria das vezes, clínico, baseado na presença de vesículas agrupadas dolorosas sobre base eritematosa. Quando há necessidade de confirmação, especialmente em pacientes imunossuprimidos ou apresentações atípicas, o PCR para HSV é o exame de maior sensibilidade e especificidade. A citologia de Tzanck é um método rápido e de baixo custo, demonstrando células gigantes multinucleadas e acantólise, embora não diferencie HSV do vírus Varicela-Zóster. A cultura viral e testes de imunofluorescência também podem ser utilizados, mas atualmente o PCR é considerado o método de escolha para confirmação laboratorial.', 'O impetigo é uma piodermite superficial causada por Staphylococcus aureus, Streptococcus pyogenes ou ambos.',
        'Impetigo estreptocócico → Glomerulonefrite pós-estreptocócica.
Faringite estreptocócica → Febre reumática.
Herpes-zóster → Neuralgia pós-herpética e Ramsay Hunt.
Crosta melicérica = lembrar do impetigo.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '37aab49f-a570-573b-a2f5-a359c00035fc'::uuid, '42aa62e1-3a35-5f90-b0a0-ff0d45f9a6f5'::uuid,
        'A', 'Glomerulonefrite pós-estreptocócica → complicação imunológica que pode ocorrer após infecção por cepas nefritogênicas de Streptococcus pyogenes.', 'Correta. A glomerulonefrite pós-estreptocócica é uma complicação clássica do impetigo estreptocócico e pode surgir semanas após a infecção cutânea.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'c9bbfc2a-aa8a-5a9f-a866-d7a8d0c3ff95'::uuid, '42aa62e1-3a35-5f90-b0a0-ff0d45f9a6f5'::uuid,
        'B', 'Febre reumática → complicação autoimune típica da faringoamigdalite estreptocócica.', 'Incorreta. A febre reumática está relacionada à faringite por Streptococcus pyogenes, não ao impetigo.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '193a0736-0db4-558b-85c8-2d8f854fed94'::uuid, '42aa62e1-3a35-5f90-b0a0-ff0d45f9a6f5'::uuid,
        'C', 'Neuralgia pós-herpética → dor neuropática persistente após infecção pelo vírus Varicela-Zóster.', 'Incorreta. Trata-se de complicação do herpes-zóster, sem relação com impetigo.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '371535cc-8db2-5a9b-9ee2-725f06c6b215'::uuid, '42aa62e1-3a35-5f90-b0a0-ff0d45f9a6f5'::uuid,
        'D', 'Síndrome de Ramsay Hunt → acometimento do nervo facial pelo vírus Varicela-Zóster.', 'Incorreta. A síndrome de Ramsay Hunt é uma complicação do herpes-zóster otológico e não do impetigo.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 010 | Turma 115 -T1- Transformada em objetiva
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '6151cfa1-c483-553f-b6f3-c8c57d14e99f'::uuid, v_discipline_id, NULL, 'médio',
        'ADF, masculino, 14 anos, apresenta comedões abertos, intensa reação inflamatória, nódulos furunculoides e lesões purulentas na face. Qual alternativa apresenta corretamente o diagnóstico e a classificação da doença?', 'single',
        'C', ARRAY[]::text[],
        'A acne vulgar é classificada conforme a intensidade da inflamação. A acne conglobata (grau IV) é uma das formas mais graves, predominando em adolescentes do sexo masculino. Caracteriza-se por comedões numerosos, nódulos inflamatórios profundos, abscessos, fístulas e intensa produção de secreção purulenta, evoluindo frequentemente com cicatrizes permanentes. Deve ser diferenciada da acne fulminante, que apresenta quadro sistêmico importante.
Nos casos de acne conglobata, qual alternativa apresenta duas medidas importantes para o manejo da doença?
Higienização frequente da pele + antibioticoterapia tópica isolada.
Justificativa: Incorreta. A higiene auxilia no controle da oleosidade, porém não controla formas graves, e a monoterapia com antibióticos deve ser evitada devido ao risco de resistência bacteriana.
Isotretinoína oral + acompanhamento clínico com monitorização laboratorial e orientação quanto ao risco de cicatrizes.
Justificativa: Correta. A isotretinoína é o tratamento de escolha da acne conglobata. O acompanhamento clínico e laboratorial é essencial devido aos efeitos adversos do medicamento e ao elevado risco de cicatrizes permanentes.
Apenas extração de comedões + peelings químicos seriados.
Justificativa: Incorreta. Esses procedimentos podem complementar o tratamento após o controle da inflamação, mas são insuficientes para tratar acne conglobata.
Corticoide tópico + suspensão definitiva de alimentos gordurosos.
Justificativa: Incorreta. Corticoides tópicos não fazem parte do tratamento da acne conglobata, e a exclusão de alimentos gordurosos isoladamente não controla a doença.
🧠 Dica de memorização
Acne grave → Isotretinoína oral.
Antibiótico nunca em monoterapia.
Peelings e extração de comedões → apenas adjuvantes, após controle da inflamação.
Acne fulminante → pode necessitar corticoterapia sistêmica antes da isotretinoína.
Quanto mais grave a acne, maior o risco de cicatrizes permanentes.
📚 Explicação geral
O tratamento da acne depende da gravidade das lesões. Na acne conglobata, a isotretinoína oral é considerada o tratamento de escolha por atuar sobre os quatro pilares fisiopatológicos da doença: redução da produção sebácea, normalização da queratinização folicular, diminuição da colonização por Cutibacterium acnes e ação anti-inflamatória. Durante o tratamento é necessária monitorização clínica e laboratorial, além de orientação sobre efeitos adversos, risco de cicatrizes e importância da adesão terapêutica. Antibióticos sistêmicos podem ser utilizados em situações específicas, mas não devem ser empregados como monoterapia.
AMM, 42 anos, HIV positivo, em tratamento com TARV iniciado há 2 semanas, relata febre baixa (37,9°C), adinamia e lesões dolorosas em mucosa oral e vaginal há 15 dias, caracterizadas por vesículas agrupadas sobre base eritematosa. Qual alternativa apresenta corretamente o diagnóstico clínico?
Herpes-zóster → reativação do vírus Varicela-Zóster → lesões vesiculares em distribuição dermatomérica unilateral.
Justificativa: Incorreta. O herpes-zóster apresenta distribuição ao longo de um dermátomo, geralmente unilateral, e não acomete simultaneamente mucosa oral e genital.
Herpes simples → infecção pelo vírus Herpes simplex (HSV-1/HSV-2) → vesículas agrupadas sobre base eritematosa, dolorosas, com frequente acometimento de mucosas.
Justificativa: Correta. O quadro é típico de herpes simples, caracterizado por lesões vesiculares dolorosas sobre base eritematosa, frequentemente envolvendo mucosas, especialmente em pacientes imunossuprimidos.
Síndrome da pele escaldada estafilocócica → toxinas esfoliativas do Staphylococcus aureus → bolhas flácidas difusas.
Justificativa: Incorreta. A SSSS acomete principalmente recém-nascidos e crianças pequenas, cursando com bolhas flácidas e descamação difusa, sem vesículas agrupadas em mucosas.
Doença de Behçet → vasculite multissistêmica → úlceras orais e genitais recorrentes.
Justificativa: Incorreta. Embora a doença de Behçet apresente úlceras orais e genitais, as lesões são ulceradas desde o início, sem fase típica de vesículas agrupadas sobre base eritematosa.
🧠 Dica de memorização
HSV → Vesículas agrupadas + dor + base eritematosa.
HSV-1 → predominância oral.
HSV-2 → predominância genital (embora ambos possam acometer qualquer sítio).
Herpes-zóster → dermátomo unilateral.
Behçet → úlceras recorrentes, não vesículas.
📚 Explicação geral
O herpes simples é causado pelos vírus HSV-1 e HSV-2, permanecendo latente nos gânglios sensitivos após a infecção primária. A reativação ocorre principalmente em situações de imunossupressão, estresse ou trauma. As lesões iniciam-se como vesículas agrupadas sobre base eritematosa, que rapidamente se rompem formando erosões dolorosas. Em pacientes com HIV, as lesões podem ser extensas, persistentes e acometer simultaneamente diferentes mucosas.
Embora o diagnóstico do herpes simples seja predominantemente clínico, qual alternativa apresenta dois exames complementares que podem auxiliar na confirmação diagnóstica?
PCR para HSV + Citologia de Tzanck → detecta DNA viral e evidencia células gigantes multinucleadas, respectivamente.
Justificativa: Correta. O PCR é o método mais sensível para confirmação do HSV, enquanto o esfregaço de Tzanck demonstra células gigantes multinucleadas, auxiliando no diagnóstico.
Cultura bacteriana + Pesquisa de corpos fumagoides.
Justificativa: Incorreta. A cultura bacteriana não diagnostica herpes simples, e corpos fumagoides são característicos da cromoblastomicose.
Pesquisa de BAAR + Teste de Montenegro.
Justificativa: Incorreta. O BAAR é utilizado para micobactérias, e o teste de Montenegro auxilia no diagnóstico da leishmaniose tegumentar.
Exame micológico direto + Cultura para Sporothrix spp.
Justificativa: Incorreta. Esses exames são utilizados para micoses, como dermatofitoses e esporotricose, não para infecções pelo HSV.
🧠 Dica de memorização
Herpes simples → diagnóstico geralmente clínico.
PCR → exame mais sensível para HSV.
Tzanck → células gigantes multinucleadas (não diferencia HSV de VZV).
Cultura viral → pode ser utilizada, porém tem menor sensibilidade que o PCR.
Corpos fumagoides = cromoblastomicose | Conídios em "margarida" = esporotricose.
📚 Explicação geral
O diagnóstico do herpes simples é, na maioria das vezes, clínico, baseado na presença de vesículas agrupadas dolorosas sobre base eritematosa. Quando há necessidade de confirmação, especialmente em pacientes imunossuprimidos ou apresentações atípicas, o PCR para HSV é o exame de maior sensibilidade e especificidade. A citologia de Tzanck é um método rápido e de baixo custo, demonstrando células gigantes multinucleadas e acantólise, embora não diferencie HSV do vírus Varicela-Zóster. A cultura viral e testes de imunofluorescência também podem ser utilizados, mas atualmente o PCR é considerado o método de escolha para confirmação laboratorial.', 'A acne vulgar é classificada conforme a intensidade da inflamação.',
        'Grau I → apenas comedões.
Grau II → pápulas e pústulas.
Grau III → nódulos e cistos.
Grau IV → acne conglobata = nódulos furunculoides + abscessos + fístulas.
Grau V → acne fulminante = acne grave + sintomas sistêmicos.', 'Atenção ao comando: apenas uma alternativa deve corresponder integralmente ao enunciado.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'b94d3611-22ed-5715-8f75-87e4f8fc9324'::uuid, '6151cfa1-c483-553f-b6f3-c8c57d14e99f'::uuid,
        'A', 'Acne comedoniana (Grau I) → predominam comedões abertos e fechados, sem lesões inflamatórias.', 'Incorreta. A acne grau I é exclusivamente comedoniana, sem nódulos ou lesões purulentas.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '64d4ffe6-6f46-5e6e-86ab-f8e89c6e1438'::uuid, '6151cfa1-c483-553f-b6f3-c8c57d14e99f'::uuid,
        'B', 'Acne papulopustulosa (Grau II) → presença de pápulas e pústulas superficiais, sem nódulos profundos.', 'Incorreta. A acne grau II apresenta inflamação leve a moderada, mas não cursa com nódulos furunculoides.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'f00ddf0b-99a8-5874-8622-1ec3bffd72b7'::uuid, '6151cfa1-c483-553f-b6f3-c8c57d14e99f'::uuid,
        'C', 'Acne conglobata (Grau IV) → forma inflamatória grave com nódulos, abscessos, fístulas e tendência à formação de cicatrizes.', 'Correta. A associação de comedões, nódulos furunculoides e lesões purulentas caracteriza acne conglobata, classificada como grau IV.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'f36b671b-87fa-5f96-a21b-9499b2c677cb'::uuid, '6151cfa1-c483-553f-b6f3-c8c57d14e99f'::uuid,
        'D', 'Acne fulminante (Grau V) → forma ulceronecrosante associada a febre, mal-estar e alterações laboratoriais sistêmicas.', 'Incorreta. A acne fulminante cursa com manifestações sistêmicas importantes, como febre, artralgias e mal-estar, ausentes no caso clínico.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 011 | Turma 115 -T1- Transformada em objetiva
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        'ae312db2-f496-5ab3-86e9-0f9684626aae'::uuid, v_discipline_id, NULL, 'médio',
        'Nos casos de acne conglobata, qual alternativa apresenta duas medidas importantes para o manejo da doença?', 'single',
        'B', ARRAY[]::text[],
        'O tratamento da acne depende da gravidade das lesões. Na acne conglobata, a isotretinoína oral é considerada o tratamento de escolha por atuar sobre os quatro pilares fisiopatológicos da doença: redução da produção sebácea, normalização da queratinização folicular, diminuição da colonização por Cutibacterium acnes e ação anti-inflamatória. Durante o tratamento é necessária monitorização clínica e laboratorial, além de orientação sobre efeitos adversos, risco de cicatrizes e importância da adesão terapêutica. Antibióticos sistêmicos podem ser utilizados em situações específicas, mas não devem ser empregados como monoterapia.
AMM, 42 anos, HIV positivo, em tratamento com TARV iniciado há 2 semanas, relata febre baixa (37,9°C), adinamia e lesões dolorosas em mucosa oral e vaginal há 15 dias, caracterizadas por vesículas agrupadas sobre base eritematosa. Qual alternativa apresenta corretamente o diagnóstico clínico?
Herpes-zóster → reativação do vírus Varicela-Zóster → lesões vesiculares em distribuição dermatomérica unilateral.
Justificativa: Incorreta. O herpes-zóster apresenta distribuição ao longo de um dermátomo, geralmente unilateral, e não acomete simultaneamente mucosa oral e genital.
Herpes simples → infecção pelo vírus Herpes simplex (HSV-1/HSV-2) → vesículas agrupadas sobre base eritematosa, dolorosas, com frequente acometimento de mucosas.
Justificativa: Correta. O quadro é típico de herpes simples, caracterizado por lesões vesiculares dolorosas sobre base eritematosa, frequentemente envolvendo mucosas, especialmente em pacientes imunossuprimidos.
Síndrome da pele escaldada estafilocócica → toxinas esfoliativas do Staphylococcus aureus → bolhas flácidas difusas.
Justificativa: Incorreta. A SSSS acomete principalmente recém-nascidos e crianças pequenas, cursando com bolhas flácidas e descamação difusa, sem vesículas agrupadas em mucosas.
Doença de Behçet → vasculite multissistêmica → úlceras orais e genitais recorrentes.
Justificativa: Incorreta. Embora a doença de Behçet apresente úlceras orais e genitais, as lesões são ulceradas desde o início, sem fase típica de vesículas agrupadas sobre base eritematosa.
🧠 Dica de memorização
HSV → Vesículas agrupadas + dor + base eritematosa.
HSV-1 → predominância oral.
HSV-2 → predominância genital (embora ambos possam acometer qualquer sítio).
Herpes-zóster → dermátomo unilateral.
Behçet → úlceras recorrentes, não vesículas.
📚 Explicação geral
O herpes simples é causado pelos vírus HSV-1 e HSV-2, permanecendo latente nos gânglios sensitivos após a infecção primária. A reativação ocorre principalmente em situações de imunossupressão, estresse ou trauma. As lesões iniciam-se como vesículas agrupadas sobre base eritematosa, que rapidamente se rompem formando erosões dolorosas. Em pacientes com HIV, as lesões podem ser extensas, persistentes e acometer simultaneamente diferentes mucosas.
Embora o diagnóstico do herpes simples seja predominantemente clínico, qual alternativa apresenta dois exames complementares que podem auxiliar na confirmação diagnóstica?
PCR para HSV + Citologia de Tzanck → detecta DNA viral e evidencia células gigantes multinucleadas, respectivamente.
Justificativa: Correta. O PCR é o método mais sensível para confirmação do HSV, enquanto o esfregaço de Tzanck demonstra células gigantes multinucleadas, auxiliando no diagnóstico.
Cultura bacteriana + Pesquisa de corpos fumagoides.
Justificativa: Incorreta. A cultura bacteriana não diagnostica herpes simples, e corpos fumagoides são característicos da cromoblastomicose.
Pesquisa de BAAR + Teste de Montenegro.
Justificativa: Incorreta. O BAAR é utilizado para micobactérias, e o teste de Montenegro auxilia no diagnóstico da leishmaniose tegumentar.
Exame micológico direto + Cultura para Sporothrix spp.
Justificativa: Incorreta. Esses exames são utilizados para micoses, como dermatofitoses e esporotricose, não para infecções pelo HSV.
🧠 Dica de memorização
Herpes simples → diagnóstico geralmente clínico.
PCR → exame mais sensível para HSV.
Tzanck → células gigantes multinucleadas (não diferencia HSV de VZV).
Cultura viral → pode ser utilizada, porém tem menor sensibilidade que o PCR.
Corpos fumagoides = cromoblastomicose | Conídios em "margarida" = esporotricose.
📚 Explicação geral
O diagnóstico do herpes simples é, na maioria das vezes, clínico, baseado na presença de vesículas agrupadas dolorosas sobre base eritematosa. Quando há necessidade de confirmação, especialmente em pacientes imunossuprimidos ou apresentações atípicas, o PCR para HSV é o exame de maior sensibilidade e especificidade. A citologia de Tzanck é um método rápido e de baixo custo, demonstrando células gigantes multinucleadas e acantólise, embora não diferencie HSV do vírus Varicela-Zóster. A cultura viral e testes de imunofluorescência também podem ser utilizados, mas atualmente o PCR é considerado o método de escolha para confirmação laboratorial.', 'O tratamento da acne depende da gravidade das lesões.',
        'Acne grave → Isotretinoína oral.
Antibiótico nunca em monoterapia.
Peelings e extração de comedões → apenas adjuvantes, após controle da inflamação.
Acne fulminante → pode necessitar corticoterapia sistêmica antes da isotretinoína.
Quanto mais grave a acne, maior o risco de cicatrizes permanentes.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '72e16476-19de-539e-9061-d85f511c5c8b'::uuid, 'ae312db2-f496-5ab3-86e9-0f9684626aae'::uuid,
        'A', 'Higienização frequente da pele + antibioticoterapia tópica isolada.', 'Incorreta. A higiene auxilia no controle da oleosidade, porém não controla formas graves, e a monoterapia com antibióticos deve ser evitada devido ao risco de resistência bacteriana.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '01fab525-4166-5b53-9f88-342d0d831a90'::uuid, 'ae312db2-f496-5ab3-86e9-0f9684626aae'::uuid,
        'B', 'Isotretinoína oral + acompanhamento clínico com monitorização laboratorial e orientação quanto ao risco de cicatrizes.', 'Correta. A isotretinoína é o tratamento de escolha da acne conglobata. O acompanhamento clínico e laboratorial é essencial devido aos efeitos adversos do medicamento e ao elevado risco de cicatrizes permanentes.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '8fddd296-8235-59cb-a293-6d260f7dbd0d'::uuid, 'ae312db2-f496-5ab3-86e9-0f9684626aae'::uuid,
        'C', 'Apenas extração de comedões + peelings químicos seriados.', 'Incorreta. Esses procedimentos podem complementar o tratamento após o controle da inflamação, mas são insuficientes para tratar acne conglobata.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'dea33d14-55bb-561d-a8f0-0d64121d6c09'::uuid, 'ae312db2-f496-5ab3-86e9-0f9684626aae'::uuid,
        'D', 'Corticoide tópico + suspensão definitiva de alimentos gordurosos.', 'Incorreta. Corticoides tópicos não fazem parte do tratamento da acne conglobata, e a exclusão de alimentos gordurosos isoladamente não controla a doença.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 012 | Turma 115 -T1- Transformada em objetiva
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        'a3fc6a0f-a8df-5217-bc36-e73eaa1fe7b3'::uuid, v_discipline_id, NULL, 'médio',
        'AMM, 42 anos, HIV positivo, em tratamento com TARV iniciado há 2 semanas, relata febre baixa (37,9°C), adinamia e lesões dolorosas em mucosa oral e vaginal há 15 dias, caracterizadas por vesículas agrupadas sobre base eritematosa. Qual alternativa apresenta corretamente o diagnóstico clínico?', 'single',
        'B', ARRAY[]::text[],
        'O herpes simples é causado pelos vírus HSV-1 e HSV-2, permanecendo latente nos gânglios sensitivos após a infecção primária. A reativação ocorre principalmente em situações de imunossupressão, estresse ou trauma. As lesões iniciam-se como vesículas agrupadas sobre base eritematosa, que rapidamente se rompem formando erosões dolorosas. Em pacientes com HIV, as lesões podem ser extensas, persistentes e acometer simultaneamente diferentes mucosas.
Embora o diagnóstico do herpes simples seja predominantemente clínico, qual alternativa apresenta dois exames complementares que podem auxiliar na confirmação diagnóstica?
PCR para HSV + Citologia de Tzanck → detecta DNA viral e evidencia células gigantes multinucleadas, respectivamente.
Justificativa: Correta. O PCR é o método mais sensível para confirmação do HSV, enquanto o esfregaço de Tzanck demonstra células gigantes multinucleadas, auxiliando no diagnóstico.
Cultura bacteriana + Pesquisa de corpos fumagoides.
Justificativa: Incorreta. A cultura bacteriana não diagnostica herpes simples, e corpos fumagoides são característicos da cromoblastomicose.
Pesquisa de BAAR + Teste de Montenegro.
Justificativa: Incorreta. O BAAR é utilizado para micobactérias, e o teste de Montenegro auxilia no diagnóstico da leishmaniose tegumentar.
Exame micológico direto + Cultura para Sporothrix spp.
Justificativa: Incorreta. Esses exames são utilizados para micoses, como dermatofitoses e esporotricose, não para infecções pelo HSV.
🧠 Dica de memorização
Herpes simples → diagnóstico geralmente clínico.
PCR → exame mais sensível para HSV.
Tzanck → células gigantes multinucleadas (não diferencia HSV de VZV).
Cultura viral → pode ser utilizada, porém tem menor sensibilidade que o PCR.
Corpos fumagoides = cromoblastomicose | Conídios em "margarida" = esporotricose.
📚 Explicação geral
O diagnóstico do herpes simples é, na maioria das vezes, clínico, baseado na presença de vesículas agrupadas dolorosas sobre base eritematosa. Quando há necessidade de confirmação, especialmente em pacientes imunossuprimidos ou apresentações atípicas, o PCR para HSV é o exame de maior sensibilidade e especificidade. A citologia de Tzanck é um método rápido e de baixo custo, demonstrando células gigantes multinucleadas e acantólise, embora não diferencie HSV do vírus Varicela-Zóster. A cultura viral e testes de imunofluorescência também podem ser utilizados, mas atualmente o PCR é considerado o método de escolha para confirmação laboratorial.', 'O herpes simples é causado pelos vírus HSV-1 e HSV-2, permanecendo latente nos gânglios sensitivos após a infecção primária.',
        'HSV → Vesículas agrupadas + dor + base eritematosa.
HSV-1 → predominância oral.
HSV-2 → predominância genital (embora ambos possam acometer qualquer sítio).
Herpes-zóster → dermátomo unilateral.
Behçet → úlceras recorrentes, não vesículas.', 'Atenção ao comando: apenas uma alternativa deve corresponder integralmente ao enunciado.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'f7a93840-2d0d-5d29-a9ee-b42a79b14d27'::uuid, 'a3fc6a0f-a8df-5217-bc36-e73eaa1fe7b3'::uuid,
        'A', 'Herpes-zóster → reativação do vírus Varicela-Zóster → lesões vesiculares em distribuição dermatomérica unilateral.', 'Incorreta. O herpes-zóster apresenta distribuição ao longo de um dermátomo, geralmente unilateral, e não acomete simultaneamente mucosa oral e genital.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '04e55fdb-7747-58b5-8e2d-cb65bed95c6d'::uuid, 'a3fc6a0f-a8df-5217-bc36-e73eaa1fe7b3'::uuid,
        'B', 'Herpes simples → infecção pelo vírus Herpes simplex (HSV-1/HSV-2) → vesículas agrupadas sobre base eritematosa, dolorosas, com frequente acometimento de mucosas.', 'Correta. O quadro é típico de herpes simples, caracterizado por lesões vesiculares dolorosas sobre base eritematosa, frequentemente envolvendo mucosas, especialmente em pacientes imunossuprimidos.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '2808b14b-a47e-5574-99d6-0894f34815c5'::uuid, 'a3fc6a0f-a8df-5217-bc36-e73eaa1fe7b3'::uuid,
        'C', 'Síndrome da pele escaldada estafilocócica → toxinas esfoliativas do Staphylococcus aureus → bolhas flácidas difusas.', 'Incorreta. A SSSS acomete principalmente recém-nascidos e crianças pequenas, cursando com bolhas flácidas e descamação difusa, sem vesículas agrupadas em mucosas.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '6f1a9144-d661-53f5-aa31-78ae46f7a5ab'::uuid, 'a3fc6a0f-a8df-5217-bc36-e73eaa1fe7b3'::uuid,
        'D', 'Doença de Behçet → vasculite multissistêmica → úlceras orais e genitais recorrentes.', 'Incorreta. Embora a doença de Behçet apresente úlceras orais e genitais, as lesões são ulceradas desde o início, sem fase típica de vesículas agrupadas sobre base eritematosa.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 013 | Turma 115 -T1- Transformada em objetiva
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '3291f9ff-af6e-571a-8a5e-8466b2e9dc28'::uuid, v_discipline_id, NULL, 'médio',
        'Embora o diagnóstico do herpes simples seja predominantemente clínico, qual alternativa apresenta dois exames complementares que podem auxiliar na confirmação diagnóstica?', 'single',
        'A', ARRAY[]::text[],
        'O diagnóstico do herpes simples é, na maioria das vezes, clínico, baseado na presença de vesículas agrupadas dolorosas sobre base eritematosa. Quando há necessidade de confirmação, especialmente em pacientes imunossuprimidos ou apresentações atípicas, o PCR para HSV é o exame de maior sensibilidade e especificidade. A citologia de Tzanck é um método rápido e de baixo custo, demonstrando células gigantes multinucleadas e acantólise, embora não diferencie HSV do vírus Varicela-Zóster. A cultura viral e testes de imunofluorescência também podem ser utilizados, mas atualmente o PCR é considerado o método de escolha para confirmação laboratorial.', 'O diagnóstico do herpes simples é, na maioria das vezes, clínico, baseado na presença de vesículas agrupadas dolorosas sobre base eritematosa.',
        'Herpes simples → diagnóstico geralmente clínico.
PCR → exame mais sensível para HSV.
Tzanck → células gigantes multinucleadas (não diferencia HSV de VZV).
Cultura viral → pode ser utilizada, porém tem menor sensibilidade que o PCR.
Corpos fumagoides = cromoblastomicose | Conídios em "margarida" = esporotricose.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '5ec34176-8d0d-5bf9-8ce2-e31ec84ecee9'::uuid, '3291f9ff-af6e-571a-8a5e-8466b2e9dc28'::uuid,
        'A', 'PCR para HSV + Citologia de Tzanck → detecta DNA viral e evidencia células gigantes multinucleadas, respectivamente.', 'Correta. O PCR é o método mais sensível para confirmação do HSV, enquanto o esfregaço de Tzanck demonstra células gigantes multinucleadas, auxiliando no diagnóstico.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '4e613062-26cf-5baf-83a8-1592fbe4dc1c'::uuid, '3291f9ff-af6e-571a-8a5e-8466b2e9dc28'::uuid,
        'B', 'Cultura bacteriana + Pesquisa de corpos fumagoides.', 'Incorreta. A cultura bacteriana não diagnostica herpes simples, e corpos fumagoides são característicos da cromoblastomicose.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'b5a49f9a-b284-5441-a3d3-35295f4bb92a'::uuid, '3291f9ff-af6e-571a-8a5e-8466b2e9dc28'::uuid,
        'C', 'Pesquisa de BAAR + Teste de Montenegro.', 'Incorreta. O BAAR é utilizado para micobactérias, e o teste de Montenegro auxilia no diagnóstico da leishmaniose tegumentar.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '16a2cf60-7cec-5644-aa8a-196438e2d5b6'::uuid, '3291f9ff-af6e-571a-8a5e-8466b2e9dc28'::uuid,
        'D', 'Exame micológico direto + Cultura para Sporothrix spp.', 'Incorreta. Esses exames são utilizados para micoses, como dermatofitoses e esporotricose, não para infecções pelo HSV.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 014 | Turma 116 -T1
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '605fbde6-8cdd-5484-bc0d-7ef9199b744c'::uuid, v_discipline_id, NULL, 'médio',
        'Em relação ao impetigo, é incorreta:', 'single',
        'A', ARRAY[]::text[],
        'O impetigo é a piodermite superficial mais frequente da infância. A forma não bolhosa representa cerca de 70% dos casos e pode ser causada por Staphylococcus aureus ou Streptococcus pyogenes. Já a forma bolhosa é causada quase exclusivamente por S. aureus produtor de toxinas esfoliativas. As lesões acometem preferencialmente a face, especialmente regiões periorais e perinasais, podendo disseminar-se por autoinoculação. Quando a infecção bacteriana ocorre sobre uma dermatose pré-existente, como escabiose ou eczema, recebe o nome de impetiginização.', 'O impetigo é a piodermite superficial mais frequente da infância.',
        'Impetigo = crosta melicérica.
Forma não bolhosa → S. aureus + S. pyogenes.
Forma bolhosa → apenas S. aureus.
Autoinoculação é frequente.
Impetiginização = infecção bacteriana secundária sobre outra dermatose.', 'Atenção ao comando: deve-se marcar a alternativa incorreta ou a exceção.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '9b97c2f2-741b-55fc-a1a6-5017262803c7'::uuid, '605fbde6-8cdd-5484-bc0d-7ef9199b744c'::uuid,
        'A', 'Acometem preferencialmente membros inferiores e face', 'Correta. O impetigo acomete principalmente a face, especialmente regiões periorais e perinasais, além de membros superiores e outras áreas expostas. Os membros inferiores podem ser acometidos, mas não são considerados local de predileção, tornando a afirmação incorreta.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '7f07a4b9-5930-5109-a5d6-1863a73dee5e'::uuid, '605fbde6-8cdd-5484-bc0d-7ef9199b744c'::uuid,
        'B', 'Pode disseminar por autoinoculação', 'Incorreta. O impetigo é altamente contagioso e a autoinoculação é frequente, favorecendo o surgimento de novas lesões em diferentes áreas da pele.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '47a88112-d327-54f6-ba96-6f433a7f3fd4'::uuid, '605fbde6-8cdd-5484-bc0d-7ef9199b744c'::uuid,
        'C', 'Quando o impetigo complica uma pediculose, escabiose e eczema é denominado impetiginização', 'Incorreta. A impetiginização corresponde à infecção bacteriana secundária sobre dermatoses pré-existentes, como escabiose, pediculose e dermatites.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '4115f240-1db8-5ad7-91a0-1d85e891e573'::uuid, '605fbde6-8cdd-5484-bc0d-7ef9199b744c'::uuid,
        'D', 'São infecções primárias de pele causadas por estafilococos e estreptococos', 'Incorreta. O impetigo é uma piodermite primária causada principalmente por Staphylococcus aureus e Streptococcus pyogenes.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 015 | Turma 116 -T1
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '8f3c13c0-6783-55fa-8446-346b1813ad3e'::uuid, v_discipline_id, NULL, 'médio',
        'Em relação à celulite, é incorreto:', 'single',
        'C', ARRAY[]::text[],
        'A celulite é uma infecção bacteriana da derme profunda e do tecido celular subcutâneo, causada principalmente por Streptococcus pyogenes e Staphylococcus aureus. Clinicamente, apresenta placa eritematosa, dolorosa, quente e mal delimitada, diferentemente da erisipela, que possui limites bem definidos. O tratamento baseia-se em antibioticoterapia sistêmica, repouso, elevação do membro acometido e analgesia. Casos graves podem necessitar de internação e antibioticoterapia intravenosa. Embora incomuns, complicações como abscesso, bacteremia e sepse podem ocorrer, especialmente em pacientes com fatores de risco.
Em relação às foliculites, é incorreto afirmar:
Na foliculite decalvante é de evolução crônica, pode causar fibrose e é mais comum nos homens adultos
Justificativa: Incorreta. A foliculite decalvante é uma foliculite crônica neutrofílica, predominante em homens adultos, podendo evoluir com fibrose e alopecia cicatricial.
Tem resposta terapêutica rápida
Justificativa: Correta (é a resposta da questão). A foliculite decalvante apresenta evolução crônica, com frequentes recidivas e resposta terapêutica geralmente lenta e insatisfatória, exigindo tratamento prolongado.
A terapêutica é feita com antibióticos e a dapsona pode ser útil
Justificativa: Incorreta. O tratamento baseia-se principalmente em antibióticos sistêmicos, podendo ser utilizada a dapsona em casos selecionados devido à sua ação anti-inflamatória.
Pode causar politriquia, ou seja, emergir vários fios da mesma abertura folicular
Justificativa: Incorreta. A politríquia (tufted hair folliculitis) é um achado característico da foliculite decalvante, resultante da destruição parcial dos folículos e da emergência de múltiplos fios por um mesmo óstio folicular.
🧠 Dica de memorização
Foliculite decalvante → Decalva = alopecia cicatricial.
Politríquia = vários fios saindo do mesmo óstio folicular.
Predomina em homens adultos.
Tratamento é prolongado e recorrências são frequentes.
Antibióticos são a base da terapêutica; dapsona pode ser utilizada em casos selecionados.
📚 Explicação geral
A foliculite decalvante é uma dermatose inflamatória crônica do couro cabeludo, provavelmente relacionada a uma resposta imunológica anormal ao Staphylococcus aureus. Caracteriza-se por pústulas foliculares recorrentes, crostas, eritema, politríquia e evolução para alopecia cicatricial. O tratamento é difícil, frequentemente exigindo antibioticoterapia prolongada (como rifampicina associada à clindamicina, tetraciclinas ou outros esquemas), podendo ser associados dapsona, isotretinoína ou imunomoduladores em casos refratários. A resposta costuma ser lenta, com elevado índice de recidiva, tornando essa uma das principais características cobradas em provas de Dermatologia.
Em relação à esporotricose, é correto:
A forma cutaneolinfática é a mais comum, corresponde a cerca de 55% dos casos
Justificativa: Incorreta. A forma cutaneolinfática é realmente a mais frequente, porém corresponde a aproximadamente 70–80% dos casos, e não a cerca de 55%.
A forma cutânea localizada de aspecto verrucoso faz diagnóstico diferencial com paracoccidioidomicose, leishmaniose, cromomicose mas não tuberculose
Justificativa: Incorreta. A forma cutânea localizada de aspecto verrucoso também faz diagnóstico diferencial com tuberculose cutânea, além de paracoccidioidomicose, leishmaniose e cromoblastomicose.
Pode-se empregar o itraconazol como tratamento de escolha assim como o iodeto de potássio, o fluconazol, a terbinafina
Justificativa: Correta. O itraconazol é o tratamento de primeira escolha da esporotricose cutânea. A solução saturada de iodeto de potássio permanece como alternativa clássica, enquanto terbinafina e fluconazol podem ser utilizados em situações específicas, embora este último apresente menor eficácia.
Na histopatologia, encontra-se os corpos fumagóides
Justificativa: Incorreta. Os corpos fumagóides (ou corpos escleróticos/Medlar) são característicos da cromoblastomicose, e não da esporotricose. Na esporotricose, o exame histopatológico pode evidenciar reação granulomatosa e, ocasionalmente, corpos asteroides.
🧠 Dica de memorização
Esporotricose → conídios em "margarida" (cultura).
Corpos fumagoides → cromoblastomicose.
Forma mais comum → cutaneolinfática (≈70–80%).
Tratamento de escolha → itraconazol.
Iodeto de potássio → alternativa clássica por via oral.
📚 Explicação geral
A esporotricose é uma micose subcutânea causada por fungos do complexo Sporothrix, adquirida principalmente por inoculação traumática através de espinhos, vegetação ou contato com gatos infectados. A forma cutaneolinfática representa cerca de 70–80% dos casos, caracterizando-se por nódulos que ulceram e se distribuem ao longo dos vasos linfáticos ("rosário linfático"). O itraconazol é o tratamento de primeira escolha, enquanto a solução saturada de iodeto de potássio permanece uma alternativa eficaz. Casos graves, disseminados ou viscerais podem necessitar de anfotericina B. O diagnóstico diferencial inclui leishmaniose tegumentar, cromoblastomicose, tuberculose cutânea e paracoccidioidomicose.
Em relação à cromomicose, é incorreto:
É encontrada em regiões tropicais e subtropicais
Justificativa: Incorreta. A cromoblastomicose é uma micose subcutânea de distribuição predominante em regiões tropicais e subtropicais, incluindo o Brasil.
O número de casos de registro inter-humano vem aumentando, mas não é a forma mais comum de transmissão
Justificativa: Correta (é a resposta da questão). A cromoblastomicose não apresenta transmissão inter-humana. A infecção ocorre por inoculação traumática de fungos demáceos presentes no solo, madeira e vegetação. Portanto, afirmar que os casos de transmissão entre pessoas vêm aumentando é incorreto.
No Brasil, a Fonsecaea pedrosoi é a espécie mais frequente
Justificativa: Incorreta. Fonsecaea pedrosoi é o principal agente etiológico da cromoblastomicose no Brasil.
A identificação das espécies é realizada exclusivamente por meio de cultura
Justificativa: Incorreta. A identificação definitiva da espécie é feita pela cultura, porém o diagnóstico da cromoblastomicose pode ser sugerido pelo exame micológico direto e pela histopatologia, que evidenciam os corpos fumagoides (corpos escleróticos ou de Medlar). Portanto, não depende exclusivamente da cultura para o diagnóstico da doença.
🧠 Dica de memorização
Trauma + madeira + solo → cromoblastomicose.
Não existe transmissão pessoa a pessoa.
Fonsecaea pedrosoi → principal agente no Brasil.
Corpos fumagoides = marca registrada da cromoblastomicose.
Diagnóstico → exame direto, histopatologia e cultura.
📚 Explicação geral
A cromoblastomicose é uma micose subcutânea crônica causada por fungos demáceos, adquirida por inoculação traumática durante atividades rurais. O principal agente no Brasil é Fonsecaea pedrosoi. Clinicamente, manifesta-se por lesões verrucosas de crescimento lento, principalmente nos membros inferiores. O diagnóstico é sugerido pela presença de corpos fumagoides no exame micológico direto ou na histopatologia, sendo a cultura importante para identificar a espécie. O tratamento é prolongado e frequentemente combina antifúngicos sistêmicos (como itraconazol ou terbinafina) com métodos físicos, como crioterapia, termoterapia ou cirurgia.', 'A celulite é uma infecção bacteriana da derme profunda e do tecido celular subcutâneo, causada principalmente por Streptococcus pyogenes e Staphylococcus aureus.',
        'Celulite = derme profunda + tecido subcutâneo.
Tratamento → antibiótico sistêmico (nunca apenas tópico).
Repouso + elevação do membro + analgesia são medidas importantes.
Corticoterapia pode ser adjuvante em casos selecionados.
Celulite facial é mais comum em crianças.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '5e6288e6-cb41-5ed5-9c95-3dff577a256d'::uuid, '8f3c13c0-6783-55fa-8446-346b1813ad3e'::uuid,
        'A', 'A celulite é facial é mais comum em crianças', 'Incorreta. A celulite facial realmente é mais frequente em crianças, principalmente devido à maior incidência de infecções de vias aéreas superiores, sinusites e traumatismos faciais nessa faixa etária.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '909881fd-9700-5740-ad2b-41399b3ec480'::uuid, '8f3c13c0-6783-55fa-8446-346b1813ad3e'::uuid,
        'B', 'São raras as complicações e quando presentes mais comuns em crianças e imunodeprimidos', 'Incorreta. As complicações da celulite são incomuns, porém podem ocorrer com maior frequência em crianças, idosos, diabéticos e pacientes imunossuprimidos, podendo evoluir para abscessos, fasciíte necrosante, bacteremia e sepse.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'd3e1ab1b-a3be-56d6-bf90-62605d367125'::uuid, '8f3c13c0-6783-55fa-8446-346b1813ad3e'::uuid,
        'C', 'Na terapêutica é fundamental o repouso, antibioticoterapia tópica e analgesia', 'Correta. A celulite acomete a derme profunda e o tecido celular subcutâneo, necessitando de antibioticoterapia sistêmica, e não tópica. O tratamento inclui repouso, analgesia, elevação do membro acometido e antibióticos por via oral ou intravenosa, conforme a gravidade.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '2ea0546d-6d49-5e7f-a5ce-4de3d572d93a'::uuid, '8f3c13c0-6783-55fa-8446-346b1813ad3e'::uuid,
        'D', 'Pode-se utilizar corticoterapia como terapia coadjuvante nos casos exuberantes ou com pouca resposta à antibioticoterapia', 'Incorreta. Em pacientes selecionados, a corticoterapia pode ser utilizada como terapia adjuvante, sempre associada à antibioticoterapia adequada, contribuindo para redução do processo inflamatório e resolução mais rápida do quadro.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 016 | Turma 116 -T1
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        'a4cec8bf-b746-5f78-840b-4ca9807a6c53'::uuid, v_discipline_id, NULL, 'médio',
        'Em relação às foliculites, é incorreto afirmar:', 'single',
        'B', ARRAY[]::text[],
        'A foliculite decalvante é uma dermatose inflamatória crônica do couro cabeludo, provavelmente relacionada a uma resposta imunológica anormal ao Staphylococcus aureus. Caracteriza-se por pústulas foliculares recorrentes, crostas, eritema, politríquia e evolução para alopecia cicatricial. O tratamento é difícil, frequentemente exigindo antibioticoterapia prolongada (como rifampicina associada à clindamicina, tetraciclinas ou outros esquemas), podendo ser associados dapsona, isotretinoína ou imunomoduladores em casos refratários. A resposta costuma ser lenta, com elevado índice de recidiva, tornando essa uma das principais características cobradas em provas de Dermatologia.
Em relação à esporotricose, é correto:
A forma cutaneolinfática é a mais comum, corresponde a cerca de 55% dos casos
Justificativa: Incorreta. A forma cutaneolinfática é realmente a mais frequente, porém corresponde a aproximadamente 70–80% dos casos, e não a cerca de 55%.
A forma cutânea localizada de aspecto verrucoso faz diagnóstico diferencial com paracoccidioidomicose, leishmaniose, cromomicose mas não tuberculose
Justificativa: Incorreta. A forma cutânea localizada de aspecto verrucoso também faz diagnóstico diferencial com tuberculose cutânea, além de paracoccidioidomicose, leishmaniose e cromoblastomicose.
Pode-se empregar o itraconazol como tratamento de escolha assim como o iodeto de potássio, o fluconazol, a terbinafina
Justificativa: Correta. O itraconazol é o tratamento de primeira escolha da esporotricose cutânea. A solução saturada de iodeto de potássio permanece como alternativa clássica, enquanto terbinafina e fluconazol podem ser utilizados em situações específicas, embora este último apresente menor eficácia.
Na histopatologia, encontra-se os corpos fumagóides
Justificativa: Incorreta. Os corpos fumagóides (ou corpos escleróticos/Medlar) são característicos da cromoblastomicose, e não da esporotricose. Na esporotricose, o exame histopatológico pode evidenciar reação granulomatosa e, ocasionalmente, corpos asteroides.
🧠 Dica de memorização
Esporotricose → conídios em "margarida" (cultura).
Corpos fumagoides → cromoblastomicose.
Forma mais comum → cutaneolinfática (≈70–80%).
Tratamento de escolha → itraconazol.
Iodeto de potássio → alternativa clássica por via oral.
📚 Explicação geral
A esporotricose é uma micose subcutânea causada por fungos do complexo Sporothrix, adquirida principalmente por inoculação traumática através de espinhos, vegetação ou contato com gatos infectados. A forma cutaneolinfática representa cerca de 70–80% dos casos, caracterizando-se por nódulos que ulceram e se distribuem ao longo dos vasos linfáticos ("rosário linfático"). O itraconazol é o tratamento de primeira escolha, enquanto a solução saturada de iodeto de potássio permanece uma alternativa eficaz. Casos graves, disseminados ou viscerais podem necessitar de anfotericina B. O diagnóstico diferencial inclui leishmaniose tegumentar, cromoblastomicose, tuberculose cutânea e paracoccidioidomicose.
Em relação à cromomicose, é incorreto:
É encontrada em regiões tropicais e subtropicais
Justificativa: Incorreta. A cromoblastomicose é uma micose subcutânea de distribuição predominante em regiões tropicais e subtropicais, incluindo o Brasil.
O número de casos de registro inter-humano vem aumentando, mas não é a forma mais comum de transmissão
Justificativa: Correta (é a resposta da questão). A cromoblastomicose não apresenta transmissão inter-humana. A infecção ocorre por inoculação traumática de fungos demáceos presentes no solo, madeira e vegetação. Portanto, afirmar que os casos de transmissão entre pessoas vêm aumentando é incorreto.
No Brasil, a Fonsecaea pedrosoi é a espécie mais frequente
Justificativa: Incorreta. Fonsecaea pedrosoi é o principal agente etiológico da cromoblastomicose no Brasil.
A identificação das espécies é realizada exclusivamente por meio de cultura
Justificativa: Incorreta. A identificação definitiva da espécie é feita pela cultura, porém o diagnóstico da cromoblastomicose pode ser sugerido pelo exame micológico direto e pela histopatologia, que evidenciam os corpos fumagoides (corpos escleróticos ou de Medlar). Portanto, não depende exclusivamente da cultura para o diagnóstico da doença.
🧠 Dica de memorização
Trauma + madeira + solo → cromoblastomicose.
Não existe transmissão pessoa a pessoa.
Fonsecaea pedrosoi → principal agente no Brasil.
Corpos fumagoides = marca registrada da cromoblastomicose.
Diagnóstico → exame direto, histopatologia e cultura.
📚 Explicação geral
A cromoblastomicose é uma micose subcutânea crônica causada por fungos demáceos, adquirida por inoculação traumática durante atividades rurais. O principal agente no Brasil é Fonsecaea pedrosoi. Clinicamente, manifesta-se por lesões verrucosas de crescimento lento, principalmente nos membros inferiores. O diagnóstico é sugerido pela presença de corpos fumagoides no exame micológico direto ou na histopatologia, sendo a cultura importante para identificar a espécie. O tratamento é prolongado e frequentemente combina antifúngicos sistêmicos (como itraconazol ou terbinafina) com métodos físicos, como crioterapia, termoterapia ou cirurgia.', 'A foliculite decalvante é uma dermatose inflamatória crônica do couro cabeludo, provavelmente relacionada a uma resposta imunológica anormal ao Staphylococcus aureus.',
        'Foliculite decalvante → Decalva = alopecia cicatricial.
Politríquia = vários fios saindo do mesmo óstio folicular.
Predomina em homens adultos.
Tratamento é prolongado e recorrências são frequentes.
Antibióticos são a base da terapêutica; dapsona pode ser utilizada em casos selecionados.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '4c8d9c48-46c6-5f55-926d-ab5081344fe6'::uuid, 'a4cec8bf-b746-5f78-840b-4ca9807a6c53'::uuid,
        'A', 'Na foliculite decalvante é de evolução crônica, pode causar fibrose e é mais comum nos homens adultos', 'Incorreta. A foliculite decalvante é uma foliculite crônica neutrofílica, predominante em homens adultos, podendo evoluir com fibrose e alopecia cicatricial.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '5cf526d3-804e-5eb2-8221-8ea909b5e607'::uuid, 'a4cec8bf-b746-5f78-840b-4ca9807a6c53'::uuid,
        'B', 'Tem resposta terapêutica rápida', 'Correta (é a resposta da questão). A foliculite decalvante apresenta evolução crônica, com frequentes recidivas e resposta terapêutica geralmente lenta e insatisfatória, exigindo tratamento prolongado.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '674fccbd-1899-563b-8cbb-01e8d1a0ca2f'::uuid, 'a4cec8bf-b746-5f78-840b-4ca9807a6c53'::uuid,
        'C', 'A terapêutica é feita com antibióticos e a dapsona pode ser útil', 'Incorreta. O tratamento baseia-se principalmente em antibióticos sistêmicos, podendo ser utilizada a dapsona em casos selecionados devido à sua ação anti-inflamatória.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '852794ff-6097-5cdb-a243-27435985d4f5'::uuid, 'a4cec8bf-b746-5f78-840b-4ca9807a6c53'::uuid,
        'D', 'Pode causar politriquia, ou seja, emergir vários fios da mesma abertura folicular', 'Incorreta. A politríquia (tufted hair folliculitis) é um achado característico da foliculite decalvante, resultante da destruição parcial dos folículos e da emergência de múltiplos fios por um mesmo óstio folicular.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 017 | Turma 116 -T1
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '448f884e-1b53-57fa-ac3a-2693b2893ddf'::uuid, v_discipline_id, NULL, 'médio',
        'Em relação à esporotricose, é correto:', 'single',
        'C', ARRAY[]::text[],
        'A esporotricose é uma micose subcutânea causada por fungos do complexo Sporothrix, adquirida principalmente por inoculação traumática através de espinhos, vegetação ou contato com gatos infectados. A forma cutaneolinfática representa cerca de 70–80% dos casos, caracterizando-se por nódulos que ulceram e se distribuem ao longo dos vasos linfáticos ("rosário linfático"). O itraconazol é o tratamento de primeira escolha, enquanto a solução saturada de iodeto de potássio permanece uma alternativa eficaz. Casos graves, disseminados ou viscerais podem necessitar de anfotericina B. O diagnóstico diferencial inclui leishmaniose tegumentar, cromoblastomicose, tuberculose cutânea e paracoccidioidomicose.
Em relação à cromomicose, é incorreto:
É encontrada em regiões tropicais e subtropicais
Justificativa: Incorreta. A cromoblastomicose é uma micose subcutânea de distribuição predominante em regiões tropicais e subtropicais, incluindo o Brasil.
O número de casos de registro inter-humano vem aumentando, mas não é a forma mais comum de transmissão
Justificativa: Correta (é a resposta da questão). A cromoblastomicose não apresenta transmissão inter-humana. A infecção ocorre por inoculação traumática de fungos demáceos presentes no solo, madeira e vegetação. Portanto, afirmar que os casos de transmissão entre pessoas vêm aumentando é incorreto.
No Brasil, a Fonsecaea pedrosoi é a espécie mais frequente
Justificativa: Incorreta. Fonsecaea pedrosoi é o principal agente etiológico da cromoblastomicose no Brasil.
A identificação das espécies é realizada exclusivamente por meio de cultura
Justificativa: Incorreta. A identificação definitiva da espécie é feita pela cultura, porém o diagnóstico da cromoblastomicose pode ser sugerido pelo exame micológico direto e pela histopatologia, que evidenciam os corpos fumagoides (corpos escleróticos ou de Medlar). Portanto, não depende exclusivamente da cultura para o diagnóstico da doença.
🧠 Dica de memorização
Trauma + madeira + solo → cromoblastomicose.
Não existe transmissão pessoa a pessoa.
Fonsecaea pedrosoi → principal agente no Brasil.
Corpos fumagoides = marca registrada da cromoblastomicose.
Diagnóstico → exame direto, histopatologia e cultura.
📚 Explicação geral
A cromoblastomicose é uma micose subcutânea crônica causada por fungos demáceos, adquirida por inoculação traumática durante atividades rurais. O principal agente no Brasil é Fonsecaea pedrosoi. Clinicamente, manifesta-se por lesões verrucosas de crescimento lento, principalmente nos membros inferiores. O diagnóstico é sugerido pela presença de corpos fumagoides no exame micológico direto ou na histopatologia, sendo a cultura importante para identificar a espécie. O tratamento é prolongado e frequentemente combina antifúngicos sistêmicos (como itraconazol ou terbinafina) com métodos físicos, como crioterapia, termoterapia ou cirurgia.', 'A esporotricose é uma micose subcutânea causada por fungos do complexo Sporothrix, adquirida principalmente por inoculação traumática através de espinhos, vegetação ou contato com gatos infectados.',
        'Esporotricose → conídios em "margarida" (cultura).
Corpos fumagoides → cromoblastomicose.
Forma mais comum → cutaneolinfática (≈70–80%).
Tratamento de escolha → itraconazol.
Iodeto de potássio → alternativa clássica por via oral.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'e67a8ce7-adae-5b57-9ccd-5c8d96e5ab7e'::uuid, '448f884e-1b53-57fa-ac3a-2693b2893ddf'::uuid,
        'A', 'A forma cutaneolinfática é a mais comum, corresponde a cerca de 55% dos casos', 'Incorreta. A forma cutaneolinfática é realmente a mais frequente, porém corresponde a aproximadamente 70–80% dos casos, e não a cerca de 55%.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '091fc6cc-1c66-5835-969e-f3bb23b2c3b2'::uuid, '448f884e-1b53-57fa-ac3a-2693b2893ddf'::uuid,
        'B', 'A forma cutânea localizada de aspecto verrucoso faz diagnóstico diferencial com paracoccidioidomicose, leishmaniose, cromomicose mas não tuberculose', 'Incorreta. A forma cutânea localizada de aspecto verrucoso também faz diagnóstico diferencial com tuberculose cutânea, além de paracoccidioidomicose, leishmaniose e cromoblastomicose.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '0c53c630-be78-5bb6-bd97-8f043cc06355'::uuid, '448f884e-1b53-57fa-ac3a-2693b2893ddf'::uuid,
        'C', 'Pode-se empregar o itraconazol como tratamento de escolha assim como o iodeto de potássio, o fluconazol, a terbinafina', 'Correta. O itraconazol é o tratamento de primeira escolha da esporotricose cutânea. A solução saturada de iodeto de potássio permanece como alternativa clássica, enquanto terbinafina e fluconazol podem ser utilizados em situações específicas, embora este último apresente menor eficácia.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '8136b281-f61f-5410-917d-a6650e659e02'::uuid, '448f884e-1b53-57fa-ac3a-2693b2893ddf'::uuid,
        'D', 'Na histopatologia, encontra-se os corpos fumagóides', 'Incorreta. Os corpos fumagóides (ou corpos escleróticos/Medlar) são característicos da cromoblastomicose, e não da esporotricose. Na esporotricose, o exame histopatológico pode evidenciar reação granulomatosa e, ocasionalmente, corpos asteroides.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 018 | Turma 116 -T1
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        'aef168d5-ed90-5eab-9323-f550b2cbe1a2'::uuid, v_discipline_id, NULL, 'médio',
        'Em relação à cromomicose, é incorreto:', 'single',
        'B', ARRAY[]::text[],
        'A cromoblastomicose é uma micose subcutânea crônica causada por fungos demáceos, adquirida por inoculação traumática durante atividades rurais. O principal agente no Brasil é Fonsecaea pedrosoi. Clinicamente, manifesta-se por lesões verrucosas de crescimento lento, principalmente nos membros inferiores. O diagnóstico é sugerido pela presença de corpos fumagoides no exame micológico direto ou na histopatologia, sendo a cultura importante para identificar a espécie. O tratamento é prolongado e frequentemente combina antifúngicos sistêmicos (como itraconazol ou terbinafina) com métodos físicos, como crioterapia, termoterapia ou cirurgia.', 'A cromoblastomicose é uma micose subcutânea crônica causada por fungos demáceos, adquirida por inoculação traumática durante atividades rurais.',
        'Trauma + madeira + solo → cromoblastomicose.
Não existe transmissão pessoa a pessoa.
Fonsecaea pedrosoi → principal agente no Brasil.
Corpos fumagoides = marca registrada da cromoblastomicose.
Diagnóstico → exame direto, histopatologia e cultura.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '1fd395a9-046e-5566-9078-a6dab3eb6d9c'::uuid, 'aef168d5-ed90-5eab-9323-f550b2cbe1a2'::uuid,
        'A', 'É encontrada em regiões tropicais e subtropicais', 'Incorreta. A cromoblastomicose é uma micose subcutânea de distribuição predominante em regiões tropicais e subtropicais, incluindo o Brasil.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '0198572a-cfc3-5a04-8ad2-5ccf6eed4c29'::uuid, 'aef168d5-ed90-5eab-9323-f550b2cbe1a2'::uuid,
        'B', 'O número de casos de registro inter-humano vem aumentando, mas não é a forma mais comum de transmissão', 'Correta (é a resposta da questão). A cromoblastomicose não apresenta transmissão inter-humana. A infecção ocorre por inoculação traumática de fungos demáceos presentes no solo, madeira e vegetação. Portanto, afirmar que os casos de transmissão entre pessoas vêm aumentando é incorreto.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'd8136f09-4d2f-5f0e-8a81-fa530e87700d'::uuid, 'aef168d5-ed90-5eab-9323-f550b2cbe1a2'::uuid,
        'C', 'No Brasil, a Fonsecaea pedrosoi é a espécie mais frequente', 'Incorreta. Fonsecaea pedrosoi é o principal agente etiológico da cromoblastomicose no Brasil.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'a760716d-d729-5ac7-a71c-6600e249ecac'::uuid, 'aef168d5-ed90-5eab-9323-f550b2cbe1a2'::uuid,
        'D', 'A identificação das espécies é realizada exclusivamente por meio de cultura', 'Incorreta. A identificação definitiva da espécie é feita pela cultura, porém o diagnóstico da cromoblastomicose pode ser sugerido pelo exame micológico direto e pela histopatologia, que evidenciam os corpos fumagoides (corpos escleróticos ou de Medlar). Portanto, não depende exclusivamente da cultura para o diagnóstico da doença.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 019 | Turma 116 -T1
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '46048e4a-5d9c-5b3b-b713-e75c41feb79c'::uuid, v_discipline_id, NULL, 'médio',
        'Em relação à escabiose, é incorreto:', 'single',
        'D', ARRAY[]::text[],
        'A escabiose é uma ectoparasitose causada pelo ácaro Sarcoptes scabiei var. hominis. A transmissão ocorre principalmente por contato corporal direto e prolongado. A lesão característica é o sulco escabiótico, frequentemente acompanhado por pápula ou vesícula em uma das extremidades. O prurido costuma ser intenso e pior à noite. Apesar de ser mais frequente em locais com aglomeração e condições socioeconômicas desfavoráveis, a doença ocorre mundialmente.', 'A escabiose é uma ectoparasitose causada pelo ácaro Sarcoptes scabiei var.',
        'Escabiose = doença cosmopolita.
Pode acometer qualquer idade.
A fêmea escava o sulco e deposita os ovos.
Prurido intenso, sobretudo à noite.
Prurido = hipersensibilidade + irritação mecânica.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'c60237f0-1df4-59a0-9f83-135d2171f80b'::uuid, '46048e4a-5d9c-5b3b-b713-e75c41feb79c'::uuid,
        'A', 'Incide em todas as idades', 'Incorreta. A afirmação é verdadeira. A escabiose pode acometer pessoas de qualquer idade, embora seja mais frequente em ambientes com contato próximo e aglomeração.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '9743a7f6-375c-5acf-9fe7-b82be3b954d8'::uuid, '46048e4a-5d9c-5b3b-b713-e75c41feb79c'::uuid,
        'B', 'É produzida exclusivamente pela fêmea', 'Incorreta. A afirmação é verdadeira. A fêmea fecundada do Sarcoptes scabiei escava túneis na camada córnea, deposita ovos e é responsável pelas lesões típicas da doença.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '3c739218-2fa5-5a93-922a-cd8056401a30'::uuid, '46048e4a-5d9c-5b3b-b713-e75c41feb79c'::uuid,
        'C', 'O prurido se dá por dois mecanismos: alérgico e o mecânico', 'Incorreta. A afirmação é verdadeira. O prurido decorre principalmente de reação de hipersensibilidade ao ácaro, ovos e fezes, além da irritação mecânica causada pela movimentação do parasito na pele.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'c7735e66-b7fb-532f-9b72-a165effebe5a'::uuid, '46048e4a-5d9c-5b3b-b713-e75c41feb79c'::uuid,
        'D', 'É uma dermatozoonose de regiões tropicais e subtropicais', 'Correta. A escabiose tem distribuição cosmopolita, ocorrendo em todas as regiões do mundo, e não apenas em áreas tropicais e subtropicais.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 020 | Turma 116 -T1
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        'a4899cfa-111c-516a-9f7c-8277fa8b15e6'::uuid, v_discipline_id, NULL, 'médio',
        'Em relação à larva migrans, é incorreto:', 'single',
        'C', ARRAY[]::text[],
        'A larva migrans cutânea é uma dermatozoonose causada pela penetração na pele de larvas de ancilostomídeos de cães e gatos, principalmente Ancylostoma braziliense e A. caninum. O homem é hospedeiro acidental, e as larvas permanecem confinadas à epiderme, formando trajetos serpiginosos intensamente pruriginosos. Como não há invasão sistêmica, eosinofilia significativa é incomum. O tratamento é realizado preferencialmente com albendazol (400 mg/dia por 3 dias) ou ivermectina em dose única, associados a medidas para controle do prurido quando necessário.', 'A larva migrans cutânea é uma dermatozoonose causada pela penetração na pele de larvas de ancilostomídeos de cães e gatos, principalmente Ancylostoma braziliense e A.',
        'Larva migrans = "bicho geográfico".
Agentes principais → Ancylostoma braziliense e A. caninum.
Distribuição → cosmopolita, predominando em regiões tropicais.
Eosinofilia importante → não é comum.
Tratamento → albendazol ou ivermectina.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '077d3c6b-54aa-52cb-8f63-762eb9e6faa8'::uuid, 'a4899cfa-111c-516a-9f7c-8277fa8b15e6'::uuid,
        'A', 'É cosmopolita', 'Incorreta. A larva migrans cutânea possui distribuição cosmopolita, sendo mais frequente em regiões tropicais e subtropicais, onde as condições climáticas favorecem a sobrevivência das larvas.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '10663479-2ca1-5001-944e-de3858ee0220'::uuid, 'a4899cfa-111c-516a-9f7c-8277fa8b15e6'::uuid,
        'B', 'O agente etiológico é Ancylostoma caninum', 'Incorreta. A afirmação é verdadeira. A larva migrans cutânea é causada principalmente por Ancylostoma braziliense e Ancylostoma caninum, parasitas de cães e gatos.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '743ded67-75c1-5e49-9ae1-dc47b6947dc0'::uuid, 'a4899cfa-111c-516a-9f7c-8277fa8b15e6'::uuid,
        'C', 'A eosinofilia elevada é comum', 'Correta. A eosinofilia geralmente é ausente ou discreta, pois a infecção permanece restrita à pele. Eosinofilia elevada é incomum e, quando presente, sugere outras formas de helmintíase ou comprometimento sistêmico.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'a7432ddb-d237-5483-8f05-7daa45c35e9a'::uuid, 'a4899cfa-111c-516a-9f7c-8277fa8b15e6'::uuid,
        'D', 'Como opção de tratamento temos: albendazol 400 mg por 3 dias.', 'Incorreta. O albendazol 400 mg/dia por 3 dias é um dos esquemas terapêuticos recomendados para larva migrans cutânea. Outra opção eficaz é a ivermectina em dose única.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 021 | Turma 116 -T1
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '0e13fb50-06d9-56e4-8093-878fad500cb2'::uuid, v_discipline_id, NULL, 'médio',
        'Em relação ao tratamento da acne, é incorreta:', 'single',
        'C', ARRAY[]::text[],
        'O tratamento da acne deve ser individualizado conforme a gravidade. Os retinoides tópicos (adapaleno, tretinoína), o peróxido de benzoíla e o ácido salicílico são os principais medicamentos tópicos. Nas formas inflamatórias moderadas a graves, podem ser utilizados antibióticos sistêmicos, como doxiciclina, minociclina e limeciclina, sempre por tempo limitado e associados ao tratamento tópico. A isotretinoína oral é indicada para acne nodulocística, conglobata ou resistente. Os peelings químicos podem ser empregados como terapia adjuvante tanto na acne ativa quanto no tratamento das sequelas, como hiperpigmentação e cicatrizes superficiais.', 'O tratamento da acne deve ser individualizado conforme a gravidade.',
        'Acne leve → tratamento tópico.
Acne moderada/grave → pode necessitar de antibióticos sistêmicos ou isotretinoína.
Peelings químicos → ajudam na acne ativa e nas cicatrizes.
Nunca utilizar antibiótico tópico isoladamente.
Peróxido de benzoíla reduz resistência bacteriana.', 'Atenção ao comando: deve-se marcar a alternativa incorreta ou a exceção.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '981c8722-1d89-50f5-a71e-07fdfb35e724'::uuid, '0e13fb50-06d9-56e4-8093-878fad500cb2'::uuid,
        'A', 'Pode ser feito tratamento sistêmico como limeciclina, doxiciclina e minociclinas.', 'Incorreta. As tetraciclinas (limeciclina, doxiciclina e minociclina) são amplamente utilizadas no tratamento sistêmico da acne inflamatória moderada a grave.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '387d06d2-e359-5d87-bd97-385a718af958'::uuid, '0e13fb50-06d9-56e4-8093-878fad500cb2'::uuid,
        'B', 'No tratamento local, podemos usar ácido salicílico, adapaleno, peróxido de benzoíla.', 'Incorreta. Esses medicamentos constituem a base do tratamento tópico da acne, atuando sobre a hiperqueratinização, inflamação e proliferação de Cutibacterium acnes.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'dac77e6f-9ac0-5275-a2b1-9f58a5b7f980'::uuid, '0e13fb50-06d9-56e4-8093-878fad500cb2'::uuid,
        'C', 'Os peelings químicos não são indicados para acne, apenas para cicatrizes.', 'Correta. Os peelings químicos podem ser indicados tanto para acne ativa, principalmente a comedoniana e papulopustulosa leve, quanto para o tratamento de hiperpigmentação pós-inflamatória e cicatrizes superficiais.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '0dca197a-6193-517d-b84a-08655369cd96'::uuid, '0e13fb50-06d9-56e4-8093-878fad500cb2'::uuid,
        'D', 'A monoterapia com antibióticos tópicos deve ser evitada.', 'Incorreta. O uso isolado de antibióticos tópicos favorece resistência bacteriana. Recomenda-se associá-los ao peróxido de benzoíla e/ou retinóides tópicos.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 022 | Turma 116 -T1
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '6be6b5e5-ce91-5ff6-9372-773e6803b444'::uuid, v_discipline_id, NULL, 'médio',
        'AMM, 72 anos, diabético, adinamia, refere dor de moderada intensidade, dolorosas, as lesões se iniciaram 3 dias, na região intercostal, obedecendo um dermátomo, sobre o caso clínico, Qual o diagnóstico etiológico?', 'single',
        'D', ARRAY[]::text[],
        'O herpes-zóster resulta da reativação do vírus Varicella-zoster (VZV), que permanece latente nos gânglios sensitivos após a infecção primária (varicela). O quadro clínico caracteriza-se por dor neuropática, seguida do surgimento de vesículas agrupadas sobre base eritematosa, distribuídas de forma unilateral ao longo de um dermátomo. O diagnóstico é predominantemente clínico, e o tratamento com antivirais (aciclovir, valaciclovir ou fanciclovir) deve ser iniciado preferencialmente nas primeiras 72 horas, reduzindo a duração da doença e o risco de complicações.', 'O herpes-zóster resulta da reativação do vírus Varicella-zoster (VZV), que permanece latente nos gânglios sensitivos após a infecção primária (varicela).',
        'Dor → Vesículas → Dermátomo = tríade clássica do herpes-zóster.
VZV reativado = vírus da varicela que permanece latente nos gânglios sensitivos.
Unilateral e não ultrapassa a linha média.
Idosos, diabéticos e imunossuprimidos apresentam maior risco.
Até 72 horas → iniciar antiviral precocemente.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '589441bb-70c4-53fd-bb62-7ea80ca32e9a'::uuid, '6be6b5e5-ce91-5ff6-9372-773e6803b444'::uuid,
        'A', 'Herpes simples → infecção recorrente por HSV-1 ou HSV-2, geralmente acometendo mucosas ou região perioral/genital.', 'Incorreta. O herpes simples apresenta lesões vesiculares agrupadas, porém não costuma seguir distribuição dermatomérica nem cursar com dor neurítica intensa como no herpes-zóster.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '81adaed6-714d-579d-9dc1-ba8e6e003c02'::uuid, '6be6b5e5-ce91-5ff6-9372-773e6803b444'::uuid,
        'B', 'Erisipela → infecção bacteriana da derme superficial, caracterizada por placa eritematosa bem delimitada.', 'Incorreta. A erisipela manifesta-se com placa eritematosa, quente e dolorosa, sem vesículas agrupadas em dermátomo.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '42b346a2-6f8a-53f7-9049-4782287f2b62'::uuid, '6be6b5e5-ce91-5ff6-9372-773e6803b444'::uuid,
        'C', 'Dermatite de contato → reação inflamatória desencadeada por irritantes ou alérgenos.', 'Incorreta. A dermatite de contato costuma provocar prurido e lesões eczematosas relacionadas ao contato com determinada substância, não respeitando dermátomos.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '5ad4028c-bc4d-5af2-a712-34f63207bf66'::uuid, '6be6b5e5-ce91-5ff6-9372-773e6803b444'::uuid,
        'D', 'Herpes-zóster → reativação do vírus Varicella-zoster, caracterizada por dor e vesículas distribuídas ao longo de um dermátomo.', 'Correta. O quadro de dor precedendo ou acompanhando lesões vesiculares unilaterais que respeitam um dermátomo é típico do herpes-zóster, especialmente em idosos e imunossuprimidos.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 023 | Turma 116 -T1
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '101562b4-281c-556d-88b9-2cc6277e778d'::uuid, v_discipline_id, NULL, 'médio',
        'AMM, 72 anos, diabético, adinamia, refere dor de moderada intensidade, dolorosas, as lesões se iniciaram 3 dias, na região intercostal, obedecendo um dermátomo, sobre o caso clínico, Se houver complicações, citar 1 neste caso.', 'single',
        'A', ARRAY[]::text[],
        'A neuralgia pós-herpética é a principal complicação do herpes-zóster e caracteriza-se pela persistência da dor neuropática após a resolução das lesões cutâneas, geralmente por mais de 90 dias. É mais comum em idosos, imunossuprimidos e pacientes que apresentaram dor intensa ou lesões extensas na fase aguda. O tratamento pode incluir gabapentina, pregabalina, antidepressivos tricíclicos e analgésicos, enquanto o uso precoce de antivirais ajuda a reduzir sua incidência.
Turma 116 -T2
Em relação ao impetigo, é incorreta:
É mais frequente em crianças.
Justificativa: Incorreta. O impetigo é a piodermite superficial mais frequente da infância, acometendo principalmente crianças em idade pré-escolar e escolar.
A forma clínica mais comum é impetigo não bolhoso;
Justificativa: Incorreta. O impetigo não bolhoso representa cerca de 70% dos casos e pode ser causado por Staphylococcus aureus e Streptococcus pyogenes.
Ocorre, inicialmente, mácula eritematosa que evolui lentamente para bolha e/ou vesículas que se rompem facilmente;
Justificativa: Correta. O impetigo não evolui lentamente. Na forma não bolhosa, as lesões evoluem rapidamente de máculas ou pápulas para vesículas ou pústulas, formando crostas melicéricas. Na forma bolhosa, surgem bolhas flácidas diretamente pela ação das toxinas estafilocócicas.
Ocorre em locais de pequenos traumatismos como escoriações, queimaduras ou picadas de inseto.
Justificativa: Incorreta. Pequenos traumatismos favorecem a inoculação bacteriana e o desenvolvimento do impetigo, sendo comum seu aparecimento sobre escoriações, picadas de insetos e queimaduras.
🧠 Dica de memorização
Impetigo não bolhoso = 70% dos casos.
Crosta melicérica = lesão clássica.
S. aureus e S. pyogenes = principais agentes.
Pequenos traumatismos favorecem o aparecimento.
Não há evolução lenta das lesões.
📚 Explicação geral
O impetigo é uma piodermite superficial altamente contagiosa, predominante em crianças. A forma não bolhosa é a mais frequente e caracteriza-se por vesículas ou pústulas que se rompem rapidamente, originando crostas melicéricas. Já a forma bolhosa é causada por Staphylococcus aureus produtor de toxinas esfoliativas, formando bolhas flácidas. As lesões costumam surgir sobre áreas de pequenos traumatismos e podem disseminar-se por autoinoculação.', 'A neuralgia pós-herpética é a principal complicação do herpes-zóster e caracteriza-se pela persistência da dor neuropática após a resolução das lesões cutâneas, geralmente por mais de 90 dias.',
        'Idoso + Herpes-zóster = pense em neuralgia pós-herpética.
É a complicação mais frequente da doença.
Define-se por dor persistente após a cicatrização das lesões, geralmente por mais de 90 dias.
Quanto maior a idade e mais intenso o quadro inicial, maior o risco.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '5d596063-a6aa-56e8-a07f-22b3bc9a98de'::uuid, '101562b4-281c-556d-88b9-2cc6277e778d'::uuid,
        'A', 'A) Neuralgia pós-herpética → dor persistente após resolução das lesões cutâneas.', 'Correta . É a complicação mais frequente do herpes-zóster, especialmente em idosos, podendo persistir por meses ou anos.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'de46ca81-7988-5796-9c8b-800f4c2e3fc1'::uuid, '101562b4-281c-556d-88b9-2cc6277e778d'::uuid,
        'B', 'Glomerulonefrite pós-estreptocócica → complicação imunológica de infecções estreptocócicas.', 'Incorreta. Está relacionada principalmente ao impetigo e à faringite estreptocócica, não ao herpes-zóster.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'd667405a-ceb6-571e-9ce3-7b0362c2669c'::uuid, '101562b4-281c-556d-88b9-2cc6277e778d'::uuid,
        'C', 'Eritema nodoso → paniculite inflamatória associada a diversas doenças infecciosas e inflamatórias.', 'Incorreta. Não representa complicação típica do herpes-zóster.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '47894ebc-0bfa-5af5-af87-5a2cdc48c994'::uuid, '101562b4-281c-556d-88b9-2cc6277e778d'::uuid,
        'D', 'Linfedema crônico → comprometimento permanente da drenagem linfática.', 'Incorreta. Não é uma complicação habitual do herpes-zóster.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 024 | Turma 116 -T2
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        'c60738de-94a2-528d-acf4-6f2424ab43d4'::uuid, v_discipline_id, NULL, 'médio',
        'Em relação ao impetigo, é incorreta:', 'single',
        'C', ARRAY[]::text[],
        'O impetigo é uma piodermite superficial altamente contagiosa, predominante em crianças. A forma não bolhosa é a mais frequente e caracteriza-se por vesículas ou pústulas que se rompem rapidamente, originando crostas melicéricas. Já a forma bolhosa é causada por Staphylococcus aureus produtor de toxinas esfoliativas, formando bolhas flácidas. As lesões costumam surgir sobre áreas de pequenos traumatismos e podem disseminar-se por autoinoculação.', 'O impetigo é uma piodermite superficial altamente contagiosa, predominante em crianças.',
        'Impetigo não bolhoso = 70% dos casos.
Crosta melicérica = lesão clássica.
S. aureus e S. pyogenes = principais agentes.
Pequenos traumatismos favorecem o aparecimento.
Não há evolução lenta das lesões.', 'Atenção ao comando: deve-se marcar a alternativa incorreta ou a exceção.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '543e44d2-7114-5e9f-b964-1cbba1b07282'::uuid, 'c60738de-94a2-528d-acf4-6f2424ab43d4'::uuid,
        'A', 'É mais frequente em crianças.', 'Incorreta. O impetigo é a piodermite superficial mais frequente da infância, acometendo principalmente crianças em idade pré-escolar e escolar.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '9295e250-1e9c-5ef7-8865-b5818e87225c'::uuid, 'c60738de-94a2-528d-acf4-6f2424ab43d4'::uuid,
        'B', 'A forma clínica mais comum é impetigo não bolhoso;', 'Incorreta. O impetigo não bolhoso representa cerca de 70% dos casos e pode ser causado por Staphylococcus aureus e Streptococcus pyogenes.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'bba9685d-8731-5e56-a525-a0c8fb703181'::uuid, 'c60738de-94a2-528d-acf4-6f2424ab43d4'::uuid,
        'C', 'Ocorre, inicialmente, mácula eritematosa que evolui lentamente para bolha e/ou vesículas que se rompem facilmente;', 'Correta. O impetigo não evolui lentamente. Na forma não bolhosa, as lesões evoluem rapidamente de máculas ou pápulas para vesículas ou pústulas, formando crostas melicéricas. Na forma bolhosa, surgem bolhas flácidas diretamente pela ação das toxinas estafilocócicas.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '57475fc2-9d28-5ad5-9d47-96a86bd92c96'::uuid, 'c60738de-94a2-528d-acf4-6f2424ab43d4'::uuid,
        'D', 'Ocorre em locais de pequenos traumatismos como escoriações, queimaduras ou picadas de inseto.', 'Incorreta. Pequenos traumatismos favorecem a inoculação bacteriana e o desenvolvimento do impetigo, sendo comum seu aparecimento sobre escoriações, picadas de insetos e queimaduras.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 025 | Turma 116 -T2
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '40edf7a9-c784-5368-a8a2-8f8f239a5a5c'::uuid, v_discipline_id, NULL, 'médio',
        'Sobre a Síndrome da Pele Escaldada Estafilocócica (SSSS), é incorreta:', 'single',
        'B', ARRAY[]::text[],
        'A Síndrome da Pele Escaldada Estafilocócica (SSSS) é causada por cepas de Staphylococcus aureus produtoras das toxinas esfoliativas A e B, que degradam a desmogleína 1, promovendo clivagem intraepidérmica na camada granulosa. O quadro ocorre principalmente em lactentes e crianças pequenas devido à imaturidade da depuração renal das toxinas. Clinicamente, manifesta-se com eritema difuso, formação de bolhas flácidas, sinal de Nikolsky positivo e extensa descamação cutânea, com preservação das mucosas. O tratamento consiste em antibioticoterapia sistêmica antiestafilocócica e medidas de suporte. O principal diagnóstico diferencial é a necrólise epidérmica tóxica (NET).', 'A Síndrome da Pele Escaldada Estafilocócica (SSSS) é causada por cepas de Staphylococcus aureus produtoras das toxinas esfoliativas A e B, que degradam a desmogleína 1, promovendo clivagem intraepidérmica na camada granulosa.',
        'SSSS = criança + S. aureus + toxinas ETA/ETB.
Desmogleína 1 → clivagem na camada granulosa.
Mucosas preservadas (diferente da NET).
Adulto acometido = doença rara, porém com alta mortalidade.', 'Atenção ao comando: deve-se marcar a alternativa incorreta ou a exceção.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '19fe19cb-2811-5221-a593-310a50504ca8'::uuid, '40edf7a9-c784-5368-a8a2-8f8f239a5a5c'::uuid,
        'A', 'É causada pelo Staphylococcus aureus do grupo 2', 'Incorreta. A SSSS é causada por cepas de Staphylococcus aureus produtoras das toxinas esfoliativas A e B, tradicionalmente pertencentes ao grupo fágico II.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '6aaf5082-1f31-5e34-937f-360a06b9e35f'::uuid, '40edf7a9-c784-5368-a8a2-8f8f239a5a5c'::uuid,
        'B', 'É comum tanto em adultos como em crianças, quando acomete adultos a mortalidade pode chegar a 100%', 'Correta. A SSSS é muito mais frequente em crianças, especialmente lactentes. Em adultos é rara, porém apresenta elevada mortalidade, podendo aproximar-se de 60–100%, principalmente em imunossuprimidos e pacientes com insuficiência renal.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'f7aa8bdd-d3e0-5f69-a81e-6c3cc7719b83'::uuid, '40edf7a9-c784-5368-a8a2-8f8f239a5a5c'::uuid,
        'C', 'A toxina esfoliativa A e toxina esfoliativa B fazem parte da etiopatogenia', 'Incorreta. As toxinas esfoliativas A (ETA) e B (ETB) produzidas pelo S. aureus promovem clivagem da desmogleína 1, levando ao descolamento intraepidérmico característico da doença.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'c280b422-fc4d-541c-b877-6b6a473536bc'::uuid, '40edf7a9-c784-5368-a8a2-8f8f239a5a5c'::uuid,
        'D', 'Tem como diagnóstico diferencial a necrólise epidérmica tóxica (NET).', 'Incorreta. A necrólise epidérmica tóxica é um dos principais diagnósticos diferenciais da SSSS, embora apresente acometimento de mucosas e clivagem em plano diferente da epiderme.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 026 | Turma 116 -T2
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '965e02b4-2573-53a8-8d73-f6b4db2d16f7'::uuid, v_discipline_id, NULL, 'médio',
        'Em relação à erisipela, é correto:', 'single',
        'D', ARRAY[]::text[],
        'A erisipela é uma infecção bacteriana aguda da derme superficial e dos vasos linfáticos, causada principalmente pelo Streptococcus pyogenes. Clinicamente, apresenta placa eritematosa, quente, dolorosa, brilhante e bem delimitada, frequentemente acompanhada de febre e mal-estar. As formas bolhosas e a localização facial estão associadas a maior gravidade e maior risco de complicações. O tratamento baseia-se em antibioticoterapia sistêmica, preferencialmente com penicilinas ou cefalosporinas, além de repouso, elevação do membro acometido e analgesia.', 'A erisipela é uma infecção bacteriana aguda da derme superficial e dos vasos linfáticos, causada principalmente pelo Streptococcus pyogenes.',
        'Erisipela = estreptococo (S. pyogenes).
Lesão elevada, brilhante e bem delimitada.
Forma bolhosa = maior gravidade.
Face = localização de maior risco.
Celulite = bordas mal definidas; Erisipela = bordas bem definidas.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'b00a2e3d-064e-51d1-a3c7-49be4074319e'::uuid, '965e02b4-2573-53a8-8d73-f6b4db2d16f7'::uuid,
        'A', 'O agente etiológico é predominantemente estafilocócico', 'Incorreta. O principal agente etiológico da erisipela é o Streptococcus pyogenes (estreptococo β-hemolítico do grupo A). O Staphylococcus aureus está mais relacionado à celulite e às piodermites.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '4bacabf4-8994-5521-a42f-7eeaa8ed6280'::uuid, '965e02b4-2573-53a8-8d73-f6b4db2d16f7'::uuid,
        'B', 'O estreptococo se estabelece secundariamente', 'Incorreta. O estreptococo é o agente primário da erisipela, penetrando através de soluções de continuidade da pele.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '026cb469-5b0d-5160-a725-bce1dc764ba9'::uuid, '965e02b4-2573-53a8-8d73-f6b4db2d16f7'::uuid,
        'C', 'A mortalidade é alta', 'Incorreta. A mortalidade da erisipela é geralmente baixa quando o tratamento é instituído precocemente, embora complicações possam ocorrer em idosos, diabéticos e imunossuprimidos.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '02ee28db-7b11-55df-b8bf-d4bc8312bd8c'::uuid, '965e02b4-2573-53a8-8d73-f6b4db2d16f7'::uuid,
        'D', 'A apresentação bolhosa confere maior gravidade assim como a localização facial', 'Correta. As formas bolhosas estão associadas a maior intensidade inflamatória e risco de complicações. A erisipela facial também merece atenção especial devido ao maior risco de disseminação e complicações locais.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 027 | Turma 116 -T2
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        'd7698e94-01f1-546c-98da-a0b1d597962a'::uuid, v_discipline_id, NULL, 'médio',
        'Em relação às foliculites, é incorreto afirmar:', 'single',
        'B', ARRAY[]::text[],
        'A foliculite decalvante é uma foliculite neutrofílica crônica do couro cabeludo, frequentemente associada ao Staphylococcus aureus. Caracteriza-se por pústulas foliculares recorrentes, crostas, eritema e evolução para alopecia cicatricial, sendo a politríquia um achado bastante característico. O tratamento é desafiador e geralmente prolongado, utilizando antibióticos sistêmicos, como rifampicina associada à clindamicina ou tetraciclinas, podendo ser empregada dapsona em casos selecionados. A resposta costuma ser lenta e as recidivas são comuns.', 'A foliculite decalvante é uma foliculite neutrofílica crônica do couro cabeludo, frequentemente associada ao Staphylococcus aureus.',
        'Foliculite decalvante = crônica + alopecia cicatricial.
Politríquia = vários fios saindo do mesmo óstio folicular.
Predomina em homens adultos.
Tratamento prolongado com antibióticos; dapsona pode ser útil.
Recidivas são frequentes.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '20cf0a52-2ffc-5616-b39e-d0563909e035'::uuid, 'd7698e94-01f1-546c-98da-a0b1d597962a'::uuid,
        'A', 'Na foliculite decalvante é de evolução crônica, pode causar fibrose e é mais comum nos homens adultos', 'Incorreta. A foliculite decalvante é uma dermatose inflamatória crônica, predominante em homens adultos, que pode evoluir com fibrose e alopecia cicatricial.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '592ec16b-f382-5569-9431-c3d560df40a5'::uuid, 'd7698e94-01f1-546c-98da-a0b1d597962a'::uuid,
        'B', 'Tem resposta terapêutica rápida', 'Correta. A foliculite decalvante apresenta evolução crônica, resposta terapêutica geralmente lenta e frequentes recidivas, exigindo tratamento prolongado.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '1aab5438-2743-59a6-8cfa-eddb17f1fea1'::uuid, 'd7698e94-01f1-546c-98da-a0b1d597962a'::uuid,
        'C', 'A terapêutica é feita com antibióticos e a dapsona pode ser útil', 'Incorreta. O tratamento baseia-se principalmente em antibióticos sistêmicos, podendo a dapsona ser utilizada como opção terapêutica em casos selecionados.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '1ed0f805-4b7c-55b5-9b4f-478b7f9ad1ef'::uuid, 'd7698e94-01f1-546c-98da-a0b1d597962a'::uuid,
        'D', 'Pode causar politríquia, ou seja, emergir vários fios da mesma abertura folicular', 'Incorreta. A politríquia (tufted hair) é um achado característico da foliculite decalvante, decorrente da emergência de múltiplos fios por um mesmo óstio folicular.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 028 | Turma 116 -T2
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '8e5e5ce3-4587-51b2-8744-b9213281a986'::uuid, v_discipline_id, NULL, 'médio',
        'Em relação à esporotricose, é correto afirmar:', 'single',
        'D', ARRAY[]::text[],
        'A esporotricose é uma micose subcutânea causada por fungos do complexo Sporothrix, adquirida geralmente por inoculação traumática através de espinhos, madeira, solo ou contato com gatos infectados. A forma cutâneo-linfática é a mais frequente, seguida da forma cutânea fixa. As formas disseminadas e extracutâneas, com comprometimento de ossos, articulações, músculos e vísceras, são raras e ocorrem principalmente em pacientes imunossuprimidos. O tratamento de escolha é o itraconazol, enquanto a anfotericina B é reservada para os casos graves ou disseminados.', 'A esporotricose é uma micose subcutânea causada por fungos do complexo Sporothrix, adquirida geralmente por inoculação traumática através de espinhos, madeira, solo ou contato com gatos infectados.',
        'Esporotricose = infecção subaguda/crônica.
Fungo dimórfico → Sporothrix spp.
Forma mais comum = cutâneo-linfática.
Linfonodos não são obrigatoriamente acometidos.
Formas osteoarticulares e viscerais → imunossuprimidos (HIV, alcoolismo, diabetes, corticoterapia).', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '31689055-f2f6-5b4a-a234-ce0a44fd5064'::uuid, '8e5e5ce3-4587-51b2-8744-b9213281a986'::uuid,
        'A', 'É uma infecção aguda, causada por fungo dimórfico Sporothrix spp', 'Incorreta. A esporotricose é uma infecção subaguda ou crônica, causada por fungos dimórficos do complexo Sporothrix.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'c777f58b-32f6-5145-852f-1ca51cc8aee4'::uuid, '8e5e5ce3-4587-51b2-8744-b9213281a986'::uuid,
        'B', 'Caracteriza-se por lesões polimórficas e com acometimento de linfonodo obrigatoriamente.', 'Incorreta. As lesões são realmente polimórficas, porém o acometimento linfonodal não é obrigatório, podendo estar ausente em diversas formas clínicas, como a forma cutânea fixa.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '68bca797-7441-506d-acf3-9f877121a22e'::uuid, '8e5e5ce3-4587-51b2-8744-b9213281a986'::uuid,
        'C', 'A maioria dos casos envolve a pele secundariamente', 'Incorreta. A pele é o principal sítio de acometimento primário, após inoculação traumática do fungo. O acometimento secundário ocorre nas formas disseminadas.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '434f3be6-ffa3-599b-920d-6ff41d9c183f'::uuid, '8e5e5ce3-4587-51b2-8744-b9213281a986'::uuid,
        'D', 'O acometimento muscular, ósseo e articular ocorre em pacientes imunossuprimidos, em geral, em alcoólatras, AIDS, diabetes e em dose altas de corticosteróide.', 'Correta. As formas extracutâneas da esporotricose, incluindo acometimento osteoarticular e muscular, são incomuns e ocorrem principalmente em pacientes imunossuprimidos, como portadores de HIV/AIDS, alcoolistas, diabéticos e usuários de corticoterapia em altas doses.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 029 | Turma 116 -T2
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '7bb0cb45-060e-529a-908b-9c78d595b8ea'::uuid, v_discipline_id, NULL, 'médio',
        'Em relação à cromomicose, é incorreto:', 'single',
        'A', ARRAY[]::text[],
        'A cromoblastomicose é uma micose subcutânea crônica causada por fungos demáceos inoculados por trauma com madeira, espinhos ou solo contaminado. As lesões apresentam grande polimorfismo clínico, sendo as formas verrucosas as mais características. O diagnóstico é sugerido pela identificação dos corpos escleróticos (fumagoides ou de Medlar) no exame micológico direto ou histopatológico, sendo a cultura utilizada para identificação da espécie. O tratamento é prolongado e frequentemente associa antifúngicos sistêmicos (como itraconazol ou terbinafina) a métodos físicos, como crioterapia ou cirurgia.', 'A cromoblastomicose é uma micose subcutânea crônica causada por fungos demáceos inoculados por trauma com madeira, espinhos ou solo contaminado.',
        'Cromoblastomicose = fungos demáceos.
Corpos fumagoides (escleróticos/Medlar) = diagnóstico clássico.
Lesões são polimórficas, principalmente verrucosas.
Principal agente no Brasil = Fonsecaea pedrosoi.
Acometimento visceral é raro, mas possível.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '4cb3adf6-40a2-5d30-8dff-51da126d2f5b'::uuid, '7bb0cb45-060e-529a-908b-9c78d595b8ea'::uuid,
        'A', 'É uma infecção fúngica crônica, monomórfica que acomete preferencialmente a derme e o subcutâneo', 'Correta. A cromoblastomicose é uma infecção crônica, porém apresenta lesões polimórficas, podendo assumir aspectos nodulares, verrucosos, tumorais, cicatriciais e em placa. Portanto, não é uma doença monomórfica.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '3f3be073-7020-5ee9-b0c9-4d336a816234'::uuid, '7bb0cb45-060e-529a-908b-9c78d595b8ea'::uuid,
        'B', 'Causada por espécies de fungo demáceos', 'Incorreta. A cromoblastomicose é causada por fungos demáceos, principalmente Fonsecaea pedrosoi, além de Cladophialophora carrionii e Phialophora verrucosa.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '3cb38518-add9-5ebb-816e-093cf2130d20'::uuid, '7bb0cb45-060e-529a-908b-9c78d595b8ea'::uuid,
        'C', 'Pode acometer órgãos internos, em casos raros', 'Incorreta. Embora seja uma doença predominantemente cutânea e subcutânea, casos excepcionais de disseminação para órgãos internos, como sistema nervoso central e pulmões, já foram descritos.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'c6b2b62f-0a25-51f0-87b9-d074c756c625'::uuid, '7bb0cb45-060e-529a-908b-9c78d595b8ea'::uuid,
        'D', 'Encontra-se os corpos escleróticos no exame micológico direto', 'Incorreta. Os corpos escleróticos (corpos fumagoides ou de Medlar) são característicos da cromoblastomicose e podem ser observados no exame micológico direto e na histopatologia.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 030 | Turma 116 -T2
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '5685eb47-587b-52a7-87ad-0d0467cc736d'::uuid, v_discipline_id, NULL, 'médio',
        'Em relação à larva migrans, é incorreto:', 'single',
        'C', ARRAY[]::text[],
        'A larva migrans cutânea é uma dermatozoonose causada pela penetração de larvas de ancilostomídeos de cães e gatos, principalmente Ancylostoma braziliense e A. caninum. O homem é um hospedeiro acidental, e as larvas permanecem confinadas à epiderme, formando trajetos serpiginosos intensamente pruriginosos. Como não ocorre migração sistêmica, eosinofilia importante é rara. O tratamento consiste principalmente em albendazol (400 mg/dia por 3 dias) ou ivermectina em dose única, além de medidas para alívio do prurido.', 'A larva migrans cutânea é uma dermatozoonose causada pela penetração de larvas de ancilostomídeos de cães e gatos, principalmente Ancylostoma braziliense e A.',
        'Larva migrans = "bicho geográfico".
Agentes principais → Ancylostoma braziliense e A. caninum.
Eosinofilia importante → não é comum.
Tratamento → albendazol ou ivermectina.
Contato com areia contaminada por fezes de cães e gatos = principal fator de risco.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'b0de69b8-c00e-5134-b495-9e126ab43f26'::uuid, '5685eb47-587b-52a7-87ad-0d0467cc736d'::uuid,
        'A', 'É cosmopolita', 'Incorreta. A larva migrans cutânea possui distribuição cosmopolita, embora seja mais frequente em regiões tropicais e subtropicais.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '97f0d768-b562-56b5-b4a2-4bd24d365140'::uuid, '5685eb47-587b-52a7-87ad-0d0467cc736d'::uuid,
        'B', 'O agente etiológico é Ancylostoma caninum', 'Incorreta. Ancylostoma caninum é um dos agentes etiológicos da larva migrans cutânea, juntamente com Ancylostoma braziliense, considerado o principal agente.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '84bda6bb-25cc-5eaf-8afa-1cb2803abc9c'::uuid, '5685eb47-587b-52a7-87ad-0d0467cc736d'::uuid,
        'C', 'A eosinofilia elevada é comum', 'Correta. A eosinofilia geralmente é ausente ou discreta, pois a infecção permanece restrita à pele. Eosinofilia elevada é incomum e, quando presente, deve levantar a suspeita de acometimento sistêmico ou outras helmintíases.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '97edba42-2b7f-53f5-971c-81776e36607e'::uuid, '5685eb47-587b-52a7-87ad-0d0467cc736d'::uuid,
        'D', 'Como opção de tratamento temos: albendazol 400 mg por 3 dias', 'Incorreta. O albendazol 400 mg ao dia por 3 dias é um dos esquemas terapêuticos recomendados para larva migrans cutânea. A ivermectina em dose única também é uma opção eficaz.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 031 | Turma 116 -T2
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '12fb42c0-e603-5bb6-a279-60ba4e97650b'::uuid, v_discipline_id, NULL, 'médio',
        'Em relação à acne, é incorreto:', 'single',
        'B', ARRAY[]::text[],
        'A acne vulgar é uma doença inflamatória da unidade pilossebácea, classificada em grau I (comedoniana) e graus II a V (inflamatórias). A acne conglobata caracteriza-se por lesões nodulocísticas, abscessos e fístulas, predominando em homens. A acne fulminans representa a forma mais grave, com surgimento abrupto de lesões ulceradas associado a sintomas sistêmicos, como febre, fadiga, mal-estar, mialgia e artralgia, acometendo principalmente adolescentes do sexo masculino. A distribuição típica envolve áreas seborreicas, especialmente a face, tórax e dorso.', 'A acne vulgar é uma doença inflamatória da unidade pilossebácea, classificada em grau I (comedoniana) e graus II a V (inflamatórias).',
        'Grau I = comedões (não inflamatória).
Graus II–V = acne inflamatória.
Acne conglobata = nódulos + cistos + fístulas.
Acne fulminans = homem jovem + sintomas sistêmicos.
Face (zona T) = principal local de acometimento.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '2ab97722-7af6-514d-b017-43992a7bc964'::uuid, '12fb42c0-e603-5bb6-a279-60ba4e97650b'::uuid,
        'A', 'Pode ser classificada em acne não inflamatória: grau I, e em acne inflamatória: grau II, III, IV e V.', 'Incorreta. A classificação clínica da acne é essa: grau I (comedoniana) e graus II a V (formas inflamatórias).'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '3d478f4f-7b77-59c2-89cd-1aea9c64872c'::uuid, '12fb42c0-e603-5bb6-a279-60ba4e97650b'::uuid,
        'B', 'Na acne fulminans, a forma mais grave, possui sintomatologia como: fadiga, febre, mal-estar, mialgia e é essencialmente uma doença de jovens do sexo feminino.', 'Correta. A acne fulminans realmente cursa com manifestações sistêmicas importantes (febre, mal-estar, mialgia, artralgia e fadiga), porém acomete predominantemente adolescentes e adultos jovens do sexo masculino, e não do sexo feminino.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '910fa2d4-f88a-59c2-be10-b873932beb81'::uuid, '12fb42c0-e603-5bb6-a279-60ba4e97650b'::uuid,
        'C', 'A acne conglobata predomina lesões císticas e ocorre principalmente no sexo masculino.', 'Incorreta. A acne conglobata caracteriza-se por nódulos, cistos, abscessos e fístulas intercomunicantes, acometendo principalmente homens jovens.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '87791467-6383-5815-bf29-f717883ddc8f'::uuid, '12fb42c0-e603-5bb6-a279-60ba4e97650b'::uuid,
        'D', 'Quando ocorre na face, tem preferência pelas regiões frontais, malares e mento', 'Incorreta. A acne acomete preferencialmente áreas ricas em glândulas sebáceas, especialmente fronte, regiões malares, nariz e mento.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 032 | Turma 116 -T2
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '85f1c539-dfe6-5435-b184-eafec07d3a92'::uuid, v_discipline_id, NULL, 'médio',
        'AMJL, 42 anos, anti-HIV positivo, em tratamento com TARV iniciado há 2 semanas, relata febre baixa (37,9°C), adinamia, dor em região facial unilateral, há 3 dias, fez uso de anti-inflamatório sem melhoras, posteriormente surgiram lesões vesiculares agrupadas e base eritematosa que segue o trajeto do nervo facial, sobre o caso clínico. Qual o diagnóstico clínico', 'single',
        'C', ARRAY[]::text[],
        'O herpes-zóster resulta da reativação do vírus Varicella-zoster, que permanece latente nos gânglios sensitivos após a varicela. O quadro caracteriza-se por dor neuropática, seguida de vesículas agrupadas sobre base eritematosa, distribuídas de forma unilateral ao longo de um dermátomo. Pacientes imunossuprimidos, especialmente aqueles com HIV ou em fase de reconstituição imune após início da TARV, apresentam maior risco de desenvolver a doença e suas complicações. O tratamento deve ser iniciado preferencialmente nas primeiras 72 horas com antivirais (aciclovir, valaciclovir ou fanciclovir), associados ao controle adequado da dor.', 'O herpes-zóster resulta da reativação do vírus Varicella-zoster, que permanece latente nos gânglios sensitivos após a varicela.',
        'Dor antes das vesículas = pense em herpes-zóster.
Dermátomo + unilateral + não cruza a linha média = diagnóstico clássico.
Herpes simples → vesículas agrupadas, mas sem dermátomo.
HIV e início recente da TARV → aumentam o risco de reativação do VZV (IRIS).', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '51701e9b-194a-5805-b26b-ec7b0caa831e'::uuid, '85f1c539-dfe6-5435-b184-eafec07d3a92'::uuid,
        'A', 'Herpes simples recorrente → lesões agrupadas sem distribuição dermatomérica.', 'Incorreta. O herpes simples apresenta vesículas agrupadas e recorrentes, porém não acompanha um dermátomo e geralmente acomete regiões periorais ou genitais.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '7b3b65e7-1cc4-556e-9602-6a74e9e9ace2'::uuid, '85f1c539-dfe6-5435-b184-eafec07d3a92'::uuid,
        'B', 'Erisipela facial → placa eritematosa quente e bem delimitada causada principalmente por estreptococos.', 'Incorreta. A erisipela cursa com placa eritematosa dolorosa e bem delimitada, sem vesículas agrupadas distribuídas ao longo de um dermátomo.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '3e71f733-62fb-55ff-9d41-b5ed04dc2f17'::uuid, '85f1c539-dfe6-5435-b184-eafec07d3a92'::uuid,
        'C', 'Herpes-zóster → dor neurítica precede vesículas agrupadas em distribuição dermatomérica unilateral.', 'Correta. O quadro é típico de herpes-zóster, caracterizado por dor neuropática seguida de vesículas agrupadas sobre base eritematosa, distribuídas unilateralmente ao longo de um dermátomo. A infecção por HIV e o início recente da TARV aumentam o risco de reativação do vírus Varicella-zoster, inclusive como manifestação da síndrome inflamatória da reconstituição imune (IRIS).'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '2c3f0aa4-8378-56e3-a7ff-c8932765f561'::uuid, '85f1c539-dfe6-5435-b184-eafec07d3a92'::uuid,
        'D', 'Dermatite de contato alérgica → eczema pruriginoso relacionado à exposição a alérgeno.', 'Incorreta. A dermatite de contato caracteriza-se por eczema pruriginoso relacionado à exposição a agentes sensibilizantes, não cursando com dor neurítica nem distribuição dermatomérica.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 033 | Turma 116 -T2
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        'eed9a312-1837-5f47-b7d6-57ee9b762c4a'::uuid, v_discipline_id, NULL, 'médio',
        'AMJL, 42 anos, anti-HIV positivo, em tratamento com TARV iniciado há 2 semanas, relata febre baixa (37,9°C), adinamia, dor em região facial unilateral, há 3 dias, fez uso de anti-inflamatório sem melhoras, posteriormente surgiram lesões vesiculares agrupadas e base eritematosa que segue o trajeto do nervo facial, sobre o caso clínico. qual alternativa traz duas complicações possíveis no caso acima?', 'single',
        'B', ARRAY[]::text[],
        'O herpes-zóster pode evoluir com diversas complicações, especialmente em idosos e pacientes imunossuprimidos. A neuralgia pós-herpética é a mais frequente, resultando em dor neuropática persistente após a cicatrização das lesões. O zóster oftálmico ocorre quando há acometimento do ramo oftálmico do nervo trigêmeo e pode causar perda visual. A síndrome de Ramsay Hunt decorre do acometimento do nervo facial pelo vírus Varicella-zoster, causando paralisia facial periférica associada a lesões vesiculares auriculares. Em pacientes com imunodeficiência, como portadores de HIV, também podem ocorrer formas disseminadas cutâneas e viscerais, com maior morbidade e necessidade de tratamento hospitalar com antivirais intravenosos.', 'O herpes-zóster pode evoluir com diversas complicações, especialmente em idosos e pacientes imunossuprimidos.',
        'Complicações clássicas do herpes-zóster:
Neuralgia pós-herpética.
Zóster oftálmico.
Síndrome de Ramsay Hunt.
Disseminação cutânea ou visceral em imunossuprimidos.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '13dc2129-fedd-5c62-9d95-1ddeb4f4518f'::uuid, 'eed9a312-1837-5f47-b7d6-57ee9b762c4a'::uuid,
        'A', 'Celulite bacteriana e Zóster oftálmico .', 'Incorreta. O zóster oftálmico é uma complicação do herpes-zóster quando há acometimento do ramo oftálmico do nervo trigêmeo. Entretanto, celulite bacteriana não é considerada uma complicação típica do herpes-zóster, podendo ocorrer apenas como infecção secundária eventual.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'bdfb2cfe-ee13-5011-a18c-f42b8e8fb8d6'::uuid, 'eed9a312-1837-5f47-b7d6-57ee9b762c4a'::uuid,
        'B', 'Neuralgia pós-herpética + síndrome de Ramsay Hunt', 'Correta. Ambas são complicações clássicas do herpes-zóster. A neuralgia pós-herpética é a complicação mais frequente, caracterizada por dor persistente após a resolução das lesões. A síndrome de Ramsay Hunt ocorre pela reativação do VZV no gânglio geniculado, cursando com paralisia facial periférica, otalgia e vesículas no pavilhão auricular ou conduto auditivo.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '0afe7bb4-45aa-5a15-b9a9-de8162212336'::uuid, 'eed9a312-1837-5f47-b7d6-57ee9b762c4a'::uuid,
        'C', 'Eritema nodoso + Zóster oftálmico.', 'Incorreta. O zóster oftálmico é uma complicação reconhecida do herpes-zóster, porém eritema nodoso não possui relação com a evolução da doença.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '0539a3c1-b201-5282-b442-93cdc44e7bbb'::uuid, 'eed9a312-1837-5f47-b7d6-57ee9b762c4a'::uuid,
        'D', 'Pitiríase rósea + Disseminação visceral em imunossuprimidos.', 'Incorreta. A disseminação visceral pode ocorrer em pacientes imunossuprimidos, como aqueles com HIV. Entretanto, pitiríase rósea não representa complicação do herpes-zóster.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 034 | Turma 117 -T1
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '60fa3b1d-a08b-56ad-a8d7-48790c748afc'::uuid, v_discipline_id, NULL, 'médio',
        'Em relação ao impetigo, é incorreto afirmar:', 'single',
        'B', ARRAY[]::text[],
        'O impetigo é uma piodermite superficial altamente contagiosa, predominante na infância. As lesões acometem principalmente a face e áreas expostas, podendo disseminar-se facilmente por autoinoculação, formando novas lesões em diferentes regiões do corpo. Os principais agentes etiológicos são Staphylococcus aureus e Streptococcus pyogenes. Além de ocorrer como infecção primária, o impetigo também pode complicar dermatoses pruriginosas pré-existentes, caracterizando a impetiginização.', 'O impetigo é uma piodermite superficial altamente contagiosa, predominante na infância.',
        'Face = principal local acometido.
Autoinoculação = disseminação frequente.
Agentes → S. aureus + S. pyogenes.
Impetiginização = infecção bacteriana sobre outra dermatose.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '7503e1b6-6116-55b6-8d23-23d99dbc084a'::uuid, '60fa3b1d-a08b-56ad-a8d7-48790c748afc'::uuid,
        'A', 'Acomete principalmente face e membros superiores.', 'Incorreta. O impetigo acomete preferencialmente a face, especialmente regiões periorais e perinasais, além de extremidades expostas, incluindo os membros superiores.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '0f65ab84-bd6d-5341-b583-9ac5e1cee445'::uuid, '60fa3b1d-a08b-56ad-a8d7-48790c748afc'::uuid,
        'B', 'A disseminação quase não existe, mas quando existe acomete apenas face.', 'Correta. O impetigo apresenta alta capacidade de disseminação por autoinoculação, podendo acometer diversas regiões do corpo, e não apenas a face.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '0bb5dfe8-2d74-5a97-923f-ff285a45efce'::uuid, '60fa3b1d-a08b-56ad-a8d7-48790c748afc'::uuid,
        'C', 'São em geral causadas por estreptococos e estafilococos.', 'Incorreta. O impetigo é causado principalmente por Staphylococcus aureus e Streptococcus pyogenes.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '47a913ce-5768-5f72-a4b3-217f16b10afd'::uuid, '60fa3b1d-a08b-56ad-a8d7-48790c748afc'::uuid,
        'D', 'Pode complicar com uma dermatose preexistente.', 'Incorreta. O impetigo pode surgir secundariamente sobre dermatoses pré-existentes, como escabiose, pediculose, dermatite atópica e eczema, situação denominada impetiginização.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 035 | Turma 117 -T1
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        'f391b56a-6380-50d8-95bc-7799226235f5'::uuid, v_discipline_id, NULL, 'médio',
        'Em relação a erisipela, é incorreto afirmar:', 'single',
        'D', ARRAY[]::text[],
        'A erisipela é uma infecção aguda da derme superficial e dos vasos linfáticos, causada principalmente pelo Streptococcus pyogenes. Clinicamente, apresenta placa eritematosa, edemaciada, quente, dolorosa e bem delimitada, frequentemente acompanhada de febre, calafrios e mal-estar. Embora o estreptococo seja o agente etiológico clássico, casos ocasionais relacionados ao Staphylococcus aureus já foram descritos na literatura, motivo pelo qual a afirmação de que "não há casos descritos" é considerada incorreta. O tratamento é realizado com antibioticoterapia sistêmica e medidas de suporte.', 'A erisipela é uma infecção aguda da derme superficial e dos vasos linfáticos, causada principalmente pelo Streptococcus pyogenes.',
        'Erisipela = Streptococcus (principalmente grupo A).
Placa elevada, brilhante e bem delimitada.
Febre e calafrios são comuns.
Celulite → bordas mal delimitadas.
Staphylococcus não é o agente clássico, mas há relatos raros.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '8ed22cf0-a3da-57f2-ab78-2ee8f3f2e8e7'::uuid, 'f391b56a-6380-50d8-95bc-7799226235f5'::uuid,
        'A', 'É de natureza estreptocócica do grupo A, eventualmente dos grupos B, C e G.', 'Incorreta. A erisipela é causada predominantemente pelo Streptococcus pyogenes (grupo A), podendo, mais raramente, ser causada por estreptococos dos grupos B, C e G.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '4ce399f3-9d58-5a22-85b2-39b899cdcf03'::uuid, 'f391b56a-6380-50d8-95bc-7799226235f5'::uuid,
        'B', 'Pode ser acompanhada de febre, mal-estar e calafrios.', 'Incorreta. Além da placa eritematosa dolorosa, é comum o paciente apresentar manifestações sistêmicas como febre, calafrios e mal-estar.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '6db9d626-9571-580d-84b3-6e63186b999f'::uuid, 'f391b56a-6380-50d8-95bc-7799226235f5'::uuid,
        'C', 'Manifesta-se como eritema, edema e bordas bem delimitadas.', 'Incorreta. A placa erisipelatosa caracteriza-se por eritema, edema, calor local, dor e limites nítidos, sendo essa uma das principais características que a diferenciam da celulite.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '170e7b9c-2144-5776-8486-b101ff2c252a'::uuid, 'f391b56a-6380-50d8-95bc-7799226235f5'::uuid,
        'D', 'Não há casos descritos de etiologia estafilocócica.', 'Correta. Embora a erisipela seja classicamente uma infecção estreptocócica, existem relatos raros de casos causados por Staphylococcus aureus. Portanto, afirmar que não há casos descritos de etiologia estafilocócica é incorreto.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 036 | Turma 117 -T1
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        'db041f84-91fa-5386-8c46-ab5682f81425'::uuid, v_discipline_id, NULL, 'médio',
        'Em relação ao tratamento do impetigo, todas são corretas exceto:', 'single',
        'A', ARRAY[]::text[],
        'O tratamento do impetigo depende da extensão da doença. Casos localizados podem ser tratados com antibióticos tópicos, como mupirocina ou ácido fusídico. Quando há múltiplas lesões, acometimento extenso, surtos familiares ou sintomas sistêmicos, está indicada antibioticoterapia sistêmica. Medidas locais, como higiene adequada, remoção das crostas e uso de antissépticos ou compressas com permanganato de potássio em lesões exsudativas, aceleram a resolução e diminuem a transmissão da infecção.', 'O tratamento do impetigo depende da extensão da doença.',
        'Poucas lesões → mupirocina tópica.
Lesões extensas ou múltiplas → antibiótico sistêmico.
Limpeza + remoção de crostas + antissépticos = tratamento adjuvante.
Não atrasar o início da antibioticoterapia quando indicada.', 'Atenção ao comando: deve-se marcar a alternativa incorreta ou a exceção.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'b1ed451f-8361-5707-9bdd-357a2f11d090'::uuid, 'db041f84-91fa-5386-8c46-ab5682f81425'::uuid,
        'A', 'Antibióticos não devem iniciar imediatamente.', 'Correta. O tratamento do impetigo inclui antibioticoterapia tópica ou sistêmica, conforme a extensão das lesões. O início precoce dos antibióticos reduz o tempo de doença, a transmissão e o risco de complicações, portanto não se deve retardar seu uso quando indicado.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'e30d5523-071c-59b3-a3cf-7df35b9da9f1'::uuid, 'db041f84-91fa-5386-8c46-ab5682f81425'::uuid,
        'B', 'Faz parte do tratamento a limpeza, uso de antissépticos.', 'Incorreta. A higiene adequada das lesões e o uso de antissépticos auxiliam na remoção das crostas e na redução da carga bacteriana, sendo medidas importantes no tratamento.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'a7c50720-8f47-5c7d-aa09-72641325734e'::uuid, 'db041f84-91fa-5386-8c46-ab5682f81425'::uuid,
        'C', 'Permanganato de potássio, faz parte do tratamento.', 'Incorreta. O permanganato de potássio pode ser utilizado como adjuvante em curativos úmidos, especialmente em lesões exsudativas, auxiliando na secagem e limpeza das lesões.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '9c80f15f-dd6f-5870-b3ef-4ab1a9685d6e'::uuid, 'db041f84-91fa-5386-8c46-ab5682f81425'::uuid,
        'D', 'Em casos mais extensos, o uso de antibioticoterapia sistêmica é mandatório.', 'Incorreta. Nos casos extensos, com múltiplas lesões, surtos ou sintomas sistêmicos, a antibioticoterapia sistêmica é recomendada, sendo cefalexina e amoxicilina-clavulanato opções frequentes.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 037 | Turma 117 -T1
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '873adaec-92bf-5d6e-be5f-21d7af247f0e'::uuid, v_discipline_id, NULL, 'médio',
        'Em relação a cromomicose, é incorreto:', 'single',
        'C', ARRAY[]::text[],
        'A cromoblastomicose é uma micose subcutânea crônica causada por fungos demáceos, adquirida por inoculação traumática durante atividades rurais. O principal agente no Brasil é Fonsecaea pedrosoi. Caracteriza-se por lesões polimórficas de crescimento lento, predominando a forma verrucosa, geralmente localizada nos membros inferiores. O diagnóstico é baseado na identificação dos corpos fumagoides (corpos escleróticos ou de Medlar) no exame micológico direto ou histopatológico, sendo a cultura utilizada para identificação da espécie. O acometimento sistêmico é raro.', 'A cromoblastomicose é uma micose subcutânea crônica causada por fungos demáceos, adquirida por inoculação traumática durante atividades rurais.',
        'Cromoblastomicose = fungos demáceos (escuros).
Zona rural + trauma com espinhos ou madeira.
Lesões polimórficas, principalmente verrucosas.
Corpos fumagoides (Medlar) = achado clássico.
Comprometimento sistêmico é incomum.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '1dad151e-d8be-5d7e-8509-8169d6062574'::uuid, '873adaec-92bf-5d6e-be5f-21d7af247f0e'::uuid,
        'A', 'É encontrada principalmente na zona rural.', 'Incorreta. A cromoblastomicose acomete principalmente trabalhadores rurais devido ao contato frequente com solo, madeira, espinhos e vegetação.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '59901f1f-1ec3-5b6b-8bef-08ea41cdbd4b'::uuid, '873adaec-92bf-5d6e-be5f-21d7af247f0e'::uuid,
        'B', 'É uma infecção polimórfica.', 'Incorreta. A doença apresenta polimorfismo clínico, podendo manifestar-se sob as formas nodular, verrucosa, tumoral, cicatricial e em placa.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'c03de451-0920-5947-a89e-e444d6347439'::uuid, '873adaec-92bf-5d6e-be5f-21d7af247f0e'::uuid,
        'C', 'Não são fungos demácios.', 'Correta. A cromoblastomicose é causada por fungos demáceos (pigmentados pela melanina), como Fonsecaea pedrosoi, Cladophialophora carrionii e Phialophora verrucosa. Portanto, afirmar que não são fungos demáceos está incorreto.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '6dd6bd28-071b-5b38-8c9e-ba2e1d0b9120'::uuid, '873adaec-92bf-5d6e-be5f-21d7af247f0e'::uuid,
        'D', 'Em geral, não há comprometimento sistêmico.', 'Incorreta. A cromoblastomicose permanece, na maioria dos casos, restrita à pele e ao tecido subcutâneo. O acometimento sistêmico é raro.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 038 | Turma 117 -T1
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '0cb85006-26f9-5902-8683-3bf86b07d5c8'::uuid, v_discipline_id, NULL, 'médio',
        'Em relação a esporotricose, é incorreto:', 'single',
        'D', ARRAY[]::text[],
        'A esporotricose é uma micose subcutânea causada por fungos do complexo Sporothrix, adquirida principalmente por inoculação traumática através de espinhos, solo, vegetação ou contato com gatos infectados. A forma cutaneolinfática é a mais frequente e caracteriza-se por nódulos que ulceram e se distribuem ao longo dos vasos linfáticos. Em crianças, a face é um local frequentemente acometido. O diagnóstico diferencial inclui leishmaniose tegumentar, cromoblastomicose, tuberculose cutânea e pioderma gangrenoso. O tratamento de escolha é o itraconazol, sendo a solução saturada de iodeto de potássio uma alternativa clássica.', 'A esporotricose é uma micose subcutânea causada por fungos do complexo Sporothrix, adquirida principalmente por inoculação traumática através de espinhos, solo, vegetação ou contato com gatos infectados.',
        'Forma cutaneolinfática = 70–80% dos casos.
Crianças → acometimento facial é frequente.
Diagnósticos diferenciais → leishmaniose, cromoblastomicose, tuberculose cutânea e pioderma gangrenoso.
Esporotricose → nódulos e úlceras; goma não é lesão típica.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '0949fbc4-54ef-5dbe-8a7d-ac68e62b3ad5'::uuid, '0cb85006-26f9-5902-8683-3bf86b07d5c8'::uuid,
        'A', 'A forma clínica cutaneolinfática é mais comum (cerca de 80% dos casos).', 'Incorreta. A forma cutaneolinfática é a apresentação clínica mais frequente da esporotricose, correspondendo a aproximadamente 70–80% dos casos.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '77651f93-c435-58dc-9fdc-c9ed1ea428a2'::uuid, '0cb85006-26f9-5902-8683-3bf86b07d5c8'::uuid,
        'B', 'Preferência pela face, nas crianças.', 'Incorreta. Em crianças, a face é um dos locais mais acometidos, provavelmente devido ao maior contato com gatos infectados e à menor estatura.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '3f692b61-5b5d-54bb-9616-ccba73e0db53'::uuid, '0cb85006-26f9-5902-8683-3bf86b07d5c8'::uuid,
        'C', 'Como diagnóstico diferencial, deve-se considerar leishmaniose, pioderma gangrenoso, cromomicose e tuberculose cutânea.', 'Incorreta. Todas essas doenças fazem parte do diagnóstico diferencial da esporotricose, especialmente nas formas ulceradas ou verrucosas.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'c37e70b1-5657-5baf-8f04-452cd61c5172'::uuid, '0cb85006-26f9-5902-8683-3bf86b07d5c8'::uuid,
        'D', 'A goma pode ser vista nessa doença como lesão elementar.', 'Correta. A goma não é uma lesão elementar característica da esporotricose. As lesões típicas incluem pápulas, nódulos, úlceras, placas verrucosas e nódulos distribuídos ao longo dos vasos linfáticos. A goma é classicamente observada em doenças como a sífilis terciária e algumas formas de tuberculose cutânea.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 039 | Turma 117 -T1
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '33a7391c-f9ca-5152-87a2-a6834968f767'::uuid, v_discipline_id, NULL, 'médio',
        'Em relação a cromomicose, é correto afirmar:', 'single',
        'B', ARRAY[]::text[],
        'A cromoblastomicose é uma micose subcutânea crônica causada por fungos demáceos, adquirida por inoculação traumática durante atividades rurais. As lesões acometem principalmente os membros inferiores e apresentam evolução lenta, frequentemente assumindo aspecto verrucoso. O diagnóstico é sugerido pela presença de corpos fumagoides no exame micológico direto ou histopatológico, enquanto a cultura é necessária para identificação da espécie. O tratamento costuma ser prolongado, utilizando principalmente itraconazol ou terbinafina, frequentemente associados a métodos físicos, como crioterapia ou cirurgia, devido à dificuldade de erradicação da doença.', 'A cromoblastomicose é uma micose subcutânea crônica causada por fungos demáceos, adquirida por inoculação traumática durante atividades rurais.',
        'Trauma + trabalhador rural + membro inferior = cromoblastomicose.
Fungos demáceos = agentes etiológicos.
Corpos fumagoides = cromoblastomicose.
Corpos asteróides = esporotricose.
Cultura = identifica a espécie do fungo.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'dba03d9c-09c8-5cbf-a227-96f4170f8f44'::uuid, '33a7391c-f9ca-5152-87a2-a6834968f767'::uuid,
        'A', 'Tem uma resposta boa quando se utiliza voriconazol como monoterapia.', 'Incorreta. A cromoblastomicose apresenta tratamento difícil e prolongado. O voriconazol não é considerado tratamento de primeira linha, e a monoterapia geralmente não proporciona bons resultados.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '5f3593c5-59b3-531d-8fca-6c92bb75639f'::uuid, '33a7391c-f9ca-5152-87a2-a6834968f767'::uuid,
        'B', 'A penetração do fungo ocorre por traumatismo, sendo a doença mais comum em membros inferiores.', 'Correta. A cromoblastomicose é adquirida por inoculação traumática de fungos demáceos presentes no solo, madeira e vegetação. Os membros inferiores são os locais mais frequentemente acometidos, especialmente em trabalhadores rurais.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '0f8dce21-5d50-5af5-bbc1-5779eabb8955'::uuid, '33a7391c-f9ca-5152-87a2-a6834968f767'::uuid,
        'C', 'O exame micológico sem a cultura define o agente etiológico.', 'Incorreta. O exame micológico direto identifica os corpos fumagoides (escleróticos ou de Medlar), confirmando o diagnóstico da doença, porém a identificação da espécie depende da cultura.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '20531a52-5934-5bb8-9a54-6628f74d5873'::uuid, '33a7391c-f9ca-5152-87a2-a6834968f767'::uuid,
        'D', 'Encontra-se facilmente corpos asteróides.', 'Incorreta. Os corpos asteróides são encontrados principalmente na esporotricose. Na cromoblastomicose, o achado característico são os corpos fumagoides (corpos escleróticos ou de Medlar).'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 040 | Turma 117 -T1
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        'df13c29a-a8fb-5a6c-bac5-51effc3929e5'::uuid, v_discipline_id, NULL, 'médio',
        'Em relação a acne, é incorreto afirmar:', 'single',
        'D', ARRAY[]::text[],
        'A acne vulgar é uma doença inflamatória da unidade pilossebácea. Embora a acne comedoniana (grau I) seja classificada clinicamente como não inflamatória, sabe-se que o processo inflamatório já está presente em nível microscópico desde o início da formação do microcomedão. A acne conglobata representa uma forma grave, com nódulos, cistos e fístulas, fazendo parte da síndrome de oclusão folicular. Já a acne fulminante é a forma mais grave da doença, acometendo principalmente adolescentes do sexo masculino e cursando com importantes manifestações sistêmicas, como febre, mal-estar, mialgia e artralgia.', 'A acne vulgar é uma doença inflamatória da unidade pilossebácea.',
        'Acne grau I = comedões = clinicamente não inflamatória.
Histologicamente, a inflamação começa cedo.
Acne fulminante = homem jovem + febre + mialgia + artralgia.
Acne conglobata = tríade/tétrade da oclusão folicular.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'f1eea9a2-73d6-56ef-8cce-8fb4719d9bd1'::uuid, 'df13c29a-a8fb-5a6c-bac5-51effc3929e5'::uuid,
        'A', 'Há fadiga, febre, mialgia, artralgia na acne fulminante.', 'Incorreta. A acne fulminante caracteriza-se por manifestações sistêmicas importantes, como febre, fadiga, mal-estar, mialgia e artralgia, além de lesões ulceradas e dolorosas.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '8dd0eca8-c7fb-53fb-a1a2-0f42b35662e8'::uuid, 'df13c29a-a8fb-5a6c-bac5-51effc3929e5'::uuid,
        'B', 'Ocorre, na acne fulminante, em geral, em pacientes jovens masculinos.', 'Incorreta. A acne fulminante acomete predominantemente adolescentes e adultos jovens do sexo masculino.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'a770d9ef-7611-5899-be56-3aa22f74706a'::uuid, 'df13c29a-a8fb-5a6c-bac5-51effc3929e5'::uuid,
        'C', 'A acne conglobata faz parte da tríade de oclusão folicular.', 'Incorreta. A acne conglobata integra a tríade da oclusão folicular, juntamente com a hidradenite supurativa e a foliculite dissecante do couro cabeludo (alguns autores descrevem a tétrade, acrescentando o cisto pilonidal).'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '22abd2bb-eb7d-5a91-9ff1-c3ff434cb5f1'::uuid, 'df13c29a-a8fb-5a6c-bac5-51effc3929e5'::uuid,
        'D', 'A acne comedogênica, na fase inicial, clinicamente é inflamatória, mas na patologia não se encontra reação inflamatória.', 'Correta. A acne comedoniana (grau I) é considerada clinicamente não inflamatória, embora estudos histopatológicos demonstrem que já existe processo inflamatório microscópico desde as fases iniciais da doença.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 041 | Turma 117 -T1
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '6bd59bb4-5ee3-5cc8-8df4-34c0b153d052'::uuid, v_discipline_id, NULL, 'médio',
        'Em relação a acne, é correto afirmar:', 'single',
        'D', ARRAY[]::text[],
        'A acne vulgar é uma doença multifatorial da unidade pilossebácea. Sua fisiopatologia baseia-se em quatro pilares: aumento da produção de sebo, hiperqueratinização folicular, proliferação de Cutibacterium acnes e resposta inflamatória. Embora os andrógenos sejam importantes para estimular a atividade das glândulas sebáceas, a maioria dos pacientes apresenta níveis hormonais normais, sendo a maior sensibilidade periférica aos andrógenos o principal mecanismo envolvido. A forma mais grave da classificação clínica é a acne fulminante (grau V), caracterizada por lesões ulceradas e manifestações sistêmicas.', 'A acne vulgar é uma doença multifatorial da unidade pilossebácea.',
        'Acne = ↑ sebo + hiperqueratinização + Cutibacterium acnes + inflamação.
Malassezia ≠ acne vulgar.
Grau V = acne fulminante.
Maioria dos pacientes → andrógenos normais, mas maior sensibilidade sebácea.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '55e6ce6f-509e-5f63-b3d1-6ffc45d32211'::uuid, '6bd59bb4-5ee3-5cc8-8df4-34c0b153d052'::uuid,
        'A', 'Está relacionada à diminuição da secreção sebácea.', 'Incorreta. A acne está relacionada ao aumento da produção de sebo, associado à hiperqueratinização folicular, proliferação de Cutibacterium acnes e inflamação.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '3a329e04-d156-5b23-a480-82fc86ad5520'::uuid, '6bd59bb4-5ee3-5cc8-8df4-34c0b153d052'::uuid,
        'B', 'Há colonização apenas da M. furfur.', 'Incorreta. O principal microrganismo envolvido na fisiopatologia da acne é o Cutibacterium acnes (antigo Propionibacterium acnes). A Malassezia furfur está relacionada principalmente à pitiríase versicolor e à foliculite por Malassezia.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'bcc5589b-177b-53e0-87d0-bbd22c2d3820'::uuid, '6bd59bb4-5ee3-5cc8-8df4-34c0b153d052'::uuid,
        'C', 'A acne nodulocística representa o grau V na classificação atual.', 'Incorreta. A acne nodulocística corresponde ao grau III ou IV, dependendo da classificação adotada. O grau V corresponde à acne fulminante, forma mais grave da doença, acompanhada de manifestações sistêmicas.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'e8a0ec88-bd24-50a5-870c-ea1f70ff034b'::uuid, '6bd59bb4-5ee3-5cc8-8df4-34c0b153d052'::uuid,
        'D', 'Na maioria das vezes, não há excesso de andrógenos circulantes.', 'Correta. A maioria dos pacientes com acne apresenta níveis séricos normais de andrógenos. A doença decorre principalmente da maior sensibilidade das glândulas sebáceas aos andrógenos, e não do aumento da concentração hormonal circulante.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 042 | Turma 117 -T1
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '19560a07-f089-52dd-af0b-e9865f96ad5a'::uuid, v_discipline_id, NULL, 'médio',
        'Em relação à escabiose, é incorreto:', 'single',
        'C', ARRAY[]::text[],
        'A escabiose é uma ectoparasitose causada pelo ácaro Sarcoptes scabiei var. hominis. A fêmea fecundada é responsável pela escavação dos túneis na camada córnea da pele, onde deposita os ovos, desencadeando intensa reação de hipersensibilidade. O quadro clínico caracteriza-se por prurido de predomínio noturno, sulcos escabióticos e pápulas, acometendo principalmente espaços interdigitais, punhos, axilas, região periumbilical e genitais. O tratamento é realizado preferencialmente com permetrina 5%, sendo indispensável tratar simultaneamente todos os contactantes próximos e orientar a higienização de roupas e roupas de cama para prevenir reinfestações.', 'A escabiose é uma ectoparasitose causada pelo ácaro Sarcoptes scabiei var.',
        'Escabiose = fêmea escava o sulco e deposita os ovos.
Prurido intenso à noite = principal pista clínica.
Tratar paciente + todos os contactantes.
Prurido pode persistir após o tratamento (hipersensibilidade pós-escabiose).
Permetrina 5% = tratamento de primeira escolha.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '1f23d009-fb01-5203-9d17-19f92cf3f887'::uuid, '19560a07-f089-52dd-af0b-e9865f96ad5a'::uuid,
        'A', 'Corticosteróides tópicos podem ser úteis em caso de prurido intenso.', 'Incorreta. Após o tratamento escabicida, corticosteroides tópicos de baixa potência podem ser utilizados em casos selecionados para aliviar o prurido e a inflamação residual.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '29a8eb71-2c53-59cb-9e5f-3af4007461df'::uuid, '19560a07-f089-52dd-af0b-e9865f96ad5a'::uuid,
        'B', 'É preciso tratar todos os contactantes.', 'Incorreta. Todos os contactantes domiciliares e parceiros íntimos devem ser tratados simultaneamente, mesmo que estejam assintomáticos, para evitar reinfestações.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'fb9339f8-96bf-5095-b18f-c481871fbb56'::uuid, '19560a07-f089-52dd-af0b-e9865f96ad5a'::uuid,
        'C', 'Ocorre exclusivamente pelo macho na epiderme.', 'Correta. A escabiose é causada principalmente pela fêmea fecundada do Sarcoptes scabiei, que escava túneis na camada córnea da epiderme e deposita seus ovos. O macho tem participação apenas na fecundação e não é responsável pelas lesões típicas.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '74f14ec6-06f7-5a70-9456-d89a9310afe0'::uuid, '19560a07-f089-52dd-af0b-e9865f96ad5a'::uuid,
        'D', 'É contagiosa, com prurido predominantemente noturno.', 'Incorreta. A escabiose é altamente contagiosa por contato direto e caracteriza-se por prurido intenso, com piora durante a noite.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 043 | Turma 118 -T2
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '9ffee39d-a07c-5f0c-901c-f625bf6a4823'::uuid, v_discipline_id, NULL, 'médio',
        'Em relação ao impetigo, é incorreta:', 'single',
        'B', ARRAY[]::text[],
        'O impetigo é uma piodermite superficial altamente contagiosa, causada principalmente por Staphylococcus aureus e Streptococcus pyogenes. A forma não bolhosa é a apresentação mais frequente, enquanto a forma bolhosa decorre da ação das toxinas esfoliativas produzidas pelo S. aureus. As lesões iniciam-se como máculas ou pápulas que evoluem rapidamente para vesículas, pústulas ou bolhas, rompendo-se e originando as típicas crostas melicéricas. A doença predomina em crianças, especialmente em períodos de maior calor e umidade. Nas infecções cutâneas estreptocócicas, a ASLO geralmente permanece normal, sendo o anti-DNase B um marcador mais sensível para documentar infecção estreptocócica prévia.', 'O impetigo é uma piodermite superficial altamente contagiosa, causada principalmente por Staphylococcus aureus e Streptococcus pyogenes.',
        'Não bolhoso = 70% dos casos.
Bolhoso = apenas Staphylococcus aureus.
Crosta melicérica = lesão clássica.
ASLO geralmente não aumenta no impetigo.
Mais comum em crianças e em clima quente/úmido.', 'Atenção ao comando: deve-se marcar a alternativa incorreta ou a exceção.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '2791062a-93a1-5080-9388-13211f389f25'::uuid, '9ffee39d-a07c-5f0c-901c-f625bf6a4823'::uuid,
        'A', 'É mais frequente em crianças nos meses de mais calor.', 'Incorreta. O impetigo é mais comum em crianças e apresenta maior incidência em períodos quentes e úmidos.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '34ca2369-ffaa-5d7f-a669-b5fd53579af1'::uuid, '9ffee39d-a07c-5f0c-901c-f625bf6a4823'::uuid,
        'B', 'A forma clínica mais comum é impetigo bolhoso;', 'Correta. A forma não bolhosa (impetigo contagioso de Tilbury Fox) representa cerca de 70% dos casos, enquanto a forma bolhosa é menos frequente.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '4650f7e3-bb2f-56f2-bd0e-771519d62b01'::uuid, '9ffee39d-a07c-5f0c-901c-f625bf6a4823'::uuid,
        'C', 'Ocorre, inicialmente, mácula eritematosa que evolui rapidamente para bolha ou vesículas que se rompem facilmente;', 'Incorreta. O impetigo inicia-se com mácula ou pápula eritematosa que evolui rapidamente para vesículas, pústulas ou bolhas, que se rompem formando as características crostas melicéricas.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '5bd17c77-06e3-5313-a97a-0a6a859af7a9'::uuid, '9ffee39d-a07c-5f0c-901c-f625bf6a4823'::uuid,
        'D', 'Não há elevação da antiestreptolisina O (ASLO).', 'Incorreta. Nas infecções cutâneas estreptocócicas, como o impetigo, a ASLO geralmente não se eleva, sendo o anti-DNase B o marcador sorológico mais útil.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 044 | Turma 118 -T2
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '4f707617-8a8b-5af1-9232-667a0db9fe82'::uuid, v_discipline_id, NULL, 'médio',
        'Em relação à erisipela, é correto:', 'single',
        'D', ARRAY[]::text[],
        'A erisipela é uma infecção aguda da derme superficial e dos vasos linfáticos, causada predominantemente por Streptococcus pyogenes. Manifesta-se por placa eritematosa, quente, dolorosa, infiltrada e bem delimitada, frequentemente acompanhada de febre e mal-estar. Fatores como tinea pedis, diabetes, insuficiência venosa, linfedema e obesidade favorecem o surgimento da doença. As formas bolhosas e o acometimento facial estão associados a maior gravidade e maior risco de complicações, exigindo tratamento sistêmico e acompanhamento cuidadoso.', 'A erisipela é uma infecção aguda da derme superficial e dos vasos linfáticos, causada predominantemente por Streptococcus pyogenes.',
        'Erisipela = Streptococcus (principal agente).
Porta de entrada clássica = tinea pedis.
Diabetes, insuficiência venosa e linfedema aumentam o risco.
Forma bolhosa e acometimento facial = maior gravidade.
Lesão elevada e bem delimitada diferencia da celulite.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '1cdcb230-2546-5140-8666-a5258c883faf'::uuid, '4f707617-8a8b-5af1-9232-667a0db9fe82'::uuid,
        'A', 'O agente etiológico é predominantemente estreptocócico;', 'Incorreta. A afirmação é verdadeira. O principal agente etiológico da erisipela é o Streptococcus pyogenes (estreptococo β-hemolítico do grupo A), podendo ocorrer, mais raramente, estreptococos dos grupos B, C e G.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '3fc8c556-80c6-54b0-a1de-f18d7e2c5937'::uuid, '4f707617-8a8b-5af1-9232-667a0db9fe82'::uuid,
        'B', 'O estafilococo se estabelece secundariamente;', 'Incorreta. Embora a erisipela seja classicamente estreptocócica, o Staphylococcus aureus pode participar secundariamente em alguns casos, especialmente quando há portas de entrada ou infecção sobreposta.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'bda1d5bf-eca4-5e61-b33c-58ec5db53ef0'::uuid, '4f707617-8a8b-5af1-9232-667a0db9fe82'::uuid,
        'C', 'São fatores de risco: tinea pedis, diabetes, insuficiência venosa entre outros;', 'Incorreta. Fissuras interdigitais por tinea pedis, diabetes mellitus, insuficiência venosa, linfedema, obesidade e traumas cutâneos são importantes fatores predisponentes para erisipela.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '33c4e362-e6ee-56a3-b9c4-9705f694f560'::uuid, '4f707617-8a8b-5af1-9232-667a0db9fe82'::uuid,
        'D', 'A apresentação bolhosa confere maior gravidade assim como a localização facial.', 'Correta. A forma bolhosa está associada a quadros mais exuberantes e maior risco de complicações. A erisipela facial também exige maior atenção devido ao potencial de disseminação e complicações locais.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 045 | Turma 118 -T2
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '04061c99-751c-5c38-8d90-b154e5ef5694'::uuid, v_discipline_id, NULL, 'médio',
        'Em relação às foliculites, é incorreto afirmar:', 'single',
        'D', ARRAY[]::text[],
        'As foliculites compreendem um grupo de doenças inflamatórias do folículo piloso. A foliculite decalvante é uma forma crônica neutrofílica do couro cabeludo, frequentemente associada ao Staphylococcus aureus, caracterizada por pústulas recorrentes, politríquia, fibrose e alopecia cicatricial. A foliculite queloidiana acomete principalmente a nuca, evoluindo com placas fibróticas e queloidianas. Já a foliculite da barba (sicose da barba) é uma infecção crônica dos folículos da região da barba, favorecida pelo barbear. O tratamento da foliculite decalvante costuma ser prolongado, utilizando antibióticos sistêmicos, e a dapsona pode ser empregada como terapia adjuvante em casos selecionados.', 'As foliculites compreendem um grupo de doenças inflamatórias do folículo piloso.',
        'Foliculite decalvante = crônica + alopecia cicatricial + politríquia.
Foliculite queloidiana = nuca + queloides + fibrose.
Foliculite da barba = curso crônico/recorrente.
Dapsona = opção em casos selecionados, não faz milagre.
Foliculite decalvante = tratamento difícil e recidivante.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '2fdc8494-6b56-5aba-908d-da0de9b6fcf6'::uuid, '04061c99-751c-5c38-8d90-b154e5ef5694'::uuid,
        'A', 'Na foliculite decalvante é de evolução crônica, pode causar fibrose e é mais comum nos homens adultos;', 'Incorreta. A foliculite decalvante é uma dermatose inflamatória crônica que acomete principalmente homens adultos, podendo evoluir com fibrose e alopecia cicatricial.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'c99a200f-f214-5325-967b-01aca9f93681'::uuid, '04061c99-751c-5c38-8d90-b154e5ef5694'::uuid,
        'B', 'A foliculite da barba é caracterizada pela cronicidade;', 'Incorreta. A foliculite da barba (sicose da barba) apresenta curso crônico ou recorrente, geralmente relacionada à infecção por Staphylococcus aureus e ao trauma provocado pelo ato de barbear.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '5cee918b-6bc9-5f3c-bf7f-5b3586990569'::uuid, '04061c99-751c-5c38-8d90-b154e5ef5694'::uuid,
        'C', 'A foliculite queloidiana se localiza na nuca, cujas pústulas confluem e levam à formação de fístula e fibrose;', 'Incorreta. A foliculite queloidiana acomete preferencialmente a região occipital e nuca, evoluindo com pápulas, pústulas, fibrose e placas queloidianas. Em casos avançados podem ocorrer trajetos fistulosos.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'c8a8bfc7-ff87-5045-ac6e-c3c3159fac68'::uuid, '04061c99-751c-5c38-8d90-b154e5ef5694'::uuid,
        'D', 'A foliculite decalvante possui tratamento com resultados rápidos e bons, principalmente quando se utiliza dapsona;', 'Correta. A foliculite decalvante apresenta evolução crônica, resposta terapêutica frequentemente lenta e insatisfatória, com elevadas taxas de recidiva. A dapsona pode ser utilizada em casos selecionados, mas não proporciona resultados rápidos nem é considerada tratamento de primeira escolha.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 046 | Turma 118 -T2
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '629d2877-1048-5e0a-8655-44b62ff186c6'::uuid, v_discipline_id, NULL, 'médio',
        'Em relação à esporotricose, é correto:', 'single',
        'C', ARRAY[]::text[],
        'A esporotricose é uma micose subcutânea causada por fungos do complexo Sporothrix, adquirida principalmente por inoculação traumática ou contato com gatos infectados. A forma cutaneolinfática é a mais frequente, caracterizada por nódulos ulcerados distribuídos ao longo dos vasos linfáticos. O itraconazol é o tratamento de primeira escolha, enquanto a anfotericina B é reservada para formas graves, disseminadas ou em pacientes imunossuprimidos. O principal achado histopatológico sugestivo é o corpo asteroide, enquanto os corpos fumagoides são típicos da cromoblastomicose.', 'A esporotricose é uma micose subcutânea causada por fungos do complexo Sporothrix, adquirida principalmente por inoculação traumática ou contato com gatos infectados.',
        'Forma mais comum = cutaneolinfática (70–80%).
Itraconazol = tratamento de escolha.
Iodeto de potássio = alternativa clássica.
Anfotericina B = formas graves/disseminadas.
Corpos asteroides = esporotricose; corpos fumagoides = cromoblastomicose.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '537d7b31-2ded-5116-b78b-9169eea03d7e'::uuid, '629d2877-1048-5e0a-8655-44b62ff186c6'::uuid,
        'A', 'É uma infecção aguda ou subaguda causada por S. schenkii;', 'Incorreta. A esporotricose é uma infecção subaguda ou crônica, causada por fungos do complexo Sporothrix spp., e não tipicamente uma infecção aguda.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '27b831c6-d5ea-5182-9fee-c44025b82437'::uuid, '629d2877-1048-5e0a-8655-44b62ff186c6'::uuid,
        'B', 'A forma cutânea localizada, é a forma mais comum (70% dos casos) pode aspecto verrucoso faz diagnóstico diferencial com paracoccidioidomicose, leishmaniose, cromomicose entre outras;', 'Incorreta. A forma cutaneolinfática é a apresentação mais frequente, correspondendo a cerca de 70–80% dos casos. A forma cutânea localizada é menos comum.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '023af549-1496-5473-bec4-000f1f766213'::uuid, '629d2877-1048-5e0a-8655-44b62ff186c6'::uuid,
        'C', 'Pode-se empregar o itraconazol como tratamento de escolha assim como o iodeto de potássio, o fluconazol, a terbinafina, também podemos usar anfotericina B lipossomal e deoxicolato nas formas graves;', 'Correta. O itraconazol é o tratamento de primeira escolha. A solução saturada de iodeto de potássio é uma alternativa clássica. Terbinafina e fluconazol podem ser utilizados em situações específicas, e a anfotericina B (lipossomal ou desoxicolato) está indicada nas formas graves, disseminadas ou extracutâneas.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '141beed1-b35c-5288-af60-eb4a74527596'::uuid, '629d2877-1048-5e0a-8655-44b62ff186c6'::uuid,
        'D', 'Na histopatologia, encontra-se os corpos fumagóides.', 'Incorreta. Os corpos fumagoides (corpos escleróticos ou de Medlar) são característicos da cromoblastomicose. Na esporotricose, podem ser encontrados granulomas e, ocasionalmente, corpos asteroides.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 047 | Turma 118 -T2
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '7196fbce-c5d8-5d4e-be9d-d69a852d4324'::uuid, v_discipline_id, NULL, 'médio',
        'Em relação à cromomicose, é correto:', 'single',
        'A', ARRAY[]::text[],
        'A cromoblastomicose é uma micose subcutânea crônica causada por fungos demáceos, adquirida por inoculação traumática durante atividades rurais. O principal agente etiológico no Brasil é Fonsecaea pedrosoi. O diagnóstico é estabelecido pela demonstração dos corpos fumagoides (corpos escleróticos ou de Medlar) no exame micológico direto ou histopatológico, enquanto a cultura permite identificar a espécie envolvida. A transmissão ocorre a partir do ambiente, não havendo transmissão inter-humana. O tratamento costuma ser prolongado e frequentemente associa antifúngicos sistêmicos, como itraconazol ou terbinafina, a métodos físicos, como crioterapia ou cirurgia.', 'A cromoblastomicose é uma micose subcutânea crônica causada por fungos demáceos, adquirida por inoculação traumática durante atividades rurais.',
        'Zona rural + trauma = cromoblastomicose.
Não existe transmissão inter-humana.
Brasil → Fonsecaea pedrosoi.
Corpos fumagoides = diagnóstico da doença.
Cultura = identifica a espécie.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'aec76a48-71a9-5a7a-82f5-ba2c933ea5f5'::uuid, '7196fbce-c5d8-5d4e-be9d-d69a852d4324'::uuid,
        'A', 'É encontrada em regiões tropicais e subtropicais;', 'Correta. A cromoblastomicose é uma micose subcutânea típica de regiões tropicais e subtropicais, predominando em trabalhadores rurais expostos a traumas com vegetação, madeira e solo.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '76a8a822-d450-5c35-a59a-c00b6478dd58'::uuid, '7196fbce-c5d8-5d4e-be9d-d69a852d4324'::uuid,
        'B', 'O número de casos de registro inter-humano vem aumentando e é a forma mais comum de transmissão;', 'Incorreta. A transmissão não ocorre de pessoa para pessoa. A infecção é adquirida quase sempre por inoculação traumática de fungos demáceos presentes no ambiente.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '6889ceb8-ede7-57fe-86f3-aa491b656607'::uuid, '7196fbce-c5d8-5d4e-be9d-d69a852d4324'::uuid,
        'C', 'No Brasil, a Fonsecaea compacta é a espécie mais frequente;', 'Incorreta. No Brasil, a espécie mais frequentemente isolada é a Fonsecaea pedrosoi. Fonsecaea compacta é um agente menos comum.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '03f26281-4585-5de2-98ab-2f77b5225da7'::uuid, '7196fbce-c5d8-5d4e-be9d-d69a852d4324'::uuid,
        'D', 'A identificação das espécies é realizada exclusivamente por meio do exame micológico direto.', 'Incorreta. O exame micológico direto evidencia os corpos fumagoides (corpos escleróticos ou de Medlar), confirmando o diagnóstico. A identificação da espécie depende da cultura.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 048 | Turma 118 -T2
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        'a3e6eb60-2879-55cc-a384-4eec95e537d5'::uuid, v_discipline_id, NULL, 'médio',
        'A pediculose é uma dermatozoonose comum em nosso meio, é correto afirmar:', 'single',
        'D', ARRAY[]::text[],
        'A pediculose do couro cabeludo é uma ectoparasitose causada pelo Pediculus humanus capitis, frequente em crianças em idade escolar, especialmente no sexo feminino. O principal sintoma é o prurido intenso, decorrente da reação de hipersensibilidade à saliva do parasita, predominando nas regiões occipital e retroauricular. O diagnóstico é essencialmente clínico, baseado na visualização de piolhos vivos ou lêndeas aderidas aos fios de cabelo, que podem ser vistas a olho nu; a dermatoscopia constitui um método complementar. O tratamento inclui permetrina 1%, repetição após 7 dias, remoção mecânica com pente fino e abordagem dos contactantes para evitar reinfestações.', 'A pediculose do couro cabeludo é uma ectoparasitose causada pelo Pediculus humanus capitis, frequente em crianças em idade escolar, especialmente no sexo feminino.',
        'Pediculose = escolares + mulheres.
Prurido predominante nas regiões occipital e retroauricular.
Lêndeas são visíveis a olho nu; a dermatoscopia apenas auxilia na confirmação e diferenciação de lêndeas viáveis, cascas vazias e pseudolêndeas.
Pente fino + permetrina 1% + repetir após 7 dias = tratamento clássico.
Sempre examinar e tratar os contactantes quando indicado.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'e95e0f24-45e1-5f50-8787-51057c1f5adc'::uuid, 'a3e6eb60-2879-55cc-a384-4eec95e537d5'::uuid,
        'A', 'O prurido é intenso, principalmente nas áreas parietais;', 'Incorreta. O prurido pode ser intenso, mas predomina especialmente nas regiões occipital e retroauricular, e não principalmente nas áreas parietais.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'ddac3f52-3236-5b46-aa52-2d9dee000c43'::uuid, 'a3e6eb60-2879-55cc-a384-4eec95e537d5'::uuid,
        'B', 'Só é possível a visualização das lêndeas à dermatoscopia;', 'Incorreta. As lêndeas podem ser identificadas a olho nu, firmemente aderidas à haste dos cabelos. A dermatoscopia é apenas um método auxiliar, útil para confirmar o diagnóstico e diferenciar lêndeas viáveis, cascas vazias e pseudolêndeas.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'bf265402-aae7-531b-8983-d681c7679fa1'::uuid, 'a3e6eb60-2879-55cc-a384-4eec95e537d5'::uuid,
        'C', 'O prurido é leve, quase inexistente, na pediculose pubiana;', 'Incorreta. A pediculose pubiana geralmente provoca prurido intenso, principalmente à noite, podendo apresentar escoriações e máculas cerúleas.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '075bf5d0-d01c-5ede-8c9a-20c7b01315a1'::uuid, 'a3e6eb60-2879-55cc-a384-4eec95e537d5'::uuid,
        'D', 'A pediculose da cabeça tem preferência por escolares e mulheres.', 'Correta. A pediculose do couro cabeludo é mais frequente em crianças em idade escolar e no sexo feminino, possivelmente pelo contato próximo e pela maior frequência de cabelos longos.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 049 | Turma 118 -T2
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '70b30b16-102c-5c19-ac5f-d3403e0d5dd9'::uuid, v_discipline_id, NULL, 'médio',
        'Em relação à tungíase, é incorreto:', 'single',
        'D', ARRAY[]::text[],
        'A tungíase é uma ectoparasitose causada pela pulga Tunga penetrans, comum em regiões tropicais e em indivíduos que caminham descalços. A fêmea penetra na epiderme, originando um nódulo amarelado com ponto negro central, geralmente localizado nos pés. O tratamento de escolha consiste na remoção completa do parasita em condições assépticas, seguida de cuidados locais e profilaxia antitetânica quando indicada. Antibióticos são reservados para infecção bacteriana secundária. Apesar de já ter sido estudada, a ivermectina não demonstrou benefício consistente, não sendo recomendada como tratamento de rotina.', 'A tungíase é uma ectoparasitose causada pela pulga Tunga penetrans, comum em regiões tropicais e em indivíduos que caminham descalços.',
        'Tungíase = Tunga penetrans.
Lesão clássica = nódulo amarelado + ponto negro central.
Poucas lesões → extração mecânica.
Sempre atualizar vacina antitetânica quando necessário.
Ivermectina não faz parte do tratamento de rotina da tungíase.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '1961bf35-3fd8-5949-8473-a0845424d28e'::uuid, '70b30b16-102c-5c19-ac5f-d3403e0d5dd9'::uuid,
        'A', 'É autolimitada, produzida pela Tunga penetrans;', 'Incorreta. A tungíase é causada pela Tunga penetrans e pode evoluir para resolução espontânea após a morte do parasita, embora o tratamento seja recomendado para prevenir complicações.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '66a31061-e75e-5496-8445-ee4a409309bf'::uuid, '70b30b16-102c-5c19-ac5f-d3403e0d5dd9'::uuid,
        'B', 'A lesão elementar é um nódulo, amarelada com ponto negro central;', 'Incorreta. A lesão típica é um nódulo ou pápula amarelada, com um ponto negro central, que corresponde à porção posterior do abdome da pulga em contato com o meio externo.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '4d61205a-f7a4-5d88-a6d7-1399c149a1f0'::uuid, '70b30b16-102c-5c19-ac5f-d3403e0d5dd9'::uuid,
        'C', 'O tratamento consiste em remoção completa do parasita quando poucas lesões;', 'Incorreta. A extração completa e cuidadosa do parasita é o tratamento de escolha quando há poucas lesões, reduzindo o risco de infecção secundária.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '8e11627d-b89c-5495-987e-015b11aa97ae'::uuid, '70b30b16-102c-5c19-ac5f-d3403e0d5dd9'::uuid,
        'D', 'Quando houver infestação maciça, o tiabendazol ou ivermectina devem ser prescritos.', 'Correta. Embora o tratamento principal seja a remoção mecânica, a ivermectina não apresenta eficácia comprovada e não é recomendada rotineiramente para tungíase. O tiabendazol tópico pode ser utilizado em alguns casos, mas a ivermectina não constitui tratamento padrão para infestações maciças.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 050 | Turma 118 -T2
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '0677c3e0-c615-587a-8579-7c7796f25419'::uuid, v_discipline_id, NULL, 'médio',
        'Em relação ao tratamento da acne, é incorreta:', 'single',
        'A', ARRAY[]::text[],
        'O tratamento da acne deve ser individualizado conforme a gravidade das lesões. Os retinoides tópicos são a base do tratamento por normalizarem a queratinização folicular e prevenirem a formação de novos comedões. O peróxido de benzoíla possui ação bactericida contra Cutibacterium acnes e reduz o risco de resistência aos antibióticos, motivo pelo qual estes não devem ser utilizados em monoterapia. Os peelings químicos podem atuar como terapia adjuvante na acne leve e no tratamento de sequelas, enquanto os nódulos representam inflamação profunda, característica das formas moderadas e graves da doença.', 'O tratamento da acne deve ser individualizado conforme a gravidade das lesões.',
        'Nódulo = inflamação profunda.
Retinoides = comedolíticos (principal ação).
Peróxido de benzoíla + antibiótico = reduz resistência bacteriana.
Peelings = podem tratar acne leve e cicatrizes.
Nunca usar antibiótico isoladamente.', 'Atenção ao comando: deve-se marcar a alternativa incorreta ou a exceção.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'd4c38ca0-9e5b-5230-8896-1bf9546d6def'::uuid, '0677c3e0-c615-587a-8579-7c7796f25419'::uuid,
        'A', 'Na acne papulopustulosa, quando há nódulos decorrem de um processo inflamatório superficial;', 'Correta. Os nódulos da acne resultam de um processo inflamatório profundo, envolvendo a derme, e não superficial. São lesões características das formas mais graves da doença.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'c3b44aaa-e1af-5769-8eb7-7855b4a8abc7'::uuid, '0677c3e0-c615-587a-8579-7c7796f25419'::uuid,
        'B', 'No tratamento local, podemos usar ácido retinoico, porém tem ação anti-inflamatória maior;', 'Incorreta. Os retinoides tópicos (como ácido retinoico, adapaleno e tretinoína) atuam principalmente como comedolíticos e normalizadores da queratinização folicular. Embora possuam algum efeito anti-inflamatório, essa não é sua principal ação.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'c3610062-e3fe-5da4-91bf-a607ca8d08b6'::uuid, '0677c3e0-c615-587a-8579-7c7796f25419'::uuid,
        'C', 'Os peelings químicos são indicados tanto para acne quanto para cicatrizes;', 'Incorreta. Os peelings químicos podem ser utilizados como tratamento adjuvante da acne ativa, especialmente comedoniana e papulopustulosa leve, além de serem úteis no tratamento de cicatrizes superficiais e hiperpigmentação pós-inflamatória.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '8fc65419-9312-5954-87f2-ee82312e517d'::uuid, '0677c3e0-c615-587a-8579-7c7796f25419'::uuid,
        'D', 'A monoterapia com antibióticos deve ser evitada.', 'Incorreta. A monoterapia com antibióticos tópicos ou sistêmicos não é recomendada devido ao risco de resistência bacteriana. Devem ser associados a retinoides tópicos e/ou peróxido de benzoíla.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 051 | Turma 118 -T2
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        'de26c824-79f7-5c16-9a3b-d059d731c823'::uuid, v_discipline_id, NULL, 'médio',
        'Em relação à acne, são corretas, exceto:', 'single',
        'D', ARRAY[]::text[],
        'A acne vulgar é uma doença inflamatória crônica da unidade pilossebácea, caracterizada por períodos de exacerbação e remissão. O diagnóstico é clínico e, em formas graves, pode estar associada a síndromes como a SAPHO. Atualmente, há evidências de que fatores dietéticos, especialmente alimentos de alto índice glicêmico e o consumo de leite, podem influenciar sua evolução. O tratamento combina medidas tópicas e sistêmicas, podendo incluir procedimentos adjuvantes, como a extração de comedões, sempre associada à terapia medicamentosa.', 'A acne vulgar é uma doença inflamatória crônica da unidade pilossebácea, caracterizada por períodos de exacerbação e remissão.',
        'Acne = doença crônica, não aguda.
Alimentos de alto índice glicêmico e leite podem piorar a acne.
Diagnóstico é clínico.
SAPHO → lembre da acne conglobata.
Extração de comedões = tratamento adjuvante, nunca substitui a terapia medicamentosa.', 'Atenção ao comando: deve-se marcar a alternativa incorreta ou a exceção.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'bbcde1cf-c695-59ad-9cd5-4b5e45e3d7cd'::uuid, 'de26c824-79f7-5c16-9a3b-d059d731c823'::uuid,
        'A', 'A ingestão de certos alimentos pode ter relação com acne vulgar;', 'Incorreta. Evidências atuais demonstram associação entre acne e dietas de alto índice glicêmico, além do consumo excessivo de leite e derivados em indivíduos suscetíveis.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'e6ab4390-4f37-5160-a8ec-f053b05022b7'::uuid, 'de26c824-79f7-5c16-9a3b-d059d731c823'::uuid,
        'B', 'A extração mecânica dos comedões logo após o início do tratamento é de grande importância;', 'Incorreta. A extração mecânica dos comedões pode ser utilizada como tratamento adjuvante, principalmente após o início da terapia medicamentosa, para acelerar a melhora clínica.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '0b051c9c-2d99-569b-bc21-b7b44a6d5fc4'::uuid, 'de26c824-79f7-5c16-9a3b-d059d731c823'::uuid,
        'C', 'O diagnóstico é clínico e pode fazer parte de síndromes como SAPHO;', 'Incorreta. O diagnóstico da acne é essencialmente clínico. Formas graves, como a acne conglobata, podem estar associadas à síndrome SAPHO (Sinovite, Acne, Pustulose, Hiperostose e Osteíte).'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'd85c3fc9-d5bb-533d-b43b-be2fa08ef38a'::uuid, 'de26c824-79f7-5c16-9a3b-d059d731c823'::uuid,
        'D', 'A doença é aguda com fases de acalmia e exacerbação.', 'Correta. A acne é uma doença crônica, caracterizada por períodos de melhora e exacerbação. Portanto, afirmar que é uma doença aguda está incorreto.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 052 | Dermatoviroses - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        'c741ebf6-103c-5666-9962-8c45ac86a227'::uuid, v_discipline_id, NULL, 'médio',
        'Escolar, com 6 anos de idade, é trazido pela mãe com lesões em face, pescoço, axilas e coxas, individualizadas, na cor da pele, em forma de cúpula, com umbilicação central. Mãe relata que “espremeu” uma lesão, com saída de uma substância clara de dentro da lesão e que o primo do paciente apresenta o mesmo quadro clínico. Trata-se de:', 'single',
        'A', ARRAY[]::text[],
        'O molusco contagioso é uma infecção cutânea causada por um Poxvírus, frequente na infância e transmitida por contato direto ou autoinoculação. Caracteriza-se por pápulas peroladas, em forma de cúpula, com umbilicação central, das quais pode ser expresso um material esbranquiçado contendo partículas virais. O diagnóstico é essencialmente clínico, e a doença costuma ser autolimitada, embora tratamentos como curetagem, crioterapia ou agentes tópicos possam ser indicados em casos selecionados.', 'O molusco contagioso é uma infecção cutânea causada por um Poxvírus, frequente na infância e transmitida por contato direto ou autoinoculação.',
        'Molusco contagioso = criança + pápula perolada + umbilicação central.
Ao comprimir → sai material esbranquiçado (corpúsculos de molusco).
Transmissão por contato direto, sendo comum entre irmãos e colegas.
Pitiríase versicolor = máculas descamativas.
Varicela = vesículas em vários estágios evolutivos.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'b7218bc4-6520-5740-a69c-69f5bf1563b8'::uuid, 'c741ebf6-103c-5666-9962-8c45ac86a227'::uuid,
        'A', 'Molusco contagioso.', 'Correta. O quadro é clássico de molusco contagioso, caracterizado por pápulas peroladas, cor da pele, de superfície lisa, formato em cúpula e umbilicação central. Ao serem comprimidas, eliminam um material esbranquiçado rico em corpúsculos de molusco. É comum em crianças e altamente contagioso por contato direto.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '2218a063-e48a-5c9a-8755-71ac744988b6'::uuid, 'c741ebf6-103c-5666-9962-8c45ac86a227'::uuid,
        'B', 'Glândulas sebáceas ectópicas.', 'Incorreta. As glândulas sebáceas ectópicas (grânulos de Fordyce) são achados benignos, geralmente localizados em mucosas labiais e genitais, sem umbilicação central e sem transmissão entre contatos.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'ad5583b8-783c-5686-8bd9-229ead5893ab'::uuid, 'c741ebf6-103c-5666-9962-8c45ac86a227'::uuid,
        'C', 'Pitiríase versicolor.', 'Incorreta. A pitiríase versicolor apresenta máculas hipo ou hipercromias com descamação fina, sem lesões papulosas em cúpula ou umbilicação central.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '1b1f2334-1f2f-5fb9-9b63-9098f5c00750'::uuid, 'c741ebf6-103c-5666-9962-8c45ac86a227'::uuid,
        'D', 'Varicela-zóster.', 'Incorreta. A varicela caracteriza-se por lesões vesiculares em diferentes estágios evolutivos ("gota de orvalho sobre pétala de rosa"), acompanhadas de febre e prurido, não apresentando pápulas umbilicadas persistentes.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 053 | Dermatoviroses - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        'f37df542-2203-5aef-bda9-ca2f21800f22'::uuid, v_discipline_id, NULL, 'médio',
        'Criança de 3 anos, hígida, apresenta múltiplas pápulas cor da pele, lisas e firmes, de 0,1 a 0,3 cm, com umbilicação central, localizadas na região lateral do tronco, assintomáticas, que surgiram há cerca de 1 mês. Com base no quadro clínico descrito, assinale a alternativa CORRETA:', 'single',
        'E', ARRAY[]::text[],
        'O molusco contagioso é uma infecção cutânea causada por um Poxvírus, frequente em crianças. Apresenta-se como pápulas firmes, peroladas e umbilicadas, localizadas principalmente no tronco, axilas e membros. O diagnóstico é clínico e a doença costuma ser autolimitada, porém pode ser tratada com curetagem, crioterapia ou agentes tópicos quando as lesões são numerosas, persistentes ou causam desconforto estético.', 'O molusco contagioso é uma infecção cutânea causada por um Poxvírus, frequente em crianças.',
        'Pápula perolada + umbilicação central = molusco contagioso.
Agente etiológico = Poxvírus.
Transmissão = contato direto e autoinoculação.
Tratamento quando indicado = curetagem, crioterapia ou agentes tópicos.
Verruga = HPV; Molusco = Poxvírus.', 'Atenção ao comando: apenas uma alternativa deve corresponder integralmente ao enunciado.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '9be72b3e-1c45-52f0-a7a3-900d23ab9228'::uuid, 'f37df542-2203-5aef-bda9-ca2f21800f22'::uuid,
        'A', 'O diagnóstico é de verruga viral, causada pelo herpesvírus hominis e o tratamento é a crioterapia.', 'Incorreta. As verrugas virais são causadas pelo Papilomavírus Humano (HPV), e não pelo herpesvírus. Além disso, a presença de umbilicação central é característica de molusco contagioso.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '4f7cc956-f21b-5f4b-949a-e1a51e1f96a4'::uuid, 'f37df542-2203-5aef-bda9-ca2f21800f22'::uuid,
        'B', 'O diagnóstico é de prurido por insetos ou urticária papular e os agentes mais prováveis seriam pulgas ou percevejos, porque as lesões estão em área coberta.', 'Incorreta. A urticária papular cursa com pápulas intensamente pruriginosas, geralmente sem umbilicação central. O caso descrito é assintomático e típico de molusco contagioso.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '13679513-40bd-593f-a271-99d632bdc938'::uuid, 'f37df542-2203-5aef-bda9-ca2f21800f22'::uuid,
        'C', 'O diagnóstico é de molusco contagioso, uma doença transmitida por artrópodes, e o tratamento é a ivermectina oral.', 'Incorreta. O molusco contagioso é causado por um Poxvírus e transmitido principalmente por contato direto e autoinoculação, não por artrópodes. A ivermectina oral não faz parte do tratamento de rotina.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '6894c4f6-2cbb-57f6-a858-c719bd689033'::uuid, 'f37df542-2203-5aef-bda9-ca2f21800f22'::uuid,
        'D', 'O diagnóstico é de verruga viral, causada pelo Papilomavírus Humano (HPV) e o tratamento é a eletrocoagulação das lesões.', 'Incorreta. Embora as verrugas sejam causadas pelo HPV, o quadro clínico descrito é compatível com molusco contagioso, devido às pápulas peroladas com umbilicação central.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '467d0842-7007-5bcd-b3e0-7f0cef11b894'::uuid, 'f37df542-2203-5aef-bda9-ca2f21800f22'::uuid,
        'E', 'O diagnóstico é de molusco contagioso, causado por um poxvírus, e o tratamento é a curetagem das lesões.', 'Correta. O molusco contagioso é uma infecção causada por um Poxvírus, caracterizada por pápulas peroladas, firmes e umbilicadas. A curetagem é uma das principais opções terapêuticas quando há indicação de tratamento.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 054 | Dermatoviroses - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '1c7e0bec-6b82-5141-9384-ef46c250149b'::uuid, v_discipline_id, NULL, 'médio',
        'Criança de 7 anos apresenta lesões peroladas, lisas, em forma de cúpula e com umbilicação central, que estão se espalhando pelo corpo rapidamente nos últimos meses. Surgem mais no pescoço, face e coxas. Sobre esta lesão, pode-se afirmar que:', 'single',
        'A', ARRAY[]::text[],
        'O molusco contagioso é uma infecção viral causada por um Poxvírus, predominante na infância. Caracteriza-se por pápulas lisas, peroladas e umbilicadas, geralmente assintomáticas, podendo disseminar-se por autoinoculação. Crianças com dermatite atópica apresentam maior risco de desenvolver lesões extensas devido ao comprometimento da barreira cutânea e ao ato de coçar. O diagnóstico é clínico, e a doença costuma ser autolimitada, embora curetagem, crioterapia ou agentes tópicos possam ser indicados em casos selecionados.', 'O molusco contagioso é uma infecção viral causada por um Poxvírus, predominante na infância.',
        'Molusco = Poxvírus + pápulas peroladas + umbilicação central.
Mais comum em crianças.
Dermatite atópica favorece lesões numerosas e disseminadas.
Adulto → pensar em transmissão sexual ou imunossupressão.
Autoinoculação explica o surgimento de novas lesões.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'f8032a3d-2240-5de6-90c8-f7a354127f56'::uuid, '1c7e0bec-6b82-5141-9384-ef46c250149b'::uuid,
        'A', 'É mais frequente em pacientes com dermatite atópica.', 'Correta. O molusco contagioso é mais frequente e costuma ser mais disseminado em pacientes com dermatite atópica, devido à alteração da barreira cutânea e à autoinoculação favorecida pelo prurido.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '5f4ef65a-c770-5448-b095-e1b41bf8b2c4'::uuid, '1c7e0bec-6b82-5141-9384-ef46c250149b'::uuid,
        'B', 'O agente infeccioso está ausente.', 'Incorreta. O molusco contagioso é causado por um Poxvírus, portanto há um agente infeccioso claramente definido.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '3160a703-76c2-5341-b48d-78bf727f264d'::uuid, '1c7e0bec-6b82-5141-9384-ef46c250149b'::uuid,
        'C', 'É uma lesão muito pruriginosa e dolorosa, sendo difícil diferenciá-la do prurigo estrófulo.', 'Incorreta. As lesões costumam ser assintomáticas ou discretamente pruriginosas, não sendo tipicamente dolorosas. O aspecto clínico com umbilicação central facilita sua diferenciação do prurigo estrófulo.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'f2b97fd8-2559-5716-9655-c8f114d10a37'::uuid, '1c7e0bec-6b82-5141-9384-ef46c250149b'::uuid,
        'D', 'Ocorre mais comumente em pacientes adultos.', 'Incorreta. O molusco contagioso é mais frequente em crianças, especialmente entre 2 e 10 anos. Em adultos, costuma estar relacionado à transmissão sexual ou à imunossupressão.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 055 | Dermatoviroses - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        'e26a6015-a35a-52f0-9cd3-2857f929011a'::uuid, v_discipline_id, NULL, 'médio',
        'Sobre o Herpes zoster é CORRETO afirmar:', 'single',
        'B', ARRAY[]::text[],
        'O herpes-zóster resulta da reativação do vírus Varicella-zoster, permanecendo latente nos gânglios sensitivos após a infecção primária (varicela). O quadro caracteriza-se por dor neuropática que antecede o surgimento de vesículas agrupadas, distribuídas de forma unilateral ao longo de um dermátomo, sem ultrapassar a linha média. As principais complicações incluem neuralgia pós-herpética, zóster oftálmico e síndrome de Ramsay Hunt, sendo mais frequente em idosos e pacientes imunossuprimidos.', 'O herpes-zóster resulta da reativação do vírus Varicella-zoster, permanecendo latente nos gânglios sensitivos após a infecção primária (varicela).',
        'Dor antes da lesão = herpes-zóster.
Dermátomo + unilateral + não cruza a linha média.
Ramsay Hunt = paralisia facial + vesículas na orelha.
Hutchinson = lesão na ponta do nariz → risco de zóster oftálmico.
Idosos e imunossuprimidos = maior risco.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '40887289-30e0-507c-a68d-3933e94bd366'::uuid, 'e26a6015-a35a-52f0-9cd3-2857f929011a'::uuid,
        'A', 'É mais frequente em pessoas jovens.', 'Incorreta. O herpes-zóster é mais frequente em idosos e indivíduos imunossuprimidos, devido à redução da imunidade celular contra o vírus Varicella-zoster.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '1e24fba6-f8f9-50a6-995f-e9639fa0bba7'::uuid, 'e26a6015-a35a-52f0-9cd3-2857f929011a'::uuid,
        'B', 'A dor costuma preceder o aparecimento das lesões.', 'Correta. A dor neuropática, queimação, parestesia ou hiperestesia geralmente precedem o surgimento das vesículas em 2 a 5 dias, constituindo o pródromo clássico da doença.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '332650f6-807d-5b0a-b4f1-cac2efd9e5c1'::uuid, 'e26a6015-a35a-52f0-9cd3-2857f929011a'::uuid,
        'C', 'Associadas à paralisia facial, lesões em pavilhão auricular e conduto auditivo externo com sintomas vestibulococleares caracterizam o Sinal de Hutchinson.', 'Incorreta. Esse quadro caracteriza a Síndrome de Ramsay Hunt. O Sinal de Hutchinson corresponde à presença de lesões na ponta do nariz, indicando acometimento do ramo nasociliar do nervo trigêmeo e maior risco de comprometimento ocular.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'a487752c-e408-5450-9d7c-5f9b38940e38'::uuid, 'e26a6015-a35a-52f0-9cd3-2857f929011a'::uuid,
        'D', 'A erupção costuma ocorrer de forma simétrica, acometendo ambos os lados do corpo, atravessando a linha média.', 'Incorreta. O herpes-zóster apresenta distribuição unilateral, seguindo um dermátomo e, caracteristicamente, não ultrapassa a linha média.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 056 | Dermatoviroses - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '53d69f6d-c0f8-5748-a20d-03629319e184'::uuid, v_discipline_id, NULL, 'médio',
        'Sobre o Herpes zoster é correto afirmar:', 'single',
        'C', ARRAY[]::text[],
        'O herpes-zóster é causado pela reativação do vírus Varicella-zoster, permanecendo latente nos gânglios sensitivos após a varicela. O quadro caracteriza-se por dor neuropática seguida de vesículas agrupadas em distribuição dermatomérica unilateral. O início precoce da terapia antiviral, idealmente nas primeiras 72 horas, reduz a duração da doença, favorece a cicatrização das lesões e diminui o risco de complicações, especialmente a neuralgia pós-herpética, a mais frequente em idosos.', 'O herpes-zóster é causado pela reativação do vírus Varicella-zoster, permanecendo latente nos gânglios sensitivos após a varicela.',
        'Dor → depois vesículas → dermátomo = herpes-zóster.
Antiviral até 72 horas = melhor benefício.
Principal complicação = neuralgia pós-herpética.
Lesões unilaterais e não cruzam a linha média.
Idosos e imunossuprimidos = maior risco.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '0b05af6c-2235-5a8b-92c6-5f6358f6ff64'::uuid, '53d69f6d-c0f8-5748-a20d-03629319e184'::uuid,
        'A', 'É mais frequente em pessoas jovens.', 'Incorreta. O herpes-zóster ocorre principalmente em idosos e pacientes imunossuprimidos, devido à redução da imunidade celular contra o vírus Varicella-zoster.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'c9abe66d-dd48-580c-963d-7c42609e02d6'::uuid, '53d69f6d-c0f8-5748-a20d-03629319e184'::uuid,
        'B', 'A dor só tem início após o surgimento das lesões cutâneas.', 'Incorreta. A dor neuropática geralmente precede o aparecimento das lesões em 2 a 5 dias, podendo persistir após sua resolução.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'e82b9d53-42dd-5097-8296-afc7aafc20ed'::uuid, '53d69f6d-c0f8-5748-a20d-03629319e184'::uuid,
        'C', 'O tratamento antiviral precoce é fundamental para prevenir a neuralgia pós-herpética', 'Correta. O tratamento com antivirais (aciclovir, valaciclovir ou fanciclovir), iniciado preferencialmente nas primeiras 72 horas, reduz a duração da doença, acelera a cicatrização e diminui o risco de neuralgia pós-herpética, especialmente em idosos.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'bcdee563-01bf-55d2-b867-ac2978c18ee6'::uuid, '53d69f6d-c0f8-5748-a20d-03629319e184'::uuid,
        'D', 'A erupção costuma ocorrer de forma simétrica, acometendo ambos os lados do corpo, atravessando a linha média.', 'Incorreta. O herpes-zóster apresenta distribuição unilateral, seguindo um dermátomo e, caracteristicamente, não ultrapassa a linha média.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 057 | Dermatoviroses - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        'd948dc39-f72c-5b2a-967c-286c388f6a4b'::uuid, v_discipline_id, NULL, 'médio',
        'Criança de 7 anos apresenta lesões peroladas, lisas, em forma de cúpula e com umbilicação central, que estão se espalhando pelo corpo rapidamente nos últimos meses, ocorrendo em pescoço, face e coxas. Sobre esta lesão, pode-se afirmar que:', 'single',
        'A', ARRAY[]::text[],
        '', 'Criança de 7 anos apresenta lesões peroladas, lisas, em forma de cúpula e com umbilicação central, que estão se espalhando pelo corpo rapidamente nos últimos meses, ocorrendo em pescoço, face e coxas.',
        '', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '3935d061-53b0-5736-b916-663ef99b1d1c'::uuid, 'd948dc39-f72c-5b2a-967c-286c388f6a4b'::uuid,
        'A', 'É mais frequente em pacientes com dermatite atópica.', 'Correta. O molusco contagioso é mais frequente e pode apresentar lesões mais numerosas em pacientes com dermatite atópica, devido à alteração da barreira cutânea e à autoinoculação favorecida pelo prurido.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '931fea79-2011-58ef-bdb4-1015ee58b81d'::uuid, 'd948dc39-f72c-5b2a-967c-286c388f6a4b'::uuid,
        'B', 'O agente infeccioso está ausente na lesão.', 'Incorreta. O molusco contagioso é causado por um Poxvírus, que está presente nas lesões, especialmente no material esbranquiçado eliminado à expressão.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'd074d04f-1b6d-57f3-a38d-1ee54b4c08c5'::uuid, 'd948dc39-f72c-5b2a-967c-286c388f6a4b'::uuid,
        'C', 'É uma lesão muito pruriginosa e dolorosa.', 'Incorreta. As lesões costumam ser assintomáticas ou discretamente pruriginosas, não sendo tipicamente dolorosas.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '7385dd1f-cc7f-59a7-b8e0-ea0fec25dad7'::uuid, 'd948dc39-f72c-5b2a-967c-286c388f6a4b'::uuid,
        'D', 'Ocorre mais comumente em pacientes adultos.', 'Incorreta. O molusco contagioso é mais frequente em crianças. Em adultos, quando presente, costuma estar associado à transmissão sexual ou à imunossupressão.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 058 | Dermatoviroses - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '4d6e8df7-0bef-5eee-a497-765570a376ce'::uuid, v_discipline_id, NULL, 'médio',
        'Os vírus da família Herpesviridae são agentes etiológicos de infecções no homem e em animais, capazes de permanecer longo tempo em latência na célula do hospedeiro. A respeito do herpes simples, marque a alternativa correta:', 'single',
        'D', ARRAY[]::text[],
        'O herpes simples é causado pelos vírus HSV-1 e HSV-2, pertencentes à família Herpesviridae. Após a infecção primária, o vírus permanece em latência nos gânglios sensitivos, podendo sofrer reativações ao longo da vida. O HSV-1 é classicamente associado às infecções orofaciais e costuma ser adquirido ainda na infância, enquanto o HSV-2 é o principal agente do herpes genital, transmitido predominantemente por contato sexual. Entretanto, mudanças no comportamento sexual aumentaram a participação do HSV-1 nos casos de herpes genital.', 'O herpes simples é causado pelos vírus HSV-1 e HSV-2, pertencentes à família Herpesviridae.',
        'HSV-1 → acima da cintura (boca e face).
HSV-2 → abaixo da cintura (genital).
HSV-1 geralmente é adquirido na infância.
Ambos permanecem latentes nos gânglios sensitivos e podem reativar.
HSV-1 também pode causar herpes genital, mas com menor frequência que o HSV-2.', 'Atenção ao comando: apenas uma alternativa deve corresponder integralmente ao enunciado.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '3978474a-dd6c-5990-9202-a30fd57bb4a4'::uuid, '4d6e8df7-0bef-5eee-a497-765570a376ce'::uuid,
        'A', 'O herpes vírus tipo 2 (HSV-2) é responsável pela maioria dos casos de herpes simples na face e tronco.', 'Incorreta. O HSV-1 é o principal responsável pelas infecções orofaciais, enquanto o HSV-2 está mais frequentemente associado ao herpes genital.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '51991dc4-7233-52d8-9787-4e4bab8f3934'::uuid, '4d6e8df7-0bef-5eee-a497-765570a376ce'::uuid,
        'B', 'O herpes vírus tipo 1 (HSV-1) é o principal causador do herpes genital.', 'Incorreta. Embora o HSV-1 tenha aumentado sua participação nos casos de herpes genital, especialmente em adultos jovens, o HSV-2 permanece como o principal agente etiológico dessa infecção.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '8a50b32c-aa4c-5cde-9f23-7e3c5c63532f'::uuid, '4d6e8df7-0bef-5eee-a497-765570a376ce'::uuid,
        'C', 'A transmissão do herpes vírus tipo 1 (HSV-1) ocorre principalmente por contato sexual.', 'Incorreta. O HSV-1 é transmitido principalmente por contato direto com saliva ou secreções orais, geralmente durante a infância.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'cf4486ce-0c97-5687-815d-feb33a15646d'::uuid, '4d6e8df7-0bef-5eee-a497-765570a376ce'::uuid,
        'D', 'A transmissão do herpes vírus tipo 1 (HSV-1) ocorre geralmente abaixo dos 10 anos de idade.', 'Correta. A infecção primária pelo HSV-1 ocorre, na maioria das vezes, na infância, antes dos 10 anos, por contato íntimo com saliva ou secreções de indivíduos infectados.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 059 | Dermatoviroses - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        'e5e47dbb-f6e9-5e9a-8bcf-b0bde26e64cd'::uuid, v_discipline_id, NULL, 'médio',
        'Quanto ao vírus varicela-zoster, é INCORRETO afirmar que:', 'single',
        'C', ARRAY[]::text[],
        'O vírus varicela-zóster (VZV) causa inicialmente a varicela, geralmente adquirida na infância. Após a resolução da infecção primária, o vírus permanece latente nos gânglios sensitivos, podendo ser reativado anos ou décadas depois, originando o herpes-zóster. A reativação é favorecida pela redução da imunidade celular, sendo mais comum em idosos, pacientes com HIV, neoplasias ou em uso de imunossupressores. O herpes-zóster caracteriza-se por dor neuropática seguida de vesículas agrupadas em distribuição dermatomérica unilateral.', 'O vírus varicela-zóster (VZV) causa inicialmente a varicela, geralmente adquirida na infância.',
        'Varicela = primoinfecção.
Herpes-zóster = reativação do VZV latente.
Latência → gânglios sensitivos.
Idosos e imunossuprimidos = maior risco de reativação.
O vírus permanece latente por toda a vida.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '601ecd47-1a09-54a9-ba2b-ae72f02a1d3a'::uuid, 'e5e47dbb-f6e9-5e9a-8bcf-b0bde26e64cd'::uuid,
        'A', 'Em geral, infecta o homem na infância.', 'Incorreta. A infecção primária pelo vírus varicela-zóster (varicela) ocorre, na maioria dos casos, durante a infância.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'a77ab817-50fc-511b-a3cf-63be2e8ee4e8'::uuid, 'e5e47dbb-f6e9-5e9a-8bcf-b0bde26e64cd'::uuid,
        'B', 'Após a fase de disseminação hematogênica, caminha pelos nervos periféricos até os gânglios nervosos, onde poderá permanecer em latência por toda a vida.', 'Incorreta. Após a infecção primária, o vírus permanece latente nos gânglios sensitivos por toda a vida, podendo reativar-se anos depois.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'f6453974-7567-517e-ac90-2e4fda7503bd'::uuid, 'e5e47dbb-f6e9-5e9a-8bcf-b0bde26e64cd'::uuid,
        'C', 'O Herpes-zoster resulta da primoinfecção pelo vírus varicela-zóster.', 'Correta. O herpes-zóster não resulta da primoinfecção. Ele decorre da reativação do vírus varicela-zóster que permaneceu latente após a varicela.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '2c060816-9d1b-5931-997e-43ae6bbbee9b'::uuid, 'e5e47dbb-f6e9-5e9a-8bcf-b0bde26e64cd'::uuid,
        'D', 'Indivíduos imunodeprimidos por doenças como malignidades ou infecção pelo HIV, ou em uso de medicamentos imunossupressores, têm maior risco para reativação do vírus varicela-zoster.', 'Incorreta. A imunossupressão é um dos principais fatores de risco para a reativação do VZV e o desenvolvimento do herpes-zóster.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 060 | Dermatoviroses - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '2c8e7246-d5ba-5f5a-b1ff-70a473ad105c'::uuid, v_discipline_id, NULL, 'médio',
        'Alguns indivíduos podem permanecer com sintoma de dor mesmo após a resolução das lesões cutâneas de herpes zoster, configurando a neuralgia pós-herpética. Marque a alternativa INCORRETA quanto a esse quadro:', 'single',
        'A', ARRAY[]::text[],
        'A neuralgia pós-herpética é a principal complicação do herpes-zóster e caracteriza-se pela persistência da dor neuropática após a resolução das lesões cutâneas, geralmente por mais de 90 dias. O risco aumenta com a idade, sendo muito mais frequente em idosos e imunossuprimidos. O tratamento baseia-se em fármacos para dor neuropática, como gabapentina, pregabalina e amitriptilina, enquanto o uso precoce de antivirais durante a fase aguda do herpes-zóster reduz sua incidência e gravidade.', 'A neuralgia pós-herpética é a principal complicação do herpes-zóster e caracteriza-se pela persistência da dor neuropática após a resolução das lesões cutâneas, geralmente por mais de 90 dias.',
        'Idoso + herpes-zóster = pense em neuralgia pós-herpética.
É a complicação mais comum da doença.
Dor persiste após a cicatrização das lesões (≥ 90 dias).
Gabapentina, pregabalina e amitriptilina = principais tratamentos.
Antiviral iniciado até 72 horas ajuda a reduzir o risco da complicação.', 'Atenção ao comando: deve-se marcar a alternativa incorreta ou a exceção.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '73996dda-7514-5f28-af48-0a743e10c5b4'::uuid, '2c8e7246-d5ba-5f5a-b1ff-70a473ad105c'::uuid,
        'A', 'A neuralgia pós-herpética é mais comum em jovens do que em idosos.', 'Correta. A neuralgia pós-herpética é muito mais frequente em idosos, especialmente acima dos 60 anos, devido ao maior comprometimento da imunidade celular e da regeneração neural.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '3dd3b47c-862f-588a-ba64-4ea9e0512f72'::uuid, '2c8e7246-d5ba-5f5a-b1ff-70a473ad105c'::uuid,
        'B', 'Pode ser intensa e pode persistir por meses, caso não seja realizado tratamento adequado.', 'Incorreta. A neuralgia pós-herpética pode causar dor neuropática intensa e persistir por meses ou até anos, comprometendo significativamente a qualidade de vida.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '5f2d8072-e52e-5dca-968b-2a66de23bf45'::uuid, '2c8e7246-d5ba-5f5a-b1ff-70a473ad105c'::uuid,
        'C', 'É a complicação mais comum do herpes zoster.', 'Incorreta. A neuralgia pós-herpética é a complicação mais frequente do herpes-zóster, principalmente em idosos e imunossuprimidos.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '2c08c421-dfa8-5662-9d86-93be461637a1'::uuid, '2c8e7246-d5ba-5f5a-b1ff-70a473ad105c'::uuid,
        'D', 'Em seu tratamento, podem ser usadas medicações como carbamazepina, amitriptilina e gabapentina.', 'Incorreta. O tratamento inclui medicamentos para dor neuropática, como gabapentina, pregabalina e antidepressivos tricíclicos (amitriptilina). A carbamazepina pode ser utilizada em situações específicas, embora não seja considerada primeira escolha.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 061 | Dermatoviroses - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        'db7671ff-5bc5-5bd1-b5c4-ba7c0ced667b'::uuid, v_discipline_id, NULL, 'médio',
        'Dentre as alternativas abaixo, marque a que contém opção terapêutica para o tratamento do molusco contagioso.', 'single',
        'D', ARRAY[]::text[],
        'O molusco contagioso é uma infecção cutânea causada por um Poxvírus, caracterizada por pápulas peroladas com umbilicação central. Em crianças imunocompetentes, a doença geralmente é autolimitada, podendo desaparecer espontaneamente em meses. Quando o tratamento é indicado, as principais opções são curetagem, crioterapia e alguns agentes tópicos, especialmente em casos com múltiplas lesões, autoinoculação ou repercussão estética. O aciclovir não possui atividade contra o Poxvírus e, portanto, não deve ser utilizado.', 'O molusco contagioso é uma infecção cutânea causada por um Poxvírus, caracterizada por pápulas peroladas com umbilicação central.',
        'Molusco = Poxvírus (não é herpes).
Aciclovir → herpes simples e herpes-zóster.
Curetagem = tratamento clássico do molusco.
Crioterapia e agentes tópicos também podem ser utilizados.
Em crianças imunocompetentes, a doença costuma ser autolimitada.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'efd2bcbc-edfa-5c09-af5b-4f3d21bb72dc'::uuid, 'db7671ff-5bc5-5bd1-b5c4-ba7c0ced667b'::uuid,
        'A', 'Aciclovir oral', 'Incorreta. O molusco contagioso é causado por um Poxvírus, portanto o aciclovir, que atua contra herpesvírus, não possui eficácia no seu tratamento.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '0097f50f-1283-5041-8275-95e21e2883de'::uuid, 'db7671ff-5bc5-5bd1-b5c4-ba7c0ced667b'::uuid,
        'B', 'Corticoide tópico', 'Incorreta. Corticoides tópicos não tratam o molusco contagioso. Podem ser utilizados apenas para controlar dermatite eczematosa associada ao redor das lesões.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'ccdffda0-1684-539a-988e-54b62a8afe5a'::uuid, 'db7671ff-5bc5-5bd1-b5c4-ba7c0ced667b'::uuid,
        'C', 'Aciclovir tópico', 'Incorreta. Assim como o aciclovir oral, não apresenta ação contra o Poxvírus responsável pelo molusco contagioso.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '9ba6f466-a8a1-5f50-b61a-8723e0b40e4a'::uuid, 'db7671ff-5bc5-5bd1-b5c4-ba7c0ced667b'::uuid,
        'D', 'Curetagem', 'Correta. A curetagem é uma das principais opções terapêuticas para o molusco contagioso, promovendo a remoção das lesões. Outras alternativas incluem crioterapia e agentes tópicos em casos selecionados.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 062 | Dermatoviroses - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '7d8381db-83f1-5f9c-881d-4dc6c83afe59'::uuid, v_discipline_id, NULL, 'médio',
        'Marque a alternativa que NÃO está relacionada ao herpes zóster:', 'single',
        'B', ARRAY[]::text[],
        'O herpes-zóster resulta da reativação do vírus Varicella-zoster latente nos gânglios sensitivos. Além das lesões vesiculares em distribuição dermatomérica, pode causar complicações como neuralgia pós-herpética, zóster oftálmico e síndrome de Ramsay Hunt, esta caracterizada por paralisia facial periférica associada a vesículas no ouvido e sintomas vestibulococleares. O reconhecimento precoce dessas complicações é fundamental para o início imediato da terapia antiviral e redução das sequelas.', 'O herpes-zóster resulta da reativação do vírus Varicella-zoster latente nos gânglios sensitivos.',
        'Ramsay Hunt = Face + Orelha + Ouvido.
Paralisia facial.
Vesículas auriculares.
Vertigem e perda auditiva.
Hutchinson = ponta do nariz → risco de zóster oftálmico.
Neuralgia pós-herpética = complicação mais comum.
Memória não tem relação com Ramsay Hunt.', 'Atenção ao comando: deve-se marcar a alternativa incorreta ou a exceção.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '7295a830-c6ce-53a4-996e-2c8a89d05402'::uuid, '7d8381db-83f1-5f9c-881d-4dc6c83afe59'::uuid,
        'A', 'Pode ocorrer acometimento do nervo facial com paralisia facial.', 'Incorreta. O acometimento do nervo facial pode ocorrer no herpes-zóster, especialmente na síndrome de Ramsay Hunt, levando à paralisia facial periférica.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'f169e0af-6768-53db-950f-26511297351a'::uuid, '7d8381db-83f1-5f9c-881d-4dc6c83afe59'::uuid,
        'B', 'Pode ocasionar síndrome de Ramsay-Hunt, que é caracterizada por distúrbios de memória.', 'Correta. A síndrome de Ramsay Hunt caracteriza-se por paralisia facial periférica, vesículas no pavilhão auricular e/ou conduto auditivo externo, otalgia e sintomas vestibulococleares, como vertigem e perda auditiva. Distúrbios de memória não fazem parte do quadro clínico.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'd92c0530-0471-568c-ab26-92e7f038598a'::uuid, '7d8381db-83f1-5f9c-881d-4dc6c83afe59'::uuid,
        'C', 'Pode ocorrer acometimento da córnea pelo comprometimento do ramo oftálmico do nervo trigêmeo.', 'Incorreta. O herpes-zóster oftálmico resulta do acometimento do ramo oftálmico (V1) do nervo trigêmeo, podendo causar ceratite, uveíte e outras complicações oculares.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'fb3a4088-ed55-5976-948f-25a39d095446'::uuid, '7d8381db-83f1-5f9c-881d-4dc6c83afe59'::uuid,
        'D', 'Pode ocorrer neuralgia pós-herpética.', 'Incorreta. A neuralgia pós-herpética é a complicação mais frequente do herpes-zóster, principalmente em idosos.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 063 | Dermatoviroses - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '9000ebaa-a57f-54f7-878b-7b2ee3a4550e'::uuid, v_discipline_id, NULL, 'médio',
        'Em relação ao herpes vírus, é incorreto afirmar:', 'single',
        'B', ARRAY[]::text[],
        'O herpes simples é causado pelos vírus HSV-1 e HSV-2, que permanecem em latência nos gânglios sensitivos após a infecção primária. A maioria das primo-infecções é assintomática, mas alguns pacientes desenvolvem vesículas agrupadas sobre base eritematosa, frequentemente precedidas por sintomas prodrômicos. O HSV-1 está associado principalmente às infecções orolabiais, enquanto o HSV-2 é o principal agente do herpes genital. O vírus Varicella-zoster corresponde ao HHV-3 e não faz parte do grupo dos vírus do herpes simples.', 'O herpes simples é causado pelos vírus HSV-1 e HSV-2, que permanecem em latência nos gânglios sensitivos após a infecção primária.',
        'HSV-1 = herpes orolabial.
HSV-2 = herpes genital.
VZV (HHV-3) = varicela e herpes-zóster.
Pródromos (ardor, dor e prurido) antecedem as vesículas.
A maioria das primo-infecções é assintomática.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'ccec8a79-8354-5b23-a024-55000450c6ee'::uuid, '9000ebaa-a57f-54f7-878b-7b2ee3a4550e'::uuid,
        'A', 'Clinicamente é caracterizada por formação de vesículas e pode ser acompanhado por sintomas prodrômicas', 'Incorreta. O herpes simples caracteriza-se por vesículas agrupadas sobre base eritematosa, frequentemente precedidas por pródromos como ardor, prurido, dor ou parestesia.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'e8fdb1ad-db83-5200-824b-27f13110cc12'::uuid, '9000ebaa-a57f-54f7-878b-7b2ee3a4550e'::uuid,
        'B', 'Há 2 tipos de vírus do herpes simples: o tipo 1 e o tipo 3', 'Correta. Existem dois tipos de vírus do herpes simples: HSV-1 e HSV-2. O tipo 3 corresponde ao vírus Varicella-zoster (VZV), responsável pela varicela e pelo herpes-zóster, e não ao herpes simples.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'ea10e692-746b-5a20-84a3-0d17edf52ee7'::uuid, '9000ebaa-a57f-54f7-878b-7b2ee3a4550e'::uuid,
        'C', 'A inoculação viral, em 90% dos casos, leva infecção inaparente', 'Incorreta. A infecção primária pelo HSV é assintomática na maioria dos indivíduos, estimando-se que cerca de 90% dos casos sejam inaparentes.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '0bc18fbb-29dc-5eca-8447-8cd8b55cf08b'::uuid, '9000ebaa-a57f-54f7-878b-7b2ee3a4550e'::uuid,
        'D', 'A primo-infecção pode ser assintomática ou oligossintomática', 'Incorreta. A primo-infecção pelo herpes simples pode ser totalmente assintomática ou apresentar manifestações leves (oligossintomáticas), especialmente em crianças.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 064 | Dermatoviroses - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '0f81080d-75eb-5619-ad0c-95e1ca30b114'::uuid, v_discipline_id, NULL, 'médio',
        'Em relação a infecção do vírus varicela-zóster, é incorreto:', 'single',
        'A', ARRAY[]::text[],
        'O herpes-zóster resulta da reativação do vírus Varicella-zoster, que permanece latente nos gânglios sensitivos após a varicela. A doença é mais comum em idosos e indivíduos imunossuprimidos. O tratamento antiviral precoce reduz a duração da fase vesicular, acelera a cicatrização e diminui o risco de complicações, especialmente a neuralgia pós-herpética. O contato direto com as lesões pode transmitir o vírus para indivíduos suscetíveis, que desenvolverão varicela, e não herpes-zóster.', 'O herpes-zóster resulta da reativação do vírus Varicella-zoster, que permanece latente nos gânglios sensitivos após a varicela.',
        'Varicela = primoinfecção.
Herpes-zóster = reativação do VZV.
Idosos e imunossuprimidos = maior risco.
Antiviral até 72 horas = reduz duração da doença e risco de complicações.
Herpes-zóster transmite varicela, não herpes-zóster.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '2647544a-3423-511c-8118-38774caffbf9'::uuid, '0f81080d-75eb-5619-ad0c-95e1ca30b114'::uuid,
        'A', 'O herpes zoster tem incidência predominante antes da 5a década de vida', 'Correta. O herpes-zóster ocorre predominantemente após a 5a década de vida, sendo mais frequente em idosos e imunossuprimidos devido à redução da imunidade celular.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'ec02f18b-86df-5fc4-ab49-2e25bf52be3e'::uuid, '0f81080d-75eb-5619-ad0c-95e1ca30b114'::uuid,
        'B', 'O tratamento com antiviral diminui o tempo de evolução de vesiculação.', 'Incorreta. O tratamento antiviral precoce (preferencialmente nas primeiras 72 horas) reduz a formação de novas vesículas, acelera a cicatrização e diminui a duração da doença.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '8eca227c-75d8-5b96-b7ab-6603c7202aa1'::uuid, '0f81080d-75eb-5619-ad0c-95e1ca30b114'::uuid,
        'C', 'Pode transmitir varicela àqueles que ainda não tiveram.', 'Incorreta. O contato direto com as vesículas do herpes-zóster pode transmitir o vírus Varicella-zoster, causando varicela em indivíduos suscetíveis que nunca tiveram a doença ou não foram vacinados.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '19ee14aa-933b-58fc-b57d-a578e24f37b6'::uuid, '0f81080d-75eb-5619-ad0c-95e1ca30b114'::uuid,
        'D', 'O vírus fica latente nos gânglios paravertebrais e pode ser reativado a qualquer momento', 'Incorreta. Após a infecção primária (varicela), o vírus permanece latente nos gânglios sensitivos, especialmente nos gânglios da raiz dorsal e de nervos cranianos, podendo reativar-se anos depois.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 065 | Dermatoviroses - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        'edc8c626-4f03-5531-bdc1-679c8bd8d3e1'::uuid, v_discipline_id, NULL, 'médio',
        'Sobre o molusco contagioso, é correto afirmar:', 'single',
        'C', ARRAY[]::text[],
        'O molusco contagioso é uma infecção cutânea causada por um Poxvírus, predominante na infância. Clinicamente, apresenta pápulas peroladas com umbilicação central, transmitidas por contato direto ou autoinoculação. Embora seja uma doença autolimitada, as lesões podem persistir por vários meses. Quando há indicação de tratamento, a curetagem é uma das opções mais eficazes, podendo também ser utilizados crioterapia e agentes tópicos em casos selecionados.', 'O molusco contagioso é uma infecção cutânea causada por um Poxvírus, predominante na infância.',
        'Molusco = Poxvírus (um dos maiores vírus).
Principal acometido = criança.
Tratamento clássico = curetagem.
Lesões persistem por meses, não semanas.
Adulto → pensar em transmissão sexual ou imunossupressão.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'f5ad6d05-b706-50af-be22-234d6b0e3192'::uuid, 'edc8c626-4f03-5531-bdc1-679c8bd8d3e1'::uuid,
        'A', 'Causada pelo Poxvírus, caracterizado pelo menor vírus que se conhece.', 'Incorreta. O molusco contagioso é causado por um Poxvírus, porém os poxvírus estão entre os maiores vírus conhecidos, e não os menores.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'f74156c0-3646-59bc-941b-d86af0be2fc9'::uuid, 'edc8c626-4f03-5531-bdc1-679c8bd8d3e1'::uuid,
        'B', 'É tipicamente de adultos, sendo considerada uma infecção sexualmente transmissível.', 'Incorreta. O molusco contagioso ocorre principalmente em crianças. Em adultos, pode ser transmitido sexualmente, mas essa não é sua apresentação mais comum.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '422916ac-e164-5558-8213-8f813f24a5d3'::uuid, 'edc8c626-4f03-5531-bdc1-679c8bd8d3e1'::uuid,
        'C', 'A curetagem é o melhor método de tratamento.', 'Correta. A curetagem é considerada um dos métodos mais eficazes para remoção das lesões quando há indicação de tratamento. Outras opções incluem crioterapia e agentes tópicos.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '6d23653e-2ee4-5ba6-88f9-84e108e6bffa'::uuid, 'edc8c626-4f03-5531-bdc1-679c8bd8d3e1'::uuid,
        'D', 'As lesões persistem por pouco tempo (em geral, 1-2 semanas).', 'Incorreta. O molusco contagioso é uma doença autolimitada, porém as lesões costumam persistir por meses, podendo permanecer por até 1 a 2 anos em alguns pacientes.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 066 | Dermatoviroses - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        'cdf582ff-d5c8-540d-891a-7c23d7060733'::uuid, v_discipline_id, NULL, 'médio',
        'Sobre as infecções por Vírus Herpes Simplex 1 e 2, assinale a alternativa incorreta:', 'single',
        'E', ARRAY[]::text[],
        'Os vírus Herpes Simplex tipos 1 e 2 (HSV-1 e HSV-2) pertencem à família Herpesviridae e têm como característica marcante a capacidade de permanecer em latência nos gânglios sensitivos após a infecção primária. O HSV-1 está associado principalmente ao herpes orolabial, enquanto o HSV-2 é o principal agente do herpes genital, embora ambos possam acometer qualquer localização. A reativação viral pode ser desencadeada por estresse, febre, exposição solar, trauma ou imunossupressão, resultando em episódios recorrentes da doença.', 'Os vírus Herpes Simplex tipos 1 e 2 (HSV-1 e HSV-2) pertencem à família Herpesviridae e têm como característica marcante a capacidade de permanecer em latência nos gânglios sensitivos após a infecção primária.',
        'HSV-1 → gengivoestomatite e herpes labial.
HSV-2 → principal agente do herpes genital.
Todos os herpesvírus permanecem latentes.
Latência do HSV → gânglios sensitivos (trigeminal e sacrais).
Imunossuprimidos → quadros mais extensos e recorrentes.', 'Atenção ao comando: deve-se marcar a alternativa incorreta ou a exceção.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '97173625-976c-57cf-bbb7-e57b062834f5'::uuid, 'cdf582ff-d5c8-540d-891a-7c23d7060733'::uuid,
        'A', 'Os primeiros episódios da infecção orofacial costumam ser gengivoestomatite e faringite.', 'Incorreta. A primo-infecção pelo HSV-1 frequentemente manifesta-se como gengivoestomatite herpética ou faringite, especialmente em crianças.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '32b17851-511f-52fd-8f2c-c62ce63e020f'::uuid, 'cdf582ff-d5c8-540d-891a-7c23d7060733'::uuid,
        'B', 'O Herpes labial é causado por esses agentes virais.', 'Incorreta. O herpes labial é causado principalmente pelo HSV-1, embora o HSV-2 também possa, ocasionalmente, acometer a região orolabial.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'da49ee07-18f6-576a-aec9-fe9aec71f8eb'::uuid, 'cdf582ff-d5c8-540d-891a-7c23d7060733'::uuid,
        'C', 'As infecções cutâneas são mais comuns em imunossuprimidos.', 'Incorreta. Pacientes imunossuprimidos apresentam maior risco de infecções cutâneas extensas, recorrentes e graves por HSV.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '747b55ea-b597-5a5a-b4cc-bb1abb1cefe5'::uuid, 'cdf582ff-d5c8-540d-891a-7c23d7060733'::uuid,
        'D', 'Herpes genital é um dos acometimentos frequentes dessa infecção, constituindo-se em um Infecção sexualmente transmissível (IST).', 'Incorreta. O herpes genital é uma das ISTs mais frequentes, sendo causado principalmente pelo HSV-2, embora o HSV-1 também possa estar envolvido.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '3feeb8d0-5a7b-57bf-84ee-a41b46efdd60'::uuid, 'cdf582ff-d5c8-540d-891a-7c23d7060733'::uuid,
        'E', 'O vírus do tipo herpes simples, diferente de alguns outros Herpesvírus humanos, não costumam permanecer latentes no indivíduo.', 'Correta. O HSV-1 e o HSV-2 permanecem em latência nos gânglios sensitivos por toda a vida, podendo sofrer reativações periódicas. A latência é uma das principais características dos herpesvírus.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 067 | Dermatoviroses - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '76ba9f5b-f358-5333-8706-05e28eb190fe'::uuid, v_discipline_id, NULL, 'médio',
        'O Vírus da Varicela-Zoster (HHV-3) é responsável por duas entidades clínicas relacionadas entre si. A respeito delas, assinale a alternativa correta:', 'single',
        'D', ARRAY[]::text[],
        'O vírus Varicella-zoster (HHV-3) causa inicialmente a varicela, adquirida por transmissão respiratória, com disseminação sistêmica e surgimento de vesículas em diferentes estágios evolutivos, predominando em tronco e face. Após a resolução da infecção, o vírus permanece latente nos gânglios sensitivos e pode ser reativado anos depois, originando o herpes-zóster, especialmente em idosos e imunossuprimidos. O tratamento precoce com antivirais reduz a duração da doença e o risco de complicações.', 'O vírus Varicella-zoster (HHV-3) causa inicialmente a varicela, adquirida por transmissão respiratória, com disseminação sistêmica e surgimento de vesículas em diferentes estágios evolutivos, predominando em tronco e face.',
        'Varicela = primoinfecção.
Herpes-zóster = reativação do VZV.
Entrada do vírus = vias respiratórias.
Varicela → lesões começam no tronco e face (distribuição centrípeta).
Latência = gânglios sensitivos.', 'Atenção ao comando: apenas uma alternativa deve corresponder integralmente ao enunciado.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '77e9fd8d-17ec-5c95-818f-eda2aa1020b0'::uuid, '76ba9f5b-f358-5333-8706-05e28eb190fe'::uuid,
        'A', 'Não existe nenhum tipo de tratamento farmacológico para essa condição, sendo possível realizar apenas prevenção e tratamento paliativo.', 'Incorreta. Tanto a varicela quanto o herpes-zóster podem ser tratados com antivirais, como aciclovir, valaciclovir e fanciclovir, principalmente em pacientes de risco ou quando iniciados precocemente'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '0f630138-dcc4-5f37-a4fe-dd9507c39e85'::uuid, '76ba9f5b-f358-5333-8706-05e28eb190fe'::uuid,
        'B', 'A varicela dificilmente chega ao organismo pelas vias aéreas, ficando restrita a pele, onde causa a formação de vesículas e crostas.', 'Incorreta. A infecção pelo VZV ocorre principalmente pelas vias respiratórias, seguida de disseminação hematogênica até a pele, onde surgem as lesões características.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'ca8c29b3-c6aa-58fa-9225-8ca3e05b6c60'::uuid, '76ba9f5b-f358-5333-8706-05e28eb190fe'::uuid,
        'C', 'Essas lesões aparecem primeiramente nas extremidades, atingindo, na sequência, o tronco do paciente.', 'Incorreta. A varicela apresenta distribuição centrípeta, iniciando-se geralmente em face e tronco, com posterior acometimento das extremidades.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '46802368-33a4-5fa4-9758-8636af48a357'::uuid, '76ba9f5b-f358-5333-8706-05e28eb190fe'::uuid,
        'D', 'O Herpes zóster é a reativação do da varicela.', 'Correta. O herpes-zóster resulta da reativação do vírus Varicella-zoster, que permaneceu latente nos gânglios sensitivos após a infecção primária (varicela).'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 068 | Dermatoviroses - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        'b3ca796a-8f4f-5058-bfcf-44f024ab6f46'::uuid, v_discipline_id, NULL, 'médio',
        'Assinale a opção correta no que se refere à varicela, causada pelo vírus varicela-zoster (VZV):', 'single',
        'B', ARRAY[]::text[],
        'A varicela é a manifestação da primoinfecção pelo vírus Varicella-zoster (VZV), transmitido principalmente por via respiratória. Caracteriza-se por um exantema vesicular pruriginoso, cujas lesões coexistem em diferentes estágios evolutivos, predominando inicialmente em tronco e face. O diagnóstico é, na maioria dos casos, clínico, e a doença costuma ser autolimitada em crianças imunocompetentes, embora possa evoluir com complicações em pacientes de maior risco.', 'A varicela é a manifestação da primoinfecção pelo vírus Varicella-zoster (VZV), transmitido principalmente por via respiratória.',
        'Varicela = muito prurido.
Lesões em vários estágios ao mesmo tempo = achado clássico.
Mácula → pápula → vesícula → crosta.
Diagnóstico geralmente é clínico.
Doença costuma ser benigna em crianças saudáveis.', 'Atenção ao comando: apenas uma alternativa deve corresponder integralmente ao enunciado.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'b073f859-61c4-5974-a437-ae732646c018'::uuid, 'b3ca796a-8f4f-5058-bfcf-44f024ab6f46'::uuid,
        'A', 'A maioria dos casos de varicela não se apresenta com prurido.', 'Incorreta. A varicela é tipicamente pruriginosa, sendo o prurido um dos principais sintomas da doença, frequentemente intenso.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '65ccaf07-152a-5bf5-b7f1-d75bb0c32814'::uuid, 'b3ca796a-8f4f-5058-bfcf-44f024ab6f46'::uuid,
        'B', 'A varicela caracteriza-se por exantema maculopapular, com presença de vesículas e crostas em diferentes estágios.', 'Correta. A varicela evolui com lesões que passam por máculas, pápulas, vesículas e crostas, coexistindo em diferentes fases evolutivas ("céu estrelado" ou "gota de orvalho sobre pétala de rosa"), característica clássica da doença.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '4a9a05f4-8d34-5daf-a658-d29e9f3c974a'::uuid, 'b3ca796a-8f4f-5058-bfcf-44f024ab6f46'::uuid,
        'C', 'Estas manifestações clínicas apresentam-se comumente como doença grave, evoluindo para óbito.', 'Incorreta. Na maioria das crianças imunocompetentes, a varicela é uma doença benigna e autolimitada. Formas graves ocorrem principalmente em adultos, gestantes, recém-nascidos e imunossuprimidos.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'fef6cc4e-5a46-55d0-af29-5bc91d47545d'::uuid, 'b3ca796a-8f4f-5058-bfcf-44f024ab6f46'::uuid,
        'D', 'O diagnóstico laboratorial deve ser realizado a partir do cultivo da amostra clínica em meio de cultura.', 'Incorreta. O diagnóstico da varicela é essencialmente clínico. Quando necessário, exames como PCR ou imunofluorescência são preferidos, pois o cultivo viral é pouco utilizado na prática.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 069 | Dermatoviroses - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        'f636acf8-3883-5929-a91a-b0aba1595d5a'::uuid, v_discipline_id, NULL, 'médio',
        'Você é médico em uma Unidade de Saúde da Família e uma mãe traz seu filho de 7 anos para a consulta, pois o menino iniciou com lesões no tronco, ombros e face (imagem abaixo) há alguns dias. As lesões não são pruriginosas, não doem, mas estão se espalhando e a mãe está preocupada, pois tem outros filhos e a criança frequenta a escola. O diagnóstico mais provável é:', 'single',
        'A', ARRAY[]::text[],
        'O molusco contagioso é uma infecção cutânea causada por um Poxvírus, frequente na infância. Caracteriza-se por pápulas firmes, peroladas e umbilicadas, geralmente assintomáticas, que podem disseminar-se por autoinoculação. O diagnóstico é clínico e a doença costuma ser autolimitada, embora curetagem, crioterapia ou agentes tópicos possam ser indicados quando há múltiplas lesões, disseminação importante ou repercussão estética.', 'O molusco contagioso é uma infecção cutânea causada por um Poxvírus, frequente na infância.',
        'Criança + pápulas peroladas + umbilicação central = molusco contagioso.
Poxvírus = agente etiológico.
Assintomático ou pouco pruriginoso.
Transmissão por contato direto e autoinoculação.
Varicela = vesículas pruriginosas; Herpes-zóster = dermátomo doloroso.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', '/questions/dermatologia/dermatologia_p2_q069.png'
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '9245891c-fee2-52f8-9840-e850643865d0'::uuid, 'f636acf8-3883-5929-a91a-b0aba1595d5a'::uuid,
        'A', 'molusco contagioso', 'Correta. O molusco contagioso caracteriza-se por pápulas peroladas, lisas, em forma de cúpula, com umbilicação central, geralmente assintomáticas e frequentes em crianças. A transmissão ocorre por contato direto e autoinoculação, justificando a disseminação das lesões.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '476218a7-e96e-583b-9c0c-fd750c0e9a9f'::uuid, 'f636acf8-3883-5929-a91a-b0aba1595d5a'::uuid,
        'B', 'varicela', 'Incorreta. A varicela cursa com vesículas intensamente pruriginosas, acompanhadas de febre e lesões em diferentes estágios evolutivos (máculas, pápulas, vesículas e crostas), o que não corresponde ao caso.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '33a7d82f-fe6d-5070-b9fa-0a569eefae03'::uuid, 'f636acf8-3883-5929-a91a-b0aba1595d5a'::uuid,
        'C', 'penfigoide bolhoso', 'Incorreta. O penfigoide bolhoso acomete principalmente idosos, manifestando-se por bolhas tensas sobre base eritematosa, sendo extremamente raro em crianças.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '6442e62b-378e-5589-aecd-0d1249de0500'::uuid, 'f636acf8-3883-5929-a91a-b0aba1595d5a'::uuid,
        'D', 'herpes-zóster', 'Incorreta. O herpes-zóster apresenta vesículas agrupadas em distribuição dermatomérica unilateral, geralmente dolorosas, não se disseminando de forma difusa em crianças imunocompetentes.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 070 | Dermatoviroses - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        'c1a33fe6-2384-5fdb-bbde-d80d8ab70c3a'::uuid, v_discipline_id, NULL, 'médio',
        'Em relação a infecção pelo herpes simples, é incorreto:', 'single',
        'C', ARRAY[]::text[],
        'O herpes simples é causado pelos vírus HSV-1 e HSV-2, que permanecem latentes nos gânglios sensitivos após a infecção primária. A maioria das primo-infecções é assintomática, enquanto os casos sintomáticos podem manifestar-se como gengivoestomatite, herpes labial, herpes genital ou panarício herpético. Em pacientes imunossuprimidos, as lesões tendem a ser mais extensas, persistentes e disseminadas, exigindo tratamento antiviral precoce.', 'O herpes simples é causado pelos vírus HSV-1 e HSV-2, que permanecem latentes nos gânglios sensitivos após a infecção primária.',
        'HSV-1 → herpes labial e panarício herpético.
HSV-2 → principal agente do herpes genital.
≈90% das primo-infecções são assintomáticas.
Imunossuprimidos → quadros mais graves e disseminados.
Todos os herpesvírus permanecem latentes nos gânglios sensitivos.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '9d02832d-a622-5c0c-9008-c322f128a705'::uuid, 'c1a33fe6-2384-5fdb-bbde-d80d8ab70c3a'::uuid,
        'A', 'O panarício herpético é, em geral, causado pelo herpes tipo 1.', 'Incorreta. O panarício herpético é causado principalmente pelo HSV-1, especialmente em crianças e profissionais da saúde expostos à saliva. O HSV-2 também pode estar envolvido, porém com menor frequência.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '99cf2788-b171-5ce1-a64e-4f3f870c5ac7'::uuid, 'c1a33fe6-2384-5fdb-bbde-d80d8ab70c3a'::uuid,
        'B', 'Herpes simples tipo 2 ocorre, majoritariamente, na região genital, cerca de 80-90% dos casos, e 10-20% dos casos de herpes labial.', 'Incorreta. O HSV-2 é responsável pela maioria dos casos de herpes genital (80–90%). Embora possa causar herpes labial, isso ocorre em uma pequena parcela dos casos.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '5b2c6acb-e7c6-5265-9b74-31b55cd9226c'::uuid, 'c1a33fe6-2384-5fdb-bbde-d80d8ab70c3a'::uuid,
        'C', 'A primoinfecção assintomática ocorre em torno 1 - 10% dos casos.', 'Correta. A maioria das primo-infecções pelo herpes simples é assintomática, ocorrendo em aproximadamente 90% dos casos. Portanto, afirmar que apenas 1–10% são assintomáticas está incorreto.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '23dbd415-b2af-5216-bbf4-bbed7160b85d'::uuid, 'c1a33fe6-2384-5fdb-bbde-d80d8ab70c3a'::uuid,
        'D', 'Em imunossuprimidos tendem a apresentar formas mais severas e generalização do processo.', 'Incorreta. Pacientes imunossuprimidos apresentam maior risco de formas extensas, recorrentes, disseminadas e de evolução mais grave.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 071 | Dermatoviroses - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '4ab2aabc-110b-548a-9331-ed0a8a9ce5c9'::uuid, v_discipline_id, NULL, 'médio',
        'Em relação ao herpes zoster, é incorreto:', 'single',
        'B', ARRAY[]::text[],
        'O herpes-zóster resulta da reativação do vírus Varicella-zoster latente nos gânglios sensitivos. O acometimento ocorre principalmente nos dermátomos torácicos, seguido pelo nervo trigêmeo, produzindo dor neuropática intensa e vesículas agrupadas em distribuição unilateral. A doença é mais comum após os 50 anos e em imunossuprimidos, podendo ser um sinal de investigação para condições que reduzam a imunidade, como neoplasias, embora não constitua uma síndrome paraneoplásica.', 'O herpes-zóster resulta da reativação do vírus Varicella-zoster latente nos gânglios sensitivos.',
        'Torácico é o dermátomo mais acometido.
Trigêmeo = segunda localização mais frequente.
Dor intensa pode anteceder as vesículas e simular IAM.
Idosos e imunossuprimidos = maior risco.
Herpes-zóster pode sugerir imunossupressão, mas não é doença paraneoplásica.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '5967660a-ffbb-5483-9c0e-402e07d1ef47'::uuid, '4ab2aabc-110b-548a-9331-ed0a8a9ce5c9'::uuid,
        'A', 'Tem incidência maior após a 5a década de vida, porém, não é rara em jovens.', 'Incorreta. O herpes-zóster é mais frequente após os 50 anos, mas também pode ocorrer em jovens, especialmente em imunossuprimidos.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'a9414282-269f-5134-aaa9-5f0c1c3a3284'::uuid, '4ab2aabc-110b-548a-9331-ed0a8a9ce5c9'::uuid,
        'B', 'Ocorre mais frequentemente nos nervos cervical e trigêmeo.', 'Correta. O acometimento mais comum é dos dermátomos torácicos, seguido do nervo trigêmeo. O envolvimento dos nervos cervicais é menos frequente, tornando essa afirmação incorreta.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'd115266c-9892-5c1b-9933-7fe9b493e487'::uuid, '4ab2aabc-110b-548a-9331-ed0a8a9ce5c9'::uuid,
        'C', 'Manifesta-se com dor lancinante, simulando, inclusive, infarto agudo do miocárdio.', 'Incorreta. A dor neuropática pode preceder as lesões cutâneas e, quando acomete dermátomos torácicos, pode simular condições como infarto agudo do miocárdio, pleurite ou abdome agudo.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '5ce12217-219a-53ae-8c24-564077d15e07'::uuid, '4ab2aabc-110b-548a-9331-ed0a8a9ce5c9'::uuid,
        'D', 'Pode ser um indicador de neoplasia, mas não é paraneoplásico.', 'Incorreta. O herpes-zóster pode representar um marcador de imunossupressão, incluindo neoplasias hematológicas e sólidas, porém não é considerado uma síndrome paraneoplásica.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 072 | Dermatoviroses - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '1591503e-a01f-5f71-8e47-ef6b3d51cfb0'::uuid, v_discipline_id, NULL, 'médio',
        'Em relação ao molusco contagioso, é incorreto:', 'single',
        'D', ARRAY[]::text[],
        'O molusco contagioso é uma infecção cutânea causada por um Poxvírus, sendo o MCV-1 o subtipo mais frequente. Manifesta-se por pápulas peroladas, firmes e umbilicadas, geralmente assintomáticas, que podem disseminar-se por autoinoculação. É mais comum em crianças, enquanto o MCV-2 predomina em adultos, especialmente nos casos de transmissão sexual e em pacientes imunossuprimidos.', 'O molusco contagioso é uma infecção cutânea causada por um Poxvírus, sendo o MCV-1 o subtipo mais frequente.',
        'MCV-1 = principal agente (crianças).
MCV-2 = mais comum em adultos e imunossuprimidos.
Pápulas peroladas + umbilicação central = molusco contagioso.
Poxvírus = agente etiológico.
Autoinoculação explica a disseminação das lesões.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '804adbec-ea8c-5962-844f-38dc03f0e5c7'::uuid, '1591503e-a01f-5f71-8e47-ef6b3d51cfb0'::uuid,
        'A', 'Causada pelo Poxvírus.', 'Incorreta. O molusco contagioso é causado por um Poxvírus, pertencente ao gênero Molluscipoxvirus.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'e236b914-ad1e-5583-9007-0865e3df4238'::uuid, '1591503e-a01f-5f71-8e47-ef6b3d51cfb0'::uuid,
        'B', 'São constituídas de pápulas, translúcidas e apresentam umbilicação central.', 'Incorreta. As lesões são pápulas lisas, firmes, peroladas ou translúcidas, em forma de cúpula, com umbilicação central, constituindo o aspecto clássico da doença.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '8951eaac-a596-5d7f-9269-5db28cdbaeb8'::uuid, '1591503e-a01f-5f71-8e47-ef6b3d51cfb0'::uuid,
        'C', 'É autoinoculável e pode acometer ocasionalmente em mucosas.', 'Incorreta. O molusco contagioso dissemina-se facilmente por autoinoculação. O acometimento de mucosas é incomum, mas pode ocorrer ocasionalmente.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'e538481b-f756-5436-803f-974da9f47f68'::uuid, '1591503e-a01f-5f71-8e47-ef6b3d51cfb0'::uuid,
        'D', 'O tipo mais comum do vírus é o vírus do molusco contagioso 2(MCV2).', 'Correta. O MCV-1 é responsável pela grande maioria dos casos, especialmente em crianças. O MCV-2 é menos frequente e está mais associado a adultos e pacientes imunossuprimidos.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 073 | Micoses Subcutâneas - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        'a31a4bc9-8077-5acb-af98-5d1437266564'::uuid, v_discipline_id, NULL, 'médio',
        'Paciente feminina, estudante, 15 anos, relata surgimento de “ferida” em ombro direito há 15 dias, sem fatores desencadeantes aparentes. Fez uso de antibiótico tópico, sem melhora. Após exame clínico e complementar, recebeu o diagnóstico de esporotricose. Quanto à essa doença, marque a alternativa correta:', 'single',
        'D', ARRAY[]::text[],
        'A esporotricose é uma micose subcutânea causada por fungos do complexo Sporothrix spp., adquirida geralmente por inoculação traumática através de espinhos, madeira ou contato com gatos infectados. A forma cutaneolinfática é a apresentação mais comum. O tratamento é realizado com itraconazol por via oral, enquanto a anfotericina B é reservada para formas graves, disseminadas ou extracutâneas. Antifúngicos tópicos não apresentam eficácia no tratamento da doença.', 'A esporotricose é uma micose subcutânea causada por fungos do complexo Sporothrix spp., adquirida geralmente por inoculação traumática através de espinhos, madeira ou contato com gatos infectados.',
        'Esporotricose = micose subcutânea.
Agente = Sporothrix spp.
Itraconazol = tratamento de escolha.
SSKI = alternativa clássica.
Antifúngico tópico não trata esporotricose.', 'Atenção ao comando: apenas uma alternativa deve corresponder integralmente ao enunciado.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'cc442dd8-e8b9-50dd-8469-c92afe4ffe53'::uuid, 'a31a4bc9-8077-5acb-af98-5d1437266564'::uuid,
        'A', 'É micose superficial que acomete derme e subcutâneo.', 'Incorreta. A esporotricose é uma micose subcutânea, acometendo principalmente a derme e o tecido subcutâneo após inoculação traumática do fungo.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '6a0ba4e7-0d0c-5e04-970d-73a7474850da'::uuid, 'a31a4bc9-8077-5acb-af98-5d1437266564'::uuid,
        'B', 'É causada por fungo dermatófito do gênero Trichophyton, Microsporum e Epidermophyton.', 'Incorreta. A esporotricose é causada por fungos do complexo Sporothrix spp.. Os gêneros Trichophyton, Microsporum e Epidermophyton são responsáveis pelas dermatofitoses.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '0cab1c18-78bc-5531-9b08-74f223d26e88'::uuid, 'a31a4bc9-8077-5acb-af98-5d1437266564'::uuid,
        'C', 'O tratamento é feito com antifúngico tópico por período prolongado.', 'Incorreta. Antifúngicos tópicos não são eficazes no tratamento da esporotricose cutânea. O tratamento é realizado com antifúngicos sistêmicos.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '101672ca-0bfd-54ae-8676-da51a12bf135'::uuid, 'a31a4bc9-8077-5acb-af98-5d1437266564'::uuid,
        'D', 'O tratamento é feito com antifúngico oral.', 'Correta. O tratamento de escolha é o itraconazol por via oral, sendo a solução saturada de iodeto de potássio (SSKI) uma alternativa clássica. Nas formas graves ou disseminadas, utiliza-se anfotericina B.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 074 | Micoses Subcutâneas - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '66fa0a2d-c9ff-52fd-9e21-d27d2759759b'::uuid, v_discipline_id, NULL, 'médio',
        'Paciente masculino, 40 anos, agricultor, apresentando placa verrucosa em perna esquerda há 6 meses, assintomática. Procurou a Unidade de Saúde, sendo submetido à biópsia da lesão com envio de material para exame micológico direto e cultura, o qual evidenciou estruturas fúngicas. Quanto ao caso relatado, marque a alternativa INCORRETA:', 'single',
        'B', ARRAY[]::text[],
        'A cromoblastomicose é uma micose subcutânea crônica, adquirida por inoculação traumática de fungos demáceos presentes no solo e na vegetação, acometendo principalmente trabalhadores rurais. Clinicamente, manifesta-se por placas verrucosas crônicas, predominando em membros inferiores. O diagnóstico é realizado pelo exame micológico direto, histopatologia e cultura. O tratamento é prolongado, tendo o itraconazol como principal antifúngico, frequentemente associado a métodos físicos, como crioterapia ou cirurgia, em casos selecionados.', 'A cromoblastomicose é uma micose subcutânea crônica, adquirida por inoculação traumática de fungos demáceos presentes no solo e na vegetação, acometendo principalmente trabalhadores rurais.',
        'Agricultor + placa verrucosa + membro inferior = pense em cromoblastomicose.
Esporotricose e cromoblastomicose → inoculação traumática.
Inalação → lembrar de paracoccidioidomicose e histoplasmose, não de cromoblastomicose.
Itraconazol = principal antifúngico nas duas doenças.
Cromoblastomicose → corpos fumagoides no exame direto.', 'Atenção ao comando: deve-se marcar a alternativa incorreta ou a exceção.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'b836910b-078e-59bd-a322-336c8197ae05'::uuid, '66fa0a2d-c9ff-52fd-9e21-d27d2759759b'::uuid,
        'A', 'É possível tratar-se de forma verrucosa de esporotricose.', 'Incorreta. A esporotricose pode apresentar forma cutânea fixa com aspecto verrucoso, devendo fazer diagnóstico diferencial com cromoblastomicose e outras micoses subcutâneas.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'ea3fa170-b0d4-53f4-a4e2-ab8c703b6900'::uuid, '66fa0a2d-c9ff-52fd-9e21-d27d2759759b'::uuid,
        'B', 'A principal forma de contágio é inalação do fungo.', 'Correta. A cromoblastomicose e a esporotricose são adquiridas principalmente por inoculação traumática do fungo através de espinhos, madeira ou solo contaminado. A inalação não é a principal via de transmissão dessas micoses.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '0e6d9050-4323-5aad-a79c-75b1fcf5433b'::uuid, '66fa0a2d-c9ff-52fd-9e21-d27d2759759b'::uuid,
        'C', 'Há necessidade de tratamento sistêmico com itraconazol.', 'Incorreta. O itraconazol é um dos principais antifúngicos utilizados tanto na cromoblastomicose quanto na esporotricose, geralmente por tratamento prolongado.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '8e0ae4ba-da60-55a7-80dd-6f43c468f007'::uuid, '66fa0a2d-c9ff-52fd-9e21-d27d2759759b'::uuid,
        'D', 'É possível tratar-se de cromomicose.', 'Incorreta. O quadro clínico de placa verrucosa crônica em agricultor, acometendo membro inferior, é altamente sugestivo de cromoblastomicose (cromomicose).'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 075 | Micoses Subcutâneas - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '2fb73a25-b521-51f6-88ae-db1dc8f4b498'::uuid, v_discipline_id, NULL, 'médio',
        'Paciente de 18 anos, estudante, relata aparecimento de lesão cutânea na mão direita há seis meses. Fez uso correto de antibiótico oral (cefalexina) por 14 dias, sem melhora. Nega possuir animais de estimação; nega contato com terra ou vegetação. No exame físico, observa-se lesão nodular eritematosa em dorso de mão direita. Marque a alternativa correta:', 'single',
        'D', ARRAY[]::text[],
        'A esporotricose é uma micose subcutânea causada por fungos do complexo Sporothrix spp. Diante de uma lesão nodular crônica sem resposta à antibioticoterapia, deve-se considerar esse diagnóstico mesmo na ausência de história epidemiológica típica. O diagnóstico é realizado por biópsia com exame micológico e cultura, considerados os métodos mais úteis para confirmação da doença. O tratamento é feito, na maioria dos casos, com itraconazol por via oral.', 'A esporotricose é uma micose subcutânea causada por fungos do complexo Sporothrix spp.',
        'Nódulo crônico + antibiótico sem resposta = pensar em micose subcutânea.
Esporotricose → biópsia + cultura são mais úteis que raspado.
Nem sempre há história de contato com gatos, espinhos ou terra.
Raspado = dermatofitoses; biópsia = micoses subcutâneas.
Lesão nodular localizada pode corresponder à forma cutânea fixa (localizada).', 'Atenção ao comando: apenas uma alternativa deve corresponder integralmente ao enunciado.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '9568ced7-06be-517b-b836-c060f8802552'::uuid, '2fb73a25-b521-51f6-88ae-db1dc8f4b498'::uuid,
        'A', 'Como a paciente não possui história de contato com animais doentes nem com terra ou vegetação, podemos excluir a possibilidade doença fúngica.', 'Incorreta. A ausência de fatores epidemiológicos clássicos não exclui o diagnóstico de micose subcutânea. A esporotricose pode ocorrer mesmo sem história evidente de contato com gatos, solo ou vegetação.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '691f201b-bbda-5f2e-b5d2-4edd7ca1cd73'::uuid, '2fb73a25-b521-51f6-88ae-db1dc8f4b498'::uuid,
        'B', 'A hipótese de micose subcutânea já pode ser descartada, visto que não houve melhora após tratamento correto com antibiótico (cefalexina).', 'Incorreta. A ausência de resposta à antibioticoterapia reforça a necessidade de investigar outras etiologias, como infecções fúngicas, micobacterioses e leishmaniose.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'dd79031d-6c19-579a-a07c-0c8dcd1a008d'::uuid, '2fb73a25-b521-51f6-88ae-db1dc8f4b498'::uuid,
        'C', 'Devemos solicitar exame micológico de raspado da lesão, pois pode tratar-se de caso de esporotricose, forma ulcerada.', 'Incorreta. O raspado é pouco útil para o diagnóstico da esporotricose, pois trata-se de uma micose subcutânea. Além disso, o caso descreve uma lesão nodular, e não ulcerada.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '2731094d-efce-5bc6-88b1-07edb3223e18'::uuid, '2fb73a25-b521-51f6-88ae-db1dc8f4b498'::uuid,
        'D', 'Devemos solicitar biópsia cutânea, com envio de fragmento para exame micológico, para investigar a possibilidade de esporotricose (forma cutânea localizada nodular)', 'Correta. Nas micoses subcutâneas, como a esporotricose, a investigação é realizada por biópsia com envio de material para exame micológico e cultura, especialmente quando há lesão nodular crônica sem resposta à antibioticoterapia.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 076 | Micoses Subcutâneas - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '2d5aed02-6a49-5db7-9c19-f380f106f621'::uuid, v_discipline_id, NULL, 'médio',
        'A cromomicose é micose subcutânea crônica ocasionada por fungos demáceos pigmentados, como os do gênero Fonsecaea e Cladosporium. que são encontrados no solo e em vegetações. Sobre esta micose, marque a alternativa INCORRETA:', 'single',
        'D', ARRAY[]::text[],
        'A cromoblastomicose é uma micose subcutânea crônica causada por fungos demáceos, adquirida por inoculação traumática após contato com solo ou vegetação contaminados. O quadro clínico caracteriza-se principalmente por placas verrucosas de crescimento lento, predominando em membros inferiores de trabalhadores rurais. O tratamento é prolongado, utilizando principalmente itraconazol ou terbinafina, muitas vezes associados a crioterapia, termoterapia ou cirurgia para aumentar as chances de cura.', 'A cromoblastomicose é uma micose subcutânea crônica causada por fungos demáceos, adquirida por inoculação traumática após contato com solo ou vegetação contaminados.',
        'Cromoblastomicose = trabalhador rural + trauma + placa verrucosa.
Agentes = fungos demáceos (Fonsecaea pedrosoi é o principal no Brasil).
Corpos fumagoides = achado clássico no exame direto/histopatológico.
Tratamento = itraconazol por longo período, frequentemente associado a terapias físicas.
Não espere cura em poucos dias: é uma micose de tratamento difícil e prolongado.', 'Atenção ao comando: deve-se marcar a alternativa incorreta ou a exceção.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '1a8b7fe7-2154-56ad-b2b9-6e0e6b414c22'::uuid, '2d5aed02-6a49-5db7-9c19-f380f106f621'::uuid,
        'A', 'A cromomicose se manifesta como placa verrucosa', 'Incorreta. A apresentação clínica mais característica da cromoblastomicose é a placa verrucosa, embora outras formas clínicas também possam ocorrer.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '2250b924-1152-58e1-817d-dc0950ff1a40'::uuid, '2d5aed02-6a49-5db7-9c19-f380f106f621'::uuid,
        'B', 'É uma doença que acomete principalmente pessoas de zona rural', 'Incorreta. A doença predomina em trabalhadores rurais, devido ao maior contato com solo, madeira e vegetação, principais fontes de inoculação do fungo.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '003d11b7-34b1-5d88-940d-b551b9bdb13c'::uuid, '2d5aed02-6a49-5db7-9c19-f380f106f621'::uuid,
        'C', 'O fungo é transmitido por inoculação na pele', 'Incorreta. A transmissão ocorre por inoculação traumática, geralmente após ferimentos com espinhos, madeira ou outros materiais contaminados.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '0e5d9f2c-42c9-5d0e-b07c-6518ee368483'::uuid, '2d5aed02-6a49-5db7-9c19-f380f106f621'::uuid,
        'D', 'O tratamento geralmente é feito com antifúngico oral, com obtenção de cura em poucos dias.', 'Correta. O tratamento da cromoblastomicose é prolongado, frequentemente durando meses ou até anos, devido à dificuldade de erradicação do fungo. O itraconazol é a principal opção terapêutica e, muitas vezes, deve ser associado a métodos físicos, como crioterapia ou cirurgia.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 077 | Micoses Subcutâneas - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '9dc7feb0-80ed-5972-882f-a555a8cadbef'::uuid, v_discipline_id, NULL, 'médio',
        'Quanto ao micetoma, é INCORRETO afirmar que:', 'single',
        'A', ARRAY[]::text[],
        'O micetoma é uma infecção crônica da pele e do tecido subcutâneo, podendo atingir músculos e ossos. Divide-se em eumicetoma, causado por fungos, e actinomicetoma, causado por bactérias filamentosas. A doença caracteriza-se pela tríade de tumoração, fístulas e eliminação de grãos, sendo o tratamento definido conforme o agente etiológico, podendo envolver antimicrobianos, antifúngicos e, em alguns casos, tratamento cirúrgico.', 'O micetoma é uma infecção crônica da pele e do tecido subcutâneo, podendo atingir músculos e ossos.',
        'Micetoma = tumoração + fístulas + grãos.
Eumicetoma = fungo.
Actinomicetoma = bactéria.
Grãos eliminados pelas fístulas ajudam no diagnóstico.
Tratamento depende do agente etiológico e da extensão da doença.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'a4f19828-7591-5631-b949-57f749fb4c4d'::uuid, '9dc7feb0-80ed-5972-882f-a555a8cadbef'::uuid,
        'A', 'O eumicetoma ou maduromicose é causado por diversos gêneros de bactérias.', 'Correta. O eumicetoma (maduromicose) é causado por fungos. O micetoma causado por bactérias é denominado actinomicetoma.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'af9dc588-5e44-51ef-a144-f47418a11854'::uuid, '9dc7feb0-80ed-5972-882f-a555a8cadbef'::uuid,
        'B', 'A apresentação clínica é caracterizada por tumoração, fístulas e grãos.', 'Incorreta. Essa é a tríade clínica clássica do micetoma: tumefação, múltiplas fístulas e eliminação de grãos.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '8e04fde5-f4bc-5dcf-9021-7944e7920cf5'::uuid, '9dc7feb0-80ed-5972-882f-a555a8cadbef'::uuid,
        'C', 'Os grãos ou grânulos estão presentes na secreção que flui das lesões fistulosas ou ulceradas.', 'Incorreta. Os grãos representam colônias do agente etiológico e são eliminados através das secreções das fístulas, sendo importantes para o diagnóstico.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'c5012e20-d0a2-515c-be9c-ad0f6b2d3161'::uuid, '9dc7feb0-80ed-5972-882f-a555a8cadbef'::uuid,
        'D', 'O tratamento dos micetomas depende do agente etiológico, do local da lesão, do grau de invasão dos tecidos e da sensibilidade do agente aos medicamentos.', 'Incorreta. O tratamento é individualizado conforme o agente causal (fungo ou bactéria), extensão da doença e acometimento de tecidos profundos, podendo associar tratamento medicamentoso e cirurgia.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 078 | Micoses Subcutâneas - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '8491d751-20fa-5d68-bd7d-b19441d02c26'::uuid, v_discipline_id, NULL, 'médio',
        'Sobre a esporotricose, é INCORRETO afirmar que:', 'single',
        'B', ARRAY[]::text[],
        'A esporotricose é uma micose subcutânea causada por fungos do complexo Sporothrix spp., adquirida por inoculação traumática ou contato com gatos infectados. O fungo é dimórfico e produz manifestações clínicas variadas, desde lesões cutâneas localizadas até formas disseminadas com acometimento pulmonar, osteoarticular e visceral. A disseminação ocorre principalmente em pacientes imunodeprimidos, enquanto a forma cutaneolinfática representa a apresentação clínica mais frequente.', 'A esporotricose é uma micose subcutânea causada por fungos do complexo Sporothrix spp., adquirida por inoculação traumática ou contato com gatos infectados.',
        'Esporotricose = fungo dimórfico.
Lesões polimórficas (não monomórficas).
Forma mais comum = cutaneolinfática.
Pulmões e vísceras podem ser acometidos nas formas graves.
Disseminada → pensar em imunossupressão.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '15301a3d-fa85-581c-9ac5-ac24b3720ef2'::uuid, '8491d751-20fa-5d68-bd7d-b19441d02c26'::uuid,
        'A', 'É uma infecção subaguda.', 'Incorreta. A esporotricose é uma micose subcutânea de evolução subaguda ou crônica, com instalação lenta e progressiva.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'ed2da4b1-4b9a-537f-a130-6cf1a7d8f1b0'::uuid, '8491d751-20fa-5d68-bd7d-b19441d02c26'::uuid,
        'B', 'É causada por um fungo que causa lesões monomórficas e é um fungo dimórfico.', 'Correta. O Sporothrix spp. é um fungo dimórfico, porém a esporotricose apresenta lesões polimórficas, podendo assumir formas nodular, ulcerada, verrucosa, cutaneolinfática, fixa, disseminada e extracutânea.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '8109c628-bb56-5bfa-9e38-344f593c24f0'::uuid, '8491d751-20fa-5d68-bd7d-b19441d02c26'::uuid,
        'C', 'Pode envolver pulmões e vísceras.', 'Incorreta. Embora incomum, a esporotricose pode acometer pulmões, ossos, articulações e vísceras, principalmente em pacientes imunossuprimidos.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '506a711d-4901-5614-abf2-0e76b92162c9'::uuid, '8491d751-20fa-5d68-bd7d-b19441d02c26'::uuid,
        'D', 'Na forma disseminada é mais comum acometer pacientes imunodeprimidos.', 'Incorreta. A forma disseminada ocorre predominantemente em pacientes imunodeprimidos, especialmente aqueles com HIV/AIDS, neoplasias ou uso de imunossupressores.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 079 | Micoses Subcutâneas - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        'f0202844-62e6-5cd5-80c3-382f722d50f6'::uuid, v_discipline_id, NULL, 'médio',
        'Sobre a esporotricose, é CORRETO afirmar que:', 'single',
        'C', ARRAY[]::text[],
        'O tratamento da esporotricose é realizado preferencialmente com itraconazol, considerado o antifúngico de primeira escolha. A solução saturada de iodeto de potássio (SSKI) permanece como alternativa eficaz, devendo ser introduzida de forma gradual para minimizar efeitos adversos. Já a anfotericina B é reservada para pacientes com formas graves, disseminadas ou extracutâneas, especialmente imunossuprimidos. O tratamento costuma ser prolongado, devendo ser mantido até a resolução clínica das lesões e por algumas semanas adicionais para reduzir recidivas.', 'O tratamento da esporotricose é realizado preferencialmente com itraconazol, considerado o antifúngico de primeira escolha.',
        'Itraconazol = tratamento de escolha.
SSKI = solução SATURADA de iodeto de potássio.
SSKI → iniciar dose baixa e aumentar gradualmente.
Anfotericina B = formas graves ou disseminadas.
Insaturado = errado; saturado = correto.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '5d7c8050-3264-571a-80d4-c6f65b315960'::uuid, 'f0202844-62e6-5cd5-80c3-382f722d50f6'::uuid,
        'A', 'O itraconazol não apresenta uma eficácia boa.', 'Incorreta. O itraconazol é o tratamento de primeira escolha para a esporotricose cutânea e cutaneolinfática, apresentando elevada eficácia.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'cc15d9f0-a325-5e13-94f3-155ed4018189'::uuid, 'f0202844-62e6-5cd5-80c3-382f722d50f6'::uuid,
        'B', 'O iodeto de potássio deve ser insaturado e apresenta como efeitos colaterais: coriza, expectoração e gosto metálico.', 'Incorreta. Utiliza-se a solução saturada de iodeto de potássio (SSKI), e não a forma insaturada. Entre seus efeitos adversos estão gosto metálico, coriza e expectoração.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '24e6f3f3-5f09-5ace-a884-77fd8675b914'::uuid, 'f0202844-62e6-5cd5-80c3-382f722d50f6'::uuid,
        'C', 'A posologia do iodeto de potássio, em geral, se faz em três tomadas diárias, e deve começar com doses menores e aumentada gradualmente.', 'Correta. A solução saturada de iodeto de potássio é administrada, em geral, três vezes ao dia, iniciando-se com doses baixas e aumentando progressivamente para melhorar a tolerabilidade.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '4b3b4d35-9bbd-5c3d-b8c4-e2ff9021d5a8'::uuid, 'f0202844-62e6-5cd5-80c3-382f722d50f6'::uuid,
        'D', 'A anfotericina B é contraindicada nos casos de esporotricose.', 'Incorreta. A anfotericina B está indicada nas formas graves, disseminadas, extracutâneas e em pacientes imunossuprimidos, não sendo contraindicada.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 080 | Micoses Subcutâneas - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        'aeaffff5-1a73-56ed-a0c0-0cdbd837d046'::uuid, v_discipline_id, NULL, 'médio',
        'Sobre a cromomicose, é INCORRETO afirmar que:', 'single',
        'D', ARRAY[]::text[],
        'A cromoblastomicose é uma micose subcutânea crônica causada por fungos demáceos, principalmente Fonsecaea pedrosoi. O diagnóstico é baseado na identificação dos corpos fumagoides (corpos escleróticos) no exame micológico direto ou histopatológico, enquanto a cultura permite identificar a espécie. O tratamento costuma ser prolongado e de difícil resolução, frequentemente exigindo associação de antifúngicos sistêmicos com terapias físicas para aumentar as taxas de cura.', 'A cromoblastomicose é uma micose subcutânea crônica causada por fungos demáceos, principalmente Fonsecaea pedrosoi.',
        'Fonsecaea pedrosoi = principal agente no Brasil.
Corpos fumagoides = marca registrada da cromoblastomicose.
Exame direto e histopatologia podem evidenciá-los.
Tratamento é prolongado e frequentemente combinado.
Excelente resposta terapêutica = pegadinha de prova.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '4a9b317f-b74a-5982-9906-a37c36d9c58d'::uuid, 'aeaffff5-1a73-56ed-a0c0-0cdbd837d046'::uuid,
        'A', 'Tem como principal agente etiológico a Fonsecaea pedrosoi.', 'Incorreta. A Fonsecaea pedrosoi é o principal agente etiológico da cromoblastomicose no Brasil.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'aa501a01-1f53-5fff-8b6d-8903fe2aa81e'::uuid, 'aeaffff5-1a73-56ed-a0c0-0cdbd837d046'::uuid,
        'B', 'No exame micológico direto, os corpos fumagoides são achados comuns a todas as espécies.', 'Incorreta. Os corpos fumagoides (corpos escleróticos ou de Medlar) são o principal achado no exame micológico direto, independentemente da espécie de fungo demáceo envolvida.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '50946797-170d-56f1-982c-73f2e08c4a1d'::uuid, 'aeaffff5-1a73-56ed-a0c0-0cdbd837d046'::uuid,
        'C', 'No exame histopatológico podem ser encontrados corpos fumagoides.', 'Incorreta. Os corpos fumagoides também podem ser observados no exame histopatológico, sendo considerados característicos da cromoblastomicose.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'aa12a91b-c41d-5aac-93ad-85540b3f9bb9'::uuid, 'aeaffff5-1a73-56ed-a0c0-0cdbd837d046'::uuid,
        'D', 'Possui excelente resposta aos diversos tratamentos existentes.', 'Correta. A cromoblastomicose apresenta tratamento difícil e prolongado, com elevadas taxas de recidiva. Frequentemente é necessário associar antifúngicos sistêmicos (como itraconazol ou terbinafina) a métodos físicos, como crioterapia, termoterapia ou cirurgia.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 081 | Micoses Subcutâneas - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '624aec7c-1361-5fa7-ab60-b860c02b52dc'::uuid, v_discipline_id, NULL, 'médio',
        'Menino de 10 anos de idade, há um mês foi ferido por um gato, evoluindo com lesão na mão direita que progrediu com surgimento de novas lesões no antebraço direito. Sem doenças prévias. Ao exame dermatológico, observam-se vários nódulos ulcerados medindo de 0,3 cm a 1,5 cm, dispostos linearmente ao longo do trajeto linfático, em "conta de rosário", acometendo o dorso da mão direita e o antebraço direito. Qual é a hipótese diagnóstica mais provável?', 'single',
        'D', ARRAY[]::text[],
        'A esporotricose cutaneolinfática é a forma clínica mais frequente da doença, representando cerca de 70–80% dos casos. Após a inoculação do Sporothrix spp., surge um nódulo inicial que pode ulcerar, seguido pelo aparecimento de novos nódulos ao longo dos vasos linfáticos, formando o clássico aspecto em "conta de rosário". O contato com gatos infectados tornou-se uma importante forma de transmissão no Brasil. O tratamento de escolha é o itraconazol, sendo a solução saturada de iodeto de potássio uma alternativa em casos selecionados.', 'A esporotricose cutaneolinfática é a forma clínica mais frequente da doença, representando cerca de 70–80% dos casos.',
        'Gato + nódulos em "conta de rosário" = esporotricose.
Forma mais comum = cutaneolinfática.
Esporotricose → Sporothrix spp.
Doença da arranhadura do gato → Bartonella + linfadenite regional.
Cromoblastomicose → placa verrucosa; dermatofitose → lesão anular descamativa.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'f239dae7-e9f4-5bdd-9104-9b9cdd13b159'::uuid, '624aec7c-1361-5fa7-ab60-b860c02b52dc'::uuid,
        'A', 'Dermatofitose.', 'Incorreta. As dermatofitoses acometem estruturas queratinizadas (pele, cabelos e unhas), produzindo lesões anulares descamativas, e não nódulos ulcerados em trajeto linfático.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '6d90b224-ad0a-51a8-9e5b-6fa7292cedb0'::uuid, '624aec7c-1361-5fa7-ab60-b860c02b52dc'::uuid,
        'B', 'Doença da arranhadura do gato.', 'Incorreta. É causada pela bactéria Bartonella henselae e caracteriza-se principalmente por linfadenopatia regional após arranhadura de gato, não sendo típico o padrão de nódulos ulcerados em "conta de rosário".'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '36ee1e66-8876-5922-89fd-b30bead80082'::uuid, '624aec7c-1361-5fa7-ab60-b860c02b52dc'::uuid,
        'C', 'Cromoblastomicose.', 'Incorreta. A cromoblastomicose evolui lentamente com placas verrucosas, principalmente em membros inferiores, não apresentando disseminação linfática característica.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '1dc9b936-bcbb-5715-8c14-2977f0f34982'::uuid, '624aec7c-1361-5fa7-ab60-b860c02b52dc'::uuid,
        'D', 'Esporotricose.', 'Correta. O quadro é clássico de esporotricose cutaneolinfática, caracterizada por um nódulo inicial seguido de novos nódulos ulcerados distribuídos ao longo dos vasos linfáticos ("rosário linfático"), frequentemente após contato com gatos infectados.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 082 | Micoses Subcutâneas - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        'fad5bcf7-dcb2-5c8b-b643-5d5d9eb7e0d0'::uuid, v_discipline_id, NULL, 'médio',
        'Em relação à esporotricose linfocutânea, assinale a alternativa INCORRETA:', 'single',
        'D', ARRAY[]::text[],
        'A esporotricose cutaneolinfática é a forma clínica mais frequente da doença e resulta da inoculação traumática de fungos do complexo Sporothrix spp.. Clinicamente, apresenta nódulos que ulceram e se distribuem ao longo dos vasos linfáticos. O tratamento é realizado com itraconazol por via oral, enquanto a solução saturada de iodeto de potássio (SSKI) constitui uma alternativa terapêutica clássica. Antifúngicos tópicos não são eficazes para essa micose subcutânea.', 'A esporotricose cutaneolinfática é a forma clínica mais frequente da doença e resulta da inoculação traumática de fungos do complexo Sporothrix spp..',
        'Esporotricose = fungo dimórfico.
Transmissão = inoculação traumática (espinhos, madeira, gatos).
Forma cutaneolinfática = nódulos + úlceras + "conta de rosário".
Itraconazol = primeira escolha.
Iodeto de potássio = oral, nunca tópico.', 'Atenção ao comando: deve-se marcar a alternativa incorreta ou a exceção.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '3fffa895-6caf-5833-b2c7-de5078a2bc88'::uuid, 'fad5bcf7-dcb2-5c8b-b643-5d5d9eb7e0d0'::uuid,
        'A', 'É causada por um fungo dimórfico encontrado no solo e na vegetação em decomposição, que gera infecção crônica.', 'Incorreta. A esporotricose é causada por fungos do complexo Sporothrix spp., dimórficos e encontrados no solo, madeira e vegetação em decomposição, produzindo infecção de evolução subaguda ou crônica.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '3e0fc714-521d-59bb-a18e-e7678ac93c47'::uuid, 'fad5bcf7-dcb2-5c8b-b643-5d5d9eb7e0d0'::uuid,
        'B', 'O fungo penetra no hospedeiro após inoculação traumática de materiais contaminados.', 'Incorreta. A transmissão ocorre principalmente por inoculação traumática, através de espinhos, madeira, solo contaminado ou contato com gatos infectados.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '96ae65cb-8480-5bb2-924b-dd07197d81b9'::uuid, 'fad5bcf7-dcb2-5c8b-b643-5d5d9eb7e0d0'::uuid,
        'C', 'Caracteriza-se por lesões nodulares e ulcerativas.', 'Incorreta. A forma cutaneolinfática caracteriza-se por nódulos que podem ulcerar, distribuídos ao longo dos vasos linfáticos, formando o clássico aspecto em "conta de rosário".'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'f9ea1bb7-1e81-5907-9673-9d498719e10e'::uuid, 'fad5bcf7-dcb2-5c8b-b643-5d5d9eb7e0d0'::uuid,
        'D', 'O tratamento é tópico, realizado com iodeto de potássio.', 'Correta. O tratamento da esporotricose não é tópico. O iodeto de potássio é administrado por via oral, na forma de solução saturada (SSKI), sendo o itraconazol o tratamento de primeira escolha.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 083 | Micoses Subcutâneas - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '04791df2-309f-54ef-b66f-074dd36440c6'::uuid, v_discipline_id, NULL, 'médio',
        'Em relação a esporotricose, é incorreta:', 'single',
        'C', ARRAY[]::text[],
        'A esporotricose é uma micose subcutânea causada por fungos do complexo Sporothrix spp., adquirida principalmente por inoculação traumática ou contato com gatos infectados. O tratamento de escolha é o itraconazol, enquanto a solução saturada de iodeto de potássio (SSKI) permanece como alternativa clássica. Na histopatologia, pode ser observado o corpúsculo asteroide, um achado sugestivo da doença, enquanto os corpos fumagoides são característicos da cromoblastomicose.', 'A esporotricose é uma micose subcutânea causada por fungos do complexo Sporothrix spp., adquirida principalmente por inoculação traumática ou contato com gatos infectados.',
        'Esporotricose = Sporothrix spp.
Itraconazol = tratamento de escolha.
SSKI = solução SATURADA de iodeto de potássio.
Corpúsculo asteroide = esporotricose.
Corpos fumagoides = cromoblastomicose.', 'Atenção ao comando: deve-se marcar a alternativa incorreta ou a exceção.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '6ab6f211-0c44-5a2a-8e3b-22938ef2f52c'::uuid, '04791df2-309f-54ef-b66f-074dd36440c6'::uuid,
        'A', 'Tem distribuição cosmopolita, mas acomete com mais frequência em áreas de clima tropical.', 'Incorreta. A esporotricose possui distribuição cosmopolita, sendo mais frequente em regiões tropicais e subtropicais, especialmente em indivíduos expostos ao solo, vegetação e gatos infectados.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '7632cc87-7a7b-5c28-8a67-b57e48878995'::uuid, '04791df2-309f-54ef-b66f-074dd36440c6'::uuid,
        'B', 'Causada pelo Sporotrix sp.', 'Incorreta. A esporotricose é causada por fungos do complexo Sporothrix spp., agentes dimórficos responsáveis pela micose subcutânea.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '129a75f0-e928-54b1-b6b7-e89e766d897d'::uuid, '04791df2-309f-54ef-b66f-074dd36440c6'::uuid,
        'C', 'O iodeto de potássio insaturado é o tratamento de escolha.', 'Correta. O tratamento não é realizado com iodeto de potássio insaturado. Utiliza-se a solução saturada de iodeto de potássio (SSKI) como alternativa terapêutica, sendo o itraconazol o tratamento de primeira escolha.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '96afa1a5-f1f2-5d0a-aed9-86a3a3b54ffd'::uuid, '04791df2-309f-54ef-b66f-074dd36440c6'::uuid,
        'D', 'É comum ver corpúsculo asteróide que é uma coroa radiada eosinofílica ao redor do fungo.', 'Incorreta. O corpúsculo asteroide pode ser encontrado na histopatologia da esporotricose, correspondendo a uma reação eosinofílica ao redor da levedura, embora não seja um achado obrigatório.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 084 | Micoses Subcutâneas - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        'dee33354-0dda-55a2-87fc-a12f33cff97c'::uuid, v_discipline_id, NULL, 'médio',
        'Em relação a cromoblastomicose (ou cromomicose) é incorreto afirmar:', 'single',
        'A', ARRAY[]::text[],
        'A cromoblastomicose é uma micose subcutânea crônica granulomatosa causada por fungos demáceos saprófitas do ambiente, adquirida por inoculação traumática. Caracteriza-se por lesões de crescimento lento, geralmente verrucosas, predominando nos membros inferiores. O diagnóstico é feito pela identificação dos corpos fumagoides no exame micológico direto ou histopatológico e pela cultura. O tratamento é prolongado, frequentemente com itraconazol ou terbinafina associados a métodos físicos, como crioterapia ou cirurgia.', 'A cromoblastomicose é uma micose subcutânea crônica granulomatosa causada por fungos demáceos saprófitas do ambiente, adquirida por inoculação traumática.',
        'Cromoblastomicose = doença crônica e granulomatosa.
Fungos demáceos → corpos fumagoides (Medlar).
Principal agente = Fonsecaea pedrosoi.
Membros inferiores + trabalhador rural = apresentação clássica.
Trauma com vegetação = principal forma de infecção.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '6fb74500-80e7-520e-938c-cefec1dc823a'::uuid, 'dee33354-0dda-55a2-87fc-a12f33cff97c'::uuid,
        'A', 'É uma infecção subaguda, não granulomatosa causada por fungos demácios que formam corpos escleróticos.', 'Correta. A cromoblastomicose é uma infecção crônica granulomatosa, e não subaguda nem não granulomatosa. É causada por fungos demáceos que formam os característicos corpos escleróticos (fumagoides ou de Medlar).'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'c8e90838-167d-5198-b601-59734a3f7fab'::uuid, 'dee33354-0dda-55a2-87fc-a12f33cff97c'::uuid,
        'B', 'Os principais agentes etiológicos são: Fonsecaea pedrosoi, Fonsecaea compacta, Phialophora verrucosa e Cladosporium carrionii.', 'Incorreta. Esses são os principais fungos demáceos implicados na cromoblastomicose, sendo Fonsecaea pedrosoi o agente mais frequente no Brasil.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '3ec4ceec-0a73-534d-a889-a77e983e66e5'::uuid, 'dee33354-0dda-55a2-87fc-a12f33cff97c'::uuid,
        'C', 'Os fungos que acometem a cromomicose são saprófitas na natureza.', 'Incorreta. Os agentes etiológicos vivem como saprófitas no solo, madeira e vegetação em decomposição, sendo inoculados na pele após traumatismos.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'a67aa187-fa7f-530b-8231-5b0693ae110d'::uuid, 'dee33354-0dda-55a2-87fc-a12f33cff97c'::uuid,
        'D', 'Os membros inferiores são os mais frequentemente acometidos.', 'Incorreta. Os membros inferiores representam o local mais frequentemente acometido, principalmente em trabalhadores rurais devido aos traumas com vegetação.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 085 | Micoses Subcutâneas - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '03df385d-a0aa-5a79-87f3-5e140cd95948'::uuid, v_discipline_id, NULL, 'médio',
        'Em relação ao micetoma, é correto:', 'single',
        'D', ARRAY[]::text[],
        'O micetoma é uma infecção crônica da pele e do tecido subcutâneo que pode atingir músculos e ossos. Divide-se em eumicetoma, causado por fungos, e actinomicetoma, causado por bactérias filamentosas como Nocardia brasiliensis e Actinomyces israelii. Clinicamente, caracteriza-se pela tríade de tumoração, fístulas e eliminação de grãos, acometendo principalmente os pés. O tratamento varia conforme o agente etiológico, podendo incluir antibióticos, antifúngicos e, em casos avançados, abordagem cirúrgica.', 'O micetoma é uma infecção crônica da pele e do tecido subcutâneo que pode atingir músculos e ossos.',
        'Micetoma = tumoração + fístulas + grãos.
Eumicetoma = fungos.
Actinomicetoma = bactérias (Nocardia e Actinomyces).
Pé de Madura = localização clássica.
Tratamento depende do agente etiológico (fungo ou bactéria).', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '0caf13c1-1a46-59e0-9f84-19a389efcc88'::uuid, '03df385d-a0aa-5a79-87f3-5e140cd95948'::uuid,
        'A', 'É uma infecção causada por fungos com grãos brancos, pretos, amarelos e vermelhos.', 'Incorreta. O micetoma pode ser causado por fungos (eumicetoma) ou por bactérias filamentosas (actinomicetoma). Portanto, não é uma infecção exclusivamente fúngica.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '1e3262b4-20e6-510e-8686-facdef235502'::uuid, '03df385d-a0aa-5a79-87f3-5e140cd95948'::uuid,
        'B', 'O tratamento consiste em associação de terapias, por exemplo, sulfametoxazol + trimetropim ou dapsona + estreptomicina.', 'Incorreta. Esses esquemas são utilizados principalmente no actinomicetoma (forma bacteriana), mas não representam o tratamento de todos os micetomas, que depende do agente etiológico.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '8d590c43-8cf4-5d2e-ba06-383bced96427'::uuid, '03df385d-a0aa-5a79-87f3-5e140cd95948'::uuid,
        'C', 'As regiões menos atingidas são extremidades.', 'Incorreta. As extremidades, especialmente os pés ("pé de Madura"), são os locais mais frequentemente acometidos pelo micetoma.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '360fbc99-cf3e-5652-92f1-356d84310432'::uuid, '03df385d-a0aa-5a79-87f3-5e140cd95948'::uuid,
        'D', 'São os principais agentes: Actinomyces israelii e Nocardia brasiliensis, podendo ser causadas por outros agentes.', 'Correta. O actinomicetoma é causado por bactérias filamentosas, sendo Nocardia brasiliensis um dos principais agentes no Brasil, além de Actinomyces israelii e outras espécies.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 086 | Piodermites - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        'b13a1203-ad06-5450-897a-2626767fbf1c'::uuid, v_discipline_id, NULL, 'médio',
        'Criança de 5 anos, feminina, apresentando lesão na região de face há 7 dias. Mãe relata que inicialmente surgiu uma bolha de conteúdo purulento, que rapidamente rompeu-se, resultando em erosão com crosta melicérica. Marque a alternativa que contém a principal hipótese para o caso:', 'single',
        'D', ARRAY[]::text[],
        'O impetigo é a piodermite superficial mais comum da infância, causada principalmente por Staphylococcus aureus e Streptococcus pyogenes. A forma não bolhosa predomina e caracteriza-se pelo rompimento rápido de vesículas, formando as clássicas crostas melicéricas. O diagnóstico é clínico e o tratamento inclui higiene local, remoção das crostas e antibioticoterapia tópica ou sistêmica, conforme a extensão das lesões.', 'O impetigo é a piodermite superficial mais comum da infância, causada principalmente por Staphylococcus aureus e Streptococcus pyogenes.',
        'Crosta melicérica = impetigo até prova em contrário.
Face + criança = localização clássica.
Não bolhoso = mais comum.
Staphylococcus aureus e Streptococcus pyogenes = principais agentes.
Alta contagiosidade por autoinoculação e contato direto.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'd14162b7-b792-5a8f-b4b8-dd9ca67c8e00'::uuid, 'b13a1203-ad06-5450-897a-2626767fbf1c'::uuid,
        'A', 'Ectima gangrenoso', 'Incorreta. O ectima gangrenoso é uma infecção grave, geralmente associada à Pseudomonas aeruginosa em pacientes imunossuprimidos, formando úlceras necróticas, e não crostas melicéricas.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'ae463ef8-20cf-5eba-90d6-cd5945a41024'::uuid, 'b13a1203-ad06-5450-897a-2626767fbf1c'::uuid,
        'B', 'Foliculite', 'Incorreta. A foliculite acomete o folículo piloso, manifestando-se por pápulas e pústulas foliculares, sem formação de crostas melicéricas.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'ee6557a8-006d-5ed6-ba0d-a4bccc5adc25'::uuid, 'b13a1203-ad06-5450-897a-2626767fbf1c'::uuid,
        'C', 'Furunculose', 'Incorreta. A furunculose é uma infecção profunda do folículo piloso causada principalmente por Staphylococcus aureus, caracterizada por nódulos dolorosos e abscessos.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'b9d1913a-469f-5bde-8b13-b67cfc61fc80'::uuid, 'b13a1203-ad06-5450-897a-2626767fbf1c'::uuid,
        'D', 'Impetigo', 'Correta. O quadro é típico de impetigo, especialmente da forma não bolhosa, em que vesículas ou bolhas rompem-se rapidamente, originando erosões recobertas por crostas melicéricas, predominando na face de crianças.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 087 | Piodermites - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '1397c03c-ea44-5f4f-83db-9ced3a74b47b'::uuid, v_discipline_id, NULL, 'médio',
        'Paciente comparece à Unidade de Pronto Atendimento apresentando febre e mal-estar. Em terço distal da perna direita, apresenta área de eritema rubro, com edema, dor e aumento da temperatura local, com bordas bem delimitadas. Com base no caso descrito, marque a alternativa INCORRETA:', 'single',
        'A', ARRAY[]::text[],
        'A erisipela é uma infecção aguda da derme superficial e dos vasos linfáticos, causada principalmente pelo Streptococcus pyogenes. Manifesta-se por placa eritematosa, dolorosa, quente, edemaciada e com bordas bem delimitadas, geralmente acompanhada de febre e mal-estar. O tratamento é feito com penicilina ou outros antibióticos ativos contra estreptococos, além de repouso, elevação do membro e correção das portas de entrada para prevenir recorrências.', 'A erisipela é uma infecção aguda da derme superficial e dos vasos linfáticos, causada principalmente pelo Streptococcus pyogenes.',
        'Erisipela = Streptococcus pyogenes.
Borda elevada e bem delimitada = achado clássico.
Porta de entrada → tinea pedis é a mais cobrada em prova.
Recidivas → linfedema e fibrose.
Diabetes e insuficiência venosa aumentam o risco.', 'Atenção ao comando: deve-se marcar a alternativa incorreta ou a exceção.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '7a6caa72-f920-5673-a617-20758680afa4'::uuid, '1397c03c-ea44-5f4f-83db-9ced3a74b47b'::uuid,
        'A', 'É condição ocasionada principalmente por estafilococos', 'Correta. A erisipela é causada predominantemente por estreptococos β-hemolíticos do grupo A (Streptococcus pyogenes), e não por estafilococos.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'dc977e0e-1496-51bf-8635-7c87ddbaa9bb'::uuid, '1397c03c-ea44-5f4f-83db-9ced3a74b47b'::uuid,
        'B', 'Caso ocorram vários episódios sucessivos dessa condição, pode haver edema crônico, fibrose e aumento progressivo da região afetada do membro.', 'Incorreta. Episódios recorrentes de erisipela podem lesar os vasos linfáticos, causando linfedema crônico, fibrose e aumento do volume do membro.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '6c401cd9-e1d4-57dd-ab0d-1c3020f3f2fa'::uuid, '1397c03c-ea44-5f4f-83db-9ced3a74b47b'::uuid,
        'C', 'A penetração do agente ocorre, em geral, por soluções de continuidade na pele.', 'Incorreta. O estreptococo penetra através de portas de entrada, como micoses interdigitais, úlceras, fissuras, picadas de insetos e pequenos traumatismos.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'c0659c03-0b35-58b4-b850-8a93f250676d'::uuid, '1397c03c-ea44-5f4f-83db-9ced3a74b47b'::uuid,
        'D', 'Doenças crônicas, como diabetes, podem ser fator predisponente', 'Incorreta. Diabetes mellitus, insuficiência venosa, obesidade, linfedema e tinea pedis são importantes fatores de risco para o desenvolvimento da erisipela.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 088 | Piodermites - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '6c8d076d-6389-5620-9a9a-1a69fc60fbb3'::uuid, v_discipline_id, NULL, 'médio',
        'O impetigo é a dermatose infecciosa que apresenta duas formas de manifestação, uma com bolhas (impetigo bolhoso) e outra com vesicocrostas (impetigo não bolhoso). Quanto a essa doença, marque a alternativa INCORRETA:', 'single',
        'C', ARRAY[]::text[],
        'O impetigo é uma piodermite superficial que ocorre em duas formas principais. O impetigo não bolhoso é o mais frequente, podendo ser causado por Staphylococcus aureus e Streptococcus pyogenes, caracterizando-se por vesículas que evoluem para crostas melicéricas. O impetigo bolhoso é causado exclusivamente pelo Staphylococcus aureus, devido à produção de toxinas esfoliativas que promovem clivagem intraepidérmica. Entre as principais complicações destacam-se a glomerulonefrite pós-estreptocócica (forma estreptocócica) e a Síndrome da Pele Escaldada Estafilocócica (forma estafilocócica).', 'O impetigo é uma piodermite superficial que ocorre em duas formas principais.',
        'Não bolhoso = Streptococcus + Staphylococcus.
Bolhoso = Staphylococcus aureus.
Glomerulonefrite → estreptococo.
Síndrome da Pele Escaldada → estafilococo.
Crosta melicérica = impetigo não bolhoso.', 'Atenção ao comando: deve-se marcar a alternativa incorreta ou a exceção.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '1bfd27e7-6d54-5042-ae44-8849a004fb8c'::uuid, '6c8d076d-6389-5620-9a9a-1a69fc60fbb3'::uuid,
        'A', 'O impetigo não bolhoso é a forma mais comum e mais contagiosa.', 'Incorreta. O impetigo não bolhoso representa cerca de 70% dos casos e é a forma mais frequente e altamente contagiosa.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '3a26c914-0c6c-5c29-b573-92e09779c57c'::uuid, '6c8d076d-6389-5620-9a9a-1a69fc60fbb3'::uuid,
        'B', 'No impetigo estafilocócico, predominam lesões vesico-bolhosas flácidas, porém, mais duradouras do que as observadas no impetigo estreptocócico.', 'Incorreta. No impetigo bolhoso estafilocócico, as bolhas são flácidas e permanecem íntegras por mais tempo que as vesículas do impetigo não bolhoso, antes de se romperem.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '890732ae-98f0-57b1-a4df-622cc0ff0c14'::uuid, '6c8d076d-6389-5620-9a9a-1a69fc60fbb3'::uuid,
        'C', 'A complicação mais grave do impetigo estafilocócico é a glomerulonefrite.', 'Correta. A glomerulonefrite pós-estreptocócica é complicação do impetigo estreptocócico, e não do impetigo estafilocócico. A principal complicação do impetigo estafilocócico é a Síndrome da Pele Escaldada Estafilocócica (SSSS), causada pelas toxinas esfoliativas.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'db66f658-1bb2-53ca-af15-c2e108f81e06'::uuid, '6c8d076d-6389-5620-9a9a-1a69fc60fbb3'::uuid,
        'D', 'No impetigo bolhoso, os principais agentes são os estafilococos.', 'Incorreta. O impetigo bolhoso é causado quase exclusivamente pelo Staphylococcus aureus, produtor das toxinas esfoliativas A e B.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 089 | Piodermites - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        'f2814f85-fe40-5435-a276-4adf5d7f002d'::uuid, v_discipline_id, NULL, 'médio',
        'Quanto ao tratamento do impetigo, marque a alternativa INCORRETA:', 'single',
        'C', ARRAY[]::text[],
        'O tratamento do impetigo depende da extensão das lesões. Casos localizados são tratados com higiene da pele, remoção das crostas e antibióticos tópicos, principalmente mupirocina ou ácido fusídico. Quando há lesões disseminadas, sintomas sistêmicos ou surtos familiares, está indicada antibioticoterapia sistêmica. Deve-se evitar antibióticos tópicos com maior potencial de sensibilização e que não sejam de uso exclusivamente dermatológico, devido ao risco de resistência bacteriana e dermatite de contato.', 'O tratamento do impetigo depende da extensão das lesões.',
        'Poucas lesões → antibiótico tópico (mupirocina/ácido fusídico).
Muitas lesões → antibiótico sistêmico.
Sempre remover as crostas antes da medicação.
Evite neomicina e gentamicina tópicas.
Mupirocina = uso tópico exclusivo.', 'Atenção ao comando: deve-se marcar a alternativa incorreta ou a exceção.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '950c7120-b181-54de-acd8-7b496387fe49'::uuid, 'f2814f85-fe40-5435-a276-4adf5d7f002d'::uuid,
        'A', 'Devemos orientar a limpeza e remoção das crostas, que podem ser amolecidas previamente com óleo.', 'Incorreta. A higiene local e a remoção cuidadosa das crostas fazem parte do tratamento, podendo estas ser amolecidas previamente com óleo ou compressas úmidas.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '84d7368f-7c60-525a-af4f-903965a4bca3'::uuid, 'f2814f85-fe40-5435-a276-4adf5d7f002d'::uuid,
        'B', 'O tratamento do impetigo em geral é feito com antibiótico tópico, como mupirocina ou ácido fusídico.', 'Incorreta. Nos casos localizados, os antibióticos tópicos, como mupirocina e ácido fusídico, são o tratamento de primeira escolha.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'ed73bd08-f214-5d93-aa0f-7d1304d5eaa3'::uuid, 'f2814f85-fe40-5435-a276-4adf5d7f002d'::uuid,
        'C', 'Devemos dar preferência aos antibióticos tópicos que não sejam de uso tópico exclusivo e que tenham maior potencial de sensibilização.', 'Correta. Deve-se preferir antibióticos de uso tópico exclusivo, como mupirocina e ácido fusídico, pois apresentam menor risco de resistência bacteriana e sensibilização cutânea. Antibióticos tópicos como neomicina e gentamicina devem ser evitados.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '8463f6f6-49ce-50b5-a983-2244a96e1115'::uuid, 'f2814f85-fe40-5435-a276-4adf5d7f002d'::uuid,
        'D', 'Em quadros de impetigo com lesões disseminadas, é recomendável a administração de antibiótico por via sistêmica.', 'Incorreta. Nos casos extensos, múltiplas lesões ou acometimento de vários segmentos corporais, está indicada a antibioticoterapia sistêmica, geralmente com cefalexina, dicloxacilina ou amoxicilina-clavulanato.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 090 | Piodermites - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '24a2a15f-3a95-5f80-add2-b7d4759cad1d'::uuid, v_discipline_id, NULL, 'médio',
        'Quanto ao tratamento da erisipela, marque a alternativa INCORRETA:', 'single',
        'A', ARRAY[]::text[],
        'A erisipela é uma infecção aguda da derme e dos vasos linfáticos causada predominantemente pelo Streptococcus pyogenes. O tratamento baseia-se em penicilina ou outros antibióticos ativos contra estreptococos, associados a repouso, elevação do membro acometido e analgesia. A prevenção de recorrências depende da correção das portas de entrada (como tinea pedis e fissuras), do controle do linfedema e da insuficiência venosa, além do uso de meias compressivas quando indicado.', 'A erisipela é uma infecção aguda da derme e dos vasos linfáticos causada predominantemente pelo Streptococcus pyogenes.',
        'Erisipela = Streptococcus pyogenes.
Penicilina = tratamento de escolha.
Repouso + elevação do membro = reduzem edema.
Tratar porta de entrada (tinea pedis, fissuras, úlceras) evita recidivas.
Recorrências → podem evoluir para linfedema crônico.', 'Atenção ao comando: deve-se marcar a alternativa incorreta ou a exceção.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '6b9cfae6-b0e9-5641-8239-147ef846768c'::uuid, '24a2a15f-3a95-5f80-add2-b7d4759cad1d'::uuid,
        'A', 'Penicilina é opção de escolha, visto que o principal agente infeccioso é o estafilococo.', 'Correta. A penicilina é realmente o tratamento de escolha, porém porque o principal agente etiológico da erisipela é o Streptococcus pyogenes (estreptococo β-hemolítico do grupo A), e não o estafilococo.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '2f70b047-dfed-57c3-9254-9e019d9d1280'::uuid, '24a2a15f-3a95-5f80-add2-b7d4759cad1d'::uuid,
        'B', 'O repouso do membro é fundamental, principalmente quando a localização é no membro inferior.', 'Incorreta. O repouso reduz o edema, melhora a dor e favorece a recuperação, sendo uma medida importante no tratamento da erisipela de membros inferiores.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '2fd38076-4eb3-580c-a4a1-947ed31dcba6'::uuid, '24a2a15f-3a95-5f80-add2-b7d4759cad1d'::uuid,
        'C', 'É recomendada a elevação do membro acometido sempre que possível.', 'Incorreta. A elevação do membro diminui o edema e melhora o retorno venoso e linfático, auxiliando na resolução do processo inflamatório.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '1568b643-7931-553e-89b4-7ccba0293a0d'::uuid, '24a2a15f-3a95-5f80-add2-b7d4759cad1d'::uuid,
        'D', 'Após o tratamento, para prevenir recidivas, recomenda-se uso de meias elásticas, evitar a posição ereta e deambular o máximo possível.', 'Incorreta. Após a fase aguda, recomenda-se controlar fatores predisponentes, como insuficiência venosa e linfedema, utilizando meias elásticas, evitando permanecer longos períodos em posição ortostática e estimulando deambulação moderada, que melhora a bomba muscular da panturrilha.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 091 | Piodermites - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        'f0aea170-efe6-5379-8a52-092809ed7c1f'::uuid, v_discipline_id, NULL, 'médio',
        'Sobre o impetigo bolhoso, marque a alternativa INCORRETA:', 'single',
        'C', ARRAY[]::text[],
        'O impetigo bolhoso é uma piodermite superficial causada pelo Staphylococcus aureus produtor das toxinas esfoliativas A e B, responsáveis pela clivagem intraepidérmica na camada granulosa. Clinicamente, apresenta bolhas flácidas que se rompem rapidamente, formando erosões superficiais. A doença é altamente contagiosa e pode disseminar-se por autoinoculação. Os principais diagnósticos diferenciais incluem herpes simples, síndrome da pele escaldada estafilocócica, queimaduras e outras dermatoses bolhosas, sendo a tinea corporis um diagnóstico diferencial pouco característico.', 'O impetigo bolhoso é uma piodermite superficial causada pelo Staphylococcus aureus produtor das toxinas esfoliativas A e B, responsáveis pela clivagem intraepidérmica na camada granulosa.',
        'Impetigo bolhoso = Staphylococcus aureus.
Toxinas esfoliativas A e B → clivagem intraepidérmica.
Bolhas flácidas = rompem facilmente.
Auto-inoculação = novas lesões.
Herpes simples é diferencial clássico; tinea corporis não.', 'Atenção ao comando: deve-se marcar a alternativa incorreta ou a exceção.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'f3647fbc-fa37-5155-aab6-3ef3a46aab8c'::uuid, 'f0aea170-efe6-5379-8a52-092809ed7c1f'::uuid,
        'A', 'O agente etiológico predominante é o Staphylococcus aureus.', 'Incorreta. O impetigo bolhoso é causado quase exclusivamente pelo Staphylococcus aureus produtor das toxinas esfoliativas A e B.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '1ebdcabd-95e0-5d6b-8e05-2ebde85a0025'::uuid, 'f0aea170-efe6-5379-8a52-092809ed7c1f'::uuid,
        'B', 'A clivagem da bolha no impetigo bolhoso é intraepidérmica, daí a observação da bolha integra ser efêmera', 'Incorreta. A ação das toxinas esfoliativas promove clivagem intraepidérmica ao nível da camada granulosa, formando bolhas flácidas que se rompem facilmente.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'f8fb8e3f-2dba-5522-8744-10d520cba096'::uuid, 'f0aea170-efe6-5379-8a52-092809ed7c1f'::uuid,
        'C', 'Tem como diagnóstico diferencial o herpes simples e a tinea corporis', 'Correta. O herpes simples é um importante diagnóstico diferencial do impetigo bolhoso. Entretanto, a tinea corporis não é considerada um diagnóstico diferencial clássico, pois geralmente manifesta-se como placas anulares descamativas, e não como doença bolhosa. Os principais diferenciais incluem herpes simples, queimaduras, síndrome da pele escaldada estafilocócica e outras dermatoses bolhosas.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'ccb0ec05-ad63-5685-a248-0f0e1c14e56f'::uuid, 'f0aea170-efe6-5379-8a52-092809ed7c1f'::uuid,
        'D', 'As lesões iniciam-se geralmente próximo a boca, nariz e genitália.', 'Incorreta. As lesões acometem preferencialmente face (especialmente regiões periorificiais), pescoço, axilas, períneo e área das fraldas.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '864caef5-dac5-59e9-82f0-075834691c9f'::uuid, 'f0aea170-efe6-5379-8a52-092809ed7c1f'::uuid,
        'E', 'As lesões são auto-inoculáveis', 'Incorreta. O impetigo é altamente contagioso e pode disseminar-se por autoinoculação, favorecendo o aparecimento de novas lesões.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 092 | Piodermites - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        'fa3a9dcb-6aef-5efb-a8b7-809293909685'::uuid, v_discipline_id, NULL, 'médio',
        'Qual o tipo de foliculite caracteriza-se pela formação de nódulos e abscessos intercomunicantes no couro cabeludo?', 'single',
        'A', ARRAY[]::text[],
        'As foliculites profundas do couro cabeludo apresentam características distintas. A foliculite dissecante é a forma mais destrutiva, marcada por nódulos inflamatórios profundos, abscessos intercomunicantes e fístulas, culminando em alopecia cicatricial. A foliculite decalvante cursa com pústulas recorrentes e politríquia, geralmente associada ao Staphylococcus aureus. Já a foliculite queloidiana acomete preferencialmente a nuca, formando placas fibróticas e cicatrizes queloidianas. O reconhecimento dessas diferenças é uma pegadinha frequente em provas de Dermatologia.
Qual a manifestação clássica da espécie Staphylococcus aureus?
Erisipela.
Justificativa: Incorreta. A erisipela é causada predominantemente pelo Streptococcus pyogenes, acometendo a derme superficial e vasos linfáticos.
Furúnculos
Justificativa: Correta. O Staphylococcus aureus é o principal agente etiológico da furunculose, uma infecção profunda do folículo piloso que evolui com abscesso, dor e necrose central.
Febre puerperal
Justificativa: Incorreta. A febre puerperal clássica está relacionada ao Streptococcus pyogenes, embora outros microrganismos possam estar envolvidos.
Escarlatina
Justificativa: Incorreta. A escarlatina é causada pelo Streptococcus pyogenes produtor de toxinas eritrogênicas, geralmente após faringite estreptocócica.
🧠 Dica de memorização
Staphylococcus aureus → pus, abscesso e furúnculo.
Streptococcus pyogenes → erisipela, escarlatina e febre puerperal.
Furúnculo = infecção profunda do folículo piloso.
Abscesso + necrose = pense em S. aureus.
📚 Explicação geral
O Staphylococcus aureus é a principal bactéria causadora das infecções piogênicas da pele. Sua manifestação clássica é o furúnculo, decorrente de infecção profunda do folículo piloso com formação de abscesso. Além da furunculose, pode causar foliculite, carbúnculo, impetigo bolhoso, síndrome da pele escaldada estafilocócica e infecções de feridas cirúrgicas. Sua capacidade de produzir toxinas e formar abscessos diferencia-o das infecções estreptocócicas, que tendem a apresentar disseminação pelos planos linfáticos.', 'As foliculites profundas do couro cabeludo apresentam características distintas.',
        'Dissecante → "Disseca" o couro cabeludo → abscessos + fístulas + nódulos.
Decalvante → Decalva → alopecia cicatricial + politríquia.
Queloidiana → Queloides na nuca.
Necrótica → Pápulas que necrosam e formam crostas.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '0bc06828-da55-5816-b8ff-7c851d0e7f0b'::uuid, 'fa3a9dcb-6aef-5efb-a8b7-809293909685'::uuid,
        'A', 'Foliculite dissecante', 'Correta. A foliculite dissecante do couro cabeludo é uma forma crônica de foliculite profunda, caracterizada pela formação de nódulos inflamatórios, abscessos intercomunicantes, trajetos fistulosos e alopecia cicatricial. Faz parte da tríade (ou tétrade) da oclusão folicular.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '680f8db4-f0f8-52a5-b177-99c84a6cedb4'::uuid, 'fa3a9dcb-6aef-5efb-a8b7-809293909685'::uuid,
        'B', 'Foliculite necrótica', 'Incorreta. A foliculite necrótica manifesta-se por pequenas pápulas e pústulas que evoluem para necrose e crostas, acometendo principalmente a linha de implantação dos cabelos, sem formação de abscessos intercomunicantes.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '63b10c3f-9338-5c16-9d8b-472a46ea612a'::uuid, 'fa3a9dcb-6aef-5efb-a8b7-809293909685'::uuid,
        'C', 'Foliculite decalvante', 'Incorreta. A foliculite decalvante caracteriza-se por pústulas foliculares recorrentes, inflamação crônica e alopecia cicatricial com politríquia (múltiplos fios emergindo do mesmo óstio folicular), mas não costuma apresentar abscessos intercomunicantes.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'af4e2824-922c-593e-9795-045d99109950'::uuid, 'fa3a9dcb-6aef-5efb-a8b7-809293909685'::uuid,
        'D', 'Foliculite queloidiana', 'Incorreta. A foliculite queloidiana da nuca acomete principalmente a região occipital e cervical posterior, evoluindo com pápulas, placas fibróticas e cicatrizes queloidianas, sem abscessos intercomunicantes.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 093 | Piodermites - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '1edaf248-0115-5148-8ab0-74d46b38add6'::uuid, v_discipline_id, NULL, 'médio',
        'Qual a manifestação clássica da espécie Staphylococcus aureus?', 'single',
        'B', ARRAY[]::text[],
        'O Staphylococcus aureus é a principal bactéria causadora das infecções piogênicas da pele. Sua manifestação clássica é o furúnculo, decorrente de infecção profunda do folículo piloso com formação de abscesso. Além da furunculose, pode causar foliculite, carbúnculo, impetigo bolhoso, síndrome da pele escaldada estafilocócica e infecções de feridas cirúrgicas. Sua capacidade de produzir toxinas e formar abscessos diferencia-o das infecções estreptocócicas, que tendem a apresentar disseminação pelos planos linfáticos.', 'O Staphylococcus aureus é a principal bactéria causadora das infecções piogênicas da pele.',
        'Staphylococcus aureus → pus, abscesso e furúnculo.
Streptococcus pyogenes → erisipela, escarlatina e febre puerperal.
Furúnculo = infecção profunda do folículo piloso.
Abscesso + necrose = pense em S. aureus.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '80164aed-959a-53c3-aacf-9bc6606ab5b4'::uuid, '1edaf248-0115-5148-8ab0-74d46b38add6'::uuid,
        'A', 'Erisipela.', 'Incorreta. A erisipela é causada predominantemente pelo Streptococcus pyogenes, acometendo a derme superficial e vasos linfáticos.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'dc7bbd42-5164-50f6-a3af-0c87f4e8b71c'::uuid, '1edaf248-0115-5148-8ab0-74d46b38add6'::uuid,
        'B', 'Furúnculos', 'Correta. O Staphylococcus aureus é o principal agente etiológico da furunculose, uma infecção profunda do folículo piloso que evolui com abscesso, dor e necrose central.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'a62a2bde-1fc8-5bea-bb2e-73b677ab4cbd'::uuid, '1edaf248-0115-5148-8ab0-74d46b38add6'::uuid,
        'C', 'Febre puerperal', 'Incorreta. A febre puerperal clássica está relacionada ao Streptococcus pyogenes, embora outros microrganismos possam estar envolvidos.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '6af3938c-7f35-5d72-a47f-dd3a82103864'::uuid, '1edaf248-0115-5148-8ab0-74d46b38add6'::uuid,
        'D', 'Escarlatina', 'Incorreta. A escarlatina é causada pelo Streptococcus pyogenes produtor de toxinas eritrogênicas, geralmente após faringite estreptocócica.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 094 | Piodermites - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '5a5bd3d8-b265-54fe-8e31-b4c60955117f'::uuid, v_discipline_id, NULL, 'médio',
        'A ordem correta, de cima para baixo, é:', 'single',
        'A', ARRAY[]::text[],
        'As infecções cutâneas por Staphylococcus aureus variam conforme a profundidade do acometimento. A foliculite restringe-se ao folículo piloso; a furunculose corresponde à infecção profunda do folículo com formação de abscesso; a carbunculose resulta da confluência de múltiplos furúnculos. A celulite infecciosa acomete a derme profunda e o tecido subcutâneo, apresentando bordas mal definidas, enquanto o impetigo bolhoso é uma infecção superficial causada pelas toxinas esfoliativas produzidas pelo S. aureus.', 'As infecções cutâneas por Staphylococcus aureus variam conforme a profundidade do acometimento.',
        'Foliculite → infecção superficial do folículo.
Furúnculo → foliculite profunda + abscesso.
Carbúnculo → união de vários furúnculos.
Celulite → pele profunda + bordas mal delimitadas.
Impetigo bolhoso → bolhas por S. aureus.', 'Atenção ao comando: apenas uma alternativa deve corresponder integralmente ao enunciado.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '9fce8f77-5f47-55ab-a76b-7d28beaaaf2c'::uuid, '5a5bd3d8-b265-54fe-8e31-b4c60955117f'::uuid,
        'A', '3, 1, 4, 2, 5', 'Correta. A sequência corresponde corretamente às definições clínicas de carbunculose, foliculite, celulite infecciosa, furunculose e impetigo bolhoso.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '33e48881-5e6c-5dbb-aef7-e1bbfe290ebb'::uuid, '5a5bd3d8-b265-54fe-8e31-b4c60955117f'::uuid,
        'B', '3, 2, 4, 1, 5', 'Incorreta. Furunculose e foliculite foram invertidas. A foliculite acomete superficialmente o folículo piloso, enquanto a furunculose é uma infecção profunda com abscesso.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '94318cc6-cbb3-507e-aff6-132ddac9aa60'::uuid, '5a5bd3d8-b265-54fe-8e31-b4c60955117f'::uuid,
        'C', '5, 1, 4, 2, 3', 'Incorreta. O primeiro conceito descreve carbunculose e não impetigo bolhoso.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '78480a5a-78eb-51bb-bf8f-e0e694be811f'::uuid, '5a5bd3d8-b265-54fe-8e31-b4c60955117f'::uuid,
        'D', '2, 1, 3, 4, 5', 'Incorreta. Celulite infecciosa e carbunculose foram relacionadas de forma incorreta.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '4e37c1c7-142b-5327-a8a2-c64b2fc37032'::uuid, '5a5bd3d8-b265-54fe-8e31-b4c60955117f'::uuid,
        'E', '1, 3, 5, 4, 2', 'Incorreta. A sequência não corresponde às definições clínicas apresentadas.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 095 | Piodermites - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        'ce427097-7016-59a9-9896-18fb5ce1f899'::uuid, v_discipline_id, NULL, 'médio',
        'Com relação às doenças que o S. pyogenes pode causar, assinale a alternativa correta:', 'single',
        'B', ARRAY[]::text[],
        'O Streptococcus pyogenes (estreptococo β-hemolítico do grupo A) é responsável por diversas infecções cutâneas e sistêmicas. Entre elas destacam-se faringite estreptocócica, escarlatina, impetigo, erisipela, fasciíte necrosante, síndrome do choque tóxico estreptocócico e febre puerperal. A bactéria permanece sensível à penicilina, que continua sendo o tratamento de primeira escolha para a maioria dessas infecções.', 'O Streptococcus pyogenes (estreptococo β-hemolítico do grupo A) é responsável por diversas infecções cutâneas e sistêmicas.',
        'S. pyogenes = "FAEE"
Faringite
Amigdalite
Erisipela
Escarlatina
Língua em morango + pele de lixa = escarlatina.
Penicilina continua sendo o tratamento de escolha.
Erisipela = bordas bem delimitadas.', 'Atenção ao comando: apenas uma alternativa deve corresponder integralmente ao enunciado.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'a7a0979b-23c5-5684-91ad-53a6e0fce920'::uuid, 'ce427097-7016-59a9-9896-18fb5ce1f899'::uuid,
        'A', 'Semelhantemente à celulite, a erisipela é uma infecção aguda da pele com bordas indefinidas.', 'Incorreta. A erisipela caracteriza-se por placa eritematosa com bordas elevadas e bem delimitadas, diferentemente da celulite infecciosa, que apresenta limites imprecisos.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'ae2f8473-4ebb-5732-919f-a02949e0b842'::uuid, 'ce427097-7016-59a9-9896-18fb5ce1f899'::uuid,
        'B', 'Após um quadro típico de amigdalite, uma criança que apresentar exantema com pequenas pápulas poderá estar fazendo um quadro de escarlatina.', 'Correta. A escarlatina é causada pelo Streptococcus pyogenes produtor de toxinas eritrogênicas, geralmente após uma faringoamigdalite estreptocócica. Caracteriza-se por febre, faringite, língua em morango e exantema micropapular difuso ("pele de lixa").'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'ed6c6fd1-82b4-5f75-ac3c-9b4c79546abf'::uuid, 'ce427097-7016-59a9-9896-18fb5ce1f899'::uuid,
        'C', 'Outras doenças que podem ser causadas pelo S. pyogenes são: impetigo, fasciíte necrosante, síndrome do choque tóxico e febre puerperal, sendo esta última bastante frequente atualmente.', 'Incorreta. Embora todas essas doenças possam ser causadas pelo S. pyogenes, a febre puerperal atualmente é rara, devido às medidas de assepsia e ao uso de antibióticos.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'b9305f01-2a3a-5049-8888-ec7825004ad4'::uuid, 'ce427097-7016-59a9-9896-18fb5ce1f899'::uuid,
        'D', 'Atualmente, procura-se novos antibióticos para combater essas infecções, uma vez que o S. pyogenes tem se tornado resistente aos beta-lactâmicos.', 'Incorreta. O Streptococcus pyogenes permanece universalmente sensível à penicilina e aos demais beta-lactâmicos, que continuam sendo o tratamento de escolha.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 096 | Piodermites - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '0bc86979-e556-53bb-889b-f11083eb9d31'::uuid, v_discipline_id, NULL, 'médio',
        'Sobre as infecções de pele, suas manifestações e agentes etiológicos, assinale a alternativa INCORRETA:', 'multiple',
        'B', ARRAY['B', 'D']::text[],
        'As infecções cutâneas apresentam manifestações distintas conforme o agente etiológico e a profundidade do acometimento. Herpes simples e varicela-zóster produzem lesões vesiculares, enquanto o impetigo bolhoso e a síndrome da pele escaldada são causados por toxinas do Staphylococcus aureus. Já a fasciíte necrosante é uma infecção rapidamente progressiva da fáscia, geralmente causada por Streptococcus pyogenes, com alta morbimortalidade. A furunculose e a carbunculose representam infecções foliculares distintas, diferindo principalmente pela extensão e profundidade do processo.', 'As infecções cutâneas apresentam manifestações distintas conforme o agente etiológico e a profundidade do acometimento.',
        'Vesículas → herpes simples e varicela-zóster.
Bolhas por toxina estafilocócica → impetigo bolhoso e SSSS.
Fasciíte necrosante → Streptococcus pyogenes ("bactéria devoradora de carne").
Furúnculo ≠ carbúnculo.
Impetigo não bolhoso = S. aureus e/ou S. pyogenes.', 'Atenção ao comando: deve-se marcar a alternativa incorreta ou a exceção.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'cfbb7935-9381-5bad-9be8-c2c2f407f4fe'::uuid, '0bc86979-e556-53bb-889b-f11083eb9d31'::uuid,
        'A', 'Infecções que geram vesículas normalmente são causadas, dentre outros, por vírus varicela-zoster e vírus herpes simples.', 'Incorreta. As infecções por HSV e VZV cursam tipicamente com vesículas agrupadas, sendo importantes causas de lesões vesiculares da pele.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'cc3a85ce-cd46-5151-a5aa-b663c0cd2381'::uuid, '0bc86979-e556-53bb-889b-f11083eb9d31'::uuid,
        'B', 'Doenças como impetigo bolhoso, fasciíte necrosante e síndrome da pele escaldada geram bolhas e são causadas pelo S. aureus.', 'Correta. Embora o impetigo bolhoso e a síndrome da pele escaldada estafilocócica sejam causados pelo Staphylococcus aureus e apresentem bolhas, a fasciíte necrosante é causada predominantemente pelo Streptococcus pyogenes (tipo II) ou por infecção polimicrobiana (tipo I). Além disso, sua manifestação principal é necrose extensa da fáscia, e não formação de bolhas.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'a7c36a81-61d1-554a-b768-b19a8418c3dc'::uuid, '0bc86979-e556-53bb-889b-f11083eb9d31'::uuid,
        'C', 'Impetigo não bolhoso pode ser causado tanto pelo S. pyogenes quanto pelo S. aureus.', 'Incorreta. O impetigo não bolhoso pode ser causado por Streptococcus pyogenes, Staphylococcus aureus ou por infecção mista.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '180cc4f0-d7f1-5224-bea6-0942a1af8d3b'::uuid, '0bc86979-e556-53bb-889b-f11083eb9d31'::uuid,
        'D', 'Furunculose e carbunculose são termos intercambiáveis e dizem respeito a uma infecção do folículo capilar causada pelo S. aureus.', 'Correta. Furunculose e carbunculose não são sinônimos. A furunculose corresponde à infecção profunda de um folículo piloso, enquanto a carbunculose resulta da confluência de vários furúnculos, formando um processo mais extenso e profundo.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 097 | Piodermites - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '4dcf2383-6e42-5ca7-aedd-08e4ed1a2937'::uuid, v_discipline_id, NULL, 'médio',
        'O impetigo e a síndrome da pele escaldada são infecções que podem ser causadas pelo Staphylococcus aureus. Sobre elas, assinale a alternativa correta:', 'single',
        'C', ARRAY[]::text[],
        'O Staphylococcus aureus pode causar tanto o impetigo bolhoso quanto a Síndrome da Pele Escaldada Estafilocócica (SSSS) por meio da produção das toxinas esfoliativas A e B. No impetigo bolhoso, a ação das toxinas permanece localizada, produzindo bolhas flácidas. Na SSSS, as toxinas disseminam-se pela circulação, promovendo clivagem da desmogleína 1 em áreas extensas da pele, levando ao descolamento epidérmico difuso e ao sinal de Nikolsky positivo.', 'O Staphylococcus aureus pode causar tanto o impetigo bolhoso quanto a Síndrome da Pele Escaldada Estafilocócica (SSSS) por meio da produção das toxinas esfoliativas A e B.',
        'Impetigo bolhoso = toxina local.
SSSS = toxina disseminada pelo sangue.
Alvo das toxinas = desmogleína 1.
S. aureus → toxinas esfoliativas A e B.
Botulínica não tem relação com impetigo ou SSSS.', 'Atenção ao comando: apenas uma alternativa deve corresponder integralmente ao enunciado.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'e5ebebe7-233a-5cef-91f3-621f38ee7f98'::uuid, '4dcf2383-6e42-5ca7-aedd-08e4ed1a2937'::uuid,
        'A', 'Os impetigos são causados unicamente por bactérias da espécie S. aureus.', 'Incorreta. O impetigo não bolhoso pode ser causado tanto pelo Staphylococcus aureus quanto pelo Streptococcus pyogenes. Apenas o impetigo bolhoso é causado praticamente exclusivamente pelo S. aureus.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '7062205c-3734-51bd-b969-1c3319257cbb'::uuid, '4dcf2383-6e42-5ca7-aedd-08e4ed1a2937'::uuid,
        'B', 'Os impetigos são mais comuns em idosos na região dos braços.', 'Incorreta. O impetigo acomete principalmente crianças, predominando na face e em membros expostos.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '58aed824-cd77-5a24-8fcc-56d5e910602c'::uuid, '4dcf2383-6e42-5ca7-aedd-08e4ed1a2937'::uuid,
        'C', 'Na síndrome da pele escaldada, as toxinas agem de forma mais disseminada que no impetigo, diretamente na adesão célula-célula existentes no epitélio.', 'Correta. Na Síndrome da Pele Escaldada Estafilocócica (SSSS), as toxinas esfoliativas A e B produzidas pelo S. aureus disseminam-se pela corrente sanguínea e promovem clivagem da desmogleína 1, rompendo a adesão entre os queratinócitos e causando descolamento difuso da epiderme.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'dc9f2dd6-90e0-5f20-b23d-ab42b4dddaaf'::uuid, '4dcf2383-6e42-5ca7-aedd-08e4ed1a2937'::uuid,
        'D', 'Nas duas doenças, toxinas botulínicas agem de forma a causar descamações da pele.', 'Incorreta. As lesões são causadas pelas toxinas esfoliativas A e B do S. aureus, e não por toxina botulínica.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 098 | Piodermites - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '33254519-6833-555d-94e1-c842f2660424'::uuid, v_discipline_id, NULL, 'médio',
        'Sobre a fasciíte necrosante e suas bactérias causadoras, assinale a alternativa correta:', 'single',
        'D', ARRAY[]::text[],
        'A fasciíte necrosante é uma infecção bacteriana grave e rapidamente progressiva que acomete a fáscia superficial e o tecido subcutâneo, podendo evoluir para sepse e óbito. O principal agente etiológico é o Streptococcus pyogenes, embora formas polimicrobianas também sejam frequentes. O quadro clínico caracteriza-se por dor intensa desproporcional ao exame, edema, eritema, febre e rápida evolução para necrose. O tratamento exige desbridamento cirúrgico imediato, associado à antibioticoterapia intravenosa de amplo espectro e suporte intensivo.', 'A fasciíte necrosante é uma infecção bacteriana grave e rapidamente progressiva que acomete a fáscia superficial e o tecido subcutâneo, podendo evoluir para sepse e óbito.',
        'Fasciíte necrosante = emergência cirúrgica.
Dor intensa desproporcional ao exame = sinal de alerta.
Principal agente = Streptococcus pyogenes.
Tratamento = cirurgia + antibiótico intravenoso.
"Bactéria devoradora de carne" = necrose da fáscia e tecido subcutâneo.', 'Atenção ao comando: apenas uma alternativa deve corresponder integralmente ao enunciado.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '977e4910-f304-5fca-9cd4-c912b647d682'::uuid, '33254519-6833-555d-94e1-c842f2660424'::uuid,
        'A', 'São conhecidas popularmente como "bactérias comedoras de carne", sendo mais comumente associadas, no meio médico, ao gênero Staphylococcus.', 'Incorreta. A fasciíte necrosante é classicamente associada ao Streptococcus pyogenes (tipo II), embora também possa ser polimicrobiana (tipo I). O Staphylococcus aureus não é o agente mais frequentemente relacionado.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '6f967efa-b9ef-515e-add2-8a75fa9c5c01'::uuid, '33254519-6833-555d-94e1-c842f2660424'::uuid,
        'B', 'É uma doença autolimitada que dificilmente gera complicações, mas pode algumas vezes necessitar de antibióticos para ser controlada.', 'Incorreta. A fasciíte necrosante é uma emergência médica, de rápida progressão, com elevada morbimortalidade, exigindo antibioticoterapia intravenosa e desbridamento cirúrgico precoce.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'ca4e5c1b-3d33-5f5a-8dbc-23dea139b31e'::uuid, '33254519-6833-555d-94e1-c842f2660424'::uuid,
        'C', 'Apesar de ser conhecida como a "doença da bactéria devoradora de carne", esse é um exagero popular gerado pelas séries televisivas, uma vez que dificilmente a doença progride até esse nível - apenas quando não cuidada, como em moradores de rua.', 'Incorreta. Embora o termo seja popular, a fasciíte necrosante realmente pode evoluir com necrose extensa de tecidos moles, independentemente da condição social do paciente, caso não seja tratada rapidamente.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '0b9ce0d2-fdc9-5699-827e-71904140a909'::uuid, '33254519-6833-555d-94e1-c842f2660424'::uuid,
        'D', 'É uma infecção extremamente grave e invasiva de tecidos subcutâneos e da fáscia, com necrose extensa. Os sintomas envolvem dor intensa no local, febre, mal-estar e calafrios.', 'Correta. A fasciíte necrosante é uma infecção rapidamente progressiva da fáscia superficial e tecido subcutâneo, caracterizada por dor desproporcional ao exame físico, febre, toxemia e necrose extensa, constituindo uma emergência cirúrgica.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 099 | Piodermites - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '7b0759c0-5e83-52c5-bb5e-2a4c724b6f43'::uuid, v_discipline_id, NULL, 'médio',
        'A respeito da erisipela e da celulite infecciosa, assinale a opção correta:', 'single',
        'D', ARRAY[]::text[],
        'A erisipela e a celulite infecciosa são infecções bacterianas da pele que diferem principalmente pela profundidade do acometimento. A erisipela envolve a derme superficial e os vasos linfáticos, apresentando placas eritematosas com bordas bem delimitadas, geralmente causadas por Streptococcus pyogenes. Já a celulite acomete a derme profunda e o tecido subcutâneo, possui bordas mal definidas e pode ser causada tanto por S. pyogenes quanto por Staphylococcus aureus. Ambas requerem tratamento precoce para evitar complicações sistêmicas.', 'A erisipela e a celulite infecciosa são infecções bacterianas da pele que diferem principalmente pela profundidade do acometimento.',
        'Erisipela = Streptococcus + borda bem delimitada.
Celulite = Streptococcus ou Staphylococcus + borda mal delimitada.
Erisipela → derme superficial e vasos linfáticos.
Celulite → derme profunda e tecido subcutâneo.
Ambas podem evoluir para sepse se não tratadas.', 'Atenção ao comando: apenas uma alternativa deve corresponder integralmente ao enunciado.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '33b299f3-d90f-5d2b-a9cd-e5e8ff10d616'::uuid, '7b0759c0-5e83-52c5-bb5e-2a4c724b6f43'::uuid,
        'A', 'A erisipela é uma forma de celulite superficial, mais frequentemente relacionada à infecção por Staphylococcus aureus.', 'Incorreta. A erisipela é uma infecção superficial da derme e vasos linfáticos causada predominantemente pelo Streptococcus pyogenes, e não pelo Staphylococcus aureus.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '14f664c1-eca9-55e7-8e0c-fb7e3278dad0'::uuid, '7b0759c0-5e83-52c5-bb5e-2a4c724b6f43'::uuid,
        'B', 'Na erisipela, a área comprometida é eritematosa, edemaciada, quente, dolorosa e sem bordas definidas.', 'Incorreta. A principal característica clínica da erisipela é a presença de bordas bem delimitadas, diferentemente da celulite infecciosa, que apresenta limites imprecisos.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'de89c3c1-f2a3-5132-ac8d-7d5e7064bd35'::uuid, '7b0759c0-5e83-52c5-bb5e-2a4c724b6f43'::uuid,
        'C', 'Apenas a erisipela pode progredir para complicações se não tratada, como infecção de corrente sanguínea.', 'Incorreta. Tanto a erisipela quanto a celulite infecciosa podem evoluir com complicações graves, como bacteremia, abscessos, fasciíte necrosante e sepse.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'fc4dda99-9b1f-5744-a89b-b739444a6c7a'::uuid, '7b0759c0-5e83-52c5-bb5e-2a4c724b6f43'::uuid,
        'D', 'A celulite pode estar associada tanto à infecção por Streptococcus pyogenes quanto a Staphylococcus aureus.', 'Correta. A celulite infecciosa acomete a derme profunda e o tecido subcutâneo, sendo causada principalmente por Streptococcus pyogenes e Staphylococcus aureus.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 100 | Piodermites - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        'c1b65260-6ea1-55c5-9178-9c234cf2e9d5'::uuid, v_discipline_id, NULL, 'médio',
        'Paciente de 13 anos atendido em Unidade de Pronto Atendimento (UPA). Apresenta lesões de pele localizadas próximas à região oral, caracterizadas como pústulas isoladas que se tornaram crostas (veja a imagem). Diagnóstico etiológico foi realizado e confirmado através do crescimento do microrganismo em meio de cultura sólido seguido da coloração de Gram e provas bioquímicas. Com base nessas informações, assinale a alternativa correta:', 'single',
        'C', ARRAY[]::text[],
        'O impetigo não bolhoso é a piodermite superficial mais comum da infância, caracterizada por vesículas ou pústulas que rapidamente se rompem, originando as clássicas crostas melicéricas. Os principais agentes etiológicos são Streptococcus pyogenes e Staphylococcus aureus. O diagnóstico é geralmente clínico, mas pode ser confirmado por cultura bacteriana, coloração de Gram e provas bioquímicas quando necessário. O tratamento inclui higiene local, remoção das crostas e antibioticoterapia tópica ou sistêmica conforme a extensão das lesões.', 'O impetigo não bolhoso é a piodermite superficial mais comum da infância, caracterizada por vesículas ou pústulas que rapidamente se rompem, originando as clássicas crostas melicéricas.',
        'Crosta melicérica = impetigo.
Impetigo não bolhoso = S. pyogenes e/ou S. aureus.
Herpes = vesículas agrupadas, não pústulas.
Gram + cultura = bactéria, não vírus.
Escarlatina = faringite + língua em morango + pele de lixa.', 'Atenção ao comando: apenas uma alternativa deve corresponder integralmente ao enunciado.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', '/questions/dermatologia/dermatologia_p2_q100.png'
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'e41147ec-ab23-5ce1-b1be-66af267521b6'::uuid, 'c1b65260-6ea1-55c5-9178-9c234cf2e9d5'::uuid,
        'A', 'Trata-se de um caso de herpes zoster, sendo o agente associado ao vírus varicela zoster.', 'Incorreta. O herpes-zóster caracteriza-se por vesículas agrupadas em distribuição dermatomérica unilateral, geralmente acompanhadas de dor intensa. Além disso, o diagnóstico é viral e não por cultura bacteriana.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'dafd9e6c-8630-50b2-91fe-f53fa0ce48f3'::uuid, 'c1b65260-6ea1-55c5-9178-9c234cf2e9d5'::uuid,
        'B', 'Trata-se de um caso de herpes labial, sendo o agente associado ao vírus herpes simplex.', 'Incorreta. O herpes labial produz vesículas agrupadas sobre base eritematosa e o diagnóstico é, em geral, clínico ou por métodos virológicos, não por cultura bacteriana e coloração de Gram.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '08903400-d124-53c7-8d45-33baf1fee340'::uuid, 'c1b65260-6ea1-55c5-9178-9c234cf2e9d5'::uuid,
        'C', 'Trata-se de um caso de impetigo e o agente provavelmente associado é o Streptococcus pyogenes.', 'Correta. O quadro clínico de pústulas que evoluem para crostas melicéricas, principalmente na região perioral de crianças e adolescentes, é típico de impetigo não bolhoso. O diagnóstico bacteriológico confirma uma etiologia bacteriana, sendo o Streptococcus pyogenes um dos principais agentes causadores.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'ad5f0d42-a664-5e8f-85eb-34064a957869'::uuid, 'c1b65260-6ea1-55c5-9178-9c234cf2e9d5'::uuid,
        'D', 'Trata-se de um caso de escarlatina e o agente provavelmente associado é Staphylococcus aureus.', 'Incorreta. A escarlatina é causada pelo Streptococcus pyogenes e manifesta-se por faringite, língua em morango e exantema difuso, não por lesões pustulosas com crostas.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 101 | Piodermites - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '6698fad5-a5bb-58ca-bd78-95da3d4c535d'::uuid, v_discipline_id, NULL, 'médio',
        'Paciente pediátrico: ao exame físico, apresentava faringite acompanhada de "língua de morango", febre e anorexia. No tórax, apresentava exantema com minúsculas pápulas "ásperas". De acordo com os sintomas clínicos e o resultado da cultura em meio de cultura, foi prescrito tratamento antimicrobiano imediato. O agente microbiológico associado, provavelmente, é:', 'single',
        'C', ARRAY[]::text[],
        'A escarlatina é uma manifestação causada por cepas de Streptococcus pyogenes produtoras de toxinas eritrogênicas, geralmente após um episódio de faringoamigdalite estreptocócica. O quadro clínico inclui febre, odinofagia, língua em morango e exantema micropapular difuso, de textura áspera ("pele de lixa"), predominando em tronco e pregas cutâneas. O tratamento é realizado com penicilina ou outros β-lactâmicos, reduzindo sintomas, transmissão e complicações, como a febre reumática.', 'A escarlatina é uma manifestação causada por cepas de Streptococcus pyogenes produtoras de toxinas eritrogênicas, geralmente após um episódio de faringoamigdalite estreptocócica.',
        'Escarlatina = Streptococcus pyogenes.
Tríade clássica: faringite + língua em morango + pele de lixa.
Toxina eritrogênica = responsável pelo exantema.
Penicilina = tratamento de escolha.
Língua em morango é um dos achados mais cobrados em prova.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'bf08d61f-3f81-5f71-a9f7-93dc74b93a3a'::uuid, '6698fad5-a5bb-58ca-bd78-95da3d4c535d'::uuid,
        'A', 'Vírus varicela zoster (VZV).', 'Incorreta. O VZV causa varicela e herpes-zóster, caracterizados por vesículas em diferentes estágios evolutivos, e não por faringite com língua em morango e exantema escarlatiniforme.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '0b785468-c9cc-59e9-8628-7a74e3a8ee61'::uuid, '6698fad5-a5bb-58ca-bd78-95da3d4c535d'::uuid,
        'B', 'Mycobacterium leprae.', 'Incorreta. Mycobacterium leprae é o agente da hanseníase, doença de evolução crônica que acomete pele e nervos periféricos, sem relação com esse quadro clínico agudo.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '79de30ff-7c6c-5ebb-802d-98a27001173a'::uuid, '6698fad5-a5bb-58ca-bd78-95da3d4c535d'::uuid,
        'C', 'Streptococcus pyogenes', 'Correta. O quadro é típico de escarlatina, causada pelo Streptococcus pyogenes produtor de toxinas eritrogênicas. Caracteriza-se por faringite, febre, língua em morango e exantema micropapular difuso, conferindo aspecto de "pele de lixa".'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '535e6171-6d14-5ab4-979c-e33f42df0c5b'::uuid, '6698fad5-a5bb-58ca-bd78-95da3d4c535d'::uuid,
        'D', 'Staphylococcus aureus.', 'Incorreta. O Staphylococcus aureus pode causar infecções cutâneas e síndrome da pele escaldada, mas não é o agente etiológico da escarlatina.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 102 | Piodermites - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '0d55bf0e-2676-5587-843f-7c4bb6c620ea'::uuid, v_discipline_id, NULL, 'médio',
        'Sobre o impetigo, marque a INCORRETA:', 'single',
        'D', ARRAY[]::text[],
        'O impetigo não bolhoso (ou impetigo contagioso de Tilbury Fox) é a forma mais comum da doença e pode ser causado por Staphylococcus aureus e Streptococcus pyogenes. Já a Síndrome da Pele Escaldada Estafilocócica (Doença de Ritter) resulta da disseminação das toxinas esfoliativas do S. aureus, que atuam sobre a desmogleína 1, causando descolamento epidérmico. A foliculite decalvante é uma dermatose inflamatória crônica do couro cabeludo associada principalmente ao S. aureus, não sendo considerada uma infecção fúngica.', 'O impetigo não bolhoso (ou impetigo contagioso de Tilbury Fox) é a forma mais comum da doença e pode ser causado por Staphylococcus aureus e Streptococcus pyogenes.',
        'Tilbury Fox = impetigo não bolhoso.
Doença de Ritter = toxinas A e B → desmogleína 1.
Foliculite decalvante = principalmente S. aureus.
Erisipela = bordas bem delimitadas.
Fungo ≠ causa clássica da foliculite decalvante.', 'Atenção ao comando: deve-se marcar a alternativa incorreta ou a exceção.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '618f19a5-a174-51b8-810a-ac3c78e67152'::uuid, '0d55bf0e-2676-5587-843f-7c4bb6c620ea'::uuid,
        'A', 'O impetigo bolhoso faz diagnóstico diferencial com queimadura e dermatofitose', 'Incorreta. O impetigo bolhoso pode fazer diagnóstico diferencial com queimaduras, herpes simples, síndrome da pele escaldada estafilocócica e outras dermatoses bolhosas. A dermatofitose pode ser considerada em algumas apresentações clínicas, especialmente quando há lesões anulares superficiais.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'b48eb795-13b4-54d4-a52d-124a76fbed22'::uuid, '0d55bf0e-2676-5587-843f-7c4bb6c620ea'::uuid,
        'B', 'O impetigo não bolhoso é conhecido também como Impetigo contagioso de Tilbury Fox, representa cerca de 70% dos casos de impetigo e pode ser causado pelo S. aureus e Streptococcus pyogenes', 'Incorreta. O impetigo não bolhoso corresponde a aproximadamente 70% dos casos e pode ser causado por Staphylococcus aureus, Streptococcus pyogenes ou infecção mista.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'e04af1f0-8cd4-59f6-a170-94a57048d453'::uuid, '0d55bf0e-2676-5587-843f-7c4bb6c620ea'::uuid,
        'C', 'Na D de Ritter Von Ritterschein devido à imaturidade renal da criança ocorre acúmulo de toxinas esfoliativas A e B produzidas pelo S. aureus, que vão agir na desmogleína 1 da epiderme, causando um descolamento da pele', 'Incorreta. Essa é a fisiopatologia clássica da Síndrome da Pele Escaldada Estafilocócica (Doença de Ritter). As toxinas esfoliativas A e B clivam a desmogleína 1, provocando descolamento epidérmico difuso.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'd7d5bf01-c18e-5641-b821-3841aed5465d'::uuid, '0d55bf0e-2676-5587-843f-7c4bb6c620ea'::uuid,
        'D', 'Na Foliculite decalvante, ocorre um processo inflamatório intenso no couro cabeludo causado pela presença de fungos e bactérias', 'Correta. A foliculite decalvante é considerada uma dermatose neutrofílica crônica, relacionada principalmente ao Staphylococcus aureus e à resposta inflamatória do hospedeiro. Fungos não fazem parte da etiopatogenia clássica da doença.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '00e8ac8e-22cd-5958-b61f-459892c68e7d'::uuid, '0d55bf0e-2676-5587-843f-7c4bb6c620ea'::uuid,
        'E', 'Na erisipela ocorre nítida demarcação da área sa e a doente', 'Incorreta. A placa eritematosa com bordas bem delimitadas é uma das principais características clínicas da erisipela.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 103 | Acne - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '73118fb4-c6f7-5747-925c-e8d62529f9c6'::uuid, v_discipline_id, NULL, 'médio',
        'Quanto à patogenia da acne vulgar, marque a alternativa correta:', 'single',
        'D', ARRAY[]::text[],
        'A acne vulgar resulta da interação de quatro mecanismos fisiopatológicos principais: hipersecreção sebácea estimulada por andrógenos, hiperqueratinização do infundíbulo folicular, proliferação do Cutibacterium acnes e resposta inflamatória. A formação do microcomedão representa a lesão inicial da doença, decorrente da obstrução do folículo pilossebáceo pela queratinização anômala. Embora os andrógenos desempenhem papel importante, a maioria dos pacientes apresenta níveis hormonais normais, havendo maior sensibilidade da glândula sebácea a esses hormônios.', 'A acne vulgar resulta da interação de quatro mecanismos fisiopatológicos principais: hipersecreção sebácea estimulada por andrógenos, hiperqueratinização do infundíbulo folicular, proliferação do Cutibacterium acnes e resposta inflamatória.',
        'Os 4 pilares da acne:
↑ Produção de sebo
↑ Queratinização folicular → comedão
Proliferação de Cutibacterium acnes
Inflamação
👉 O primeiro evento é a hiperqueratinização folicular, formando o microcomedão.', 'Atenção ao comando: apenas uma alternativa deve corresponder integralmente ao enunciado.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '6b91123e-9c1a-559e-9c3d-c742e71c90be'::uuid, '73118fb4-c6f7-5747-925c-e8d62529f9c6'::uuid,
        'A', 'Os pacientes acneicos têm níveis mais altos de ácidos graxos e ácido linoleico, os quais se normalizam após tratamento', 'Incorreta. Na acne, observa-se redução do ácido linoleico no sebo, favorecendo alterações da queratinização folicular. Além disso, há aumento de ácidos graxos livres decorrente da ação do Cutibacterium acnes, e não aumento do ácido linoleico.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '38953c21-da67-5d21-93dc-e80db12a6197'::uuid, '73118fb4-c6f7-5747-925c-e8d62529f9c6'::uuid,
        'B', 'Na maioria dos pacientes com acne, existem alterações hormonais subjacentes e endocrinopatias, com níveis de andrógenos circulantes aumentados', 'Incorreta. A maioria dos pacientes não apresenta endocrinopatias nem aumento dos andrógenos circulantes. O problema está na maior sensibilidade da unidade pilossebácea aos andrógenos.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'f6399da0-5dbe-5ed2-b31a-67c1f16684b8'::uuid, '73118fb4-c6f7-5747-925c-e8d62529f9c6'::uuid,
        'C', 'A levedura Pityrosporum furfur contribui na patogenia da acne vulgar', 'Incorreta. A levedura Malassezia furfur (Pityrosporum furfur) está relacionada principalmente à foliculite por Malassezia e à pitiríase versicolor, não sendo um dos fatores fundamentais da acne vulgar.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '4e716a3a-fa4c-58a4-981c-9866efeabf6b'::uuid, '73118fb4-c6f7-5747-925c-e8d62529f9c6'::uuid,
        'D', 'Na acne, ocorre queratinização anômala no infundíbulo folicular, levando à obstrução do orifício folicular e formação do comedão', 'Correta. A hiperqueratinização do infundíbulo folicular é um dos quatro pilares da fisiopatologia da acne. Ela promove a obstrução do folículo pilossebáceo, originando o microcomedão, que evolui para comedões abertos ou fechados.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 104 | Acne - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        'b21427b2-170c-5daa-9765-0235ae2423ae'::uuid, v_discipline_id, NULL, 'médio',
        'O quadro clínico da acne vulgar é polimorfo, acometendo principalmente face, ombros e porção superior do tórax. Quanto às manifestaçõe clínicas, marque a alternativa correta:', 'single',
        'C', ARRAY[]::text[],
        'A acne vulgar apresenta quadro polimorfo, com lesões não inflamatórias (comedões) e inflamatórias (pápulas, pústulas, nódulos e abscessos). A classificação clínica baseia-se na gravidade: grau I (comedônica), grau II (pápulo-pustulosa), grau III (nódulo-abscedante), grau IV (conglobata) e grau V (fulminante). As formas mais graves decorrem da ruptura da parede folicular, que desencadeia intensa resposta inflamatória e aumenta o risco de cicatrizes permanentes.', 'A acne vulgar apresenta quadro polimorfo, com lesões não inflamatórias (comedões) e inflamatórias (pápulas, pústulas, nódulos e abscessos).',
        'Classificação da acne:
Grau I → Comedônica (não inflamatória)
Grau II → Pápulo-pustulosa
Grau III → Nódulo-abscedante
Grau IV → Conglobata
Grau V → Fulminante (febre, artralgia, mialgia)
👉 Quanto maior o grau, maior a inflamação.', 'Atenção ao comando: apenas uma alternativa deve corresponder integralmente ao enunciado.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '41954386-2b28-5a2e-ad06-b7e0b896fc5c'::uuid, 'b21427b2-170c-5daa-9765-0235ae2423ae'::uuid,
        'A', 'A acne comedônica é caracterizada pela predominância de pústulas e pápulas inflamatórias', 'Incorreta. A acne comedônica (grau I) caracteriza-se pela presença de comedões abertos e fechados, sem predomínio de lesões inflamatórias.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'f0186fce-83d2-5d80-8eef-d4df337a9189'::uuid, 'b21427b2-170c-5daa-9765-0235ae2423ae'::uuid,
        'B', 'A acne não inflamatória pode ser classificada em grau I, II, III, IV ou V', 'Incorreta. Apenas o grau I corresponde à acne não inflamatória (comedônica). Os graus II, III, IV e V representam formas inflamatórias.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '4cdbecd7-a31d-524a-8437-b42c43c57c46'::uuid, 'b21427b2-170c-5daa-9765-0235ae2423ae'::uuid,
        'C', 'Na acne nódulo-abscedante, formam-se nódulos furunculoides e abscessos devido à ruptura da parede folicular e reação inflamatória.', 'Correta. A acne nódulo-abscedante (grau III) caracteriza-se pela formação de nódulos e abscessos, resultantes da ruptura da parede folicular, extravasamento do conteúdo para a derme e intensa reação inflamatória.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '356bb8db-d495-5522-bcc3-2065bf68bab8'::uuid, 'b21427b2-170c-5daa-9765-0235ae2423ae'::uuid,
        'D', 'A acne conglobata é forma não inflamatória caracterizada pela presença de comedões', 'Incorreta. A acne conglobata é uma forma grave inflamatória, predominando nódulos, abscessos, fístulas e cicatrizes, sendo mais frequente em homens jovens.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 105 | Acne - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        'cc585196-b4ba-583d-a7b6-fffa4e17375d'::uuid, v_discipline_id, NULL, 'médio',
        'A hiperqueratinização folicular resulta na formação dos comedões na acne vulgar. Quanto aos tipos de comedões, marque a alternativa INCORRETA:', 'single',
        'C', ARRAY[]::text[],
        'Os comedões representam as lesões fundamentais da acne vulgar e resultam da hiperqueratinização do infundíbulo folicular. O microcomedão é a lesão inicial e microscópica. Quando o óstio permanece fechado, forma-se o comedão fechado (cravo branco). Quando ocorre dilatação do óstio folicular, surge o comedão aberto (cravo preto), cuja coloração escura decorre da oxidação da melanina e dos lipídios, e não do acúmulo de sujeira. Essas lesões caracterizam a acne comedônica (grau I).', 'Os comedões representam as lesões fundamentais da acne vulgar e resultam da hiperqueratinização do infundíbulo folicular.',
        'Microcomedão = invisível.
Comedão fechado = cravo branco.
Comedão aberto = cravo preto.
Preto ≠ sujeira; é oxidação da melanina e dos lipídios.
Todos pertencem ao grau I (acne comedônica).', 'Atenção ao comando: deve-se marcar a alternativa incorreta ou a exceção.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '58ae3743-18a7-5269-ab68-e1f9775e63e3'::uuid, 'cc585196-b4ba-583d-a7b6-fffa4e17375d'::uuid,
        'A', 'No microcomedão, o acúmulo de corneócitos no infundíbulo produz uma dilatação folicular não visível', 'Incorreta. O microcomedão é a lesão inicial da acne e não é visível clinicamente, correspondendo à obstrução microscópica do infundíbulo folicular.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'b863233e-8ee7-5bd5-ae9d-6af992172934'::uuid, 'cc585196-b4ba-583d-a7b6-fffa4e17375d'::uuid,
        'B', 'O comedão fechado é lesão papular cor da pele que ocorre por acúmulo de corneócitos no infundíbulo folicular.', 'Incorreta. O comedão fechado ("cravo branco") apresenta-se como pequena pápula esbranquiçada ou cor da pele, resultante da obstrução do óstio folicular.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'f8871e27-f4b5-5ec3-8227-80a656433fb3'::uuid, 'cc585196-b4ba-583d-a7b6-fffa4e17375d'::uuid,
        'C', 'O comedão aberto é lesão esbranquiçada que resulta do acúmulo de corneócitos e sebo e da colonização pelo P. acnes, sendo conhecido como “cravo branco”.', 'Correta. O comedão aberto corresponde ao "cravo preto", e não ao "cravo branco". Sua coloração escura resulta da oxidação da melanina e dos lipídios, e não da ação do Cutibacterium acnes.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'd2d89a47-5c41-5b41-a054-eddf31eff1ec'::uuid, 'cc585196-b4ba-583d-a7b6-fffa4e17375d'::uuid,
        'D', 'O microcomedão, o comedão fechado e o comedão aberto fazem parte do quadro de acne comedônica ou grau I.', 'Incorreta. Essas lesões compõem a acne comedônica (grau I), forma não inflamatória da doença.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 106 | Acne - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '50f42767-5d3a-5015-a74f-cd923cce2050'::uuid, v_discipline_id, NULL, 'médio',
        'Quanto ao tratamento da acne vulgar, marque a alternativa INCORRETA:', 'single',
        'D', ARRAY[]::text[],
        'O tratamento da acne vulgar depende da gravidade. A acne comedônica é tratada principalmente com retinoides tópicos. Nas formas inflamatórias, associam-se antibióticos orais aos tratamentos tópicos, evitando-se a monoterapia com antibióticos. A isotretinoína oral é indicada para formas graves, conglobata, fulminante ou acne resistente ao tratamento convencional. Seus principais efeitos adversos incluem queilite, xerose, elevação de transaminases e hipertrigliceridemia, além de apresentar alto potencial teratogênico, exigindo contracepção rigorosa em mulheres em idade fértil.', 'O tratamento da acne vulgar depende da gravidade.',
        'Grau I → retinoide tópico.
Grau II/III → retinoide + antibiótico.
Isotretinoína = acne grave.
Isotretinoína = teratogênica → anticoncepção obrigatória.
Isotretinoína ↑ triglicerídeos (não diminui!).', 'Atenção ao comando: deve-se marcar a alternativa incorreta ou a exceção.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'cf5afe94-e962-5e1c-a04e-a05dd611e12c'::uuid, '50f42767-5d3a-5015-a74f-cd923cce2050'::uuid,
        'A', 'Na acne comedônica, o tratamento consiste em medicação tópica, como a tretinoína gel', 'Incorreta. Na acne comedônica (grau I), os retinoides tópicos (como tretinoína, adapaleno e tazaroteno) constituem o tratamento de primeira linha, pois atuam na hiperqueratinização folicular.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '10d0fe2e-0a83-5b48-b368-463c38659ae0'::uuid, '50f42767-5d3a-5015-a74f-cd923cce2050'::uuid,
        'B', 'Na acne inflamatória, podem ser empregados antibióticos orais, como a tetraciclina', 'Incorreta. Nas formas inflamatórias moderadas a graves, podem ser utilizados antibióticos orais, como doxiciclina, limeciclina, minociclina e tetraciclina, sempre associados ao tratamento tópico.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'df9505e3-9a72-5378-9d00-8c1db2e94dfc'::uuid, '50f42767-5d3a-5015-a74f-cd923cce2050'::uuid,
        'C', 'É necessária anticoncepção para uso de isotretinoína oral em mulheres em idade fértil, por sua ação teratogênica', 'Incorreta. A isotretinoína é altamente teratogênica, sendo obrigatória a adoção de método contraceptivo eficaz antes, durante e após o tratamento em mulheres com potencial reprodutivo.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'f6f93383-f8f9-551c-9326-59916c8ecfd6'::uuid, '50f42767-5d3a-5015-a74f-cd923cce2050'::uuid,
        'D', 'Dentre os principais efeitos adversos da isotretinoína oral, estão o ressecamento labial, xerose cutânea e diminuição dos níveis de triglicerídeos', 'Correta. A isotretinoína costuma provocar aumento, e não diminuição, dos triglicerídeos e do colesterol. Os efeitos adversos mais comuns incluem queilite (ressecamento labial), xerose cutânea, ressecamento ocular, elevação de transaminases e hipertrigliceridemia.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 107 | Acne - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '2348ad2b-ee5c-59d3-a1fb-9f9b519d74ab'::uuid, v_discipline_id, NULL, 'médio',
        'Bactérias encontradas na porção profunda do folículo pilossebáceo participam na patogênese da acne. Quanto a esse tópico, marque a alternativa INCORRETA:', 'single',
        'D', ARRAY[]::text[],
        'O Cutibacterium acnes participa da fisiopatologia da acne ao proliferar no interior do folículo obstruído e produzir lipases, que degradam os triglicerídeos do sebo em ácidos graxos livres pró-inflamatórios. Além disso, componentes da parede bacteriana estimulam a resposta imune, favorecendo a produção de citocinas inflamatórias. Apesar desse papel, a acne não é uma doença infecciosa nem contagiosa. Nas formas inflamatórias, os antibióticos tópicos e orais são indicados para reduzir a carga bacteriana e a inflamação, devendo ser associados ao peróxido de benzoíla para minimizar o desenvolvimento de resistência bacteriana.', 'O Cutibacterium acnes participa da fisiopatologia da acne ao proliferar no interior do folículo obstruído e produzir lipases, que degradam os triglicerídeos do sebo em ácidos graxos livres pró-inflamatórios.',
        'Os 4 pilares da acne:
↑ Sebo
↑ Queratinização
↑ Cutibacterium acnes
↑ Inflamação
👉 Acne não é contagiosa, mas usa antibiótico.
👉 Nunca usar antibiótico tópico isolado → associar ao peróxido de benzoíla.', 'Atenção ao comando: deve-se marcar a alternativa incorreta ou a exceção.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '11c40d2a-1377-5a7d-96c3-362b135d2c8a'::uuid, '2348ad2b-ee5c-59d3-a1fb-9f9b519d74ab'::uuid,
        'A', 'Com a retenção sebácea, bactérias presentes no folículo proliferam e hidrolisam triglicerídeos do sebo, liberando ácidos graxos, que são irritantes para a parede folicular.', 'Incorreta. O Cutibacterium acnes prolifera no ambiente rico em sebo e produz lipases que hidrolisam os triglicerídeos, liberando ácidos graxos livres, os quais intensificam a inflamação da unidade pilossebácea.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '49312e77-eb24-5dd1-aaaa-a99265946a6c'::uuid, '2348ad2b-ee5c-59d3-a1fb-9f9b519d74ab'::uuid,
        'B', 'A pressão do sebo acumulado pode romper o epitélio folicular, desencadeando uma resposta inflamatória.', 'Incorreta. A ruptura da parede folicular libera sebo, queratina e bactérias para a derme, desencadeando intensa resposta inflamatória com formação de pápulas, pústulas, nódulos e abscessos.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'd992d6d0-43ff-50f2-b5b1-2830c42bdf15'::uuid, '2348ad2b-ee5c-59d3-a1fb-9f9b519d74ab'::uuid,
        'C', 'Na parede dessas bactérias, existem antígenos que estimulam a produção de anticorpos e a resposta imune celular.', 'Incorreta. Antígenos do Cutibacterium acnes ativam a imunidade inata e adaptativa, promovendo liberação de citocinas inflamatórias e contribuindo para o desenvolvimento das lesões inflamatórias.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'c08d1cd2-5948-5174-b40f-6430abb6b6ed'::uuid, '2348ad2b-ee5c-59d3-a1fb-9f9b519d74ab'::uuid,
        'D', 'Apesar da participação das bactérias, a acne não é uma doença contagiosa e antibióticos tópicos não fazem parte de seu tratamento.', 'Correta. Embora a acne não seja contagiosa, os antibióticos tópicos (como clindamicina e eritromicina) fazem parte do tratamento das formas inflamatórias, sempre associados ao peróxido de benzoíla, para reduzir o risco de resistência bacteriana.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 108 | Acne - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        'f8302637-38ce-52f2-999d-c3bb0c1e3ef6'::uuid, v_discipline_id, NULL, 'médio',
        'Qual o grau de acne clinicamente constitui-se de pápulas eritematosas e lesões císticas?', 'single',
        'D', ARRAY[]::text[],
        'A classificação clínica da acne baseia-se na intensidade da inflamação. A acne grau III, também denominada nódulo-abscedante, caracteriza-se pelo aparecimento de nódulos inflamatórios e lesões císticas, além de pápulas e pústulas. Essas lesões resultam da ruptura da parede folicular, com extravasamento do conteúdo para a derme e intensa resposta inflamatória, aumentando o risco de cicatrizes permanentes.', 'A classificação clínica da acne baseia-se na intensidade da inflamação.',
        'Classificação da acne:
Grau I → Comedões
Grau II → Pápulas + pústulas
Grau III → Nódulos/cistos (abscessos)
Grau IV → Conglobata (fístulas e cicatrizes)
Grau V → Fulminans (febre + artralgia + necrose)
👉 Cistos = Grau III.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '3f5dc463-3cfa-574a-9d7c-b66b90a74432'::uuid, 'f8302637-38ce-52f2-999d-c3bb0c1e3ef6'::uuid,
        'A', 'Acne fulminans', 'Incorreta. A acne fulminans (grau V) é a forma mais grave, acompanhada de febre, mal-estar, artralgia, mialgia e ulcerações hemorrágicas, não sendo definida apenas por pápulas e cistos.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '0390d30d-5e3a-5e3d-824a-32ead1e88d6b'::uuid, 'f8302637-38ce-52f2-999d-c3bb0c1e3ef6'::uuid,
        'B', 'Acne comedoniana', 'Incorreta. A acne comedoniana (grau I) caracteriza-se por comedões abertos e fechados, sem lesões císticas.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '82c9abad-2163-5b62-a779-9ac9075ba7e7'::uuid, 'f8302637-38ce-52f2-999d-c3bb0c1e3ef6'::uuid,
        'C', 'Acne grau V', 'Incorreta. A acne grau V corresponde à acne fulminans, quadro sistêmico grave com manifestações constitucionais.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'b1bc4a36-8015-5d3c-99d0-04722cf73249'::uuid, 'f8302637-38ce-52f2-999d-c3bb0c1e3ef6'::uuid,
        'D', 'Acne grau III', 'Correta. A acne grau III (nódulo-abscedante) apresenta pápulas inflamatórias, pústulas, nódulos e lesões císticas (abscessos), decorrentes da ruptura da parede folicular e intensa resposta inflamatória.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 109 | Acne - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '2638a91e-fac3-5a26-979d-19429c6222e8'::uuid, v_discipline_id, NULL, 'médio',
        'Qual dentre as causas abaixo não é causa aventada na gênese da acne?', 'single',
        'C', ARRAY[]::text[],
        'A acne é uma doença multifatorial cuja fisiopatologia envolve hipersecreção sebácea, hiperqueratinização folicular, proliferação do Cutibacterium acnes e inflamação. Diversos fatores podem agravar o quadro, como cosméticos comedogênicos, dieta rica em leite e alimentos de alto índice glicêmico, uso de esteroides e alguns contraceptivos com maior atividade androgênica. A vitamina C, por outro lado, não possui relação comprovada com o desenvolvimento ou agravamento da acne.', 'A acne é uma doença multifatorial cuja fisiopatologia envolve hipersecreção sebácea, hiperqueratinização folicular, proliferação do Cutibacterium acnes e inflamação.',
        'Fatores que podem piorar a acne:
🧴 Cosméticos comedogênicos
🥛 Leite e derivados
💊 Esteroides/anabolizantes
💉 Andrógenos
💊 Alguns anticoncepcionais (progestagênios androgênicos)
🚫 Vitamina C não faz parte dessa lista.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'ab60c0ee-b0e7-59bf-aa11-3fcc90d54d74'::uuid, '2638a91e-fac3-5a26-979d-19429c6222e8'::uuid,
        'A', 'Cosméticos faciais oleosos', 'Incorreta. Cosméticos comedogênicos podem favorecer a obstrução folicular e desencadear ou agravar a acne, caracterizando a chamada acne cosmética.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '16ed3532-54f1-5937-b8ed-809597935053'::uuid, '2638a91e-fac3-5a26-979d-19429c6222e8'::uuid,
        'B', 'Dieta rica em lactose', 'Incorreta. Estudos sugerem associação entre leite e derivados (especialmente leite desnatado) e agravamento da acne, possivelmente pela influência sobre IGF-1 e hormônios presentes no leite.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '0ef7edcc-85c0-52c9-bb41-6f0591c9ce93'::uuid, '2638a91e-fac3-5a26-979d-19429c6222e8'::uuid,
        'C', 'Suplementos ricos em vitamina C', 'Correta. A vitamina C não está relacionada à fisiopatologia nem ao agravamento da acne. Não há evidências de que sua suplementação seja fator desencadeante da doença.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'ef4ad2b6-3fe7-508c-9e0b-2c0d4737c85f'::uuid, '2638a91e-fac3-5a26-979d-19429c6222e8'::uuid,
        'D', 'Uso de esteróides', 'Incorreta. O uso de corticosteroides e, principalmente, esteroides anabolizantes, pode induzir ou agravar a acne ("acne esteroide").'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '809ccaab-a31f-5c32-899c-0e5ef3a37f0f'::uuid, '2638a91e-fac3-5a26-979d-19429c6222e8'::uuid,
        'E', 'Alguns contraceptivos orais', 'Incorreta. Embora muitos contraceptivos combinados melhorem a acne, formulações com progestágenos de maior atividade androgênica podem desencadear ou piorar o quadro acneico.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 110 | Acne - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        'a9167d0c-1023-55a1-a81d-29dff55d9a96'::uuid, v_discipline_id, NULL, 'médio',
        'Qual o mais temido efeito adverso da isotretinoína oral e que consta no termo de consentimento livre e esclarecido do uso da mesma?', 'single',
        'A', ARRAY[]::text[],
        'A isotretinoína oral é o tratamento mais eficaz para acne grave, conglobata, fulminante ou resistente à terapêutica convencional. Seu efeito adverso mais importante é a teratogenicidade, com elevado risco de malformações fetais, motivo pelo qual seu uso exige contracepção rigorosa, testes de gravidez periódicos e assinatura do Termo de Consentimento Livre e Esclarecido. Outros efeitos adversos comuns incluem queilite, xerose cutânea, ressecamento ocular, hipertrigliceridemia e elevação das enzimas hepáticas, que devem ser monitorados durante o tratamento.', 'A isotretinoína oral é o tratamento mais eficaz para acne grave, conglobata, fulminante ou resistente à terapêutica convencional.',
        'Isotretinoína = "3 Ts"
Teratogênica ⭐ (mais importante)
Triglicerídeos ↑
Transaminases ↑
Além disso:
👄 Queilite
🧴 Xerose cutânea
👁️ Ressecamento ocular', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '1be6e5c7-44a1-5682-a9b9-748f8af62081'::uuid, 'a9167d0c-1023-55a1-a81d-29dff55d9a96'::uuid,
        'A', 'Teratogenicidade', 'Correta. A teratogenicidade é o efeito adverso mais grave da isotretinoína oral. O medicamento é altamente teratogênico, podendo causar malformações fetais graves, sendo obrigatória a utilização de método contraceptivo eficaz em mulheres em idade fértil e a assinatura do Termo de Consentimento Livre e Esclarecido.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '2a97188b-5733-5c34-9262-0ecb7192937b'::uuid, 'a9167d0c-1023-55a1-a81d-29dff55d9a96'::uuid,
        'B', 'Hepatite', 'Incorreta. A isotretinoína pode causar elevação das transaminases e, raramente, hepatotoxicidade, mas esse não é o efeito adverso mais temido nem o principal motivo do termo de consentimento.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'bf9c0dc9-4468-5373-93b5-64107ac02ad5'::uuid, 'a9167d0c-1023-55a1-a81d-29dff55d9a96'::uuid,
        'C', 'Xerodermia', 'Incorreta. A xerose cutânea e a queilite são os efeitos adversos mais frequentes, porém são reversíveis e geralmente leves quando comparados ao risco teratogênico.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '04c22d40-615f-59c8-a4f0-dd9f3a004d8b'::uuid, 'a9167d0c-1023-55a1-a81d-29dff55d9a96'::uuid,
        'D', 'Anafilaxia', 'Incorreta. Reações anafiláticas são extremamente raras e não representam a principal preocupação durante o uso da isotretinoína.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 111 | Acne - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        'a9c94933-7773-525e-83c2-517abbb541c5'::uuid, v_discipline_id, NULL, 'médio',
        'A acne é uma condição muito prevalente na sociedade. Marque a opção que melhor descreve a lesão:', 'single',
        'D', ARRAY[]::text[],
        'A acne vulgar é uma doença inflamatória crônica da unidade pilossebácea, caracterizada por um quadro polimorfo, composto por comedões, pápulas, pústulas, nódulos e cistos. As lesões surgem em regiões ricas em glândulas sebáceas, principalmente face, tórax e dorso, e resultam da interação entre hiperprodução de sebo, hiperqueratinização folicular, proliferação do Cutibacterium acnes e resposta inflamatória.', 'A acne vulgar é uma doença inflamatória crônica da unidade pilossebácea, caracterizada por um quadro polimorfo, composto por comedões, pápulas, pústulas, nódulos e cistos.',
        'Acne = doença da unidade pilossebácea.
Lesão inicial = comedão.
Lesão inflamatória típica = pápula perifolicular.
Face, tórax e dorso = principais locais.
Não forma vesículas nem lesões descamativas.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '345f3bff-d898-5b27-9f77-d3fb6c644c02'::uuid, 'a9c94933-7773-525e-83c2-517abbb541c5'::uuid,
        'A', 'Lesões eritematodescamativas da derme com infecção secundária', 'Incorreta. A acne não é uma dermatose eritematodescamativa. Trata-se de uma doença da unidade pilossebácea, caracterizada por comedões e lesões inflamatórias.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '5cb2adbf-9a36-5574-9e7a-8c7d7751de54'::uuid, 'a9c94933-7773-525e-83c2-517abbb541c5'::uuid,
        'B', 'Formação vesiculosa da derme com infecção secundária associada a lesão', 'Incorreta. A acne não cursa com vesículas. As lesões típicas são comedões, pápulas, pústulas, nódulos e cistos.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '39e046ef-99d1-5912-802e-291713b17653'::uuid, 'a9c94933-7773-525e-83c2-517abbb541c5'::uuid,
        'C', 'Mácula eritematosa com infecção secundária', 'Incorreta. A mácula não representa a lesão elementar da acne. As lesões iniciais são os comedões, que podem evoluir para lesões inflamatórias.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '6154acee-6f05-56be-b2b6-7c40bf5287cc'::uuid, 'a9c94933-7773-525e-83c2-517abbb541c5'::uuid,
        'D', 'Lesões papulosas em regiões perifoliculares', 'Correta. A acne é uma doença inflamatória da unidade pilossebácea, caracterizada por lesões perifoliculares, incluindo comedões, pápulas, pústulas, nódulos e cistos, predominando em áreas ricas em glândulas sebáceas, como face, tórax e dorso.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 112 | Acne - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '7f1f725f-2882-5f65-ad7a-77d2c83bc225'::uuid, v_discipline_id, NULL, 'médio',
        'Sobre a fisiopatogenia da acne, marque a CORRETA:', 'single',
        'C', ARRAY[]::text[],
        'A acne vulgar é uma doença inflamatória crônica da unidade pilossebácea. Sua fisiopatologia baseia-se em quatro mecanismos principais: hipersecreção sebácea, hiperqueratinização do infundíbulo folicular, proliferação do Cutibacterium acnes e resposta inflamatória. A obstrução do folículo leva à formação do microcomedão, que pode evoluir para comedões, pápulas, pústulas, nódulos e cistos. A interação desses mecanismos determina a gravidade e as manifestações clínicas da doença.', 'A acne vulgar é uma doença inflamatória crônica da unidade pilossebácea.',
        'Lembre dos 4 pilares da acne (SQBI):
Sebo ↑
Queratinização folicular ↑
Bactéria (Cutibacterium acnes)
Inflação
👉 Essa sequência explica praticamente toda a fisiopatologia da acne.', 'Atenção ao comando: apenas uma alternativa deve corresponder integralmente ao enunciado.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '6213a791-dfc6-534a-95e0-a0809b089287'::uuid, '7f1f725f-2882-5f65-ad7a-77d2c83bc225'::uuid,
        'A', 'Lesão superficial da pele com consequente infecção secundária pelo Staphylococcus aureus', 'Incorreta. A acne não se inicia por infecção cutânea. Trata-se de uma doença da unidade pilossebácea, cuja fisiopatologia envolve hiperprodução de sebo, hiperqueratinização folicular, proliferação do Cutibacterium acnes e inflamação.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'bead5811-7a42-5914-a49e-4d8935f9b27f'::uuid, '7f1f725f-2882-5f65-ad7a-77d2c83bc225'::uuid,
        'B', 'Lesão eritematosa descamativa de cunho imunológico', 'Incorreta. A acne não é uma dermatose imunológica primária nem eritematodescamativa. A inflamação é secundária aos eventos que ocorrem na unidade pilossebácea.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '8b822e94-e27b-5800-b813-a8887d6aa6f9'::uuid, '7f1f725f-2882-5f65-ad7a-77d2c83bc225'::uuid,
        'C', 'Obstrução folicular por acúmulo de sebo, proliferação de bactérias e inflamação local', 'Correta. A fisiopatologia da acne envolve hiperqueratinização folicular, obstrução do folículo pilossebáceo, aumento da produção de sebo, proliferação do Cutibacterium acnes e intensa resposta inflamatória local.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'db6c6b65-c9b8-5769-9aae-2abb5ba1137d'::uuid, '7f1f725f-2882-5f65-ad7a-77d2c83bc225'::uuid,
        'D', 'Reação alérgica com formação de pústulas na derme', 'Incorreta. A acne não resulta de uma reação alérgica. As pústulas surgem em consequência da inflamação da unidade pilossebácea, e não por hipersensibilidade.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 113 | Acne - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        'dc4d03b0-ed79-5820-aa9e-fb8f27bd461e'::uuid, v_discipline_id, NULL, 'médio',
        '( ) O uso crônico de corticoides pode acarretar em acne', 'single',
        'B', ARRAY[]::text[],
        'Os andrógenos estimulam a atividade das glândulas sebáceas, sendo fundamentais na fisiopatologia da acne. Entretanto, a maioria dos pacientes apresenta níveis hormonais normais, existindo maior sensibilidade dos receptores androgênicos da unidade pilossebácea. A acne também pode ocorrer em crianças, embora seja mais comum na adolescência. Além disso, alguns medicamentos, especialmente os corticosteroides sistêmicos, podem desencadear a chamada acne medicamentosa (acne esteroide).', 'Os andrógenos estimulam a atividade das glândulas sebáceas, sendo fundamentais na fisiopatologia da acne.',
        'Hormônios na acne:
✅ Andrógenos participam da acne.
❌ A maioria dos pacientes não tem hiperandrogenismo.
👶 Crianças podem ter acne (neonatal, infantil e pré-puberal).
💊 Corticoides → acne esteroide.
👉 Sensibilidade aos andrógenos > quantidade de andrógenos.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '70c74057-3a93-5c01-ba8c-c75be40ad6c0'::uuid, 'dc4d03b0-ed79-5820-aa9e-fb8f27bd461e'::uuid,
        'A', 'V - V - F - F', 'Incorreta. A maioria dos pacientes com acne não apresenta aumento dos andrógenos séricos, e o uso crônico de corticoides pode desencadear acne.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '277468be-d6b7-5f3d-8281-749979b9d512'::uuid, 'dc4d03b0-ed79-5820-aa9e-fb8f27bd461e'::uuid,
        'B', 'V - F - F - V', 'Correta. Os andrógenos desempenham papel central na acne, porém a maioria dos pacientes possui níveis hormonais normais, havendo maior sensibilidade da unidade pilossebácea. Crianças podem apresentar acne (neonatal, infantil ou pré-puberal), e o uso prolongado de corticoides pode causar acne esteroide.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '475d2651-d417-5b13-a1b1-166c270cb59b'::uuid, 'dc4d03b0-ed79-5820-aa9e-fb8f27bd461e'::uuid,
        'C', 'V - V - F - V', 'Incorreta. O erro está em afirmar que pacientes acneicos apresentam, na maioria, níveis elevados de andrógenos circulantes.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '8326ba5e-0a3b-5ac5-87c9-7f6c8bc99c86'::uuid, 'dc4d03b0-ed79-5820-aa9e-fb8f27bd461e'::uuid,
        'D', 'V - F - V - F', 'Incorreta. Crianças podem desenvolver acne em diferentes fases da infância, e os corticoides podem desencadear acne medicamentosa.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 114 | Acne - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        'c9c6cf47-1b20-5860-8f62-faceea36c9d1'::uuid, v_discipline_id, NULL, 'médio',
        'A respeito da acne, marque a alternativa CORRETA:', 'single',
        'A', ARRAY[]::text[],
        'A acne vulgar é uma doença multifatorial, com forte influência genética. A predisposição hereditária interfere na produção de sebo, na queratinização folicular e na intensidade da resposta inflamatória. Embora seja mais prevalente na adolescência, a acne pode persistir ou surgir na idade adulta, especialmente em mulheres, quando fatores hormonais e medicamentosos tornam-se mais relevantes. As formas graves são mais comuns em homens jovens, enquanto a maior parte dos pacientes apresenta quadros leves ou moderados.', 'A acne vulgar é uma doença multifatorial, com forte influência genética.',
        '🧬 Genética = fator importante na acne.
👦 Homens → formas mais graves.
👩 Mulheres adultas → investigar causas hormonais (SOP, medicamentos).
📊 A maioria dos casos é leve.
👉 Se os pais tiveram acne importante, o risco no filho aumenta bastante.', 'Atenção ao comando: apenas uma alternativa deve corresponder integralmente ao enunciado.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '88d46175-0fe2-55d4-9b16-96cbe95a8429'::uuid, 'c9c6cf47-1b20-5860-8f62-faceea36c9d1'::uuid,
        'A', 'Existe um forte componente genético para formação de acne', 'Correta. A acne apresenta importante predisposição genética, influenciando a atividade das glândulas sebáceas, a queratinização folicular, a resposta inflamatória e a suscetibilidade individual à doença.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '045a6600-1976-56e4-9e66-8e18e4e8863d'::uuid, 'c9c6cf47-1b20-5860-8f62-faceea36c9d1'::uuid,
        'B', 'mulheres costumam desenvolver as formas mais graves de acne', 'Incorreta. As formas mais graves, como acne conglobata e acne fulminans, predominam em homens jovens, devido à maior influência dos andrógenos.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '23ae5e9c-d284-5667-ba96-e7ad95ff7a98'::uuid, 'c9c6cf47-1b20-5860-8f62-faceea36c9d1'::uuid,
        'C', 'A etiologia da acne em pacientes com mais idade é a mesma da etiologia de acne em adolescentes', 'Incorreta. Embora compartilhem mecanismos fisiopatológicos, a acne do adulto, especialmente em mulheres, pode estar relacionada a fatores hormonais, cosméticos, medicamentos e síndrome dos ovários policísticos, diferindo parcialmente da acne da adolescência.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '1b35b74b-8e34-5ec6-9cdb-217dd10ffe6c'::uuid, 'c9c6cf47-1b20-5860-8f62-faceea36c9d1'::uuid,
        'D', 'A acne moderada/grave costuma ocorrer em até 50% dos casos de acne', 'Incorreta. A maioria dos pacientes apresenta formas leves (comedônica ou pápulo-pustulosa leve). As formas moderadas e graves representam uma parcela significativamente menor dos casos.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 115 | Acne - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '94625772-9944-5c76-9538-af820a77ffb9'::uuid, v_discipline_id, NULL, 'médio',
        'A acne pode ser classificada de acordo com sua morfologia e potencial grau de gravidade. A respeito destas classificações marque a CORRETA:', 'single',
        'D', ARRAY[]::text[],
        'A classificação clínica da acne acompanha a progressão da inflamação. A acne grau I é exclusivamente comedônica. A grau II apresenta pápulas e pústulas inflamatórias. A grau III caracteriza-se por nódulos e abscessos, decorrentes da ruptura da parede folicular. Já a grau IV (acne conglobata) é marcada pela presença de abscessos profundos, fístulas intercomunicantes e cicatrizes extensas, sendo uma das formas mais graves da doença e frequentemente necessitando de tratamento com isotretinoína oral.', 'A classificação clínica da acne acompanha a progressão da inflamação.',
        'Classificação da acne:
Grau I → Comedões
Grau II → Pápulas + pústulas
Grau III → Nódulos + abscessos
Grau IV → Fístulas + abscessos + cicatrizes (Conglobata)
Grau V → Fulminante (febre, artralgia, mialgia)
👉 A palavra "fístula" praticamente entrega o Grau IV.', 'Atenção ao comando: apenas uma alternativa deve corresponder integralmente ao enunciado.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '90a8479d-8eb1-57b5-8b90-160e32b39b86'::uuid, '94625772-9944-5c76-9538-af820a77ffb9'::uuid,
        'A', 'Acne grau I - presença de inflamação e distensão leve', 'Incorreta. A acne grau I (comedônica) é não inflamatória, caracterizada apenas pela presença de comedões abertos e fechados, sem pápulas ou pústulas.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '38a8809b-da9a-5e6f-a50c-f598c204ab9a'::uuid, '94625772-9944-5c76-9538-af820a77ffb9'::uuid,
        'B', 'Acne grau II - inflamação com pápulas, pústulas e nódulos furunculóides', 'Incorreta. A acne grau II (pápulo-pustulosa) apresenta pápulas e pústulas, porém não há nódulos furunculoides, que caracterizam graus mais avançados.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '251fedec-8258-57d3-8ca0-d2ddd80dc170'::uuid, '94625772-9944-5c76-9538-af820a77ffb9'::uuid,
        'C', 'Acne grau III - obstrução sem inflamação', 'Incorreta. A acne grau III (nódulo-abscedante) é uma forma inflamatória, caracterizada por nódulos, abscessos e intensa reação inflamatória.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'd4b698d0-0394-5960-aa72-c15a9623fd94'::uuid, '94625772-9944-5c76-9538-af820a77ffb9'::uuid,
        'D', 'Acne grau IV - inflamação já com formação de abcessos e fístulas', 'Correta. A acne grau IV (conglobata) é uma forma grave da doença, caracterizada por nódulos, abscessos, fístulas intercomunicantes e cicatrizes, acometendo principalmente homens jovens.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 116 | Acne - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '707e2f8b-fd73-5c10-a7fd-dab77ec1b80f'::uuid, v_discipline_id, NULL, 'médio',
        'Sobre a acne, marque a alternativa CORRETA:', 'single',
        'D', ARRAY[]::text[],
        'A acne vulgar é diagnosticada clinicamente, dispensando exames complementares na maioria dos casos. A higiene adequada auxilia no controle da oleosidade, mas não elimina a doença, cuja origem está na unidade pilossebácea. A exposição solar não constitui tratamento e pode inclusive agravar as sequelas da acne. Fatores dietéticos, especialmente alimentos de alto índice glicêmico e laticínios, podem contribuir para o agravamento em indivíduos suscetíveis, mas não são considerados causa única da doença.', 'A acne vulgar é diagnosticada clinicamente, dispensando exames complementares na maioria dos casos.',
        'Acne = diagnóstico clínico.
☀️ Sol não trata acne.
🍫 Dieta pode influenciar, mas não é causa isolada.
🧼 Higiene ajuda, mas excesso piora.
👉 Nem sujeira causa acne, nem lavar o rosto 10 vezes por dia resolve.', 'Atenção ao comando: apenas uma alternativa deve corresponder integralmente ao enunciado.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '836428bb-db97-58a7-b00b-ff430cd699fc'::uuid, '707e2f8b-fd73-5c10-a7fd-dab77ec1b80f'::uuid,
        'A', 'O diagnóstico envolve a biópsia para análise das lesões', 'Incorreta. O diagnóstico da acne é essencialmente clínico, baseado na história e no exame dermatológico. A biópsia é raramente necessária.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'a2f1c817-00a4-5e8e-a9ef-9a3472bd93c5'::uuid, '707e2f8b-fd73-5c10-a7fd-dab77ec1b80f'::uuid,
        'B', 'Chocolate não tem correlação com formação de acne', 'Incorreta. Embora o chocolate isoladamente não seja considerado causa direta da acne, estudos sugerem que dietas ricas em açúcares de alto índice glicêmico e alguns tipos de chocolate podem agravar o quadro em indivíduos predispostos.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '2ec4e71a-6a23-5fc8-9cce-55e0a482510b'::uuid, '707e2f8b-fd73-5c10-a7fd-dab77ec1b80f'::uuid,
        'C', 'Banhos de sol podem funcionar como tratamento da acne', 'Incorreta. A exposição solar pode produzir melhora temporária pela ação anti-inflamatória e pelo mascaramento das lesões, porém não é tratamento para acne. Além disso, pode provocar efeito rebote, hiperpigmentação e aumentar o risco de câncer de pele.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '67c2fe35-c05e-5b3a-a362-d90efe432233'::uuid, '707e2f8b-fd73-5c10-a7fd-dab77ec1b80f'::uuid,
        'D', 'A má higiene pode piorar o quadro da acne.', 'Correta. Embora a acne não seja causada por falta de higiene, a limpeza inadequada da pele favorece o acúmulo de oleosidade, resíduos e cosméticos, podendo contribuir para a obstrução folicular e agravar o quadro. Por outro lado, lavagens excessivas também são prejudiciais, pois irritam a pele e estimulam maior produção de sebo.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 117 | Acne - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        'edf72d34-8ff0-562b-88f5-f9d70135a022'::uuid, v_discipline_id, NULL, 'médio',
        'A respeito da etiopatogenia da acne vulgar, assinale a opção CORRETA:', 'single',
        'D', ARRAY[]::text[],
        'A acne vulgar resulta da interação de quatro mecanismos fisiopatológicos: hipersecreção sebácea, hiperqueratinização folicular, proliferação do Cutibacterium acnes e resposta inflamatória. O primeiro evento é a obstrução do infundíbulo folicular, que leva à formação do microcomedão. A doença apresenta herança multifatorial, e os andrógenos exercem papel importante ao estimular a atividade das glândulas sebáceas, embora a maioria dos pacientes apresente níveis séricos hormonais normais.', 'A acne vulgar resulta da interação de quatro mecanismos fisiopatológicos: hipersecreção sebácea, hiperqueratinização folicular, proliferação do Cutibacterium acnes e resposta inflamatória.',
        'Os 4 pilares da acne (SQBI):
Sebo ↑
Queratinização folicular ↑ ⭐ (evento inicial)
Bactéria (Cutibacterium acnes)
Inflação
👉 A lesão inicial é o microcomedão, formado pela hiperqueratinização folicular.', 'Atenção ao comando: apenas uma alternativa deve corresponder integralmente ao enunciado.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'b2177282-31fd-594e-a6a9-7e6e1aac6f40'::uuid, 'edf72d34-8ff0-562b-88f5-f9d70135a022'::uuid,
        'A', 'A participação bacteriana não é fundamental no que diz respeito à etiopatogênese da acne vulgar.', 'Incorreta. A proliferação do Cutibacterium acnes constitui um dos quatro pilares da fisiopatologia da acne, participando da resposta inflamatória por meio da produção de lipases e ativação do sistema imune.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '87b54991-56cf-54a9-909d-7be917d0dd93'::uuid, 'edf72d34-8ff0-562b-88f5-f9d70135a022'::uuid,
        'B', 'Existem indícios de que a ocorrência da acne vulgar seja dada por tendência hereditária, transmitida por genes autossômicos recessivos.', 'Incorreta. A acne possui forte componente genético, porém sua herança é multifatorial e poligênica, não seguindo um padrão autossômico recessivo.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'd8f90611-ed26-560c-901c-528ec0d48cf3'::uuid, 'edf72d34-8ff0-562b-88f5-f9d70135a022'::uuid,
        'C', 'Nos casos de acne vulgar, a secreção sebácea é reduzida, mas a obstrução folicular leva ao acúmulo de sebo dentro do folículo', 'Incorreta. Na acne ocorre aumento da produção de sebo, estimulado pelos andrógenos, associado à hiperqueratinização folicular.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '57a488ca-6b1b-5060-aeb1-a7b89a3c36d6'::uuid, 'edf72d34-8ff0-562b-88f5-f9d70135a022'::uuid,
        'D', 'A acne vulgar ocorre em razão de um distúrbio de queratinização folicular, que leva à obstrução do folículo', 'Correta. A hiperqueratinização do infundíbulo folicular é um dos principais eventos da fisiopatologia da acne. A obstrução do folículo leva à formação do microcomedão, lesão inicial da doença.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '4e8da1f5-5fe9-50d9-8c34-3cf969ef0876'::uuid, 'edf72d34-8ff0-562b-88f5-f9d70135a022'::uuid,
        'E', 'O estímulo androgênico, embora presente em outros tipos de acne, não está relacionado à acne vulgar', 'Incorreta. Os andrógenos desempenham papel fundamental na acne vulgar, estimulando a produção de sebo e favorecendo o desenvolvimento das lesões.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 118 | Acne - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '13af0960-251d-5411-8895-2254ff2b6071'::uuid, v_discipline_id, NULL, 'médio',
        'Na maior parte dos casos, a acne se origina de um distúrbio primário, ou seja, de uma disfunção do próprio mecanismo folicular/sebáceo. No entanto, existe a acne secundária. Sobre elas, marque a alternativa CORRETA:', 'single',
        'A', ARRAY[]::text[],
        'A maioria dos casos corresponde à acne vulgar primária, decorrente de alterações próprias da unidade pilossebácea. Entretanto, a acne secundária pode surgir em consequência de doenças endócrinas, especialmente a Síndrome dos Ovários Policísticos (SOP), além do uso de medicamentos como corticosteroides, anabolizantes, lítio e anticonvulsivantes. Cosméticos comedogênicos também podem favorecer o aparecimento da acne cosmética. Nessas situações, além do tratamento dermatológico, é fundamental corrigir o fator desencadeante sempre que possível.', 'A maioria dos casos corresponde à acne vulgar primária, decorrente de alterações próprias da unidade pilossebácea.',
        'Principais causas de acne secundária:
👩 SOP (hiperandrogenismo)
💊 Corticoides e anabolizantes
🧴 Cosméticos comedogênicos
💊 Alguns anticoncepcionais
⚠️ Medicamentos (lítio, fenitoína, isoniazida, entre outros)
👉 Acne persistente em mulher adulta = pensar em SOP.', 'Atenção ao comando: apenas uma alternativa deve corresponder integralmente ao enunciado.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'cc103f33-6a4d-5823-be22-7e95a0a3bf41'::uuid, '13af0960-251d-5411-8895-2254ff2b6071'::uuid,
        'A', 'a acne pode ser decorrente de um quadro de Síndrome dos Ovários Policísticos', 'Correta. A Síndrome dos Ovários Policísticos (SOP) é uma importante causa de acne secundária em mulheres, devido ao hiperandrogenismo. Nesses casos, a acne costuma ser persistente, de início tardio ou resistente ao tratamento convencional, devendo-se investigar alterações hormonais.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'd3ae2119-6804-55c5-aeca-ae9bdc7f086a'::uuid, '13af0960-251d-5411-8895-2254ff2b6071'::uuid,
        'B', 'acne infantil geralmente ocorre por hiperprodução hormonal da criança', 'Incorreta. A acne infantil possui etiologia multifatorial e não decorre, na maioria dos casos, de hiperprodução hormonal da criança. Na acne neonatal, por exemplo, há influência dos andrógenos maternos e da atividade fisiológica das glândulas sebáceas.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '4af86a9d-0193-5eba-8458-ba91c5c0aa96'::uuid, '13af0960-251d-5411-8895-2254ff2b6071'::uuid,
        'C', 'corticosteróides provocam acne pela redução da resposta imunológica a agentes causadores da acne', 'Incorreta. Os corticosteroides podem desencadear acne medicamentosa, porém o mecanismo não ocorre simplesmente por imunossupressão. Há alterações da queratinização folicular e da unidade pilossebácea, produzindo lesões monomórficas.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '19fbe0a7-c873-502a-be1a-d764301585ef'::uuid, '13af0960-251d-5411-8895-2254ff2b6071'::uuid,
        'D', 'excesso de maquiagem não altera a quantidade de sebo da pele e portanto não causam acne', 'Incorreta. Cosméticos comedogênicos podem obstruir o folículo pilossebáceo e desencadear ou agravar a chamada acne cosmética, mesmo sem aumentar diretamente a produção de sebo.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 119 | Acne - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '55bde8bc-73d6-5c2b-b1c7-d4cca4e7377d'::uuid, v_discipline_id, NULL, 'médio',
        'Paciente masculino, 16 anos, chega ao consultório referindo piora do quadro de acne há 6 meses. Ao exame físico, você nota lesões pustulosas discretas perifoliculares na região da face. Acreditando ser um quadro de acne grau II, qual tratamento está indicado para o paciente?', 'single',
        'D', ARRAY[]::text[],
        'O tratamento da acne deve ser individualizado conforme a gravidade. Na acne grau II, predominam pápulas e pústulas superficiais, sendo indicada a associação de retinoide tópico com peróxido de benzoíla, que atua tanto na formação dos comedões quanto na redução da carga bacteriana e da inflamação. Antibióticos tópicos, quando utilizados, devem ser sempre associados ao peróxido de benzoíla, evitando resistência do Cutibacterium acnes. A isotretinoína fica reservada para formas graves ou refratárias.', 'O tratamento da acne deve ser individualizado conforme a gravidade.',
        'Tratamento por grau da acne:
Grau I → Retinoide tópico
Grau II → Retinoide + Peróxido de benzoíla ⭐
Grau III → Acrescentar antibiótico oral
Graus IV e V → Isotretinoína oral
👉 Nunca usar antibiótico tópico isolado.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '8ebcd442-cbc6-5edb-82e9-31590b130bb0'::uuid, '55bde8bc-73d6-5c2b-b1c7-d4cca4e7377d'::uuid,
        'A', 'indicação de isotretinoina (Roacutan)', 'Incorreta. A isotretinoína oral é indicada para formas graves, como acne conglobata, fulminante, nódulo-cística extensa ou resistente ao tratamento convencional. Não é tratamento de primeira linha para acne grau II.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'faef7e38-3ae8-5542-8c57-d090410a7686'::uuid, '55bde8bc-73d6-5c2b-b1c7-d4cca4e7377d'::uuid,
        'B', 'prescrição apenas de eritromicina tópica e consultas regulares para acompanhamento do quadro', 'Incorreta. A monoterapia com antibiótico tópico deve ser evitada, devido ao risco de resistência bacteriana. Quando indicado, deve ser sempre associado ao peróxido de benzoíla.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'eafe96e2-6b79-5b19-a2e6-c4523fca61e8'::uuid, '55bde8bc-73d6-5c2b-b1c7-d4cca4e7377d'::uuid,
        'C', 'indicação apenas de retinóides tópicos e acompanhamento regular do quadro', 'Incorreta. Os retinoides tópicos isolados são mais indicados para a acne comedônica (grau I). Na acne grau II, deve-se associar um agente com ação sobre a inflamação e o Cutibacterium acnes.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '9471a3fa-fdc1-53f2-8512-2a10e76a42d3'::uuid, '55bde8bc-73d6-5c2b-b1c7-d4cca4e7377d'::uuid,
        'D', 'indicação de retinóide tópico e peróxido de benzoíla, com acompanhamento regular do quadro', 'Correta. Na acne grau II (pápulo-pustulosa leve), o tratamento inicial recomendado consiste na associação de retinoide tópico (adapaleno, tretinoína ou tazaroteno) com peróxido de benzoíla, que atua reduzindo a proliferação do Cutibacterium acnes e diminuindo o risco de resistência bacteriana.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 120 | Acne - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '0014cb74-ed0e-54df-adb0-d2e5c104e30b'::uuid, v_discipline_id, NULL, 'médio',
        'Paciente masculino, 16 anos, refere quadro de acne há 2 anos em rosto e costas. Refere prejuízo na sua vida social e cita problemas na sua auto-aceitação. Cita tratamento tópico anterior para seu quadro de acne, porém ineficaz. Ao exame físico, você nota formações de cicatrizes extensas, abcessos e fístulas no rosto e inúmeras pápulas permeadas por cicatrizes em derme das costas. Qual tratamento você indicaria para o quadro de acne grave apresentado?', 'single',
        'A', ARRAY[]::text[],
        'A isotretinoína oral é o tratamento de escolha para as formas graves de acne, como a acne conglobata, a acne fulminans e os casos com cicatrizes extensas ou refratários ao tratamento convencional. O medicamento atua reduzindo intensamente a produção de sebo, normalizando a queratinização folicular, diminuindo a colonização por Cutibacterium acnes e reduzindo a inflamação. Nos quadros extremamente inflamatórios, principalmente na acne fulminante, recomenda-se iniciar ou associar corticosteroides sistêmicos para controlar a resposta inflamatória antes da introdução ou durante o início da isotretinoína.', 'A isotretinoína oral é o tratamento de escolha para as formas graves de acne, como a acne conglobata, a acne fulminans e os casos com cicatrizes extensas ou refratários ao tratamento convencional.',
        'Tratamento da acne por gravidade:
Grau I → Retinoide tópico.
Grau II → Retinoide + peróxido de benzoíla.
Grau III → Antibiótico oral + tratamento tópico.
Graus IV e V → Isotretinoína oral.
👉 Fístulas + abscessos + cicatrizes = pense imediatamente em isotretinoína.
👉 Se houver inflamação exuberante ou acne fulminante, considerar corticoide sistêmico antes ou junto da isotretinoína.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '78f43bf3-f190-5d55-acc3-cc17184f3804'::uuid, '0014cb74-ed0e-54df-adb0-d2e5c104e30b'::uuid,
        'A', 'indicação de isotretinoína e considerar associação com corticoides', 'Correta. O quadro é compatível com acne grave (conglobata ou fulminante, dependendo da presença de sintomas sistêmicos), caracterizada por abscessos, fístulas e cicatrizes extensas. O tratamento de escolha é a isotretinoína oral. Em casos muito inflamatórios ou de acne fulminante, pode ser necessária a associação temporária de corticosteroides sistêmicos para controlar a inflamação e evitar piora inicial.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'ee163394-751b-5eb7-af58-49807dfebe56'::uuid, '0014cb74-ed0e-54df-adb0-d2e5c104e30b'::uuid,
        'B', 'retinóide tópico + peróxido de benzoíla', 'Incorreta. Essa associação é indicada principalmente para acne leve a moderada (graus I e II), sendo insuficiente para quadros graves com abscessos e cicatrizes.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '7db77e12-c454-5998-9619-f039a3ca48be'::uuid, '0014cb74-ed0e-54df-adb0-d2e5c104e30b'::uuid,
        'C', 'retinoide tópico + ATB tópico', 'Incorreta. O tratamento tópico isolado não é eficaz para acne grave. Além disso, antibióticos tópicos nunca devem ser utilizados em monoterapia.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'b0ec9139-f287-5fd9-81ed-ed1967bd97dd'::uuid, '0014cb74-ed0e-54df-adb0-d2e5c104e30b'::uuid,
        'D', 'peróxido de benzoíla + ATB sistêmico', 'Incorreta. Embora antibióticos orais possam ser utilizados na acne inflamatória moderada, a presença de fístulas, abscessos e cicatrizes extensas indica isotretinoína oral, que é o tratamento de escolha.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 121 | Escabiose - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '2fdb563a-e415-5c01-a037-28cfb2e9b4e3'::uuid, v_discipline_id, NULL, 'médio',
        'Paciente feminina, 37 anos, relatando prurido disseminado pelo corpo, com piora à noite e evolução de uma semana. No exame da pele, observou-se presença de pequenas saliências lineares, com menos de 1 cm, com vesicopápula em uma das extremidades. Quanto ao caso relatado, marque a alternativa INCORRETA:', 'single',
        'A', ARRAY[]::text[],
        '', 'Paciente feminina, 37 anos, relatando prurido disseminado pelo corpo, com piora à noite e evolução de uma semana.',
        '', 'Atenção ao comando: deve-se marcar a alternativa incorreta ou a exceção.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'aba7dd42-b0d8-52fc-9799-b914f04913b5'::uuid, '2fdb563a-e415-5c01-a037-28cfb2e9b4e3'::uuid,
        'A', 'Os locais com maior acometimento no adulto costumam ser couro cabeludo, face, região extensora de cotovelos e de joelhos.', 'Correta. No adulto, a escabiose acomete principalmente espaços interdigitais, punhos, axilas, mamilos, umbigo e genitais. Face e couro cabeludo geralmente são poupados.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '1ca15be9-8a73-5f3c-b0a2-df35e1e6e1b6'::uuid, '2fdb563a-e415-5c01-a037-28cfb2e9b4e3'::uuid,
        'B', 'É importante investigar se existem familiares ou pessoas da mesma habitação apresentando prurido.', 'Incorreta. Todos os contactantes domiciliares devem ser investigados e tratados simultaneamente.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '848c5ec6-62a9-5ee2-97b0-fdebd9d4e314'::uuid, '2fdb563a-e415-5c01-a037-28cfb2e9b4e3'::uuid,
        'C', 'É uma doença transmitida por contato pessoal e ocasionada por ácaros.', 'Incorreta. A escabiose é causada pelo ácaro Sarcoptes scabiei var. hominis e transmite-se principalmente por contato direto.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '2ad13559-e500-5190-ba54-9fcdadcf96c0'::uuid, '2fdb563a-e415-5c01-a037-28cfb2e9b4e3'::uuid,
        'D', 'No tratamento, podemos empregar a permetrina em loção.', 'Incorreta. A permetrina 5% é o tratamento tópico de primeira escolha.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 122 | Escabiose - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '1797c739-153d-56ff-8bf5-f53b17077e70'::uuid, v_discipline_id, NULL, 'médio',
        'A diagnose de pediculose do couro cabeludo é sugerida pela queixa de prurido e confirmada pela presença dos ovos ou lêndeas nas hastes dos cabelos. Quanto à pediculose, marque a alternativa INCORRETA:', 'single',
        'C', ARRAY[]::text[],
        'A pediculose é causada por piolhos e manifesta-se principalmente por prurido intenso. O diagnóstico é confirmado pela visualização de piolhos ou lêndeas aderidas aos fios de cabelo. O tratamento da pediculose do couro cabeludo baseia-se em permetrina 1%, remoção das lêndeas com pente fino e reaplicação após 7 dias. Na pediculose do corpo, a medida mais importante é a lavagem e troca das roupas, pois o parasita permanece principalmente nas vestimentas.', 'A pediculose é causada por piolhos e manifesta-se principalmente por prurido intenso.',
        '👦 Pediculose do couro cabeludo → permetrina 1% + pente fino.
🥚 Repetir em 7 dias.
👕 Pediculose do corpo → tratar principalmente as roupas.
👨‍👩‍👧‍👦 Examinar e tratar os contactantes.', 'Atenção ao comando: deve-se marcar a alternativa incorreta ou a exceção.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '294e4112-855e-5e00-a063-3d2c1aad5ebe'::uuid, '1797c739-153d-56ff-8bf5-f53b17077e70'::uuid,
        'A', 'Devemos orientar a remoção das lêndeas com pente fino, após passar vinagre diluído com água morna.', 'Incorreta. O uso do pente fino é recomendado para remover lêndeas. O vinagre diluído pode facilitar seu desprendimento, embora sua eficácia isolada seja limitada.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '75a80333-1941-5b85-892e-c42add83be79'::uuid, '1797c739-153d-56ff-8bf5-f53b17077e70'::uuid,
        'B', 'O tratamento pode ser feito com xampu de permetrina, deixando-se agir por 5 a 10 minutos, e repetindo a aplicação após uma semana.', 'Incorreta. A permetrina 1% é um dos tratamentos de primeira linha para pediculose do couro cabeludo, devendo ser reaplicada após 7 dias para eliminar os parasitas que eclodirem das lêndeas.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'bae5ea37-9f9f-58d7-975f-f672522f92d4'::uuid, '1797c739-153d-56ff-8bf5-f53b17077e70'::uuid,
        'C', 'Na pediculose do corpo, na maioria dos casos é necessário tratamento com ivermectina oral e permetrina tópica, visto ser uma forma clínica mais resistente ao tratamento.', 'Correta. Na pediculose do corpo, o principal tratamento consiste em higienização das roupas, roupas de cama e melhora das condições de higiene. Na maioria dos casos não é necessário tratamento medicamentoso, pois o piolho vive principalmente nas roupas e não na pele.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '66d6c3dc-fa70-59b6-944f-0ed25de42f1d'::uuid, '1797c739-153d-56ff-8bf5-f53b17077e70'::uuid,
        'D', 'Devemos sempre examinar e, se for o caso, tratar os contatos do paciente.', 'Incorreta. Contactantes com infestação devem ser tratados para evitar reinfestação.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 123 | Escabiose - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '5036abcf-e2cb-5881-93d5-8f09ebdf5f10'::uuid, v_discipline_id, NULL, 'médio',
        'Paciente feminina, 20 anos, fez uso de loção de permetrina 5%, prescrita pelo médico da Unidade Básica de Saúde pelo diagnóstico de escabiose, tendo aplicado a medicação por 2 noites seguidas, repetindo após uma semana. Contudo, retorna para reavaliação referindo permanência do prurido, embora menos intenso. Com base nas informações acima, marque a resposta que contém conduta adequada para o caso:', 'single',
        'B', ARRAY[]::text[],
        'Após o tratamento adequado da escabiose, é comum que o prurido persista por algumas semanas, devido à reação de hipersensibilidade aos antígenos do ácaro. Nesses casos, o tratamento consiste em controle sintomático, principalmente com anti-histamínicos, e não na repetição indiscriminada do escabicida.', 'Após o tratamento adequado da escabiose, é comum que o prurido persista por algumas semanas, devido à reação de hipersensibilidade aos antígenos do ácaro.',
        '🌙 Prurido pode persistir por 2–4 semanas.
✅ Prurido ≠ tratamento mal sucedido.
💊 Controle com anti-histamínico.
🚫 Não repetir permetrina apenas porque ainda coça.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '0a98536a-919f-55b4-a75b-6d655a003a34'::uuid, '5036abcf-e2cb-5881-93d5-8f09ebdf5f10'::uuid,
        'A', 'Devemos manter o tratamento com loção de permetrina à noite até a melhora do prurido.', 'Incorreta. A persistência do prurido após o tratamento não indica falha terapêutica. O prurido pode permanecer por 2 a 4 semanas devido à resposta de hipersensibilidade aos antígenos do ácaro.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'acf11d34-ac66-53c9-a0a2-721ffaec7e36'::uuid, '5036abcf-e2cb-5881-93d5-8f09ebdf5f10'::uuid,
        'B', 'Devemos prescrever anti-histamínico para controle do prurido pós-tratamento, que ocorre por memória do prurido ou por hipersensibilidade.', 'Correta. Após tratamento adequado, o prurido residual é frequente e pode ser controlado com anti-histamínicos e, quando necessário, corticoides tópicos de baixa potência. Não há indicação de repetir o escabicida apenas pela persistência do prurido.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '5d69daab-7da7-5e24-ae29-59bc5324d912'::uuid, '5036abcf-e2cb-5881-93d5-8f09ebdf5f10'::uuid,
        'C', 'Devemos prescrever aplicação de benzoato de benzila diariamente até a melhora do prurido.', 'Incorreta. O benzoato de benzila não deve ser utilizado continuamente até cessar o prurido, pois este pode persistir mesmo após a erradicação do parasita.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '73d043e0-6215-5bff-9bf3-ca6438e20f97'::uuid, '5036abcf-e2cb-5881-93d5-8f09ebdf5f10'::uuid,
        'D', 'Devemos orientar banhos frequentes com sabonete escabicida ou sabonete de enxofre.', 'Incorreta. Sabonetes escabicidas ou de enxofre não substituem o tratamento específico e não são indicados para controlar o prurido pós-tratamento.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 124 | Escabiose - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        'b397248a-752a-560f-9cb6-a9d7d1ca8863'::uuid, v_discipline_id, NULL, 'médio',
        'Sobre a escabiose, marque a errada:', 'single',
        'D', ARRAY[]::text[],
        'Na escabiose, a fêmea fecundada do Sarcoptes scabiei var. hominis é responsável pela formação dos túneis na epiderme e pela deposição dos ovos, desencadeando a resposta inflamatória e o prurido. A transmissão ocorre principalmente por contato direto, mas pode ocorrer por fômites na forma crostosa. A ivermectina oral é especialmente útil em surtos e na escabiose norueguesa.', 'Na escabiose, a fêmea fecundada do Sarcoptes scabiei var.',
        '👩 Fêmea = faz o túnel e põe os ovos.
👨 Macho = papel pouco relevante.
🦀 Escabiose crostosa → ivermectina oral.
🏠 Asilos e presídios → tratar coletivamente.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '09d16aaf-2bba-5cfa-82c9-509307aba1bc'::uuid, 'b397248a-752a-560f-9cb6-a9d7d1ca8863'::uuid,
        'A', 'A transmissão por fômites é possível', 'Incorreta. Embora a principal via seja o contato direto e prolongado, a transmissão por fômites (roupas, lençóis e toalhas) pode ocorrer, principalmente na escabiose crostosa (norueguesa).'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '463f3872-7a25-5097-95fc-9f9ecc93aa6a'::uuid, 'b397248a-752a-560f-9cb6-a9d7d1ca8863'::uuid,
        'B', 'Na escabiose norueguesa, a imunodepressão e as doenças neurológicas são fatores de risco', 'Incorreta. A escabiose crostosa ocorre principalmente em imunodeprimidos, idosos e pacientes com doenças neurológicas ou incapacitantes.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'eafb3c7c-b1fb-5169-a3e2-31b0eb1a8c43'::uuid, 'b397248a-752a-560f-9cb6-a9d7d1ca8863'::uuid,
        'C', 'A medicação oral ivermectina é útil em casos de sarna norueguesa e em casos ocorridos em conglomerados como asilos', 'Incorreta. A ivermectina oral é indicada na escabiose crostosa e em surtos institucionais (asilos, presídios, hospitais), facilitando o tratamento coletivo.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '84b0ace8-860b-5061-8dfa-98d307dcce1d'::uuid, 'b397248a-752a-560f-9cb6-a9d7d1ca8863'::uuid,
        'D', 'A fêmea e/ou o macho do S. scabiei var hominis na pele são determinantes dos sintomas da escabiose', 'Correta. Os sintomas da escabiose decorrem principalmente da fêmea fecundada, que escava túneis na epiderme para depositar ovos. O macho permanece pouco tempo sobre a pele e não é o principal responsável pela doença.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

    -- Questão 125 | Escabiose - Estudo dirigido
    INSERT INTO public.questions (
        id, discipline_id, topic_id, difficulty, statement, question_type,
        correct_answer, correct_answers, general_comment, summary, memory_tip,
        trap, reference, active, exam, image_url
    ) VALUES (
        '97d0de82-6d03-5e2f-970a-f77b0c4108e6'::uuid, v_discipline_id, NULL, 'médio',
        'Sobre a escabiose, marque a errada:', 'single',
        'D', ARRAY[]::text[],
        'A escabiose é causada pelo Sarcoptes scabiei var. hominis e caracteriza-se por prurido intenso, principalmente noturno, decorrente da resposta de hipersensibilidade ao ácaro. As lesões predominam em áreas de pele fina, mas palmas e plantas podem ser acometidas, especialmente em lactentes e na escabiose crostosa.', 'A escabiose é causada pelo Sarcoptes scabiei var.',
        '🌙 Prurido pior à noite.
🕳️ Sulco escabiótico.
✋ Palmas e plantas podem ser acometidas em crianças.
👶 Lactentes → face, couro cabeludo, palmas e plantas.
👩 Fêmea do ácaro = responsável pelos túneis.', 'Diferencie a alternativa completa dos distratores parcialmente verdadeiros.',
        'Material de revisão — Dermatologia — Prova 2', true, 'P2', NULL
    )
    ON CONFLICT (id) DO NOTHING;

    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'ed9a23a0-a5a9-5327-bd48-81090c98e9b4'::uuid, '97d0de82-6d03-5e2f-970a-f77b0c4108e6'::uuid,
        'A', 'É produzida pelo ácaro Sarcoptes scabiei var. hominis', 'Incorreta. A escabiose é causada pelo ácaro Sarcoptes scabiei var. hominis, responsável pela infestação da epiderme.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        '729dec4c-e9e9-5492-abc4-dd2c0ddfa9a8'::uuid, '97d0de82-6d03-5e2f-970a-f77b0c4108e6'::uuid,
        'B', 'O principal sintoma é o prurido noturno, o qual ocorre por mecanismo alérgico e pela migração da fêmea na pele', 'Incorreta. O prurido noturno é a manifestação clínica mais característica da escabiose e resulta da hipersensibilidade aos antígenos do ácaro, associada à migração da fêmea na epiderme.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'b2f11f70-d775-5155-8896-236c74d8b385'::uuid, '97d0de82-6d03-5e2f-970a-f77b0c4108e6'::uuid,
        'C', 'Lesões entre os dedos podem estar ausentes', 'Incorreta. Embora os espaços interdigitais sejam um dos locais mais frequentemente acometidos, eles podem estar preservados, especialmente em apresentações atípicas ou em fases iniciais da doença.'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;
    INSERT INTO public.alternatives (id, question_id, letter, text, explanation)
    VALUES (
        'cab649f4-dbe0-5a10-bd0f-c2acd95423bd'::uuid, '97d0de82-6d03-5e2f-970a-f77b0c4108e6'::uuid,
        'D', 'Pode acometer todo o corpo, exceto palmas e plantas', 'Correta. A afirmação está errada porque palmas e plantas podem ser acometidas, principalmente em lactentes, crianças pequenas e na escabiose crostosa (norueguesa).'
    )
    ON CONFLICT (question_id, letter) DO NOTHING;

END
$migration$;

COMMIT;

-- Validação pós-importação
SELECT
    q.exam,
    q.question_type,
    COUNT(*) AS total_questoes
FROM public.questions q
JOIN public.disciplines d ON d.id = q.discipline_id
WHERE d.name = 'Dermatologia' AND q.exam = 'P2'
GROUP BY q.exam, q.question_type
ORDER BY q.question_type;
