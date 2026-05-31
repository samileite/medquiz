# MedQuiz

Repositório do MedQuiz — um projeto React + Vite com Firebase Auth, Firestore e Supabase.

## Requisitos

- Node.js 18+ recomendado
- npm

## Instalação

No diretório do projeto:

```bash
npm install
```

## Variáveis de ambiente

O projeto usa variáveis de ambiente para conectar ao Supabase no modo cliente.

Crie um arquivo `.env` na raiz do projeto com as variáveis abaixo:

```env
VITE_SUPABASE_URL=seu_supabase_url
VITE_SUPABASE_ANON_KEY=seu_supabase_anon_key
```

> O Firebase já está configurado no código em `src/firebase.js`.

## Execução em desenvolvimento

```bash
npm run dev
```

Depois, abra o endereço mostrado no terminal (por padrão `http://localhost:5173`).

## Build para produção

```bash
npm run build
```

## Preview da build

```bash
npm run preview
```

## Outros scripts úteis

- `npm run lint` — executa o ESLint em `src`
- `npm run import-gastro` — roda o script de importação de dados `scripts/import-gastro-from-pdf.mjs`

## Estrutura principal

- `src/` — código React da aplicação
- `src/firebase.js` — configuração do Firebase
- `src/lib/supabase.js` — cliente Supabase
- `api/` — função de API para salvar respostas
- `scripts/` — scripts auxiliares de importação e diagnóstico
- `public/` — arquivos estáticos

## Observações

- Se usar Supabase, garanta que as chaves estejam corretas no `.env`.
- Se quiser adaptar o Firebase, ajuste `src/firebase.js` com as credenciais correspondentes.
