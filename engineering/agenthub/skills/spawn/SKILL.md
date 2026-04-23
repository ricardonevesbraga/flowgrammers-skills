---
name: "spawn"
description: "Lançar N subagentes paralelos em git worktrees isolados para competir na tarefa da sessão."
command: /hub:spawn
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# /hub:spawn — Lançar Agentes Paralelos

Lançar N subagentes que trabalham na mesma tarefa em paralelo, cada um em um git worktree isolado.

## Uso

```
/hub:spawn                                    # Lançar agentes para a sessão mais recente
/hub:spawn 20260317-143022                    # Lançar agentes para uma sessão específica
/hub:spawn --template optimizer               # Usar template optimizer para prompts de dispatch
/hub:spawn --template refactorer              # Usar template refactorer
```

## Templates

Quando `--template <name>` é fornecido, usar o prompt de dispatch de `references/agent-templates.md` em vez do prompt padrão abaixo. Templates disponíveis:

| Template | Padrão | Caso de Uso |
|----------|---------|----------|
| `optimizer` | Editar → avaliar → manter/descartar → repetir x10 | Desempenho, latência, redução de tamanho |
| `refactorer` | Reestruturar → testar → iterar até verde | Qualidade de código, dívida técnica |
| `test-writer` | Escrever testes → medir cobertura → repetir | Lacunas de cobertura de testes |
| `bug-fixer` | Reproduzir → diagnosticar → corrigir → verificar | Correção de bugs com abordagens concorrentes |

Ao usar um template, substituir todas as `{variáveis}` com valores da configuração da sessão. Atribuir a cada agente uma **estratégia diferente** apropriada ao template e à tarefa — estratégias diversas maximizam o valor da exploração paralela.

## O Que Faz

1. Carregar configuração da sessão de `.agenthub/sessions/{session-id}/config.yaml`
2. Para cada agente 1..N:
   - Escrever atribuição de tarefa em `.agenthub/board/dispatch/`
   - Construir prompt do agente com tarefa, restrições e instruções de escrita no board
3. Lançar TODOS os agentes em uma **única mensagem** com múltiplas chamadas à ferramenta Agent:

```
Agent(
  prompt: "You are agent-{i} in hub session {session-id}.

Your task: {task}

Read your full assignment at .agenthub/board/dispatch/{seq}-agent-{i}.md

Instructions:
1. Work in your worktree — make changes, run tests, iterate
2. Commit all changes with descriptive messages
3. Write your result summary to .agenthub/board/results/agent-{i}-result.md
   Include: approach taken, files changed, metric if available, confidence level
4. Exit when done

Constraints:
- Do NOT read or modify other agents' work
- Do NOT access .agenthub/board/results/ for other agents
- Commit early and often with descriptive messages
- If you hit a dead end, commit what you have and explain in your result",
  isolation: "worktree"
)
```

4. Atualizar estado da sessão para `running` via:
```bash
python {skill_path}/scripts/session_manager.py --update {session-id} --state running
```

## Regras Críticas

- **Todos os agentes em UMA mensagem** — lançar todas as chamadas à ferramenta Agent simultaneamente para verdadeiro paralelismo
- **isolation: "worktree"** é obrigatório — cada agente precisa do seu próprio sistema de arquivos
- **Nunca modificar a configuração da sessão** após o spawn — os agentes dependem de configuração estável
- **Cada agente recebe uma postagem única no board** — posts de dispatch são numerados sequencialmente

## Após o Spawn

Informar ao usuário:
- {N} agentes lançados em paralelo
- Cada um trabalhando em um worktree isolado
- Monitorar com `/hub:status`
- Avaliar quando concluído com `/hub:eval`
