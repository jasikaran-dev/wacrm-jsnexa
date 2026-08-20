-- ============================================================
-- 040_ai_groq_provider.sql — Add Groq as a supported AI provider
--
-- Widens the `provider` CHECK constraints added in 029_ai_reply.sql
-- (ai_configs) and 033_ai_reply_polish.sql (ai_usage_log) from
-- ('openai', 'anthropic') to also allow 'groq'. No new tables/columns —
-- Groq reuses the existing BYO-key config shape (api_key is still one
-- AES-256-GCM-encrypted column, regardless of which provider it's for).
--
-- Idempotent — safe to run multiple times.
-- ============================================================

ALTER TABLE ai_configs
  DROP CONSTRAINT IF EXISTS ai_configs_provider_check;

ALTER TABLE ai_configs
  ADD CONSTRAINT ai_configs_provider_check
  CHECK (provider IN ('openai', 'anthropic', 'groq'));

ALTER TABLE ai_usage_log
  DROP CONSTRAINT IF EXISTS ai_usage_log_provider_check;

ALTER TABLE ai_usage_log
  ADD CONSTRAINT ai_usage_log_provider_check
  CHECK (provider IN ('openai', 'anthropic', 'groq'));
