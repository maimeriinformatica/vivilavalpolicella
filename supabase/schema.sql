-- Vivi la Valpolicella — tabella per i messaggi del modulo contatti.
-- Eseguire una volta in Supabase: SQL Editor > New query > incolla > Run.

create table if not exists public.messaggi (
  id               bigint generated always as identity primary key,
  creato_il        timestamptz not null default now(),
  nome             text not null check (char_length(nome) between 1 and 120),
  email            text not null check (email ~* '^[^@\s]+@[^@\s]+\.[^@\s]+$' and char_length(email) <= 200),
  argomento        text check (char_length(argomento) <= 80),
  messaggio        text not null check (char_length(messaggio) between 1 and 5000),
  consenso_privacy boolean not null check (consenso_privacy = true),
  letto            boolean not null default false
);

alter table public.messaggi enable row level security;

-- I visitatori del sito (chiave anon) possono SOLO inserire messaggi.
drop policy if exists "visitatori_inseriscono" on public.messaggi;
create policy "visitatori_inseriscono"
  on public.messaggi for insert
  to anon
  with check (consenso_privacy = true and letto = false);

-- Nessuna policy di lettura per anon: i messaggi si leggono solo dal pannello
-- Supabase (Table Editor) o con un utente autenticato dell'associazione.
drop policy if exists "staff_legge" on public.messaggi;
create policy "staff_legge"
  on public.messaggi for select
  to authenticated
  using (true);

drop policy if exists "staff_aggiorna" on public.messaggi;
create policy "staff_aggiorna"
  on public.messaggi for update
  to authenticated
  using (true) with check (true);

grant insert on public.messaggi to anon;
grant select, update on public.messaggi to authenticated;
