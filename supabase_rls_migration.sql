-- Run this once in Supabase SQL Editor if the tables already exist.
-- It protects the existing JSON document and the normalized tables.
-- Existing normalized rows with no user_id are intentionally hidden by RLS;
-- assign them to a specific auth.users.id only if you know their owner.

alter table public.warehouse_data enable row level security;
drop policy if exists "Users manage their own warehouse data" on public.warehouse_data;
create policy "Users manage their own warehouse data"
  on public.warehouse_data for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

alter table public.components add column if not exists user_id uuid references auth.users(id) on delete cascade;
alter table public.components alter column user_id set default auth.uid();
alter table public.components enable row level security;
drop policy if exists "Users manage their own components" on public.components;
create policy "Users manage their own components"
  on public.components for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);

alter table public.dropdown_options add column if not exists user_id uuid references auth.users(id) on delete cascade;
alter table public.dropdown_options alter column user_id set default auth.uid();
alter table public.dropdown_options enable row level security;
drop policy if exists "Users manage their own dropdown options" on public.dropdown_options;
create policy "Users manage their own dropdown options"
  on public.dropdown_options for all
  using (auth.uid() = user_id)
  with check (auth.uid() = user_id);
