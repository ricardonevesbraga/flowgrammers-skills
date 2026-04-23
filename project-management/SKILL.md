---
name: "pm-skills"
description: "6 skills de gerenciamento de projetos para Claude Code. Senior PM, scrum master, especialista em Jira (JQL), especialista em Confluence, administrador Atlassian e criador de templates. Integração MCP para automação ao vivo no Jira/Confluence."
version: 1.0.0
author: Ric Neves - Flowgrammers
license: MIT
tags:
  - project-management
  - jira
  - confluence
  - atlassian
  - scrum
  - agile
agents:
  - claude-code
---

# Skills de Gerenciamento de Projetos

6 skills de gerenciamento de projetos prontas para produção com integração Atlassian MCP.

## Início Rápido

### Claude Code
```
/read project-management/jira-expert/SKILL.md
```

## Visão Geral das Skills

| Skill | Pasta | Foco |
|-------|--------|-------|
| Senior PM | `senior-pm/` | Gestão de portfólio, análise de riscos, planejamento de recursos |
| Scrum Master | `scrum-master/` | Previsão de velocidade, saúde do sprint, retrospectivas |
| Jira Expert | `jira-expert/` | Consultas JQL, fluxos de trabalho, automação, painéis |
| Confluence Expert | `confluence-expert/` | Bases de conhecimento, layouts de página, macros |
| Atlassian Admin | `atlassian-admin/` | Gestão de usuários, permissões, integrações |
| Atlassian Templates | `atlassian-templates/` | Blueprints, layouts personalizados, conteúdo reutilizável |

## Ferramentas Python

6 scripts, todos somente stdlib:

```bash
python3 senior-pm/scripts/project_health_dashboard.py --help
python3 scrum-master/scripts/velocity_analyzer.py --help
```

## Regras

- Carregue apenas o SKILL.md da skill específica que você precisa
- Use as ferramentas MCP para operações ao vivo no Jira/Confluence quando disponíveis
