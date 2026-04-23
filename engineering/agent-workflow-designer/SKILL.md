---
name: "agent-workflow-designer"
description: "Projeta workflows multi-agente de nível produção com escolha clara de padrão, contratos de transferência, tratamento de falhas e controles de custo e contexto."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Agent Workflow Designer

**Nível:** POWERFUL  
**Categoria:** Engineering  
**Domínio:** Sistemas Multi-Agente / Orquestração de IA

---

## Visão Geral

Projeta workflows multi-agente de nível produção com escolha clara de padrão, contratos de transferência, tratamento de falhas e controles de custo e contexto.

## Capacidades Principais

- Seleção de padrão de workflow para sistemas de agentes com múltiplas etapas
- Geração de configuração esqueleto para inicialização rápida de workflows
- Disciplina de contexto e custo em fluxos de longa duração
- Scaffolding de estratégias de recuperação de erros e retry
- Referências de documentação para trade-offs de padrões operacionais

---

## Quando Usar

- Um único prompt é insuficiente para a complexidade da tarefa
- Você precisa de agentes especialistas com limites explícitos
- Você quer estrutura de workflow determinística antes da implementação
- Você precisa de loops de validação para qualidade ou gates de segurança

---

## Início Rápido

```bash
# Gerar um esqueleto de workflow sequencial
python3 scripts/workflow_scaffolder.py sequential --name content-pipeline

# Gerar um workflow orquestrador e salvá-lo
python3 scripts/workflow_scaffolder.py orchestrator --name incident-triage --output workflows/incident-triage.json
```

---

## Mapa de Padrões

- `sequential`: cadeia de dependência passo a passo estrita
- `parallel`: fan-out/fan-in para subtarefas independentes
- `router`: despacho por intenção/tipo com fallback
- `orchestrator`: planejador coordena especialistas com dependências
- `evaluator`: loop gerador + gate de qualidade

Templates detalhados: `references/workflow-patterns.md`

---

## Workflow Recomendado

1. Selecionar padrão com base no formato de dependência e perfil de risco.
2. Criar scaffold de configuração via `scripts/workflow_scaffolder.py`.
3. Definir campos do contrato de transferência para cada aresta.
4. Adicionar políticas de retry/timeout e gates de validação de saída.
5. Executar dry-run com orçamentos de contexto pequenos antes de escalar.

---

## Armadilhas Comuns

- Sobre-orquestrar tarefas solucionáveis por um único prompt bem estruturado
- Ausência de políticas de timeout/retry para chamadas a modelos externos
- Passar contexto upstream completo em vez de artefatos específicos
- Ignorar acumulação de custo por etapa

## Melhores Práticas

1. Comece com o menor padrão que possa satisfazer os requisitos.
2. Mantenha os payloads de transferência explícitos e delimitados.
3. Valide saídas intermediárias antes da síntese no fan-in.
4. Aplique limites de orçamento e timeout em cada etapa.
