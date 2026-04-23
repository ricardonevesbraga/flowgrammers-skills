---
name: "docker-development"
description: "Skill e plugin para desenvolvimento Docker e container no Claude Code para otimização de Dockerfile, orquestração docker-compose, builds multi-stage e hardening de segurança de container. Use quando: o usuário quiser otimizar um Dockerfile, criar ou melhorar configurações docker-compose, implementar builds multi-stage, auditar segurança de container, reduzir tamanho de imagem ou seguir melhores práticas de container."
license: MIT
metadata:
  version: 1.0.0
  author: Ric Neves - Flowgrammers
  category: engineering
  updated: 2026-03-16
agents:
  - claude-code
---

# Docker Development

> Imagens menores. Builds mais rápidos. Containers seguros. Sem suposições.

Workflow Docker opinativo que transforma Dockerfiles inchados em containers de nível produção. Cobre otimização, builds multi-stage, orquestração compose e hardening de segurança.

Não é um tutorial Docker — é um conjunto de decisões concretas sobre como construir containers que não desperdiçam tempo, espaço ou superfície de ataque.

---

## Slash Comandos

| Comando | O que faz |
|---------|-------------|
| `/docker:optimize` | Analisa e otimiza um Dockerfile para tamanho, velocidade e cache de camada |
| `/docker:compose` | Gera ou melhora docker-compose.yml com melhores práticas |
| `/docker:security` | Audita um Dockerfile ou container em execução para problemas de segurança |

---

## Quando Esta Skill É Ativada

Reconheça estes padrões do usuário:

- "Otimize este Dockerfile"
- "Meu build Docker está lento"
- "Crie um docker-compose para este projeto"
- "Este Dockerfile é seguro?"
- "Reduza o tamanho da minha imagem Docker"
- "Configure builds multi-stage"
- "Melhores práticas Docker para [linguagem/framework]"
- Qualquer solicitação envolvendo: Dockerfile, docker-compose, container, tamanho de imagem, cache de build, segurança Docker

Se o usuário tem um Dockerfile ou quer containerizar algo → esta skill se aplica.

---

## Workflow

### `/docker:optimize` — Otimização de Dockerfile

1. **Analisar o estado atual**
   - Leia o Dockerfile
   - Identifique a imagem base e seu tamanho
   - Conte camadas (cada RUN/COPY/ADD = 1 camada)
   - Verifique anti-padrões comuns

2. **Aplicar lista de verificação de otimização**

   ```
   IMAGEM BASE
   ├── Use tags específicas, nunca :latest em produção
   ├── Prefira variantes slim/alpine (debian-slim > ubuntu > debian)
   ├── Fixe digest para reprodutibilidade em CI: image@sha256:...
   └── Combine base com necessidades de runtime (não use python:3.12 para um binário compilado)

   OTIMIZAÇÃO DE CAMADA
   ├── Combine comandos RUN relacionados com && \
   ├── Ordene camadas: menos mudáveis primeiro (deps antes do código fonte)
   ├── Limpe cache do gerenciador de pacotes na mesma camada RUN
   ├── Use .dockerignore para excluir arquivos desnecessários
   └── Separe deps de build das deps de runtime

   CACHE DE BUILD
   ├── COPY arquivos de dependência antes do código fonte (package.json, requirements.txt, go.mod)
   ├── Instale deps em uma camada separada do COPY de código
   ├── Use mounts de cache BuildKit: --mount=type=cache,target=/root/.cache
   └── Evite COPY . . antes da instalação de dependências

   BUILDS MULTI-STAGE
   ├── Estágio 1: build (SDK completo, ferramentas de build, deps de dev)
   ├── Estágio 2: runtime (base mínima, apenas artefatos de produção)
   ├── COPY --from=builder apenas o necessário
   └── A imagem final não deve ter ferramentas de build, código fonte ou deps de dev
   ```

3. **Gerar Dockerfile otimizado**
   - Aplique todas as otimizações relevantes
   - Adicione comentários inline explicando cada decisão
   - Reporte a redução estimada de tamanho

4. **Validar**
   ```bash
   python3 scripts/dockerfile_analyzer.py Dockerfile
   ```

### `/docker:compose` — Configuração Docker Compose

1. **Identificar serviços**
   - Aplicação (web, API, worker)
   - Banco de dados (postgres, mysql, redis, mongo)
   - Cache (redis, memcached)
   - Fila (rabbitmq, kafka)
   - Proxy reverso (nginx, traefik, caddy)

2. **Aplicar melhores práticas de compose**

   ```
   SERVIÇOS
   ├── Use depends_on com condition: service_healthy
   ├── Adicione healthchecks para cada serviço
   ├── Defina limites de recurso (mem_limit, cpus)
   ├── Use named volumes para dados persistentes
   └── Fixe versões de imagem

   REDE
   ├── Crie redes explícitas (não dependa do padrão)
   ├── Separe redes frontend e backend
   ├── Exponha apenas portas que precisam de acesso externo
   └── Use internal: true para redes somente de backend

   AMBIENTE
   ├── Use env_file para secrets, não variáveis de ambiente inline
   ├── Nunca faça commit de arquivos .env (adicione ao .gitignore)
   ├── Use substituição de variável: ${VAR:-default}
   └── Documente todas as variáveis de ambiente necessárias

   DESENVOLVIMENTO vs PRODUÇÃO
   ├── Use profiles ou arquivos de override do compose
   ├── Dev: bind mounts para hot reload, portas de debug expostas
   ├── Prod: named volumes, sem portas de debug, restart: unless-stopped
   └── docker-compose.override.yml para config somente de dev
   ```

3. **Gerar arquivo compose**
   - Produza docker-compose.yml com healthchecks, redes, volumes
   - Gere .env.example com todas as variáveis necessárias documentadas
   - Adicione anotações de perfil dev/prod

### `/docker:security` — Auditoria de Segurança de Container

1. **Auditoria de Dockerfile**

   | Verificação | Gravidade | Correção |
   |-------|----------|-----|
   | Executando como root | Crítica | Adicione `USER nonroot` após criar usuário |
   | Usando tag :latest | Alta | Fixe para versão específica |
   | Secrets em ENV/ARG | Crítica | Use secrets BuildKit: `--mount=type=secret` |
   | COPY com glob amplo | Média | Use caminhos específicos, adicione .dockerignore |
   | EXPOSE desnecessário | Baixa | Exponha apenas portas que o app usa |
   | Sem HEALTHCHECK | Média | Adicione HEALTHCHECK com intervalo apropriado |
   | Instruções privilegiadas | Alta | Evite `--privileged`, descarte capabilities |
   | Cache do gerenciador de pacotes retido | Baixa | Limpe na mesma camada RUN |

2. **Verificações de segurança em runtime**

   | Verificação | Gravidade | Correção |
   |-------|----------|-----|
   | Container executando como root | Crítica | Defina usuário no Dockerfile ou compose |
   | Sistema de arquivos raiz gravável | Média | Use `read_only: true` no compose |
   | Todas as capabilities retidas | Alta | Descarte todas, adicione apenas as necessárias: `cap_drop: [ALL]` |
   | Sem limites de recurso | Média | Defina `mem_limit` e `cpus` |
   | Modo de rede host | Alta | Use rede bridge ou personalizada |
   | Mounts sensíveis | Crítica | Nunca monte /etc, /var/run/docker.sock em prod |
   | Sem driver de log configurado | Baixa | Defina `logging:` com limites de tamanho |

3. **Gerar relatório de segurança**
   ```
   SECURITY AUDIT — [nome do Dockerfile/Imagem]
   Data: [timestamp]

   CRÍTICO: [count]
   ALTO:    [count]
   MÉDIO:   [count]
   BAIXO:   [count]

   [Achados detalhados com recomendações de correção]
   ```

---

## Ferramentas

### `scripts/dockerfile_analyzer.py`

Utilitário CLI para análise estática de Dockerfiles.

**Funcionalidades:**
- Contagem de camadas e sugestões de otimização
- Análise de imagem base com estimativas de tamanho
- Detecção de anti-padrões (15+ regras)
- Sinalização de problemas de segurança
- Detecção e validação de build multi-stage
- Saída JSON e texto

**Uso:**
```bash
# Analisar um Dockerfile
python3 scripts/dockerfile_analyzer.py Dockerfile

# Saída JSON
python3 scripts/dockerfile_analyzer.py Dockerfile --output json

# Analisar com foco em segurança
python3 scripts/dockerfile_analyzer.py Dockerfile --security

# Verificar um diretório específico
python3 scripts/dockerfile_analyzer.py path/to/Dockerfile
```

### `scripts/compose_validator.py`

Utilitário CLI para validar arquivos docker-compose.

**Funcionalidades:**
- Validação de dependência de serviço
- Detecção de presença de healthcheck
- Análise de configuração de rede
- Validação de mount de volume
- Auditoria de variável de ambiente
- Detecção de conflito de porta
- Pontuação de melhores práticas

**Uso:**
```bash
# Validar um arquivo compose
python3 scripts/compose_validator.py docker-compose.yml

# Saída JSON
python3 scripts/compose_validator.py docker-compose.yml --output json

# Modo estrito (falha em avisos)
python3 scripts/compose_validator.py docker-compose.yml --strict
```

---

## Padrões de Build Multi-Stage

### Padrão 1: Linguagem Compilada (Go, Rust, C++)

```dockerfile
# Estágio de build
FROM golang:1.22-alpine AS builder
WORKDIR /app
COPY go.mod go.sum ./
RUN go mod download
COPY . .
RUN CGO_ENABLED=0 go build -ldflags="-s -w" -o /app/server ./cmd/server

# Estágio de runtime
FROM gcr.io/distroless/static-debian12
COPY --from=builder /app/server /server
USER nonroot:nonroot
ENTRYPOINT ["/server"]
```

### Padrão 2: Node.js / TypeScript

```dockerfile
# Estágio de dependências
FROM node:20-alpine AS deps
WORKDIR /app
COPY package.json package-lock.json ./
RUN npm ci --production=false

# Estágio de build
FROM deps AS builder
COPY . .
RUN npm run build

# Estágio de runtime
FROM node:20-alpine
WORKDIR /app
RUN addgroup -g 1001 -S appgroup && adduser -S appuser -u 1001
COPY --from=builder /app/dist ./dist
COPY --from=deps /app/node_modules ./node_modules
COPY package.json ./
USER appuser
EXPOSE 3000
CMD ["node", "dist/index.js"]
```

### Padrão 3: Python

```dockerfile
# Estágio de build
FROM python:3.12-slim AS builder
WORKDIR /app
COPY requirements.txt .
RUN pip install --no-cache-dir --prefix=/install -r requirements.txt

# Estágio de runtime
FROM python:3.12-slim
WORKDIR /app
RUN groupadd -r appgroup && useradd -r -g appgroup appuser
COPY --from=builder /install /usr/local
COPY . .
USER appuser
EXPOSE 8000
CMD ["python", "-m", "uvicorn", "main:app", "--host", "0.0.0.0", "--port", "8000"]
```

---

## Árvore de Decisão de Imagem Base

```
É um binário compilado (Go, Rust, C)?
├── Sim → distroless/static ou scratch
└── Não
    ├── Precisa de shell para depuração?
    │   ├── Sim → variante alpine (ex.: node:20-alpine)
    │   └── Não → variante distroless
    ├── Precisa de glibc (não musl)?
    │   ├── Sim → variante slim (ex.: python:3.12-slim)
    │   └── Não → variante alpine
    └── Precisa de pacotes específicos do SO?
        ├── Muitos → debian-slim
        └── Poucos → alpine + apk add
```

---

## Gatilhos Proativos

Sinalize estes sem ser solicitado:

- **Dockerfile usa :latest** → Sugira fixar para uma tag de versão específica.
- **Sem .dockerignore** → Crie um. No mínimo: `.git`, `node_modules`, `__pycache__`, `.env`.
- **COPY . . antes da instalação de dependências** → Quebra o cache. Reordene para instalar deps primeiro.
- **Executando como root** → Adicione instrução USER. Sem exceções para produção.
- **Secrets em ENV ou ARG** → Use mounts de secret BuildKit. Nunca bake secrets em camadas.
- **Imagem acima de 1GB** → Build multi-stage obrigatório. Não há razão para uma imagem de produção tão grande.
- **Sem healthcheck** → Adicione um. Orquestradores (Compose, K8s) precisam dele para gerenciamento adequado do ciclo de vida.
- **apt-get sem limpeza na mesma camada** → `rm -rf /var/lib/apt/lists/*` no mesmo RUN.

---

## Instalação

### One-liner (qualquer ferramenta)
```bash
git clone https://github.com/alirezarezvani/claude-skills.git
cp -r claude-skills/engineering/docker-development ~/.claude/skills/
```

---

## Skills Relacionadas

- **senior-devops** — Escopo DevOps mais amplo (CI/CD, IaC, monitoramento). Complementar — use docker-development para trabalho específico de container, senior-devops para pipeline e infraestrutura.
- **senior-security** — Segurança de aplicação. Complementar — docker-development cobre segurança de container, senior-security cobre ameaças em nível de aplicação.
- **autoresearch-agent** — Pode otimizar tempos de build Docker ou tamanhos de imagem como experimentos mensuráveis.
- **ci-cd-pipeline-builder** — Construção de pipeline. Complementar — docker-development constrói os containers, ci-cd-pipeline-builder os implanta.
