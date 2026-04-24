# Flowgrammers Claude Skills

[![License: MIT](https://img.shields.io/badge/License-MIT-e8006a.svg)](LICENSE)
[![Skills](https://img.shields.io/badge/skills-251-e8006a.svg)](#mapa-completo-de-skills)
[![Idioma](https://img.shields.io/badge/idioma-PT--BR-e8006a.svg)](#)
[![Claude Code](https://img.shields.io/badge/platform-Claude%20Code-00e8d0.svg)](https://docs.claude.com/en/docs/claude-code/overview)
[![Version](https://img.shields.io/badge/version-2.1.0-00e8d0.svg)](CHANGELOG.md)

> **251 skills + 29 comandos slash prontos para produção no Claude Code**
> Contexto 100% brasileiro · Apenas Claude Code · Por Ric Neves — Flowgrammers

> 📊 **Veja a apresentação visual completa:** abra [`SKILLS-portavel.html`](SKILLS-portavel.html) no navegador — 14 slides cobrindo todos os 9 domínios.

---

## O que são Skills?

Skills são arquivos de instrução que transformam o Claude Code em especialistas sob demanda. Em vez de escrever longos prompts toda vez, você carrega uma skill e o Claude assume imediatamente o papel de um especialista — com frameworks, ferramentas e contexto já configurados.

```
Sem skill:  "Me ajude com marketing..."        → resposta genérica
Com skill:  /read marketing-skill/paid-ads/SKILL.md
            "Preciso de uma campanha no Meta Ads com orçamento de R$5k"
            → análise de segmentação, estrutura de campanha, copy de anúncio, ROAS esperado
```

---

## Instalação Rápida (1 comando)

```bash
curl -fsSL https://raw.githubusercontent.com/ricardonevesbraga/flowgrammers-skills/main/install.sh | bash
```

Isso instala tudo automaticamente em `~/.claude/skills/` e `~/.claude/commands/`.
Veja a seção [Instalação Manual](#instalação-manual) se preferir controle total.

### Ou clone e instale

```bash
git clone https://github.com/ricardonevesbraga/flowgrammers-skills.git
cd flowgrammers-skills
./install.sh
```

> ⭐ **Gostou?** Deixe uma estrela no GitHub — ajuda o projeto a crescer organicamente.

---

## Como Usar

### 1. Carregar uma skill

```
/read c-level-advisor/ceo-advisor/SKILL.md
```

### 2. Pedir ao Claude para agir como especialista

```
Use a skill de CEO Advisor e me ajude a preparar minha apresentação para investidores.
Atue como Senior Frontend e revise meu componente React.
Como especialista em SEO, analise meu site para o mercado brasileiro.
```

### 3. Usar comandos slash (após instalação)

```
/prd          → gera um PRD completo
/tdd          → workflow de TDD
/sprint-plan  → planejamento de sprint
/saas-health  → métricas de saúde do SaaS
/tech-debt    → análise de dívida técnica
```

---

## Mapa Completo de Skills

### C-Level Advisory (`c-level-advisor/`) — 37 skills

Assessoria estratégica para líderes executivos.

| Skill | O que faz |
|-------|-----------|
| `ceo-advisor` | Estratégia, captação, board, cultura organizacional |
| `cfo-advisor` | Modelagem financeira, runway, fundraising |
| `cto-advisor` | Arquitetura técnica, build vs buy, roadmap de eng. |
| `cmo-advisor` | Estratégia de marketing, GTM, posicionamento |
| `coo-advisor` | Operações, OKRs, eficiência organizacional |
| `cpo-advisor` | Estratégia de produto, roadmap, métricas |
| `cro-advisor` | Revenue, pipeline, quota, sales ops |
| `chro-advisor` | RH, cultura, retenção, CLT/PJ |
| `ciso-advisor` | Segurança, LGPD, ISO 27001, gestão de risco |
| `cdo-advisor` ✨ | Chief Data Officer — dados, governança, LGPD, monetização |
| `caio-advisor` ✨ | Chief AI Officer — estratégia de IA, responsible AI, ROI |
| `clo-advisor` ✨ | Chief Legal Officer — jurídico BR, M&A, LGPD |
| `chief-of-staff` | Roteador automático para o C-suite correto |
| `executive-mentor` | Coaching executivo com 5 sub-skills |
| `board-meeting` | Protocolo e preparação de reunião de conselho |
| `board-deck-builder` | Construção de deck para o board |
| `founder-coach` | Coaching para founders em early-stage |
| `decision-logger` | Registro e auditoria de decisões estratégicas |
| E mais 19... | |

```
/read c-level-advisor/ceo-advisor/SKILL.md
Preciso preparar minha apresentação para a Série A. Temos ARR de R$2M, crescendo 15% a.m.
```

---

### Engineering (`engineering/`) — 60 skills

Ferramentas avançadas de engenharia de software.

| Skill | O que faz |
|-------|-----------|
| `rag-architect` | Design de pipelines RAG, chunking, embeddings |
| `mcp-server-builder` | Construção de MCP servers para Claude Code |
| `database-designer` | Modelagem de banco de dados, índices, performance |
| `ci-cd-pipeline-builder` | Pipelines CI/CD, GitHub Actions, deploy |
| `api-design-reviewer` | Revisão de APIs REST/GraphQL |
| `observability-designer` | Logs, métricas, traces, alertas |
| `docker-development` | Containers, compose, otimização de imagens |
| `terraform-patterns` | IaC, módulos, state management, segurança |
| `performance-profiler` | Profiling Node.js, Python, Go — gargalos |
| `pr-review-expert` | Revisão automatizada de pull requests |
| `agenthub` | Orquestração de agentes com 7 sub-skills |
| `autoresearch-agent` | Agente de pesquisa autônomo com 5 sub-skills |
| E mais 43... | |

```
/read engineering/rag-architect/SKILL.md
Preciso implementar um RAG para documentos PDF em português com Pinecone e Claude.
```

---

### Engineering Team (`engineering-team/`) — 54 skills

Time completo de engenharia especializado.

| Skill | O que faz |
|-------|-----------|
| `senior-frontend` | React, Next.js, TypeScript, Tailwind, acessibilidade |
| `senior-backend` | APIs, banco de dados, autenticação, performance |
| `senior-mobile-ios` ✨ | Swift 6, SwiftUI, Xcode Cloud, App Store |
| `senior-mobile-android` ✨ | Kotlin, Jetpack Compose, Play Store, KMP |
| `senior-sre` ✨ | SLO, error budget, postmortems, chaos engineering |
| `senior-devops` | CI/CD, Kubernetes, monitoramento, cloud |
| `senior-qa` | Testes, cobertura, E2E com Playwright |
| `senior-architect` | Arquitetura de sistemas, trade-offs, decisões |
| `senior-ml-engineer` | MLOps, LLMs, integração de IA em produção |
| `senior-data-engineer` | Pipelines de dados, ETL/ELT, dbt, Airflow |
| `code-reviewer` | Revisão de código TypeScript, Python, Go, Swift |
| `tdd-guide` | Test-Driven Development, red-green-refactor |
| `playwright-pro` | Testes E2E com 9 sub-skills especializadas |
| `aws-solution-architect` | Arquitetura AWS, Well-Architected Framework |
| `senior-security` | Segurança de aplicação, OWASP, modelagem de ameaças |
| E mais 33... | |

```
/read engineering-team/senior-frontend/SKILL.md
Revise este componente React e identifique problemas de performance e acessibilidade.
```

---

### Marketing (`marketing-skill/`) — 45 skills

Marketing digital completo com contexto brasileiro.

| Skill | O que faz |
|-------|-----------|
| `paid-ads` | Meta Ads, Google Ads, LinkedIn, TikTok — estratégia e copy |
| `seo-audit` | Auditoria SEO técnica e on-page |
| `ai-seo` | SEO para era da IA, Google SGE, otimização LLM |
| `content-strategy` | Estratégia de conteúdo e calendário editorial |
| `email-sequence` | Sequências de email e automação |
| `copywriting` | Copy persuasivo para diferentes formatos |
| `brand-guidelines` | Identidade e diretrizes de marca |
| `pricing-strategy` | Estratégia de precificação e monetização |
| `launch-strategy` | Estratégia de lançamento de produto |
| `churn-prevention` | Prevenção de churn e retenção |
| `social-media-manager` | Gestão de redes sociais com WhatsApp |
| E mais 34... | |

```
/read marketing-skill/paid-ads/SKILL.md
Quero criar uma campanha no Meta Ads para captar leads B2B no Brasil, orçamento R$10k/mês.
```

---

### Product Team (`product-team/`) — 18 skills

| Skill | O que faz |
|-------|-----------|
| `product-manager-toolkit` | Kit completo de PM com RICE, OKRs, métricas |
| `growth-product-manager` ✨ | NSM, AARRR, growth loops, PLG, experimentação |
| `agile-product-owner` | PO ágil, backlog, refinement, sprint planning |
| `ux-researcher-designer` | Pesquisa de usuário, entrevistas, personas |
| `ui-design-system` | Sistema de design, componentes, tokens |
| `landing-page-generator` | Geração de landing pages de alta conversão |
| `saas-scaffolder` | Scaffolding completo de produto SaaS |
| `competitive-teardown` | Análise competitiva detalhada |
| `product-strategist` | Estratégia de produto e visão de longo prazo |
| E mais 9... | |

---

### Business Growth (`business-growth/`) — 7 skills

Skills com contexto 100% brasileiro (LGPD, CLT, PIX, NF-e, CAMARB).

| Skill | O que faz |
|-------|-----------|
| `customer-success-manager` | Health scoring, churn, expansão de conta |
| `account-manager` ✨ | Account Plan, QBR, renovação, upsell/cross-sell |
| `partnerships-manager` ✨ | Canais, resellers, SIs, marketplaces, MDF |
| `sales-engineer` | Análise de RFP, PoC, matrizes competitivas |
| `revenue-operations` | Pipeline, forecast, métricas GTM |
| `contract-and-proposal-writer` | Contratos e propostas — lei brasileira |

```
/read business-growth/contract-and-proposal-writer/SKILL.md
Preciso de um contrato de prestação de serviços de consultoria mensal, R$8k/mês, LGPD incluso.
```

---

### Project Management (`project-management/`) — 10 skills

| Skill | O que faz |
|-------|-----------|
| `senior-pm` | Gestão de projetos, riscos, stakeholders |
| `program-manager` ✨ | Programa multi-projeto, RAID log, steering committee |
| `scrum-master` | Scrum, velocity, retrospectivas, burndown |
| `jira-expert` | Automações e configurações avançadas do Jira |
| `confluence-expert` | Documentação e knowledge base no Confluence |
| `meeting-analyzer` | Análise e síntese de reuniões |

---

### Finance (`finance/`) — 6 skills

Métricas em R$, Simples Nacional, Receita Federal, PIX, NF-e, SPED.

| Skill | O que faz |
|-------|-----------|
| `controller-contador` ✨ | Contabilidade BR (NF-e, SPED, ECD, regimes tributários) |
| `fpa-analyst` ✨ | FP&A — budget, forecast, variance analysis, unit economics |
| `financial-analyst` | Índices financeiros, DCF, variação orçamentária |
| `saas-metrics-coach` | ARR, MRR, Churn, LTV, CAC — benchmarks do setor |
| `business-investment-advisor` | Análise de investimentos e valuation |

---

### RA/QM Team (`ra-qm-team/`) — 14 skills

Regulatório e qualidade com contexto Brasil (ANVISA, LGPD, ANPD).

| Skill | O que faz |
|-------|-----------|
| `gdpr-dsgvo-expert` | LGPD (Lei 13.709/18), GDPR, DPIA, direitos dos titulares |
| `fda-consultant-specialist` | ANVISA/FDA, registro de dispositivos médicos |
| `quality-manager-qms-iso13485` | QMS ISO 13485 para dispositivos médicos |
| `information-security-manager-iso27001` | ISMS ISO 27001 |
| `soc2-compliance` | SOC2 + LGPD para empresas SaaS |
| `risk-management-specialist` | Gestão de riscos ISO 14971 |
| `capa-officer` | CAPA, investigação de não-conformidades |
| E mais 7... | |

---

## Comandos Slash Disponíveis

Após instalação, disponíveis em qualquer projeto:

| Comando | O que faz |
|---------|-----------|
| `/prd` | Gera um Product Requirements Document completo |
| `/tdd` | Inicia workflow de Test-Driven Development |
| `/sprint-plan` | Planejamento de sprint com estimativas |
| `/saas-health` | Dashboard de métricas SaaS (ARR, MRR, Churn) |
| `/tech-debt` | Inventário e priorização de dívida técnica |
| `/okr` | Criação e revisão de OKRs |
| `/retro` | Facilitação de retrospectiva ágil |
| `/code-to-prd` | Gera PRD a partir de código existente |
| `/financial-health` | Análise de saúde financeira |
| `/user-story` | Geração de user stories com critérios de aceite |
| `/rice` | Priorização RICE de features |
| `/a11y-audit` | Auditoria de acessibilidade WCAG 2.2 |
| `/persona` | Geração de personas baseadas em dados |
| `/security-review` | Review de segurança de código |
| `/changelog` | Geração de changelog conventional commits |
| E mais 14 comandos... | |

---

## Contexto Brasileiro

Todas as skills foram adaptadas para o mercado brasileiro:

| Contexto | Skills Relevantes |
|----------|------------------|
| **LGPD** | `ra-qm-team/gdpr-dsgvo-expert`, `ra-qm-team/information-security-manager-iso27001` |
| **PIX** | `business-growth/revenue-operations`, `finance/financial-analyst` |
| **WhatsApp Business** | `skills-brasileiras/marketing`, `marketing-skill/social-media-manager` |
| **NF-e / Fiscal** | `finance/financial-analyst`, `business-growth/revenue-operations` |
| **CLT / PJ / MEI** | `c-level-advisor/chro-advisor`, `business-growth/contract-and-proposal-writer` |
| **ANVISA** | `ra-qm-team/fda-consultant-specialist`, `ra-qm-team/regulatory-affairs-head` |
| **Meta Ads BR** | `marketing-skill/paid-ads`, `skills-brasileiras/marketing` |
| **Métricas em R$** | `finance/saas-metrics-coach`, `business-growth/revenue-operations` |

---

## Instalação Manual

### Opção 1 — Download do ZIP

1. Baixe o arquivo `flowgrammers-claude-code-v2-brasil.zip`
2. Descompacte
3. Execute o instalador:
   ```bash
   cd flowgrammers-v2
   chmod +x install.sh
   ./install.sh
   ```

### Opção 2 — Clonar o repositório

```bash
git clone https://github.com/ricardonevesbraga/flowgrammers-skills.git
cd flowgrammers-skills
chmod +x install.sh
./install.sh
```

### Opção 3 — Instalação manual passo a passo

```bash
# 1. Criar diretório de skills
mkdir -p ~/.claude/flowgrammers-skills

# 2. Copiar todos os arquivos
cp -r . ~/.claude/flowgrammers-skills/

# 3. Instalar comandos slash
mkdir -p ~/.claude/commands
cp -r commands/* ~/.claude/commands/

# 4. Configurar CLAUDE.md global (opcional)
cat >> ~/.claude/CLAUDE.md << 'EOF'

## Flowgrammers Skills

Skills disponíveis em: ~/.claude/flowgrammers-skills/
Para usar: /read ~/.claude/flowgrammers-skills/[domínio]/[skill]/SKILL.md
EOF
```

---

## Requisitos

- **Claude Code** (CLI) instalado — `npm install -g @anthropic-ai/claude-code`
- macOS, Linux ou Windows (WSL2)
- Sem outras dependências

---

## Sobre

Skills criadas e adaptadas pela **Flowgrammers** para o mercado brasileiro.

- Site: [flowgrammers.com.br](https://flowgrammers.com.br)
- Autor: Ric Neves — Flowgrammers
- Versão: 2.1.0 ([changelog](CHANGELOG.md))
- Licença: [MIT](LICENSE)
- Repositório: [github.com/ricardonevesbraga/flowgrammers-skills](https://github.com/ricardonevesbraga/flowgrammers-skills)

## Contribuindo

Quer sugerir uma skill nova, corrigir algo, ou adicionar um perfil que falta? Veja [CONTRIBUTING.md](CONTRIBUTING.md).

## Apoie o projeto

Se as skills te pouparam tempo:

- ⭐ Dê uma estrela no GitHub — ajuda muito
- 🔁 Compartilhe com outros devs brasileiros
- 💬 Abra uma issue com feedback ou sugestão
- 🤝 Contribua com uma skill nova via PR
