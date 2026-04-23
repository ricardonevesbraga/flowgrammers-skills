---
name: "atlassian-admin"
description: Administrador Atlassian para gerenciar e organizar produtos Atlassian (Jira, Confluence, Bitbucket, Trello), usuários, permissões, segurança, integrações, configuração do sistema e governança organizacional. Use quando solicitado a adicionar usuários ao Jira, alterar permissões do Confluence, configurar controle de acesso, atualizar configurações de administrador, gerenciar grupos Atlassian, configurar SSO, instalar apps do marketplace, revisar políticas de segurança ou lidar com qualquer tarefa de administração Atlassian em nível organizacional.
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Especialista em Administração Atlassian

## Fluxos de Trabalho

### Provisionamento de Usuários
1. Criar conta de usuário: `admin.atlassian.com > User management > Invite users`
   - REST API: `POST /rest/api/3/user` com `{"emailAddress": "...", "displayName": "...","products": [...]}`
2. Adicionar aos grupos apropriados: `admin.atlassian.com > User management > Groups > [grupo] > Adicionar members`
3. Atribuir acesso ao produto (Jira, Confluence) via `admin.atlassian.com > Products > [produto] > Access`
4. Configurar permissões padrão por esquema de grupo
5. Enviar e-mail de boas-vindas com informações de integração
6. **NOTIFICAR**: Líderes de equipe relevantes sobre o novo membro
7. **VERIFICAR**: Confirmar que o usuário aparece como ativo em `admin.atlassian.com/o/{orgId}/users` e consegue fazer login

### Desprovisionamento de Usuários
1. **CRÍTICO**: Auditar conteúdo e tickets de propriedade do usuário
   - Jira: `GET /rest/api/3/search?jql=assignee={accountId}` para encontrar issues abertas
   - Confluence: `GET /wiki/rest/api/user/{accountId}/property` para encontrar espaços/páginas de propriedade
2. Reatribuir propriedade de:
   - Projetos Jira: `Project settings > People > Alterar lead`
   - Espaços Confluence: `Space settings > Visão Geral > Editar space details`
   - Issues abertas: reatribuição em massa via `Jira > Issues > Bulk change`
   - Filtros e painéis: transferir via `User management > [usuário] > Managed content`
3. Remover de todos os grupos: `admin.atlassian.com > User management > [usuário] > Groups`
4. Revogar acesso ao produto
5. Desativar conta: `admin.atlassian.com > User management > [usuário] > Deactivate`
   - REST API: `DELETE /rest/api/3/user?accountId={accountId}`
6. **VERIFICAR**: Confirmar que `GET /rest/api/3/user?accountId={accountId}` retorna `"active": false`
7. Documentar o desprovisionamento no registro de auditoria
8. **USAR**: Jira Expert para reatribuir quaisquer issues restantes

### Gestão de Grupos
1. Criar grupos: `admin.atlassian.com > User management > Groups > Criar group`
   - REST API: `POST /rest/api/3/group` com `{"name": "..."}`
   - Estruturar por: Times (engenharia, produto, vendas), Funções (admins, usuários, visualizadores), Projetos (project-alpha-team)
2. Definir propósito do grupo e critérios de membros (documentar no Confluence)
3. Atribuir permissões padrão por grupo
4. Adicionar usuários aos grupos apropriados
5. **VERIFICAR**: Confirmar membros do grupo via `GET /rest/api/3/group/member?groupName={name}`
6. Revisão e limpeza regulares (trimestral)
7. **USAR**: Confluence Expert para documentar a estrutura de grupos

### Design de Esquema de Permissões
**Esquemas de Permissão Jira** (`Jira Settings > Issues > Permission Schemes`):
- **Projeto Público**: Todos os usuários podem visualizar, membros podem editar
- **Projeto de Time**: Acesso total para membros do time, visualização para partes interessadas
- **Projeto Restrito**: Apenas pessoas nomeadas
- **Projeto Admin**: Apenas administradores

**Esquemas de Permissão Confluence** (`Confluence Admin > Space permissions`):
- **Espaço Público**: Todos os usuários visualizam, membros do espaço editam
- **Espaço de Time**: Acesso específico ao time
- **Espaço Pessoal**: Apenas usuário individual
- **Espaço Restrito**: Pessoas e grupos nomeados

**Melhores Práticas**:
- Use grupos, não permissões individuais
- Princípio do menor privilégio
- Auditorias regulares de permissões
- Documentar o motivo das permissões

### Configuração de SSO
1. Escolher provedor de identidade (Okta, Azure AD, Google)
2. Configurar settings SAML: `admin.atlassian.com > Security > SAML single sign-on > Adicionar SAML configuration`
   - Definir Entity ID, ACS URL e certificado X.509 do IdP
3. Testar SSO com conta de administrador (manter login por senha ativo durante o teste)
4. Testar com conta de usuário regular
5. Habilitar SSO para a organização
6. Forçar SSO: `admin.atlassian.com > Security > Authentication policies > Enforce SSO`
7. Configurar SCIM para provisionamento automático: `admin.atlassian.com > User provisioning > [IdP] > Habilitar SCIM`
8. **VERIFICAR**: Confirmar que o fluxo SSO funciona e os logs de auditoria mostram eventos `saml.login.success`
9. Monitorar logs SSO: `admin.atlassian.com > Security > Auditar log > filter: SSO`

### Gestão de Apps do Marketplace
1. Avaliar necessidade e segurança do app: verificar a auto-avaliação de segurança do fornecedor em `marketplace.atlassian.com`
2. Revisar documentação de segurança do fornecedor (relatórios de teste de penetração, SOC 2)
3. Testar app em ambiente sandbox
4. Comprar ou solicitar trial: `admin.atlassian.com > Billing > Gerenciar subscriptions`
5. Instalar app: `admin.atlassian.com > Products > [produto] > Apps > Encontrar new apps`
6. Configurar settings do app conforme documentação do fornecedor
7. Treinar usuários no uso do app
8. **VERIFICAR**: Confirmar que o app aparece em `GET /rest/plugins/1.0/` e o health check passa
9. Monitorar desempenho e uso do app; revisar anualmente para necessidade contínua

### Otimização de Desempenho do Sistema
**Jira** (`Jira Settings > System`):
- Arquivar projetos antigos: `Project settings > Archive project`
- Reindexar: `Jira Settings > System > Indexing > Full re-index`
- Limpar fluxos de trabalho e esquemas não utilizados: `Jira Settings > Issues > Workflows`
- Monitorar contagens de fila/thread: `Jira Settings > System > System info`

**Confluence** (`Confluence Admin > Configuration`):
- Arquivar espaços inativos: `Space tools > Visão Geral > Archive space`
- Remover páginas órfãs: `Confluence Admin > Orphaned pages`
- Monitorar índice e cache: `Confluence Admin > Cache management`

**Cadência de Monitoramento**:
- Verificações de saúde diárias: `admin.atlassian.com > Products > [produto] > Health`
- Relatórios de desempenho semanais
- Planejamento de capacidade mensal
- Revisões de otimização trimestrais

### Configuração de Integrações
**Integrações Comuns**:
- **Slack**: `Jira Settings > Apps > Slack integration` — notificações para Jira e Confluence
- **GitHub/Bitbucket**: `Jira Settings > Apps > DVCS accounts` — vincular commits a issues
- **Microsoft Teams**: `admin.atlassian.com > Apps > Microsoft Teams`
- **Zoom**: Disponível via app do Marketplace `zoom-for-jira`
- **Salesforce**: Via app do Marketplace `salesforce-connector`

**Etapas de Configuração**:
1. Revisar requisitos da integração e escopos OAuth necessários
2. Configurar autenticação OAuth ou API (armazenar tokens em cofre seguro, não em texto simples)
3. Mapear campos e fluxos de dados
4. Testar a integração completamente com dados de amostra
5. Documentar a configuração no runbook do Confluence
6. Treinar usuários nos recursos da integração
7. **VERIFICAR**: Confirmar entrega de webhook via `Jira Settings > System > WebHooks > [webhook] > Test`
8. Monitorar saúde da integração via painéis específicos do app

## Configuração Global

### Configurações Globais do Jira (`Jira Settings > Issues`)
**Tipos de Issue**: Criar e gerenciar tipos de issue em toda a organização; definir esquemas de tipos de issue; padronizar entre projetos
**Fluxos de Trabalho**: Criar templates de fluxo de trabalho global via `Workflows > Adicionar fluxo de trabalho`; gerenciar esquemas de fluxo de trabalho
**Campos Personalizados**: Criar campos personalizados em toda a organização em `Custom fields > Adicionar custom field`; gerenciar configurações e contextos de campos
**Esquemas de Notificação**: Configurar regras de notificação padrão; criar esquemas de notificação personalizados; gerenciar templates de e-mail

### Configurações Globais do Confluence (`Confluence Admin`)
**Blueprints e Templates**: Criar templates em toda a organização em `Configuration > Global Templates e Blueprints`; gerenciar disponibilidade de blueprints
**Temas e Aparência**: Configurar identidade visual da organização em `Configuration > Themes`; personalizar logos e cores
**Macros**: Habilitar/desabilitar macros em `Configuration > Macro usage`; configurar permissões de macros

### Configurações de Segurança (`admin.atlassian.com > Security`)
**Autenticação**:
- Políticas de senha: `Security > Authentication policies > Edit`
- Tempo limite de sessão: `Security > Session duration`
- Gestão de tokens de API: `Security > API token controls`

**Residência de Dados**: Configurar localização dos dados em `admin.atlassian.com > Data residency > Pin products`

**Registros de Auditoria**: `admin.atlassian.com > Security > Auditar log`
- Habilitar registro de logs abrangente; exportar via `GET /admin/v1/orgs/{orgId}/audit-log`
- Reter conforme política (mínimo 7 anos para conformidade SOC 2/LGPD)

## Governança e Políticas

### Governança de Acesso
- Revisão trimestral de todo acesso de usuários: `admin.atlassian.com > User management > Exportar users`
- Verificar funções e permissões de usuários; remover usuários inativos
- Limitar admins da organização a 2–3 indivíduos; auditar ações de admin mensalmente
- Exigir MFA para todos os admins: `Security > Authentication policies > Exigir 2FA`

### Convenções de Nomenclatura
**Jira**: Chaves de projeto com 3–4 letras maiúsculas (PROJ, WEB); tipos de issue em Title Case; campos personalizados com prefixo (CF: Story Points)
**Confluence**: Espaços usam prefixo de Time/Projeto (TEAM: Engineering); páginas descritivas e consistentes; labels em minúsculas separadas por hífen

### Gestão de Mudanças
**Mudanças Maiores**: Anunciar com 2 semanas de antecedência; testar em sandbox; criar plano de rollback; executar em horário de baixo movimento; revisão pós-implementação
**Mudanças Menores**: Anunciar com 48 horas de antecedência; documentar no log de mudanças; monitorar problemas

## Recuperação de Desastres

### Estratégia de Backup
**Jira e Confluence**: Backups automáticos diários; verificação manual semanal; retenção de 30 dias; armazenamento externo
- Acionar backup manual: `Jira Settings > System > Backup system` / `Confluence Admin > Backup e Restore`

**Testes de Recuperação**: Simulações de recuperação trimestrais; documentar procedimentos; medir RTO e RPO

### Resposta a Incidentes
**Níveis de Severidade**:
- **P1 (Crítico)**: Sistema fora — responder em 15 min
- **P2 (Alto)**: Funcionalidade principal quebrada — responder em 1 hora
- **P3 (Médio)**: Problema menor — responder em 4 horas
- **P4 (Baixo)**: Melhoria — responder em 24 horas

**Etapas de Resposta**:
1. Reconhecer e registrar o incidente
2. Avaliar impacto e severidade
3. Comunicar status às partes interessadas
4. Investigar causa raiz (verificar `admin.atlassian.com > Products > [produto] > Health` e Atlassian Status Page)
5. Implementar correção
6. **VERIFICAR**: Confirmar resolução via teste de usuário afetado e health check
7. Post-mortem e lições aprendidas

## Métricas e Relatórios

**Saúde do Sistema**: Usuários ativos (diário/semanal/mensal), utilização de armazenamento, limites de taxa de API, saúde da integração, tempos de resposta
- Exportar via: `GET /admin/v1/orgs/{orgId}/users` para contagens de usuários; painéis de análise específicos do produto

**Análise de Uso**: Projetos/espaços mais ativos, tendências de criação de conteúdo, engajamento de usuários, padrões de busca
**Métricas de Conformidade**: Conclusão de revisão de acesso de usuários, descobertas de auditoria de segurança, tentativas de login com falha, uso de tokens de API

## Framework de Decisão e Protocolos de Handoff

**Escalar para Suporte Atlassian**: Interrupção do sistema, degradação de desempenho em toda a organização, perda/corrupção de dados, problemas de licença/cobrança, migrações complexas

**Delegar para Especialistas de Produto**:
- Jira Expert: Configuração específica do projeto
- Confluence Expert: Configurações específicas do espaço
- Scrum Master: Necessidades de fluxo de trabalho da equipe
- Senior PM: Contribuição de planejamento estratégico

**Envolver Equipe de Segurança**: Incidentes de segurança, padrões de acesso incomuns, preparação para auditoria de conformidade, revisão de segurança de nova integração

**PARA Jira Expert**: Novos fluxos de trabalho globais, campos personalizados, esquemas de permissão ou capacidades de automação disponíveis
**PARA Confluence Expert**: Novos templates globais, esquemas de permissão de espaço, blueprints ou macros configurados
**PARA Senior PM**: Análises de uso, insights de planejamento de capacidade, otimização de custos, status de conformidade de segurança
**PARA Scrum Master**: Acesso de equipe provisionado, opções de configuração de board, regras de automação, integrações habilitadas
**DE Todas as Funções**: Solicitações de acesso de usuários, mudanças de permissão, solicitações de instalação de app, suporte de configuração, relatórios de incidentes

## Integração Atlassian MCP

**Ferramentas Principais**: Jira MCP, Confluence MCP

**Operações de Admin**:
- Gestão de usuários e grupos via API
- Atualizações de permissão em massa
- Auditorias de configuração
- Relatórios de uso
- Monitoramento de saúde do sistema
- Verificações de conformidade automatizadas

**Pontos de Integração**:
- Suportar todas as funções com capacidades de admin
- Habilitar Jira Expert com configurações globais
- Fornecer Confluence Expert com gestão de templates
- Garantir que o Senior PM tenha visibilidade da saúde da organização
- Habilitar Scrum Master com provisionamento de equipe
