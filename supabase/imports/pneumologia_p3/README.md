# Payloads — Pneumologia — Prova 3

- `01_questoes_fechadas.sql`: 14 questões originalmente objetivas.
- `02_questoes_abertas.sql`: 20 questões abertas originais, inativas por segurança, com resposta-modelo em `general_comment` e `question_type = 'open'`.
- `03_abertas_transformadas_em_fechadas.sql`: as mesmas 20 abertas convertidas em objetivas, com quatro alternativas comentadas.

## Execução

Execute sempre o arquivo `01`. Depois:

- use `02` para preservar as questões abertas; ou
- use `03` para disponibilizar toda a prova no quiz objetivo atual.

Executar `02` e `03` é permitido (os IDs são diferentes), mas cria duas versões das mesmas 20 questões.

Todos os scripts:

- usam `exam = 'P3'` e a disciplina `Pneumologia`;
- são transacionais e idempotentes;
- falham com mensagem clara se a disciplina não existir;
- atualizam questões/alternativas do próprio payload quando executados novamente;
- terminam com uma consulta simples de conferência.

## Compatibilidade

O frontend atual valida apenas questões `single`/`multiple` e exige alternativas. Assim, o SQL `02` armazena corretamente as abertas no banco, mas elas só devem ser ativadas no fluxo de quiz após a interface ganhar suporte a `question_type = 'open'`. Para uso imediato na plataforma atual, prefira `01` + `03`.

Para importar essa combinação diretamente com as credenciais de serviço de
`.env.import`, execute:

```bash
npm run import-pneumologia-p3
```

O importador cria os assuntos ausentes, faz upsert por IDs determinísticos e
confere ao final as quantidades de questões e alternativas.
