---
name: "tc-tracker"
description: "Use quando o usuário pede para rastrear mudanças técnicas, criar registros de mudanças, gerenciar ciclos de vida de TCs, ou fazer handoff de trabalho entre sessões de IA. Cobre fluxos de trabalho init/create/update/status/resume/close/export para documentação estruturada de mudanças de código."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# TC Tracker

Rastrear toda mudança de código com registros JSON estruturados, uma máquina de estados aplicada e um formato de handoff de sessão que permite que uma nova sessão de IA retome o trabalho de forma limpa quando a anterior expira.

## Visão Geral

Uma Mudança Técnica (TC) é um registro estruturado que captura **o que** mudou, **por que** mudou, **quem** mudou, **quando** mudou, **como foi testado** e **onde o trabalho está** para a próxima sessão. Os registros ficam como JSON em `docs/TC/` dentro do projeto alvo, validados contra um esquema estrito e uma máquina de estados.

**Use esta skill quando o usuário:**
- Pede para "rastrear esta mudança" ou quer uma trilha de auditoria para modificações de código
- Quer fazer handoff de trabalho em andamento para uma futura sessão de IA
- Precisa de notas de lançamento estruturadas que vão além de mensagens de commit
- Integra um projeto existente e quer documentação retroativa de mudanças
- Pede `/tc init`, `/tc create`, `/tc update`, `/tc status`, `/tc resume` ou `/tc close`

**NÃO use esta skill quando:**
- O usuário apenas quer um changelog do histórico git (use `engineering/changelog-generator`)
- O usuário apenas quer rastrear itens de dívida técnica (use `engineering/tech-debt-tracker`)
- A mudança é trivial (typo, formatação) e não afetará comportamento

## Layout de Armazenamento

Cada projeto armazena TCs em `{project_root}/docs/TC/`:

```
docs/TC/
├── tc_config.json          # Configurações do projeto
├── tc_registry.json        # Índice mestre + estatísticas
├── records/
│   └── TC-001-04-05-26-user-auth/
│       └── tc_record.json  # Fonte da verdade
└── evidence/
    └── TC-001/             # Trechos de log, saída de comandos, screenshots
```

## Convenção de ID de TC

- **TC Pai:** `TC-NNN-MM-DD-YY-functionality-slug` (ex.: `TC-001-04-05-26-user-authentication`)
- **Sub-TC:** `TC-NNN.A` ou `TC-NNN.A.1` (letra = revisão, dígito = sub-revisão)
- `NNN` é sequencial, `MM-DD-YY` é a data de criação, slug é kebab-case.

## Máquina de Estados

```
planned -> in_progress -> implemented -> tested -> deployed
   |            |              |           |          |
   +-> blocked -+              +- in_progress <-------+
        |                          (rework / hotfix)
        +-> planned
```

> Consulte [references/lifecycle.md](references/lifecycle.md) para a tabela completa de transições e fluxos de recuperação.

## Comandos de Fluxo de Trabalho

A skill inclui cinco scripts Python que realizam operações determinísticas com apenas stdlib nos registros TC. Cada um suporta `--help` e `--json`.

### 1. Inicializar rastreamento em um projeto

```bash
python3 scripts/tc_init.py --project "My Project" --root .
```

Cria `docs/TC/`, `docs/TC/records/`, `docs/TC/evidence/`, `tc_config.json` e `tc_registry.json`. Idempotente — re-executar reporta "já inicializado" com estatísticas atuais.

### 2. Criar um novo registro TC

```bash
python3 scripts/tc_create.py \
  --root . \
  --name "user-authentication" \
  --title "Add JWT-based user authentication" \
  --scope feature \
  --priority high \
  --summary "Adds JWT login + middleware" \
  --motivation "Required for protected endpoints"
```

Gera o próximo ID TC sequencial, cria o diretório do registro, escreve um `tc_record.json` totalmente populado (status `planned`, revisão de criação R1) e atualiza o registro.

### 3. Atualizar um registro TC

```bash
# Transição de status (validada contra a máquina de estados)
python3 scripts/tc_update.py --root . --tc-id TC-001-04-05-26-user-auth \
  --set-status in_progress --reason "Starting implementation"

# Adicionar um arquivo
python3 scripts/tc_update.py --root . --tc-id TC-001-04-05-26-user-auth \
  --add-file src/auth.py:created

# Acrescentar dados de handoff
python3 scripts/tc_update.py --root . --tc-id TC-001-04-05-26-user-auth \
  --handoff-progress "JWT middleware wired up" \
  --handoff-next "Write integration tests" \
  --handoff-next "Update README"
```

Cada mudança acrescenta uma entrada de revisão sequencial `R<n>`, atualiza `updated` e revalida contra o esquema antes de escrever atomicamente (`.tmp` depois renomear).

### 4. Ver status

```bash
# TC único
python3 scripts/tc_status.py --root . --tc-id TC-001-04-05-26-user-auth

# Todos os TCs (resumo do registro)
python3 scripts/tc_status.py --root . --all --json
```

### 5. Validar um registro ou registro

```bash
python3 scripts/tc_validator.py --record docs/TC/records/TC-001-.../tc_record.json
python3 scripts/tc_validator.py --registry docs/TC/tc_registry.json
```

O validador aplica o esquema, verifica legalidade da máquina de estados, verifica IDs sequenciais `R<n>` e `T<n>` e asserta consistência de aprovação (`approved=true` requer `approved_by` e `approved_date`).

> Consulte [references/tc-schema.md](references/tc-schema.md) para o esquema completo.

## Dispatcher de Slash-Comando

O repositório inclui um slash command `/tc` em `commands/tc.md` que despacha para estes scripts com base no subcomando:

| Comando | Ação |
|---------|--------|
| `/tc init` | Executar `tc_init.py` para o projeto atual |
| `/tc create <name>` | Solicitar campos, executar `tc_create.py` |
| `/tc update <tc-id>` | Aplicar mudanças descritas pelo usuário via `tc_update.py` |
| `/tc status [tc-id]` | Executar `tc_status.py` |
| `/tc resume <tc-id>` | Exibir handoff, arquivar sessão anterior, iniciar nova |
| `/tc close <tc-id>` | Transitar para `deployed`, definir aprovação |
| `/tc export` | Re-renderizar todos os artefatos derivados |
| `/tc painel` | Re-renderizar o resumo do registro |

O slash command é a interface do usuário; os scripts Python são o motor.

## Formato de Handoff de Sessão

O bloco de handoff fica em `session_context.handoff` dentro de cada TC e é o campo mais importante para continuidade de IA. Contém:

- `progress_summary` — o que foi feito
- `next_steps` — lista ordenada de ações restantes
- `blockers` — qualquer coisa impedindo o progresso
- `key_context` — decisões críticas, armadilhas, padrões que o próximo bot deve conhecer
- `files_in_progress` — arquivos sendo editados e seu estado (`editing`, `needs_review`, `partially_done`, `ready`)
- `decisions_made` — decisões arquiteturais com justificativa e timestamp

> Consulte [references/handoff-format.md](references/handoff-format.md) para a estrutura completa e regras de preenchimento.

## Regras de Validação (Sempre Aplicadas)

1. **Máquina de estados** — apenas transições válidas são permitidas.
2. **IDs sequenciais** — `revision_history` usa `R1, R2, R3...`; `test_cases` usa `T1, T2, T3...`.
3. **Histórico append-only** — entradas de revisão nunca são modificadas ou excluídas.
4. **Consistência de aprovação** — `approved=true` requer `approved_by` e `approved_date`.
5. **Formato de ID de TC** — deve corresponder a `TC-NNN-MM-DD-YY-slug`.
6. **Formato de ID de Sub-TC** — deve corresponder a `TC-NNN.A` ou `TC-NNN.A.N`.
7. **Escritas atômicas** — JSON é escrito em `.tmp` depois renomeado.
8. **Estatísticas do registro** — recalculadas em cada escrita do registro.

## Padrão de Bookkeeping Não-Bloqueante

O rastreamento de TC NÃO DEVE interromper o fluxo de trabalho principal.

- **Nunca pare para atualizar registros TC inline.** Continue codificando.
- Em marcos naturais, spawn um subagente em background para atualizar o registro.
- Faça perguntas apenas quando genuinamente necessário ("Este trabalho não corresponde a nenhum TC ativo — criar um?"), e pergunte uma vez por sessão, não por arquivo.
- No final da sessão, escreva um bloco de handoff final antes de fechar.

## Criação em Lote Retroativa

Para integrar um projeto existente com histórico não documentado, construa um `retro_changelog.json` (uma entrada por mudança lógica) e alimente-o para `tc_create.py` em um loop, ou estenda o script para modo em lote. Agrupar commits por funcionalidade, não por arquivo.

## Anti-Padrões

| Anti-padrão | Por que é ruim | Faça isso em vez disso |
|--------------|--------------|-----------------|
| Editar `revision_history` para "corrigir" um typo | Histórico é append-only — adulteração destrói a trilha de auditoria | Adicionar uma nova revisão que corrija o campo |
| Pular a máquina de estados ("apenas defina o status como deployed") | Ignora validação e oculta fases saltadas | Percorrer `in_progress -> implemented -> tested -> deployed` |
| Criar um TC por arquivo alterado | Fragmenta trabalho relacionado e explode o registro | Um TC por unidade lógica (funcionalidade, correção, refatoração) |
| Atualizar TC inline entre cada edição de código | Desacelera o agente principal, desperdiça contexto | Spawn um subagente em background em marcos |
| Marcar `approved=true` sem `approved_by` | Validador rejeitará; trilha de auditoria enganosa | Sempre definir `approved_by` e `approved_date` juntos |
| Sobrescrever `tc_record.json` diretamente com editor de texto | Risco de corrupção no meio da escrita e pula validação | Use `tc_update.py` (escrita atômica + verificação de esquema) |
| Colocar segredos em `notes` ou evidências | Registros são commitados no repositório | Referenciar uma variável de ambiente ou store de segredos externo |
| Reutilizar IDs de TC após exclusão | Quebra a garantia sequencial e confunde o histórico | Incrementar apenas para frente — nunca reciclar |
| Deixar `next_steps` ficar desatualizado | Derrota o propósito do handoff | Atualizar em cada marco, mesmo se "nada mudou" |

## Referências Cruzadas

- `engineering/changelog-generator` — Gera notas de lançamento Keep-a-Changelog a partir de Conventional Commits. Combinar com TC tracker: TC para a trilha de auditoria granular por mudança, changelog para notas de lançamento voltadas ao usuário.
- `engineering/tech-debt-tracker` — Para rastrear itens de dívida técnica de longa duração em vez de mudanças discretas de código.
- `engineering/focused-fix` — Quando uma correção de bug precisa de reparo sistemático em toda a funcionalidade, execute `/focused-fix` primeiro e depois capture o resultado como um TC.
- `project-management/decision-log` — Decisões arquiteturais feitas dentro do bloco `decisions_made` de um TC também podem ser promovidas para um registro de decisões de nível de projeto.
- `engineering-team/code-reviewer` — A revisão pré-merge se encaixa naturalmente na transição `tested -> deployed`; capture o revisor em `approval.approved_by`.

## Referências Nesta Skill

- [references/tc-schema.md](references/tc-schema.md) — Esquema JSON completo para registros TC e o registro.
- [references/lifecycle.md](references/lifecycle.md) — Máquina de estados, transições válidas e fluxos de recuperação.
- [references/handoff-format.md](references/handoff-format.md) — Estrutura de handoff de sessão e melhores práticas.
