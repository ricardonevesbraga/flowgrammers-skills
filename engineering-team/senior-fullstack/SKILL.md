---
name: "senior-fullstack"
description: "Kit de desenvolvimento fullstack com scaffolding de projetos para stacks Next.js, FastAPI, MERN e Django, análise de qualidade de código com scoring de segurança e complexidade, e orientação na seleção de stack. Use quando o usuário pedir para 'criar scaffolding de um novo projeto', 'criar um app Next.js', 'configurar FastAPI com React', 'analisar qualidade de código', 'auditar minha base de código', 'qual stack devo usar', 'gerar boilerplate de projeto' ou mencionar desenvolvimento fullstack, configuração de projeto ou comparação de tech stack."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Desenvolvedor Fullstack Sênior

Skill de desenvolvimento fullstack com scaffolding de projetos e ferramentas de análise de qualidade de código.

---

## Sumário

- [Frases de Ativação](#trigger-phrases)
- [Ferramentas](#ferramentas)
- [Workflows](#workflows)
- [Guias de Referência](#referência-guides)

---

## Frases de Ativação

Use esta skill quando ouvir:
- "criar scaffolding de um novo projeto"
- "criar um app Next.js"
- "configurar FastAPI com React"
- "analisar qualidade de código"
- "verificar problemas de segurança na base de código"
- "qual stack devo usar"
- "configurar um projeto fullstack"
- "gerar boilerplate de projeto"

---

## Ferramentas

### Project Scaffolder

Gera estruturas de projeto fullstack com código boilerplate.

**Templates Suportados:**
- `nextjs` - Next.js 14+ com App Router, TypeScript, Tailwind CSS
- `fastapi-react` - Backend FastAPI + Frontend React + PostgreSQL
- `mern` - MongoDB, Express, React, Node.js com TypeScript
- `django-react` - Django REST Framework + Frontend React

**Uso:**

```bash
# Listar templates disponíveis
python scripts/project_scaffolder.py --list-templates

# Criar projeto Next.js
python scripts/project_scaffolder.py nextjs my-app

# Criar projeto FastAPI + React
python scripts/project_scaffolder.py fastapi-react my-api

# Criar projeto MERN stack
python scripts/project_scaffolder.py mern my-project

# Criar projeto Django + React
python scripts/project_scaffolder.py django-react my-app

# Especificar diretório de saída
python scripts/project_scaffolder.py nextjs my-app --output ./projects

# Saída JSON
python scripts/project_scaffolder.py nextjs my-app --json
```

**Parâmetros:**

| Parâmetro | Descrição |
|-----------|-------------|
| `template` | Nome do template (nextjs, fastapi-react, mern, django-react) |
| `project_name` | Nome para o novo diretório do projeto |
| `--output, -o` | Diretório de saída (padrão: diretório atual) |
| `--list-templates, -l` | Listar todos os templates disponíveis |
| `--json` | Saída em formato JSON |

**A saída inclui:**
- Estrutura do projeto com todos os arquivos necessários
- Configurações de pacotes (package.json, requirements.txt)
- Configuração TypeScript
- Setup de Docker e docker-compose
- Templates de arquivo de ambiente
- Próximos passos para executar o projeto

---

### Analisador de Qualidade de Código

Analisa bases de código fullstack em busca de problemas de qualidade.

**Categorias de Análise:**
- Vulnerabilidades de segurança (segredos hardcoded, riscos de injeção)
- Métricas de complexidade de código (complexidade ciclomática, profundidade de aninhamento)
- Saúde de dependências (pacotes desatualizados, CVEs conhecidos)
- Estimativa de cobertura de testes
- Qualidade de documentação

**Uso:**

```bash
# Analisar diretório atual
python scripts/code_quality_analyzer.py .

# Analisar projeto específico
python scripts/code_quality_analyzer.py /path/to/project

# Saída detalhada com achados completos
python scripts/code_quality_analyzer.py . --verbose

# Saída JSON
python scripts/code_quality_analyzer.py . --json

# Salvar relatório em arquivo
python scripts/code_quality_analyzer.py . --output report.json
```

**Parâmetros:**

| Parâmetro | Descrição |
|-----------|-------------|
| `project_path` | Caminho para o diretório do projeto (padrão: diretório atual) |
| `--verbose, -v` | Mostrar achados detalhados |
| `--json` | Saída em formato JSON |
| `--output, -o` | Escrever relatório em arquivo |

**A saída inclui:**
- Score geral (0-100) com nota em letra
- Problemas de segurança por severidade (crítico, alto, médio, baixo)
- Arquivos de alta complexidade
- Dependências vulneráveis com referências CVE
- Estimativa de cobertura de testes
- Completude de documentação
- Recomendações priorizadas

**Exemplo de Saída:**

```
============================================================
RELATÓRIO DE ANÁLISE DE QUALIDADE DE CÓDIGO
============================================================

Score Geral: 75/100 (Nota: C)
Arquivos Analisados: 45
Total de Linhas: 12.500

--- SEGURANÇA ---
  Crítico: 1
  Alto: 2
  Médio: 5

--- COMPLEXIDADE ---
  Complexidade Média: 8.5
  Arquivos de Alta Complexidade: 3

--- RECOMENDAÇÕES ---
1. [P0] SEGURANÇA
   Problema: Possível segredo hardcoded detectado
   Ação: Remover ou proteger dados sensíveis na linha 42
```

---

## Workflows

### Workflow 1: Iniciar Novo Projeto

1. Escolha a stack adequada com base nos requisitos (consulte a Matriz de Decisão de Stack)
2. Crie o scaffolding da estrutura do projeto
3. Verifique o scaffold: confirme que `package.json` (ou `requirements.txt`) existe
4. Execute verificação de qualidade inicial — resolva quaisquer problemas P0 antes de prosseguir
5. Configure o ambiente de desenvolvimento

```bash
# 1. Criar scaffolding do projeto
python scripts/project_scaffolder.py nextjs my-saas-app

# 2. Verificar se o scaffold foi criado
ls my-saas-app/package.json

# 3. Navegar e instalar
cd my-saas-app
npm install

# 4. Configurar ambiente
cp .env.example .env.local

# 5. Executar verificação de qualidade
python ../scripts/code_quality_analyzer.py .

# 6. Iniciar desenvolvimento
npm run dev
```

### Workflow 2: Auditar Base de Código Existente

1. Execute análise de qualidade de código
2. Revise achados de segurança — corrija todos os problemas P0 (críticos) imediatamente
3. Re-execute o analyzer para confirmar que os problemas P0 foram resolvidos
4. Crie tickets para problemas P1/P2

```bash
# 1. Análise completa
python scripts/code_quality_analyzer.py /path/to/project --verbose

# 2. Gerar relatório detalhado
python scripts/code_quality_analyzer.py /path/to/project --json --output audit.json

# 3. Após corrigir problemas P0, re-executar para verificar
python scripts/code_quality_analyzer.py /path/to/project --verbose
```

### Workflow 3: Seleção de Stack

Use o guia de tech stack para avaliar opções:

1. **SEO Obrigatório?** → Next.js com SSR
2. **Backend intenso em API?** → FastAPI ou NestJS separado
3. **Funcionalidades em tempo real?** → Adicionar camada WebSocket
4. **Expertise da equipe** → Combine a stack com as habilidades da equipe

Veja `references/tech_stack_guide.md` para comparação detalhada.

---

## Guias de Referência

### Padrões de Arquitetura (`references/architecture_patterns.md`)

- Arquitetura de componentes frontend (Atomic Design, Container/Presentational)
- Padrões backend (Clean Architecture, Repository Pattern)
- Design de API (convenções REST, design de schema GraphQL)
- Padrões de banco de dados (connection pooling, transações, read replicas)
- Estratégias de cache (cache-aside, HTTP cache headers)
- Arquitetura de autenticação (JWT + refresh tokens, sessions)

### Workflows de Desenvolvimento (`references/development_workflows.md`)

- Configuração de desenvolvimento local (Docker Compose, configuração de ambiente)
- Workflows Git (trunk-based, conventional commits)
- Pipelines CI/CD (exemplos GitHub Actions)
- Estratégias de testes (unit, integration, E2E)
- Processo de revisão de código (templates de PR, checklists)
- Estratégias de implantação (blue-green, canary, feature flags)
- Monitoramento e observabilidade (logging, métricas, health checks)

### Guia de Tech Stack (`references/tech_stack_guide.md`)

- Comparação de frameworks frontend (Next.js, React+Vite, Vue)
- Frameworks backend (Express, Fastify, NestJS, FastAPI, Django)
- Seleção de banco de dados (PostgreSQL, MongoDB, Redis)
- ORMs (Prisma, Drizzle, SQLAlchemy)
- Soluções de autenticação (Auth.js, Clerk, JWT customizado)
- Plataformas de implantação (Vercel, Railway, AWS)
- Recomendações de stack por caso de uso (MVP, SaaS, Enterprise)

---

## Referência Rápida

### Matriz de Decisão de Stack

| Requisito | Recomendação |
|-------------|---------------|
| Site crítico para SEO | Next.js com SSR |
| Painel interno | React + Vite |
| Backend API-first | FastAPI ou Fastify |
| Escala enterprise | NestJS + PostgreSQL |
| Protótipo rápido | Next.js API routes |
| Dados orientados a documento | MongoDB |
| Queries complexas | PostgreSQL |

### Problemas Comuns

| Problema | Solução |
|-------|----------|
| Queries N+1 | Use DataLoader ou eager loading |
| Builds lentas | Verificar tamanho do bundle, lazy load |
| Complexidade de auth | Use Auth.js ou Clerk |
| Erros de tipo | Habilitar strict mode no tsconfig |
| Problemas de CORS | Configurar middleware corretamente |
