---
Name: code-to-prd
Tier: STANDARD
Category: product
Dependencies: none
Author: Ric Neves - Flowgrammers
Version: 2.1.2
name: code-to-prd
description: |
  Faça engenharia reversa de qualquer base de código em um Documento de Requisitos de Produto (PRD) completo.
  Analisa rotas, componentes, gerenciamento de estado, integrações de API e interações do usuário para produzir
  documentação legível para negócios, detalhada o suficiente para engenheiros ou agentes de IA reconstruírem
  completamente cada página e endpoint. Funciona com frameworks frontend (React, Vue, Angular, Svelte, Next.js, Nuxt),
  frameworks backend (NestJS, Django, Express, FastAPI) e aplicações fullstack.

  Acione quando os usuários mencionarem: gerar PRD, fazer engenharia reversa de requisitos, código para documentação,
  extrair especificações de produto do código, documentar lógica de página, analisar campos e interações de página,
  criar inventário funcional, escrever requisitos de uma base de código existente, documentar endpoints de API
  ou analisar rotas de backend.
license: MIT
metadata:
  updated: 2026-03-17
agents:
  - claude-code
---

## Nome

Código → PRD

## Descrição

Faça engenharia reversa de qualquer base de código frontend, backend ou fullstack em um Documento de Requisitos de Produto (PRD) completo. Analisa rotas, componentes, modelos, APIs e interações do usuário para produzir documentação legível para negócios, detalhada o suficiente para engenheiros ou agentes de IA reconstruírem completamente cada página e endpoint.

# Código → PRD: Engenharia Reversa de Qualquer Base de Código em Requisitos de Produto

## Funcionalidades

- **Fluxo de trabalho de 3 fases**: varredura global → análise página a página → geração de documento estruturado
- **Suporte Frontend**: React, Vue, Angular, Svelte, Next.js (App + Pages Router), Nuxt, SvelteKit, Remix
- **Suporte Backend**: NestJS, Express, Django, Django REST Framework, FastAPI, Flask
- **Suporte Fullstack**: Análise combinada de frontend + backend com saída de PRD unificada
- **Detecção de mock**: Distingue automaticamente integrações de API reais de dados mock/fixture
- **Extração de enums**: Lista exaustivamente todos os códigos de status, mapeamentos de tipo e constantes
- **Extração de modelos**: Analisa modelos Django, entidades NestJS, schemas Pydantic
- **Scripts de automação**: `codebase_analyzer.py` para varredura, `prd_scaffolder.py` para geração de diretórios
- **Lista de verificação de qualidade**: Validação de completude, precisão e legibilidade

## Uso

```bash
# Analisar um projeto e gerar esqueleto de PRD
python3 scripts/codebase_analyzer.py /path/to/project -o analysis.json
python3 scripts/prd_scaffolder.py analysis.json -o prd/ -n "My App"

# Ou use o slash command
/code-to-prd /path/to/project
```

## Exemplos

### Frontend (React)
```bash
/code-to-prd ./src
# → Varre componentes, rotas, chamadas de API, gerenciamento de estado
# → Gera prd/ com documentos por página, dicionário de enums, inventário de API
```

### Backend (Django)
```bash
/code-to-prd ./myproject
# → Detecta Django via manage.py, varre urls.py, views.py, models.py
# → Documenta endpoints, schemas de modelos, configuração de admin, permissões
```

### Fullstack (Next.js)
```bash
/code-to-prd .
# → Analisa tanto páginas app/ quanto rotas api/
# → Gera PRD unificado cobrindo páginas de UI e endpoints de API
```

---

## Função

Você é um analista de produto sênior e arquiteto técnico. Seu trabalho é ler uma base de código frontend, entender o propósito de negócio de cada página e produzir um PRD completo em **linguagem amigável para gerentes de produto**.

### Audiência Dupla

1. **Gerentes de produto / partes interessadas de negócio** — precisam entender *o que* o sistema faz, não *como*
2. **Engenheiros / agentes de IA** — precisam de detalhes suficientes para **reconstruir completamente** os campos, interações e relacionamentos de cada página

Seu documento deve descrever funcionalidades em linguagem não técnica sem omitir nenhum detalhe de negócio.

### Stacks Suportadas

| Stack | Frameworks |
|-------|-----------|
| **Frontend** | React, Vue, Angular, Svelte, Next.js (App/Pages Router), Nuxt, SvelteKit, Remix, Astro |
| **Backend** | NestJS, Express, Fastify, Django, Django REST Framework, FastAPI, Flask |
| **Fullstack** | Next.js (rotas de API + páginas), Nuxt (server/ + pages/), Django (views + templates) |

Para projetos **somente backend**, o conceito de "página" mapeia para **grupos de recursos de API** ou **visualizações admin**. O mesmo fluxo de trabalho de 3 fases se aplica — rotas viram endpoints, componentes viram controllers/views e interações viram fluxos de request/response.

---

## Fluxo de Trabalho

### Fase 1: — Varredura Global do Projeto

Construir contexto global antes de mergulhar nas páginas.

#### 1. Identificar Estrutura do Projeto

Varrer o diretório raiz e entender a organização:

```
Diretórios Frontend:
- Páginas/rotas (pages/, views/, routes/, app/, src/pages/)
- Componentes (components/, modules/)
- Config de rota (router.ts, routes.ts, definições de rota App.tsx)
- Camada de API/serviço (services/, api/, requests/)
- Gerenciamento de estado (store/, models/, context/)
- Arquivos i18n (locales/, i18n/) — nomes de exibição de campos frequentemente ficam aqui

Diretórios Backend (NestJS):
- Módulos (src/modules/, src/*.module.ts)
- Controllers (*.controller.ts) — manipuladores de rota
- Services (*.service.ts) — lógica de negócio
- DTOs (dto/, *.dto.ts) — shapes de request/response
- Entities (entities/, *.entity.ts) — modelos de banco de dados
- Guards/pipes/interceptors — auth, validação, transformação

Diretórios Backend (Django):
- Apps (*/apps.py, */views.py, */models.py, */urls.py)
- Config de URL (urls.py, */urls.py)
- Views (views.py, viewsets.py) — manipuladores de rota
- Models (models.py) — schema do banco de dados
- Serializers (serializers.py) — shapes de request/response
- Forms (forms.py) — validação e definições de campo
- Templates (templates/) — páginas renderizadas pelo servidor
- Admin (admin.py) — configuração do painel admin
```

**Identificar framework** pelo `package.json` (frameworks Node.js) ou arquivos do projeto (`manage.py` para Django, `requirements.txt`/`pyproject.toml` para Python). Padrões de roteamento, componentes e gerenciamento de estado diferem significativamente entre frameworks — a identificação permite análise precisa.

#### 2. Construir Inventário de Rotas e Páginas

Extrair todas as páginas da configuração de rotas em um **inventário de páginas** completo:

| Campo | Descrição |
|-------|-----------|
| Caminho da rota | ex.: `/user/list`, `/order/:id` |
| Título da página | Da configuração de rota, breadcrumbs ou componente de página |
| Módulo / nível de menu | Onde fica na navegação |
| Caminho do arquivo de componente | Arquivo(s) de origem implementando esta página |

Para roteamento baseado em sistema de arquivos (Next.js, Nuxt), inferir da estrutura de diretórios.

**Para projetos backend**, o inventário de páginas vira um **inventário de endpoints/recursos**:

| Campo | Descrição |
|-------|-----------|
| Caminho do endpoint | ex.: `/api/users`, `/api/orders/:id` |
| Método HTTP | GET, POST, PUT, DELETE, PATCH |
| Controller/view | Arquivo de origem que trata esta rota |
| Módulo/app | Qual módulo NestJS ou app Django é responsável |
| Auth necessária | Se autenticação/permissões são necessárias |

Para NestJS: extrair de decorators `@Controller` + `@Get/@Post/@Put/@Delete`.
Para Django: extrair de `urls.py` → `urlpatterns` e `viewsets.py` → registros do router.

#### 3. Mapear Contexto Global

Antes de analisar páginas individuais, capture:

- **Estado global** — informações do usuário, permissões, feature flags, configuração
- **Componentes compartilhados** — layout, nav, guards de auth, error boundaries
- **Enums e constantes** — códigos de status, mapeamentos de tipo, definições de role
- **Config base de API** — URL base, interceptors, headers de auth, tratamento de erros
- **Modelos de banco de dados** (backend) — relacionamentos de entidade, tipos de campo, constraints
- **Middleware** (backend) — middleware de auth, limitação de taxa, registro de logs, CORS
- **DTOs/Serializers** (backend) — shapes de validação de request, formatos de response

Estes serão referenciados em toda a análise de página/endpoint.

---

### Fase 2: — Análise Profunda Página a Página

Analisar cada página no inventário. **Cada página produz seu próprio arquivo Markdown.**

#### Dimensões de Análise

Para cada página, responda:

##### A. Visão Geral da Página
- O que esta página faz? (uma frase)
- Onde ela se encaixa no sistema?
- Qual cenário traz um usuário até aqui?

##### B. Layout e Regiões
- Regiões principais: área de busca, tabela, painel de detalhes, barra de ação, abas, etc.
- Arranjo espacial: topo/base, esquerda/direita, aninhado

##### C. Inventário de Campos (core — seja exaustivo)

**Para páginas de formulário**, liste cada campo:

| Nome do Campo | Tipo | Obrigatório | Padrão | Validação | Descrição de Negócio |
|---------------|------|-------------|--------|-----------|----------------------|
| Nome de usuário | Entrada de texto | Sim | — | Máx 20 chars | Conta de login do sistema |

**Para páginas de tabela/lista**, liste:
- Campos de busca/filtro (tipo, obrigatório, opções de enum)
- Colunas da tabela (nome, formato, ordenável, filtrável)
- Botões de ação por linha (o que cada um faz)

**Prioridade de extração do nome do campo:**
1. Texto de exibição hardcoded no código
2. Valores de tradução i18n
3. Props `placeholder` / `label` / `title` do componente
4. Nomes de variáveis (último recurso — forneça um nome de exibição razoável)

##### D. Lógica de Interação

Descrever como **"ação do usuário → resposta do sistema"**:

```
[Ação]      Usuário clica em "Criar"
[Resposta]  Modal abre com campos de formulário: ...
[Validação] Nome obrigatório, verificação de formato de telefone
[API]       POST /api/user/create com dados do formulário
[Sucesso]   Toast "Criado com sucesso", fechar modal, atualizar lista
[Falha]     Exibir mensagem de erro da API
```

**Cubra todos os tipos de interação:**
- Carregamento/inicialização da página (queries padrão, dados pré-carregados)
- Busca / filtro / reset
- Operações CRUD (criar, ler, atualizar, excluir)
- Tabela: paginação, ordenação, seleção de linha, ações em lote
- Envio e validação de formulário
- Transições de status (ex.: fluxos de aprovação: pendente → aprovado → rejeitado)
- Importar / exportar
- Interdependências de campos (selecionar valor A muda opções no campo B)
- Controles de permissão (botões/campos visíveis apenas para certos papéis)
- Polling / atualização automática / atualizações em tempo real

##### E. Dependências de API

**Caso 1: API integrada** (chamadas HTTP reais no código)

| Nome da API | Método | Caminho | Gatilho | Parâmetros Principais | Notas |
|-------------|--------|---------|---------|----------------------|-------|
| Obter usuários | GET | /api/user/list | Carregamento, busca | page, size, palavra-chave | Paginado |

**Caso 2: API não integrada** (dados mock/hardcoded)

Quando a página usa dados mock, fixtures hardcoded, simulações com `setTimeout`, ou stubs `Promise.resolve()` — a API ainda não é real. **Faça engenharia reversa da especificação de API necessária** a partir da funcionalidade e shape dos dados da página.

Para cada API necessária, documente:
- Método, caminho sugerido, gatilho
- Parâmetros de entrada (nome, tipo, obrigatório, descrição)
- Campos de saída (nome, tipo, descrição)
- Descrição da lógica de negócio principal

**Sinais de detecção:**
- `setTimeout` / `Promise.resolve()` retornando dados → mock
- Dados definidos no componente ou em arquivos `*.mock.*` → mock
- Chamadas HTTP reais (`axios`, `fetch`, camada de serviço) com caminhos reais → integrado
- Diretório `__mocks__` → mock

##### F. Relacionamentos de Página

- **Entrada**: Quais páginas apontam para cá? Quais parâmetros elas passam?
- **Saída**: Para onde os usuários podem navegar daqui? Quais parâmetros?
- **Acoplamento de dados**: Quais páginas compartilham dados ou acionam atualizações umas nas outras?

---

### Fase 3: — Geração de Documentação

#### Estrutura de Saída

Criar `prd/` na raiz do projeto (ou diretório especificado pelo usuário):

```
prd/
├── README.md                     # Visão geral do sistema
├── pages/
│   ├── 01-user-mgmt-list.md      # Um arquivo por página
│   ├── 02-user-mgmt-detail.md
│   ├── 03-order-mgmt-list.md
│   └── ...
└── appendix/
    ├── enum-dictionary.md         # Todos enums, códigos de status, mapeamentos de tipo
    ├── page-relationships.md      # Mapa de navegação entre páginas
    └── api-inventory.md           # Referência completa de API
```

#### Template README.md

```markdown
# [Nome do Sistema] — Documento de Requisitos de Produto

## Visão Geral do Sistema
[2-3 parágrafos: o que o sistema faz, contexto de negócio, usuários principais]

## Visão Geral dos Módulos

| Módulo | Páginas | Funcionalidade Principal |
|--------|---------|--------------------------|
| Gerenciamento de Usuários | Lista de usuários, Detalhes do usuário, Gerenciamento de papéis | CRUD de usuários, atribuição de papéis e permissões |

## Inventário de Páginas

| # | Nome da Página | Rota | Módulo | Link de Documento |
|---|----------------|------|--------|-------------------|
| 1 | Lista de Usuários | /user/list | Gerenc. Usuários | [→](./pages/01-user-mgmt-list.md) |

## Notas Globais

### Modelo de Permissão
[Resumir sistema de auth/role se presente no código]

### Padrões de Interação Comuns
[Regras globais: todas as exclusões requerem confirmação, listas padrão por created_at desc, etc.]
```

#### Template de Documentação por Página

```markdown
# [Nome da Página]

> **Rota:** `/xxx/xxx`
> **Módulo:** [Nome do módulo]
> **Gerado:** [Data]

## Visão Geral
[2-3 frases: função principal e caso de uso]

## Layout
[Detalhamento de regiões — descrição em texto ou diagrama ASCII]

## Campos

### [Região: ex. "Filtros de Busca"]
| Campo | Tipo | Obrigatório | Opções / Enum | Padrão | Notas |
|-------|------|-------------|---------------|--------|-------|

### [Região: ex. "Tabela de Dados"]
| Coluna | Formato | Ordenável | Filtrável | Notas |
|--------|---------|-----------|-----------|-------|

### [Região: ex. "Ações"]
| Botão | Condição de Visibilidade | Comportamento |
|-------|--------------------------|---------------|

## Interações

### Carregamento da Página
[O que acontece ao montar]

### [Cenário: ex. "Busca"]
- **Gatilho:** [Ação do usuário]
- **Comportamento:** [Resposta do sistema]
- **Regras especiais:** [Se houver]

### [Cenário: ex. "Criar"]
- **Gatilho:** ...
- **Conteúdo do Modal/Drawer:** [Campos e lógica dentro]
- **Validação:** ...
- **Em caso de sucesso:** ...

## Dependências de API

| API | Método | Caminho | Gatilho | Notas |
|-----|--------|---------|---------|-------|
| ... | ... | ... | ... | ... |

## Relacionamentos de Página
- **De:** [Páginas de origem + parâmetros]
- **Para:** [Páginas de destino + parâmetros]
- **Acoplamento de dados:** [Gatilhos de atualização entre páginas]

## Regras de Negócio
[Qualquer coisa que não se encaixe acima]
```

---

## Princípios Fundamentais

### 1. Linguagem de Negócio Primeiro
Não escreva "chama `useState` para gerenciar estado de loading." Escreva "o botão de busca exibe um spinner para evitar envios duplicados."

Não escreva "useEffect busca ao montar." Escreva "a página carrega automaticamente a primeira página de resultados ao abrir."

Inclua detalhes técnicos apenas quando eles **afetam diretamente o comportamento do produto**: caminhos de API (engenheiros precisam deles), regras de validação (afetam a UX), condições de permissão (afetam visibilidade).

### 2. Não Perca a Lógica Oculta
O código contém lógica que PMs podem não perceber que existe:
- Interdependências de campos (tipo A exibe campo X; tipo B exibe campo Y)
- Visibilidade condicional de botões
- Formatação de dados (moeda com 2 decimais, formatos de data, mapeamentos de rótulos de status)
- Ordem de classificação padrão e tamanho de página
- Efeitos de debounce/throttle na entrada do usuário
- Intervalos de polling / atualização automática

### 3. Listar Enums Exaustivamente
Quando o código define enums (códigos de status, códigos de tipo, tipos de papel), liste **cada valor e seu significado**. Eles frequentemente estão espalhados por arquivos de constantes, configurações `valueEnum` de componentes ou mapeadores de resposta de API.

### 4. Marque Incerteza — Não Adivinhe
Se o significado de negócio de um campo ou lógica não puder ser determinado a partir do código (ex.: nomes de variáveis abreviados, condicionais excessivamente complexos), marque como `[A CONFIRMAR]` e explique o que você observou e por que está incerto. Nunca fabrique significado de negócio.

### 5. Mantenha Arquivos de Página Auto-Contidos
O Markdown de cada página deve ser **independente** — ler apenas aquele arquivo dá compreensão completa. Use links relativos ao referenciar outras páginas ou entradas do apêndice.

---

## Estratégias por Tipo de Página

### Páginas Frontend

| Tipo de Página | Áreas de Foco |
|----------------|---------------|
| **Lista / Tabela** | Condições de busca, colunas, ações por linha, paginação, operações em lote |
| **Formulário / Criar-Editar** | Cada campo, validação, interdependências, comportamento após envio |
| **Detalhe / Visualização** | Informações exibidas, organização de abas/seções, ações disponíveis |
| **Modal / Drawer** | Descrever como parte da página acionadora — não um arquivo separado. Mas documentar totalmente o conteúdo |
| **Dashboard** | Cards de dados, gráficos, significado das métricas, dimensões de filtro, frequência de atualização |

### Endpoints de Backend (NestJS / Django / Express)

| Tipo de Endpoint | Áreas de Foco |
|------------------|---------------|
| **Recurso CRUD** | Todos os campos (de DTO/serializer), regras de validação, permissões, paginação, filtragem, ordenação |
| **Endpoints de Auth** | Fluxo de login/registro, formato do token, lógica de refresh, redefinição de senha, provedores OAuth |
| **Upload de arquivo** | Tipos aceitos, limites de tamanho, destino de armazenamento, pipeline de processamento |
| **Webhook / evento** | Condições de gatilho, shape do payload, política de retry, idempotência |
| **Job em background** | Gatilho, agenda, entrada/saída, tratamento de falhas, monitoramento |
| **Views Admin** (Django) | Modelos registrados, list_display, search_fields, filtros, modelos inline, ações customizadas |

---

## Ritmo de Execução

**Projetos grandes (>15 páginas):** Trabalhe em lotes de 3-5 páginas por módulo. Conclua a visão geral do sistema + inventário de páginas primeiro. Produza cada lote para revisão do usuário antes de prosseguir.

**Projetos pequenos (≤15 páginas):** Conclua toda a análise em uma única passagem.

---

## Armadilhas Comuns

| Armadilha | Correção |
|-----------|----------|
| Usar nomes de componentes como nomes de páginas | `UserManagementTable` → "Lista de Gerenciamento de Usuários" |
| Pular modais e drawers | Eles contêm lógica de negócio crítica — documente completamente |
| Perder nomes de campos i18n | Verifique arquivos de tradução, não apenas o JSX do componente |
| Ignorar parâmetros dinâmicos de rota | `/order/:id` = página requer um ID de pedido para carregar |
| Esquecer controles de permissão | Documente quais papéis veem quais botões/páginas |
| Assumir que todas as APIs são reais | Verifique padrões de dados mock antes de documentar endpoints |
| Pular customização do admin Django | `admin.py` frequentemente contém regras de negócio críticas (filtros de lista, ações customizadas, inlines) |
| Perder guards/pipes do NestJS | `@UseGuards`, `@UsePipes` contêm lógica de auth e validação que afeta o comportamento |
| Ignorar constraints do banco de dados | Constraints de campo do modelo (unique, max_length, choices) são regras de validação para o PRD |
| Negligenciar middleware | Middleware de auth, limitadores de taxa e config CORS definem comportamento em todo o sistema |

---

## Ferramentas

### Scripts

| Script | Propósito | Uso |
|--------|-----------|-----|
| `scripts/codebase_analyzer.py` | Varrer base de código → extrair rotas, APIs, modelos, enums, estrutura | `python3 codebase_analyzer.py /path/to/project` |
| `scripts/prd_scaffolder.py` | Gerar esqueleto de diretório PRD a partir do JSON de análise | `python3 prd_scaffolder.py analysis.json` |

**Fluxo de trabalho recomendado:**
```bash
# 1. Analisar o projeto (saída JSON — funciona para frontend, backend ou fullstack)
python3 scripts/codebase_analyzer.py /path/to/project -o analysis.json

# 2. Revisar a análise (resumo em markdown)
python3 scripts/codebase_analyzer.py /path/to/project -f markdown

# 3. Scaffoldar o diretório de PRD com stubs
python3 scripts/prd_scaffolder.py analysis.json -o prd/ -n "My App"

# 4. Preencher seções TODO página a página usando o fluxo de trabalho do SKILL.md
```

Ambos os scripts são **somente stdlib** — sem necessidade de pip install.

### Referências

| Arquivo | Conteúdo |
|---------|----------|
| `references/prd-quality-checklist.md` | Lista de verificação de completude, precisão e legibilidade |
| `references/framework-patterns.md` | Padrões específicos de framework para rotas, estado, APIs, formulários, permissões |

---

## Atribuição

Esta skill foi inspirada por [code-to-prd](https://github.com/lihanglogan/code-to-prd) de [@lihanglogan](https://github.com/lihanglogan), que propôs o conceito original e a metodologia na [PR #368](https://github.com/alirezarezvani/claude-skills/pull/368). O fluxo de trabalho central de três fases (varredura global → análise página a página → geração de documento estruturado) originou-se desse trabalho. Esta versão foi reconstruída do zero em inglês com ferramentas adicionadas (scripts de análise, scaffolder, referência de framework, lista de verificação de qualidade).
