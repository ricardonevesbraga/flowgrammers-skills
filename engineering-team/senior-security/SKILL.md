---
name: "senior-security"
description: "Kit de engenharia de segurança para modelagem de ameaças, análise de vulnerabilidades, arquitetura segura e testes de penetração. Inclui análise STRIDE, orientação OWASP, padrões de criptografia e ferramentas de escaneamento de segurança. Use quando o usuário perguntar sobre revisões de segurança, análise de ameaças, avaliações de vulnerabilidades, práticas de codificação segura, auditorias de segurança, análise de superfície de ataque, remediação de CVE ou melhores práticas de segurança."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Engenheiro de Segurança Sênior

Ferramentas de engenharia de segurança para modelagem de ameaças, análise de vulnerabilidades, design de arquitetura segura e testes de penetração.

---

## Sumário

- [Workflow de Modelagem de Ameaças](#threat-modeling-workflow)
- [Workflow de Arquitetura de Segurança](#security-architecture-workflow)
- [Workflow de Avaliação de Vulnerabilidades](#vulnerability-assessment-workflow)
- [Workflow de Revisão de Código Seguro](#secure-code-review-workflow)
- [Workflow de Resposta a Incidentes](#incident-response-workflow)
- [Referência de Ferramentas de Segurança](#security-tools-referência)
- [Ferramentas e Referências](#ferramentas-e-referências)

---

## Workflow de Modelagem de Ameaças

Identifique e analise ameaças de segurança usando a metodologia STRIDE.

### Workflow: Conduzir Modelagem de Ameaças

1. Definir escopo e limites do sistema:
   - Identificar ativos a proteger
   - Mapear limites de confiança
   - Documentar fluxos de dados
2. Criar diagrama de fluxo de dados:
   - Entidades externas (usuários, serviços)
   - Processos (componentes da aplicação)
   - Armazenamentos de dados (bancos de dados, caches)
   - Fluxos de dados (APIs, conexões de rede)
3. Aplicar STRIDE a cada elemento do DFD (veja [Matriz STRIDE por Elemento](#stride-per-element-matrix) abaixo)
4. Pontuar riscos usando DREAD:
   - Potencial de dano (1-10)
   - Reprodutibilidade (1-10)
   - Explorabilidade (1-10)
   - Usuários afetados (1-10)
   - Descobribilidade (1-10)
5. Priorizar ameaças por score de risco
6. Definir mitigações para cada ameaça
7. Documentar no relatório de modelagem de ameaças
8. **Validação:** Todos os elementos do DFD analisados; STRIDE aplicado; ameaças pontuadas; mitigações mapeadas

### Categorias de Ameaças STRIDE

| Categoria | Propriedade de Segurança | Foco de Mitigação |
|----------|-------------------|------------------|
| Spoofing | Autenticação | MFA, certificados, auth forte |
| Tampering | Integridade | Assinatura, checksums, validação |
| Repudiation | Não-repúdio | Logs de auditoria, assinaturas digitais |
| Information Disclosure | Confidencialidade | Criptografia, controles de acesso |
| Denial of Service | Disponibilidade | Rate limiting, redundância |
| Elevation of Privilege | Autorização | RBAC, princípio do menor privilégio |

### Matriz STRIDE por Elemento

| Elemento DFD | S | T | R | I | D | E |
|-------------|---|---|---|---|---|---|
| Entidade Externa | X | | X | | | |
| Processo | X | X | X | X | X | X |
| Armazenamento de Dados | | X | X | X | X | |
| Fluxo de Dados | | X | | X | X | |

Veja: [references/threat-modeling-guide.md](references/threat-modeling-guide.md)

---

## Workflow de Arquitetura de Segurança

Projete sistemas seguros usando princípios de defesa em profundidade.

### Workflow: Projetar Arquitetura Segura

1. Definir requisitos de segurança:
   - Requisitos de conformidade (LGPD, LGPD/ANVISA, PCI-DSS)
   - Classificação de dados (público, interno, confidencial, restrito)
   - Entradas do modelo de ameaças
2. Aplicar camadas de defesa em profundidade:
   - Perímetro: WAF, proteção DDoS, rate limiting
   - Rede: Segmentação, IDS/IPS, mTLS
   - Host: Patching, EDR, hardening
   - Aplicação: Validação de entrada, autenticação, codificação segura
   - Dados: Criptografia em repouso e em trânsito
3. Implementar princípios Zero Trust:
   - Verificar explicitamente (cada requisição)
   - Acesso com menor privilégio (JIT/JEA)
   - Assumir violação (segmentar, monitorar)
4. Configurar autenticação e autorização:
   - Seleção de provedor de identidade
   - Requisitos de MFA
   - Modelo RBAC/ABAC
5. Projetar estratégia de criptografia:
   - Abordagem de gerenciamento de chaves
   - Seleção de algoritmo
   - Ciclo de vida de certificados
6. Planejar monitoramento de segurança:
   - Agregação de logs
   - Integração SIEM
   - Regras de alerta
7. Documentar decisões de arquitetura
8. **Validação:** Camadas de defesa em profundidade definidas; Zero Trust aplicado; estratégia de criptografia documentada; monitoramento planejado

### Camadas de Defesa em Profundidade

```
Camada 1: PERÍMETRO
  WAF, mitigação DDoS, filtragem DNS, rate limiting

Camada 2: REDE
  Segmentação, IDS/IPS, monitoramento de rede, VPN, mTLS

Camada 3: HOST
  Proteção de endpoint, hardening de SO, patching, logging

Camada 4: APLICAÇÃO
  Validação de entrada, autenticação, codificação segura, SAST

Camada 5: DADOS
  Criptografia em repouso/trânsito, controles de acesso, DLP, backup
```

### Seleção de Padrão de Autenticação

| Caso de Uso | Padrão Recomendado |
|----------|---------------------|
| Aplicação web | OAuth 2.0 + PKCE com OIDC |
| Autenticação de API | JWT com expiração curta + refresh tokens |
| Serviço para serviço | mTLS com rotação de certificado |
| CLI/Automação | Chaves de API com allowlisting de IP |
| Alta segurança | Chaves hardware FIDO2/WebAuthn |

Veja: [references/security-architecture-patterns.md](references/security-architecture-patterns.md)

---

## Workflow de Avaliação de Vulnerabilidades

Identifique e remedie vulnerabilidades de segurança em aplicações.

### Workflow: Conduzir Avaliação de Vulnerabilidades

1. Definir escopo da avaliação:
   - Sistemas e aplicações em escopo
   - Metodologia de teste (caixa preta, caixa cinza, caixa branca)
   - Regras de engajamento
2. Coletar informações:
   - Inventário de stack tecnológico
   - Documentação de arquitetura
   - Relatórios anteriores de vulnerabilidades
3. Realizar escaneamento automatizado:
   - SAST (análise estática)
   - DAST (análise dinâmica)
   - Escaneamento de dependências
   - Detecção de segredos
4. Conduzir testes manuais:
   - Falhas de lógica de negócio
   - Bypass de autenticação
   - Problemas de autorização
   - Vulnerabilidades de injeção
5. Classificar achados por severidade:
   - Crítico: Risco de exploração imediata
   - Alto: Impacto significativo, mais fácil de explorar
   - Médio: Impacto moderado ou dificuldade
   - Baixo: Impacto menor
6. Desenvolver plano de remediação:
   - Priorizar por risco
   - Atribuir responsáveis
   - Definir prazos
7. Verificar correções e documentar
8. **Validação:** Escopo definido; testes automatizados e manuais completos; achados classificados; remediação rastreada

Para descrições de vulnerabilidades do OWASP Top 10 e orientação de testes, consulte [owasp.org/Top10](https://owasp.org/Top10).

### Matriz de Severidade de Vulnerabilidades

| Impacto \ Explorabilidade | Fácil | Moderado | Difícil |
|-------------------------|------|----------|-----------|
| Crítico | Crítico | Crítico | Alto |
| Alto | Crítico | Alto | Médio |
| Médio | Alto | Médio | Baixo |
| Baixo | Médio | Baixo | Baixo |

---

## Workflow de Revisão de Código Seguro

Revise código em busca de vulnerabilidades de segurança antes da implantação.

### Workflow: Conduzir Revisão de Código de Segurança

1. Estabelecer escopo de revisão:
   - Arquivos e funções alterados
   - Áreas sensíveis à segurança (auth, crypto, tratamento de entrada)
   - Integrações de terceiros
2. Executar análise automatizada:
   - Ferramentas SAST (Semgrep, CodeQL, Bandit)
   - Escaneamento de segredos
   - Verificação de vulnerabilidades de dependências
3. Revisar código de autenticação:
   - Tratamento de senha (hashing, armazenamento)
   - Gerenciamento de sessão
   - Validação de token
4. Revisar código de autorização:
   - Verificações de controle de acesso
   - Implementação RBAC
   - Limites de privilégio
5. Revisar tratamento de dados:
   - Validação de entrada
   - Codificação de saída
   - Construção de query SQL
   - Tratamento de caminho de arquivo
6. Revisar código criptográfico:
   - Seleção de algoritmo
   - Gerenciamento de chaves
   - Geração de número aleatório
7. Documentar achados com severidade
8. **Validação:** Scans automatizados aprovados; auth/authz revisados; tratamento de dados verificado; crypto verificada; achados documentados

### Checklist de Revisão de Código de Segurança

| Categoria | Verificação | Risco |
|----------|-------|------|
| Validação de Entrada | Toda entrada do usuário validada e sanitizada | Injeção |
| Codificação de Saída | Codificação apropriada ao contexto aplicada | XSS |
| Autenticação | Senhas com hash usando Argon2/bcrypt | Roubo de credenciais |
| Sessão | Flags de cookie seguros definidos (HttpOnly, Secure, SameSite) | Hijacking de sessão |
| Autorização | Verificações de permissão no lado do servidor em todos os endpoints | Escalação de privilégio |
| SQL | Queries parametrizadas usadas exclusivamente | SQL injection |
| Acesso a Arquivo | Sequências de path traversal rejeitadas | Path traversal |
| Segredos | Sem credenciais ou chaves hardcoded | Divulgação de informações |
| Dependências | Pacotes vulneráveis conhecidos atualizados | Cadeia de suprimentos |
| Logging | Dados sensíveis não registrados | Divulgação de informações |

### Padrões Seguros vs Inseguros

| Padrão | Problema | Alternativa Segura |
|---------|-------|-------------------|
| Formatação de string SQL | SQL injection | Use queries parametrizadas com placeholders |
| Construção de comando shell | Injeção de comando | Use subprocess com listas de argumentos, sem shell |
| Concatenação de caminho | Path traversal | Validar e canonicalizar caminhos |
| MD5/SHA1 para senhas | Hash fraco | Use Argon2id ou bcrypt |
| Math.random para tokens | Valores previsíveis | Use crypto.getRandomValues |

### Exemplos de Código Inline

**SQL Injection — inseguro vs. seguro (Python):**

```python
# Inseguro: formatação de string permite SQL injection
query = f"SELECT * FROM users WHERE username = '{username}'"
cursor.execute(query)

# Seguro: query parametrizada — entrada do usuário nunca interpretada como SQL
query = "SELECT * FROM users WHERE username = %s"
cursor.execute(query, (username,))
```

**Hashing de Senha com Argon2id (Python):**

```python
from argon2 import PasswordHasher

ph = PasswordHasher()          # usa padrões seguros (time_cost, memory_cost)

# No registro
hashed = ph.hash(plain_password)

# No login — lança argon2.exceptions.VerifyMismatchError em falha
ph.verify(hashed, plain_password)
```

**Escaneamento de Segredos — padrão de correspondência central (Python):**

```python
import re, pathlib

SECRET_PATTERNS = {
    "aws_access_key":  re.compile(r"AKIA[0-9A-Z]{16}"),
    "github_token":    re.compile(r"ghp_[A-Za-z0-9]{36}"),
    "private_key":     re.compile(r"-----BEGIN (RSA |EC )?PRIVATE KEY-----"),
    "generic_secret":  re.compile(r'(?i)(password|secret|api_key)\s*=\s*["\']?\S{8,}'),
}

def scan_file(path: pathlib.Path) -> list[dict]:
    findings = []
    for lineno, line in enumerate(path.read_text(errors="replace").splitlines(), 1):
        for name, pattern in SECRET_PATTERNS.items():
            if pattern.search(line):
                findings.append({"file": str(path), "line": lineno, "type": name})
    return findings
```

---

## Workflow de Resposta a Incidentes

Responda e contenha incidentes de segurança.

### Workflow: Lidar com Incidente de Segurança

1. Identificar e triar:
   - Validar que o incidente é genuíno
   - Avaliar escopo e severidade inicial
   - Ativar equipe de resposta a incidentes
2. Conter a ameaça:
   - Isolar sistemas afetados
   - Bloquear IPs/contas maliciosos
   - Desabilitar credenciais comprometidas
3. Erradicar a causa raiz:
   - Remover malware/backdoors
   - Corrigir vulnerabilidades
   - Atualizar configurações
4. Recuperar operações:
   - Restaurar a partir de backups limpos
   - Verificar integridade do sistema
   - Monitorar recorrência
5. Conduzir pós-mortem:
   - Reconstrução da timeline
   - Análise de causa raiz
   - Lições aprendidas
6. Implementar melhorias:
   - Atualizar regras de detecção
   - Aprimorar controles
   - Atualizar runbooks
7. Documentar e reportar
8. **Validação:** Ameaça contida; causa raiz eliminada; sistemas recuperados; pós-mortem completo; melhorias implementadas

### Níveis de Severidade de Incidentes

| Nível | Tempo de Resposta | Escalação |
|-------|---------------|------------|
| P1 - Crítico (violação ativa/exfiltração) | Imediato | CISO, Jurídico, Executivo |
| P2 - Alto (confirmado, contido) | 1 hora | Líder de Segurança, Diretor de TI |
| P3 - Médio (potencial, sob investigação) | 4 horas | Equipe de Segurança |
| P4 - Baixo (suspeito, baixo impacto) | 24 horas | Engenheiro de plantão |

### Checklist de Resposta a Incidentes

| Fase | Ações |
|-------|---------|
| Identificação | Validar alerta, avaliar escopo, determinar severidade |
| Contenção | Isolar sistemas, preservar evidências, bloquear acesso |
| Erradicação | Remover ameaça, corrigir vulnerabilidades, redefinir credenciais |
| Recuperação | Restaurar serviços, verificar integridade, aumentar monitoramento |
| Lições Aprendidas | Documentar timeline, identificar lacunas, atualizar procedimentos |

---

## Referência de Ferramentas de Segurança

### Ferramentas de Segurança Recomendadas

| Categoria | Ferramentas |
|----------|-------|
| SAST | Semgrep, CodeQL, Bandit (Python), plugins de segurança ESLint |
| DAST | OWASP ZAP, Burp Suite, Nikto |
| Escaneamento de Dependências | Snyk, Dependabot, npm audit, pip-audit |
| Detecção de Segredos | GitLeaks, TruffleHog, detect-secrets |
| Segurança de Container | Trivy, Clair, Anchore |
| Infraestrutura | Checkov, tfsec, ScoutSuite |
| Rede | Wireshark, Nmap, Masscan |
| Penetração | Metasploit, sqlmap, Burp Suite Pro |

### Seleção de Algoritmo Criptográfico

| Caso de Uso | Algoritmo | Tamanho da Chave |
|----------|-----------|----------|
| Criptografia simétrica | AES-256-GCM | 256 bits |
| Hashing de senha | Argon2id | N/A (usar padrões) |
| Autenticação de mensagem | HMAC-SHA256 | 256 bits |
| Assinaturas digitais | Ed25519 | 256 bits |
| Troca de chaves | X25519 | 256 bits |
| TLS | TLS 1.3 | N/A |

Veja: [references/cryptography-implementation.md](references/cryptography-implementation.md)

---

## Ferramentas e Referências

### Scripts

| Script | Propósito |
|--------|---------|
| [threat_modeler.py](scripts/threat_modeler.py) | Análise de ameaças STRIDE com scoring de risco DREAD; saída JSON e texto; modo guiado interativo |
| [secret_scanner.py](scripts/secret_scanner.py) | Detectar segredos e credenciais hardcoded em 20+ padrões; pronto para integração CI/CD |

Para uso, consulte os exemplos de código inline em [Workflow de Revisão de Código Seguro](#inline-code-examples) e os arquivos de script diretamente.

### Referências

| Documento | Conteúdo |
|----------|---------|
| [security-architecture-patterns.md](references/security-architecture-patterns.md) | Zero Trust, defesa em profundidade, padrões de autenticação, segurança de API |
| [threat-modeling-guide.md](references/threat-modeling-guide.md) | Metodologia STRIDE, árvores de ataque, scoring DREAD, criação de DFD |
| [cryptography-implementation.md](references/cryptography-implementation.md) | AES-GCM, RSA, Ed25519, hashing de senha, gerenciamento de chaves |

---

## Referência de Padrões de Segurança

### Checklist de Cabeçalhos de Segurança

| Cabeçalho | Valor Recomendado |
|--------|-------------------|
| Content-Security-Policy | default-src self; script-src self |
| X-Frame-Options | DENY |
| X-Content-Type-Options | nosniff |
| Strict-Transport-Security | max-age=31536000; includeSubDomains |
| Referrer-Policy | strict-origin-when-cross-origin |
| Permissions-Policy | geolocation=(), microphone=(), camera=() |

Para requisitos de frameworks de conformidade (OWASP ASVS, CIS Benchmarks, NIST CSF, PCI-DSS, LGPD/ANVISA, SOC 2), consulte a respectiva documentação oficial.

---

## Skills Relacionadas

| Skill | Ponto de Integração |
|-------|-------------------|
| [senior-devops](../senior-devops/) | Segurança CI/CD, hardening de infraestrutura |
| [senior-secops](../senior-secops/) | Monitoramento de segurança, resposta a incidentes |
| [senior-backend](../senior-backend/) | Desenvolvimento de API segura |
| [senior-architect](../senior-architect/) | Decisões de arquitetura de segurança |
