---
name: "merge"
description: "Mergear o branch do agente vencedor no base, arquivar os perdedores e limpar os worktrees."
command: /hub:merge
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# /hub:merge — Mergear o Vencedor

Mergear o branch do melhor agente no branch base, arquivar branches perdedores via git tags e limpar worktrees.

## Uso

```
/hub:merge                                       # Mergear vencedor da sessão mais recente
/hub:merge 20260317-143022                       # Mergear vencedor de sessão específica
/hub:merge 20260317-143022 --agent agent-2       # Escolher vencedor explicitamente
```

## O Que Faz

### 1. Identificar o Vencedor

Se `--agent` especificado, usar esse. Caso contrário, usar o agente #1 classificado no `/hub:eval` mais recente.

### 2. Mergear o Vencedor

```bash
git checkout {base_branch}
git merge --no-ff hub/{session-id}/{winner}/attempt-1 \
  -m "hub: merge {winner} from session {session-id}

Task: {task}
Winner: {winner}
Session: {session-id}"
```

### 3. Arquivar os Perdedores

Para cada agente não-vencedor:

```bash
# Criar tag de arquivo (preserva commits para sempre)
git tag hub/archive/{session-id}/{agent-id} hub/{session-id}/{agent-id}/attempt-1

# Excluir ref do branch (commits preservados via tag)
git branch -D hub/{session-id}/{agent-id}/attempt-1
```

### 4. Limpar Worktrees

```bash
python {skill_path}/scripts/session_manager.py --cleanup {session-id}
```

### 5. Postar Resumo do Merge

Escrever `.agenthub/board/results/merge-summary.md`:

```markdown
---
author: coordinator
timestamp: {now}
channel: results
---

## Resumo do Merge

- **Sessão**: {session-id}
- **Vencedor**: {winner}
- **Mergeado em**: {base_branch}
- **Arquivados**: {loser-1}, {loser-2}, ...
- **Worktrees limpos**: {count}
```

### 6. Atualizar Estado

```bash
python {skill_path}/scripts/session_manager.py --update {session-id} --state merged
```

## Segurança

- **Confirmar com o usuário** antes do merge — mostrar o resumo do diff primeiro
- **Nunca force-push** — o merge é sempre `--no-ff` para histórico claro
- **Arquivar, não excluir** — commits dos agentes perdedores são preservados via tags
- **Limpar worktrees** — não deixar diretórios órfãos no disco

## Após o Merge

Informar ao usuário:
- Vencedor mergeado em `{base_branch}`
- Perdedores arquivados com tags `hub/archive/{session-id}/agent-{N}`
- Worktrees limpos
- Estado da sessão: `merged`
