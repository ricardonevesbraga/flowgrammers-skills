---
name: "secrets-vault-manager"
description: "Use quando o usuário pede para configurar infraestrutura de gerenciamento de segredos, integrar o HashiCorp Vault, configurar armazenamentos de segredos em nuvem (AWS Secrets Manager, Azure Key Vault, GCP Secret Manager), implementar rotação de segredos ou auditar padrões de acesso a segredos."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Secrets Vault Manager

**Nível:** PODEROSO
**Categoria:** Engenharia
**Domínio:** Segurança / Infraestrutura / DevOps

---

## Visão Geral

Gerenciamento de infraestrutura de segredos em produção para equipes que executam HashiCorp Vault, armazenamentos de segredos nativos em nuvem ou arquiteturas híbridas. Esta skill cobre criação de políticas, configuração de métodos de autenticação, rotação automatizada, segredos dinâmicos, registro de logs de auditoria e resposta a incidentes.

**Distinto do env-secrets-manager** que lida com higiene de arquivo `.env` local e detecção de vazamentos. Esta skill opera na camada de infraestrutura — clusters Vault, KMS em nuvem, autoridades de certificação e injeção de segredos em CI/CD.

### Quando Usar

- Configurando um novo cluster Vault ou migrando para um armazenamento de segredos gerenciado
- Projetando métodos de autenticação para serviços, runners de CI e operadores humanos
- Implementando rotação automatizada de credenciais (banco de dados, chaves de API, certificados)
- Auditando padrões de acesso a segredos para conformidade (SOC 2, ISO 27001, LGPD)
- Respondendo a um vazamento de segredo que requer revogação em massa
- Integrando segredos em cargas de trabalho Kubernetes ou pipelines CI/CD

---

## Padrões HashiCorp Vault

### Decisões de Arquitetura

| Decisão | Recomendação | Justificativa |
|---------|---------------|-----------|
| Modo de implantação | HA com armazenamento Raft | Sem dependência externa, eleição de líder integrada |
| Auto-unseal | KMS em nuvem (AWS KMS / Azure Key Vault / GCP KMS) | Elimina unseal manual, habilita reinicializações automatizadas |
| Namespaces | Um por ambiente (dev/staging/prod) | Isolamento de raio de impacto, políticas independentes |
| Dispositivos de auditoria | Arquivo + syslog (duplo) | Vault recusa requisições se todos os dispositivos de auditoria falharem — duplo previne interrupções |

### Métodos de Autenticação

**AppRole** — Autenticação máquina-a-máquina para serviços e jobs em lote.

```hcl
# Habilitar AppRole
path "auth/approle/*" {
  capabilities = ["create", "read", "update", "delete", "list"]
}

# Papel específico da aplicação
vault write auth/approle/role/payment-service \
  token_ttl=1h \
  token_max_ttl=4h \
  secret_id_num_uses=1 \
  secret_id_ttl=10m \
  token_policies="payment-service-read"
```

**Kubernetes** — Autenticação nativa de pod via tokens de conta de serviço.

```hcl
vault write auth/kubernetes/role/api-server \
  bound_service_account_names=api-server \
  bound_service_account_namespaces=production \
  policies=api-server-secrets \
  ttl=1h
```

**OIDC** — Acesso de operador humano via provedor SSO (Okta, Azure AD, Google Workspace).

```hcl
vault write auth/oidc/role/engineering \
  bound_audiences="vault" \
  allowed_redirect_uris="https://vault.example.com/ui/vault/auth/oidc/oidc/callback" \
  user_claim="email" \
  oidc_scopes="openid,profile,email" \
  policies="engineering-read" \
  ttl=8h
```

### Engines de Segredos

| Engine | Caso de Uso | Estratégia de TTL |
|--------|-------------|-------------|
| KV v2 | Segredos estáticos (chaves de API, configuração) | Versionado, rotação manual |
| Database | Credenciais de banco de dados dinâmicas | Padrão 1h, máximo 24h |
| PKI | Certificados TLS | Certs folha 90 dias, CA intermediária 5 anos |
| Transit | Criptografia como serviço | Rotação de chave a cada 90 dias |
| SSH | Certificados SSH assinados | 30 min para interativo, 8h para automação |

### Design de Política

Siga o princípio do menor privilégio com granularidade baseada em caminho:

```hcl
# Política payment-service-read
path "secret/data/production/payment/*" {
  capabilities = ["read"]
}

path "database/creds/payment-readonly" {
  capabilities = ["read"]
}

# Negar acesso explicitamente a caminhos de admin
path "sys/*" {
  capabilities = ["deny"]
}
```

**Convenção de nomenclatura de política:** `{servico}-{nivel-acesso}` (ex.: `payment-service-read`, `api-gateway-admin`).

---

## Integração com Armazenamentos de Segredos em Nuvem

### Matriz de Comparação

| Funcionalidade | AWS Secrets Manager | Azure Key Vault | GCP Secret Manager |
|---------|--------------------|-----------------|--------------------|
| Rotação | Lambda integrado | Lógica personalizada via Functions | Cloud Functions |
| Versionamento | Automático | Manual ou automático | Automático |
| Criptografia | AWS KMS (padrão ou CMK) | Respaldado por HSM | Gerenciado pelo Google ou CMEK |
| Controle de acesso | Políticas IAM + política de recurso | RBAC + Políticas de Acesso | Vinculações IAM |
| Entre regiões | Replicação suportada | Geo-redundante por padrão | Replicação suportada |
| Auditoria | CloudTrail | Azure Monitor + Diagnostic Logs | Cloud Audit Logs |
| Modelo de preços | Por segredo + por chamada de API | Por operação + por chave | Por versão de segredo + por acesso |

### Quando Usar Qual

- **AWS Secrets Manager**: Rotação de credenciais RDS/Aurora pronta para uso. Melhor quando totalmente no AWS.
- **Azure Key Vault**: Força no gerenciamento de certificados. Obrigatório para cargas de trabalho integradas ao Azure AD.
- **GCP Secret Manager**: Superfície de API mais simples. Melhor para cargas de trabalho nativas do GKE com Workload Identity.
- **HashiCorp Vault**: Multi-cloud, segredos dinâmicos, PKI, criptografia em trânsito. Melhor para ambientes complexos ou híbridos.

### Padrões de Acesso por SDK

**Princípio:** Sempre busque segredos na inicialização ou via sidecar — nunca embutidos em imagens ou arquivos de configuração.

```python
# Padrão AWS Secrets Manager
import boto3, json

def get_secret(secret_name, region="us-east-1"):
    client = boto3.client("secretsmanager", region_name=region)
    response = client.get_secret_value(SecretId=secret_name)
    return json.loads(response["SecretString"])
```

```python
# Padrão GCP Secret Manager
from google.cloud import secretmanager

def get_secret(project_id, secret_id, version="latest"):
    client = secretmanager.SecretManagerServiceClient()
    name = f"projects/{project_id}/secrets/{secret_id}/versions/{version}"
    response = client.access_secret_version(request={"name": name})
    return response.payload.data.decode("UTF-8")
```

```python
# Padrão Azure Key Vault
from azure.identity import DefaultAzureCredential
from azure.keyvault.secrets import SecretClient

def get_secret(vault_url, secret_name):
    credential = DefaultAzureCredential()
    client = SecretClient(vault_url=vault_url, credential=credential)
    return client.get_secret(secret_name).value
```

---

## Fluxos de Trabalho de Rotação de Segredos

### Estratégia de Rotação por Tipo de Segredo

| Tipo de Segredo | Frequência de Rotação | Método | Risco de Downtime |
|-------------|-------------------|--------|---------------|
| Senhas de banco de dados | 30 dias | Troca de conta dupla | Zero (rotação A/B) |
| Chaves de API | 90 dias | Gerar nova, deprecar antiga | Zero (janela de sobreposição) |
| Certificados TLS | 60 dias antes da expiração | ACME ou PKI do Vault | Zero (recarga graciosa) |
| Chaves SSH | 90 dias | Certificados assinados pelo Vault | Zero (baseado em CA) |
| Tokens de serviço | 24 horas | Geração dinâmica | Zero (curta duração) |
| Chaves de criptografia | 90 dias | Versionamento de chave (rewrap) | Zero (coexistência de versões) |

### Rotação de Credenciais de Banco de Dados (Conta Dupla)

1. Existem duas contas de banco de dados: `app_user_a` e `app_user_b`
2. A aplicação usa `app_user_a` atualmente
3. A rotação muda a senha do `app_user_b`, atualiza o armazenamento de segredos
4. A aplicação muda para `app_user_b` na próxima busca de credenciais
5. Após o período de carência, a senha do `app_user_a` é rotacionada
6. O ciclo se repete

### Rotação de Chave de API (Janela de Sobreposição)

1. Gere nova chave de API com o provedor
2. Armazene a nova chave no armazenamento de segredos como `current`, mova a antiga para `previous`
3. Implante as aplicações — elas leem `current`
4. Após todas as instâncias reiniciadas (ou TTL expirado), revogue `previous`
5. O monitoramento confirma zero uso da chave antiga antes da revogação

---

## Segredos Dinâmicos

Os segredos dinâmicos são gerados sob demanda com expiração automática. Prefira segredos dinâmicos a credenciais estáticas sempre que possível.

### Credenciais Dinâmicas de Banco de Dados (Vault)

```hcl
# Configurar engine de banco de dados
vault write database/config/postgres \
  plugin_name=postgresql-database-plugin \
  connection_url="postgresql://{{username}}:{{password}}@db.example.com:5432/app" \
  allowed_roles="app-readonly,app-readwrite" \
  username="vault_admin" \
  password="<admin-password>"

# Criar papel com TTL
vault write database/roles/app-readonly \
  db_name=postgres \
  creation_statements="CREATE ROLE \"{{name}}\" WITH LOGIN PASSWORD '{{password}}' VALID UNTIL '{{expiration}}'; GRANT SELECT ON ALL TABLES IN SCHEMA public TO \"{{name}}\";" \
  default_ttl=1h \
  max_ttl=24h
```

### Credenciais Dinâmicas de Cloud IAM

O Vault pode gerar credenciais de curta duração para AWS IAM, senhas de service principal do Azure ou chaves de conta de serviço do GCP — eliminando completamente as credenciais de nuvem de longa duração.

### Autoridade Certificadora SSH

Substitua a distribuição de chaves SSH por um modelo de certificado assinado pelo Vault:

1. Vault atua como CA SSH
2. Usuários/máquinas solicitam certificados assinados com TTL curto (30 min)
3. Servidores SSH confiam na chave pública da CA — sem gerenciamento de `authorized_keys`
4. Os certificados expiram automaticamente — sem necessidade de revogação para operações normais

---

## Logging de Auditoria

### O Que Registrar

| Evento | Prioridade | Retenção |
|-------|----------|-----------|
| Acesso de leitura a segredo | ALTA | Mínimo 1 ano |
| Criação/atualização de segredo | ALTA | Mínimo 1 ano |
| Login no método de autenticação | MÉDIA | 90 dias |
| Mudanças de política | CRÍTICA | 2 anos (conformidade) |
| Tentativas de acesso com falha | CRÍTICA | 1 ano |
| Criação/revogação de token | MÉDIA | 90 dias |
| Operações de seal/unseal | CRÍTICA | Indefinido |

### Sinais de Detecção de Anomalias

- Segredo acessado de novo IP/faixa CIDR
- Pico no volume de acesso (mais de 3x a linha de base para um caminho)
- Acesso fora do horário para métodos de autenticação humana
- Serviço acessando segredos fora do escopo de sua política (requisições negadas)
- Múltiplas tentativas de autenticação com falha de uma única fonte
- Token criado com TTL incomumente longo

### Relatórios de Conformidade

Gere relatórios periódicos cobrindo:

1. **Inventário de acesso** — Quais identidades acessaram quais segredos, quando
2. **Conformidade de rotação** — Segredos com rotação atrasada
3. **Deriva de política** — Políticas modificadas desde a última revisão
4. **Segredos órfãos** — Segredos sem acesso recente (mais de 90 dias)

Use `audit_log_analyzer.py` para analisar logs de auditoria do Vault ou da nuvem em busca desses sinais.

---

## Procedimentos de Emergência

### Resposta a Vazamento de Segredo (Imediato)

**Meta de tempo: Contenha em 15 minutos após a detecção.**

1. **Identifique o escopo** — Qual(is) segredo(s) vazou, onde (repositório, log, mensagem de erro, terceiro)
2. **Revogue imediatamente** — Gire a credencial comprometida na fonte (API do provedor, Vault, cloud SM)
3. **Invalide tokens** — Revogue todos os tokens Vault que acessaram o segredo vazado
4. **Audite o raio de impacto** — Consulte logs de auditoria para uso do segredo comprometido na janela de exposição
5. **Notifique stakeholders** — Equipe de segurança, proprietários do serviço afetado, conformidade (se PII/dados regulados)
6. **Post-mortem** — Documente a causa raiz, atualize os controles para prevenir recorrência

### Operações de Seal do Vault

**Quando fazer seal:** Incidente de segurança ativo afetando a infraestrutura do Vault, comprometimento suspeito de chave.

**Fazer seal** para todas as operações do Vault. Use apenas como último recurso.

**Procedimento de unseal:**
1. Reúna o quórum de detentores da chave de unseal (threshold de Shamir)
2. Ou confirme que a chave KMS de auto-unseal está acessível
3. Faça unseal via `vault operator unseal` ou reinicie com auto-unseal
4. Verifique se os dispositivos de auditoria estão reconectados
5. Verifique leases ativos e validade de tokens

Veja `references/emergency_procedures.md` para playbooks completos.

---

## Integração CI/CD

### Sidecar do Vault Agent (Kubernetes)

O Vault Agent roda junto com os pods da aplicação, lida com autenticação e renderização de segredos:

```yaml
# Anotação de pod para o Vault Agent Injector
annotations:
  vault.hashicorp.com/agent-inject: "true"
  vault.hashicorp.com/role: "api-server"
  vault.hashicorp.com/agent-inject-secret-db: "database/creds/app-readonly"
  vault.hashicorp.com/agent-inject-template-db: |
    {{- with secret "database/creds/app-readonly" -}}
    postgresql://{{ .Data.username }}:{{ .Data.password }}@db:5432/app
    {{- end }}
```

### External Secrets Operator (Kubernetes)

Para equipes que preferem GitOps declarativo em vez de sidecars de agente:

```yaml
apiVersion: external-secrets.io/v1beta1
kind: ExternalSecret
metadata:
  name: api-credentials
spec:
  refreshInterval: 1h
  secretStoreRef:
    name: vault-backend
    kind: ClusterSecretStore
  target:
    name: api-credentials
  data:
    - secretKey: api-key
      remoteRef:
        key: secret/data/production/api
        property: key
```

### OIDC do GitHub Actions

Elimine segredos de longa duração no CI usando federação OIDC:

```yaml
- name: Autenticar no Vault
  uses: hashicorp/vault-action@v2
  with:
    url: https://vault.example.com
    method: jwt
    role: github-ci
    jwtGithubAudience: https://vault.example.com
    secrets: |
      secret/data/ci/deploy api_key | DEPLOY_API_KEY ;
      secret/data/ci/deploy db_password | DB_PASSWORD
```

---

## Anti-Padrões

| Anti-Padrão | Risco | Abordagem Correta |
|-------------|------|-----------------|
| Segredos hardcoded no código-fonte | Vazamento via repositório, logs, saída de erro | Busque do armazenamento de segredos em tempo de execução |
| Tokens estáticos de longa duração (mais de 30 dias) | Credenciais obsoletas, sem responsabilização | Segredos dinâmicos ou TTL curto + rotação |
| Contas de serviço compartilhadas | Sem trilha de auditoria por consumidor | Identidade por serviço com credenciais únicas |
| Sem política de rotação | Credenciais comprometidas persistem indefinidamente | Rotação automatizada por agendamento |
| Segredos em variáveis de ambiente no CI | Visíveis nos logs de build, tabela de processos | Injeção via Vault Agent ou baseada em OIDC |
| Único detentor de chave de unseal | Bus factor de 1, recuperação bloqueada | Divisão Shamir (3-de-5) ou auto-unseal |
| Sem dispositivo de auditoria configurado | Zero visibilidade no acesso | Dispositivos de auditoria duplos (arquivo + syslog) |
| Políticas com curinga (`path "*"`) | Superprivilegiado, viola o menor privilégio | Políticas explícitas baseadas em caminho por serviço |

---

## Ferramentas

| Script | Propósito |
|--------|---------|
| `vault_config_generator.py` | Gerar política do Vault e configuração de autenticação a partir de requisitos da aplicação |
| `rotation_planner.py` | Criar agendamento de rotação a partir de um arquivo de inventário de segredos |
| `audit_log_analyzer.py` | Analisar logs de auditoria para anomalias e lacunas de conformidade |

---

## Referências Cruzadas

- **env-secrets-manager** — Higiene de arquivo `.env` local, detecção de vazamentos, consciência de deriva
- **senior-secops** — Operações de segurança, resposta a incidentes, modelagem de ameaças
- **ci-cd-pipeline-builder** — Design de pipeline onde os segredos são consumidos
- **docker-development** — Padrões de injeção de segredos em containers
- **helm-chart-builder** — Gerenciamento de segredos Kubernetes em charts Helm
