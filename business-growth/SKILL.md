---
name: "business-growth-skills"
description: "4 skills de crescimento de negócios para Claude Code. Customer Success (health scoring, prevenção de churn), Sales Engineer (análise de RFP), Revenue Operations (pipeline, GTM), Contract & Proposal Writer (propostas e contratos). Ferramentas Python (apenas stdlib)."
version: 1.1.0
author: Ric Neves - Flowgrammers
license: MIT
tags:
  - business
  - customer-success
  - sales
  - revenue-operations
  - growth
agents:
  - claude-code
---

# Business & Growth Skills

4 skills prontas para produção em customer success, vendas e revenue operations.

## Início Rápido

```
/read business-growth/customer-success-manager/SKILL.md
/read business-growth/sales-engineer/SKILL.md
/read business-growth/revenue-operations/SKILL.md
/read business-growth/contract-and-proposal-writer/SKILL.md
```

## Visão Geral das Skills

| Skill | Pasta | Foco |
|-------|-------|------|
| Customer Success Manager | `customer-success-manager/` | Health scoring, previsão de churn, expansão |
| Sales Engineer | `sales-engineer/` | Análise de RFP, matrizes competitivas, planejamento de PoC |
| Revenue Operations | `revenue-operations/` | Análise de pipeline, precisão de forecast, métricas GTM |
| Contract & Proposal Writer | `contract-and-proposal-writer/` | Geração de propostas, templates de contratos (lei brasileira) |

## Ferramentas Python

9 scripts, todos usando apenas a biblioteca padrão:

```bash
python3 customer-success-manager/scripts/health_score_calculator.py --help
python3 revenue-operations/scripts/pipeline_analyzer.py --help
```

## Regras

- Carregue apenas o SKILL.md da skill específica que precisar
- Use as ferramentas Python para scoring e métricas, não estimativas manuais
