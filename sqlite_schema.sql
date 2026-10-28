PRAGMA foreign_keys = ON;
CREATE TABLE components (
  id TEXT PRIMARY KEY, sku TEXT NOT NULL UNIQUE COLLATE NOCASE, name TEXT NOT NULL,
  quantity_number REAL NOT NULL DEFAULT 0, quantity_unit TEXT NOT NULL DEFAULT 'Piece',
  price_per_unit REAL NOT NULL DEFAULT 0, total_value REAL NOT NULL DEFAULT 0,
  component_type TEXT NOT NULL, ownership TEXT NOT NULL DEFAULT 'Mine',
  borrowed_from TEXT, lent_to TEXT, date_lent TEXT, note TEXT,
  current_status TEXT NOT NULL DEFAULT 'In Storage',
  created_at TEXT NOT NULL, updated_at TEXT NOT NULL
);
CREATE TABLE dropdown_options (
  field_name TEXT NOT NULL, value TEXT NOT NULL,
  PRIMARY KEY(field_name,value)
);
CREATE INDEX components_type_idx ON components(component_type);
CREATE INDEX components_status_idx ON components(current_status);

-- Cloud mode uses Supabase Auth plus a per-user JSON document. The SQLite
-- schema remains available for local/offline deployments.
CREATE TABLE warehouse_data (
  user_id TEXT PRIMARY KEY,
  payload TEXT NOT NULL,
  updated_at TEXT NOT NULL
);
