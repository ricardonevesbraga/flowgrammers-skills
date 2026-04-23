---
name: "observability-designer"
description: "Designer de Observabilidade (PODEROSO). Projeta estratégias abrangentes de observabilidade para sistemas em produção, incluindo frameworks SLI/SLO, otimização de alertas e geração de painéis."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Observability Designer (PODEROSO)

**Categoria:** Engenharia
**Nível:** PODEROSO
**Descrição:** Projetar estratégias abrangentes de observabilidade para sistemas em produção, incluindo frameworks SLI/SLO, otimização de alertas e geração de painéis.

## Visão Geral

O Observability Designer permite criar estratégias de observabilidade prontas para produção que fornecem insights profundos sobre comportamento, desempenho e confiabilidade do sistema. Esta skill combina os três pilares da observabilidade (métricas, logs, traces) com frameworks comprovados como design de SLI/SLO, monitoramento de sinais dourados e otimização de alertas para criar soluções abrangentes de observabilidade.

## Competências Principais

### Design de Framework SLI/SLO/SLA
- **Indicadores de Nível de Serviço (SLI):** Defina sinais mensuráveis que indicam a saúde do serviço
- **Objetivos de Nível de Serviço (SLO):** Defina alvos de confiabilidade com base na experiência do usuário
- **Acordos de Nível de Serviço (SLA):** Estabeleça compromissos voltados ao cliente com consequências
- **Gerenciamento de Orçamento de Erro:** Calcule e rastreie o consumo do orçamento de erros
- **Alertas de Taxa de Queima:** Alertas de taxa de queima em múltiplas janelas para proteção proativa de SLO

### Os Três Pilares da Observabilidade

#### Métricas
- **Sinais Dourados:** Monitoramento de latência, tráfego, erros e saturação
- **Método RED:** Taxa, Erros e Duração para serviços orientados a requisições
- **Método USE:** Utilização, Saturação e Erros para monitoramento de recursos
- **Métricas de Negócio:** Rastreamento de receita, engajamento de usuários e adoção de funcionalidades
- **Métricas de Infraestrutura:** CPU, memória, disco, rede e métricas de recursos personalizados

#### Logs
- **Logging Estruturado:** Formatos de log baseados em JSON com campos consistentes
- **Agregação de Logs:** Estratégias de coleta e indexação centralizada de logs
- **Níveis de Log:** Uso adequado dos níveis DEBUG, INFO, WARN, ERROR, FATAL
- **IDs de Correlação:** Rastreamento de requisições em sistemas distribuídos
- **Amostragem de Logs:** Gerenciamento de volume para sistemas de alto throughput

#### Traces
- **Rastreamento Distribuído:** Visualização do fluxo de requisições de ponta a ponta
- **Design de Span:** Limites de span significativos e metadados
- **Amostragem de Trace:** Estratégias de amostragem inteligentes para desempenho e custo
- **Mapas de Serviço:** Descoberta automática de dependências por meio de traces
- **Análise de Causa Raiz:** Fluxos de trabalho de debugging orientados por trace

### Princípios de Design de Painel

#### Arquitetura da Informação
- **Hierarquia:** Caminhos de drill-down Visão Geral → Serviço → Componente → Instância
- **Razão Áurea:** 80% métricas operacionais, 20% métricas exploratórias
- **Carga Cognitiva:** Máximo de 7±2 painéis por tela
- **Jornada do Usuário:** Personas de painel baseadas em papel (SRE, Desenvolvedor, Executivo)

#### Melhores Práticas de Visualização
- **Seleção de Gráfico:** Séries temporais para tendências, mapas de calor para distribuições, medidores para status
- **Teoria das Cores:** Vermelho para crítico, âmbar para aviso, verde para estados saudáveis
- **Linhas de Referência:** Alvos de SLO, limites de capacidade e linhas de base históricas
- **Intervalos de Tempo:** Padrão para janelas significativas (4h para incidentes, 7d para tendências)

#### Design de Painel
- **Consultas de Métricas:** Consultas eficientes do Prometheus/InfluxDB com agregação adequada
- **Integração de Alertas:** Indicadores visuais de estado de alerta nos painéis relevantes
- **Elementos Interativos:** Variáveis de template, links de drill-down e overlays de anotação
- **Desempenho:** Tempos de renderização abaixo de um segundo por meio de otimização de consultas

### Design e Otimização de Alertas

#### Classificação de Alertas
- **Níveis de Severidade:**
  - **Crítico:** Serviço fora, taxa de queima de SLO alta
  - **Aviso:** Aproximando-se dos limites, problemas sem impacto ao usuário
  - **Informação:** Notificações de implantação, alertas de planejamento de capacidade
- **Acionabilidade:** Todo alerta deve ter uma ação de resposta clara
- **Roteamento de Alertas:** Políticas de escalonamento com base em severidade e propriedade da equipe

#### Prevenção de Fadiga de Alertas
- **Sinal vs. Ruído:** Alta precisão (poucos falsos positivos) sobre alto recall
- **Histerese:** Diferentes limites para disparo e resolução de alertas
- **Supressão:** Supressão de alertas dependentes durante interrupções conhecidas
- **Agrupamento:** Alertas relacionados agrupados em notificações únicas

#### Design de Regras de Alerta
- **Seleção de Limites:** Métodos estatísticos para determinação de limites
- **Funções de Janela:** Janelas de média e cálculos de percentil adequados
- **Ciclo de Vida do Alerta:** Condições claras de disparo e critérios de resolução automática
- **Testes:** Validação de regras de alerta contra dados históricos

### Geração de Runbook e Resposta a Incidentes

#### Estrutura do Runbook
- **Contexto do Alerta:** O que o alerta significa e por que disparou
- **Avaliação de Impacto:** Impacto voltado ao usuário vs. impacto interno
- **Passos de Investigação:** Procedimentos de troubleshooting ordenados com estimativas de tempo
- **Ações de Resolução:** Correções comuns e procedimentos de escalonamento
- **Pós-Incidente:** Tarefas de acompanhamento e medidas de prevenção

#### Padrões de Detecção de Incidentes
- **Detecção de Anomalias:** Métodos estatísticos para detectar padrões incomuns
- **Alertas Compostos:** Alertas de múltiplos sinais para modos de falha complexos
- **Alertas Preditivos:** Alertas prospectivos baseados em capacidade e tendências
- **Monitoramento Canário:** Detecção precoce por meio de monitoramento de implantação progressiva

### Framework de Sinais Dourados

#### Monitoramento de Latência
- **Latência de Requisição:** Rastreamento de tempo de resposta P50, P95, P99
- **Latência de Fila:** Tempo gasto esperando em filas de processamento
- **Latência de Rede:** Atrasos de comunicação entre serviços
- **Latência de Banco de Dados:** Métricas de execução de consulta e pool de conexões

#### Monitoramento de Tráfego
- **Taxa de Requisições:** Requisições por segundo com detecção de burst
- **Uso de Banda:** Throughput de rede e utilização de capacidade
- **Sessões de Usuário:** Rastreamento de usuários ativos e duração da sessão
- **Uso de Funcionalidades:** Métricas de adoção de endpoint de API e funcionalidades

#### Monitoramento de Erros
- **Taxa de Erro:** Rastreamento de código de resposta HTTP 4xx e 5xx
- **Orçamento de Erro:** Alvos de taxa de erro baseados em SLO e consumo
- **Distribuição de Erros:** Classificação de tipos de erro e tendências
- **Falhas Silenciosas:** Detecção de falhas de processamento sem erros HTTP

#### Monitoramento de Saturação
- **Utilização de Recursos:** Uso de CPU, memória, disco e rede
- **Profundidade de Fila:** Comprimento da fila de processamento e tempos de espera
- **Pools de Conexão:** Saturação de conexões de banco de dados e serviços
- **Limitação de Taxa:** Rastreamento de throttling de API e esgotamento de cota

### Estratégias de Rastreamento Distribuído

#### Arquitetura de Trace
- **Estratégia de Amostragem:** Amostragem head-based, tail-based e adaptativa
- **Propagação de Trace:** Propagação de contexto entre limites de serviço
- **Correlação de Span:** Modelagem de relacionamento pai-filho
- **Armazenamento de Trace:** Políticas de retenção e otimização de armazenamento

#### Instrumentação de Serviço
- **Auto-Instrumentação:** Geração automática de trace baseada em framework
- **Instrumentação Manual:** Criação de span personalizado para lógica de negócio
- **Tratamento de Bagagem:** Propagação de preocupações transversais
- **Impacto no Desempenho:** Medição e otimização do overhead de instrumentação

### Padrões de Agregação de Logs

#### Arquitetura de Coleta
- **Implantação de Agente:** Estratégias de envio de log (push vs. pull)
- **Roteamento de Log:** Roteamento e filtragem baseados em tópico
- **Estratégias de Parsing:** Tratamento de log estruturado vs. não estruturado
- **Evolução de Esquema:** Versionamento e migração do formato de log

#### Armazenamento e Indexação
- **Design de Índice:** Indexação otimizada de campos para padrões de consulta comuns
- **Políticas de Retenção:** Retenção de log baseada em tempo e volume
- **Compressão:** Compressão e arquivamento de dados de log
- **Desempenho de Pesquisa:** Otimização de consultas e cache de resultados

### Otimização de Custos para Observabilidade

#### Gerenciamento de Dados
- **Retenção de Métricas:** Retenção em camadas com base na importância da métrica
- **Amostragem de Logs:** Amostragem inteligente para reduzir custos de ingestão
- **Amostragem de Traces:** Estratégias de coleta de trace com bom custo-benefício
- **Arquivamento de Dados:** Armazenamento frio para dados históricos de observabilidade

#### Otimização de Recursos
- **Eficiência de Consultas:** Consultas otimizadas de métricas e logs
- **Custos de Armazenamento:** Camadas de armazenamento adequadas para diferentes tipos de dados
- **Limitação de Taxa de Ingestão:** Ingestão de dados controlada para gerenciar custos
- **Gerenciamento de Cardinalidade:** Detecção e mitigação de métricas de alta cardinalidade

## Visão Geral dos Scripts

Esta skill inclui três scripts Python poderosos para design abrangente de observabilidade:

### 1. SLO Designer (`slo_designer.py`)
Gera frameworks completos de SLI/SLO com base nas características do serviço:
- **Entrada:** JSON de descrição do serviço (tipo, criticidade, dependências)
- **Saída:** Definições de SLI, alvos de SLO, orçamentos de erro, alertas de taxa de queima, recomendações de SLA
- **Funcionalidades:** Cálculos de taxa de queima em múltiplas janelas, políticas de orçamento de erro, geração de regras de alerta

### 2. Alert Optimizer (`alert_optimizer.py`)
Analisa e otimiza configurações de alertas existentes:
- **Entrada:** JSON de configuração de alertas com regras, limites e roteamento
- **Saída:** Relatório de otimização e configuração de alertas melhorada
- **Funcionalidades:** Detecção de ruído, lacunas de cobertura, identificação de duplicatas, otimização de limites

### 3. Dashboard Generator (`dashboard_generator.py`)
Cria especificações abrangentes de painel:
- **Entrada:** JSON de descrição do serviço/sistema
- **Saída:** JSON de painel compatível com Grafana e documentação
- **Funcionalidades:** Cobertura de sinais dourados, métodos RED/USE, caminhos de drill-down, visões baseadas em papel

## Padrões de Integração

### Integração com Stack de Monitoramento
- **Prometheus:** Coleta de métricas e geração de regras de alertas
- **Grafana:** Criação de painel e configuração de visualização
- **Elasticsearch/Kibana:** Análise de logs e integração de painel
- **Jaeger/Zipkin:** Configuração de rastreamento distribuído e análise

### Integração CI/CD
- **Monitoramento de Pipeline:** Observabilidade de build, teste e implantação
- **Correlação de Implantação:** Rastreamento de impacto de release e gatilhos de rollback
- **Monitoramento de Feature Flag:** Observabilidade de rollout de funcionalidades e testes A/B
- **Regressão de Desempenho:** Monitoramento automatizado de desempenho em pipelines

### Integração com Gerenciamento de Incidentes
- **PagerDuty/VictorOps:** Roteamento de alertas e políticas de escalonamento
- **Slack/Teams:** Integração de notificação e colaboração
- **JIRA/ServiceNow:** Rastreamento de incidentes e fluxos de trabalho de resolução
- **Post-Mortem:** Análise automatizada de incidentes e rastreamento de melhorias

## Padrões Avançados

### Observabilidade Multi-Cloud
- **Métricas Entre Nuvens:** Métricas unificadas no AWS, GCP e Azure
- **Observabilidade de Rede:** Monitoramento de conectividade entre nuvens
- **Atribuição de Custos:** Rastreamento de custos de recursos em nuvem e otimização
- **Monitoramento de Conformidade:** Rastreamento de postura de segurança e conformidade

### Observabilidade de Microsserviços
- **Integração com Service Mesh:** Configuração de observabilidade Istio/Linkerd
- **Monitoramento de API Gateway:** Observabilidade de roteamento de requisições e limitação de taxa
- **Orquestração de Containers:** Monitoramento de cluster Kubernetes e carga de trabalho
- **Descoberta de Serviços:** Monitoramento dinâmico de serviços e verificações de saúde

### Observabilidade de Machine Learning
- **Desempenho de Modelo:** Monitoramento de precisão, deriva e viés
- **Monitoramento de Feature Store:** Rastreamento de qualidade e frescura de features
- **Observabilidade de Pipeline:** Monitoramento de execução e desempenho do pipeline de ML
- **Análise de Testes A/B:** Significância estatística e medição de impacto nos negócios

## Melhores Práticas

### Alinhamento Organizacional
- **Definição de SLO:** Definição colaborativa de alvos entre produto e engenharia
- **Propriedade de Alertas:** Caminhos claros de escalonamento e responsabilidades da equipe
- **Governança de Painel:** Gerenciamento centralizado de painel e padrões
- **Programas de Treinamento:** Educação da equipe em ferramentas e práticas de observabilidade

### Excelência Técnica
- **Infraestrutura como Código:** Controle de versão da configuração de observabilidade
- **Estratégia de Testes:** Teste de regras de alerta e validação de painel
- **Monitoramento de Desempenho:** Rastreamento do desempenho do sistema de observabilidade
- **Considerações de Segurança:** Controle de acesso e privacidade de dados na observabilidade

### Melhoria Contínua
- **Revisão de Métricas:** Avaliação regular da eficácia dos SLI/SLO
- **Ajuste de Alertas:** Otimização contínua de limites e roteamento de alertas
- **Evolução do Painel:** Melhorias de painel orientadas por feedback do usuário
- **Avaliação de Ferramentas:** Avaliação regular da eficácia das ferramentas de observabilidade

## Métricas de Sucesso

### Métricas Operacionais
- **Tempo Médio para Detecção (MTTD):** Quão rapidamente os problemas são identificados
- **Tempo Médio para Resolução (MTTR):** Tempo da detecção à resolução
- **Precisão de Alertas:** Porcentagem de alertas acionáveis
- **Conquista de SLO:** Porcentagem de alvos de SLO atendidos consistentemente

### Métricas de Negócio
- **Confiabilidade do Sistema:** Tempo de atividade geral e qualidade da experiência do usuário
- **Velocidade de Engenharia:** Produtividade da equipe de desenvolvimento e frequência de implantação
- **Eficiência de Custo:** Custo de observabilidade como porcentagem do gasto em infraestrutura
- **Satisfação do Cliente:** Confiabilidade e satisfação de desempenho relatada pelos usuários

Esta skill abrangente de design de observabilidade permite que as organizações construam sistemas de monitoramento e alertas robustos e escaláveis que fornecem insights acionáveis enquanto mantêm eficiência de custos e excelência operacional.
