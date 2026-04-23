---
name: "gcp-cloud-architect"
description: "Projete arquiteturas GCP para startups e empresas. Use ao projetar infraestrutura Google Cloud, implantar no GKE ou Cloud Run, configurar pipelines BigQuery, otimizar custos GCP ou migrar para GCP. Cobre Cloud Run, GKE, Cloud Functions, Cloud SQL, BigQuery e otimização de custos."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# GCP Cloud Architect

Projete arquiteturas Google Cloud escaláveis e econômicas para startups e empresas com templates de infraestrutura como código.

---

## Fluxo de Trabalho

### Passo 1: Coletar Requisitos

Coletar especificações da aplicação:

```
- Tipo de aplicação (web app, mobile backend, pipeline de dados, SaaS)
- Usuários esperados e requisições por segundo
- Restrições de orçamento (limite de gasto mensal)
- Tamanho da equipe e nível de experiência com GCP
- Requisitos de conformidade (LGPD, ANVISA, SOC 2)
- Requisitos de disponibilidade (SLA, RPO/RTO)
```

### Passo 2: Projetar Arquitetura

Executar o designer de arquitetura para obter recomendações de padrão:

```bash
python scripts/architecture_designer.py --input requirements.json
```

**Exemplo de saída:**

```json
{
  "recommended_pattern": "serverless_web",
  "service_stack": ["Cloud Storage", "Cloud CDN", "Cloud Run", "Firestore", "Identity Platform"],
  "estimated_monthly_cost_usd": 30,
  "pros": ["Low ops overhead", "Pay-per-use", "Auto-scaling", "No cold starts on Cloud Run min instances"],
  "cons": ["Vendor lock-in", "Regional limitations", "Eventual consistency with Firestore"]
}
```

Selecionar dos padrões recomendados:
- **Serverless Web**: Cloud Storage + Cloud CDN + Cloud Run + Firestore
- **Microsserviços no GKE**: GKE Autopilot + Cloud SQL + Memorystore + Cloud Pub/Sub
- **Pipeline de Dados Serverless**: Pub/Sub + Dataflow + BigQuery + Looker
- **Plataforma ML**: Vertex AI + Cloud Storage + BigQuery + Cloud Functions

Veja `references/architecture_patterns.md` para especificações detalhadas dos padrões.

**Ponto de verificação:** Confirmar que o padrão recomendado corresponde à maturidade operacional da equipe e aos requisitos de conformidade antes de prosseguir para o Passo 3.

### Passo 3: Estimar Custos

Analisar custos estimados e oportunidades de otimização:

```bash
python scripts/cost_optimizer.py --resources current_setup.json --monthly-spend 2000
```

**Exemplo de saída:**

```json
{
  "current_monthly_usd": 2000,
  "recommendations": [
    { "action": "Right-size Cloud SQL db-custom-4-16384 to db-custom-2-8192", "savings_usd": 380, "priority": "high" },
    { "action": "Purchase 1-yr committed use discount for GKE nodes", "savings_usd": 290, "priority": "high" },
    { "action": "Move Cloud Storage objects >90 days to Nearline", "savings_usd": 75, "priority": "medium" }
  ],
  "total_potential_savings_usd": 745
}
```

A saída inclui:
- Detalhamento de custos mensais por serviço
- Recomendações de dimensionamento correto
- Oportunidades de desconto por uso comprometido
- Análise de desconto por uso sustentado
- Economia mensal potencial

Use a [Calculadora de Preços GCP](https://cloud.google.com/products/calculator) para estimativas detalhadas.

### Passo 4: Gerar IaC

Criar infraestrutura como código para o padrão selecionado:

```bash
python scripts/deployment_manager.py --app-name my-app --pattern serverless_web --region us-central1
```

**Exemplo de saída Terraform HCL (Cloud Run + Firestore):**

```hcl
terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = var.region
}

variable "project_id" {
  description = "GCP project ID"
  type        = string
}

variable "region" {
  description = "GCP region"
  type        = string
  default     = "us-central1"
}

resource "google_cloud_run_v2_service" "api" {
  name     = "${var.environment}-${var.app_name}-api"
  location = var.region

  template {
    containers {
      image = "gcr.io/${var.project_id}/${var.app_name}:latest"
      resources {
        limits = {
          cpu    = "1000m"
          memory = "512Mi"
        }
      }
      env {
        name  = "FIRESTORE_PROJECT"
        value = var.project_id
      }
    }
    scaling {
      min_instance_count = 0
      max_instance_count = 10
    }
  }
}

resource "google_firestore_database" "default" {
  project     = var.project_id
  name        = "(default)"
  location_id = var.region
  type        = "FIRESTORE_NATIVE"
}
```

**Exemplo de implantação via gcloud CLI:**

```bash
# Implantar serviço Cloud Run
gcloud run deploy my-app-api \
  --image gcr.io/$PROJECT_ID/my-app:latest \
  --region us-central1 \
  --platform managed \
  --allow-unauthenticated \
  --memory 512Mi \
  --cpu 1 \
  --min-instances 0 \
  --max-instances 10

# Criar banco de dados Firestore
gcloud firestore databases create --location=us-central1
```

> Templates completos incluindo Cloud CDN, Identity Platform, IAM e Cloud Monitoring são gerados por `deployment_manager.py` e também disponíveis em `references/architecture_patterns.md`.

### Passo 5: Configurar CI/CD

Configurar implantação automatizada com Cloud Build ou GitHub Actions:

```yaml
# cloudbuild.yaml
steps:
  - name: 'gcr.io/cloud-builders/docker'
    args: ['build', '-t', 'gcr.io/$PROJECT_ID/my-app:$COMMIT_SHA', '.']

  - name: 'gcr.io/cloud-builders/docker'
    args: ['push', 'gcr.io/$PROJECT_ID/my-app:$COMMIT_SHA']

  - name: 'gcr.io/google.com/cloudsdktool/cloud-sdk'
    entrypoint: gcloud
    args:
      - 'run'
      - 'deploy'
      - 'my-app-api'
      - '--image=gcr.io/$PROJECT_ID/my-app:$COMMIT_SHA'
      - '--region=us-central1'
      - '--platform=managed'

images:
  - 'gcr.io/$PROJECT_ID/my-app:$COMMIT_SHA'
```

```bash
# Conectar repositório e criar gatilho
gcloud builds triggers create github \
  --repo-name=my-app \
  --repo-owner=my-org \
  --branch-pattern="^main$" \
  --build-config=cloudbuild.yaml
```

### Passo 6: Revisão de Segurança

Verificar configuração de segurança:

```bash
# Revisar vinculações IAM
gcloud projects get-iam-policy $PROJECT_ID --format=json

# Verificar permissões de conta de serviço
gcloud iam service-accounts list --project=$PROJECT_ID

# Verificar VPC Service Controls (se aplicável)
gcloud access-context-manager perimeters list --policy=$POLICY_ID
```

**Lista de verificação de segurança:**
- Papéis IAM seguem o menor privilégio (prefira papéis predefinidos a papéis básicos)
- Contas de serviço usam Workload Identity para GKE
- VPC Service Controls configurados para APIs sensíveis
- Chaves de criptografia Cloud KMS para criptografia gerenciada pelo cliente
- Cloud Audit Logs habilitado para toda atividade administrativa
- Políticas de organização restringem acesso público
- Secret Manager usado para todas as credenciais

**Se a implantação falhar:**

1. Verificar o motivo da falha:
   ```bash
   gcloud run services describe my-app-api --region us-central1
   gcloud logging read "resource.type=cloud_run_revision" --limit=20
   ```
2. Revisar Cloud Logging para erros de aplicação.
3. Corrigir a configuração ou imagem de container.
4. Reimplantar:
   ```bash
   gcloud run deploy my-app-api --image gcr.io/$PROJECT_ID/my-app:latest --region us-central1
   ```

**Causas comuns de falha:**
- Erros de permissão IAM — verificar papéis de conta de serviço e flag `--allow-unauthenticated`
- Cota excedida — solicitar aumento de cota via IAM & Admin > Cotas
- Falha de inicialização do container — verificar logs de container e configuração de health check
- Região não habilitada — habilitar as APIs necessárias com `gcloud services enable`

---

## Ferramentas

### architecture_designer.py

Recomenda serviços GCP com base em requisitos de carga de trabalho.

```bash
python scripts/architecture_designer.py --input requirements.json --output design.json
```

**Entrada:** JSON com tipo de aplicação, escala, orçamento, necessidades de conformidade
**Saída:** Padrão recomendado, stack de serviços, estimativa de custo, prós/contras

### cost_optimizer.py

Analisa recursos GCP para economia de custos.

```bash
python scripts/cost_optimizer.py --resources inventory.json --monthly-spend 5000
```

**Saída:** Recomendações para:
- Remoção de recursos ociosos
- Dimensionamento correto de tipos de máquina
- Descontos por uso comprometido
- Transições de classe de armazenamento
- Otimização de egresso de rede

### deployment_manager.py

Gera scripts de implantação gcloud CLI e configurações Terraform.

```bash
python scripts/deployment_manager.py --app-name my-app --pattern serverless_web --region us-central1
```

**Saída:** Scripts de implantação prontos para produção com:
- Implantação Cloud Run ou GKE
- Configuração Firestore ou Cloud SQL
- Configuração Identity Platform
- Papéis IAM com menor privilégio
- Cloud Monitoring e Logging

---

## Início Rápido

### Web App no Cloud Run (< $100/mês)

```
Peça: "Projete um backend web serverless para um aplicativo móvel com 1000 usuários"

Resultado:
- Cloud Run para API (auto-scaling, sem cold start com min instances)
- Firestore para dados (pay-per-operation)
- Identity Platform para autenticação
- Cloud Storage + Cloud CDN para ativos estáticos
- Estimativa: $15-40/mês
```

### Microsserviços no GKE ($500-2000/mês)

```
Peça: "Projete uma arquitetura escalável para uma plataforma SaaS com 50k usuários"

Resultado:
- GKE Autopilot para cargas de trabalho em container
- Cloud SQL (PostgreSQL) com réplicas de leitura
- Memorystore (Redis) para cache de sessão
- Cloud CDN para entrega global
- Cloud Build para CI/CD
- Implantação multi-zona
```

### Pipeline de Dados Serverless

```
Peça: "Projete um pipeline de analytics em tempo real para dados de eventos"

Resultado:
- Pub/Sub para ingestão de eventos
- Dataflow (Apache Beam) para processamento de stream
- BigQuery para analytics e warehouse
- Looker para dashboards
- Cloud Functions para transformações leves
```

### Plataforma ML

```
Peça: "Projete uma plataforma de machine learning para treinamento e servindo de modelos"

Resultado:
- Vertex AI para treinamento e predição
- Cloud Storage para datasets e artefatos de modelo
- BigQuery para feature store
- Cloud Functions para gatilhos de pré-processamento
- Cloud Monitoring para detecção de drift de modelo
```

---

## Requisitos de Entrada

Fornecer estes detalhes para o design de arquitetura:

| Requisito | Descrição | Exemplo |
|-------------|-------------|---------|
| Tipo de aplicação | O que você está construindo | Plataforma SaaS, mobile backend |
| Escala esperada | Usuários, requisições/seg | 10k usuários, 100 RPS |
| Orçamento | Limite mensal GCP | $500/mês máximo |
| Contexto da equipe | Tamanho, experiência GCP | 3 devs, intermediário |
| Conformidade | Necessidades regulatórias | ANVISA, LGPD, SOC 2 |
| Disponibilidade | Requisitos de uptime | SLA 99.9%, 1hr RPO |

**Formato JSON:**

```json
{
  "application_type": "saas_platform",
  "expected_users": 10000,
  "requests_per_second": 100,
  "budget_monthly_usd": 500,
  "team_size": 3,
  "gcp_experience": "intermediate",
  "compliance": ["SOC2"],
  "availability_sla": "99.9%"
}
```

---

## Formatos de Saída

### Design de Arquitetura

- Recomendação de padrão com justificativa
- Diagrama de stack de serviços (ASCII)
- Estimativa de custo mensal e trade-offs

### Templates de IaC

- **Terraform HCL**: Configurações do provedor Google prontas para produção
- **gcloud CLI**: Comandos de implantação via script
- **Cloud Build YAML**: Definições de pipeline CI/CD

### Análise de Custos

- Detalhamento do gasto atual com recomendações de otimização
- Lista de ações priorizadas (alta/média/baixa) e lista de verificação de implementação

---

## Anti-Padrões

| Anti-Padrão | Por que Falha | Abordagem Correta |
|---|---|---|
| Usar VPC padrão para produção | Sem isolamento, regras de firewall compartilhadas | Criar VPC personalizada com subnets privadas |
| Superprovisionamento de node pools GKE | Custo desperdiçado em capacidade ociosa | Use GKE Autopilot ou cluster autoscaler |
| Armazenar segredos em variáveis de ambiente | Visível no Console Cloud, logs | Use Secret Manager com Workload Identity |
| Ignorar descontos por uso sustentado | Perder 20-30% de economia automática | Dimensionar corretamente VMs para uso de linha de base consistente |
| Implantação em região única para SaaS | Uma interrupção de região = downtime total | Multi-região com Cloud Load Balancing |
| BigQuery on-demand para cargas pesadas | Custos imprevisíveis em escala | Use slots BigQuery (taxa fixa) para cargas de trabalho consistentes |
| Executar Cloud Functions para tarefas longas | Timeout de 9 minutos, cold starts | Use Cloud Run para tarefas > 60 segundos |

---

## Referências Cruzadas

| Skill | Relação |
|-------|-------------|
| `engineering-team/aws-solution-architect` | Equivalente AWS — mesmo fluxo de trabalho de 6 passos, serviços diferentes |
| `engineering-team/azure-cloud-architect` | Equivalente Azure — completa a trifeta de nuvem |
| `engineering-team/senior-devops` | Escopo DevOps mais amplo — pipelines, monitoramento, containerização |
| `engineering/terraform-patterns` | Implementação de IaC — use para módulos Terraform direcionados ao GCP |
| `engineering/ci-cd-pipeline-builder` | Construção de pipeline — automatiza Cloud Build e implantação |

---

## Documentação de Referência

| Documento | Conteúdo |
|----------|----------|
| `references/architecture_patterns.md` | 6 padrões: serverless, microsserviços GKE, three-tier, pipeline de dados, plataforma ML, multi-região |
| `references/service_selection.md` | Matrizes de decisão para computação, banco de dados, armazenamento, mensageria |
| `references/best_practices.md` | Nomenclatura, labels, IAM, rede, monitoramento, recuperação de desastre |
