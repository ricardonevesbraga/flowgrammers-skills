---
name: "senior-sre"
description: "Site Reliability Engineer sênior especializado em SLI/SLO/SLA, error budgets, observabilidade, postmortems sem culpa, capacity planning, chaos engineering, incident management e toil reduction. Use ao definir SLOs, estruturar on-call, responder a incidentes, conduzir postmortems, projetar sistemas resilientes, reduzir toil operacional, implementar SRE practices ou quando o usuário mencionar SRE, SLO, error budget, postmortem, on-call, chaos engineering ou toil."
license: MIT
metadata:
  version: 1.0.0
  author: Ric Neves - Flowgrammers
  category: engineering-team
  domain: site-reliability
  updated: 2026-04-23
agents:
  - claude-code
---

# Site Reliability Engineer Sênior

Frameworks SRE (Google-style) adaptados para empresas brasileiras: SLO-driven reliability, error budgets, postmortems blameless, toil reduction e chaos engineering.

## Palavras-chave
SRE, site reliability, SLI, SLO, SLA, error budget, postmortem, blameless, on-call, incident management, incident commander, chaos engineering, toil, capacity planning, observability, DORA metrics

## Responsabilidades Principais

### 1. SLI/SLO/SLA (definição em camadas)

**SLI (Service Level Indicator)** — o que você mede
- Latência do p99 de requisições HTTP bem-sucedidas
- % de transações completadas com sucesso
- Freshness de dados em dashboard
- Disponibilidade = 1 - (failed_requests / total_requests)

**SLO (Service Level Objective)** — meta interna
- 99.9% de disponibilidade mensal (= 43m 49s de downtime/mês)
- p99 < 300ms em 99% das requisições
- 99.5% dos emails transacionais entregues em < 30s

**SLA (Service Level Agreement)** — promessa contratual com cliente
- Sempre MAIS PERMISSIVO que o SLO (buffer de segurança)
- SLO 99.9% → SLA 99.5% (deixa margem antes de devolver créditos)

**Regra-chave:** SLO é uma decisão de negócio, não técnica. Pergunte "o cliente percebe a diferença entre 99.9% e 99.99%?" Se não, economize milhões.

### 2. Error Budget

Se SLO = 99.9%, error budget = 0.1% do período.
- Em 30 dias = 43 minutos 49s de "permissão para falhar"

**Policy típica:**
- Budget intacto (>50%) → libere features agressivamente
- Budget 20-50% → cautela, reduza velocidade de deploy
- Budget <20% → congele novas features, foco em reliability
- Budget exaurido → freeze total até recuperação

```yaml
# error-budget-policy.yaml
service: checkout-api
slo: 99.9%
window: 30d
thresholds:
  green: ">= 50%"
  yellow: "20% - 50%"
  red: "< 20%"
  exhausted: "< 0%"
actions:
  green:
    - normal_velocity
  yellow:
    - reduce_deploy_frequency
    - require_sre_review
  red:
    - freeze_non_critical_features
    - weekly_reliability_reviews
  exhausted:
    - full_feature_freeze
    - daily_war_room
```

### 3. Observabilidade (Three Pillars + Traces + Profiling)

**Stack mínimo (2026):**
- **Metrics**: Prometheus + Grafana, OpenTelemetry SDK
- **Logs**: Loki, Elastic ou Datadog
- **Traces**: Jaeger, Tempo ou Datadog APM
- **Profiling contínuo**: Pyroscope, Grafana Cloud Profiles

**Dashboards por serviço (Golden Signals):**
1. **Latency** (distribuição, não média — use p50/p95/p99)
2. **Traffic** (RPS, throughput)
3. **Errors** (rate + %)
4. **Saturation** (CPU, memória, conexões, queue depth)

**Alertas — SEMPRE:**
- Baseados em SLO (burn rate), não em thresholds fixos
- Multi-window burn rate (5m + 1h + 6h)
- Actionable (se não há ação, não alerte)
- Com runbook linkado no alert

```yaml
# alert.yaml — Burn rate alert
alert: CheckoutAPIErrorBudgetBurnRate
expr: |
  (
    error_budget_burn_rate_5m > 14.4
    AND error_budget_burn_rate_1h > 14.4
  ) OR (
    error_budget_burn_rate_30m > 6
    AND error_budget_burn_rate_6h > 6
  )
severity: page
runbook: https://docs/runbooks/checkout-api-errors
```

### 4. Incident Management

**Estrutura de resposta:**
- **Incident Commander (IC)**: coordena, não executa
- **Subject Matter Expert (SME)**: diagnóstico e remediação
- **Communications Lead**: updates externos e internos
- **Scribe**: registra timeline

**Severidades:**
| Sev | Impacto | Resposta |
|-----|---------|----------|
| 1 | Produção derrubada, receita parada | Imediata, war room |
| 2 | Funcionalidade crítica degradada | Em horário, < 1h |
| 3 | Degradação parcial | Em horário, < 4h |
| 4 | Incomodo menor | Em backlog |

**Timeline de um SEV1:**
- 0-5min: IC declara, cria war room, notifica stakeholders
- 5-15min: Triage inicial, hipóteses, rollback se óbvio
- 15-60min: Mitigação (rollback, scale, circuit break, trafego switch)
- Pós: postmortem em até 72h

### 5. Postmortem Blameless

**Template:**
```markdown
# Postmortem: Incidente CHK-2026-04-15

## Resumo
- **Data**: 2026-04-15 14:23 BRT — 2026-04-15 15:47 BRT
- **Duração**: 1h 24min
- **Impacto**: 100% de falhas no checkout para ~12k usuários
- **Severidade**: SEV1

## Timeline
| Hora | Evento |
|------|--------|
| 14:23 | Deploy v2.4.0 iniciado |
| 14:24 | Alerta burn rate 5m disparado |
| 14:28 | IC declarado, rollback iniciado |
| 14:42 | Rollback completo, recuperação parcial |
| 15:47 | Recuperação total confirmada |

## Causa Raiz
Migração de schema adicionou NOT NULL em coluna `session_id`, mas rollout do backend precedeu migração. Durante janela de 20 min, INSERTs falharam com `null value in column "session_id"`.

## O Que Funcionou
- Alerta de burn rate disparou em 1 minuto
- Rollback automático estava configurado

## O Que Não Funcionou
- Ordem de migração não estava documentada
- Canary deploy só cobria 1% por 5min (insuficiente)

## Ações
| # | Ação | Dono | Prazo | Prioridade |
|---|------|------|-------|------------|
| 1 | Forçar migrations antes de backend em CI | SRE | 2026-04-25 | P0 |
| 2 | Aumentar canary para 10min em serviços críticos | Platform | 2026-05-10 | P1 |
| 3 | Runbook de incidents de schema | SRE | 2026-05-15 | P2 |

## Lições Aprendidas
Um princípio emergiu: "deploys de schema e código são acoplados; trate como uma unidade."
```

**Regras:**
- **Blameless**: foque em sistemas e processos, não pessoas
- **Sem "deveria ter"**: descreva o que aconteceu e por quê
- **Ações com dono, prazo e prioridade** — senão não sai do papel
- **Compartilhe amplamente** (dentro da empresa) — aprendizado é patrimônio

### 6. Toil Reduction

**Toil** = trabalho operacional manual, repetitivo, automatizável, sem valor duradouro.

**Alvo SRE canônico:** < 50% do tempo em toil.

**Identificação:**
- Tickets de onboarding/offboarding manuais
- Restart de serviços por degradação
- Rotação de credenciais manual
- Criação de ambientes sob demanda
- Escalamento manual de recursos

**Strategy:**
1. Medir (timesheet ou ticket analysis)
2. Categorizar (reactive vs. proactive)
3. Priorizar por frequência × duração
4. Automatizar top 3 por quarter
5. Medir redução trimestralmente

### 7. Capacity Planning

**Fórmula:**
```
Capacidade = Baseline × (1 + crescimento_anual) × fator_segurança

Ex: 10k RPS atual × (1 + 0.6) × 1.5 = 24k RPS de capacidade planejada
```

**Inputs:**
- Baseline atual (p99 RPS e resource use)
- Projeção de crescimento (product + business + seasonality)
- Fator de segurança (1.3 estável / 1.5 em crescimento / 2.0 em hypergrowth)
- Lead time de capacity (cloud = minutos; hardware = meses)

**Outputs:**
- Headroom requirements por serviço
- Budget de infra trimestral
- Triggers para scale automático
- Black Friday / eventos prep list

### 8. Chaos Engineering

**Princípios:**
- Construa hipótese sobre comportamento do sistema
- Varie eventos do mundo real
- Execute em produção (com cuidado)
- Automatize para executar continuamente

**Ferramentas:**
- Chaos Mesh / Litmus (Kubernetes)
- AWS Fault Injection Simulator
- Gremlin (SaaS)
- Toxiproxy (rede)

**Experimentos iniciais:**
- Kill random pod (resiliência a crashes)
- Network latency injection (graceful degradation)
- Dependency outage (Netflix: "Can we survive S3 outage in us-east-1?")
- CPU/memory pressure (saturação)

## Métricas do SRE (DORA + SRE)

| Métrica | Elite | High | Medium |
|---------|-------|------|--------|
| Deploy frequency | múltiplos/dia | 1x/dia | 1x/semana |
| Lead time for changes | < 1h | < 1 dia | < 1 semana |
| MTTR | < 1h | < 1 dia | < 1 semana |
| Change failure rate | < 15% | 16-30% | 16-30% |

**Outras:**
- SLO compliance (% do tempo dentro do SLO)
- Error budget remaining
- Alert fatigue score (alerts/week/person)
- Toil % (objetivo < 50%)

## Perguntas-Chave que um SRE Faz

- "Qual é o custo real do incidente de ontem — receita perdida + resposta + postmortem + retrabalho?"
- "Estamos otimizando para evitar incidentes ou para responder rápido?"
- "Nossos alertas são actionable ou só ruído?"
- "Se X cair agora, quanto tempo até percebermos? Até corrigirmos?"
- "Qual é o próximo toil que podemos automatizar por 2 semanas de trabalho?"

## Veja Também

- `../senior-devops/` — CI/CD e infraestrutura
- `../incident-commander/` — liderança de incidentes
- `../incident-response/` — resposta tática
- `../../engineering/observability-designer/` — instrumentação
- `../../engineering/ci-cd-pipeline-builder/` — deploy automation
