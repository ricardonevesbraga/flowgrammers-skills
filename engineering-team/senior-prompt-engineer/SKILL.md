---
name: "senior-prompt-engineer"
description: "Esta skill deve ser usada quando o usuário pedir para 'otimizar prompts', 'projetar templates de prompt', 'avaliar saídas de LLM', 'construir sistemas agênticos', 'implementar RAG', 'criar exemplos few-shot', 'analisar uso de tokens' ou 'projetar workflows de IA'. Use para padrões de prompt engineering, frameworks de avaliação de LLM, arquiteturas de agentes e design de saída estruturada."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Engenheiro de Prompt Sênior

Padrões de prompt engineering, frameworks de avaliação de LLM e design de sistemas agênticos.

## Sumário

- [Início Rápido](#início-rápido)
- [Visão Geral das Ferramentas](#visão-geral-das-ferramentas)
  - [Prompt Optimizer](#1-prompt-optimizer)
  - [RAG Evaluator](#2-rag-evaluator)
  - [Agent Orchestrator](#3-agent-orchestrator)
- [Workflows de Prompt Engineering](#prompt-engineering-workflows)
  - [Workflow de Otimização de Prompt](#workflow-de-otimização-de-prompt)
  - [Design de Exemplos Few-Shot](#design-de-exemplos-few-shot)
  - [Design de Saída Estruturada](#design-de-saída-estruturada)
- [Documentação de Referência](#documentação-de-referência)
- [Referência Rápida de Padrões Comuns](#referência-rápida-de-padrões-comuns)

---

## Início Rápido

```bash
# Analisar e otimizar um arquivo de prompt
python scripts/prompt_optimizer.py prompts/my_prompt.txt --analyze

# Avaliar qualidade de recuperação RAG
python scripts/rag_evaluator.py --contexts contexts.json --questions questions.json

# Visualizar workflow do agente a partir da definição
python scripts/agent_orchestrator.py agent_config.yaml --visualize
```

---

## Visão Geral das Ferramentas

### 1. Prompt Optimizer

Analisa prompts para eficiência de tokens, clareza e estrutura. Gera versões otimizadas.

**Entrada:** Arquivo de texto de prompt ou string
**Saída:** Relatório de análise com sugestões de otimização

**Uso:**
```bash
# Analisar um arquivo de prompt
python scripts/prompt_optimizer.py prompt.txt --analyze

# Saída:
# Contagem de tokens: 847
# Custo estimado: $0.0025 (GPT-4)
# Score de clareza: 72/100
# Problemas encontrados:
#   - Instrução ambígua na linha 3
#   - Especificação de formato de saída ausente
#   - Contexto redundante (linhas 12-15 repetem linhas 5-8)
# Sugestões:
#   1. Adicionar formato de saída explícito: "Responda em JSON com chaves: ..."
#   2. Remover contexto redundante para economizar 89 tokens
#   3. Clarificar "analisar" -> "listar os 3 principais problemas com ratings de severidade"

# Gerar versão otimizada
python scripts/prompt_optimizer.py prompt.txt --optimize --output optimized.txt

# Contar tokens para estimativa de custo
python scripts/prompt_optimizer.py prompt.txt --tokens --model gpt-4

# Extrair e gerenciar exemplos few-shot
python scripts/prompt_optimizer.py prompt.txt --extract-examples --output examples.json
```

---

### 2. RAG Evaluator

Avalia qualidade de Retrieval-Augmented Generation medindo relevância de contexto e fidelidade da resposta.

**Entrada:** Contextos recuperados (JSON) e perguntas/respostas
**Saída:** Métricas de avaliação e relatório de qualidade

**Uso:**
```bash
# Avaliar qualidade de recuperação
python scripts/rag_evaluator.py --contexts retrieved.json --questions eval_set.json

# Saída:
# === Relatório de Avaliação RAG ===
# Perguntas avaliadas: 50
#
# Métricas de Recuperação:
#   Relevância de Contexto: 0.78 (meta: >0.80)
#   Precisão de Recuperação@5: 0.72
#   Cobertura: 0.85
#
# Métricas de Geração:
#   Fidelidade da Resposta: 0.91
#   Fundamentação: 0.88
#
# Problemas Encontrados:
#   - 8 perguntas sem contexto relevante no top-5
#   - 3 respostas continham informações não presentes no contexto
#
# Recomendações:
#   1. Melhorar estratégia de chunking para documentos técnicos
#   2. Adicionar filtragem de metadados para queries sensíveis a datas

# Avaliar com métricas personalizadas
python scripts/rag_evaluator.py --contexts retrieved.json --questions eval_set.json \
    --metrics relevance,faithfulness,coverage

# Exportar resultados detalhados
python scripts/rag_evaluator.py --contexts retrieved.json --questions eval_set.json \
    --output report.json --verbose
```

---

### 3. Agent Orchestrator

Analisa definições de agentes e visualiza fluxos de execução. Valida configurações de ferramentas.

**Entrada:** Configuração de agente (YAML/JSON)
**Saída:** Visualização de workflow, relatório de validação

**Uso:**
```bash
# Validar configuração de agente
python scripts/agent_orchestrator.py agent.yaml --validate

# Saída:
# === Relatório de Validação do Agente ===
# Agente: research_assistant
# Padrão: ReAct
#
# Ferramentas (4 registradas):
#   [OK] web_search - Chave de API configurada
#   [OK] calculator - Sem config necessária
#   [WARN] file_reader - allowed_paths ausente
#   [OK] summarizer - Template de prompt válido
#
# Análise de Fluxo:
#   Profundidade máxima: 5 iterações
#   Tokens estimados/execução: 2.400-4.800
#   Loop infinito potencial: Não
#
# Recomendações:
#   1. Adicionar allowed_paths ao file_reader por segurança
#   2. Considerar adicionar condição de saída antecipada para queries simples

# Visualizar workflow do agente (ASCII)
python scripts/agent_orchestrator.py agent.yaml --visualize

# Saída:
# ┌─────────────────────────────────────────┐
# │            research_assistant           │
# │              (Padrão ReAct)             │
# └─────────────────┬───────────────────────┘
#                   │
#          ┌────────▼────────┐
#          │   Query do Usuário  │
#          └────────┬────────┘
#                   │
#          ┌────────▼────────┐
#          │     Pensar      │◄──────┐
#          └────────┬────────┘       │
#                   │                │
#          ┌────────▼────────┐       │
#          │  Selecionar Tool │       │
#          └────────┬────────┘       │
#                   │                │
#     ┌─────────────┼─────────────┐  │
#     ▼             ▼             ▼  │
# [web_search] [calculator] [file_reader]
#     │             │             │  │
#     └─────────────┼─────────────┘  │
#                   │                │
#          ┌────────▼────────┐       │
#          │    Observar     │───────┘
#          └────────┬────────┘
#                   │
#          ┌────────▼────────┐
#          │  Resposta Final  │
#          └─────────────────┘

# Exportar workflow como diagrama Mermaid
python scripts/agent_orchestrator.py agent.yaml --visualize --format mermaid
```

---

## Workflows de Prompt Engineering

### Workflow de Otimização de Prompt

Use ao melhorar a performance de um prompt existente ou reduzir custos de tokens.

**Passo 1: Estabelecer baseline do prompt atual**
```bash
python scripts/prompt_optimizer.py current_prompt.txt --analyze --output baseline.json
```

**Passo 2: Identificar problemas**
Revise o relatório de análise para:
- Desperdício de tokens (instruções redundantes, exemplos verbosos)
- Instruções ambíguas (formato de saída unclear, verbos vagos)
- Restrições ausentes (sem limites de comprimento, sem especificação de formato)

**Passo 3: Aplicar padrões de otimização**
| Problema | Padrão a Aplicar |
|-------|------------------|
| Saída ambígua | Adicionar especificação de formato explícita |
| Muito verboso | Extrair para exemplos few-shot |
| Resultados inconsistentes | Adicionar framing de papel/persona |
| Edge cases ausentes | Adicionar limites de restrição |

**Passo 4: Gerar versão otimizada**
```bash
python scripts/prompt_optimizer.py current_prompt.txt --optimize --output optimized.txt
```

**Passo 5: Comparar resultados**
```bash
python scripts/prompt_optimizer.py optimized.txt --analyze --compare baseline.json
# Mostra: redução de tokens, melhoria de clareza, problemas resolvidos
```

**Passo 6: Validar com casos de teste**
Execute ambos os prompts contra seu conjunto de avaliação e compare as saídas.

---

### Design de Exemplos Few-Shot

Use ao criar exemplos para aprendizado em contexto.

**Passo 1: Definir a tarefa claramente**
```
Tarefa: Extrair entidades de produto de avaliações de clientes
Entrada: Texto da avaliação
Saída: JSON com {product_name, sentiment, features_mentioned}
```

**Passo 2: Selecionar exemplos diversificados (3-5 recomendados)**
| Tipo de Exemplo | Propósito |
|--------------|---------|
| Caso simples | Mostra padrão básico |
| Caso extremo | Lida com ambiguidade |
| Caso complexo | Múltiplas entidades |
| Caso negativo | O que NÃO extrair |

**Passo 3: Formatar consistentemente**
```
Exemplo 1:
Entrada: "Adorei meu novo iPhone 15, a câmera é incrível!"
Saída: {"product_name": "iPhone 15", "sentiment": "positive", "features_mentioned": ["camera"]}

Exemplo 2:
Entrada: "O notebook foi ok mas a bateria é terrível."
Saída: {"product_name": "notebook", "sentiment": "mixed", "features_mentioned": ["battery life"]}
```

**Passo 4: Validar qualidade dos exemplos**
```bash
python scripts/prompt_optimizer.py prompt_with_examples.txt --validate-examples
# Verifica: consistência, cobertura, alinhamento de formato
```

**Passo 5: Testar com casos não vistos**
Garanta que o modelo generaliza além dos seus exemplos.

---

### Design de Saída Estruturada

Use quando precisar de respostas JSON/XML/estruturadas confiáveis.

**Passo 1: Definir schema**
```json
{
  "type": "object",
  "properties": {
    "summary": {"type": "string", "maxLength": 200},
    "sentiment": {"enum": ["positive", "negative", "neutral"]},
    "confidence": {"type": "number", "minimum": 0, "maximum": 1}
  },
  "required": ["summary", "sentiment"]
}
```

**Passo 2: Incluir schema no prompt**
```
Responda com JSON seguindo este schema:
- summary (string, máx. 200 chars): Resumo breve do conteúdo
- sentiment (enum): Um de "positive", "negative", "neutral"
- confidence (número 0-1): Sua confiança no sentimento
```

**Passo 3: Adicionar imposição de formato**
```
IMPORTANTE: Responda SOMENTE com JSON válido. Sem markdown, sem explicação.
Comece sua resposta com { e termine com }
```

**Passo 4: Validar saídas**
```bash
python scripts/prompt_optimizer.py structured_prompt.txt --validate-schema schema.json
```

---

## Documentação de Referência

| Arquivo | Contém | Carregar quando o usuário perguntar sobre |
|------|----------|---------------------------|
| `references/prompt_engineering_patterns.md` | 10 padrões de prompt com exemplos de entrada/saída | "qual padrão?", "few-shot", "chain-of-thought", "role prompting" |
| `references/llm_evaluation_frameworks.md` | Métricas de avaliação, métodos de scoring, teste A/B | "como avaliar?", "medir qualidade", "comparar prompts" |
| `references/agentic_system_design.md` | Arquiteturas de agente (ReAct, Plan-Execute, Tool Use) | "construir agente", "tool calling", "multi-agent" |

---

## Referência Rápida de Padrões Comuns

| Padrão | Quando Usar | Exemplo |
|---------|-------------|---------|
| **Zero-shot** | Tarefas simples e bem definidas | "Classifique este email como spam ou não spam" |
| **Few-shot** | Tarefas complexas, formato consistente necessário | Forneça 3-5 exemplos antes da tarefa |
| **Chain-of-Thought** | Raciocínio, matemática, lógica multi-etapas | "Pense passo a passo..." |
| **Role Prompting** | Expertise necessária, perspectiva específica | "Você é um contador fiscal especialista..." |
| **Saída Estruturada** | Precisa de JSON/XML parseável | Inclua schema + imposição de formato |

---

## Comandos Comuns

```bash
# Análise de Prompt
python scripts/prompt_optimizer.py prompt.txt --analyze          # Análise completa
python scripts/prompt_optimizer.py prompt.txt --tokens           # Apenas contagem de tokens
python scripts/prompt_optimizer.py prompt.txt --optimize         # Gerar versão otimizada

# Avaliação RAG
python scripts/rag_evaluator.py --contexts ctx.json --questions q.json  # Avaliar
python scripts/rag_evaluator.py --contexts ctx.json --compare baseline  # Comparar com baseline

# Desenvolvimento de Agente
python scripts/agent_orchestrator.py agent.yaml --validate       # Validar config
python scripts/agent_orchestrator.py agent.yaml --visualize      # Mostrar workflow
python scripts/agent_orchestrator.py agent.yaml --estimate-cost  # Estimativa de tokens
```
