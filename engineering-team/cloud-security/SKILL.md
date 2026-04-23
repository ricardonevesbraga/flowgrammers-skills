---
name: "cloud-security"
description: "Use ao avaliar infraestrutura de nuvem para configurações incorretas de segurança, caminhos de escalada de privilégio IAM, exposição pública de S3, regras de grupo de segurança abertas ou lacunas de segurança em IaC. Cobre avaliação de postura em AWS, Azure e GCP com mapeamento MITRE ATT&CK."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Segurança em Nuvem

Skill de avaliação de postura de segurança em nuvem para detectar escalada de privilégio IAM, exposição pública de armazenamento, riscos de configuração de rede e configurações incorretas em infraestrutura como código. Esta skill NÃO cobre resposta a incidentes para comprometimento ativo de nuvem (veja incident-response) ou escaneamento de vulnerabilidades de aplicação (veja security-pen-testing) — trata da análise sistemática de configurações de nuvem para prevenir exploração.

---

## Sumário

- [Visão Geral](#visão-geral)
- [Ferramenta de Verificação de Postura de Nuvem](#ferramenta-de-verificação-de-postura-de-nuvem)
- [Análise de Política IAM](#análise-de-política-iam)
- [Avaliação de Exposição S3](#avaliação-de-exposição-s3)
- [Análise de Grupo de Segurança](#análise-de-grupo-de-segurança)
- [Revisão de Segurança de IaC](#revisão-de-segurança-de-iac)
- [Matriz de Cobertura por Provedor de Nuvem](#matriz-de-cobertura-por-provedor-de-nuvem)
- [Fluxos de Trabalho](#fluxos-de-trabalho)
- [Anti-Padrões](#anti-padrões)
- [Referências Cruzadas](#referências-cruzadas)

---

## Visão Geral

### O que Esta Skill Faz

Esta skill fornece a metodologia e ferramentas para **gerenciamento de postura de segurança em nuvem (CSPM)** — verificando sistematicamente configurações de nuvem para configurações incorretas que criam superfície de ataque explorável. Cobre caminhos de escalada de privilégio IAM, exposição pública de armazenamento, super-permissões de rede e segurança do código de infraestrutura.

### Distinção de Outras Skills de Segurança

| Skill | Foco | Abordagem |
|-------|-------|----------|
| **cloud-security** (esta) | Risco de configuração de nuvem | Preventiva — avaliar antes da exploração |
| incident-response | Incidentes ativos de nuvem | Reativa — triagem de comprometimento confirmado de nuvem |
| threat-detection | Anomalias comportamentais | Proativa — caçar atividade de atacante em logs de nuvem |
| security-pen-testing | Vulnerabilidades de aplicação | Ofensiva — explorar ativamente fraquezas encontradas |

### Pré-requisitos

Acesso de leitura a documentos de política IAM, configurações de bucket S3 e regras de grupo de segurança em formato JSON. Para monitoramento contínuo, integrar com APIs do provedor de nuvem (AWS Config, Azure Policy, GCP Security Command Center).

---

## Ferramenta de Verificação de Postura de Nuvem

A ferramenta `cloud_posture_check.py` executa três tipos de verificações: `iam` (escalada de privilégio), `s3` (acesso público) e `sg` (exposição de rede). Ela detecta automaticamente o tipo de verificação a partir da estrutura do arquivo de configuração ou aceita flags `--check` explícitas.

```bash
# Analisar uma política IAM para caminhos de escalada de privilégio
python3 scripts/cloud_posture_check.py policy.json --check iam --json

# Avaliar configuração de bucket S3 para acesso público
python3 scripts/cloud_posture_check.py bucket_config.json --check s3 --json

# Verificar regras de grupo de segurança para portas de administração abertas
python3 scripts/cloud_posture_check.py sg.json --check sg --json

# Executar todas as verificações com aumento de severidade para recursos expostos à internet
python3 scripts/cloud_posture_check.py config.json --check all \
  --provider aws --severity-modifier internet-facing --json

# Contexto de dados regulados (aumenta severidade em um nível para todos os resultados)
python3 scripts/cloud_posture_check.py config.json --check all \
  --severity-modifier regulated-data --json

# Canalizar política IAM da AWS CLI
aws iam get-policy-version --policy-arn arn:aws:iam::123456789012:policy/MyPolicy \
  --version-id v1 | jq '.PolicyVersion.Document' | \
  python3 scripts/cloud_posture_check.py - --check iam --json
```

### Códigos de Saída

| Código | Significado | Ação Obrigatória |
|------|---------|-----------------|
| 0 | Nenhum resultado alto/crítico | Nenhuma ação necessária |
| 1 | Resultados de alta severidade | Remediar em 24 horas |
| 2 | Resultados críticos | Remediar imediatamente — escalar para incident-response se ativo |

---

## Análise de Política IAM

A análise IAM detecta caminhos de escalada de privilégio, concessões super-privilegiadas, exposição de principal público e risco de exfiltração de dados.

### Padrões de Escalada de Privilégio

| Padrão | Severidade | Combinação de Ações-Chave | MITRE |
|---------|----------|------------------------|-------|
| Escalada PassRole via Lambda | Crítica | iam:PassRole + lambda:CreateFunction | T1078.004 |
| Abuso de perfil de instância EC2 | Crítica | iam:PassRole + ec2:RunInstances | T1078.004 |
| PassRole via CloudFormation | Crítica | iam:PassRole + cloudformation:CreateStack | T1078.004 |
| Escalada por auto-attach de política | Crítica | iam:AttachUserPolicy + sts:GetCallerIdentity | T1484.001 |
| Auto-escalada por política inline | Crítica | iam:PutUserPolicy + sts:GetCallerIdentity | T1484.001 |
| Backdoor de versão de política | Crítica | iam:CreatePolicyVersion + iam:ListPolicies | T1484.001 |
| Colheita de credenciais | Alta | iam:CreateAccessKey + iam:ListUsers | T1098.001 |
| Escalada por associação a grupo | Alta | iam:AddUserToGroup + iam:ListGroups | T1098 |
| Ataque de redefinição de senha | Alta | iam:UpdateLoginProfile + iam:ListUsers | T1098 |
| Wildcard de nível de serviço | Alta | iam:* ou s3:* ou ec2:* | T1078.004 |

### Guia de Severidade de Resultados IAM

| Tipo de Resultado | Condição | Severidade |
|-------------|-----------|----------|
| Wildcard de admin completo | Action=* Resource=* | Crítica |
| Principal público | Principal: '*' | Crítica |
| Combinação de ação perigosa | Caminho de escalada de duas ações | Crítica |
| Ações individuais de priv-esc | Em recurso wildcard | Alta |
| Ações de exfiltração de dados | s3:GetObject, secretsmanager:GetSecretValue em * | Alta |
| Wildcard de serviço | ação service:* | Alta |
| Ações de dados em recurso nomeado | Escopo apropriado | Baixo/Limpo |

### Recomendações de Menor Privilégio

Para cada resultado crítico ou alto, a ferramenta produz um campo `least_privilege_suggestion` com orientação específica de remediação:
- Substituir `Action: *` por uma lista nomeada de ações necessárias
- Substituir `Resource: *` por padrões específicos de ARN
- Usar AWS Access Analyzer para identificar permissões realmente utilizadas
- Separar combinações de ações perigosas em papéis diferentes com políticas de confiança distintas

---

## Avaliação de Exposição S3

A avaliação S3 verifica quatro dimensões: configuração de bloqueio de acesso público, ACL do bucket, exposição de principal de política do bucket e criptografia padrão.

### Matriz de Verificação de Configuração S3

| Verificação | Condição de Resultado | Severidade |
|-------|------------------|----------|
| Bloqueio de acesso público | Qualquer um dos quatro flags ausente/falso | Alta |
| ACL do bucket | public-read-write | Crítica |
| ACL do bucket | public-read ou authenticated-read | Alta |
| Principal de política do bucket | "Principal": "*" com Allow | Crítica |
| Criptografia padrão | Sem ServerSideEncryptionConfiguration | Alta |
| Criptografia padrão | SSEAlgorithm não-padrão | Média |
| Sem PublicAccessBlockConfiguration | Status desconhecido | Média |

### Configuração de Baseline Recomendada para S3

```json
{
  "PublicAccessBlockConfiguration": {
    "BlockPublicAcls": true,
    "BlockPublicPolicy": true,
    "IgnorePublicAcls": true,
    "RestrictPublicBuckets": true
  },
  "ServerSideEncryptionConfiguration": {
    "Rules": [{
      "ApplyServerSideEncryptionByDefault": {
        "SSEAlgorithm": "aws:kms",
        "KMSMasterKeyID": "arn:aws:kms:region:account:key/key-id"
      },
      "BucketKeyEnabled": true
    }]
  },
  "ACL": "private"
}
```

Todas as quatro configurações de bloqueio de acesso público devem estar habilitadas tanto no nível do bucket quanto no nível da conta AWS. As configurações de nível de conta podem ser substituídas pelas configurações de nível de bucket se ambas não forem aplicadas.

---

## Análise de Grupo de Segurança

A análise de grupo de segurança sinaliza regras de entrada que expõem portas de administração, portas de banco de dados ou todo o tráfego para CIDRs da internet (0.0.0.0/0, ::/0).

### Regras de Exposição de Portas Críticas

| Porta | Serviço | Severidade do Resultado | Remediação |
|------|---------|-----------------|-------------|
| 22 | SSH | Crítica | Restringir ao CIDR de VPN ou usar AWS Systems Manager Session Manager |
| 3389 | RDP | Crítica | Restringir ao CIDR de VPN ou usar AWS Fleet Manager |
| 0–65535 (todos) | Todo o tráfego | Crítica | Remover regra; adicionar apenas as portas específicas necessárias |

### Regras de Alta Exposição para Portas de Banco de Dados

| Porta | Serviço | Severidade do Resultado | Remediação |
|------|---------|-----------------|-------------|
| 1433 | MSSQL | Alta | Permitir apenas do SG da camada de aplicação — mover para subnet privada |
| 3306 | MySQL | Alta | Permitir apenas do SG da camada de aplicação — mover para subnet privada |
| 5432 | PostgreSQL | Alta | Permitir apenas do SG da camada de aplicação — mover para subnet privada |
| 27017 | MongoDB | Alta | Permitir apenas do SG da camada de aplicação — mover para subnet privada |
| 6379 | Redis | Alta | Permitir apenas do SG da camada de aplicação — mover para subnet privada |
| 9200 | Elasticsearch | Alta | Permitir apenas do SG da camada de aplicação — mover para subnet privada |

### Modificadores de Severidade

Use `--severity-modifier internet-facing` quando o recurso avaliado for diretamente acessível pela internet (load balancer, API gateway, EC2 público). Use `--severity-modifier regulated-data` quando o recurso lidar com dados regulados por PCI, ANVISA ou LGPD. Ambos os modificadores aumentam a severidade de cada resultado em um nível.

---

## Revisão de Segurança de IaC

A revisão de segurança de infraestrutura como código captura problemas de configuração no momento da definição, antes da implantação.

### Matriz de Verificação de IaC

| Ferramenta | Tipos de Verificação | Quando Executar |
|------|-------------|-------------|
| Terraform | Verificações em nível de recurso (aws_s3_bucket_acl, aws_security_group, aws_iam_policy_document) | Pré-plan, pré-apply, gate de PR |
| CloudFormation | Validação de propriedade de template (PublicAccessBlockConfiguration, SecurityGroupIngress) | Lint de template, gate de implantação |
| Manifestos Kubernetes | Privilégios de container, políticas de rede, exposição de segredos | Gate de PR, admission controller |
| Helm charts | Igual ao Kubernetes | Gate de PR |

### Exemplo de Política IAM Terraform — Resultado vs. Limpo

```hcl
# RUIM: Gerará resultados críticos
resource "aws_iam_policy" "bad_policy" {
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = "*"
      Resource = "*"
    }]
  })
}

# BOM: Menor privilégio
resource "aws_iam_policy" "good_policy" {
  policy = jsonencode({
    Version = "2012-10-17"
    Statement = [{
      Effect   = "Allow"
      Action   = ["s3:GetObject", "s3:PutObject"]
      Resource = "arn:aws:s3:::my-specific-bucket/*"
    }]
  })
}
```

Referência completa de verificações CSPM: `references/cspm-checks.md`

---

## Matriz de Cobertura por Provedor de Nuvem

| Tipo de Verificação | AWS | Azure | GCP |
|-----------|-----|-------|-----|
| Escalada de privilégio IAM | Completa (políticas IAM, políticas de confiança, ESCALATION_COMBOS) | Parcial (atribuições RBAC, riscos de service principal) | Parcial (vinculações IAM, workload identity) |
| Acesso público a armazenamento | Completa (políticas de bucket S3, ACLs, bloqueio de acesso público) | Parcial (tokens SAS de Blob, níveis de acesso de container) | Parcial (IAM de bucket GCS, acesso uniforme em nível de bucket) |
| Exposição de rede | Completa (Security Groups, NACLs, análise em nível de porta) | Parcial (regras NSG, análise de porta de entrada) | Parcial (regras de firewall, firewall VPC) |
| Escaneamento de IaC | Completa (Terraform, CloudFormation) | Parcial (templates ARM, Bicep) | Parcial (Deployment Manager) |

---

## Fluxos de Trabalho

### Fluxo de Trabalho 1: Verificação Rápida de Postura (20 Minutos)

Para um recurso recém-provisionado ou revisão pré-implantação:

```bash
# 1. Exportar documento de política IAM
aws iam get-policy-version --policy-arn ARN --version-id v1 | \
  jq '.PolicyVersion.Document' > policy.json
python3 scripts/cloud_posture_check.py policy.json --check iam --json

# 2. Verificar configuração do bucket S3
aws s3api get-bucket-acl --bucket my-bucket > acl.json
aws s3api get-public-access-block --bucket my-bucket >> bucket.json
python3 scripts/cloud_posture_check.py bucket.json --check s3 --json

# 3. Revisar grupos de segurança para portas de administração abertas
aws ec2 describe-security-groups --group-ids sg-123456 | \
  jq '.SecurityGroups[0]' > sg.json
python3 scripts/cloud_posture_check.py sg.json --check sg --json
```

**Decisão**: Código de saída 2 = bloquear implantação e remediar. Código de saída 1 = agendar remediação em 24 horas.

### Fluxo de Trabalho 2: Avaliação Completa de Segurança em Nuvem (Múltiplos Dias)

**Dia 1 — IAM e Identidade:**
1. Exportar todas as políticas IAM anexadas a papéis de produção
2. Executar cloud_posture_check.py --check iam em cada política
3. Mapear todos os caminhos de escalada de privilégio encontrados
4. Identificar contas de serviço e papéis super-privilegiados
5. Revisar políticas de confiança entre contas

**Dia 2 — Armazenamento e Rede:**
1. Enumerar todos os buckets S3 e exportar configurações
2. Executar cloud_posture_check.py --check s3 --severity-modifier regulated-data para buckets de dados
3. Exportar configurações de grupo de segurança para todas as VPCs
4. Executar cloud_posture_check.py --check sg para recursos expostos à internet
5. Revisar regras NACL para lacunas de segmentação de rede

**Dia 3 — IaC e Integração Contínua:**
1. Revisar templates Terraform/CloudFormation no controle de versão
2. Verificar pipeline CI/CD para gates de segurança de IaC
3. Validar resultados contra `references/cspm-checks.md`
4. Produzir plano de remediação com ordenação de prioridade (Crítico → Alto → Médio)

### Fluxo de Trabalho 3: Gate de Segurança no CI/CD

Integrar verificações de postura nos pipelines de implantação para evitar que recursos com configurações incorretas cheguem à produção:

```bash
# Validar IaC antes de terraform apply
terraform show -json plan.json | \
  jq '[.resource_changes[].change.after | select(. != null)]' > resources.json
python3 scripts/cloud_posture_check.py resources.json --check all --json
if [ $? -eq 2 ]; then
  echo "Resultados críticos de segurança em nuvem — bloqueando implantação"
  exit 1
fi

# Validar bucket S3 existente antes de modificar
aws s3api get-bucket-policy --bucket "${BUCKET}" | jq '.Policy | fromjson' | \
  python3 scripts/cloud_posture_check.py - --check s3 \
  --severity-modifier regulated-data --json
```

---

## Anti-Padrões

1. **Executar análise IAM sem verificar combinações de escalada** — Ações de alto risco individuais isoladamente podem parecer de baixo risco. O perigo está nas combinações: `iam:PassRole` sozinho não é crítico, mas `iam:PassRole + lambda:CreateFunction` é um caminho confirmado de escalada de privilégio. Sempre analise o statement completo, não ações individuais.
2. **Habilitar apenas o bloqueio de acesso público em nível de bucket** — AWS S3 tem configurações de bloqueio de acesso público tanto em nível de conta quanto em nível de bucket. Uma configuração em nível de bucket pode substituir uma configuração em nível de conta. Ambas devem ser configuradas. O bloqueio em nível de conta sozinho é insuficiente se qualquer bucket tiver substituições explícitas.
3. **Tratar `--severity-modifier internet-facing` como opcional para recursos públicos** — Recursos expostos à internet têm exposição significativamente maior do que recursos internos. Resultados altos em infraestrutura voltada para a internet devem ser tratados como críticos. Sempre aplique `--severity-modifier internet-facing` para configurações de DMZ, load balancer e API gateway.
4. **Verificar apenas políticas de administrador** — Caminhos de escalada de privilégio frequentemente se originam de políticas não-administrador que combinam permissões aparentemente inocentes. Todas as políticas anexadas a identidades de produção devem ser verificadas, não apenas políticas com acesso elevado óbvio.
5. **Remediar resultados sem análise de causa raiz** — Remover uma permissão perigosa sem entender por que ela foi concedida resultará em re-adição. Documente a justificativa de negócio para cada permissão de alto risco antes de removê-la, para evitar re-introdução silenciosa.
6. **Ignorar super-permissões de contas de serviço** — Contas de serviço são frequentemente super-provisionadas durante o desenvolvimento e nunca reduzidas para produção. Cada conta de serviço em produção deve ser auditada contra o AWS Access Analyzer ou equivalente para identificar e remover permissões não utilizadas.
7. **Não aplicar modificadores de severidade para cargas de trabalho com dados regulados** — Um resultado alto em um bucket S3 de uso geral é diferente do mesmo resultado em um bucket contendo dados de PHI ou de titulares de cartão. Sempre use `--severity-modifier regulated-data` ao avaliar recursos em ambientes de dados regulados.

---

## Referências Cruzadas

| Skill | Relação |
|-------|-------------|
| [incident-response](../incident-response/SKILL.md) | Resultados críticos (S3 público, escalada de privilégio confirmada ativa) podem acionar classificação de incidente |
| [threat-detection](../threat-detection/SKILL.md) | Resultados de postura de nuvem criam alvos de caça — papéis super-privilegiados são prováveis destinos de movimento lateral |
| [red-team](../red-team/SKILL.md) | Exercícios de red team testam especificamente a explorabilidade de configurações incorretas de nuvem encontradas na avaliação de postura |
| [security-pen-testing](../security-pen-testing/SKILL.md) | Resultados de postura de nuvem alimentam a seção de segurança de infraestrutura de avaliações de pen test |
