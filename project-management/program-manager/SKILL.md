---
name: "program-manager"
description: "Program Manager sênior para gestão de programas multi-projeto, dependências entre times, RAID log (Risks, Assumptions, Issues, Dependencies), stakeholder management, governança de portfólio, status reporting executivo e entrega de iniciativas estratégicas. Use ao estruturar um programa, coordenar múltiplos squads, gerenciar dependências críticas, reportar status para C-level ou quando o usuário mencionar Program Manager, PgM, programa, portfólio, governança, RAID log, steering committee ou cross-functional delivery."
license: MIT
metadata:
  version: 1.0.0
  author: Ric Neves - Flowgrammers
  category: project-management
  domain: program-management
  updated: 2026-04-23
agents:
  - claude-code
---

# Program Manager Sênior

Frameworks para gestão de programas estratégicos: portfólio, dependências, RAID, governança, stakeholder management e entrega cross-functional.

## Palavras-chave
Program Manager, PgM, TPgM, Technical Program Manager, portfolio management, governança, steering committee, RAID log, risco, dependência, cross-functional, stakeholder management, status report, milestone tracking

## Program ≠ Project

| Projeto | Programa |
|---------|----------|
| Entregável definido | Benefício estratégico |
| Início e fim | Múltiplos projetos no tempo |
| 1 PM | 1 PgM + N PMs |
| Escopo fechado | Escopo adaptável |
| Sucesso = on time, on budget | Sucesso = valor entregue |

**Exemplo:**
- Projeto: "Migrar para AWS em Q2"
- Programa: "Modernização de Infraestrutura" (inclui migração, observabilidade, SRE, FinOps)

## Responsabilidades Principais

### 1. Program Charter (1-pager)

```markdown
# Program Charter: [Nome do Programa]

## Visão
[Uma frase clara sobre o estado futuro]

## Benefícios esperados (quantificáveis)
- R$ X de receita ou Y% de redução de custo
- Z% de melhoria em métrica chave

## Escopo
**Dentro:** [O que o programa entrega]
**Fora:** [O que NÃO faz parte]

## Stakeholders-chave
- Sponsor executivo: [nome]
- Steering committee: [nomes]
- Times envolvidos: [lista]

## Milestones principais
| Milestone | Data | Entregável |
|-----------|------|-----------|
| M1 | Q2/2026 | [...] |
| M2 | Q3/2026 | [...] |

## Riscos top 3
1. [...]
2. [...]
3. [...]

## Orçamento
R$ X (CapEx) + R$ Y (OpEx) + Z FTEs
```

### 2. Estrutura de Programa

**Papéis típicos:**
- **Sponsor Executivo** (C-level) — dono do outcome
- **Steering Committee** (VPs/Diretores) — decisões críticas mensais
- **Program Manager** — coordenação diária
- **Project Managers** (1 por workstream) — execução dos projetos
- **Workstream Leads** (tech/produto/go-to-market) — liderança técnica

**Cadência de rituais:**

| Ritual | Frequência | Participantes | Duração |
|--------|-----------|---------------|---------|
| Steering Committee | Mensal | Execs + PgM | 60 min |
| Program Sync | Semanal | PgM + PMs + leads | 60 min |
| Risk Review | Semanal | PgM + subset | 30 min |
| All-Hands do Programa | Bimestral | Todos | 45 min |
| Retrospectiva | Por milestone | Todos | 90 min |

### 3. RAID Log (Risks, Assumptions, Issues, Dependencies)

**Template:**

```markdown
# RAID Log — [Programa]

## Risks (eventos futuros com probabilidade)
| ID | Descrição | Prob | Impacto | Score | Mitigação | Owner | Status |
|----|-----------|------|---------|-------|-----------|-------|--------|
| R01 | Fornecedor X pode atrasar | M | A | 12 | Plano B contratado | JR | Monitorado |

## Assumptions (premissas a validar)
| ID | Premissa | Validação | Data | Status |
|----|----------|-----------|------|--------|
| A01 | Cliente Y assinará contrato em Q2 | Reunião 2026-05-15 | 2026-05-15 | Pendente |

## Issues (problemas atuais)
| ID | Descrição | Impacto | Owner | Deadline | Status |
|----|-----------|---------|-------|----------|--------|
| I01 | API de terceiros com downtime | Delay 1 sem | MC | 2026-05-10 | Em andamento |

## Dependencies (o que precisamos de outros)
| ID | Entrega esperada | De | Para | Data | Status |
|----|------------------|-----|------|------|--------|
| D01 | Schema de dados | Data Team | Eng Team | 2026-05-01 | Confirmado |
```

**Régua de risco (prob × impacto):**

|  | Impacto Baixo (1) | Médio (3) | Alto (5) |
|--|------|-----|------|
| **Prob Alta (5)** | 5 | 15 | 25 |
| **Média (3)** | 3 | 9 | 15 |
| **Baixa (1)** | 1 | 3 | 5 |

- Score >= 15: escalação obrigatória, steering review
- Score 9-14: plano de mitigação formal, review semanal
- Score < 9: monitoramento leve

### 4. Dependency Management

**Tipos de dependência:**
- **Finish-to-Start**: B não começa até A terminar (mais comum)
- **Start-to-Start**: B começa ao mesmo tempo de A
- **Finish-to-Finish**: B termina quando A terminar

**Mapa visual (use Miro ou similar):**

```
[Data Platform] ─────▶ [ML Training] ─────▶ [Inference Service]
                            │
                            ▼
                     [Data Governance]
                            │
                            ▼
                     [Compliance Review] ─▶ [Production Launch]
```

**Tática contra dependências ocultas:**
- Pergunta semanal em sync: "O que vocês estão esperando de outro time?"
- Dependency map atualizado a cada milestone
- Contratos internos (APIs, interfaces) com owners e SLAs

### 5. Status Reporting

**Princípios:**
- **RAG status** (Red / Amber / Green) + narrativa
- Honesto sobre red — esconder vira crise maior
- Trends são mais importantes que pontos isolados
- Propõe ações, não só informa problema

**Template executivo (máx. 1 slide):**

```markdown
# Program Status — [Nome] — [Semana/Mês]

## Overall: AMBER ⚠️

## Milestones
| Milestone | Target | Forecast | Status |
|-----------|--------|----------|--------|
| M1 | 2026-05-30 | 2026-06-07 | 🟡 |
| M2 | 2026-08-15 | 2026-08-15 | 🟢 |

## Top 3 Riscos
1. 🔴 Contratação de 2 engenheiros sêniores atrasada (mitigação: contractor)
2. 🟡 Integração API depende de aprovação legal (resolve 2026-05-10)
3. 🟢 Budget on track

## Decisões necessárias
- Aprovação de orçamento adicional de R$ X (mitigação do risco 1)
- Go/no-go para milestone M1 em 2026-05-15

## O que mudou desde o último update
- Finalizamos discovery de Y (1 semana atrás do plano)
- Fornecedor X confirmou entrega para junho
```

### 6. Stakeholder Management

**Matriz Poder × Interesse:**

| Alto Interesse | Baixo Interesse |
|--|--|
| **Alto Poder**: Manage closely | **Alto Poder**: Keep satisfied |
| **Baixo Poder**: Keep informed | **Baixo Poder**: Monitor |

**Tática por quadrante:**
- **Manage closely**: updates semanais, 1:1s quinzenais, consulta em decisões
- **Keep satisfied**: updates mensais, envolver em marcos
- **Keep informed**: newsletter, all-hands
- **Monitor**: visibilidade passiva

**Red flags de stakeholder:**
- Sumiu de 2 steering committees seguidos
- Não responde emails/chats em > 48h
- Surpresa em decisões (= não está informado)
- Muda de posição sem aviso
- Envia subordinados sem poder de decisão

### 7. Change Management no Programa

**Todo programa = mudança organizacional. Se você só gerencia tarefas, falha.**

**Kotter 8-steps aplicado:**
1. Crie senso de urgência (por que agora?)
2. Construa coalizão forte
3. Desenvolva visão e estratégia
4. Comunique a visão (10× mais do que parece necessário)
5. Remova barreiras
6. Gere quick wins
7. Consolide ganhos
8. Ancore na cultura

### 8. Governança de Portfólio (visão multi-programa)

**Framework trimestral:**
- **Health check** de cada programa (RAG, burn, benefícios)
- **Resource allocation** — quem precisa de mais / menos
- **Stop / continue / accelerate** decisions
- **Dependency map** cross-program

**Critérios para matar um programa:**
- Benefícios previstos não mais relevantes
- Custo > benefício
- Mudança estratégica (pivot)
- Execução muito ruim, sem caminho de recuperação

## Anti-Patterns (evite)

- ❌ Micromanagement de tarefas (PMs são responsáveis por isso)
- ❌ Status report que só mostra verde (perda de confiança quando vira vermelho)
- ❌ Risco listado, mitigação genérica ("vamos monitorar")
- ❌ Steering committee vira teatro (decisões prontas antes da reunião)
- ❌ Ignorar stakeholders difíceis (eles viram bloqueadores maiores)
- ❌ Comunicação só em meeting (use async também: docs, Loom, newsletter)

## Métricas do Program Manager

- **Milestone delivery rate**: % de marcos entregues on-time
- **Benefício realizado**: R$ captured × R$ planejado
- **Stakeholder NPS**: pesquisa com membros do steering
- **Issue resolution time**: mediana de dias para resolver
- **Team escalations**: quantas vezes times do programa precisaram escalar
- **Schedule variance**: dias de atraso vs. plano

## Perguntas-Chave

- "Se este programa for cancelado amanhã, qual é o maior desperdício?"
- "Qual dependência oculta pode quebrar tudo?"
- "Nossos stakeholders estão realmente alinhados ou só concordam em reunião?"
- "Que risco estamos ignorando porque é desconfortável falar?"
- "Qual é o caminho crítico — e quem é o owner do próximo milestone dele?"

## Veja Também

- `senior-pm/` — PM de projetos individuais
- `scrum-master/` — execução ágil
- `meeting-analyzer/` — eficiência de reuniões
- `team-communications/` — comunicação de time
- `jira-expert/` — tracking em Jira
- `../c-level-advisor/coo-advisor/` — execução operacional
