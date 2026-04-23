---
name: "agent-designer"
description: "Use quando o usuário pede para projetar sistemas multi-agente, criar arquiteturas de agentes, definir padrões de comunicação entre agentes ou construir workflows de agentes autônomos."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Agent Designer - Arquitetura de Sistemas Multi-Agente

**Nível:** POWERFUL  
**Categoria:** Engineering  
**Tags:** AI agents, arquitetura, design de sistemas, orquestração, sistemas multi-agente

## Visão Geral

Agent Designer é um toolkit completo para projetar, arquitetar e avaliar sistemas multi-agente. Ele fornece abordagens estruturadas para padrões de arquitetura de agentes, princípios de design de ferramentas, estratégias de comunicação e frameworks de avaliação de desempenho para construir sistemas de IA robustos e escaláveis.

## Capacidades Principais

### 1. Padrões de Arquitetura de Agentes

#### Padrão de Agente Único
- **Caso de Uso:** Tarefas simples e focadas com limites claros
- **Vantagens:** Complexidade mínima, depuração fácil, comportamento previsível
- **Desvantagens:** Escalabilidade limitada, ponto único de falha
- **Implementação:** Interação direta usuário-agente com acesso abrangente a ferramentas

#### Padrão Supervisor
- **Caso de Uso:** Decomposição hierárquica de tarefas com controle centralizado
- **Arquitetura:** Um agente supervisor coordenando múltiplos agentes especialistas
- **Vantagens:** Estrutura de comando clara, tomada de decisões centralizada
- **Desvantagens:** Gargalo no supervisor, lógica de coordenação complexa
- **Implementação:** Supervisor recebe tarefas, delega a especialistas e agrega resultados

#### Padrão Swarm
- **Caso de Uso:** Resolução distribuída de problemas com colaboração ponto a ponto
- **Arquitetura:** Múltiplos agentes autônomos com objetivos compartilhados
- **Vantagens:** Alto paralelismo, tolerância a falhas, inteligência emergente
- **Desvantagens:** Coordenação complexa, potencial de conflitos, difícil de prever
- **Implementação:** Descoberta de agentes, mecanismos de consenso, alocação distribuída de tarefas

#### Padrão Hierárquico
- **Caso de Uso:** Sistemas complexos com múltiplas camadas organizacionais
- **Arquitetura:** Estrutura em árvore com gerentes e trabalhadores em diferentes níveis
- **Vantagens:** Mapeamento organizacional natural, responsabilidades claras
- **Desvantagens:** Sobrecarga de comunicação, possíveis gargalos em cada nível
- **Implementação:** Delegação multinível com loops de feedback

#### Padrão Pipeline
- **Caso de Uso:** Processamento sequencial com etapas especializadas
- **Arquitetura:** Agentes dispostos em pipeline de processamento
- **Vantagens:** Fluxo de dados claro, otimização especializada por etapa
- **Desvantagens:** Gargalos sequenciais, ordem de processamento rígida
- **Implementação:** Filas de mensagens entre etapas, transferências de estado

### 2. Definição de Papéis dos Agentes

#### Framework de Especificação de Papéis
- **Identidade:** Nome, declaração de propósito, competências centrais
- **Responsabilidades:** Tarefas primárias, limites de decisão, critérios de sucesso
- **Capacidades:** Ferramentas obrigatórias, domínios de conhecimento, limites de processamento
- **Interfaces:** Formatos de entrada/saída, protocolos de comunicação
- **Restrições:** Limites de segurança, limites de recursos, diretrizes operacionais

#### Arquétipos Comuns de Agentes

**Agente Coordenador**
- Orquestra workflows multi-agente
- Toma decisões de alto nível e alocação de recursos
- Monitora saúde e desempenho do sistema
- Lida com escalações e resolução de conflitos

**Agente Especialista**
- Profundo conhecimento em domínio específico (código, dados, pesquisa)
- Ferramentas e conhecimento otimizados para tarefas especializadas
- Saída de alta qualidade dentro de escopo restrito
- Protocolos claros de transferência para solicitações fora do escopo

**Agente de Interface**
- Lida com interações externas (usuários, APIs, sistemas)
- Tradução de protocolos e conversão de formato
- Gerenciamento de autenticação e autorização
- Otimização da experiência do usuário

**Agente Monitor**
- Monitoramento de saúde do sistema e alertas
- Coleta e análise de métricas de desempenho
- Detecção de anomalias e relatórios
- Manutenção de conformidade e trilha de auditoria

### 3. Princípios de Design de Ferramentas

#### Design de Schema
- **Validação de Entrada:** Tipagem forte, parâmetros obrigatórios vs. opcionais
- **Consistência de Saída:** Formatos de resposta padronizados, tratamento de erros
- **Documentação:** Descrições claras, exemplos de uso, casos extremos
- **Versionamento:** Compatibilidade retroativa, caminhos de migração

#### Padrões de Tratamento de Erros
- **Degradação Graciosa:** Funcionalidade parcial quando dependências falham
- **Lógica de Retry:** Backoff exponencial, disjuntores, número máximo de tentativas
- **Propagação de Erros:** Respostas de erro estruturadas, classificação de erros
- **Estratégias de Recuperação:** Métodos de fallback, abordagens alternativas

#### Requisitos de Idempotência
- **Operações Seguras:** Operações de leitura sem efeitos colaterais
- **Escritas Idempotentes:** A mesma operação pode ser repetida com segurança
- **Gerenciamento de Estado:** Rastreamento de versão, resolução de conflitos
- **Atomicidade:** Conclusão de operação tudo-ou-nada

### 4. Padrões de Comunicação

#### Troca de Mensagens
- **Mensagens Assíncronas:** Agentes desacoplados, filas de mensagens
- **Formato de Mensagem:** Payloads estruturados com metadados
- **Garantias de Entrega:** Semântica ao-menos-uma-vez, exatamente-uma-vez
- **Roteamento:** Mensagens diretas, publicação-assinatura, broadcast

#### Estado Compartilhado
- **Armazenamentos de Estado:** Repositórios de dados centralizados
- **Modelos de Consistência:** Consistência forte, eventual, fraca
- **Padrões de Acesso:** Leitura intensiva, escrita intensiva, cargas mistas
- **Resolução de Conflitos:** Último-escritor-vence, estratégias de merge

#### Arquitetura Orientada a Eventos
- **Event Sourcing:** Logs de eventos imutáveis, reconstrução de estado
- **Tipos de Eventos:** Eventos de domínio, eventos de sistema, eventos de integração
- **Processamento de Eventos:** Em tempo real, em lote, processamento de stream
- **Schema de Eventos:** Formatos de eventos versionados, compatibilidade retroativa

### 5. Guardrails e Segurança

#### Validação de Entrada
- **Aplicação de Schema:** Campos obrigatórios, verificação de tipos, validação de formato
- **Filtragem de Conteúdo:** Detecção de conteúdo prejudicial, remoção de PII
- **Limitação de Taxa:** Throttling de requisições, cotas de recursos
- **Autenticação:** Verificação de identidade, verificações de autorização

#### Filtragem de Saída
- **Moderação de Conteúdo:** Remoção de conteúdo prejudicial, verificações de qualidade
- **Validação de Consistência:** Verificações lógicas, verificação de restrições
- **Formatação:** Formatos de saída padronizados, apresentação limpa
- **Log de Auditoria:** Trilhas de decisão, registros de conformidade

#### Humano no Loop
- **Workflows de Aprovação:** Pontos de verificação de decisões críticas
- **Gatilhos de Escalação:** Limites de confiança, avaliação de risco
- **Mecanismos de Override:** Precedência do julgamento humano
- **Loops de Feedback:** Correções humanas melhoram o comportamento do sistema

### 6. Frameworks de Avaliação

#### Métricas de Conclusão de Tarefas
- **Taxa de Sucesso:** Percentual de tarefas concluídas com êxito
- **Conclusão Parcial:** Medição de progresso para tarefas complexas
- **Classificação de Tarefas:** Critérios de sucesso por tipo de tarefa
- **Análise de Falhas:** Identificação da causa raiz e categorização

#### Avaliação de Qualidade
- **Qualidade de Saída:** Medidas de precisão, relevância e completude
- **Consistência:** Variabilidade de resposta entre entradas semelhantes
- **Coerência:** Fluxo lógico e consistência interna
- **Satisfação do Usuário:** Pontuações de feedback, padrões de uso

#### Análise de Custos
- **Uso de Tokens:** Consumo de tokens de entrada/saída por tarefa
- **Custos de API:** Uso e cobranças de serviços externos
- **Recursos Computacionais:** Utilização de CPU, memória e armazenamento
- **Tempo-para-Valor:** Custo por tarefa concluída com êxito

#### Distribuição de Latência
- **Tempo de Resposta:** Tempo de conclusão de tarefa ponta a ponta
- **Etapas de Processamento:** Identificação de gargalos por etapa
- **Tempos de Fila:** Tempos de espera em pipelines de processamento
- **Contenção de Recursos:** Impacto de operações concorrentes

### 7. Estratégias de Orquestração

#### Orquestração Centralizada
- **Motor de Workflow:** Coordenador central gerencia todos os agentes
- **Gerenciamento de Estado:** Rastreamento centralizado do estado do workflow
- **Lógica de Decisão:** Regras complexas de roteamento e ramificação
- **Monitoramento:** Visibilidade abrangente de todas as operações

#### Orquestração Descentralizada
- **Ponto a Ponto:** Agentes coordenam diretamente entre si
- **Descoberta de Serviços:** Registro e pesquisa dinâmicos de agentes
- **Protocolos de Consenso:** Tomada de decisões distribuída
- **Tolerância a Falhas:** Sem ponto único de falha

#### Abordagens Híbridas
- **Limites de Domínio:** Centralizado dentro de domínios, federado entre eles
- **Coordenação Hierárquica:** Múltiplos níveis de orquestração
- **Dependente de Contexto:** Seleção de estratégia com base no tipo de tarefa
- **Balanceamento de Carga:** Distribuição de responsabilidade de coordenação

### 8. Padrões de Memória

#### Memória de Curto Prazo
- **Janelas de Contexto:** Memória de trabalho para tarefas atuais
- **Estado de Sessão:** Dados temporários para interações em andamento
- **Gerenciamento de Cache:** Estratégias de otimização de desempenho
- **Pressão de Memória:** Tratamento de restrições de capacidade

#### Memória de Longo Prazo
- **Armazenamento Persistente:** Dados duráveis entre sessões
- **Base de Conhecimento:** Conhecimento de domínio acumulado
- **Replay de Experiências:** Aprendizado com interações passadas
- **Consolidação de Memória:** Transferência de curto para longo prazo

#### Memória Compartilhada
- **Conhecimento Colaborativo:** Aprendizado compartilhado entre agentes
- **Sincronização:** Estratégias de manutenção de consistência
- **Controle de Acesso:** Acesso à memória baseado em permissões
- **Particionamento de Memória:** Isolamento entre grupos de agentes

### 9. Considerações de Escalabilidade

#### Escalabilidade Horizontal
- **Replicação de Agentes:** Múltiplas instâncias do mesmo tipo de agente
- **Distribuição de Carga:** Roteamento de requisições entre instâncias de agentes
- **Pool de Recursos:** Recursos computacionais e de armazenamento compartilhados
- **Distribuição Geográfica:** Implantações em múltiplas regiões

#### Escalabilidade Vertical
- **Aprimoramento de Capacidade:** Agentes individuais mais poderosos
- **Expansão de Ferramentas:** Acesso mais amplo a ferramentas por agente
- **Expansão de Contexto:** Maior capacidade de memória de trabalho
- **Poder de Processamento:** Maior throughput por agente

#### Otimização de Desempenho
- **Estratégias de Cache:** Cache de resposta, cache de resultado de ferramentas
- **Processamento Paralelo:** Execução concorrente de tarefas
- **Otimização de Recursos:** Utilização eficiente de recursos
- **Eliminação de Gargalos:** Ajuste sistemático de desempenho

### 10. Tratamento de Falhas

#### Mecanismos de Retry
- **Backoff Exponencial:** Atrasos crescentes entre tentativas
- **Jitter:** Variação aleatória de atraso para prevenir thundering herd
- **Máximo de Tentativas:** Comportamento de retry limitado
- **Condições de Retry:** Classificação de falha transitória vs. permanente

#### Estratégias de Fallback
- **Degradação Graciosa:** Funcionalidade reduzida quando sistemas falham
- **Abordagens Alternativas:** Métodos diferentes para os mesmos objetivos
- **Respostas Padrão:** Comportamentos de fallback seguros
- **Comunicação com o Usuário:** Mensagens claras de falha

#### Disjuntores
- **Detecção de Falhas:** Monitoramento de taxas de falha e tempos de resposta
- **Gerenciamento de Estado:** Estados aberto, fechado e meio-aberto do disjuntor
- **Teste de Recuperação:** Retorno gradual à operação normal
- **Prevenção de Falha em Cascata:** Proteção de sistemas upstream

## Diretrizes de Implementação

### Processo de Decisão Arquitetural
1. **Análise de Requisitos:** Entender objetivos do sistema, restrições e escala
2. **Seleção de Padrão:** Escolher o padrão arquitetural apropriado
3. **Design de Agentes:** Definir papéis, responsabilidades e interfaces
4. **Arquitetura de Ferramentas:** Projetar schemas de ferramentas e tratamento de erros
5. **Design de Comunicação:** Selecionar padrões e protocolos de mensagens
6. **Implementação de Segurança:** Construir guardrails e validação
7. **Planejamento de Avaliação:** Definir métricas de sucesso e monitoramento
8. **Estratégia de Implantação:** Planejar escalabilidade e tratamento de falhas

### Garantia de Qualidade
- **Estratégia de Testes:** Abordagens de testes unitários, de integração e de sistema
- **Monitoramento:** Rastreamento em tempo real da saúde e desempenho do sistema
- **Documentação:** Documentação de arquitetura e runbooks
- **Revisão de Segurança:** Modelagem de ameaças e avaliações de segurança

### Melhoria Contínua
- **Monitoramento de Desempenho:** Análise contínua do desempenho do sistema
- **Feedback do Usuário:** Incorporação de melhorias na experiência do usuário
- **Testes A/B:** Experimentos controlados para melhorias do sistema
- **Atualizações da Base de Conhecimento:** Aprendizado e adaptação contínuos

Esta skill fornece a base para projetar sistemas multi-agente robustos e escaláveis que podem lidar com tarefas complexas mantendo segurança, confiabilidade e desempenho em escala.
