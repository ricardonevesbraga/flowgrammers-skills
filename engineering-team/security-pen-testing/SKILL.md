---
name: "security-pen-testing"
description: "Use quando o usuário pedir para realizar auditorias de segurança, testes de penetração, varredura de vulnerabilidades, verificações OWASP Top 10 ou avaliações de segurança ofensiva. Cobre análise estática, varredura de dependências, detecção de segredos, testes de segurança de API e geração de relatórios de pen test."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Teste de Penetração de Segurança

Skill de testes de segurança ofensivos para encontrar vulnerabilidades antes que os atacantes o façam. Isso NÃO é verificação de conformidade (veja senior-secops) ou redação de políticas de segurança (veja senior-security) — trata-se de descoberta sistemática de vulnerabilidades por meio de testes autorizados.

---

## Sumário

- [Visão Geral](#visão-geral)
- [Auditoria Sistemática OWASP Top 10](#auditoria-sistemática-owasp-top-10)
- [Análise Estática](#análise-estática)
- [Varredura de Vulnerabilidades em Dependências](#varredura-de-vulnerabilidades-em-dependências)
- [Varredura de Segredos](#varredura-de-segredos)
- [Testes de Segurança de API](#testes-de-segurança-de-api)
- [Testes de Vulnerabilidades Web](#testes-de-vulnerabilidades-web)
- [Segurança de Infraestrutura](#segurança-de-infraestrutura)
- [Geração de Relatório de Pen Test](#geração-de-relatório-de-pen-test)
- [Fluxo de Trabalho de Divulgação Responsável](#fluxo-de-trabalho-de-divulgação-responsável)
- [Fluxos de Trabalho](#fluxos-de-trabalho)
- [Anti-Padrões](#anti-padrões)
- [Referências Cruzadas](#referências-cruzadas)

---

## Visão Geral

### O que esta Skill Faz

Esta skill fornece a metodologia, checklists e automação para **testes de segurança ofensivos** — sondagem ativa de sistemas para descobrir vulnerabilidades exploráveis. Cobre aplicações web, APIs, infraestrutura e segurança da cadeia de suprimentos.

### Distinção de Outras Skills de Segurança

| Skill | Foco | Abordagem |
|-------|-------|----------|
| **security-pen-testing** (esta) | Encontrar vulnerabilidades | Ofensiva — simular técnicas de atacante |
| senior-secops | Operações de segurança | Defensiva — monitoramento, resposta a incidentes, SIEM |
| senior-security | Política de segurança | Governança — políticas, frameworks, registro de riscos |
| skill-security-auditor | Gates de CI/CD | Automatizada — verificações de segurança pré-merge |

### Pré-requisitos

Todos os testes descritos aqui pressupõem **autorização por escrito** do proprietário do sistema. Testes não autorizados são ilegais sob o CFAA e legislações equivalentes em todo o mundo. Sempre obtenha um documento de escopo de trabalho ou regras de engajamento assinado antes de começar.

---

## Auditoria Sistemática OWASP Top 10

Use a ferramenta de varredura de vulnerabilidades para geração automatizada de checklist:

```bash
# Gerar checklist OWASP para uma aplicação web
python scripts/vulnerability_scanner.py --target web --scope full

# Varredura rápida focada em API
python scripts/vulnerability_scanner.py --target api --scope quick --json
```

### Referência Rápida

| # | Categoria | Testes Principais |
|---|----------|-----------|
| A01 | Controle de Acesso Quebrado | IDOR, escalonamento vertical, CORS, manipulação de claims JWT, navegação forçada |
| A02 | Falhas Criptográficas | Versão TLS, hash de senha, chaves hardcoded, PRNG fraco |
| A03 | Injeção | SQLi, NoSQLi, injeção de comando, injeção de template, XSS |
| A04 | Design Inseguro | Limitação de taxa, abuso de lógica de negócio, bypass de fluxo multi-etapas |
| A05 | Configuração Incorreta de Segurança | Credenciais padrão, modo debug, cabeçalhos de segurança, listagem de diretórios |
| A06 | Componentes Vulneráveis | Auditoria de dependências (npm/pip/go), verificações de EOL, CVEs conhecidos |
| A07 | Falhas de Autenticação | Força bruta, flags de cookie de sessão, invalidação de sessão, bypass de MFA |
| A08 | Falhas de Integridade | Desserialização insegura, verificações SRI, integridade do pipeline CI/CD |
| A09 | Falhas de Logging | Log de eventos de autenticação, dados sensíveis em logs, limiares de alertas |
| A10 | SSRF | Acesso a IPs internos, endpoints de metadados cloud, rebinding DNS |

```bash
# Auditar dependências
python scripts/dependency_auditor.py --file package.json --severity high
python scripts/dependency_auditor.py --file requirements.txt --json
```

Veja [owasp_top_10_checklist.md](references/owasp_top_10_checklist.md) para procedimentos detalhados de teste, padrões de código a detectar, etapas de remediação e orientação de pontuação CVSS para cada categoria.

---

## Análise Estática

**Ferramentas recomendadas:** CodeQL (consultas personalizadas para padrões específicos do projeto), Semgrep (varredura baseada em regras com correção automática), plugins de segurança ESLint (`eslint-plugin-security`, `eslint-plugin-no-unsanitized`).

Padrões principais a detectar: injeção SQL via concatenação de strings, segredos JWT hardcoded, desserialização insegura de YAML, middleware de segurança ausente (ex.: Express sem Helmet).

Veja [attack_patterns.md](references/attack_patterns.md) para padrões de código e payloads de detecção em tipos de injeção.

---

## Varredura de Vulnerabilidades em Dependências

**Comandos por ecossistema:** `npm audit`, `pip audit`, `govulncheck ./...`, `bundle audit check`

**Fluxo de Trabalho de Triagem de CVE:**
1. **Coletar** — Executar ferramentas de auditoria por ecossistema, agregar achados
2. **Deduplicar** — Agrupar por ID CVE em dependências diretas e transitivas
3. **Priorizar** — Crítico + explorável + alcançável = corrigir imediatamente
4. **Remediar** — Atualizar, aplicar patch ou mitigar com controles compensatórios
5. **Verificar** — Reexecutar auditoria para confirmar correção, atualizar arquivos de lock

```bash
python scripts/dependency_auditor.py --file package.json --severity critical --json
```

---

## Varredura de Segredos

**Ferramentas:** TruffleHog (histórico git + sistema de arquivos), Gitleaks (baseado em regex com regras personalizadas).

```bash
# Varrer histórico git por segredos verificados
trufflehog git file://. --only-verified --json

# Varrer sistema de arquivos
trufflehog filesystem . --json
```

**Pontos de integração:** Hooks de pré-commit (gitleaks, trufflehog), gates de CI/CD (GitHub Actions com `trufflesecurity/trufflehog@main`). Configurar `.gitleaks.toml` para regras personalizadas (chaves AWS, chaves de API, cabeçalhos de chave privada) e listas de permissão para fixtures de teste.

---

## Testes de Segurança de API

### Bypass de Autenticação

- **Manipulação JWT:** Alterar `alg` para `none`, confusão RS256-para-HS256, modificação de claims (`role: "admin"`, `exp: 9999999999`)
- **Fixação de sessão:** Verificar se o ID de sessão muda após autenticação

### Falhas de Autorização

- **IDOR/BOLA:** Alterar IDs de recursos em todos os endpoints — testar leitura, atualização, exclusão entre usuários
- **BFLA:** Usuário regular tenta endpoints de admin (esperar 403)
- **Atribuição em massa:** Adicionar campos privilegiados (`role`, `is_admin`) a requisições de atualização

### Limitação de Taxa e GraphQL

- **Limitação de taxa:** Requisições rápidas para endpoints de autenticação; esperar 429 após o limite
- **GraphQL:** Testar introspecção (deve estar desabilitada em produção), ataques de profundidade de consulta, mutações em lote contornando limites de taxa

Veja [attack_patterns.md](references/attack_patterns.md) para payloads completos de manipulação JWT, metodologia de teste IDOR, listas de endpoints BFLA, padrões de introspecção/profundidade/batch GraphQL e técnicas de bypass de limitação de taxa.

---

## Testes de Vulnerabilidades Web

| Vulnerabilidade | Testes Principais |
|--------------|-----------|
| **XSS** | Refletido (payloads script/img/svg), Armazenado (campos persistentes), DOM-based (innerHTML + location.hash) |
| **CSRF** | Repetir sem token (esperar 403), repetição de token entre sessões, verificar atributo SameSite do cookie |
| **Injeção SQL** | Baseado em erro (`' OR 1=1--`), enumeração por union, baseado em tempo (`SLEEP(5)`), baseado em booleano |
| **SSRF** | IPs internos, endpoints de metadados cloud (AWS/GCP/Azure), bypasses via IPv6/hex/decimal |
| **Traversal de Caminho** | `../../../etc/passwd`, codificação URL, bypasses com dupla codificação |

Veja [attack_patterns.md](references/attack_patterns.md) para payloads completos de teste (bypasses de filtros XSS, XSS específico por contexto, injeção SQL por engine de banco de dados, técnicas de bypass SSRF e pares source/sink de XSS DOM-based).

---

## Segurança de Infraestrutura

**Verificações principais:**
- **Armazenamento cloud:** Acesso público a buckets S3 (`aws s3 ls s3://bucket --no-sign-request`), políticas de bucket, ACLs
- **Cabeçalhos de segurança HTTP:** HSTS, CSP (sem `unsafe-inline`/`unsafe-eval`), X-Content-Type-Options, X-Frame-Options, Referrer-Policy
- **Configuração TLS:** `nmap --script ssl-enum-ciphers -p 443 target.com` ou `testssl.sh` — rejeitar TLS 1.0/1.1, RC4, 3DES, cifras de exportação
- **Varredura de portas:** `nmap -sV target.com` — sinalizar portas abertas perigosas (FTP/21, Telnet/23, Redis/6379, MongoDB/27017)

---

## Geração de Relatório de Pen Test

Gerar relatórios profissionais a partir de achados estruturados:

```bash
# Gerar relatório markdown a partir do JSON de achados
python scripts/pentest_report_generator.py --findings findings.json --format md --output report.md

# Gerar relatório JSON
python scripts/pentest_report_generator.py --findings findings.json --format json --output report.json
```

### Formato do JSON de Achados

```json
[
  {
    "title": "SQL Injection in Login Endpoint",
    "severity": "critical",
    "cvss_score": 9.8,
    "cvss_vector": "CVSS:3.1/AV:N/AC:L/PR:N/UI:N/S:U/C:H/I:H/A:H",
    "category": "A03:2021 - Injection",
    "description": "The /api/login endpoint is vulnerable to SQL injection via the email parameter.",
    "evidence": "Request: POST /api/login — Response: 200 OK with admin session token",
    "impact": "Full database access, authentication bypass, potential remote code execution",
    "remediation": "Use parameterized queries. Replace string concatenation with prepared statements.",
    "references": ["https://cwe.mitre.org/data/definitions/89.html"]
  }
]
```

### Estrutura do Relatório

1. **Resumo Executivo**: Impacto no negócio, nível geral de risco, top 3 achados
2. **Escopo**: O que foi testado, o que foi excluído, datas dos testes
3. **Metodologia**: Ferramentas utilizadas, abordagem de teste (caixa preta/cinza/branca)
4. **Tabela de Achados**: Ordenada por severidade com pontuações CVSS
5. **Achados Detalhados**: Cada um com descrição, evidência, impacto, remediação
6. **Matriz de Prioridade de Remediação**: Esforço vs. impacto para cada correção
7. **Apêndice**: Saída bruta das ferramentas, listas completas de payloads

---

## Fluxo de Trabalho de Divulgação Responsável

A divulgação responsável é **obrigatória** para qualquer vulnerabilidade encontrada durante testes autorizados. Cronograma padrão: reportar no dia 1, acompanhar no dia 7, atualização de status no dia 30, divulgação pública no dia 90.

**Princípios principais:** Nunca explorar além de prova de conceito, criptografar todas as comunicações, não acessar dados reais de usuários, documentar tudo com timestamps.

Veja [responsible_disclosure.md](references/responsible_disclosure.md) para cronogramas completos de divulgação (padrão 90 dias, acelerado 30 dias, estendido 120 dias), modelos de comunicação, considerações legais, integração com programas de bug bounty e processo de solicitação de CVE.

---

## Fluxos de Trabalho

### Fluxo de Trabalho 1: Verificação Rápida de Segurança (15 Minutos)

Para revisões pré-merge ou verificações rápidas de saúde:

```bash
# 1. Gerar checklist OWASP
python scripts/vulnerability_scanner.py --target web --scope quick

# 2. Varrer dependências
python scripts/dependency_auditor.py --file package.json --severity high

# 3. Verificar segredos em commits recentes
# (Use gitleaks ou trufflehog conforme descrito na seção Varredura de Segredos)

# 4. Revisar cabeçalhos de segurança HTTP
curl -sI https://target.com | grep -iE "(strict-transport|content-security|x-frame|x-content-type)"
```

**Decisão**: Se houver achados críticos ou altos, bloquear o merge.

### Fluxo de Trabalho 2: Teste de Penetração Completo (Avaliação Multi-Dias)

**Dia 1 — Reconhecimento:**
1. Mapear a superfície de ataque: endpoints, fluxos de autenticação, integrações de terceiros
2. Executar checklist OWASP automatizado (escopo completo)
3. Executar auditoria de dependências em todos os manifestos
4. Executar varredura de segredos em todo o histórico git

**Dia 2 — Testes Manuais:**
1. Testar autenticação e autorização (IDOR, BOLA, BFLA)
2. Testar pontos de injeção (SQLi, XSS, SSRF, injeção de comando)
3. Testar falhas de lógica de negócio
4. Testar vulnerabilidades específicas de API (GraphQL, limitação de taxa, atribuição em massa)

**Dia 3 — Infraestrutura e Relatório:**
1. Verificar permissões de armazenamento cloud
2. Verificar configuração TLS e cabeçalhos de segurança
3. Varredura de portas para serviços desnecessários
4. Compilar achados em JSON estruturado
5. Gerar relatório de pen test

```bash
# Gerar relatório final
python scripts/pentest_report_generator.py --findings findings.json --format md --output pentest-report.md
```

### Fluxo de Trabalho 3: Gate de Segurança CI/CD

Verificações de segurança automatizadas em cada PR: varredura de segredos (TruffleHog), auditoria de dependências (`npm audit`, `pip audit`), SAST (Semgrep com `p/security-audit`, `p/owasp-top-ten`) e verificação de cabeçalhos de segurança em staging.

**Política de Gate**: Bloquear merge em achados críticos/altos. Avisar em médios. Registrar baixos/info.

---

## Anti-Padrões

1. **Testar em produção sem autorização** — Sempre obtenha permissão por escrito e use ambientes de staging/teste quando possível
2. **Ignorar achados de baixa severidade** — Achados baixos se acumulam; uma cadeia de baixos pode se tornar um caminho de exploração crítico
3. **Pular a divulgação responsável** — Toda vulnerabilidade encontrada deve ser reportada pelos canais adequados
4. **Depender exclusivamente de ferramentas automatizadas** — Ferramentas perdem falhas de lógica de negócio, exploits encadeados e vetores de ataque novos
5. **Testar sem escopo definido** — O escopo sem limites leva a responsabilidade legal; documente o que está e o que não está no escopo
6. **Reportar sem orientação de remediação** — Todo achado deve incluir etapas de remediação acionáveis
7. **Armazenar evidências de forma insegura** — Evidências de pen test (capturas de tela, payloads, tokens) são sensíveis; criptografe e restrinja o acesso
8. **Testes pontuais** — Testes de segurança devem ser contínuos; integre ao CI/CD e agende avaliações periódicas

---

## Referências Cruzadas

| Skill | Relação |
|-------|-------------|
| [senior-secops](../senior-secops/SKILL.md) | Operações defensivas de segurança — monitoramento, resposta a incidentes, configuração de SIEM |
| [senior-security](../senior-security/SKILL.md) | Política e governança de segurança — frameworks, registro de riscos, conformidade |
| [dependency-auditor](../../engineering/dependency-auditor/SKILL.md) | Segurança profunda da cadeia de suprimentos — SBOMs, conformidade de licenças, risco transitivo |
| [code-reviewer](../code-reviewer/SKILL.md) | Práticas de revisão de código — inclui checklist de revisão de segurança |
