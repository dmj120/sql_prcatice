CREATE TABLE IF NOT EXISTS learning_progress (
  id SERIAL PRIMARY KEY,
  skill_area TEXT NOT NULL,
  milestone TEXT NOT NULL,
  status TEXT NOT NULL DEFAULT 'Not Started',
  proficiency_level INT CHECK (proficiency_level BETWEEN 1 AND 5),
  artifact_url TEXT,
  planned_start DATE,
  planned_end DATE,
  practiced_at TIMESTAMP,
  created_at TIMESTAMPTZ NOT NULL DEFAULT NOW(),
  updated_at TIMESTAMPTZ NOT NULL DEFAULT NOW()
);

CREATE OR REPLACE FUNCTION set_updated_at() RETURNS trigger AS $$
BEGIN
  NEW.updated_at := NOW();
  RETURN NEW;
END; $$ LANGUAGE plpgsql;

DROP TRIGGER IF EXISTS trg_learning_progress_updated ON learning_progress;
CREATE TRIGGER trg_learning_progress_updated
BEFORE UPDATE ON learning_progress
FOR EACH ROW EXECUTE FUNCTION set_updated_at();
