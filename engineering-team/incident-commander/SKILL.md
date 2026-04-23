---
name: "incident-commander"
description: "Skill de Comandante de Incidentes para gerenciar resposta a incidentes tecnológicos, desde a detecção até a resolução e revisão pós-incidente. Cobre classificação de severidade, reconstrução de linha do tempo e geração de PIR."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Skill Incident Commander

**Categoria:** Engineering Team  
**Tier:** POWERFUL  
**Versão:** 1.0.0  
**Última Atualização:** Fevereiro de 2026

## Visão Geral

A skill Incident Commander fornece um framework abrangente de resposta a incidentes para gerenciar incidentes tecnológicos desde a detecção até a resolução e revisão pós-incidente. Esta skill implementa práticas testadas em batalha de equipes SRE e DevOps em escala, fornecendo ferramentas estruturadas para classificação de severidade, reconstrução de linha do tempo e análise pós-incidente completa.

## Funcionalidades Principais

- **Classificação Automatizada de Severidade** - Triagem inteligente de incidentes com base em métricas de impacto e urgência
- **Reconstrução de Linha do Tempo** - Transformar logs e eventos dispersos em narrativas coerentes de incidentes
- **Geração de Revisão Pós-Incidente** - PIRs estruturados com múltiplos frameworks de RCA
- **Templates de Comunicação** - Templates pré-construídos para atualizações de partes interessadas e escalações
- **Integração de Runbook** - Gerar runbooks acionáveis a partir de padrões de incidentes

## Skills Incluídas

### Ferramentas Principais

1. **Classificador de Incidentes** (`incident_classifier.py`)
   - Analisa descrições de incidentes e produz níveis de severidade
   - Recomenda equipes de resposta e ações iniciais
   - Gera templates de comunicação com base na severidade

2. **Reconstrutor de Linha do Tempo** (`timeline_reconstructor.py`)
   - Processa eventos com timestamp de múltiplas fontes
   - Reconstrói a linha do tempo cronológica do incidente
   - Identifica lacunas e fornece análise de duração

3. **Gerador de PIR** (`pir_generator.py`)
   - Cria documentos abrangentes de Revisão Pós-Incidente
   - Aplica múltiplos frameworks de RCA (5 Porquês, Espinha de Peixe, Linha do Tempo)
   - Gera itens de acompanhamento acionáveis

## Framework de Resposta a Incidentes

### Sistema de Classificação de Severidade

#### SEV1 - Interrupção Crítica
**Definição:** Falha completa de serviço afetando todos os usuários ou funções críticas de negócios

**Características:**
- Serviços voltados ao cliente completamente indisponíveis
- Perda ou corrupção de dados afetando usuários
- Violações de segurança com exposição de dados do cliente
- Sistemas geradores de receita inoperantes
- Violações de SLA com penalidades financeiras

**Requisitos de Resposta:**
- Escalação imediata para engenheiro de plantão
- Incident Commander designado em 5 minutos
- Notificação executiva em 15 minutos
- Atualização da página de status público em 15 minutos
- War room estabelecido
- Todos os recursos disponíveis se necessário

**Frequência de Comunicação:** A cada 15 minutos até a resolução

#### SEV2 - Impacto Maior
**Definição:** Degradação significativa afetando subconjunto de usuários ou funções não críticas

**Características:**
- Degradação parcial do serviço (>25% dos usuários afetados)
- Problemas de desempenho causando frustração do usuário
- Funcionalidades não críticas indisponíveis
- Ferramentas internas impactando produtividade
- Inconsistências de dados não afetando a experiência do usuário

**Requisitos de Resposta:**
- Resposta do engenheiro de plantão em 15 minutos
- Incident Commander designado em 30 minutos
- Atualização da página de status em 30 minutos
- Notificação de partes interessadas em 1 hora
- Atualizações regulares da equipe

**Frequência de Comunicação:** A cada 30 minutos durante a resposta ativa

#### SEV3 - Impacto Menor
**Definição:** Impacto limitado com soluções alternativas disponíveis

**Características:**
- Única funcionalidade ou componente afetado
- <25% dos usuários impactados
- Soluções alternativas disponíveis
- Degradação de desempenho sem impacto significativo na UX
- Alertas de monitoramento não urgentes

**Requisitos de Resposta:**
- Resposta em 2 horas durante horário comercial
- Resposta no próximo dia útil aceitável fora do horário
- Notificação interna da equipe
- Atualização opcional da página de status

**Frequência de Comunicação:** Apenas em marcos principais

#### SEV4 - Baixo Impacto
**Definição:** Impacto mínimo, problemas cosméticos ou manutenção planejada

**Características:**
- Bugs cosméticos
- Problemas de documentação
- Lacunas de logging ou monitoramento
- Problemas de desempenho sem impacto no usuário
- Problemas em ambiente de desenvolvimento/teste

**Requisitos de Resposta:**
- Resposta em 1-2 dias úteis
- Rastreamento padrão de ticket/issue
- Sem escalação especial necessária

**Frequência de Comunicação:** Atualizações padrão do ciclo de desenvolvimento

### Papel do Incident Commander

#### Responsabilidades Principais

1. **Comando e Controle**
   - Assumir propriedade do processo de resposta ao incidente
   - Tomar decisões críticas sobre alocação de recursos
   - Coordenar entre equipes técnicas e partes interessadas
   - Manter consciência situacional em todos os fluxos de resposta

2. **Hub de Comunicação**
   - Fornecer atualizações regulares às partes interessadas
   - Gerenciar comunicações externas (páginas de status, notificações a clientes)
   - Facilitar comunicação eficaz entre equipes de resposta
   - Proteger respondentes de distrações externas

3. **Gerenciamento de Processo**
   - Garantir rastreamento e documentação adequados do incidente
   - Conduzir em direção à resolução mantendo a qualidade
   - Coordenar handoffs entre membros da equipe
   - Planejar e executar estratégias de rollback se necessário

4. **Liderança Pós-Incidente**
   - Garantir que revisões pós-incidente completas sejam realizadas
   - Conduzir implementação de medidas preventivas
   - Compartilhar aprendizados com a organização mais ampla

#### Framework de Tomada de Decisão

**Decisões de Emergência (SEV1/2):**
- Incident Commander tem autoridade total
- Preferência por ação sobre análise
- Documentar as decisões para revisão posterior
- Consultar especialistas no assunto, mas não ficar bloqueado

**Alocação de Recursos:**
- Pode recrutar qualquer membro de equipe necessário
- Autoridade para escalar para liderança sênior
- Pode aprovar gastos de emergência para recursos externos
- Decide sobre canais de comunicação e timing

**Decisões Técnicas:**
- Apoiar-se em líderes técnicos para detalhes de implementação
- Fazer chamadas finais sobre trade-offs entre velocidade e risco
- Aprovar estratégias de rollback vs. corrigir à frente
- Coordenar abordagens de teste e validação

### Templates de Comunicação

#### Notificação Inicial de Incidente (SEV1/2)

```
Subject: [SEV{severity}] {Service Name} - {Brief Description}

Detalhes do Incidente:
- Hora de Início: {timestamp}
- Severidade: SEV{level}
- Impacto: {descrição do impacto no usuário}
- Status Atual: {investigando/mitigando/resolvido}

Detalhes Técnicos:
- Serviços Afetados: {lista de serviços}
- Sintomas: {o que os usuários estão experimentando}
- Avaliação Inicial: {causa raiz suspeita, se conhecida}

Equipe de Resposta:
- Incident Commander: {nome}
- Líder Técnico: {nome}
- SMEs Engajados: {lista}

Próxima Atualização: {timestamp}
Página de Status: {link}
War Room: {link de bridge/chat}

---
{Nome do Incident Commander}
{Informações de Contato}
```

#### Resumo Executivo (SEV1)

```
Subject: URGENTE - Interrupção Impactando Clientes - {Service Name}

Resumo Executivo:
{2-3 frases descrevendo o impacto nos clientes e implicações de negócios}

Métricas Principais:
- Tempo até Detecção: {X minutos}
- Tempo até Engajamento: {X minutos} 
- Impacto Estimado nos Clientes: {número/percentagem}
- Status Atual: {status}
- Estimativa de Resolução: {hora ou "investigando"}

Ações de Liderança Necessárias:
- [ ] Aprovação de comunicação com clientes
- [ ] Coordenação de PR/Comunicações  
- [ ] Decisões de alocação de recursos
- [ ] Engajamento de fornecedores externos

Incident Commander: {nome} ({contato})
Próxima Atualização: {hora}

---
Este é um alerta automático do nosso sistema de resposta a incidentes.
```

#### Template de Comunicação ao Cliente

```
Estamos atualmente enfrentando {breve descrição do problema} afetando {escopo do impacto}. 

Nossa equipe de engenharia foi alertada às {hora} e está trabalhando ativamente para resolver o problema. Forneceremos atualizações a cada {frequência} até a resolução.

O que sabemos:
- {declaração factual do impacto}
- {declaração factual do escopo}
- {breve status da resposta}

O que estamos fazendo:
- {ação de resposta primária}
- {ação de resposta secundária}

Solução alternativa (se disponível):
{passos da solução alternativa ou "Nenhuma solução alternativa disponível no momento"}

Pedimos desculpas pelo inconveniente e compartilharemos mais informações assim que disponíveis.

Próxima atualização: {hora}
Página de status: {link}
```

### Gerenciamento de Partes Interessadas

#### Classificação de Partes Interessadas

**Partes Interessadas Internas:**
- **Liderança de Engenharia** - Decisões técnicas e alocação de recursos
- **Gestão de Produto** - Avaliação de impacto ao cliente e implicações de funcionalidade
- **Suporte ao Cliente** - Comunicação com usuários e gerenciamento de tickets de suporte
- **Vendas/Gestão de Contas** - Gerenciamento de relacionamento com clientes empresariais
- **Equipe Executiva** - Decisões de impacto nos negócios e aprovação de comunicação externa
- **Jurídico/Conformidade** - Relatórios regulatórios e avaliação de responsabilidade

**Partes Interessadas Externas:**
- **Clientes** - Disponibilidade do serviço e comunicação de impacto
- **Parceiros** - Disponibilidade de API e impactos de integração
- **Fornecedores** - Dependências de serviços de terceiros e escalação de suporte
- **Reguladores** - Relatórios de conformidade para setores regulados
- **Público/Mídia** - Transparência para interrupções públicas

#### Cadência de Comunicação por Parte Interessada

| Parte Interessada | SEV1 | SEV2 | SEV3 | SEV4 |
|-------------|------|------|------|------|
| Liderança de Engenharia | Tempo real | 30min | 4hrs | Diário |
| Equipe Executiva | 15min | 1hr | EOD | Semanal |
| Suporte ao Cliente | Tempo real | 30min | 2hrs | Conforme necessário |
| Clientes | 15min | 1hr | Opcional | Nenhum |
| Parceiros | 30min | 2hrs | Opcional | Nenhum |

### Framework de Geração de Runbook

#### Componentes Dinâmicos de Runbook

1. **Playbooks de Detecção**
   - Definições de alerta de monitoramento
   - Árvores de decisão de triagem
   - Pontos de gatilho de escalação
   - Ações de resposta inicial

2. **Playbooks de Resposta**
   - Procedimentos de mitigação passo a passo
   - Instruções de rollback
   - Pontos de verificação de validação
   - Pontos de verificação de comunicação

3. **Playbooks de Recuperação**
   - Procedimentos de restauração de serviço
   - Verificações de consistência de dados
   - Validação de desempenho
   - Processos de notificação ao usuário

#### Estrutura do Template de Runbook

```markdown
# Runbook de Resposta a Incidentes {Serviço/Componente}

## Referência Rápida
- **Indicadores de Severidade:** {lista de condições para cada nível de severidade}
- **Contatos Principais:** {rotações de plantão e caminhos de escalação}
- **Comandos Críticos:** {lista de comandos de emergência com descrições}

## Detecção
### Alertas de Monitoramento
- {Nome do alerta}: {descrição e limites}
- {Nome do alerta}: {descrição e limites}

### Sinais de Detecção Manual
- {Sintoma}: {o que procurar e onde}
- {Sintoma}: {o que procurar e onde}

## Resposta Inicial (0-15 minutos)
1. **Avaliar Severidade**
   - [ ] Verificar {métrica primária}
   - [ ] Verificar {indicador secundário}
   - [ ] Classificar como SEV{nível} com base em {critérios}

2. **Estabelecer Comando**
   - [ ] Acionar Incident Commander se SEV1/2
   - [ ] Criar ticket de rastreamento de incidente
   - [ ] Entrar no war room: {link/informações de bridge}

3. **Investigação Inicial**
   - [ ] Verificar implantações recentes: {localização do log de implantação}
   - [ ] Revisar logs de erro: {localização do log e consultas}
   - [ ] Verificar dependências: {comandos de verificação de dependência}

## Estratégias de Mitigação
### Estratégia 1: {Nome}
**Use quando:** {condições}
**Passos:**
1. {passo detalhado com comandos}
2. {passo detalhado com resultados esperados}
3. {passo de validação}

**Plano de Rollback:**
1. {passo de rollback}
2. {passo de verificação}

### Estratégia 2: {Nome}
{estrutura semelhante}

## Recuperação e Validação
1. **Restauração do Serviço**
   - [ ] {passo de restauração}
   - [ ] Aguardar {métrica} retornar ao normal
   - [ ] Validar funcionalidade de ponta a ponta

2. **Comunicação**
   - [ ] Atualizar página de status
   - [ ] Notificar partes interessadas
   - [ ] Agendar PIR

## Armadilhas Comuns
- **{Armadilha}:** {descrição e como evitar}
- **{Armadilha}:** {descrição e como evitar}

## Informações de Referência
→ Veja references/reference-information.md para detalhes

## Exemplos de Uso

### Exemplo 1: Esgotamento do Pool de Conexões do Banco de Dados

```bash
# Classificar o incidente
echo '{"description": "Users reporting 500 errors, database connections timing out", "affected_users": "80%", "business_impact": "high"}' | python scripts/incident_classifier.py

# Reconstruir a linha do tempo a partir dos logs
python scripts/timeline_reconstructor.py --input assets/db_incident_events.json --output timeline.md

# Gerar PIR após a resolução
python scripts/pir_generator.py --incident assets/db_incident_data.json --timeline timeline.md --output pir.md
```

### Exemplo 2: Incidente de Limitação de Taxa de API

```bash
# Classificação rápida a partir de stdin
echo "API rate limits causing customer API calls to fail" | python scripts/incident_classifier.py --format text

# Construir linha do tempo a partir de múltiplas fontes
python scripts/timeline_reconstructor.py --input assets/api_incident_logs.json --detect-phases --gap-analysis

# Gerar PIR abrangente
python scripts/pir_generator.py --incident assets/api_incident_summary.json --rca-method fishbone --action-items
```

## Melhores Práticas

### Durante a Resposta ao Incidente

1. **Manter Liderança Calma**
   - Permaneça composto sob pressão
   - Tome decisões decisivas com informações incompletas
   - Comunique confiança enquanto reconhece incerteza

2. **Documente Tudo**
   - Todas as ações tomadas e seus resultados
   - Justificativa de decisão, especialmente para chamadas controversas
   - Linha do tempo de eventos à medida que ocorrem

3. **Comunicação Eficaz**
   - Use linguagem clara, sem jargão
   - Forneça atualizações regulares mesmo quando não há novas informações
   - Gerencie as expectativas das partes interessadas proativamente

4. **Excelência Técnica**
   - Prefira rollbacks a correções arriscadas sob pressão
   - Valide correções antes de declarar resolução
   - Planeje falhas secundárias e efeitos em cascata

### Pós-Incidente

1. **Cultura Sem Culpa**
   - Foque em falhas de sistema, não em erros individuais
   - Incentive relato honesto do que deu errado
   - Celebre oportunidades de aprendizado e melhoria

2. **Disciplina de Itens de Ação**
   - Atribua responsáveis e prazos específicos
   - Acompanhe o progresso publicamente
   - Priorize com base em risco e esforço

3. **Compartilhamento de Conhecimento**
   - Compartilhe PIRs amplamente dentro da organização
   - Atualize runbooks com base em lições aprendidas
   - Realize sessões de treinamento para modos comuns de falha

4. **Melhoria Contínua**
   - Procure padrões em múltiplos incidentes
   - Invista em ferramentas e automação
   - Revise e atualize processos regularmente

## Integração com Ferramentas Existentes

### Monitoramento e Alertas
- Integração PagerDuty/Opsgenie para escalação
- Datadog/Grafana para métricas e dashboards
- ELK/Splunk para análise e correlação de logs

### Plataformas de Comunicação
- Slack/Teams para coordenação do war room
- Zoom/Meet para bridges de vídeo
- Provedores de página de status (Statuspage.io, etc.)

### Sistemas de Documentação
- Confluence/Notion para armazenamento de PIR
- GitHub/GitLab para controle de versão de runbook
- JIRA/Linear para rastreamento de itens de ação

### Gerenciamento de Mudanças
- Integração de pipeline CI/CD
- Sistemas de rastreamento de implantação
- Plataformas de feature flag para rollbacks rápidos

## Conclusão

A skill Incident Commander fornece um framework abrangente para gerenciar incidentes desde a detecção até a revisão pós-incidente. Ao implementar processos estruturados, templates de comunicação claros e ferramentas de análise completas, as equipes podem melhorar suas capacidades de resposta a incidentes e construir sistemas mais resilientes.

A chave para o gerenciamento bem-sucedido de incidentes é preparação, prática e aprendizado contínuo. Use este framework como ponto de partida, mas adapte-o às necessidades específicas, cultura e ambiente técnico de sua organização.

Lembre-se: O objetivo não é prevenir todos os incidentes (o que é impossível), mas detectá-los rapidamente, responder eficazmente, comunicar claramente e aprender continuamente.
