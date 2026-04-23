---
name: "env-secrets-manager"
description: "Gerenciador de Env e Secrets — gerencia higiene de variáveis de ambiente e segurança de secrets em workflows de desenvolvimento local e produção, com auditoria, detecção de vazamento e orientação de rotação."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Env & Secrets Manager

**Nível:** PODEROSO
**Categoria:** Engenharia
**Domínio:** Segurança / DevOps / Gerenciamento de Configuração

---

## Visão Geral

Gerencie a higiene de variáveis de ambiente e a segurança de secrets em workflows de desenvolvimento local e produção. Esta skill se concentra em auditoria prática, consciência de drift e prontidão para rotação.

## Capacidades Principais

- Orientação sobre o ciclo de vida de `.env` e `.env.example`
- Detecção de vazamento de secret para árvores de trabalho de repositório
- Achados baseados em gravidade para credenciais prováveis
- Ponteiros operacionais para rotação e contenção
- Saídas prontas para integração em verificações de CI

---

## Quando Usar

- Antes de enviar commits que tocaram arquivos env/de configuração
- Durante auditorias de segurança e triagem de incidentes
- Ao integrar contribuidores que precisam de convenções de env seguras
- Ao validar que nenhum secret óbvio está hardcoded

---

## Início Rápido

```bash
# Varrer um repositório para possíveis vazamentos de secret
python3 scripts/env_auditor.py /path/to/repo

# Saída JSON para pipelines CI
python3 scripts/env_auditor.py /path/to/repo --json
```

---

## Workflow Recomendado

1. Execute `scripts/env_auditor.py` na raiz do repositório.
2. Priorize achados `críticos` e `altos` primeiro.
3. Rotacione credenciais reais e remova valores expostos.
4. Atualize `.env.example` e `.gitignore` conforme necessário.
5. Adicione ou reforce gates de varredura de secrets em pre-commit/CI.

---

## Documentação de Referência

- `references/validation-detection-rotation.md`
- `references/secret-patterns.md`

---

## Armadilhas Comuns

- Fazer commit de valores reais em `.env.example`
- Rotacionar um sistema mas perder consumidores downstream
- Registrar secrets durante depuração ou resposta a incidentes
- Tratar vazamentos suspeitos como baixa urgência sem validação

## Melhores Práticas

1. Use um gerenciador de secrets como fonte de verdade em produção.
2. Mantenha arquivos de env de desenvolvimento locais e no gitignore.
3. Aplique detecção em CI antes do merge.
4. Re-teste caminhos da aplicação imediatamente após a rotação de credenciais.

---

## Integração com Armazenamento de Secrets na Nuvem

Aplicações de produção nunca devem ler secrets de arquivos `.env` ou variáveis de ambiente assadas em imagens de container. Use um store de secrets dedicado.

### Comparação de Provedores

| Provedor | Melhor Para | Funcionalidade Principal |
|----------|----------|-------------|
| **HashiCorp Vault** | Multi-cloud / híbrido | Secrets dinâmicos, motor de política, backends plugáveis |
| **AWS Secrets Manager** | Cargas de trabalho nativas AWS | Integração nativa Lambda/ECS/EKS, rotação automática RDS |
| **Azure Key Vault** | Cargas de trabalho nativas Azure | HSM gerenciado, Azure AD RBAC, gerenciamento de certificado |
| **GCP Secret Manager** | Cargas de trabalho nativas GCP | Acesso baseado em IAM, replicação automática, versionamento |

### Orientação de Seleção

- **Provedor de nuvem único** — use o gerenciador de secrets nativo da nuvem. Ele se integra estreitamente com IAM, reduz a sobrecarga operacional e custa menos do que a auto-hospedagem.
- **Multi-cloud ou híbrido** — use HashiCorp Vault. Ele fornece uma API uniforme entre ambientes e suporta geração de secrets dinâmicos (credenciais de banco de dados, chaves IAM de nuvem) que expiram automaticamente.
- **Kubernetes-intensivo** — combine External Secrets Operator com qualquer backend acima para sincronizar secrets em objetos `Secret` do K8s sem hardcoding.

### Padrões de Acesso da Aplicação

1. **Pull via SDK/API** — a aplicação busca o secret na inicialização ou sob demanda via SDK do provedor.
2. **Injeção via sidecar** — um container sidecar (ex.: Vault Agent) escreve secrets em um volume compartilhado ou os injeta como variáveis de ambiente.
3. **Init container** — um init container do Kubernetes busca secrets antes do container principal iniciar.
4. **Driver CSI** — secrets são montados como um volume de sistema de arquivos via Secrets Store CSI Driver.

> **Referência cruzada:** Veja `engineering/secrets-vault-manager` para padrões de infraestrutura de vault de produção, implantação HA e procedimentos de recuperação de desastre.

---

## Workflow de Rotação de Secrets

Secrets obsoletos são um passivo. A rotação garante que, mesmo que uma credencial vaze, seu tempo de vida útil seja limitado.

### Fase 1: Detecção

- Rastreie datas de criação e expiração de secrets nos metadados do seu store de secrets.
- Defina alertas a 30, 14 e 7 dias antes da expiração.
- Use `scripts/env_auditor.py` para sinalizar secrets sem data de rotação registrada.

### Fase 2: Rotação

1. **Gere** uma nova credencial (chave de API, senha de banco de dados, certificado).
2. **Implante** a nova credencial para todos os consumidores (apps, serviços, pipelines) em paralelo.
3. **Verifique** que cada consumidor pode autenticar usando a nova credencial.
4. **Revogue** a credencial antiga somente após todos os consumidores estarem confirmados como saudáveis.
5. **Atualize** os metadados com o novo timestamp de rotação e a próxima data de rotação.

### Fase 3: Automação

- **AWS Secrets Manager** — use rotação baseada em Lambda integrada para RDS, Redshift e DocumentDB.
- **HashiCorp Vault** — configure secrets dinâmicos com TTLs; credenciais são geradas sob demanda e expiram automaticamente.
- **Azure Key Vault** — use notificações Event Grid para acionar funções de rotação.
- **GCP Secret Manager** — use notificações Pub/Sub ligadas a Cloud Functions para lógica de rotação.

### Lista de Verificação de Rotação de Emergência

Quando um secret é confirmado como vazado:

1. **Revogue imediatamente** a credencial comprometida no nível do provedor.
2. Gere e implante uma credencial substituta para todos os consumidores.
3. Audite logs de acesso para uso não autorizado durante a janela de exposição.
4. Varra o histórico git, logs de CI e registros de artefatos para o valor vazado.
5. Registre um relatório de incidente documentando escopo, timeline e passos de remediação.
6. Revise e reforce os controles de detecção para evitar recorrência.

---

## Injeção de Secrets em CI/CD

Secrets em pipelines CI/CD requerem tratamento cuidadoso para evitar exposição em logs, artefatos ou contextos de pull request.

### GitHub Actions

- Use **secrets de repositório** ou **secrets de ambiente** via `${{ secrets.SECRET_NAME }}`.
- Prefira **federação OIDC** (`aws-actions/configure-aws-credentials` com `role-to-assume`) em vez de chaves de acesso de longa duração.
- Secrets de ambiente com revisores necessários adicionam gates de aprovação para implantações de produção.
- O GitHub mascara automaticamente secrets em logs, mas evite `echo` ou `toJSON()` em valores de secret.

### GitLab CI

- Armazene secrets como **variáveis CI/CD** com as flags `masked` e `protected` habilitadas.
- Use **integração com HashiCorp Vault** (`secrets:vault`) para injeção dinâmica de secrets sem armazenar valores no GitLab.
- Escope variáveis para ambientes específicos (`production`, `staging`) para aplicar o menor privilégio.

### Padrões Universais

- **Nunca faça echo ou imprima** valores de secrets na saída do pipeline, mesmo para depuração.
- **Use tokens de curta duração** (OIDC, STS AssumeRole) em vez de credenciais estáticas sempre que possível.
- **Restrinja acesso em PRs** — não exponha secrets para pipelines acionados por forks ou branches não confiáveis.
- **Rotacione secrets de CI** no mesmo cronograma que os secrets de aplicação; credenciais de pipeline também são vetores de ataque.
- **Audite logs de pipeline** periodicamente para exposição acidental de secrets que o mascaramento pode ter perdido.

---

## Detecção de Secrets em Pré-Commit

Capturar secrets antes de chegarem ao controle de versão é a defesa mais custo-efetiva. Duas ferramentas líderes cobrem este espaço.

### gitleaks

```toml
# .gitleaks.toml — configuração mínima
[extend]
useDefault = true

[[rules]]
id = "custom-internal-token"
description = "Padrão de token de serviço interno"
regex = '''INTERNAL_TOKEN_[A-Za-z0-9]{32}'''
secretGroup = 0
```

- Instalar: `brew install gitleaks` ou baixar das releases do GitHub.
- Hook pré-commit: `gitleaks git --pre-commit --staged`
- Varredura de baseline: `gitleaks detect --source . --report-path gitleaks-report.json`
- Gerencie falsos positivos em `.gitleaksignore` (uma impressão digital por linha).

### detect-secrets

```bash
# Gerar baseline
detect-secrets scan --all-files > .secrets.baseline

# Hook pré-commit (via framework pre-commit)
# .pre-commit-config.yaml
repos:
  - repo: https://github.com/Yelp/detect-secrets
    rev: v1.5.0
    hooks:
      - id: detect-secrets
        args: ['--baseline', '.secrets.baseline']
```

- Suporta **plugins personalizados** para padrões específicos da organização.
- Workflow de auditoria: `detect-secrets audit .secrets.baseline` marca interativamente verdadeiros/falsos positivos.

### Gerenciamento de Falsos Positivos

- Mantenha `.gitleaksignore` ou `.secrets.baseline` no controle de versão para que toda a equipe compartilhe exclusões.
- Revise listas de falsos positivos durante auditorias de segurança — padrões podem mascarar vazamentos reais ao longo do tempo.
- Prefira apertar padrões regex em vez de ignorar amplamente arquivos.

---

## Registro de Auditoria

Saber quem acessou qual secret e quando é crítico para investigação de incidentes e conformidade.

### Trilhas de Auditoria Nativas na Nuvem

| Provedor | Serviço | O Que Captura |
|----------|---------|-----------------|
| **AWS** | CloudTrail | Cada chamada de API `GetSecretValue`, `DescribeSecret`, `RotateSecret` |
| **Azure** | Activity Log + Diagnostic Logs | Eventos de acesso ao Key Vault, incluindo identidade do chamador e IP |
| **GCP** | Cloud Audit Logs | Logs de acesso a dados para Secret Manager com principal e timestamp |
| **Vault** | Audit Backend | Registro completo de requisição/resposta (arquivo, syslog ou backend de socket) |

### Estratégia de Alertas

- Alerte sobre **acesso de intervalos de IP desconhecidos** ou contas de serviço fora do conjunto esperado.
- Alerte sobre **leituras em massa de secrets** (mais de N secrets acessados dentro de uma janela de tempo).
- Alerte sobre **acesso fora das janelas de implantação** quando nenhum pipeline CI/CD está em execução.
- Alimente logs de auditoria em seu SIEM (Splunk, Datadog, Elastic) para correlação com outros eventos de segurança.
- Revise logs de auditoria trimestralmente como parte da recertificação de acesso.

---

## Referências Cruzadas

Esta skill cobre higiene de env e detecção de secrets. Para cobertura mais profunda de domínios relacionados, veja:

| Skill | Caminho | Relação |
|-------|------|-------------|
| **Secrets Vault Manager** | `engineering/secrets-vault-manager` | Infraestrutura de vault de produção, implantação HA, DR |
| **Senior SecOps** | `engineering/senior-secops` | Perspectiva de operações de segurança, resposta a incidentes |
| **CI/CD Pipeline Builder** | `engineering/ci-cd-pipeline-builder` | Arquitetura de pipeline, padrões de injeção de secrets |
| **Infrastructure as Code** | `engineering/infrastructure-as-code` | Configuração de backend de secrets Terraform/Pulumi |
| **Container Orchestration** | `engineering/container-orchestration` | Montagem de secrets Kubernetes, sealed secrets |
