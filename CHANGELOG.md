# Changelog

Todas as mudanças notáveis deste projeto estão documentadas aqui.

O formato segue [Keep a Changelog](https://keepachangelog.com/pt-BR/1.1.0/)
e o versionamento [Semantic Versioning](https://semver.org/lang/pt-BR/).

## [2.1.0] — 2026-04-23

### Adicionado — 12 novas skills cobrindo gaps estratégicos

**C-Level Advisor (+3)**
- `cdo-advisor` — Chief Data Officer (dados, governança, LGPD, monetização)
- `caio-advisor` — Chief AI Officer (estratégia de IA, responsible AI, ROI)
- `clo-advisor` — Chief Legal Officer / General Counsel (jurídico BR, M&A, LGPD)

**Engineering Team (+3)**
- `senior-mobile-ios` — Swift 6, SwiftUI, Xcode Cloud, App Store
- `senior-mobile-android` — Kotlin, Jetpack Compose, Play Store, KMP
- `senior-sre` — SLO, error budget, postmortems, chaos engineering

**Business Growth (+2)**
- `account-manager` — Account Plan, QBR, renovação, upsell/cross-sell
- `partnerships-manager` — Canais, resellers, SIs, marketplaces, MDF

**Finance (+2)**
- `controller-contador` — Contabilidade BR (NF-e, SPED, ECD, regimes tributários)
- `fpa-analyst` — Budget, forecast, variance analysis, unit economics, 3-statements

**Product Team (+1)**
- `growth-product-manager` — NSM, AARRR, growth loops, PLG, experimentação

**Project Management (+1)**
- `program-manager` — Programa multi-projeto, RAID log, steering committee

### Adicionado — Documentação institucional
- `SKILLS-portavel.html` — apresentação HTML com 14 slides cobrindo todas as skills (estilo cyberpunk neon, portável, responsivo, print-friendly)
- `LICENSE` — arquivo MIT formal na raiz
- `CONTRIBUTING.md` — guia de contribuição

### Corrigido
- Auditoria confirmou 100% das 251 skills em português do Brasil
- Frontmatter YAML padronizado em 240/241 arquivos (1 intencional: fixture do skill-tester)

## [2.0.0] — 2026-03-05

### Adicionado
- Catálogo inicial com 241 skills em 9 domínios
- Comandos slash em `commands/` (29 comandos)
- `install.sh` automatizado para `~/.claude/skills/` e `~/.claude/commands/`
- `MASTERCLASS-portavel.html` institucional

---

**Legenda:**
- `Adicionado` — funcionalidades novas
- `Alterado` — mudanças em funcionalidades existentes
- `Depreciado` — funcionalidades que serão removidas
- `Removido` — funcionalidades removidas
- `Corrigido` — bug fixes
- `Segurança` — correções relacionadas a segurança
