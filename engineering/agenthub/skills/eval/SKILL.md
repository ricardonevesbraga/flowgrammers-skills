---
name: "eval"
description: "Avaliar e classificar resultados dos agentes por métrica ou juiz LLM para uma sessão do AgentHub."
command: /hub:eval
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# /hub:eval — Avaliar Resultados dos Agentes

Classifica todos os resultados dos agentes para uma sessão. Suporta avaliação baseada em métrica (executar um comando), juiz LLM (comparar diffs) ou híbrido.

## Uso

```
/hub:eval                           # Avaliar a sessão mais recente usando critérios configurados
/hub:eval 20260317-143022           # Avaliar sessão específica
/hub:eval --judge                   # Forçar modo juiz LLM (ignorar configuração de métrica)
```

## O Que Faz

### Modo Métrica (comando de avaliação configurado)

Executar o comando de avaliação no worktree de cada agente:

```bash
python {skill_path}/scripts/result_ranker.py \
  --session {session-id} \
  --eval-cmd "{eval_cmd}" \
  --metric {metric} --direction {direction}
```

Saída:
```
RANK  AGENTE      MÉTRICA     DELTA      ARQUIVOS
1     agent-2     142ms       -38ms      2
2     agent-1     165ms       -15ms      3
3     agent-3     190ms       +10ms      1

Vencedor: agent-2 (142ms)
```

### Modo Juiz LLM (sem comando de avaliação, ou flag --judge)

Para cada agente:
1. Obter o diff: `git diff {base_branch}...{agent_branch}`
2. Ler a postagem de resultado do agente em `.agenthub/board/results/agent-{i}-result.md`
3. Comparar todos os diffs e classificar por:
   - **Correção** — Resolve a tarefa?
   - **Simplicidade** — Menos linhas alteradas é melhor (quando a correção é igual)
   - **Qualidade** — Execução limpa, boa estrutura, sem regressões

Apresentar classificações com justificativa.

Exemplo de saída do juiz LLM para uma tarefa de conteúdo:
```
RANK  AGENTE   VEREDICTO                                     CONTAGEM
1     agent-1  Narrativa forte, CTA claro                   1480
2     agent-3  Bons dados, introdução fraca                  1520
3     agent-2  Tom genérico, sem diferenciação               1350

Vencedor: agent-1 (arco narrativo mais forte e chamada para ação)
```

### Modo Híbrido

1. Executar avaliação por métrica primeiro
2. Se os melhores agentes estiverem dentro de 10% um do outro, usar juiz LLM para desempate
3. Apresentar classificações métricas e qualitativas

## Após a Avaliação

1. Atualizar estado da sessão:
```bash
python {skill_path}/scripts/session_manager.py --update {session-id} --state evaluating
```

2. Informar ao usuário:
   - Resultados classificados com o vencedor destacado
   - Próximo passo: `/hub:merge` para mergear o vencedor
   - Ou `/hub:merge {session-id} --agent {winner}` para ser explícito
