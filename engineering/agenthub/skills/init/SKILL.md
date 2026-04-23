---
name: "init"
description: "Criar uma nova sessão de colaboração do AgentHub com tarefa, número de agentes e critérios de avaliação."
command: /hub:init
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# /hub:init — Criar Nova Sessão

Inicializar uma sessão de colaboração do AgentHub. Cria a estrutura de diretórios `.agenthub/`, gera um ID de sessão e configura os critérios de avaliação.

## Uso

```
/hub:init                                                    # Modo interativo
/hub:init --task "Optimize API" --agents 3 --eval "pytest bench.py" --metric p50_ms --direction lower
/hub:init --task "Refactor auth" --agents 2                  # Sem eval (modo juiz LLM)
```

## O Que Faz

### Se argumentos fornecidos

Passá-los ao script de init:

```bash
python {skill_path}/scripts/hub_init.py \
  --task "{task}" --agents {N} \
  [--eval "{eval_cmd}"] [--metric {metric}] [--direction {direction}] \
  [--base-branch {branch}]
```

### Se sem argumentos (modo interativo)

Coletar cada parâmetro:

1. **Tarefa** — O que os agentes devem fazer? (obrigatório)
2. **Número de agentes** — Quantos agentes paralelos? (padrão: 3)
3. **Comando de avaliação** — Comando para medir resultados (opcional — pular para modo juiz LLM)
4. **Nome da métrica** — Qual métrica extrair da saída do eval (obrigatório se comando de eval fornecido)
5. **Direção** — Menor ou maior é melhor? (obrigatório se métrica fornecida)
6. **Branch base** — Branch de origem (padrão: branch atual)

### Saída

```
Sessão AgentHub inicializada
  Session ID: 20260317-143022
  Tarefa: Optimize API response time below 100ms
  Agentes: 3
  Eval: pytest bench.py --json
  Métrica: p50_ms (menor é melhor)
  Branch base: dev
  Estado: init

Próximo passo: Execute /hub:spawn para lançar 3 agentes
```

Para tarefas de conteúdo ou pesquisa (sem comando de eval → modo juiz LLM):

```
Sessão AgentHub inicializada
  Session ID: 20260317-151200
  Tarefa: Draft 3 competing taglines for product launch
  Agentes: 3
  Eval: Juiz LLM (sem comando de eval)
  Branch base: dev
  Estado: init

Próximo passo: Execute /hub:spawn para lançar 3 agentes
```

## Captura de Baseline

Se `--eval` foi fornecido, capturar uma medição de baseline após a criação da sessão:

1. Executar o comando de eval no diretório de trabalho atual
2. Extrair o valor da métrica do stdout
3. Adicionar `baseline: {value}` a `.agenthub/sessions/{session-id}/config.yaml`
4. Exibir: `Baseline capturado: {metric} = {value}`

Este baseline é usado por `result_ranker.py --baseline` durante a avaliação para mostrar deltas. Se o comando de eval falhar nesta etapa, avisar o usuário mas continuar — o baseline é opcional.

## Após o Init

Informar ao usuário:
- Sessão criada com ID `{session-id}`
- Métrica de baseline (se capturada)
- Próximo passo: `/hub:spawn` para lançar os agentes
- Ou `/hub:spawn {session-id}` se existirem múltiplas sessões
