---
name: "azure-cloud-architect"
description: "Projete arquiteturas Azure para startups e empresas. Use ao projetar infraestrutura Azure, criar templates Bicep/ARM, otimizar custos Azure, configurar pipelines Azure DevOps ou migrar para Azure. Cobre AKS, App Service, Azure Functions, Cosmos DB e otimização de custos."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Azure Cloud Architect

Projete arquiteturas Azure escaláveis e econômicas para startups e empresas com templates de infraestrutura como código Bicep.

---

## Fluxo de Trabalho

### Passo 1: Coletar Requisitos

Coletar especificações da aplicação:

```
- Tipo de aplicação (web app, mobile backend, pipeline de dados, SaaS, microsserviços)
- Usuários esperados e requisições por segundo
- Restrições de orçamento (limite de gasto mensal)
- Tamanho da equipe e nível de experiência com Azure
- Requisitos de conformidade (LGPD, ANVISA, SOC 2, ISO 27001)
- Requisitos de disponibilidade (SLA, RPO/RTO)
- Preferências de região (residência de dados, latência)
```

### Passo 2: Projetar Arquitetura

Executar o designer de arquitetura para obter recomendações de padrão:

```bash
python scripts/architecture_designer.py \
  --app-type web_app \
  --users 10000 \
  --requirements '{"budget_monthly_usd": 500, "compliance": ["SOC2"]}'
```

**Exemplo de saída:**

```json
{
  "recommended_pattern": "app_service_web",
  "service_stack": ["App Service", "Azure SQL", "Front Door", "Key Vault", "Entra ID"],
  "estimated_monthly_cost_usd": 280,
  "pros": ["Managed platform", "Built-in autoscale", "Deployment slots"],
  "cons": ["Less control than VMs", "Platform constraints", "Cold start on consumption plans"]
}
```

Selecionar dos padrões recomendados:
- **App Service Web**: Front Door + App Service + Azure SQL + Redis Cache
- **Microsserviços no AKS**: AKS + Service Bus + Cosmos DB + API Management
- **Serverless Orientado a Eventos**: Functions + Event Grid + Service Bus + Cosmos DB
- **Pipeline de Dados**: Data Factory + Synapse Analytics + Data Lake Storage + Event Hubs

Veja `references/architecture_patterns.md` para especificações detalhadas dos padrões.

**Ponto de verificação:** Confirmar que o padrão recomendado corresponde à maturidade operacional da equipe e aos requisitos de conformidade antes de prosseguir para o Passo 3.

### Passo 3: Gerar Templates de IaC

Criar infraestrutura como código para o padrão selecionado:

```bash
# Stack de web app (Bicep)
python scripts/bicep_generator.py --arch-type web-app --output main.bicep
```

**Exemplo de saída Bicep (recursos principais de web app):**

```bicep
@description('The environment name')
param environment string = 'dev'

@description('The Azure region for resources')
param location string = resourceGroup().location

@description('The application name')
param appName string = 'myapp'

// App Service Plan
resource appServicePlan 'Microsoft.Web/serverfarms@2023-01-01' = {
  name: '${environment}-${appName}-plan'
  location: location
  sku: {
    name: 'P1v3'
    tier: 'PremiumV3'
    capacity: 1
  }
  properties: {
    reserved: true // Linux
  }
}

// App Service
resource appService 'Microsoft.Web/sites@2023-01-01' = {
  name: '${environment}-${appName}-web'
  location: location
  properties: {
    serverFarmId: appServicePlan.id
    httpsOnly: true
    siteConfig: {
      linuxFxVersion: 'NODE|20-lts'
      minTlsVersion: '1.2'
      ftpsState: 'Disabled'
      alwaysOn: true
    }
  }
  identity: {
    type: 'SystemAssigned'
  }
}

// Azure SQL Database
resource sqlServer 'Microsoft.Sql/servers@2023-05-01-preview' = {
  name: '${environment}-${appName}-sql'
  location: location
  properties: {
    administrators: {
      azureADOnlyAuthentication: true
    }
    minimalTlsVersion: '1.2'
  }
}

resource sqlDatabase 'Microsoft.Sql/servers/databases@2023-05-01-preview' = {
  parent: sqlServer
  name: '${appName}-db'
  location: location
  sku: {
    name: 'GP_S_Gen5_2'
    tier: 'GeneralPurpose'
  }
  properties: {
    autoPauseDelay: 60
    minCapacity: json('0.5')
  }
}
```

> Templates completos incluindo Front Door, Key Vault, Managed Identity e monitoramento são gerados por `bicep_generator.py` e também disponíveis em `references/architecture_patterns.md`.

**Bicep é a linguagem de IaC recomendada para Azure.** Prefira Bicep em vez de templates ARM JSON: Bicep compila para ARM JSON, tem sintaxe mais limpa, suporta módulos e tem suporte de primeira parte da Microsoft.

### Passo 4: Revisar Custos

Analisar custos estimados e oportunidades de otimização:

```bash
python scripts/cost_optimizer.py \
  --config current_resources.json \
  --json
```

**Exemplo de saída:**

```json
{
  "current_monthly_usd": 2000,
  "recommendations": [
    { "action": "Right-size SQL Database GP_S_Gen5_8 to GP_S_Gen5_2", "savings_usd": 380, "priority": "high" },
    { "action": "Purchase 1-year Reserved Instances for AKS node pools", "savings_usd": 290, "priority": "high" },
    { "action": "Move Blob Storage to Cool tier for objects >30 days old", "savings_usd": 65, "priority": "medium" }
  ],
  "total_potential_savings_usd": 735
}
```

A saída inclui:
- Detalhamento de custos mensais por serviço
- Recomendações de dimensionamento correto
- Oportunidades de Instâncias Reservadas e Savings Plan
- Economia mensal potencial

### Passo 5: Configurar CI/CD

Configurar Azure DevOps Pipelines ou GitHub Actions com Azure:

```yaml
# GitHub Actions — implantar Bicep no Azure
name: Deploy Infrastructure
on:
  push:
    branches: [main]

permissions:
  id-token: write
  contents: read

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - uses: azure/login@v2
        with:
          client-id: ${{ secrets.AZURE_CLIENT_ID }}
          tenant-id: ${{ secrets.AZURE_TENANT_ID }}
          subscription-id: ${{ secrets.AZURE_SUBSCRIPTION_ID }}

      - uses: azure/arm-deploy@v2
        with:
          resourceGroupName: rg-myapp-dev
          template: ./infra/main.bicep
          parameters: environment=dev
```

```yaml
# Azure DevOps Pipeline
trigger:
  branches:
    include:
      - main

pool:
  vmImage: 'ubuntu-latest'

steps:
  - task: AzureCLI@2
    inputs:
      azureSubscription: 'MyServiceConnection'
      scriptType: 'bash'
      scriptLocation: 'inlineScript'
      inlineScript: |
        az deployment group create \
          --resource-group rg-myapp-dev \
          --template-file infra/main.bicep \
          --parameters environment=dev
```

### Passo 6: Revisão de Segurança

Validar postura de segurança antes da produção:

- **Identidade**: Entra ID (Azure AD) com RBAC, Managed Identity para autenticação serviço-a-serviço — nunca armazene credenciais no código
- **Segredos**: Key Vault para todos os segredos, certificados e strings de conexão
- **Rede**: NSGs em todas as subnets, Private Endpoints para serviços PaaS, Application Gateway com WAF
- **Criptografia**: TLS 1.2+ em trânsito, chaves gerenciadas pelo Azure ou pelo cliente em repouso
- **Monitoramento**: Microsoft Defender for Cloud ativado, Azure Policy para guardrails
- **Conformidade**: Atribuições de Azure Policy para iniciativas SOC 2 / ANVISA / ISO 27001

**Se a implantação falhar:**

1. Verificar o status da implantação:
   ```bash
   az deployment group show \
     --resource-group rg-myapp-dev \
     --name main \
     --query 'properties.error'
   ```
2. Revisar o Log de Atividades para erros de RBAC ou política.
3. Validar o template Bicep antes de implantar:
   ```bash
   az bicep build --file main.bicep
   az deployment group validate \
     --resource-group rg-myapp-dev \
     --template-file main.bicep
   ```

**Causas comuns de falha:**
- Erros de permissão RBAC — verificar se o principal de implantação tem Contributor no grupo de recursos
- Provedor de recursos não registrado — executar `az provider register --namespace Microsoft.Web`
- Conflitos de nomenclatura — nomes de recursos Azure geralmente são únicos globalmente (contas de armazenamento, web apps)
- Cota excedida — solicitar aumento de cota via Portal Azure > Assinaturas > Uso + cotas

---

## Ferramentas

### architecture_designer.py

Gera recomendações de padrão de arquitetura com base em requisitos.

```bash
python scripts/architecture_designer.py \
  --app-type web_app \
  --users 50000 \
  --requirements '{"budget_monthly_usd": 1000, "compliance": ["ANVISA"]}' \
  --json
```

**Entrada:** Tipo de aplicação, usuários esperados, requisitos JSON
**Saída:** Padrão recomendado, stack de serviços, estimativa de custo, prós/contras

### cost_optimizer.py

Analisa configurações de recursos Azure para economia de custos.

```bash
python scripts/cost_optimizer.py --config resources.json --json
```

**Entrada:** Arquivo JSON com inventário atual de recursos Azure
**Saída:** Recomendações para:
- Remoção de recursos ociosos
- Dimensionamento correto de VMs e bancos de dados
- Compras de Instâncias Reservadas
- Transições de camada de armazenamento
- IPs públicos e load balancers não utilizados

### bicep_generator.py

Gera scaffolds de template Bicep a partir do tipo de arquitetura.

```bash
python scripts/bicep_generator.py --arch-type microservices --output main.bicep
```

**Saída:** Templates Bicep prontos para produção com:
- Managed Identity (sem senhas)
- Integração com Key Vault
- Configurações de diagnóstico para Azure Monitor
- Network security groups
- Tags para alocação de custos

---

## Início Rápido

### Arquitetura de Web App (< $100/mês)

```
Peça: "Projete um web app Azure para uma startup com 5000 usuários"

Resultado:
- App Service (B1 Linux) para a aplicação
- Azure SQL Serverless para dados relacionais
- Azure Blob Storage para ativos estáticos
- Front Door (camada gratuita) para CDN e roteamento
- Key Vault para segredos
- Estimativa: $40-80/mês
```

### Microsserviços no AKS ($500-2000/mês)

```
Peça: "Projete uma arquitetura de microsserviços no Azure para uma plataforma SaaS com 50k usuários"

Resultado:
- Cluster AKS com 3 node pools (sistema, app, jobs)
- API Management para gateway e limitação de taxa
- Cosmos DB para dados multi-modelo
- Service Bus para mensageria assíncrona
- Azure Monitor + Application Insights para observabilidade
- Implantação multi-zona
```

### Serverless Orientado a Eventos (< $200/mês)

```
Peça: "Projete um backend orientado a eventos para processamento de pedidos"

Resultado:
- Azure Functions (plano Consumption) para computação
- Event Grid para roteamento de eventos
- Service Bus para mensageria confiável
- Cosmos DB para dados de pedidos
- Application Insights para monitoramento
- Estimativa: $30-150/mês dependendo do volume
```

### Pipeline de Dados ($300-1500/mês)

```
Peça: "Projete um pipeline de dados para ingestão de 10M eventos/dia"

Resultado:
- Event Hubs para ingestão
- Stream Analytics ou Functions para processamento
- Data Lake Storage Gen2 para dados brutos
- Synapse Analytics para warehouse
- Power BI para dashboards
```

---

## Requisitos de Entrada

Fornecer estes detalhes para o design de arquitetura:

| Requisito | Descrição | Exemplo |
|-------------|-------------|---------|
| Tipo de aplicação | O que você está construindo | Plataforma SaaS, mobile backend |
| Escala esperada | Usuários, requisições/seg | 10k usuários, 100 RPS |
| Orçamento | Limite mensal Azure | $500/mês máximo |
| Contexto da equipe | Tamanho, experiência Azure | 3 devs, intermediário |
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
  "azure_experience": "intermediate",
  "compliance": ["SOC2"],
  "availability_sla": "99.9%"
}
```

---

## Anti-Padrões

| Anti-Padrão | Por que Falha | Alternativa Correta |
|---|---|---|
| Templates ARM JSON para novos projetos | Verboso, difícil de ler, sem módulos | Use Bicep — compila para ARM, sintaxe mais limpa |
| Armazenar segredos nas Configurações do App | Segredos visíveis no portal, sem rotação | Use referências do Key Vault nas Configurações do App |
| Node pool AKS único e grande | Não é possível otimizar para cargas de trabalho diferentes | Use vários node pools: sistema, app, jobs |
| Endpoints públicos em serviços PaaS | Superfície de ataque exposta | Use Private Endpoints + integração VNet |
| Superprovisionamento "por precaução" | Desperdiça orçamento desde o primeiro mês | Comece pequeno, use autoscale, ajuste mensalmente |
| Grupos de recursos compartilhados para tudo | Raio de explosão, pesadelos de RBAC | Um grupo de recursos por ambiente por carga de trabalho |
| Sem estratégia de tags | Não é possível rastrear custos ou propriedade | Tague: environment, owner, cost-center, app-name |
| Usar recursos clássicos | Obsoletos, funcionalidades limitadas | Use recursos ARM/Bicep exclusivamente |

---

## Formatos de Saída

### Design de Arquitetura

- Recomendação de padrão com justificativa
- Diagrama de stack de serviços (ASCII)
- Estimativa de custo mensal e trade-offs

### Templates de IaC

- **Bicep**: Recomendado — suporte a módulos de primeira parte, sintaxe limpa
- **ARM JSON**: Gerado a partir de Bicep quando necessário
- **Terraform HCL**: Compatível com multi-cloud usando o provedor azurerm

### Análise de Custos

- Detalhamento do gasto atual com recomendações de otimização
- Lista de ações priorizadas (alta/média/baixa) e lista de verificação de implementação

---

## Referências Cruzadas

| Skill | Relação |
|-------|-------------|
| `engineering-team/aws-solution-architect` | Equivalente AWS — mesmo fluxo de trabalho de 6 passos, serviços diferentes |
| `engineering-team/gcp-cloud-architect` | Equivalente GCP — completa a trifeta de nuvem |
| `engineering-team/senior-devops` | Escopo DevOps mais amplo — pipelines, monitoramento, containerização |
| `engineering/terraform-patterns` | Implementação de IaC — use para módulos Terraform direcionados ao Azure |
| `engineering/ci-cd-pipeline-builder` | Construção de pipeline — automatiza Azure DevOps e GitHub Actions |

---

## Documentação de Referência

| Documento | Conteúdo |
|----------|----------|
| `references/architecture_patterns.md` | 5 padrões: web app, microsserviços/AKS, serverless, pipeline de dados, multi-região |
| `references/service_selection.md` | Matrizes de decisão para computação, banco de dados, armazenamento, mensageria, rede |
| `references/best_practices.md` | Convenções de nomenclatura, tags, RBAC, segurança de rede, monitoramento, DR |
