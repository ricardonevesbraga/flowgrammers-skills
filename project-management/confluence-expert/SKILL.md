---
name: "confluence-expert"
description: Especialista em Atlassian Confluence para criação e gestão de espaços, bases de conhecimento e documentação. Configura permissões de espaço e hierarquias, cria templates de página com macros, estabelece taxonomias de documentação, projeta layouts de página e gerencia governança de conteúdo. Use quando usuários precisam construir ou reestruturar um espaço Confluence, projetar hierarquias de página com estruturas de permissão, criar ou padronizar templates de documentação, incorporar relatórios Jira em páginas, realizar auditorias de base de conhecimento ou estabelecer padrões de documentação e fluxos de trabalho colaborativos.
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Especialista em Atlassian Confluence

Expertise de nível avançado em gestão de espaços Confluence, arquitetura de documentação, criação de conteúdo, macros, templates e gestão colaborativa do conhecimento.

## Integração Atlassian MCP

**Ferramenta Principal**: Confluence MCP Server

**Operações Principais**:

```
// Criar um novo espaço
create_space({ key: "TEAM", name: "Engineering Team", description: "Base de conhecimento da equipe de engenharia" })

// Criar uma página sob uma página pai
create_page({ spaceKey: "TEAM", title: "Notas Sprint 42", parentId: "123456", body: "<p>Notas de reunião em HTML formato storage</p>" })

// Atualizar uma página existente (versão deve ser incrementada)
update_page({ pageId: "789012", version: 4, body: "<p>Conteúdo atualizado</p>" })

// Excluir uma página
delete_page({ pageId: "789012" })

// Buscar com CQL
search({ cql: 'space = "TEAM" AND label = "meeting-notes" ORDER BY lastModified DESC' })

// Recuperar páginas filhas para inspeção de hierarquia
get_children({ pageId: "123456" })

// Aplicar um label a uma página
add_label({ pageId: "789012", label: "archived" })
```

**Pontos de Integração**:
- Criar documentação para projetos do Senior PM
- Suportar o Scrum Master com templates de cerimônia
- Vincular a issues Jira para o Jira Expert
- Fornecer templates para o Criador de Templates

> **Veja também**: `MACROS.md` para referência de sintaxe de macros, `TEMPLATES.md` para biblioteca completa de templates, `PERMISSIONS.md` para detalhes de esquemas de permissão.

## Fluxos de Trabalho

### Criação de Espaço
1. Determinar tipo de espaço (Time, Projeto, Base de Conhecimento, Pessoal)
2. Criar espaço com nome e descrição claros
3. Definir página inicial do espaço com visão geral
4. Configurar permissões do espaço:
   - Visualizar, Editar, Criar, Excluir
   - Privilégios de Admin
5. Criar estrutura inicial de árvore de páginas
6. Adicionar atalhos do espaço para navegação
7. **Verificar**: Navegar até a URL do espaço e confirmar que a página inicial carrega; verificar que um usuário de teste não-admin vê o nível de permissão correto
8. **HANDOFF PARA**: Times para preenchimento de conteúdo

### Arquitetura de Páginas
**Melhores Práticas**:
- Usar hierarquia de páginas (relacionamentos pai-filho)
- Máximo 3 níveis de profundidade para navegação
- Convenções de nomenclatura consistentes
- Registros de reunião com data

**Estrutura Recomendada**:
```
Página Inicial do Espaço
├── Visão Geral & Primeiros Passos
├── Informações da Equipe
│   ├── Membros e Funções
│   ├── Canais de Comunicação
│   └── Acordos de Trabalho
├── Projetos
│   ├── Projeto A
│   │   ├── Visão Geral
│   │   ├── Requisitos
│   │   └── Notas de Reunião
│   └── Projeto B
├── Processos e Fluxos de Trabalho
├── Notas de Reunião (Arquivo)
└── Recursos e Referências
```

### Criação de Templates
1. Identificar padrão de conteúdo repetível
2. Criar página com estrutura e placeholders
3. Adicionar instruções nos placeholders
4. Formatar com macros apropriadas
5. Salvar como template
6. Compartilhar com o espaço ou tornar global
7. **Verificar**: Criar uma página de teste a partir do template e confirmar que todos os placeholders renderizam corretamente antes de compartilhar com a equipe
8. **USAR**: Referências para padrões avançados de template

### Estratégia de Documentação
1. **Avaliar** o estado atual da documentação
2. **Definir** metas de documentação e público-alvo
3. **Organizar** taxonomia e estrutura de conteúdo
4. **Criar** templates e diretrizes
5. **Migrar** documentação existente
6. **Treinar** equipes nas melhores práticas
7. **Monitorar** uso e adoção
8. **REPORTAR PARA**: Senior PM sobre saúde da documentação

### Gestão da Base de Conhecimento
**Tipos de Artigo**:
- Guias de como fazer
- Documentos de resolução de problemas
- FAQs
- Documentação de referência
- Documentação de processos

**Padrões de Qualidade**:
- Título e descrição claros
- Estruturado com cabeçalhos
- Data de atualização visível
- Responsável identificado
- Revisado trimestralmente

## Macros Essenciais

> Referência completa de macros com todos os parâmetros: veja `MACROS.md`.

### Macros de Conteúdo
**Info, Note, Warning, Tip**:
```
{info}
Informação importante aqui
{info}
```

**Expand**:
```
{expand:title=Clique para expandir}
Conteúdo oculto aqui
{expand}
```

**Sumário**:
```
{toc:maxLevel=3}
```

**Excerpt & Excerpt Include**:
```
{excerpt}
Conteúdo reutilizável
{excerpt}

{excerpt-include:Nome da Página}
```

### Conteúdo Dinâmico
**Issues Jira**:
```
{jira:JQL=project = PROJ AND status = "In Progress"}
```

**Gráfico Jira**:
```
{jirachart:type=pie|jql=project = PROJ|statType=statuses}
```

**Recém Atualizado**:
```
{recently-updated:spaces=@all|max=10}
```

**Conteúdo por Label**:
```
{contentbylabel:label=meeting-notes|maxResults=20}
```

### Macros de Colaboração
**Status**:
```
{status:colour=Green|title=Aprovado}
```

**Lista de Tarefas**:
```
{tasks}
- [ ] Tarefa 1
- [x] Tarefa 2 concluída
{tasks}
```

**Menção de Usuário**:
```
@nomeusuario
```

**Data**:
```
{date:format=dd MMM yyyy}
```

## Layouts e Formatação de Página

**Layout de Duas Colunas**:
```
{section}
{column:width=50%}
Conteúdo esquerdo
{column}
{column:width=50%}
Conteúdo direito
{column}
{section}
```

**Painel**:
```
{panel:title=Título do Painel|borderColor=#ccc}
Conteúdo do painel
{panel}
```

**Bloco de Código**:
```
{code:javascript}
const exemplo = "código aqui";
{code}
```

## Biblioteca de Templates

> Biblioteca completa de templates com markup completo: veja `TEMPLATES.md`. Principais templates resumidos abaixo.

| Template | Propósito | Seções Principais |
|----------|---------|--------------|
| **Notas de Reunião** | Reuniões de sprint/equipe | Pauta, Discussão, Decisões, Itens de Ação (macro tasks) |
| **Visão Geral do Projeto** | Kickoff e status do projeto | Painel de Fatos Rápidos, Objetivos, Tabela de Partes Interessadas, Marcos (macro Jira), Riscos |
| **Registro de Decisões** | Decisões arquiteturais/estratégicas | Contexto, Opções Consideradas, Decisão, Consequências, Próximos Passos |
| **Retrospectiva de Sprint** | Documentos de cerimônia ágil | O Que Foi Bem (info), O Que Não Foi (warning), Itens de Ação (tasks), Métricas |

## Permissões de Espaço

> Detalhes completos do esquema de permissões: veja `PERMISSIONS.md`.

### Esquemas de Permissão
**Espaço Público**:
- Todos os usuários: Visualizar
- Membros da equipe: Editar, Criar
- Admins do espaço: Admin

**Espaço de Time**:
- Membros da equipe: Visualizar, Editar, Criar
- Líderes da equipe: Admin
- Outros: Sem acesso

**Espaço de Projeto**:
- Partes interessadas: Visualizar
- Equipe do projeto: Editar, Criar
- PM: Admin

## Governança de Conteúdo

**Ciclos de Revisão**:
- Documentos críticos: Mensalmente
- Documentos padrão: Trimestralmente
- Documentos de arquivo: Anualmente

**Estratégia de Arquivamento**:
- Mover conteúdo desatualizado para espaço de Arquivo
- Rotular com "archived" e data
- Manter por 2 anos, depois excluir
- Manter trilha de auditoria

**Lista de Verificação de Qualidade do Conteúdo**:
- [ ] Título claro e descritivo
- [ ] Responsável/autor identificado
- [ ] Data de última atualização visível
- [ ] Labels apropriados aplicados
- [ ] Links funcionais
- [ ] Formatação consistente
- [ ] Nenhum dado sensível exposto

## Framework de Decisão

**Quando Escalar para Atlassian Admin**:
- Necessidade de template em toda a organização
- Exigir permissões entre espaços
- Configuração de blueprint
- Regras de automação global
- Exportação/importação de espaço

**Quando Colaborar com Jira Expert**:
- Incorporar consultas e gráficos Jira
- Vincular páginas a issues Jira
- Criar relatórios baseados em Jira
- Sincronizar documentação com tickets

**Quando Suportar o Scrum Master**:
- Templates de documentação de sprint
- Páginas de retrospectiva
- Acordos de trabalho da equipe
- Documentação de processos

**Quando Suportar o Senior PM**:
- Páginas de relatório executivo
- Documentação de portfólio
- Comunicação com partes interessadas
- Documentos de planejamento estratégico

## Protocolos de Handoff

**DO Senior PM**:
- Requisitos de documentação
- Necessidades de estrutura de espaço
- Requisitos de template
- Estratégia de gestão do conhecimento

**PARA Senior PM**:
- Relatórios de cobertura de documentação
- Análises de uso de conteúdo
- Lacunas de conhecimento identificadas
- Métricas de adoção de templates

**DO Scrum Master**:
- Templates de cerimônia de sprint
- Necessidades de documentação da equipe
- Estrutura de notas de reunião
- Formato de retrospectiva

**PARA Scrum Master**:
- Templates configurados
- Espaço para documentos da equipe
- Treinamento nas melhores práticas
- Diretrizes de documentação

**COM Jira Expert**:
- Vinculação Jira-Confluence
- Relatórios Jira incorporados
- Conexões issue-para-página
- Fluxo de trabalho entre ferramentas

## Melhores Práticas

**Organização**:
- Convenções de nomenclatura consistentes
- Labels significativos
- Hierarquia de páginas lógica
- Páginas relacionadas vinculadas
- Navegação clara

**Manutenção**:
- Auditorias regulares de conteúdo
- Remover duplicatas
- Atualizar informações desatualizadas
- Arquivar conteúdo obsoleto
- Monitorar análises de páginas

## Análises e Métricas

**Métricas de Uso**:
- Visualizações de página por espaço
- Páginas mais visitadas
- Consultas de busca
- Atividade de contribuidores
- Páginas órfãs

**Indicadores de Saúde**:
- Páginas sem atualizações recentes
- Páginas sem responsáveis
- Conteúdo duplicado
- Links quebrados
- Espaços vazios

## Skills Relacionadas

- **Jira Expert** (`project-management/jira-expert/`) — Macros e vinculação de issues Jira complementam documentos Confluence
- **Atlassian Templates** (`project-management/atlassian-templates/`) — Padrões de template para criação de conteúdo Confluence
