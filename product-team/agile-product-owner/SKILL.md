---
name: "agile-product-owner"
description: Gestão ágil de produto para gerenciamento de backlog e execução de sprint. Cobre escrita de user stories, critérios de aceitação, planejamento de sprint e rastreamento de velocidade. Use para escrever user stories, criar critérios de aceitação, planejar sprints, estimar story points, desmembrar épicos ou priorizar o backlog.
triggers:
  - write user story
  - create acceptance criteria
  - plan sprint
  - estimate story points
  - break down epic
  - prioritize backlog
  - sprint planning
  - INVEST criteria
  - Given When Then
  - user story template
  - sprint capacity
  - velocity tracking
---

# Agile Product Owner

Kit de ferramentas de gerenciamento de backlog e execução de sprint para product owners, incluindo geração de user stories, padrões de critérios de aceitação, planejamento de sprint e rastreamento de velocidade.

---

## Sumário

- [Fluxo de Trabalho de Geração de User Stories](#fluxo-de-trabalho-de-geração-de-user-stories)
- [Padrões de Critérios de Aceitação](#padrões-de-critérios-de-aceitação)
- [Fluxo de Trabalho de Desmembramento de Épico](#fluxo-de-trabalho-de-desmembramento-de-épico)
- [Fluxo de Trabalho de Planejamento de Sprint](#fluxo-de-trabalho-de-planejamento-de-sprint)
- [Priorização do Backlog](#priorização-do-backlog)
- [Documentação de Referência](#documentação-de-referência)
- [Ferramentas](#ferramentas)

---

## Fluxo de Trabalho de Geração de User Stories

Criar user stories conformes ao INVEST a partir de requisitos:

1. Identificar a persona (quem se beneficia desta funcionalidade)
2. Definir a ação ou capacidade necessária
3. Articular o benefício ou valor entregue
4. Escrever critérios de aceitação usando Dado-Quando-Então
5. Estimar story points usando a escala Fibonacci
6. Validar conforme os critérios INVEST
7. Adicionar ao backlog com prioridade
8. **Validação:** A story passa por todos os critérios INVEST; os critérios de aceitação são testáveis

### Template de User Story

```
As a [persona],
I want to [action/capability],
So that [benefit/value].
```

**Exemplo:**
```
As a marketing manager,
I want to export campaign reports to PDF,
So that I can share results with stakeholders who don't have system access.
```

### Tipos de Story

| Tipo | Template | Exemplo |
|------|----------|---------|
| Funcionalidade | As a [persona], I want to [action] so that [benefit] | As a user, I want to filter search results so that I find items faster |
| Melhoria | As a [persona], I need [capability] to [goal] | As a user, I need faster page loads to complete tasks without frustration |
| Correção de Bug | As a [persona], I expect [behavior] when [condition] | As a user, I expect my cart to persist when I refresh the page |
| Habilitador | As a developer, I need to [technical task] to enable [capability] | As a developer, I need to implement cache to enable instant search |

### Referência de Personas

| Persona | Necessidades Típicas | Contexto |
|---------|----------------------|----------|
| Usuário Final | Eficiência, simplicidade, confiabilidade | Uso diário de funcionalidades |
| Administrador | Controle, visibilidade, segurança | Gerenciamento do sistema |
| Usuário Avançado | Automação, customização, atalhos | Fluxos de trabalho especializados |
| Novo Usuário | Orientação, aprendizado, segurança | Onboarding |

---

## Padrões de Critérios de Aceitação

Escrever critérios de aceitação testáveis usando o formato Dado-Quando-Então.

### Template Dado-Quando-Então

```
Given [precondition/context],
When [action/trigger],
Then [expected outcome].
```

**Exemplos:**
```
Given the user is logged in with valid credentials,
When they click the "Export" button,
Then a PDF download starts within 2 seconds.

Given the user has entered an invalid email format,
When they submit the registration form,
Then an inline error message displays "Please enter a valid email address."

Given the shopping cart contains items,
When the user refreshes the browser,
Then the cart contents remain unchanged.
```

### Lista de Verificação dos Critérios de Aceitação

Cada story deve incluir critérios para:

| Categoria | Exemplo |
|-----------|---------|
| Caminho Feliz | Given valid input, When submitted, Then success message displayed |
| Validação | Should reject input when required field is empty |
| Tratamento de Erros | Must show user-friendly message when API fails |
| Desempenho | Should complete operation within 2 seconds |
| Acessibilidade | Must be navigable via keyboard only |

### Critérios Mínimos por Tamanho de Story

| Story Points | Contagem Mínima de Critérios |
|--------------|------------------------------|
| 1-2 | 3-4 critérios |
| 3-5 | 4-6 critérios |
| 8 | 5-8 critérios |
| 13+ | Divida a story |

Veja `references/user-story-templates.md` para biblioteca completa de templates.

---

## Fluxo de Trabalho de Desmembramento de Épico

Dividir épicos em stories de tamanho adequado para sprint e entregáveis:

1. Definir escopo do épico e critérios de sucesso
2. Identificar todas as personas afetadas pelo épico
3. Listar todas as capacidades necessárias para cada persona
4. Agrupar capacidades em stories lógicas
5. Validar que cada story é ≤8 pontos
6. Identificar dependências entre stories
7. Sequenciar stories para entrega incremental
8. **Validação:** Cada story entrega valor independente; o total de stories cobre o escopo do épico

### Técnicas de Divisão

| Técnica | Quando Usar | Exemplo |
|---------|-------------|---------|
| Por etapa do fluxo de trabalho | Processo linear | "Checkout" → "Adicionar ao carrinho" + "Informar pagamento" + "Confirmar pedido" |
| Por persona | Múltiplos tipos de usuário | "Dashboard" → "Painel admin" + "Painel do usuário" |
| Por tipo de dado | Múltiplas entradas | "Importar" → "Importar CSV" + "Importar Excel" |
| Por operação | Funcionalidade CRUD | "Gerenciar usuários" → "Criar" + "Editar" + "Excluir" |
| Caminho feliz primeiro | Redução de risco | "Funcionalidade" → "Fluxo básico" + "Tratamento de erros" + "Casos extremos" |

### Exemplo de Épico

**Épico:** Dashboard do Usuário

**Desmembramento:**
```
Épico: Dashboard do Usuário (34 pontos no total)
├── US-001: Visualizar métricas principais (5 pts) - Usuário Final
├── US-002: Personalizar layout (5 pts) - Usuário Avançado
├── US-003: Exportar dados para CSV (3 pts) - Usuário Final
├── US-004: Compartilhar com a equipe (5 pts) - Usuário Final
├── US-005: Configurar alertas (5 pts) - Usuário Avançado
├── US-006: Filtrar por período de datas (3 pts) - Usuário Final
├── US-007: Visão geral do admin (5 pts) - Admin
└── US-008: Habilitar cache (3 pts) - Habilitador
```

---

## Fluxo de Trabalho de Planejamento de Sprint

Planejar a capacidade do sprint e selecionar stories:

1. Calcular a capacidade da equipe (velocidade × disponibilidade)
2. Revisar o objetivo do sprint com as partes interessadas
3. Selecionar stories do backlog priorizado
4. Preencher até 80-85% da capacidade (comprometido)
5. Adicionar objetivos stretch (10-15% adicionais)
6. Identificar dependências e riscos
7. Quebrar stories complexas em tarefas
8. **Validação:** Pontos comprometidos ≤85% da capacidade; todas as stories têm critérios de aceitação

### Cálculo de Capacidade

```
Capacidade do Sprint = Velocidade Média × Fator de Disponibilidade

Exemplo:
Velocidade Média: 30 pontos
Disponibilidade da equipe: 90% (um membro parcialmente ausente)
Capacidade Ajustada: 27 pontos

Comprometido: 23 pontos (85% de 27)
Stretch: 4 pontos (15% de 27)
```

### Fatores de Disponibilidade

| Cenário | Fator |
|---------|-------|
| Sprint completo, sem férias | 1.0 |
| Um membro da equipe 50% ausente | 0.9 |
| Feriado durante o sprint | 0.8 |
| Múltiplos membros ausentes | 0.7 |

### Template de Carregamento do Sprint

```
Capacidade do Sprint: 27 pontos
Objetivo do Sprint: [Objetivo claro e mensurável]

COMPROMETIDO (23 pontos):
[A] US-001: Dashboard do usuário (5 pts)
[A] US-002: Funcionalidade de exportação (3 pts)
[A] US-003: Filtro de busca (5 pts)
[M] US-004: Página de configurações (5 pts)
[M] US-005: Tooltips de ajuda (3 pts)
[B] US-006: Opções de tema (2 pts)

STRETCH (4 pontos):
[B] US-007: Opções de ordenação (2 pts)
[B] US-008: Visualização de impressão (2 pts)
```

Veja `references/sprint-planning-guide.md` para procedimentos completos de planejamento.

---

## Priorização do Backlog

Priorizar o backlog usando avaliação de valor e esforço.

### Níveis de Prioridade

| Prioridade | Definição | Meta do Sprint |
|------------|-----------|----------------|
| Crítico | Bloqueando usuários, segurança, perda de dados | Imediato |
| Alto | Funcionalidade principal, necessidades-chave do usuário | Este sprint |
| Médio | Melhorias, aprimoramentos | Próximos 2-3 sprints |
| Baixo | Nice-to-have, pequenas melhorias | Backlog |

### Fatores de Priorização

| Fator | Peso | Perguntas |
|-------|------|-----------|
| Valor de Negócio | 40% | Impacto na receita? Demanda dos usuários? Alinhamento estratégico? |
| Impacto no Usuário | 30% | Quantos usuários? Com que frequência é usado? |
| Risco/Dependências | 15% | Risco técnico? Dependências externas? |
| Esforço | 15% | Tamanho? Complexidade? Incerteza? |

### Validação dos Critérios INVEST

Antes de adicionar ao sprint, valide cada story:

| Critério | Pergunta | Aprovado Se... |
|----------|----------|----------------|
| **I**ndependente | Pode ser desenvolvida sem outras stories não comprometidas? | Sem dependências bloqueantes |
| **N**egociável | A implementação é flexível? | Múltiplas abordagens possíveis |
| **V**aliosa | Entrega valor ao usuário ou ao negócio? | Benefício claro no "para que" |
| **E**stimável | A equipe consegue estimar? | Suficientemente compreendida para dimensionar |
| **S**mall (Pequena) | Pode ser concluída em um sprint? | ≤8 story points |
| **T**estável | Podemos verificar se está pronta? | Critérios de aceitação claros |

---

## Documentação de Referência

### Templates de User Story

`references/user-story-templates.md` contém:

- Formatos de story padrão por tipo (funcionalidade, melhoria, correção de bug, habilitador)
- Padrões de critérios de aceitação (Dado-Quando-Então, Should/Must/Can)
- Lista de verificação dos critérios INVEST
- Guia de estimativa de story points (escala Fibonacci)
- Antipadrões comuns de stories e correções
- Técnicas de divisão de stories

### Guia de Planejamento de Sprint

`references/sprint-planning-guide.md` contém:

- Agenda da reunião de planejamento do sprint
- Fórmulas de cálculo de capacidade
- Framework de priorização do backlog (WSJF)
- Guias das cerimônias do sprint (standup, review, retro)
- Rastreamento de velocidade e padrões de burndown
- Lista de verificação da Definição de Pronto
- Métricas e metas do sprint

---

## Ferramentas

### Gerador de User Stories

```bash
# Gerar stories a partir de um épico de exemplo
python scripts/user_story_generator.py

# Planejar sprint com capacidade
python scripts/user_story_generator.py sprint 30
```

Gera:
- User stories conformes ao INVEST
- Critérios de aceitação Dado-Quando-Então
- Estimativas de story points (escala Fibonacci)
- Atribuições de prioridade
- Carregamento do sprint com itens comprometidos e stretch

### Exemplo de Saída

```
USER STORY: USR-001
========================================
Title: View Key Metrics
Type: story
Priority: HIGH
Points: 5

Story:
As a End User, I want to view key metrics and KPIs
so that I can save time and work more efficiently

Acceptance Criteria:
  1. Given user has access, When they view key metrics, Then the result is displayed
  2. Should validate input before processing
  3. Must show clear error message when action fails
  4. Should complete within 2 seconds
  5. Must be accessible via keyboard navigation

INVEST Checklist:
  ✓ Independent
  ✓ Negotiable
  ✓ Valuable
  ✓ Estimable
  ✓ Small
  ✓ Testable
```

---

## Métricas do Sprint

Rastrear a saúde do sprint e o desempenho da equipe.

### Métricas Principais

| Métrica | Fórmula | Meta |
|---------|---------|------|
| Velocidade | Pontos concluídos / sprint | Estável ±10% |
| Confiabilidade de Comprometimento | Concluídos / Comprometidos | >85% |
| Variação de Escopo | Pontos adicionados ou removidos durante o sprint | <10% |
| Carryover | Pontos não concluídos | <15% |

### Rastreamento de Velocidade

```
Sprint 1: 25 pontos
Sprint 2: 28 pontos
Sprint 3: 30 pontos
Sprint 4: 32 pontos
Sprint 5: 29 pontos
------------------------
Velocidade Média: 28.8 pontos
Tendência: Estável

Planejamento: Comprometer 24-26 pontos
```

### Definição de Pronto

A story está completa quando:

- [ ] Código completo e revisado por par
- [ ] Testes unitários escritos e passando
- [ ] Critérios de aceitação verificados
- [ ] Documentação atualizada
- [ ] Implantado no ambiente de staging
- [ ] Aceito pelo Product Owner
- [ ] Sem bugs críticos restantes

## Skills Relacionadas

- **Scrum Master** (`project-management/scrum-master/`) — Dados de velocidade e cerimônias do sprint complementam o gerenciamento de backlog
- **Kit de Ferramentas para Gerente de Produto** (`product-team/product-manager-toolkit/`) — A priorização RICE alimenta a ordenação do backlog
