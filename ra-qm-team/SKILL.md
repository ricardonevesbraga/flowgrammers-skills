---
name: "ra-qm-skills"
description: "12 skills e plugins de agentes para Assuntos Regulatórios e Gestão da Qualidade no Claude Code. Cobre ISO 13485 QMS, MDR 2017/745, FDA 510(k)/PMA, ISO 27001 ISMS, LGPD/DSGVO, gestão de riscos (ISO 14971), CAPA, controle de documentos e auditoria — para o mercado brasileiro e internacional. Python tools (somente stdlib)."
version: 1.0.0
author: Ric Neves - Flowgrammers
license: MIT
tags:
  - regulatory
  - quality-management
  - iso-13485
  - mdr
  - fda
  - iso-27001
  - gdpr
agents:
  - claude-code
---

# Skills de Assuntos Regulatórios & Gestão da Qualidade

12 skills de conformidade prontas para produção em organizações HealthTech e MedTech.

## Início Rápido

### Claude Code
```
/read ra-qm-team/regulatory-affairs-head/SKILL.md
```

## Visão Geral das Skills

| Skill | Pasta | Foco |
|-------|--------|-------|
| Regulatory Affairs Head | `regulatory-affairs-head/` | Estratégia FDA/MDR, submissões |
| Quality Manager (QMR) | `quality-manager-qmr/` | Governança do QMS, revisão gerencial |
| Quality Manager (ISO 13485) | `quality-manager-qms-iso13485/` | Implementação do QMS, controle de documentos |
| Risk Management Specialist | `risk-management-specialist/` | ISO 14971, FMEA, arquivos de risco |
| CAPA Officer | `capa-officer/` | Análise de causa raiz, ações corretivas |
| Quality Documentation Manager | `quality-documentation-manager/` | Controle de documentos, 21 CFR Part 11 |
| QMS Audit Expert | `qms-audit-expert/` | Auditorias internas ISO 13485 |
| ISMS Audit Expert | `isms-audit-expert/` | Auditoria de segurança ISO 27001 |
| Information Security Manager | `information-security-manager-iso27001/` | Implementação do ISMS |
| MDR 745 Specialist | `mdr-745-specialist/` | Classificação EU MDR, marcação CE |
| FDA Consultant | `fda-consultant-specialist/` | 510(k), PMA, conformidade QSR |
| LGPD/GDPR/DSGVO Expert | `gdpr-dsgvo-expert/` | Conformidade de privacidade, DPIA |

## Python Tools

17 scripts, todos somente stdlib:

```bash
python3 risk-management-specialist/scripts/risk_matrix_calculator.py --help
python3 gdpr-dsgvo-expert/scripts/gdpr_compliance_checker.py --help
```

## Regras

- Carregue apenas o SKILL.md da skill específica que você precisa
- Sempre verifique os resultados de conformidade em relação às regulamentações vigentes
