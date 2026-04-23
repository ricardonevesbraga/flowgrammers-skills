# Flowgrammers Claude Code Skills 

> **Biblioteca oficial de skills da Flowgrammers para Claude Code**
> Autor: Ric Neves - Flowgrammers
> 239+ skills prontas para produção | Contexto 100% brasileiro | Apenas Claude Code

---

## Como Usar

### Carregar uma skill
```
/read c-level-advisor/ceo-advisor/SKILL.md
```

### Pedir ao Claude para usar uma skill
```
Use a skill de CEO Advisor e me ajude a preparar minha apresentação para investidores.
Atue como Senior Frontend e revise meu componente React.
Como especialista em SEO, analise meu site para o mercado brasileiro.
```

### Comandos slash (após instalar em ~/.claude/commands/)
```
/tdd    /prd    /sprint-plan    /saas-health    /tech-debt
```

---

## Skills Brasileiras (Exclusivas)

### Skills de Copy e Conteúdo (`skills-brasileiras/copy-e-conteudo/`)
42 skills de copy otimizadas para o mercado brasileiro:
- Headlines com framework AIDA
- Hooks para Reels e TikTok
- Linhas de assunto para email
- Copy para WhatsApp
- Títulos para YouTube (CTR alto)
- Copy para Instagram Stories
- E mais 36 skills...

### Skills de Marketing (`skills-brasileiras/marketing/`)
30 skills de marketing focadas no Brasil:
- Script de venda por WhatsApp
- Funil de vendas completo
- Estratégia de tráfego pago (Meta Ads, Google Ads)
- Proposta comercial B2B
- Mapeamento de jornada do cliente
- E mais 25 skills...

---

## Mapa Completo de Skills

### C-Level Advisory (`c-level-advisor/`) — 34 skills
CEO, CTO, CFO, COO, CPO, CMO, CRO, CISO, CHRO, Executive Mentor
Chief of Staff (roteador automático), Board Meeting, Decision Logger

**Como usar:**
```
/read c-level-advisor/chief-of-staff/SKILL.md
Tenho uma decisão estratégica: devo abrir capital ou buscar investidor PE?
```

### Engineering Avançado (`engineering/`) — 45 skills
RAG, MCP Server Builder, CI/CD, Observabilidade, Database Designer, PR Review

### Engineering Team (`engineering-team/`) — 37 skills
Senior Frontend (React/Next.js), Senior Backend, Senior DevOps, Senior QA
Playwright Pro, TDD Guide, Code Reviewer, AWS/GCP/Azure Architect

### Marketing (`marketing-skill/`) — 44 skills
SEO (tradicional + AI SEO), CRO, Email Marketing, Paid Ads, Growth
Content Strategy, Analytics, Competitor Analysis

### Product Team (`product-team/`) — 16 skills
Product Manager (RICE), Agile PO, UX Researcher, UI Design System
Competitive Teardown, Landing Page Generator, SaaS Scaffolder

### Business Growth (`business-growth/`) — 5 skills
Customer Success Manager, Sales Engineer, Revenue Operations
Contract & Proposal Writer

### Project Management (`project-management/`) — 9 skills
Senior PM, Scrum Master, Jira Expert, Confluence Expert

### Finance (`finance/`) — 4 skills
Financial Analyst (DCF), SaaS Metrics Coach (ARR/MRR/CAC/LTV), Business Investment Advisor

### RA/QM Team (`ra-qm-team/`) — 14 skills
ISO 13485, LGPD, ANVISA/FDA, ISO 27001, SOC2, Gestão de Riscos, CAPA

---

## Contexto Brasileiro nas Skills

Todas as skills foram adaptadas para o contexto brasileiro:

| Contexto | Skills Relevantes |
|----------|------------------|
| **LGPD** | ra-qm-team/gdpr-dsgvo-expert, ra-qm-team/information-security-manager-iso27001 |
| **PIX** | business-growth/revenue-operations, finance/financial-analyst |
| **WhatsApp Business** | skills-brasileiras/marketing, marketing-skill/email-sequence |
| **NF-e / Fiscal** | finance/financial-analyst, business-growth/revenue-operations |
| **CLT / PJ / MEI** | c-level-advisor/chro-advisor, business-growth/contract-and-proposal-writer |
| **ANVISA** | ra-qm-team/fda-consultant-specialist, ra-qm-team/regulatory-affairs-head |
| **Meta Ads BR** | marketing-skill/paid-ads, skills-brasileiras/marketing |
| **Métricas em R$** | finance/saas-metrics-coach, business-growth/revenue-operations |

---

## Instalação dos Comandos Slash

```bash
mkdir -p ~/.claude/commands
cp -r commands/* ~/.claude/commands/
```

---

## Sobre

Skills criadas e adaptadas pela **Flowgrammers** para o mercado brasileiro.
- Site: flowgrammers.com
- Autor: Ric Neves - Flowgrammers
- Versão: 2.0.0 
