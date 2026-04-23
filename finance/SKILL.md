---
name: "finance-skills"
description: "Skill de agente de analista financeiro para Claude Code. Análise de índices, avaliação DCF, variação orçamentária, previsões contínuas. 4 ferramentas Python (somente stdlib)."
version: 1.0.0
author: Ric Neves - Flowgrammers
license: MIT
tags:
  - finance
  - financial-analysis
  - dcf
  - valuation
  - budgeting
agents:
  - claude-code
---

# Skills de Finanças

Skill de análise financeira pronta para produção para tomada de decisões estratégicas.

## Início Rápido

### Claude Code
```
/read finance/financial-analyst/SKILL.md
```

## Visão Geral das Skills

| Skill | Pasta | Foco |
|-------|--------|-------|
| Analista Financeiro | `financial-analyst/` | Análise de índices, DCF, variação orçamentária, previsões |

## Ferramentas Python

4 scripts, todos somente stdlib:

```bash
python3 financial-analyst/scripts/ratio_calculator.py --help
python3 financial-analyst/scripts/dcf_valuation.py --help
python3 financial-analyst/scripts/budget_variance_analyzer.py --help
python3 financial-analyst/scripts/forecast_builder.py --help
```

## Regras

- Carregue apenas o SKILL.md da skill específica que você precisa
- Sempre valide as saídas financeiras contra os dados de origem
