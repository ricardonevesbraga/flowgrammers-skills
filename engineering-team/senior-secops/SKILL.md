---
name: "senior-secops"
description: "Skill de engenheiro SecOps sênior para segurança de aplicações, gerenciamento de vulnerabilidades, verificação de conformidade e práticas de desenvolvimento seguro. Executa scans SAST/DAST, gera planos de remediação de CVEs, verifica vulnerabilidades de dependências, cria políticas de segurança, impõe padrões de codificação segura e automatiza verificações de conformidade contra SOC2, PCI-DSS, LGPD/ANVISA e LGPD. Use ao conduzir uma revisão ou auditoria de segurança, responder a um CVE ou incidente de segurança, fortalecer infraestrutura, implementar autenticação ou gerenciamento de segredos, preparar para testes de penetração, verificar exposição ao OWASP Top 10 ou impor controles de segurança em pipelines CI/CD."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Engenheiro SecOps Sênior

Kit completo para Operações de Segurança incluindo gerenciamento de vulnerabilidades, verificação de conformidade, práticas de codificação segura e automação de segurança.

---

## Sumário

- [Capacidades Principais](#core-capabilities)
- [Workflows](#workflows)
- [Referência de Ferramentas](#tool-referência)
- [Padrões de Segurança](#security-standards)
- [Frameworks de Conformidade](#compliance-frameworks)
- [Melhores Práticas](#melhores-práticas)

---

## Capacidades Principais

### 1. Scanner de Segurança

Escaneia código-fonte em busca de vulnerabilidades de segurança incluindo segredos hardcoded, SQL injection, XSS, injeção de comando e path traversal.

```bash
# Escanear projeto em busca de problemas de segurança
python scripts/security_scanner.py /path/to/project

# Filtrar por severidade
python scripts/security_scanner.py /path/to/project --severity high

# Saída JSON para CI/CD
python scripts/security_scanner.py /path/to/project --json --output report.json
```

**Detecta:**
- Segredos hardcoded (chaves de API, senhas, credenciais AWS, tokens GitHub, chaves privadas)
- Padrões de SQL injection (concatenação de string, f-strings, template literals)
- Vulnerabilidades XSS (atribuição de innerHTML, manipulação DOM insegura, padrões inseguros React)
- Injeção de comando (shell=True, exec, eval com entrada do usuário)
- Path traversal (operações de arquivo com entrada do usuário)

### 2. Avaliador de Vulnerabilidades

Escaneia dependências em busca de CVEs conhecidos nos ecossistemas npm, Python e Go.

```bash
# Avaliar dependências do projeto
python scripts/vulnerability_assessor.py /path/to/project

# Somente crítico/alto
python scripts/vulnerability_assessor.py /path/to/project --severity high

# Exportar relatório de vulnerabilidades
python scripts/vulnerability_assessor.py /path/to/project --json --output vulns.json
```

**Escaneia:**
- `package.json` e `package-lock.json` (npm)
- `requirements.txt` e `pyproject.toml` (Python)
- `go.mod` (Go)

**Saída:**
- IDs de CVE com scores CVSS
- Versões de pacotes afetados
- Versões corrigidas para remediação
- Score de risco geral (0-100)

### 3. Verificador de Conformidade

Verifica conformidade de segurança contra frameworks SOC 2, PCI-DSS, LGPD/ANVISA e LGPD.

```bash
# Verificar todos os frameworks
python scripts/compliance_checker.py /path/to/project

# Framework específico
python scripts/compliance_checker.py /path/to/project --framework soc2
python scripts/compliance_checker.py /path/to/project --framework pci-dss
python scripts/compliance_checker.py /path/to/project --framework hipaa
python scripts/compliance_checker.py /path/to/project --framework gdpr

# Exportar relatório de conformidade
python scripts/compliance_checker.py /path/to/project --json --output compliance.json
```

**Verifica:**
- Implementação de controle de acesso
- Criptografia em repouso e em trânsito
- Logging de auditoria
- Força de autenticação (MFA, hashing de senha)
- Documentação de segurança
- Controles de segurança CI/CD

---

## Workflows

### Workflow 1: Auditoria de Segurança

Avaliação de segurança completa de uma base de código.

```bash
# Passo 1: Escanear vulnerabilidades de código
python scripts/security_scanner.py . --severity medium
# PARE se código de saída 2 — resolva achados críticos antes de continuar
```

```bash
# Passo 2: Verificar vulnerabilidades de dependências
python scripts/vulnerability_assessor.py . --severity high
# PARE se código de saída 2 — corrija CVEs críticos antes de continuar
```

```bash
# Passo 3: Verificar controles de conformidade
python scripts/compliance_checker.py . --framework all
# PARE se código de saída 2 — resolva lacunas críticas antes de prosseguir
```

```bash
# Passo 4: Gerar relatórios combinados
python scripts/security_scanner.py . --json --output security.json
python scripts/vulnerability_assessor.py . --json --output vulns.json
python scripts/compliance_checker.py . --json --output compliance.json
```

### Workflow 2: Gate de Segurança CI/CD

Integre verificações de segurança no pipeline de implantação.

```yaml
# .github/workflows/security.yml
name: "security-scan"

on:
  pull_request:
    branches: [main, develop]

jobs:
  security-scan:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: "set-up-python"
        uses: actions/setup-python@v5
        with:
          python-version: '3.11'

      - name: "security-scanner"
        run: python scripts/security_scanner.py . --severity high

      - name: "vulnerability-assessment"
        run: python scripts/vulnerability_assessor.py . --severity critical

      - name: "compliance-check"
        run: python scripts/compliance_checker.py . --framework soc2
```

Cada passo falha o pipeline com seu respectivo código de saída — nenhuma implantação prossegue além de um achado crítico.

### Workflow 3: Triagem de CVE

Responda a um novo CVE que afeta sua aplicação.

```
1. AVALIAR (0-2 horas)
   - Identificar sistemas afetados usando vulnerability_assessor.py
   - Verificar se o CVE está sendo explorado ativamente
   - Determinar score CVSS ambiental para seu contexto
   - PARE se CVSS 9.0+ em sistema voltado para internet — escalar imediatamente

2. PRIORIZAR
   - Crítico (CVSS 9.0+, voltado para internet): 24 horas
   - Alto (CVSS 7.0-8.9): 7 dias
   - Médio (CVSS 4.0-6.9): 30 dias
   - Baixo (CVSS < 4.0): 90 dias

3. REMEDIAR
   - Atualizar dependência afetada para versão corrigida
   - Executar security_scanner.py para verificar correção (deve retornar código de saída 0)
   - PARE se scanner ainda sinalizar o CVE — não implantar
   - Testar regressões
   - Implantar com monitoramento aprimorado

4. VERIFICAR
   - Re-executar vulnerability_assessor.py
   - Confirmar que o CVE não é mais reportado
   - Documentar ações de remediação
```

### Workflow 4: Resposta a Incidentes

Procedimento de tratamento de incidentes de segurança.

```
FASE 1: DETECTAR E IDENTIFICAR (0-15 min)
- Alerta recebido e reconhecido
- Avaliação inicial de severidade (SEV-1 a SEV-4)
- Comandante de incidente designado
- Canal de comunicação estabelecido

FASE 2: CONTER (15-60 min)
- Sistemas afetados identificados
- Isolamento de rede se necessário
- Credenciais rotacionadas se comprometidas
- Preservar evidências (logs, dumps de memória)

FASE 3: ERRADICAR (1-4 horas)
- Causa raiz identificada
- Malware/backdoors removidos
- Vulnerabilidades corrigidas (executar security_scanner.py; deve retornar código de saída 0)
- Sistemas fortalecidos

FASE 4: RECUPERAR (4-24 horas)
- Sistemas restaurados de backup limpo
- Serviços reativados
- Monitoramento aprimorado habilitado
- Acesso de usuários restaurado

FASE 5: PÓS-INCIDENTE (24-72 horas)
- Timeline do incidente documentado
- Análise de causa raiz completa
- Lições aprendidas documentadas
- Medidas preventivas implementadas
- Relatório para stakeholders entregue
```

---

## Referência de Ferramentas

### security_scanner.py

| Opção | Descrição |
|--------|-------------|
| `target` | Diretório ou arquivo para escanear |
| `--severity, -s` | Severidade mínima: critical, high, medium, low |
| `--verbose, -v` | Mostrar arquivos enquanto são escaneados |
| `--json` | Saída de resultados em JSON |
| `--output, -o` | Escrever resultados em arquivo |

**Códigos de Saída:** `0` = sem achados críticos/altos · `1` = achados de alta severidade · `2` = achados de severidade crítica

### vulnerability_assessor.py

| Opção | Descrição |
|--------|-------------|
| `target` | Diretório contendo arquivos de dependência |
| `--severity, -s` | Severidade mínima: critical, high, medium, low |
| `--verbose, -v` | Mostrar arquivos enquanto são escaneados |
| `--json` | Saída de resultados em JSON |
| `--output, -o` | Escrever resultados em arquivo |

**Códigos de Saída:** `0` = sem vulnerabilidades críticas/altas · `1` = vulnerabilidades de alta severidade · `2` = vulnerabilidades de severidade crítica

### compliance_checker.py

| Opção | Descrição |
|--------|-------------|
| `target` | Diretório para verificar |
| `--framework, -f` | Framework: soc2, pci-dss, hipaa, gdpr, all |
| `--verbose, -v` | Mostrar verificações enquanto executam |
| `--json` | Saída de resultados em JSON |
| `--output, -o` | Escrever resultados em arquivo |

**Códigos de Saída:** `0` = em conformidade (score 90%+) · `1` = não conforme (score 50-69%) · `2` = lacunas críticas (score <50%)

---

## Padrões de Segurança

Veja `references/security_standards.md` para orientação completa do OWASP Top 10, padrões de codificação segura, requisitos de autenticação e controles de segurança de API.

### Checklist de Codificação Segura

```markdown
## Validação de Entrada
- [ ] Validar toda entrada no lado do servidor
- [ ] Usar allowlists em vez de denylists
- [ ] Sanitizar para contexto específico (HTML, SQL, shell)

## Codificação de Saída
- [ ] Codificar HTML para saída no browser
- [ ] Codificar URL para URLs
- [ ] Codificar JavaScript para contextos de script

## Autenticação
- [ ] Usar bcrypt/argon2 para senhas
- [ ] Implementar MFA para operações sensíveis
- [ ] Impor política de senha forte

## Gerenciamento de Sessão
- [ ] Gerar IDs de sessão aleatórios seguros
- [ ] Definir flags HttpOnly, Secure, SameSite
- [ ] Implementar timeout de sessão (15 min ocioso)

## Tratamento de Erros
- [ ] Registrar erros com contexto (sem segredos)
- [ ] Retornar mensagens genéricas para usuários
- [ ] Nunca expor stack traces em produção

## Gerenciamento de Segredos
- [ ] Usar variáveis de ambiente ou secrets manager
- [ ] Nunca commitar segredos no controle de versão
- [ ] Rotacionar credenciais regularmente
```

---

## Frameworks de Conformidade

Veja `references/compliance_requirements.md` para mapeamentos completos de controles. Execute `compliance_checker.py` para verificar os controles abaixo:

### SOC 2 Type II
- **CC6** Acesso Lógico: autenticação, autorização, MFA
- **CC7** Operações do Sistema: monitoramento, logging, resposta a incidentes
- **CC8** Gerenciamento de Mudanças: CI/CD, revisão de código, controles de implantação

### PCI-DSS v4.0
- **Req 3/4**: Criptografia em repouso e em trânsito (TLS 1.2+)
- **Req 6**: Desenvolvimento seguro (validação de entrada, codificação segura)
- **Req 8**: Autenticação forte (MFA, política de senha)
- **Req 10/11**: Logging de auditoria, SAST/DAST/testes de penetração

### LGPD/ANVISA Regra de Segurança
- IDs de usuário únicos e trilhas de auditoria para acesso a informações pessoais (164.312(a)(1), 164.312(b))
- MFA para autenticação de pessoa/entidade (164.312(d))
- Criptografia de transmissão via TLS (164.312(e)(1))

### LGPD
- **Art 25/32**: Privacidade por design, criptografia, pseudonimização
- **Art 33**: Notificação de violação em até 72 horas
- **Art 17/20**: Direito ao apagamento e portabilidade de dados

---

## Melhores Práticas

### Gerenciamento de Segredos

```python
# RUIM: Segredo hardcoded
API_KEY = "sk-1234567890abcdef"

# BOM: Variável de ambiente
import os
API_KEY = os.environ.get("API_KEY")

# MELHOR: Secrets manager
from your_vault_client import get_secret
API_KEY = get_secret("api/key")
```

### Prevenção de SQL Injection

```python
# RUIM: Concatenação de string
query = f"SELECT * FROM users WHERE id = {user_id}"

# BOM: Query parametrizada
cursor.execute("SELECT * FROM users WHERE id = %s", (user_id,))
```

### Prevenção de XSS

```javascript
// RUIM: Atribuição direta de innerHTML é vulnerável
// BOM: Use textContent (auto-escapado)
element.textContent = userInput;

// BOM: Use biblioteca de sanitização para HTML
import DOMPurify from 'dompurify';
const safeHTML = DOMPurify.sanitize(userInput);
```

### Autenticação

```javascript
// Hashing de senha
const bcrypt = require('bcrypt');
const SALT_ROUNDS = 12;

// Criar hash da senha
const hash = await bcrypt.hash(password, SALT_ROUNDS);

// Verificar senha
const match = await bcrypt.compare(password, hash);
```

### Cabeçalhos de Segurança

```javascript
// Cabeçalhos de segurança Express.js
const helmet = require('helmet');
app.use(helmet());

// Ou definir cabeçalhos manualmente:
app.use((req, res, next) => {
  res.setHeader('X-Content-Type-Options', 'nosniff');
  res.setHeader('X-Frame-Options', 'DENY');
  res.setHeader('X-XSS-Protection', '1; mode=block');
  res.setHeader('Strict-Transport-Security', 'max-age=31536000; includeSubDomains');
  res.setHeader('Content-Security-Policy', "default-src 'self'");
  next();
});
```

---

## Verificação Rápida OWASP Top 10

Avaliação rápida de 15 minutos — percorra cada categoria e note aprovado/reprovado. Para testes aprofundados, transfira para a skill **security-pen-testing**.

| # | Categoria | Verificação em Uma Linha |
|---|----------|----------------|
| A01 | Controle de Acesso Quebrado | Verificar checagens de papel em cada endpoint; testar escalação horizontal de privilégio |
| A02 | Falhas Criptográficas | Confirmar TLS 1.2+ em todo lugar; sem segredos em logs ou código-fonte |
| A03 | Injeção | Executar auditoria de query parametrizada; verificar uso de raw-query em ORM |
| A04 | Design Inseguro | Revisar se existe modelo de ameaça para fluxos críticos |
| A05 | Configuração Incorreta de Segurança | Verificar credenciais padrão removidas; páginas de erro genéricas |
| A06 | Componentes Vulneráveis | Executar `vulnerability_assessor.py`; zero CVEs críticos/altos |
| A07 | Falhas de Autenticação | Verificar MFA em admin; proteção contra brute-force ativa |
| A08 | Integridade de Software e Dados | Confirmar pipeline CI/CD assina artefatos; sem deps não assinadas |
| A09 | Logging e Monitoramento | Validar que logs de auditoria capturam eventos de auth; alertas configurados |
| A10 | SSRF | Testar filtros de URL interna; bloquear endpoints de metadados (169.254.169.254) |

> **Mergulho mais profundo necessário?** Transfira para `security-pen-testing` para cobertura completa do OWASP Testing Guide.

---

## Ferramentas de Escaneamento de Segredos

Escolha o scanner certo para cada etapa do seu workflow:

| Ferramenta | Melhor Para | Linguagem | Pre-commit | CI/CD | Regras Customizadas |
|------|----------|----------|:----------:|:-----:|:------------:|
| **gitleaks** | Pipelines CI, scans de repo completo | Go | Sim | Sim | Regexes TOML |
| **detect-secrets** | Hooks pre-commit, incremental | Python | Sim | Parcial | Plugin-based |
| **truffleHog** | Scans históricos profundos, entropia | Go | Não | Sim | Regex + entropia |

**Configuração recomendada:** Use `detect-secrets` como hook pre-commit (captura segredos antes de entrar no histórico) e `gitleaks` no CI (captura o que escapar).

```bash
# Hook pre-commit detect-secrets (.pre-commit-config.yaml)
- repo: https://github.com/Yelp/detect-secrets
  rev: v1.4.0
  hooks:
    - id: detect-secrets
      args: ['--baseline', '.secrets.baseline']

# gitleaks no GitHub Actions
- name: gitleaks
  uses: gitleaks/gitleaks-action@v2
  env:
    GITLEAKS_LICENSE: ${{ secrets.GITLEAKS_LICENSE }}
```

---

## Segurança da Cadeia de Suprimentos

Proteja contra adulteração de dependências e artefatos com geração de SBOM, assinatura de artefatos e conformidade SLSA.

**Geração de SBOM:**
- **syft** — gera SBOMs de imagens de container ou diretórios de origem (formatos SPDX, CycloneDX)
- **cyclonedx-cli** — ferramentas nativas CycloneDX; mesclar múltiplos SBOMs para mono-repos

```bash
# Gerar SBOM de imagem de container
syft packages ghcr.io/org/app:latest -o cyclonedx-json > sbom.json
```

**Assinatura de Artefatos (Sigstore/cosign):**
```bash
# Assinar uma imagem de container (keyless via OIDC)
cosign sign ghcr.io/org/app:latest
# Verificar assinatura
cosign verify ghcr.io/org/app:latest --certificate-identity=ci@org.com --certificate-oidc-issuer=https://token.actions.githubusercontent.com
```

**Visão Geral dos Níveis SLSA:**
| Nível | Requisito | O que Prova |
|-------|-------------|----------------|
| 1 | Processo de build documentado | Proveniência existe |
| 2 | Serviço de build hospedado, proveniência assinada | Proveniência resistente a adulteração |
| 3 | Plataforma de build fortalecida, proveniência não falsificável | Build à prova de adulteração |
| 4 | Revisão de dois lados, builds herméticos | Máxima garantia da cadeia de suprimentos |

> **Cross-references:** `security-pen-testing` (testes de exploração de vulnerabilidades), `dependency-auditor` (auditoria de licença e CVE para dependências).

---

## Documentação de Referência

| Documento | Descrição |
|----------|-------------|
| `references/security_standards.md` | OWASP Top 10, codificação segura, autenticação, segurança de API |
| `references/vulnerability_management_guide.md` | Triagem de CVE, scoring CVSS, workflows de remediação |
| `references/compliance_requirements.md` | Mapeamentos completos de controles SOC 2, PCI-DSS, LGPD/ANVISA, LGPD |
