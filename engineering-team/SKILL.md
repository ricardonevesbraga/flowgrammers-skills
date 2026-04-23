---
name: "engineering-skills"
description: "23 skills de engenharia prontas para produção para Claude Code. Arquitetura, frontend, backend, QA, DevOps, segurança, IA/ML, engenharia de dados, Playwright, Stripe, AWS, MS365. ferramentas Node.js, TypeScript e scripts utilitários."
version: 1.1.0
author: Ric Neves - Flowgrammers
license: MIT
tags:
  - engineering
  - frontend
  - backend
  - devops
  - security
  - ai-ml
  - data-engineering
agents:
  - claude-code
---

# Engineering Team Skills

23 skills de engenharia prontas para produção, organizadas em engenharia central, IA/ML/Dados e ferramentas especializadas.

## Início Rápido

### Claude Code
```
/read engineering-team/senior-fullstack/SKILL.md
```

## Visão Geral das Skills

### Engenharia Central (13 skills)

| Skill | Pasta | Foco |
|-------|--------|-------|
| Senior Architect | `senior-architect/` | Design de sistemas, padrões de arquitetura |
| Senior Frontend | `senior-frontend/` | React, Next.js, TypeScript, Tailwind |
| Senior Backend | `senior-backend/` | Design de API, otimização de banco de dados |
| Senior Fullstack | `senior-fullstack/` | Scaffolding de projetos, qualidade de código |
| Senior QA | `senior-qa/` | Geração de testes, análise de cobertura |
| Senior DevOps | `senior-devops/` | CI/CD, infraestrutura, containers |
| Senior SecOps | `senior-secops/` | Operações de segurança, gestão de vulnerabilidades |
| Code Reviewer | `code-reviewer/` | Revisão de PR, análise de qualidade de código |
| Senior Security | `senior-security/` | Modelagem de ameaças, STRIDE, testes de penetração |
| AWS Solution Architect | `aws-solution-architect/` | Serverless, CloudFormation, otimização de custos |
| MS365 Tenant Manager | `ms365-tenant-manager/` | Administração do Microsoft 365 |
| TDD Guide | `tdd-guide/` | Fluxos de trabalho de desenvolvimento orientado a testes |
| Tech Stack Evaluator | `tech-stack-evaluator/` | Comparação de tecnologias, análise de TCO |

### IA/ML/Dados (5 skills)

| Skill | Pasta | Foco |
|-------|--------|-------|
| Senior Data Scientist | `senior-data-scientist/` | Modelagem estatística, experimentação |
| Senior Data Engineer | `senior-data-engineer/` | Pipelines, ETL, qualidade de dados |
| Senior ML Engineer | `senior-ml-engineer/` | Implantação de modelos, MLOps, integração com LLM |
| Senior Prompt Engineer | `senior-prompt-engineer/` | Otimização de prompts, RAG, agents |
| Senior Computer Vision | `senior-computer-vision/` | Detecção de objetos, segmentação |

### Ferramentas Especializadas (5 skills)

| Skill | Pasta | Foco |
|-------|--------|-------|
| Playwright Pro | `playwright-pro/` | Testes E2E (9 sub-skills) |
| Self-Improving Agent | `self-improving-agent/` | Curadoria de memória (5 sub-skills) |
| Stripe Integration | `stripe-integration-expert/` | Integração de pagamentos, webhooks |
| Incident Commander | `incident-commander/` | Fluxos de trabalho de resposta a incidentes |
| Email Template Builder | `email-template-builder/` | Geração de e-mails HTML |

## Ferramentas Python

30+ scripts, todos somente stdlib. Execute diretamente:

```bash
python3 <skill>/scripts/<tool>.py --help
```

Sem necessidade de pip install. Os scripts incluem amostras embutidas para modo demo.

## Regras

- Carregue apenas o SKILL.md da skill específica que você precisa — não carregue todas as 23 em massa
- Use as ferramentas Python para análise e scaffolding, não julgamento manual
- Verifique o CLAUDE.md para exemplos de uso de ferramentas e fluxos de trabalho
