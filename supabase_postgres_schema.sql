create table public.components (
  id uuid primary key default gen_random_uuid(), user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  sku text not null, name text not null,
  quantity_number numeric not null default 0, quantity_unit text not null default 'Piece',
  price_per_unit numeric not null default 0, total_value numeric not null default 0,
  component_type text not null, ownership text not null default 'Mine',
  borrowed_from text, lent_to text, date_lent date, note text,
  current_status text not null default 'In Storage',
  created_at timestamptz not null default now(), updated_at timestamptz not null default now()
);
create unique index components_user_sku_idx on public.components(user_id, lower(sku));
alter table public.components enable row level security;
create policy "Users manage their own components"
  on public.components for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);
create table public.dropdown_options (
  user_id uuid not null default auth.uid() references auth.users(id) on delete cascade,
  field_name text not null, value text not null,
  primary key(user_id,field_name,value)
);
alter table public.dropdown_options enable row level security;
create policy "Users manage their own dropdown options"
  on public.dropdown_options for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

-- One private document per authenticated user. RLS prevents users from
-- reading or writing another user's inventory or dropdown options.
create table public.warehouse_data (
  user_id uuid primary key references auth.users(id) on delete cascade,
  payload jsonb not null,
  updated_at timestamptz not null default now()
);
alter table public.warehouse_data enable row level security;
create policy "Users manage their own warehouse data"
  on public.warehouse_data for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);
