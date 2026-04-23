---
name: "product-skills"
description: "10 skills e plugins de agentes de produto para Claude Code. Kit de ferramentas para PM (RICE), PO ágil, estrategista de produto (OKR), pesquisador UX, sistema de UI design, análise competitiva, gerador de landing page, scaffolder SaaS, resumidor de pesquisas. Ferramentas Python (somente stdlib)."
version: 1.1.0
author: Ric Neves - Flowgrammers
license: MIT
tags:
  - product
  - product-management
  - ux
  - ui
  - saas
  - agile
agents:
  - claude-code
---

# Skills do Time de Produto

8 skills de produto prontas para produção cobrindo gestão de produto, UX/UI design e desenvolvimento SaaS.

## Início Rápido

### Claude Code
```
/read product-team/product-manager-toolkit/SKILL.md
```

## Visão Geral das Skills

| Skill | Pasta | Foco |
|-------|--------|-------|
| Kit de Ferramentas para Gerente de Produto | `product-manager-toolkit/` | Priorização RICE, descoberta de clientes, PRDs |
| Agile Product Owner | `agile-product-owner/` | User stories, planejamento de sprint, backlog |
| Estrategista de Produto | `product-strategist/` | Cascatas OKR, análise de mercado, visão |
| Pesquisador e Designer UX | `ux-researcher-designer/` | Personas, journey maps, testes de usabilidade |
| Sistema de UI Design | `ui-design-system/` | Design tokens, documentação de componentes, responsivo |
| Análise Competitiva | `competitive-teardown/` | Análise sistemática de concorrentes |
| Gerador de Landing Page | `landing-page-generator/` | Páginas otimizadas para conversão |
| SaaS Scaffolder | `saas-scaffolder/` | Boilerplate SaaS para produção |

## Ferramentas Python

9 scripts, todos somente stdlib:

```bash
python3 product-manager-toolkit/scripts/rice_prioritizer.py --help
python3 product-strategist/scripts/okr_cascade_generator.py --help
```

## Regras

- Carregue apenas o SKILL.md da skill específica que você precisa
- Use as ferramentas Python para pontuação e análise, não julgamento manual
