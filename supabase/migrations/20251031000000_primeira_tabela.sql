-- Cria a tabela onde os colaboradores irão cadastrar
create table public.colaboradores_cadastros (
  id uuid default gen_random_uuid() primary key,
  colaborador_id uuid references auth.users(id) not null, -- Liga ao usuário logado
  nome_do_cadastro text not null,
  descricao text,
  data_criacao timestamp with time zone default now()
);

-- Habilita o RLS (Segurança em Nível de Linha)
alter table public.colaboradores_cadastros enable row level security;

-- Permite que usuários autenticados cadastrem (INSERT)
create policy "Colaboradores podem cadastrar"
on public.colaboradores_cadastros for insert
to authenticated
with check (true);

-- Permite que usuários autenticados vejam todos os cadastros (SELECT)
create policy "Todos autenticados podem ver"
on public.colaboradores_cadastros for select
to authenticated
using (true);
