---
name: "senior-devops"
description: "Skill DevOps abrangente para CI/CD, automação de infraestrutura, containerização e plataformas cloud (AWS, GCP, Azure). Inclui configuração de pipeline, infraestrutura como código, automação de implantação e monitoramento. Use quando configurar pipelines, implantar aplicações, gerenciar infraestrutura, implementar monitoramento ou otimizar processos de implantação."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# DevOps Sênior

Kit completo de ferramentas para DevOps sênior com ferramentas modernas e melhores práticas.

## Início Rápido

### Capacidades Principais

Esta skill fornece três capacidades principais por meio de scripts automatizados:

```bash
# Script 1: Pipeline Generator — scaffolds pipelines CI/CD para GitHub Actions ou CircleCI
python scripts/pipeline_generator.py ./app --platform=github --stages=build,test,deploy

# Script 2: Terraform Scaffolder — gera e valida módulos IaC para AWS/GCP/Azure
python scripts/terraform_scaffolder.py ./infra --provider=aws --module=ecs-service --verbose

# Script 3: Deployment Manager — orquestra implantações de container com suporte a rollback
python3 scripts/deployment_manager.py ./deploy --verbose --json
```

## Capacidades Principais

### 1. Pipeline Generator

Scaffolds de configurações de pipeline CI/CD para GitHub Actions ou CircleCI, com stages de build, test, varredura de segurança e deploy.

**Exemplo — fluxo de trabalho GitHub Actions:**
```yaml
# .github/workflows/ci.yml
name: CI/CD Pipeline
on:
  push:
    branches: [main, develop]
  pull_request:
    branches: [main]

jobs:
  build-and-test:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Set up Node.js
        uses: actions/setup-node@v4
        with:
          node-version: '20'
          cache: 'npm'
      - run: npm ci
      - run: npm run lint
      - run: npm test -- --coverage
      - name: Upload coverage
        uses: codecov/codecov-action@v4

  build-docker:
    needs: build-and-test
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - name: Build and push image
        uses: docker/build-push-action@v5
        with:
          push: ${{ github.ref == 'refs/heads/main' }}
          tags: ghcr.io/${{ github.repository }}:${{ github.sha }}

  deploy:
    needs: build-docker
    if: github.ref == 'refs/heads/main'
    runs-on: ubuntu-latest
    steps:
      - name: Deploy to ECS
        run: |
          aws ecs update-service \
            --cluster production \
            --service app-service \
            --force-new-deployment
```

**Uso:**
```bash
python scripts/pipeline_generator.py <project-path> --platform=github|circleci --stages=build,test,deploy
```

### 2. Terraform Scaffolder

Gera, valida e planeja módulos Terraform. Aplica estrutura consistente de módulo e executa `terraform validate` + `terraform plan` antes de qualquer apply.

**Exemplo — módulo AWS ECS service:**
```hcl
# modules/ecs-service/main.tf
resource "aws_ecs_task_definition" "app" {
  family                   = var.service_name
  requires_compatibilities = ["FARGATE"]
  network_mode             = "awsvpc"
  cpu                      = var.cpu
  memory                   = var.memory

  container_definitions = jsonencode([{
    name      = var.service_name
    image     = var.container_image
    essential = true
    portMappings = [{
      containerPort = var.container_port
      protocol      = "tcp"
    }]
    environment = [for k, v in var.env_vars : { name = k, value = v }]
    logConfiguration = {
      logDriver = "awslogs"
      options = {
        awslogs-group         = "/ecs/${var.service_name}"
        awslogs-region        = var.aws_region
        awslogs-stream-prefix = "ecs"
      }
    }
  }])
}

resource "aws_ecs_service" "app" {
  name            = var.service_name
  cluster         = var.cluster_id
  task_definition = aws_ecs_task_definition.app.arn
  desired_count   = var.desired_count
  launch_type     = "FARGATE"

  network_configuration {
    subnets          = var.private_subnet_ids
    security_groups  = [aws_security_group.app.id]
    assign_public_ip = false
  }

  load_balancer {
    target_group_arn = aws_lb_target_group.app.arn
    container_name   = var.service_name
    container_port   = var.container_port
  }
}
```

**Uso:**
```bash
python scripts/terraform_scaffolder.py <target-path> --provider=aws|gcp|azure --module=ecs-service|gke-deployment|aks-service [--verbose]
```

### 3. Deployment Manager

Orquestra implantações com estratégias blue/green ou rolling, gates de health-check e rollback automático em caso de falha.

**Exemplo — implantação Kubernetes blue/green:**
```yaml
# k8s/deployment-blue.yaml
apiVersion: apps/v1
kind: Deployment
metadata:
  name: app-blue
  labels:
    app: myapp
    slot: blue      # label slot distingue blue de green
spec:
  replicas: 3
  selector:
    matchLabels:
      app: myapp
      slot: blue
  template:
    metadata:
      labels:
        app: myapp
        slot: blue
    spec:
      containers:
        - name: app
          image: ghcr.io/org/app:1.2.3
          readinessProbe:       # gate: pod deve passar antes do tráfego mudar
            httpGet:
              path: /healthz
              port: 8080
            initialDelaySeconds: 10
            periodSeconds: 5
          resources:
            requests:
              cpu: "250m"
              memory: "256Mi"
            limits:
              cpu: "500m"
              memory: "512Mi"
```

**Uso:**
```bash
python scripts/deployment_manager.py deploy \
  --env=staging|production \
  --image=app:1.2.3 \
  --strategy=blue-green|rolling \
  --health-check-url=https://app.example.com/healthz

python scripts/deployment_manager.py rollback --env=production --to-version=1.2.2
python scripts/deployment_manager.py --analyze --env=production   # auditar estado atual
```

## Recursos

- Referência de Padrões: `references/cicd_pipeline_guide.md` — padrões CI/CD detalhados, melhores práticas, anti-padrões
- Guia de Fluxo de Trabalho: `references/infrastructure_as_code.md` — processos passo a passo de IaC, otimização, solução de problemas
- Guia Técnico: `references/deployment_strategies.md` — configurações de estratégia de implantação, considerações de segurança, escalabilidade
- Scripts de Ferramentas: diretório `scripts/`

## Fluxo de Trabalho de Desenvolvimento

### 1. Mudanças de Infraestrutura (Terraform)

```bash
# Scaffold ou atualizar módulo
python scripts/terraform_scaffolder.py ./infra --provider=aws --module=ecs-service --verbose

# Validar e planejar — revisar diff antes de aplicar
terraform -chdir=infra init
terraform -chdir=infra validate
terraform -chdir=infra plan -out=tfplan

# Aplicar somente após revisão do plano
terraform -chdir=infra apply tfplan

# Verificar se os recursos estão saudáveis
aws ecs describe-services --cluster production --services app-service \
  --query 'services[0].{Status:status,Running:runningCount,Desired:desiredCount}'
```

### 2. Implantação de Aplicação

```bash
# Gerar ou atualizar configuração de pipeline
python scripts/pipeline_generator.py . --platform=github --stages=build,test,security,deploy

# Construir e taguear imagem
docker build -t ghcr.io/org/app:$(git rev-parse --short HEAD) .
docker push ghcr.io/org/app:$(git rev-parse --short HEAD)

# Implantar com gate de health-check
python scripts/deployment_manager.py deploy \
  --env=production \
  --image=app:$(git rev-parse --short HEAD) \
  --strategy=blue-green \
  --health-check-url=https://app.example.com/healthz

# Verificar se os pods estão rodando
kubectl get pods -n production -l app=myapp
kubectl rollout status deployment/app-blue -n production

# Mudar tráfego após verificação
kubectl patch service app-svc -n production \
  -p '{"spec":{"selector":{"slot":"blue"}}}'
```

### 3. Procedimento de Rollback

```bash
# Rollback imediato via deployment manager
python scripts/deployment_manager.py rollback --env=production --to-version=1.2.2

# Ou via kubectl
kubectl rollout undo deployment/app -n production
kubectl rollout status deployment/app -n production

# Verificar se o rollback foi bem-sucedido
kubectl get pods -n production -l app=myapp
curl -sf https://app.example.com/healthz || echo "ROLLBACK FALHOU — escalar"
```

## Referências Cruzadas Multi-Cloud

Use estas skills companheiras para análises aprofundadas por cloud:

| Skill | Cloud | Use Quando |
|-------|-------|----------|
| **aws-solution-architect** | AWS | ECS/EKS, Lambda, design de VPC, otimização de custos |
| **azure-cloud-architect** | Azure | AKS, App Service, Virtual Networks, Azure DevOps |
| **gcp-cloud-architect** | GCP | GKE, Cloud Run, VPC, Cloud Build *(em breve)* |

**Decisão multi-cloud vs single-cloud:**
- **Single-cloud** (padrão) — menor complexidade operacional, integração mais profunda com serviços gerenciados, melhor alavancagem de custo com descontos por uso comprometido
- **Multi-cloud** — necessário quando mandatado por conformidade/residência de dados, adquirindo empresas em clouds diferentes ou precisando de serviços best-of-breed entre provedores (ex.: AWS para computação + GCP para ML)
- **Híbrido** — on-prem + cloud; use quando workloads regulados devem permanecer on-prem enquanto workloads de burst/não-sensíveis rodam na cloud

> Comece com single-cloud. Adicione uma segunda cloud apenas quando houver um driver concreto de negócio ou conformidade — não por redundância teórica.

---

## IaC Agnóstico de Cloud

### Terraform / OpenTofu (Escolha Padrão)

Terraform (ou seu fork open-source OpenTofu) é a ferramenta de IaC recomendada para a maioria dos times:
- Linguagem única (HCL) para AWS, Azure, GCP e 3.000+ provedores
- Gerenciamento de estado com backends remotos (S3, GCS, Azure Blob)
- Fluxo de trabalho plan-before-apply previne surpresas de drift
- Referência cruzada com **terraform-patterns** para estrutura de módulo, isolamento de estado e integração CI/CD

### Pulumi (IaC com Linguagem de Programação)

Escolha Pulumi quando o time prefere fortemente TypeScript, Python, Go ou C# em vez de HCL:
- Linguagem de programação completa — loops, condicionais, testes unitários nativos
- Mesma cobertura de provedores cloud do Terraform
- Integração mais fácil para times de dev que resistem a aprender HCL

### Quando Usar IaC Nativo da Cloud

| Ferramenta | Use Quando |
|------|----------|
| **CloudFormation** | Shop apenas AWS; necessidade de suporte AWS nativo (StackSets, Service Catalog) |
| **Bicep** | Shop apenas Azure; sintaxe mais simples que templates ARM |
| **Cloud Deployment Manager** | Apenas GCP; raro — a maioria dos times GCP prefere Terraform |

> **Regra de ouro:** Use Terraform/OpenTofu a menos que esteja 100% comprometido com uma única cloud E a ferramenta nativa da cloud ofereça um recurso que o Terraform não consegue replicar.

---

## Solução de Problemas

Verifique a seção abrangente de solução de problemas em `references/deployment_strategies.md`.
