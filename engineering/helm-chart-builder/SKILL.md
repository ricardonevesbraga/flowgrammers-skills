---
name: "helm-chart-builder"
description: "Skill e plugin para desenvolvimento de Helm chart no Claude Code — scaffolding de chart, design de values, padrões de template, gerenciamento de dependências, hardening de segurança e testes de chart. Use quando: o usuário quiser criar ou melhorar Helm charts, projetar arquivos values.yaml, implementar template helpers, auditar segurança de chart (RBAC, network policies, pod security), gerenciar subcharts ou executar helm lint/test."
license: MIT
metadata:
  version: 1.0.0
  author: Ric Neves - Flowgrammers
  category: engineering
  updated: 2026-03-15
agents:
  - claude-code
---

# Helm Chart Builder

> Helm charts de nível produção. Padrões sensatos. Seguro por design. Sem cargo-culting.

Workflow Helm opinativo que transforma manifestos Kubernetes ad-hoc em charts mantíveis, testáveis e reutilizáveis. Cobre estrutura de chart, design de values, padrões de template, gerenciamento de dependências e hardening de segurança.

Não é um tutorial Helm — é um conjunto de decisões concretas sobre como construir charts nos quais os operadores confiam e os desenvolvedores não brigam.

---

## Slash Comandos

| Comando | O que faz |
|---------|-------------|
| `/helm:create` | Faz scaffold de um Helm chart pronto para produção com estrutura de melhores práticas |
| `/helm:review` | Analisa um chart existente para problemas — labels ausentes, valores hardcoded, anti-padrões de template |
| `/helm:security` | Audita chart para problemas de segurança — RBAC, network policies, pod security, manipulação de secrets |

---

## Quando Esta Skill É Ativada

Reconheça estes padrões do usuário:

- "Crie um Helm chart para este serviço"
- "Revise meu Helm chart"
- "Este chart é seguro?"
- "Projete um values.yaml"
- "Adicione uma dependência de subchart"
- "Configure helm tests"
- "Melhores práticas Helm para [tipo de carga de trabalho]"
- Qualquer solicitação envolvendo: Helm chart, values.yaml, Chart.yaml, templates, helpers, _helpers.tpl, subcharts, helm lint, helm test

Se o usuário tem um Helm chart ou quer empacotar recursos Kubernetes → esta skill se aplica.

---

## Workflow

### `/helm:create` — Scaffolding de Chart

1. **Identificar tipo de carga de trabalho**
   - Serviço web (Deployment + Service + Ingress)
   - Worker (Deployment, sem Service)
   - CronJob (CronJob + ServiceAccount)
   - Serviço stateful (StatefulSet + PVC + Headless Service)
   - Chart de biblioteca (sem templates, apenas helpers)

2. **Fazer scaffold da estrutura do chart**

   ```
   mychart/
   ├── Chart.yaml              # Metadados e dependências do chart
   ├── values.yaml             # Configuração padrão
   ├── values.schema.json      # Opcional: JSON Schema para validação de values
   ├── .helmignore             # Arquivos a excluir do empacotamento
   ├── templates/
   │   ├── _helpers.tpl        # Templates nomeados e funções helper
   │   ├── deployment.yaml     # Recurso de carga de trabalho
   │   ├── service.yaml        # Exposição de serviço
   │   ├── ingress.yaml        # Ingress (se aplicável)
   │   ├── serviceaccount.yaml # ServiceAccount
   │   ├── hpa.yaml            # HorizontalPodAutoscaler
   │   ├── pdb.yaml            # PodDisruptionBudget
   │   ├── networkpolicy.yaml  # NetworkPolicy
   │   ├── configmap.yaml      # ConfigMap (se necessário)
   │   ├── secret.yaml         # Secret (se necessário)
   │   ├── NOTES.txt           # Instruções de uso pós-instalação
   │   └── tests/
   │       └── test-connection.yaml
   └── charts/                 # Subcharts (dependências)
   ```

3. **Aplicar melhores práticas de Chart.yaml**

   ```
   METADADOS
   ├── apiVersion: v2 (somente Helm 3 — nunca v1)
   ├── name: corresponde exatamente ao nome do diretório
   ├── version: semver (versão do chart, não versão do app)
   ├── appVersion: string de versão da aplicação
   ├── description: resumo de uma linha do que o chart implanta
   └── type: application (ou library para helpers compartilhados)

   DEPENDÊNCIAS
   ├── Fixe versões de dependência com ~X.Y.Z (flutuação em nível de patch)
   ├── Use campo condition para tornar subcharts opcionais
   ├── Use alias para múltiplas instâncias do mesmo subchart
   └── Execute helm dependency update após mudanças
   ```

4. **Gerar values.yaml com documentação**
   - Cada value tem um comentário inline explicando propósito e tipo
   - Padrões sensatos que funcionam para desenvolvimento
   - Estrutura amigável para override (plana onde possível, aninhada apenas quando lógico)
   - Sem valores hardcoded específicos de cluster (registro de imagem, domínio, storage class)

5. **Validar**
   ```bash
   python3 scripts/chart_analyzer.py mychart/
   helm lint mychart/
   helm template mychart/ --debug
   ```

### `/helm:review` — Análise de Chart

1. **Verificar estrutura do chart**

   | Verificação | Gravidade | Correção |
   |-------|----------|-----|
   | _helpers.tpl ausente | Alta | Crie helpers para labels e seletores comuns |
   | Sem NOTES.txt | Média | Adicione instruções pós-instalação |
   | Sem .helmignore | Baixa | Crie um para excluir .git, arquivos CI, testes |
   | Campos Chart.yaml ausentes | Média | Adicione description, appVersion, maintainers |
   | Valores hardcoded em templates | Alta | Extraia para values.yaml com padrões |

2. **Verificar qualidade de template**

   | Verificação | Gravidade | Correção |
   |-------|----------|-----|
   | Labels padrão ausentes | Alta | Use labels `app.kubernetes.io/*` via _helpers.tpl |
   | Sem requests/limits de recurso | Crítica | Adicione seção resources com padrões em values.yaml |
   | Tag de imagem hardcoded | Alta | Use `{{ .Values.image.repository }}:{{ .Values.image.tag }}` |
   | imagePullPolicy ausente | Média | Padrão para `IfNotPresent`, sobrescrevível |
   | Probes de liveness/readiness ausentes | Alta | Adicione probes com caminhos e portas configuráveis |
   | Sem pod anti-affinity | Média | Adicione anti-affinity preferencial para HA |
   | Código de template duplicado | Média | Extraia em templates nomeados em _helpers.tpl |

3. **Verificar qualidade do values.yaml**
   ```bash
   python3 scripts/values_validator.py mychart/values.yaml
   ```

4. **Gerar relatório de revisão**
   ```
   REVISÃO DE HELM CHART — [nome do chart]
   Data: [timestamp]

   CRÍTICO: [count]
   ALTO:    [count]
   MÉDIO:   [count]
   BAIXO:   [count]

   [Achados detalhados com recomendações de correção]
   ```

### `/helm:security` — Auditoria de Segurança

1. **Auditoria de segurança de pod**

   | Verificação | Gravidade | Correção |
   |-------|----------|-----|
   | Sem securityContext | Crítica | Adicione runAsNonRoot, readOnlyRootFilesystem |
   | Executando como root | Crítica | Defina `runAsNonRoot: true`, `runAsUser: 1000` |
   | Sistema de arquivos raiz gravável | Alta | Defina `readOnlyRootFilesystem: true` + emptyDir para tmp |
   | Todas as capabilities retidas | Alta | Descarte ALL, adicione apenas as necessárias específicas |
   | Container privilegiado | Crítica | Defina `privileged: false`, use capabilities específicas |
   | Sem perfil seccomp | Média | Defina `seccompProfile.type: RuntimeDefault` |
   | allowPrivilegeEscalation true | Alta | Defina `allowPrivilegeEscalation: false` |

2. **Auditoria de RBAC**

   | Verificação | Gravidade | Correção |
   |-------|----------|-----|
   | Sem ServiceAccount | Média | Crie SA dedicado, não use o padrão |
   | automountServiceAccountToken true | Média | Defina para false a menos que o pod precise de acesso à API K8s |
   | ClusterRole em vez de Role | Média | Use Role com escopo de namespace a menos que seja necessário em todo o cluster |
   | Permissões com wildcard | Crítica | Use nomes de recursos e verbos específicos |
   | Sem RBAC algum | Baixa | Aceitável se o pod não precisar de acesso à API K8s |

3. **Auditoria de rede e secrets**

   | Verificação | Gravidade | Correção |
   |-------|----------|-----|
   | Sem NetworkPolicy | Média | Adicione ingress default-deny + regras de allow explícitas |
   | Secrets em values.yaml | Crítica | Use external secrets operator ou sealed-secrets |
   | Sem PodDisruptionBudget | Média | Adicione PDB com minAvailable para cargas de trabalho HA |
   | hostNetwork: true | Alta | Remova a menos que seja absolutamente necessário (ex.: plugin CNI) |
   | hostPID ou hostIPC | Crítica | Nunca use em charts de aplicação |

4. **Gerar relatório de segurança**
   ```
   SECURITY AUDIT — [nome do chart]
   Data: [timestamp]

   CRÍTICO: [count]
   ALTO:    [count]
   MÉDIO:   [count]
   BAIXO:   [count]

   [Achados detalhados com passos de remediação]
   ```

---

## Ferramentas

### `scripts/chart_analyzer.py`

Utilitário CLI para análise estática de diretórios de Helm chart.

**Funcionalidades:**
- Validação de estrutura de chart (arquivos necessários, layout de diretório)
- Detecção de anti-padrão de template (valores hardcoded, labels ausentes, sem limites de recurso)
- Verificações de metadados Chart.yaml
- Verificação de labels padrão (app.kubernetes.io/*)
- Verificações de baseline de segurança
- Saída JSON e texto

**Uso:**
```bash
# Analisar um diretório de chart
python3 scripts/chart_analyzer.py mychart/

# Saída JSON
python3 scripts/chart_analyzer.py mychart/ --output json

# Análise focada em segurança
python3 scripts/chart_analyzer.py mychart/ --security
```

### `scripts/values_validator.py`

Utilitário CLI para validar values.yaml contra melhores práticas.

**Funcionalidades:**
- Cobertura de documentação (comentários inline)
- Verificações de consistência de tipo
- Detecção de secrets hardcoded
- Análise de qualidade de valor padrão
- Análise de profundidade de estrutura
- Validação de convenção de nomenclatura
- Saída JSON e texto

**Uso:**
```bash
# Validar values.yaml
python3 scripts/values_validator.py values.yaml

# Saída JSON
python3 scripts/values_validator.py values.yaml --output json

# Modo estrito (falha em avisos)
python3 scripts/values_validator.py values.yaml --strict
```

---

## Padrões de Template

### Padrão 1: Labels Padrão (_helpers.tpl)

```yaml
{{/*
Labels comuns para todos os recursos.
*/}}
{{- define "mychart.labels" -}}
helm.sh/chart: {{ include "mychart.chart" . }}
app.kubernetes.io/name: {{ include "mychart.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
app.kubernetes.io/version: {{ .Chart.AppVersion | quote }}
app.kubernetes.io/managed-by: {{ .Release.Service }}
{{- end }}

{{/*
Labels de seletor (subconjunto de labels comuns — devem ser imutáveis).
*/}}
{{- define "mychart.selectorLabels" -}}
app.kubernetes.io/name: {{ include "mychart.name" . }}
app.kubernetes.io/instance: {{ .Release.Name }}
{{- end }}
```

### Padrão 2: Recursos Condicionais

```yaml
{{- if .Values.ingress.enabled -}}
apiVersion: networking.k8s.io/v1
kind: Ingress
metadata:
  name: {{ include "mychart.fullname" . }}
  labels:
    {{- include "mychart.labels" . | nindent 4 }}
  {{- with .Values.ingress.annotations }}
  annotations:
    {{- toYaml . | nindent 4 }}
  {{- end }}
spec:
  {{- if .Values.ingress.tls }}
  tls:
    {{- range .Values.ingress.tls }}
    - hosts:
        {{- range .hosts }}
        - {{ . | quote }}
        {{- end }}
      secretName: {{ .secretName }}
    {{- end }}
  {{- end }}
  rules:
    {{- range .Values.ingress.hosts }}
    - host: {{ .host | quote }}
      http:
        paths:
          {{- range .paths }}
          - path: {{ .path }}
            pathType: {{ .pathType }}
            backend:
              service:
                name: {{ include "mychart.fullname" $ }}
                port:
                  number: {{ $.Values.service.port }}
          {{- end }}
    {{- end }}
{{- end }}
```

### Padrão 3: Pod Spec com Hardening de Segurança

```yaml
spec:
  serviceAccountName: {{ include "mychart.serviceAccountName" . }}
  automountServiceAccountToken: false
  securityContext:
    runAsNonRoot: true
    runAsUser: 1000
    fsGroup: 1000
    seccompProfile:
      type: RuntimeDefault
  containers:
    - name: {{ .Chart.Name }}
      securityContext:
        allowPrivilegeEscalation: false
        readOnlyRootFilesystem: true
        capabilities:
          drop:
            - ALL
      image: "{{ .Values.image.repository }}:{{ .Values.image.tag | default .Chart.AppVersion }}"
      imagePullPolicy: {{ .Values.image.pullPolicy }}
      resources:
        {{- toYaml .Values.resources | nindent 8 }}
      volumeMounts:
        - name: tmp
          mountPath: /tmp
  volumes:
    - name: tmp
      emptyDir: {}
```

---

## Princípios de Design de Values

```
ESTRUTURA
├── Plano sobre aninhado (image.tag > container.spec.image.tag)
├── Agrupado por recurso (service.*, ingress.*, resources.*)
├── Use enabled: true/false para recursos opcionais
├── Documente cada chave com comentários YAML inline
└── Forneça padrões de desenvolvimento sensatos

NOMENCLATURA
├── camelCase para chaves (replicaCount, não replica_count)
├── Chaves booleanas: use adjetivos (enabled, required) não verbos
├── Chaves aninhadas: máximo 3 níveis de profundidade
└── Combine com convenções upstream (image.repository, image.tag, image.pullPolicy)

ANTI-PADRÕES
├── URLs ou domínios de cluster hardcoded
├── Secrets como valores padrão
├── Strings vazias onde null é correto
├── Estruturas profundamente aninhadas (>3 níveis)
├── Values sem documentação
└── values.yaml que não funciona sem overrides
```

---

## Gerenciamento de Dependências

```
SUBCHARTS
├── Use dependências Chart.yaml (não requirements.yaml — Helm 3)
├── Fixe versões: version: ~15.x.x (flutuação de patch)
├── Use condition: para tornar opcionais: condition: postgresql.enabled
├── Use alias: para múltiplas instâncias do mesmo chart
├── Sobrescreva values de subchart sob a chave do nome do subchart em values.yaml
└── Execute helm dependency update antes de empacotar

CHARTS DE BIBLIOTECA
├── type: library em Chart.yaml — sem diretório de templates
├── Exporte apenas templates nomeados — sem recursos renderizados
├── Use para labels compartilhados, annotations, security contexts
└── Versione independentemente dos charts de aplicação
```

---

## Gatilhos Proativos

Sinalize estes sem ser solicitado:

- **Sem _helpers.tpl** → Crie um. Todo chart precisa de labels padrão e helpers de fullname.
- **Tag de imagem hardcoded no template** → Extraia para values.yaml. Tags devem ser sobrescrevíveis.
- **Sem requests/limits de recurso** → Adicione-os. Pods sem limites podem matar o nó.
- **Executando como root** → Adicione securityContext. Sem exceções para charts de produção.
- **Sem NOTES.txt** → Crie um. Usuários precisam de instruções pós-instalação.
- **Secrets nos padrões de values.yaml** → Remova-os. Use placeholders com comentários explicando como fornecer secrets.
- **Sem probes de liveness/readiness** → Adicione-os. O Kubernetes precisa saber se o pod está saudável.
- **Labels app.kubernetes.io ausentes** → Adicione via _helpers.tpl. Obrigatório para rastreamento adequado de recursos.

---

## Instalação

### One-liner (qualquer ferramenta)
```bash
git clone https://github.com/alirezarezvani/claude-skills.git
cp -r claude-skills/engineering/helm-chart-builder ~/.claude/skills/
```

---

## Skills Relacionadas

- **senior-devops** — Escopo DevOps mais amplo (CI/CD, IaC, monitoramento). Complementar — use helm-chart-builder para trabalho específico de chart, senior-devops para pipeline e infraestrutura.
- **docker-development** — Construção de container. Complementar — docker-development constrói as imagens, helm-chart-builder as implanta no Kubernetes.
- **ci-cd-pipeline-builder** — Construção de pipeline. Complementar — helm-chart-builder define o artefato de implantação, ci-cd-pipeline-builder automatiza sua entrega.
- **senior-security** — Segurança de aplicação. Complementar — helm-chart-builder cobre segurança em nível Kubernetes (RBAC, pod security), senior-security cobre ameaças em nível de aplicação.
