---
name: "aws-solution-architect"
description: Projete arquiteturas AWS para startups usando padrões serverless e templates de IaC. Use ao projetar arquitetura serverless, criar templates CloudFormation, otimizar custos AWS, configurar pipelines CI/CD ou migrar para AWS. Cobre Lambda, API Gateway, DynamoDB, ECS, Aurora e otimização de custos.
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# AWS Solution Architect

Projete arquiteturas AWS escaláveis e econômicas para startups com templates de infraestrutura como código.

---

## Fluxo de Trabalho

### Passo 1: Coletar Requisitos

Coletar especificações da aplicação:

```
- Tipo de aplicação (web app, mobile backend, pipeline de dados, SaaS)
- Usuários esperados e requisições por segundo
- Restrições de orçamento (limite de gasto mensal)
- Tamanho da equipe e nível de experiência com AWS
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
  "service_stack": ["S3", "CloudFront", "API Gateway", "Lambda", "DynamoDB", "Cognito"],
  "estimated_monthly_cost_usd": 35,
  "pros": ["Low ops overhead", "Pay-per-use", "Auto-scaling"],
  "cons": ["Cold starts", "15-min Lambda limit", "Eventual consistency"]
}
```

Selecionar dos padrões recomendados:
- **Serverless Web**: S3 + CloudFront + API Gateway + Lambda + DynamoDB
- **Microsserviços Orientados a Eventos**: EventBridge + Lambda + SQS + Step Functions
- **Three-Tier**: ALB + ECS Fargate + Aurora + ElastiCache
- **GraphQL Backend**: AppSync + Lambda + DynamoDB + Cognito

Veja `references/architecture_patterns.md` para especificações detalhadas dos padrões.

**Ponto de verificação:** Confirmar que o padrão recomendado corresponde à maturidade operacional da equipe e aos requisitos de conformidade antes de prosseguir para o Passo 3.

### Passo 3: Gerar Templates de IaC

Criar infraestrutura como código para o padrão selecionado:

```bash
# Stack serverless (CloudFormation)
python scripts/serverless_stack.py --app-name my-app --region us-east-1
```

**Exemplo de saída CloudFormation YAML (recursos serverless principais):**

```yaml
AWSTemplateFormatVersion: '2010-09-09'
Transform: AWS::Serverless-2016-10-31

Parameters:
  AppName:
    Type: String
    Default: my-app

Resources:
  ApiFunction:
    Type: AWS::Serverless::Function
    Properties:
      Handler: index.handler
      Runtime: nodejs20.x
      MemorySize: 512
      Timeout: 30
      Environment:
        Variables:
          TABLE_NAME: !Ref DataTable
      Policies:
        - DynamoDBCrudPolicy:
            TableName: !Ref DataTable
      Events:
        ApiEvent:
          Type: Api
          Properties:
            Path: /{proxy+}
            Method: ANY

  DataTable:
    Type: AWS::DynamoDB::Table
    Properties:
      BillingMode: PAY_PER_REQUEST
      AttributeDefinitions:
        - AttributeName: pk
          AttributeType: S
        - AttributeName: sk
          AttributeType: S
      KeySchema:
        - AttributeName: pk
          KeyType: HASH
        - AttributeName: sk
          KeyType: RANGE
```

> Templates completos incluindo API Gateway, Cognito, funções IAM e logging CloudWatch são gerados por `serverless_stack.py` e também disponíveis em `references/architecture_patterns.md`.

**Exemplo de snippet CDK TypeScript (padrão three-tier):**

```typescript
import * as ecs from 'aws-cdk-lib/aws-ecs';
import * as ec2 from 'aws-cdk-lib/aws-ec2';
import * as rds from 'aws-cdk-lib/aws-rds';

const vpc = new ec2.Vpc(this, 'AppVpc', { maxAzs: 2 });

const cluster = new ecs.Cluster(this, 'AppCluster', { vpc });

const db = new rds.ServerlessCluster(this, 'AppDb', {
  engine: rds.DatabaseClusterEngine.auroraPostgres({
    version: rds.AuroraPostgresEngineVersion.VER_15_2,
  }),
  vpc,
  scaling: { minCapacity: 0.5, maxCapacity: 4 },
});
```

### Passo 4: Revisar Custos

Analisar custos estimados e oportunidades de otimização:

```bash
python scripts/cost_optimizer.py --resources current_setup.json --monthly-spend 2000
```

**Exemplo de saída:**

```json
{
  "current_monthly_usd": 2000,
  "recommendations": [
    { "action": "Right-size RDS db.r5.2xlarge → db.r5.large", "savings_usd": 420, "priority": "high" },
    { "action": "Purchase 1-yr Compute Savings Plan at 40% utilization", "savings_usd": 310, "priority": "high" },
    { "action": "Move S3 objects >90 days to Glacier Instant Retrieval", "savings_usd": 85, "priority": "medium" }
  ],
  "total_potential_savings_usd": 815
}
```

A saída inclui:
- Detalhamento de custos mensais por serviço
- Recomendações de dimensionamento correto
- Oportunidades de Savings Plans
- Economia mensal potencial

### Passo 5: Implantar

Implantar a infraestrutura gerada:

```bash
# CloudFormation
aws cloudformation create-stack \
  --stack-name my-app-stack \
  --template-body file://template.yaml \
  --capabilities CAPABILITY_IAM

# CDK
cdk deploy

# Terraform
terraform init && terraform apply
```

### Passo 6: Validar e Lidar com Falhas

Verificar implantação e configurar monitoramento:

```bash
# Verificar status da stack
aws cloudformation describe-stacks --stack-name my-app-stack

# Configurar alarmes CloudWatch
aws cloudwatch put-metric-alarm --alarm-name high-errors ...
```

**Se a criação da stack falhar:**

1. Verificar o motivo da falha:
   ```bash
   aws cloudformation describe-stack-events \
     --stack-name my-app-stack \
     --query 'StackEvents[?ResourceStatus==`CREATE_FAILED`]'
   ```
2. Revisar logs CloudWatch para erros de Lambda ou ECS.
3. Corrigir o template ou a configuração de recurso.
4. Excluir a stack com falha antes de tentar novamente:
   ```bash
   aws cloudformation delete-stack --stack-name my-app-stack
   # Aguardar a exclusão
   aws cloudformation wait stack-delete-complete --stack-name my-app-stack
   # Reimplantar
   aws cloudformation create-stack ...
   ```

**Causas comuns de falha:**
- Erros de permissão IAM → verificar `--capabilities CAPABILITY_IAM` e políticas de confiança de papel
- Limite de recursos excedido → solicitar aumento de cota via console de Cotas de Serviço
- Sintaxe de template inválida → executar `aws cloudformation validate-template --template-body file://template.yaml` antes de implantar

---

## Ferramentas

### architecture_designer.py

Gera padrões de arquitetura com base em requisitos.

```bash
python scripts/architecture_designer.py --input requirements.json --output design.json
```

**Entrada:** JSON com tipo de aplicação, escala, orçamento, necessidades de conformidade
**Saída:** Padrão recomendado, stack de serviços, estimativa de custo, prós/contras

### serverless_stack.py

Cria templates serverless CloudFormation.

```bash
python scripts/serverless_stack.py --app-name my-app --region us-east-1
```

**Saída:** CloudFormation YAML pronto para produção com:
- API Gateway + Lambda
- Tabela DynamoDB
- Pool de usuários Cognito
- Funções IAM com menor privilégio
- Logging CloudWatch

### cost_optimizer.py

Analisa custos e recomenda otimizações.

```bash
python scripts/cost_optimizer.py --resources inventory.json --monthly-spend 5000
```

**Saída:** Recomendações para:
- Remoção de recursos ociosos
- Dimensionamento correto de instâncias
- Compras de capacidade reservada
- Transições de camada de armazenamento
- Alternativas ao NAT Gateway

---

## Início Rápido

### Arquitetura MVP (< $100/mês)

```
Peça: "Projete um backend serverless MVP para um aplicativo móvel com 1000 usuários"

Resultado:
- Lambda + API Gateway para API
- DynamoDB pay-per-request para dados
- Cognito para autenticação
- S3 + CloudFront para ativos estáticos
- Estimativa: $20-50/mês
```

### Arquitetura de Escala ($500-2000/mês)

```
Peça: "Projete uma arquitetura escalável para uma plataforma SaaS com 50k usuários"

Resultado:
- ECS Fargate para API em container
- Aurora Serverless para dados relacionais
- ElastiCache para cache de sessão
- CloudFront para CDN
- CodePipeline para CI/CD
- Implantação Multi-AZ
```

### Otimização de Custos

```
Peça: "Otimize meu setup AWS para reduzir custos em 30%. Gasto atual: $3000/mês"

Forneça: Inventário de recursos atuais (EC2, RDS, S3, etc.)

Resultado:
- Identificação de recursos ociosos
- Recomendações de dimensionamento correto
- Análise de Savings Plans
- Políticas de ciclo de vida de armazenamento
- Economia alvo: $900/mês
```

### Geração de IaC

```
Peça: "Gere CloudFormation para um web app three-tier com auto-scaling"

Resultado:
- VPC com subnets públicas/privadas
- ALB com HTTPS
- ECS Fargate com auto-scaling
- Aurora com réplicas de leitura
- Security groups e funções IAM
```

---

## Requisitos de Entrada

Fornecer estes detalhes para o design de arquitetura:

| Requisito | Descrição | Exemplo |
|-------------|-------------|---------|
| Tipo de aplicação | O que você está construindo | Plataforma SaaS, mobile backend |
| Escala esperada | Usuários, requisições/seg | 10k usuários, 100 RPS |
| Orçamento | Limite mensal AWS | $500/mês máximo |
| Contexto da equipe | Tamanho, experiência AWS | 3 devs, intermediário |
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
  "aws_experience": "intermediate",
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

- **CloudFormation YAML**: Templates SAM/CFN prontos para produção
- **CDK TypeScript**: Código de infraestrutura type-safe
- **Terraform HCL**: Configurações compatíveis com multi-cloud

### Análise de Custos

- Detalhamento do gasto atual com recomendações de otimização
- Lista de ações priorizadas (alta/média/baixa) e lista de verificação de implementação

---

## Documentação de Referência

| Documento | Conteúdo |
|----------|----------|
| `references/architecture_patterns.md` | 6 padrões: serverless, microsserviços, three-tier, processamento de dados, GraphQL, multi-região |
| `references/service_selection.md` | Matrizes de decisão para computação, banco de dados, armazenamento, mensageria |
| `references/best_practices.md` | Design serverless, otimização de custos, hardening de segurança, escalabilidade |
