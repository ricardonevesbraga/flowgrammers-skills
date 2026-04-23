---
name: "terraform-patterns"
description: "Skill de infraestrutura-como-código com Terraform para Claude Code. Cobre padrões de design de módulos, estratégias de gerenciamento de estado, configuração de providers, hardening de segurança, policy-as-code com Sentinel/OPA e fluxos CI/CD de plan/apply. Use quando o usuário quiser projetar módulos Terraform, gerenciar state backends, revisar segurança Terraform, implementar deploys multi-região ou seguir melhores práticas de IaC."
license: MIT
metadata:
  version: 1.0.0
  author: Ric Neves - Flowgrammers
  category: engineering
  updated: 2026-03-15
agents:
  - claude-code
---

# Terraform Patterns

> Infraestrutura previsível. State seguro. Módulos que compõem. Sem drift.

Workflow Terraform opinativo que transforma HCL espalhado em código de infraestrutura bem estruturado, seguro e pronto para produção. Cobre design de módulos, gerenciamento de state, padrões de providers, hardening de segurança e integração CI/CD.

Não é um tutorial de Terraform — é um conjunto de decisões concretas sobre como escrever código de infraestrutura que não quebra às 3 da manhã.

---

## Comandos Slash

| Comando | O que faz |
|---------|-----------|
| `/terraform:review` | Analisa código Terraform em busca de anti-padrões, problemas de segurança e problemas de estrutura |
| `/terraform:module` | Projeta ou refatora um módulo Terraform com inputs, outputs e composição adequados |
| `/terraform:security` | Audita código Terraform para vulnerabilidades de segurança, exposição de secrets e misconfigurações de IAM |

---

## Quando Esta Skill Ativa

Reconheça estes padrões do usuário:

- "Revisar este código Terraform"
- "Projetar um módulo Terraform para..."
- "Meu Terraform state está..."
- "Configurar remote state backend"
- "Deploy Terraform multi-região"
- "Revisão de segurança Terraform"
- "Melhores práticas de estrutura de módulo"
- "Pipeline CI/CD para Terraform"
- Qualquer requisição envolvendo: arquivos `.tf`, HCL, módulos Terraform, gerenciamento de state, configuração de provider, infraestrutura-como-código

Se o usuário tem arquivos `.tf` ou quer provisionar infraestrutura com Terraform → esta skill se aplica.

---

## Fluxo de Trabalho

### `/terraform:review` — Revisão de Código Terraform

1. **Analisar estado atual**
   - Ler todos os arquivos `.tf` no diretório alvo
   - Identificar estrutura de módulos (flat vs nested)
   - Contar resources, data sources, variables, outputs
   - Verificar convenções de nomenclatura

2. **Aplicar checklist de revisão**

   ```
   ESTRUTURA DO MÓDULO
   ├── Variables têm descriptions e type constraints
   ├── Outputs expõem apenas o que os consumidores precisam
   ├── Resources usam nomenclatura consistente: {provider}_{type}_{purpose}
   ├── Locals usados para valores computados e expressões DRY
   └── Sem valores hardcoded — tudo parametrizado ou em locals

   STATE & BACKEND
   ├── Remote backend configurado (S3, GCS, Azure Blob, Terraform Cloud)
   ├── State locking habilitado (DynamoDB para S3, nativo para outros)
   ├── Criptografia do state em repouso habilitada
   ├── Nenhum secret armazenado no state (ou acesso ao state é restrito)
   └── Workspaces ou isolamento por diretório para ambientes

   PROVIDERS
   ├── Version constraints usam operador pessimista: ~> 5.0
   ├── Bloco required_providers dentro do bloco terraform {}
   ├── Provider aliases para multi-região ou multi-conta
   └── Sem configuração de provider em módulos filhos

   SEGURANÇA
   ├── Sem secrets, keys ou passwords hardcoded
   ├── IAM segue princípio de menor privilégio
   ├── Criptografia habilitada para storage, databases, secrets
   ├── Security groups não são excessivamente permissivos (sem 0.0.0.0/0 em portas sensíveis)
   └── Variáveis sensíveis marcadas com sensitive = true
   ```

3. **Gerar relatório**
   ```bash
   python3 scripts/tf_module_analyzer.py ./terraform
   ```

4. **Executar scan de segurança**
   ```bash
   python3 scripts/tf_security_scanner.py ./terraform
   ```

### `/terraform:module` — Design de Módulo

1. **Identificar escopo do módulo**
   - Responsabilidade única: um módulo = um agrupamento lógico
   - Determinar inputs (variables), outputs e fronteiras de resource
   - Decidir: módulo flat (diretório único) vs nested (chamando módulos filhos)

2. **Aplicar checklist de design de módulo**

   ```
   ESTRUTURA
   ├── main.tf        — Resources principais
   ├── variables.tf   — Todas as variáveis de input com descriptions e types
   ├── outputs.tf     — Todos os outputs com descriptions
   ├── versions.tf    — bloco terraform {} com required_providers
   ├── locals.tf      — Valores computados e convenções de nomenclatura
   ├── data.tf        — Data sources (se houver)
   └── README.md      — Exemplos de uso e documentação de variáveis

   VARIABLES
   ├── Toda variável tem: description, type, validation (onde aplicável)
   ├── Valores sensíveis marcados: sensitive = true
   ├── Defaults fornecidos para configurações opcionais
   ├── Use object types para configurações relacionadas: variable "config" { type = object({...}) }
   └── Validar com: validation { condition = ... }

   OUTPUTS
   ├── Expor IDs, ARNs, endpoints — coisas que os consumidores precisam
   ├── Incluir description em todo output
   ├── Marcar outputs sensíveis: sensitive = true
   └── Não expor resources inteiros — apenas atributos específicos

   COMPOSIÇÃO
   ├── Módulo raiz chama módulos filhos
   ├── Módulos filhos nunca chamam outros módulos filhos
   ├── Passar valores explicitamente — sem lookups de data source ocultos em módulos filhos
   ├── Configuração de provider apenas no módulo raiz
   └── Use module "name" { source = "./modules/name" }
   ```

3. **Gerar scaffold do módulo**
   - Estrutura de arquivo de saída com boilerplate
   - Incluir blocos de validation de variáveis
   - Adicionar lifecycle rules onde apropriado

### `/terraform:security` — Auditoria de Segurança

1. **Auditoria a nível de código**

   | Verificação | Severidade | Correção |
   |-------------|------------|----------|
   | Secrets hardcoded em arquivos `.tf` | Crítica | Use variables com sensitive = true ou vault |
   | IAM policy com ações `*` | Crítica | Escopo para ações e resources específicos |
   | Security group com 0.0.0.0/0 na porta 22/3389 | Crítica | Restringir a blocos CIDR conhecidos ou usar SSM/bastion |
   | S3 bucket sem criptografia | Alta | Adicionar bloco `server_side_encryption_configuration` |
   | S3 bucket com acesso público | Alta | Adicionar `aws_s3_bucket_public_access_block` |
   | RDS sem criptografia | Alta | Definir `storage_encrypted = true` |
   | RDS acessível publicamente | Alta | Definir `publicly_accessible = false` |
   | CloudTrail não habilitado | Média | Adicionar resource `aws_cloudtrail` |
   | `prevent_destroy` ausente em recursos com estado | Média | Adicionar `lifecycle { prevent_destroy = true }` |
   | Variables sem `sensitive = true` para secrets | Média | Adicionar `sensitive = true` às variáveis secretas |

2. **Auditoria de segurança do state**

   | Verificação | Severidade | Correção |
   |-------------|------------|----------|
   | Arquivo de state local | Crítica | Migrar para remote backend com criptografia |
   | Remote state sem criptografia | Alta | Habilitar criptografia no backend (SSE-S3, KMS) |
   | Sem state locking | Alta | Habilitar DynamoDB para S3, nativo para TF Cloud |
   | State acessível a todos os membros da equipe | Média | Restringir via IAM policies ou TF Cloud teams |

3. **Gerar relatório de segurança**
   ```bash
   python3 scripts/tf_security_scanner.py ./terraform
   python3 scripts/tf_security_scanner.py ./terraform --output json
   ```

---

## Ferramentas

### `scripts/tf_module_analyzer.py`

Utilitário CLI para analisar estrutura de diretórios e qualidade de módulos Terraform.

**Funcionalidades:**
- Contagem de resources e data sources
- Análise de variables e outputs (descriptions ausentes, types, validation)
- Verificações de convenção de nomenclatura
- Detecção de composição de módulos
- Validação de estrutura de arquivos
- Saída JSON e texto

**Uso:**
```bash
# Analisar um diretório Terraform
python3 scripts/tf_module_analyzer.py ./terraform

# Saída JSON
python3 scripts/tf_module_analyzer.py ./terraform --output json

# Analisar um módulo específico
python3 scripts/tf_module_analyzer.py ./modules/vpc
```

### `scripts/tf_security_scanner.py`

Utilitário CLI para escanear arquivos `.tf` em busca de problemas comuns de segurança.

**Funcionalidades:**
- Detecção de secrets hardcoded (chaves AWS, senhas, tokens)
- Detecção de IAM policy excessivamente permissiva
- Detecção de security group aberto (0.0.0.0/0 em portas sensíveis)
- Verificações de criptografia ausente (S3, RDS, EBS)
- Detecção de acesso público (S3, RDS, EC2)
- Auditoria de variáveis sensíveis
- Saída JSON e texto

**Uso:**
```bash
# Escanear um diretório Terraform
python3 scripts/tf_security_scanner.py ./terraform

# Saída JSON
python3 scripts/tf_security_scanner.py ./terraform --output json

# Modo estrito (elevar avisos)
python3 scripts/tf_security_scanner.py ./terraform --strict
```

---

## Padrões de Design de Módulos

### Padrão 1: Módulo Flat (Projetos Pequenos/Médios)

```
infrastructure/
├── main.tf          # Todos os resources
├── variables.tf     # Todos os inputs
├── outputs.tf       # Todos os outputs
├── versions.tf      # Requisitos do provider
├── terraform.tfvars # Valores de ambiente (não commitado)
└── backend.tf       # Configuração de remote state
```

Ideal para: Aplicação única, < 20 resources, uma equipe cuida de tudo.

### Padrão 2: Módulos Nested (Projetos Médios/Grandes)

```
infrastructure/
├── environments/
│   ├── dev/
│   │   ├── main.tf          # Chama módulos com params de dev
│   │   ├── backend.tf       # State backend de dev
│   │   └── terraform.tfvars
│   ├── staging/
│   │   └── ...
│   └── prod/
│       └── ...
├── modules/
│   ├── networking/
│   │   ├── main.tf
│   │   ├── variables.tf
│   │   └── outputs.tf
│   ├── compute/
│   │   └── ...
│   └── database/
│       └── ...
└── versions.tf
```

Ideal para: Múltiplos ambientes, padrões de infraestrutura compartilhados, colaboração de equipe.

### Padrão 3: Mono-Repo com Terragrunt

```
infrastructure/
├── terragrunt.hcl           # Config raiz
├── modules/                  # Módulos reutilizáveis
│   ├── vpc/
│   ├── eks/
│   └── rds/
├── dev/
│   ├── terragrunt.hcl       # Overrides de dev
│   ├── vpc/
│   │   └── terragrunt.hcl   # Invocação do módulo
│   └── eks/
│       └── terragrunt.hcl
└── prod/
    ├── terragrunt.hcl
    └── ...
```

Ideal para: Grande escala, muitos ambientes, configuração DRY, isolamento por equipe.

---

## Padrões de Configuração de Provider

### Pinagem de Versão
```hcl
terraform {
  required_version = ">= 1.5.0"

  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"    # Permite 5.x, bloqueia 6.0
    }
    random = {
      source  = "hashicorp/random"
      version = "~> 3.5"
    }
  }
}
```

### Multi-Região com Aliases
```hcl
provider "aws" {
  region = "us-east-1"
}

provider "aws" {
  alias  = "west"
  region = "us-west-2"
}

resource "aws_s3_bucket" "primary" {
  bucket = "my-app-primary"
}

resource "aws_s3_bucket" "replica" {
  provider = aws.west
  bucket   = "my-app-replica"
}
```

### Multi-Conta com Assume Role
```hcl
provider "aws" {
  alias  = "production"
  region = "us-east-1"

  assume_role {
    role_arn = "arn:aws:iam::PROD_ACCOUNT_ID:role/TerraformRole"
  }
}
```

---

## Árvore de Decisão de Gerenciamento de State

```
Desenvolvedor único, projeto pequeno?
├── Sim → State local (mas migre para remoto assim que possível)
└── Não
    ├── Usando Terraform Cloud/Enterprise?
    │   └── Sim → TF Cloud native backend (locking, criptografia e RBAC integrados)
    └── Não
        ├── AWS?
        │   └── S3 + DynamoDB (criptografia, locking, versionamento)
        ├── GCP?
        │   └── GCS bucket (locking nativo, criptografia)
        ├── Azure?
        │   └── Azure Blob Storage (locking nativo, criptografia)
        └── Outro?
            └── Consul ou backend PostgreSQL

Estratégia de isolamento de ambiente:
├── Arquivos de state separados por ambiente (recomendado)
│   ├── Opção A: Diretórios separados (dev/, staging/, prod/)
│   └── Opção B: Terraform workspaces (mais simples, mas menos isolamento)
└── Arquivo de state único para todos os ambientes (nunca faça isso)
```

---

## Padrões de Integração CI/CD

### GitHub Actions Plan/Apply

```yaml
# .github/workflows/terraform.yml
name: Terraform
on:
  pull_request:
    paths: ['terraform/**']
  push:
    branches: [main]
    paths: ['terraform/**']

jobs:
  plan:
    runs-on: ubuntu-latest
    if: github.event_name == 'pull_request'
    steps:
      - uses: actions/checkout@v4
      - uses: hashicorp/setup-terraform@v3
      - run: terraform init
      - run: terraform validate
      - run: terraform plan -out=tfplan
      - run: terraform show -json tfplan > plan.json
      # Postar plan como comentário no PR

  apply:
    runs-on: ubuntu-latest
    if: github.ref == 'refs/heads/main' && github.event_name == 'push'
    environment: production
    steps:
      - uses: actions/checkout@v4
      - uses: hashicorp/setup-terraform@v3
      - run: terraform init
      - run: terraform apply -auto-approve
```

### Detecção de Drift

```yaml
# Executar agendado para detectar drift
name: Detecção de Drift
on:
  schedule:
    - cron: '0 6 * * 1-5'  # Dias úteis às 6h

jobs:
  detect:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: hashicorp/setup-terraform@v3
      - run: terraform init
      - run: |
          terraform plan -detailed-exitcode -out=drift.tfplan 2>&1 | tee drift.log
          EXIT_CODE=$?
          if [ $EXIT_CODE -eq 2 ]; then
            echo "DRIFT DETECTADO — revise drift.log"
            # Enviar alerta (Slack, PagerDuty, etc.)
          fi
```

---

## Gatilhos Proativos

Sinalize estes sem ser solicitado:

- **Nenhum remote backend configurado** → Migrar para S3/GCS/Azure Blob com locking e criptografia.
- **Provider sem version constraint** → Adicionar `version = "~> X.0"` para evitar upgrades com breaking changes.
- **Secrets hardcoded em arquivos .tf** → Usar variables com `sensitive = true`, ou integrar Vault/SSM.
- **IAM policy com `"Action": "*"`** → Escopo para ações específicas. Sem wildcard em produção.
- **Security group aberto a 0.0.0.0/0 em SSH/RDP** → Restringir a CIDR de bastion ou usar SSM Session Manager.
- **Sem state locking** → Habilitar tabela DynamoDB para S3 backend, ou usar TF Cloud.
- **Resources sem tags** → Adicionar default_tags no bloco do provider. Tags são obrigatórias para rastreamento de custos.
- **`prevent_destroy` ausente em databases/storage** → Adicionar bloco lifecycle para evitar exclusão acidental.

---

## Configuração Multi-Cloud

Quando um único módulo raiz deve provisionar AWS, Azure e GCP simultaneamente.

### Padrão de Aliasing de Provider

```hcl
terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "~> 5.0"
    }
    azurerm = {
      source  = "hashicorp/azurerm"
      version = "~> 3.0"
    }
    google = {
      source  = "hashicorp/google"
      version = "~> 5.0"
    }
  }
}

provider "aws" {
  region = var.aws_region
}

provider "azurerm" {
  features {}
  subscription_id = var.azure_subscription_id
}

provider "google" {
  project = var.gcp_project_id
  region  = var.gcp_region
}
```

### Variables Compartilhadas Entre Providers

```hcl
variable "environment" {
  description = "Nome do ambiente usado em todos os providers"
  type        = string
  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "Deve ser dev, staging ou prod."
  }
}

locals {
  common_tags = {
    environment = var.environment
    managed_by  = "terraform"
    project     = var.project_name
  }
}
```

### Quando Usar Multi-Cloud

- **Sim**: Requisitos regulatórios exigem residência de dados em múltiplos providers, ou a organização tem cargas de trabalho existentes em múltiplos clouds.
- **Não**: "Evitar vendor lock-in" sozinho não é justificativa suficiente. Multi-cloud dobra a complexidade operacional. Prefira cloud único a menos que haja um requisito de negócio concreto.

---

## Compatibilidade com OpenTofu

OpenTofu é um fork open-source do Terraform mantido pela Linux Foundation sob a licença MPL 2.0.

### Migração do Terraform para OpenTofu

```bash
# 1. Instalar OpenTofu
brew install opentofu        # macOS
snap install --classic tofu  # Linux

# 2. Substituir o binário — arquivos de state são compatíveis
tofu init                    # Reinicializa com OpenTofu
tofu plan                    # Saída de plan idêntica
tofu apply                   # Mesmo workflow de apply
```

### Considerações de Licença

| | Terraform (1.6+) | OpenTofu |
|---|---|---|
| **Licença** | BSL 1.1 (source-available) | MPL 2.0 (open-source) |
| **Uso comercial** | Restrito para produtos concorrentes | Irrestrito |
| **Governança** | HashiCorp | Linux Foundation |

### Paridade de Funcionalidades

OpenTofu acompanha as funcionalidades do Terraform 1.6.x. Adições exclusivas do OpenTofu:
- Criptografia de state no lado do cliente (`tofu init -encryption`)
- Avaliação antecipada de variables/locals
- Funções definidas pelo provider

### Quando Escolher OpenTofu

- Você precisa de uma licença totalmente open-source para sua cadeia de fornecimento.
- Você quer criptografia de state no lado do cliente sem Terraform Cloud.
- Caso contrário, qualquer ferramenta funciona — a sintaxe HCL e o ecossistema de providers são idênticos.

---

## Integração com Infracost

Infracost estima custos de cloud a partir do código Terraform antes de os resources serem provisionados.

### Workflow de PR

```bash
# Mostrar breakdown de custos para o código atual
infracost breakdown --path .

# Comparar diferença de custo entre o branch atual e main
infracost diff --path . --compare-to infracost-base.json
```

### Comentário de Custo no GitHub Actions

```yaml
# .github/workflows/infracost.yml
name: Infracost
on: [pull_request]

jobs:
  cost:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: infracost/actions/setup@v3
        with:
          api-key: ${{ secrets.INFRACOST_API_KEY }}
      - run: infracost breakdown --path ./terraform --format json --out-file /tmp/infracost.json
      - run: infracost comment github --path /tmp/infracost.json --repo $GITHUB_REPOSITORY --pull-request ${{ github.event.pull_request.number }} --github-token ${{ secrets.GITHUB_TOKEN }} --behavior update
```

### Limites de Orçamento e Cost Policy

```yaml
# infracost.yml — arquivo de policy
version: 0.1
policies:
  - path: "*"
    max_monthly_cost: "5000"    # Reprovar PR se custo estimado exceder R$5.000/mês
    max_cost_increase: "500"    # Reprovar PR se aumento de custo exceder R$500/mês
```

---

## Importar Infraestrutura Existente

Trazer resources criados manualmente para o gerenciamento do Terraform.

### Workflow de terraform import

```bash
# 1. Escrever o bloco de resource primeiro (corpo vazio está ok)
# main.tf:
# resource "aws_s3_bucket" "legacy" {}

# 2. Importar o resource para o state
terraform import aws_s3_bucket.legacy my-existing-bucket-name

# 3. Executar plan para ver diff de atributos
terraform plan

# 4. Preencher o bloco de resource até o plan não mostrar mais mudanças
```

### Importação em Massa com Geração de Config (Terraform 1.5+)

```bash
# Gerar HCL para resources importados
terraform plan -generate-config-out=generated.tf

# Revisar generated.tf, então mover resources para os arquivos adequados
```

### Armadilhas Comuns

- **Drift de resource após importação**: O resource importado pode ter atributos que o Terraform não gerencia. Execute `terraform plan` imediatamente e resolva todos os diffs.
- **Manipulação de state**: Use `terraform state mv` para renomear ou reorganizar. Use `terraform state rm` para remover sem destruir. Sempre faça backup do state antes da manipulação: `terraform state pull > backup.tfstate`.
- **Defaults sensíveis**: Resources importados podem expor secrets no state. Restrinja o acesso ao state e habilite criptografia.

---

## Padrões Terragrunt

Terragrunt é um wrapper fino em torno do Terraform que fornece configuração DRY para setups multi-ambiente.

### terragrunt.hcl Raiz (Config Compartilhada)

```hcl
# terragrunt.hcl (raiz)
remote_state {
  backend = "s3"
  generate = {
    path      = "backend.tf"
    if_exists = "overwrite_terragrunt"
  }
  config = {
    bucket         = "my-org-terraform-state"
    key            = "${path_relative_to_include()}/terraform.tfstate"
    region         = "us-east-1"
    encrypt        = true
    dynamodb_table = "terraform-locks"
  }
}
```

### terragrunt.hcl Filho (Override de Ambiente)

```hcl
# prod/vpc/terragrunt.hcl
include "root" {
  path = find_in_parent_folders()
}

terraform {
  source = "../../modules/vpc"
}

inputs = {
  environment = "prod"
  cidr_block  = "10.0.0.0/16"
}
```

### Dependências Entre Módulos

```hcl
# prod/eks/terragrunt.hcl
dependency "vpc" {
  config_path = "../vpc"
}

inputs = {
  vpc_id     = dependency.vpc.outputs.vpc_id
  subnet_ids = dependency.vpc.outputs.private_subnet_ids
}
```

### Quando o Terragrunt Agrega Valor

- **Sim**: 3+ ambientes com estrutura de módulo idêntica, config de backend compartilhada ou dependências entre módulos.
- **Não**: Ambiente único, equipe pequena, ou isolamento baseado em diretório já funciona bem. Terragrunt adiciona curva de aprendizado e mais um binário para gerenciar.

---

## Skills Relacionadas

- **senior-devops** — Escopo DevOps mais amplo (CI/CD, monitoramento, containerização). Complementar — use terraform-patterns para trabalho específico de IaC, senior-devops para operações de pipeline e infraestrutura.
- **aws-solution-architect** — Design de arquitetura AWS. Complementar — terraform-patterns implementa a infraestrutura, aws-solution-architect a projeta.
- **senior-security** — Segurança de aplicação. Complementar — terraform-patterns cobre postura de segurança de infraestrutura, senior-security cobre ameaças a nível de aplicação.
- **ci-cd-pipeline-builder** — Construção de pipeline. Complementar — terraform-patterns define infraestrutura, ci-cd-pipeline-builder automatiza o deploy.
