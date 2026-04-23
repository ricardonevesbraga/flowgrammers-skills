---
name: "jira-expert"
description: Especialista em Atlassian Jira para criação e gestão de projetos, planejamento, descoberta de produto, consultas JQL, fluxos de trabalho, campos personalizados, automação, relatórios e todos os recursos do Jira. Use para configuração de projeto Jira, configuração avançada de busca, criação de painéis, design de fluxo de trabalho e operações técnicas do Jira.
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Especialista em Atlassian Jira

Expertise de nível avançado em configuração do Jira, gestão de projetos, JQL, fluxos de trabalho, automação e relatórios. Lida com todos os aspectos técnicos e operacionais do Jira.

## Início Rápido — Operações Mais Comuns

**Criar um projeto**:
```
mcp jira create_project --name "Meu Projeto" --key "MEUPROJ" --type scrum --lead "usuario@exemplo.com"
```

**Executar uma consulta JQL**:
```
mcp jira search_issues --jql "project = MEUPROJ AND status != Done AND dueDate < now()" --maxResults 50
```

Para referência completa de comandos, veja [Integração Atlassian MCP](#integração-atlassian-mcp). Para funções JQL, veja [Referência de Funções JQL](#referência-de-funções-jql). Para templates de relatório, veja [Templates de Relatório](#templates-de-relatório).

---

## Fluxos de Trabalho

### Criação de Projeto
1. Determinar tipo de projeto (Scrum, Kanban, Bug Tracking, etc.)
2. Criar projeto com template apropriado
3. Configurar settings do projeto:
   - Nome, chave, descrição
   - Líder do projeto e responsável padrão
   - Esquema de notificação
   - Esquema de permissão
4. Definir tipos de issue e fluxos de trabalho
5. Configurar campos personalizados se necessário
6. Criar visualização inicial de board/backlog
7. **HANDOFF PARA**: Scrum Master para integração da equipe

### Design de Fluxo de Trabalho
1. Mapear estados do processo (A Fazer → Em Andamento → Concluído)
2. Definir transições e condições
3. Adicionar validadores, pós-funções e condições
4. Configurar esquema de fluxo de trabalho
5. **Validar**: Implantar em um projeto de teste primeiro; verificar todas as transições, condições e pós-funções se comportam como esperado antes de associar a projetos em produção
6. Associar fluxo de trabalho ao projeto
7. Testar fluxo de trabalho com issues de amostra

### Construção de Consulta JQL
**Estrutura Básica**: `campo operador valor`

**Operadores Comuns**:
- `=, !=` : igual, diferente
- `~, !~` : contém, não contém
- `>, <, >=, <=` : comparação
- `in, not in` : pertencimento a lista
- `is empty, is not empty`
- `was, was in, was not`
- `changed`

**Exemplos Poderosos de JQL**:

Encontrar issues atrasadas:
```jql
dueDate < now() AND status != Done
```

Issues de burndown do sprint:
```jql
sprint = 23 AND status changed TO "Done" DURING (startOfSprint(), endOfSprint())
```

Encontrar issues desatualizadas:
```jql
updated < -30d AND status != Done
```

Rastreamento de épico entre projetos:
```jql
"Epic Link" = PROJ-123 ORDER BY rank
```

Cálculo de velocidade:
```jql
sprint in closedSprints() AND resolution = Done
```

Capacidade da equipe:
```jql
assignee in (usuario1, usuario2) AND sprint in openSprints()
```

### Criação de Painel
1. Criar novo painel (pessoal ou compartilhado)
2. Adicionar gadgets relevantes:
   - Resultados de Filtro (baseado em JQL)
   - Burndown do Sprint
   - Gráfico de Velocidade
   - Criado vs Resolvido
   - Gráfico de Pizza (distribuição de status)
3. Organizar layout para legibilidade
4. Configurar atualização automática
5. Compartilhar com as equipes apropriadas
6. **HANDOFF PARA**: Senior PM ou Scrum Master para uso

### Regras de Automação
1. Definir gatilho (issue criada, campo alterado, agendado)
2. Adicionar condições (se aplicável)
3. Definir ações:
   - Atualizar campo
   - Enviar notificação
   - Criar subtarefa
   - Transicionar issue
   - Publicar comentário
4. Testar automação com dados de amostra
5. Habilitar e monitorar

## Funcionalidades Avançadas

### Campos Personalizados
**Quando Criar**:
- Rastrear dados não presentes nos campos padrão
- Capturar informações específicas do processo
- Habilitar relatórios avançados

**Tipos de Campo**: Texto, Numérico, Data, Seleção (único/múltiplo/cascata), Seletor de usuário

**Configuração**:
1. Criar campo personalizado
2. Configurar contexto do campo (quais projetos/tipos de issue)
3. Adicionar às telas apropriadas
4. Atualizar templates de busca se necessário

### Vinculação de Issues
**Tipos de Link**:
- Bloqueia / É bloqueado por
- Relaciona-se a
- Duplica / É duplicado por
- Clona / É clonado por
- Relacionamento Epic-Story

**Melhores Práticas**:
- Usar vinculação de Epic para agrupamento de funcionalidades
- Usar links de bloqueio para mostrar dependências
- Documentar razões de link nos comentários

### Permissões e Segurança

**Esquemas de Permissão**:
- Navegar em Projetos
- Criar/Editar/Excluir Issues
- Administrar Projetos
- Gerenciar Sprints

**Níveis de Segurança**:
- Definir visibilidade de issue confidencial
- Controlar acesso a dados sensíveis
- Auditar mudanças de segurança

### Operações em Massa
**Mudança em Massa**:
1. Usar JQL para encontrar issues alvo
2. Selecionar operação de mudança em massa
3. Escolher campos a atualizar
4. **Validar**: Pré-visualizar todas as mudanças antes de executar; confirmar que o filtro JQL corresponde apenas às issues pretendidas — edições em massa são difíceis de reverter
5. Executar e confirmar
6. Monitorar tarefa em background

**Transições em Massa**:
- Mover múltiplas issues pelo fluxo de trabalho
- Útil para limpeza de sprint
- Requer permissões apropriadas
- **Validar**: Executar o filtro JQL e revisar resultados em pequenos lotes antes de aplicar em escala

## Referência de Funções JQL

> **Dica**: Salvar consultas usadas frequentemente como filtros nomeados em vez de reexecutar JQL complexo ad hoc. Veja [Melhores Práticas](#melhores-práticas) para orientação de desempenho.

**Data**: `startOfDay()`, `endOfDay()`, `startOfWeek()`, `endOfWeek()`, `startOfMonth()`, `endOfMonth()`, `startOfYear()`, `endOfYear()`

**Sprint**: `openSprints()`, `closedSprints()`, `futureSprints()`

**Usuário**: `currentUser()`, `membersOf("grupo")`

**Avançado**: `issueHistory()`, `linkedIssues()`, `issuesWithFixVersions()`

## Templates de Relatório

> **Dica**: Esses trechos JQL podem ser salvos como filtros compartilhados ou conectados diretamente a gadgets de painel (veja [Criação de Painel](#criação-de-painel)).

| Relatório | JQL |
|---|---|
| Relatório de Sprint | `project = PROJ AND sprint = 23` |
| Velocidade da Equipe | `assignee in (equipe) AND sprint in closedSprints() AND resolution = Done` |
| Tendência de Bugs | `type = Bug AND created >= -30d` |
| Análise de Bloqueadores | `priority = Blocker AND status != Done` |

## Framework de Decisão

**Quando Escalar para Atlassian Admin**:
- Precisar de novo esquema de permissão de projeto
- Exigir esquema de fluxo de trabalho personalizado em toda a organização
- Provisionamento ou desprovisionamento de usuários
- Perguntas de licença ou cobrança
- Mudanças de configuração em todo o sistema

**Quando Colaborar com Scrum Master**:
- Configuração de board de sprint
- Visualizações de priorização de backlog
- Filtros específicos da equipe
- Necessidades de relatório de sprint

**Quando Colaborar com Senior PM**:
- Relatórios em nível de portfólio
- Painéis entre projetos
- Necessidades de visibilidade executiva
- Dependências entre múltiplos projetos

## Protocolos de Handoff

**DO Senior PM**:
- Requisitos de estrutura de projeto
- Necessidades de fluxo de trabalho e campos
- Requisitos de relatório
- Necessidades de integração

**PARA Senior PM**:
- Métricas entre projetos
- Tendências e padrões de issues
- Gargalos de fluxo de trabalho
- Insights de qualidade de dados

**DO Scrum Master**:
- Solicitações de configuração de board de sprint
- Necessidades de otimização de fluxo de trabalho
- Requisitos de filtragem de backlog
- Configuração de rastreamento de velocidade

**PARA Scrum Master**:
- Boards de sprint configurados
- Relatórios de velocidade
- Gráficos de burndown
- Visualizações de capacidade da equipe

## Melhores Práticas

**Qualidade dos Dados**:
- Aplicar campos obrigatórios com regras de validação de campo
- Usar convenções de nomenclatura de chave de issue consistentes por tipo de projeto
- Agendar limpeza regular de issues obsoletas/órfãs

**Desempenho**:
- Evitar curingas iniciais em JQL (`~` em campos de texto grande é custoso)
- Usar filtros salvos em vez de reexecutar JQL complexo ad hoc
- Limitar gadgets de painel para reduzir tempo de carregamento da página
- Arquivar projetos concluídos em vez de excluir para preservar histórico

**Governança**:
- Documentar a justificativa para estados e transições de fluxo de trabalho personalizados
- Versionar esquemas de permissão/fluxo de trabalho antes de fazer mudanças
- Exigir revisão de gestão de mudanças para atualizações de esquemas em toda a organização
- Executar auditorias de permissão após mudanças de função de usuário

## Integração Atlassian MCP

**Ferramenta Principal**: Jira MCP Server

**Operações Principais com Comandos de Exemplo**:

Criar um projeto:
```
mcp jira create_project --name "Meu Projeto" --key "MEUPROJ" --type scrum --lead "usuario@exemplo.com"
```

Executar uma consulta JQL:
```
mcp jira search_issues --jql "project = MEUPROJ AND status != Done AND dueDate < now()" --maxResults 50
```

Atualizar um campo de issue:
```
mcp jira update_issue --issue "MEUPROJ-42" --field "status" --value "In Progress"
```

Criar um sprint:
```
mcp jira create_sprint --board 10 --name "Sprint 5" --startDate "2024-06-01" --endDate "2024-06-14"
```

Criar um filtro de board:
```
mcp jira create_filter --name "Bloqueadores Abertos" --jql "priority = Blocker AND status != Done" --shareWith "project-team"
```

**Pontos de Integração**:
- Extrair métricas para relatórios do Senior PM
- Configurar boards de sprint para o Scrum Master
- Criar páginas de documentação para o Confluence Expert
- Suportar criação de templates para o Criador de Templates

## Skills Relacionadas

- **Confluence Expert** (`project-management/confluence-expert/`) — Documentação complementa os fluxos de trabalho do Jira
- **Atlassian Admin** (`project-management/atlassian-admin/`) — Gestão de permissões e usuários para projetos Jira
