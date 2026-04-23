---
name: "status"
description: "Mostrar estado do DAG, progresso dos agentes e status dos branches para uma sessão do AgentHub."
command: /hub:status
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# /hub:status — Status da Sessão

Exibir o estado atual de uma sessão do AgentHub: branches dos agentes, contagens de commits, status de fronteira e atualizações do board.

## Uso

```
/hub:status                        # Status da sessão mais recente
/hub:status 20260317-143022        # Status de sessão específica
```

## O Que Faz

1. Executar visão geral da sessão:
```bash
python {skill_path}/scripts/session_manager.py --status {session-id}
```

2. Executar análise do DAG:
```bash
python {skill_path}/scripts/dag_analyzer.py --status --session {session-id}
```

3. Ler atualizações recentes do board:
```bash
python {skill_path}/scripts/board_manager.py --read progress
```

## Formato de Saída

```
Sessão: 20260317-143022 (running)
Tarefa: Optimize API response time below 100ms
Agentes: 3 | Base: dev

AGENTE   BRANCH                                        COMMITS  STATUS     ÚLTIMA ATUALIZ.
agent-1  hub/20260317-143022/agent-1/attempt-1         3        frontier   2026-03-17 14:35:10
agent-2  hub/20260317-143022/agent-2/attempt-1         5        frontier   2026-03-17 14:36:45
agent-3  hub/20260317-143022/agent-3/attempt-1         2        frontier   2026-03-17 14:34:22

Atividade Recente do Board:
  [progress] agent-1: Implemented caching, running tests
  [progress] agent-2: Hash map approach working, benchmarking
  [results]  agent-2: Final result posted
```

Exemplo de saída para uma tarefa de conteúdo:

```
Sessão: 20260317-151200 (running)
Tarefa: Draft 3 competing taglines for product launch
Agentes: 3 | Base: dev

AGENTE   BRANCH                                        COMMITS  STATUS     ÚLTIMA ATUALIZ.
agent-1  hub/20260317-151200/agent-1/attempt-1         2        frontier   2026-03-17 15:18:30
agent-2  hub/20260317-151200/agent-2/attempt-1         2        frontier   2026-03-17 15:19:12
agent-3  hub/20260317-151200/agent-3/attempt-1         1        frontier   2026-03-17 15:17:55

Atividade Recente do Board:
  [progress] agent-1: Storytelling angle draft complete, refining CTA
  [progress] agent-2: Benefit-led draft done, testing urgency variant
  [results]  agent-3: Final result posted
```

## Após o Status

Se todos os agentes postaram resultados:
- Sugerir `/hub:eval` para classificar os resultados

Se alguns agentes ainda estão em execução:
- Mostrar quais estão concluídos vs. em andamento
- Sugerir aguardar ou verificar novamente mais tarde
