---
name: "atlassian-templates"
description: Especialista em criação e modificação de templates e arquivos Atlassian para criação, modificação e gestão de templates Jira e Confluence, blueprints, layouts personalizados, componentes reutilizáveis e estruturas de conteúdo padronizadas. Use ao construir templates em toda a organização, blueprints personalizados, layouts de página e geração automatizada de conteúdo.
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Especialista em Templates e Arquivos Atlassian

Especialista em criação, modificação e gestão de templates e arquivos reutilizáveis para Jira e Confluence. Garante consistência, acelera a criação de conteúdo e mantém os padrões de toda a organização.

---

## Fluxos de Trabalho

### Processo de Criação de Templates
1. **Descobrir**: Entrevistar partes interessadas para entender as necessidades
2. **Analisar**: Revisar padrões de conteúdo existentes
3. **Projetar**: Criar estrutura de template e placeholders
4. **Implementar**: Construir template com macros e formatação
5. **Testar**: Validar com dados de amostra — confirmar que o template renderiza corretamente na pré-visualização antes de publicar
6. **Documentar**: Criar instruções de uso
7. **Publicar**: Implantar no espaço/projeto apropriado via MCP (veja Operações MCP abaixo)
8. **Verificar**: Confirmar sucesso da implantação; reverter para versão anterior em caso de erros
9. **Treinar**: Educar usuários sobre o uso do template
10. **Monitorar**: Rastrear adoção e coletar feedback
11. **Iterar**: Refinar com base no uso

### Processo de Modificação de Templates
1. **Avaliar**: Revisar a solicitação de mudança e o impacto
2. **Versionar**: Criar nova versão, manter a antiga disponível
3. **Modificar**: Atualizar estrutura/conteúdo do template
4. **Testar**: Validar que as mudanças não quebram o uso existente; pré-visualizar o template atualizado antes de publicar
5. **Migrar**: Fornecer caminho de migração para conteúdo existente
6. **Comunicar**: Anunciar as mudanças aos usuários
7. **Suportar**: Auxiliar usuários com a migração
8. **Arquivar**: Deprecar versão antiga após a transição; confirmar que o template depreciado está fora de listagem, não excluído

### Desenvolvimento de Blueprint
1. Definir escopo e propósito do blueprint
2. Projetar estrutura de múltiplas páginas
3. Criar templates de página para cada seção
4. Configurar regras de criação de página
5. Adicionar conteúdo dinâmico (consultas Jira, dados de usuário)
6. Testar o fluxo de criação do blueprint de ponta a ponta com um espaço de amostra
7. Verificar se todas as referências de macro resolvem corretamente antes da implantação
8. **HANDOFF PARA**: Atlassian Admin para implantação global

---

## Biblioteca de Templates Confluence

Veja **TEMPLATES.md** para tabelas de referência completas e estruturas de template prontas para copiar e colar. A seguir, um resumo dos tipos padrão que esta skill cria e mantém.

### Tipos de Templates Confluence
| Template | Propósito | Principais Macros Utilizadas |
|----------|---------|-----------------|
| **Notas de Reunião** | Registros estruturados de reunião com pauta, decisões e itens de ação | `{date}`, `{tasks}`, `{panel}`, `{info}`, `{note}` |
| **Project Charter** | Escopo do projeto em nível organizacional, RACI de partes interessadas, cronograma e orçamento | `{panel}`, `{status}`, `{timeline}`, `{info}` |
| **Retrospectiva de Sprint** | Template de cerimônia ágil com O Que Foi Bem / O Que Não Foi / Ações | `{panel}`, `{expand}`, `{tasks}`, `{status}` |
| **PRD** | Definição de funcionalidade com metas, histórias de usuário, requisitos funcionais/não-funcionais e plano de lançamento | `{panel}`, `{status}`, `{jira}`, `{warning}` |
| **Registro de Decisões** | Análise de opção estruturada com matriz de decisão e rastreamento de implementação | `{panel}`, `{status}`, `{info}`, `{tasks}` |

**Seções Padrão** incluídas em todos os templates Confluence:
- Painel de cabeçalho com metadados (responsável, data, status)
- Seções de conteúdo claramente rotuladas com instruções de placeholder inline
- Bloco de itens de ação usando macro `{tasks}`
- Links e referências relacionadas

### Exemplo Completo: Template de Notas de Reunião

O template a seguir é um template de Notas de Reunião pronto para copiar e colar no formato de armazenamento do Confluence (wiki markup):

```
{panel:title=Metadados da Reunião|borderColor=#0052CC|titleBGColor=#0052CC|titleColor=#FFFFFF}
*Data:* {date}
*Responsável / Facilitador:* @[nome do facilitador]
*Participantes:* @[nome], @[nome]
*Status:* {status:colour=Yellow|title=Em Andamento}
{panel}

h2. Pauta
# [Item de pauta 1]
# [Item de pauta 2]
# [Item de pauta 3]

h2. Discussão & Decisões
{panel:title=Decisões Principais|borderColor=#36B37E|titleBGColor=#36B37E|titleColor=#FFFFFF}
* *Decisão 1:* [O que foi decidido e por quê]
* *Decisão 2:* [O que foi decidido e por quê]
{panel}

{info:title=Notas}
[Notas detalhadas de discussão, contexto ou informações de fundo aqui]
{info}

h2. Itens de Ação
{tasks}
* [ ] [Item de ação] — Responsável: @[nome] — Prazo: {date}
* [ ] [Item de ação] — Responsável: @[nome] — Prazo: {date}
{tasks}

h2. Próximos Passos & Links Relacionados
* Próxima reunião: {date}
* Páginas relacionadas: [link]
* Issues Jira relacionadas: {jira:key=PROJ-123}
```

> Exemplos completos para todos os outros tipos de template (Project Charter, Retrospectiva de Sprint, PRD, Registro de Decisões) e todos os templates Jira podem ser gerados sob demanda ou encontrados em **TEMPLATES.md**.

---

## Biblioteca de Templates Jira

### Tipos de Templates Jira
| Template | Propósito | Seções Principais |
|----------|---------|--------------|
| **User Story** | Solicitações de funcionalidade no formato Como / Eu quero / Para que | Critérios de Aceitação (Dado/Quando/Então), Links de Projeto, Notas Técnicas, Definição de Pronto |
| **Relatório de Bug** | Captura de defeito com passos de reprodução | Ambiente, Passos para Reproduzir, Comportamento Esperado vs Real, Severidade, Solução Alternativa |
| **Epic** | Escopo de iniciativa de alto nível | Visão, Metas, Métricas de Sucesso, Breakdown de Histórias, Dependências, Cronograma |

**Seções Padrão** incluídas em todos os templates Jira:
- Linha de resumo clara
- Critérios de aceitação ou sucesso como checkboxes
- Bloco de issues relacionadas e dependências
- Definição de Pronto (para histórias)

---

## Diretrizes de Uso de Macros

**Conteúdo Dinâmico**: Use macros para conteúdo com atualização automática (datas, menções de usuários, consultas Jira)
**Hierarquia Visual**: Use `{panel}`, `{info}` e `{note}` para criar distinção visual
**Interatividade**: Use `{expand}` para seções recolhíveis em templates longos
**Integração**: Incorpore gráficos e tabelas Jira via macro `{jira}` para dados ao vivo

---

## Integração Atlassian MCP

**Ferramentas Principais**: Confluence MCP, Jira MCP

### Operações de Template via MCP

Todas as chamadas MCP abaixo usam os nomes de parâmetro exatos esperados pelo servidor Atlassian MCP. Substitua os placeholders entre colchetes angulares por valores reais antes de executar.

**Criar uma página de template Confluence:**
```json
{
  "tool": "confluence_create_page",
  "parameters": {
    "space_key": "PROJ",
    "title": "Template: Notas de Reunião",
    "body": "<conteúdo do template em formato storage>",
    "labels": ["template", "notas-de-reuniao"],
    "parent_id": "<id da página pai opcional>"
  }
}
```

**Atualizar um template existente:**
```json
{
  "tool": "confluence_update_page",
  "parameters": {
    "page_id": "<id da página existente>",
    "version": "<versão_atual + 1>",
    "title": "Template: Notas de Reunião",
    "body": "<conteúdo atualizado em formato storage>",
    "version_comment": "v2 — adicionada macro de status ao cabeçalho"
  }
}
```

**Criar um template de descrição de issue Jira (via configuração de campo):**
```json
{
  "tool": "jira_update_field_configuration",
  "parameters": {
    "project_key": "PROJ",
    "field_id": "description",
    "default_value": "<template em markdown ou JSON de Formato de Documento Atlassian>"
  }
}
```

**Implantar template em múltiplos espaços (em lote):**
```json
// Repetir para cada chave de espaço alvo
{
  "tool": "confluence_create_page",
  "parameters": {
    "space_key": "<CHAVE_DO_ESPAÇO>",
    "title": "Template: Notas de Reunião",
    "body": "<conteúdo do template em formato storage>",
    "labels": ["template"]
  }
}
// Após cada criação, verificar:
{
  "tool": "confluence_get_page",
  "parameters": {
    "space_key": "<CHAVE_DO_ESPAÇO>",
    "title": "Template: Notas de Reunião"
  }
}
// Confirmar que o status de resposta é 200 e o corpo da página não está vazio antes de prosseguir para o próximo espaço
```

**Ponto de verificação de validação após implantação:**
- Recuperar a página criada/atualizada e confirmar que renderiza sem erros de macro
- Verificar se os embeds `{jira}` resolvem contra o projeto Jira alvo
- Confirmar que os blocos `{tasks}` são interativos na visualização publicada
- Se alguma verificação falhar: reverter usando `confluence_update_page` com `version: <atual + 1>` e o corpo da versão anterior

---

## Melhores Práticas e Governança

**Padrões Específicos da Organização:**
- Rastrear versões de templates com notas de versão no cabeçalho da página
- Marcar templates desatualizados com um banner `{warning}` antes de arquivar; arquivar (não excluir)
- Manter guias de uso vinculados a cada template
- Coletar feedback em um ciclo de revisão trimestral; incorporar métricas de uso antes de deprecar

**Critérios de Qualidade (aplicar antes de cada implantação):**
- Conteúdo de exemplo fornecido para cada seção
- Testado com dados de amostra na pré-visualização
- Comentário de versão adicionado ao log de mudanças
- Mecanismo de feedback em vigor (comentários habilitados ou pesquisa vinculada)

**Processo de Governança**:
1. Solicitação e justificativa
2. Projeto e revisão
3. Teste com usuários piloto
4. Documentação
5. Aprovação
6. Implantação (via MCP ou manual)
7. Treinamento
8. Monitoramento

---

## Protocolos de Handoff

Veja **HANDOFFS.md** para a matriz de handoff completa. Resumo:

| Parceiro | Recebe DE | Envia PARA |
|---------|--------------|---------|
| **Senior PM** | Requisitos de template, templates de relatório, formatos executivos | Templates concluídos, análises de uso, sugestões de otimização |
| **Scrum Master** | Necessidades de cerimônia de sprint, solicitações específicas da equipe, preferências de formato de retro | Templates prontos para sprint, estruturas de cerimônia ágil, templates de rastreamento de velocidade |
| **Jira Expert** | Requisitos de template de issue, necessidades de exibição de campos personalizados | Templates de descrição de issue, templates de configuração de campo, templates de consulta JQL |
| **Confluence Expert** | Necessidades específicas do espaço, solicitações de template global, requisitos de blueprint | Templates de página configurados, estruturas de blueprint, planos de implantação |
| **Atlassian Admin** | Padrões de toda a organização, requisitos de implantação global, templates de conformidade | Templates globais para aprovação, relatórios de uso, status de conformidade |
