---
name: "run"
description: "Comando de ciclo de vida completo que encadeia init → baseline → spawn → eval → merge em uma única invocação."
command: /hub:run
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# /hub:run — Ciclo de Vida Completo

Executar o ciclo de vida completo do AgentHub em um único comando: inicializar, capturar baseline, lançar agentes, avaliar resultados e mergear o vencedor.

## Uso

```
/hub:run --task "Reduce p50 latency" --agents 3 \
  --eval "pytest bench.py --json" --metric p50_ms --direction lower \
  --template optimizer

/hub:run --task "Refactor auth module" --agents 2 --template refactorer

/hub:run --task "Cover untested utils" --agents 3 \
  --eval "pytest --cov=utils --cov-report=json" --metric coverage_pct --direction higher \
  --template test-writer

/hub:run --task "Write 3 email subject lines for spring sale campaign" --agents 3 --judge
```

## Parâmetros

| Parâmetro | Obrigatório | Descrição |
|-----------|----------|-------------|
| `--task` | Sim | Descrição da tarefa para os agentes |
| `--agents` | Não | Número de agentes paralelos (padrão: 3) |
| `--eval` | Não | Comando de avaliação para medir resultados (omitir para modo juiz LLM) |
| `--metric` | Não | Nome da métrica a extrair da saída do eval (obrigatório se `--eval` fornecido) |
| `--direction` | Não | `lower` ou `higher` — qual direção é melhor (obrigatório se `--metric` fornecido) |
| `--template` | Não | Template de agente: `optimizer`, `refactorer`, `test-writer`, `bug-fixer` |

## O Que Faz

Executar estas etapas sequencialmente:

### Passo 1: Inicializar

Executar `/hub:init` com os argumentos fornecidos:

```bash
python {skill_path}/scripts/hub_init.py \
  --task "{task}" --agents {N} \
  [--eval "{eval_cmd}"] [--metric {metric}] [--direction {direction}]
```

Exibir o ID da sessão ao usuário.

### Passo 2: Capturar Baseline

Se `--eval` foi fornecido:

1. Executar o comando de eval no diretório de trabalho atual
2. Extrair o valor da métrica do stdout
3. Exibir: `Baseline capturado: {metric} = {value}`
4. Adicionar `baseline: {value}` a `.agenthub/sessions/{session-id}/config.yaml`

Se nenhum `--eval` foi fornecido, pular esta etapa.

### Passo 3: Lançar Agentes

Executar `/hub:spawn` com o ID da sessão.

Se `--template` foi fornecido, usar o prompt de dispatch do template em `references/agent-templates.md` em vez do prompt de dispatch padrão. Passar o comando de eval, métrica e baseline para as variáveis do template.

Lançar todos os agentes em uma única mensagem com múltiplas chamadas à ferramenta Agent (verdadeiro paralelismo).

### Passo 4: Aguardar e Monitorar

Após o spawn, informar ao usuário que os agentes estão em execução. Quando todos os agentes concluírem (ferramenta Agent retornar resultados):

1. Exibir um breve resumo do trabalho de cada agente
2. Prosseguir para avaliação

### Passo 5: Avaliar

Executar `/hub:eval` com o ID da sessão:

- Se `--eval` foi fornecido: classificação baseada em métrica com `result_ranker.py`
- Se nenhum `--eval`: modo juiz LLM (coordenador lê diffs e classifica)

Se baseline foi capturado, passar `--baseline {value}` para `result_ranker.py` para que os deltas sejam exibidos.

Exibir a tabela de resultados classificados.

### Passo 6: Confirmar e Mergear

Apresentar os resultados ao usuário e pedir confirmação:

```
Agent-2 é o vencedor (128ms, -52ms do baseline).
Mergear o branch do agent-2? [S/n]
```

Se confirmado, executar `/hub:merge`. Se recusado, informar ao usuário que pode:
- `/hub:merge --agent agent-{N}` para escolher um vencedor diferente
- `/hub:eval --judge` para re-avaliar com juiz LLM
- Inspecionar branches manualmente

## Regras Críticas

- **Execução sequencial** — cada etapa depende da anterior
- **Parar em caso de falha** — se alguma etapa falhar, reportar o erro e parar
- **Usuário confirma o merge** — nunca auto-mergear sem perguntar
- **Template é opcional** — sem `--template`, agentes usam o prompt de dispatch padrão do `/hub:spawn`
