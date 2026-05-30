-- ============================================================================
-- SOLUÇÃO: CRIAR POLICIES RLS PARA ACESSO PÚBLICO
-- ============================================================================
-- 
-- INSTRUÇÕES:
-- 1. Abra: https://app.supabase.com/project/rkfznsgbrfrwgkhuidpl/sql/new
-- 2. Cole TODO o código abaixo
-- 3. Clique em "Run"
-- 4. O frontend deve funcionar normalmente após 5-10 segundos
--
-- ============================================================================

-- Criar policy para DISCIPLINES (leitura pública)
CREATE POLICY "allow_public_read_disciplines" ON disciplines
FOR SELECT USING (true);

-- Criar policy para TOPICS (leitura pública)
CREATE POLICY "allow_public_read_topics" ON topics
FOR SELECT USING (true);

-- Criar policy para QUESTIONS (leitura pública)
CREATE POLICY "allow_public_read_questions" ON questions
FOR SELECT USING (true);

-- Criar policy para ALTERNATIVES (leitura pública)
CREATE POLICY "allow_public_read_alternatives" ON alternatives
FOR SELECT USING (true);

-- ============================================================================
-- VERIFICAÇÃO: Se receber erro "policy already exists", não é problema
-- As policies já foram criadas anteriormente
-- ============================================================================

-- Após executar, você pode verificar com:
SELECT schemaname, tablename FROM pg_tables WHERE schemaname = 'public';
