-- ============================================================
-- MedQuiz Taxonomy v1.0 - Classificação inicial por palavras-chave
-- Disciplina: Endocrinologia
-- ============================================================
-- Segurança:
-- - Não remove nem altera topics legados.
-- - Só atualiza questões ativas de Endocrinologia.
-- - Só atualiza questões ainda sem grand_theme_id.
-- - Usa alternativas e campos explicativos no texto pesquisável.
-- - Regras mais específicas têm prioridade menor.
-- ============================================================

BEGIN;

CREATE TEMP TABLE _endocrino_taxonomy_matches ON COMMIT DROP AS
WITH endocrine_discipline AS (
    SELECT id
    FROM public.disciplines
    WHERE name = 'Endocrinologia'
    LIMIT 1
),
question_text AS (
    SELECT
        q.id AS question_id,
        lower(
            coalesce(q.statement, '') || ' ' ||
            coalesce(q.general_comment, '') || ' ' ||
            coalesce(q.summary, '') || ' ' ||
            coalesce(q.memory_tip, '') || ' ' ||
            coalesce(q.trap, '') || ' ' ||
            coalesce(q.reference, '') || ' ' ||
            coalesce(string_agg(coalesce(a.text, '') || ' ' || coalesce(a.explanation, ''), ' '), '')
        ) AS searchable_text
    FROM public.questions q
    JOIN endocrine_discipline d ON d.id = q.discipline_id
    LEFT JOIN public.alternatives a ON a.question_id = q.id
    WHERE q.active = true
      AND q.grand_theme_id IS NULL
    GROUP BY q.id
),
rules(priority, grand_theme_name, domain_name, detail_name, pattern) AS (
    VALUES
        -- Diabetes Mellitus: detalhes específicos
        (10, 'Diabetes Mellitus', 'Complicações Agudas', 'Cetoacidose diabética', '(cetoacidose|\mcad\M|diabetic ketoacidosis)'),
        (11, 'Diabetes Mellitus', 'Complicações Agudas', 'Estado hiperosmolar', '(estado hiperosmolar|hiperosmolar|\mehh\M|hhs)'),
        (12, 'Diabetes Mellitus', 'Complicações Agudas', 'Hipoglicemia', '(hipoglicemi)'),
        (20, 'Diabetes Mellitus', 'Insulinoterapia', 'Insulina NPH', '(\mnph\M|insulina nph)'),
        (21, 'Diabetes Mellitus', 'Insulinoterapia', 'Insulina regular', '(insulina regular|\mregular\M)'),
        (22, 'Diabetes Mellitus', 'Insulinoterapia', 'Análogos de insulina', '(glargina|lispro|asparte|degludeca|analogos? de insulina|análogos? de insulina)'),
        (23, 'Diabetes Mellitus', 'Insulinoterapia', 'Esquemas de insulinização', '(insulinizacao|insulinização|basal[- ]bolus|esquema.*insulin|insulina)'),
        (30, 'Diabetes Mellitus', 'Tratamento Farmacológico', 'Metformina', '(metformina)'),
        (31, 'Diabetes Mellitus', 'Tratamento Farmacológico', 'Sulfonilureias', '(sulfonilureia|glibenclamida|gliclazida|glimepirida)'),
        (32, 'Diabetes Mellitus', 'Tratamento Farmacológico', 'aGLP-1', '(glp[- ]?1|liraglutida|semaglutida|dulaglutida|exenatida)'),
        (33, 'Diabetes Mellitus', 'Tratamento Farmacológico', 'iSGLT2', '(sglt[- ]?2|dapagliflozina|empagliflozina|canagliflozina)'),
        (34, 'Diabetes Mellitus', 'Tratamento Farmacológico', 'iDPP4', '(dpp[- ]?4|sitagliptina|vildagliptina|linagliptina|saxagliptina)'),
        (40, 'Diabetes Mellitus', 'Complicações Crônicas', 'Retinopatia', '(retinopatia)'),
        (41, 'Diabetes Mellitus', 'Complicações Crônicas', 'Nefropatia', '(nefropatia|albuminuria|albuminúria|microalbuminuria|microalbuminúria|doenca renal diabetica|doença renal diabética)'),
        (42, 'Diabetes Mellitus', 'Complicações Crônicas', 'Neuropatia', '(neuropatia)'),
        (43, 'Diabetes Mellitus', 'Complicações Crônicas', 'Pé diabético', '(pe diabetico|pé diabético|ulcera.*pe|úlcera.*pé)'),
        (44, 'Diabetes Mellitus', 'Complicações Crônicas', 'Doença cardiovascular', '(cardiovascular|ateroscler|infarto|avc|coronariana)'),
        (50, 'Diabetes Mellitus', 'Diagnóstico', 'HbA1c', '(hba1c|hemoglobina glicada|a1c)'),
        (51, 'Diabetes Mellitus', 'Diagnóstico', 'TOTG', '(totg|teste oral de tolerancia|teste oral de tolerância|tolerancia a glicose|tolerância à glicose)'),
        (52, 'Diabetes Mellitus', 'Diagnóstico', 'Glicemia de jejum', '(glicemia de jejum|glicemia plasm)'),
        (53, 'Diabetes Mellitus', 'Diagnóstico', 'Critérios ADA', '(criterios ada|critérios ada|\mada\M|pre[- ]?diabetes|pré[- ]?diabetes)'),
        (60, 'Diabetes Mellitus', 'Diabetes Gestacional', NULL, '(diabetes gestacional|gestacional)'),
        (61, 'Diabetes Mellitus', 'Classificação', NULL, '(\mdm1\M|\mdm2\M|lada|mody|diabetes tipo 1|diabetes tipo 2)'),
        (90, 'Diabetes Mellitus', 'Conceitos', NULL, '(diabetes|diabetico|diabético|glicemia|hiperglicemia|insulina)'),

        -- Tireoide: detalhes e domínios específicos
        (110, 'Tireoide', 'Nódulos Tireoidianos', 'PAAF', '(\mpaaf\M|punção aspirativa|puncao aspirativa|citologia)'),
        (111, 'Tireoide', 'Nódulos Tireoidianos', 'TI-RADS', '(ti[- ]?rads|tirads)'),
        (112, 'Tireoide', 'Nódulos Tireoidianos', 'Bethesda', '(bethesda)'),
        (113, 'Tireoide', 'Nódulos Tireoidianos', 'Cintilografia', '(cintilografia)'),
        (114, 'Tireoide', 'Nódulos Tireoidianos', 'Nódulo quente', '(nodulo quente|nódulo quente)'),
        (115, 'Tireoide', 'Nódulos Tireoidianos', 'Nódulo frio', '(nodulo frio|nódulo frio)'),
        (116, 'Tireoide', 'Nódulos Tireoidianos', NULL, '(nodulo|nódulo|tireoidiano)'),
        (120, 'Tireoide', 'Exames Laboratoriais', 'TSH', '(\mtsh\M)'),
        (121, 'Tireoide', 'Exames Laboratoriais', 'T4 livre', '(t4 livre|\mt4l\M|\mt4\M)'),
        (122, 'Tireoide', 'Exames Laboratoriais', 'T3', '(\mt3\M)'),
        (123, 'Tireoide', 'Exames Laboratoriais', 'TRAb', '(\mtrab\M|anti receptor do tsh|receptor de tsh)'),
        (124, 'Tireoide', 'Exames Laboratoriais', 'Anti-TPO', '(anti[- ]?tpo|antitpo)'),
        (130, 'Tireoide', 'Tratamento', 'Levotiroxina', '(levotiroxina)'),
        (131, 'Tireoide', 'Tratamento', 'Metimazol', '(metimazol|tiamazol)'),
        (132, 'Tireoide', 'Tratamento', 'Propiltiouracil', '(propiltiouracil|\mptu\M)'),
        (133, 'Tireoide', 'Tratamento', 'Radioiodo', '(radioiodo|iodo radioativo|i-131|i131)'),
        (134, 'Tireoide', 'Tratamento', 'Tireoidectomia', '(tireoidectomia)'),
        (140, 'Tireoide', 'Hipotireoidismo', NULL, '(hipotireoidismo|mixedema|hashimoto)'),
        (141, 'Tireoide', 'Hipertireoidismo', NULL, '(hipertireoidismo|tireotoxicose|plummer)'),
        (142, 'Tireoide', 'Doença de Graves', NULL, '(graves|orbitopatia|oftalmopatia)'),
        (143, 'Tireoide', 'Tireoidites', NULL, '(tireoidite|de quervain|subaguda|silenciosa|pos[- ]?parto|pós[- ]?parto)'),
        (144, 'Tireoide', 'Câncer de Tireoide', NULL, '(papilifero|papilífero|folicular|medular|anaplasico|anaplásico|carcinoma.*tireoide|cancer de tireoide|câncer de tireoide)'),
        (190, 'Tireoide', 'Fisiologia', NULL, '(tireoide|tireoid|\mtsh\M|\mt4\M|\mt3\M)'),

        -- Obesidade
        (210, 'Obesidade', 'Cirurgia Bariátrica', NULL, '(bariatrica|bariátrica|bypass|sleeve|gastroplastia)'),
        (220, 'Obesidade', 'Tratamento Farmacológico', NULL, '(sibutramina|orlistate|liraglutida|semaglutida|tirzepatida|glp[- ]?1)'),
        (230, 'Obesidade', 'Diagnóstico', NULL, '(\mimc\M|indice de massa corporal|índice de massa corporal|circunferencia abdominal|circunferência abdominal)'),
        (290, 'Obesidade', 'Conceitos Básicos', NULL, '(obesidade|adiposidade|sobrepeso)'),

        -- Síndrome Metabólica
        (310, 'Síndrome Metabólica', 'Critérios Diagnósticos', NULL, '(sindrome metabolica|síndrome metabólica|\mhdl\M|triglicerideos|triglicerídeos|circunferencia abdominal|circunferência abdominal|pressao arterial|pressão arterial)'),
        (320, 'Síndrome Metabólica', 'Fisiopatologia', NULL, '(resistencia insulinica|resistência insulínica|acidos graxos livres|ácidos graxos livres|citocinas)'),
        (390, 'Síndrome Metabólica', 'Conceitos', NULL, '(sindrome metabolica|síndrome metabólica)'),

        -- Outros grandes temas de Endocrinologia para aumentar cobertura inicial segura
        (410, 'Hipófise', 'Prolactina', NULL, '(prolactina|prolactinoma|hiperprolactinemia|galactorreia)'),
        (420, 'Hipófise', 'GH', NULL, '(acromegalia|gigantismo|\mgh\M|igf[- ]?1)'),
        (430, 'Adrenal', 'Insuficiência Adrenal', NULL, '(insuficiencia adrenal|insuficiência adrenal|addison|crise adrenal)'),
        (440, 'Adrenal', 'Hipercortisolismo', NULL, '(cushing|hipercortisolismo|cortisol)'),
        (450, 'Adrenal', 'Catecolaminas', NULL, '(feocromocitoma|catecolamina|metanefrina)'),
        (460, 'Paratireoide e Cálcio', 'Hipercalcemia', NULL, '(hipercalcemia|calcio alto|cálcio alto)'),
        (461, 'Paratireoide e Cálcio', 'Hipocalcemia', NULL, '(hipocalcemia|calcio baixo|cálcio baixo)'),
        (462, 'Paratireoide e Cálcio', 'Hiperparatireoidismo', NULL, '(hiperparatireoidismo|\mpth\M)'),
        (470, 'Osteometabolismo', 'Osteoporose', NULL, '(osteoporose|densitometria|\mdxa\M|fratura fragilidade)'),
        (480, 'Gônadas e Reprodução', 'SOP', NULL, '(sindrome dos ovarios policisticos|síndrome dos ovários policísticos|\msop\M|hirsutismo)')
),
rule_targets AS (
    SELECT
        r.priority,
        gt.id AS grand_theme_id,
        qd.id AS domain_id,
        qdt.id AS detail_id,
        r.pattern
    FROM rules r
    JOIN endocrine_discipline d ON true
    JOIN public.question_grand_themes gt
      ON gt.discipline_id = d.id
     AND gt.name = r.grand_theme_name
    LEFT JOIN public.question_domains qd
      ON qd.grand_theme_id = gt.id
     AND qd.name = r.domain_name
    LEFT JOIN public.question_details qdt
      ON qdt.domain_id = qd.id
     AND qdt.name = r.detail_name
    WHERE (r.domain_name IS NULL OR qd.id IS NOT NULL)
      AND (r.detail_name IS NULL OR qdt.id IS NOT NULL)
),
ranked_matches AS (
    SELECT
        qt.question_id,
        rt.grand_theme_id,
        rt.domain_id,
        rt.detail_id,
        row_number() OVER (
            PARTITION BY qt.question_id
            ORDER BY rt.priority
        ) AS match_rank
    FROM question_text qt
    JOIN rule_targets rt ON qt.searchable_text ~* rt.pattern
)
SELECT
    question_id,
    grand_theme_id,
    domain_id,
    detail_id
FROM ranked_matches
WHERE match_rank = 1;

-- Preview do que será atualizado dentro desta transação.
-- Confira este resultado antes de confirmar a execução completa.
SELECT
    count(*) AS questoes_que_serao_atualizadas,
    count(*) FILTER (WHERE grand_theme_id IS NOT NULL) AS com_grande_tema,
    count(*) FILTER (WHERE domain_id IS NOT NULL) AS com_dominio,
    count(*) FILTER (WHERE detail_id IS NOT NULL) AS com_detalhe
FROM _endocrino_taxonomy_matches;

SELECT
    gt.name AS grande_tema,
    qd.name AS dominio,
    qdt.name AS detalhe,
    count(*) AS total
FROM _endocrino_taxonomy_matches m
JOIN public.question_grand_themes gt ON gt.id = m.grand_theme_id
LEFT JOIN public.question_domains qd ON qd.id = m.domain_id
LEFT JOIN public.question_details qdt ON qdt.id = m.detail_id
GROUP BY gt.name, qd.name, qdt.name
ORDER BY total DESC, gt.name, qd.name, qdt.name;

UPDATE public.questions q
SET
    grand_theme_id = m.grand_theme_id,
    domain_id = m.domain_id,
    detail_id = m.detail_id
FROM _endocrino_taxonomy_matches m
JOIN public.disciplines d ON d.name = 'Endocrinologia'
WHERE q.id = m.question_id
  AND q.discipline_id = d.id
  AND q.active = true
  AND q.grand_theme_id IS NULL;

-- Relatório final da migração.
WITH endocrine_questions AS (
    SELECT q.*
    FROM public.questions q
    JOIN public.disciplines d ON d.id = q.discipline_id
    WHERE d.name = 'Endocrinologia'
      AND q.active = true
)
SELECT
    count(*) AS total_questoes_endocrinologia,
    count(*) FILTER (WHERE grand_theme_id IS NOT NULL) AS com_grand_theme_id,
    count(*) FILTER (WHERE domain_id IS NOT NULL) AS com_domain_id,
    count(*) FILTER (WHERE detail_id IS NOT NULL) AS com_detail_id,
    count(*) FILTER (WHERE grand_theme_id IS NULL) AS sem_classificacao
FROM endocrine_questions;

COMMIT;
