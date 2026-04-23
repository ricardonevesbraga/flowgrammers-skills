---
name: tech-debt-tracker
description: Escanear bases de código em busca de dívida técnica, pontuar severidade, rastrear tendências e gerar planos de remediação priorizados. Use quando os usuários mencionarem dívida técnica, qualidade de código, prioridade de refatoração, pontuação de dívida, sprints de limpeza ou avaliação de saúde do código. Também use para planejamento de modernização de código legado e estimativa de custo de manutenção.
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Tech Debt Tracker

**Nível**: PODEROSO
**Categoria**: Automação de Processos de Engenharia
**Especialidade**: Qualidade de Código, Gerenciamento de Dívida Técnica, Engenharia de Software

## Visão Geral

A dívida técnica é um dos desafios mais insidiosos no desenvolvimento de software — ela se acumula ao longo do tempo, desacelerando a velocidade de desenvolvimento, aumentando os custos de manutenção e reduzindo a qualidade do código. Esta skill fornece uma estrutura abrangente para identificar, analisar, priorizar e rastrear dívida técnica em bases de código.

A dívida técnica não é apenas sobre código bagunçado — ela abrange atalhos arquiteturais, testes ausentes, dependências desatualizadas, lacunas de documentação e compromissos de infraestrutura. Como dívida financeira, ela acumula "juros" por meio de maior tempo de desenvolvimento, taxas mais altas de bugs e velocidade reduzida da equipe.

## O Que Esta Skill Fornece

Esta skill oferece três ferramentas interconectadas que formam um sistema completo de gerenciamento de dívida técnica:

1. **Scanner de Dívida** - Identifica automaticamente sinais de dívida técnica na sua base de código
2. **Priorizador de Dívida** - Analisa e prioriza itens de dívida usando frameworks de custo de atraso
3. **Dashboard de Dívida** - Rastreia tendências de dívida ao longo do tempo e fornece relatórios executivos

Juntas, essas ferramentas permitem que equipes de engenharia tomem decisões baseadas em dados sobre dívida técnica, equilibrando o desenvolvimento de novas funcionalidades com trabalho de manutenção.

## Framework de Classificação de Dívida Técnica
→ Consulte references/debt-frameworks.md para detalhes

## Roadmap de Implementação

### Fase 1: Fundação (Semanas 1-2)
1. Configurar infraestrutura de escaneamento de dívida
2. Estabelecer taxonomia de dívida e critérios de pontuação
3. Escanear base de código inicial e criar inventário de baseline
4. Treinar a equipe em identificação e relato de dívida

### Fase 2: Integração de Processo (Semanas 3-4)
1. Integrar rastreamento de dívida no planejamento de sprint
2. Estabelecer orçamentos de dívida e regras de alocação
3. Criar templates de relatórios para partes interessadas
4. Configurar escaneamento automatizado de dívida no CI/CD

### Fase 3: Otimização (Semanas 5-6)
1. Refinar algoritmos de pontuação com base no feedback da equipe
2. Implementar análise de tendências e métricas preditivas
3. Criar iniciativas especializadas de redução de dívida
4. Estabelecer processos de coordenação de dívida entre equipes

### Fase 4: Maturidade (Contínuo)
1. Melhoria contínua dos algoritmos de detecção
2. Análise avançada e modelos de previsão
3. Integração com ferramentas de planejamento e gerenciamento de projetos
4. Melhores práticas de gerenciamento de dívida em toda a organização

## Critérios de Sucesso

**Métricas Quantitativas:**
- Redução de 25% na taxa de juros de dívida em 6 meses
- Melhoria de 15% na velocidade de desenvolvimento
- Redução de 30% nos defeitos de produção
- Ciclos de revisão de código 20% mais rápidos

**Métricas Qualitativas:**
- Melhoria nas pontuações de satisfação do desenvolvedor
- Redução na troca de contexto durante o desenvolvimento de funcionalidades
- Integração mais rápida de novos membros da equipe
- Melhor previsibilidade nos cronogramas de entrega de funcionalidades

## Armadilhas Comuns e Como Evitá-las

### 1. Paralisia de Análise
**Problema**: Gastar muito tempo analisando a dívida em vez de corrigi-la.
**Solução**: Definir limites de tempo para análise, usar pontuação "boa o suficiente" para a maioria dos itens.

### 2. Perfeccionismo
**Problema**: Tentar eliminar toda a dívida em vez de gerenciá-la.
**Solução**: Focar na dívida de alto impacto, aceitar que alguma dívida é aceitável.

### 3. Ignorar o Contexto de Negócio
**Problema**: Priorizar elegância técnica sobre valor de negócio.
**Solução**: Sempre vincular o trabalho de dívida a resultados de negócio e impacto no cliente.

### 4. Aplicação Inconsistente
**Problema**: Algumas equipes adotam as práticas enquanto outras as ignoram.
**Solução**: Tornar o rastreamento de dívida parte do fluxo de trabalho padrão de desenvolvimento.

### 5. Engenharia Excessiva de Ferramentas
**Problema**: Construir sistemas complexos de gerenciamento de dívida que ninguém usa.
**Solução**: Começar simples, iterar com base em padrões reais de uso.

O gerenciamento de dívida técnica não é apenas sobre escrever código melhor — é sobre criar práticas de desenvolvimento sustentáveis que equilibram a pressão de entrega de curto prazo com a saúde do sistema a longo prazo. Use essas ferramentas e frameworks para tomar decisões informadas sobre quando e como investir na redução de dívida.
