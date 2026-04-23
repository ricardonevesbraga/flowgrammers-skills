---
name: "agenthub"
description: "Plugin de colaboração multi-agente que lança N subagentes paralelos competindo na mesma tarefa via isolamento por git worktree. Os agentes trabalham de forma independente, os resultados são avaliados por métrica ou juiz LLM, e o melhor branch é mergeado. Use quando: o usuário quer múltiplas abordagens testadas em paralelo — otimização de código, variação de conteúdo, exploração de pesquisa ou qualquer tarefa que se beneficie de competição paralela. Requer: um repositório git."
license: MIT
metadata:
  version: 2.1.2
  author: Ric Neves - Flowgrammers
  category: engineering
  updated: 2026-03-17
agents:
  - claude-code
---

# AgentHub — Colaboração Multi-Agente

Lance N agentes de IA em paralelo que competem na mesma tarefa. Cada agente trabalha em um git worktree isolado. O coordenador avalia os resultados e mergea o vencedor.

## Slash Commands

| Comando | Descrição |
|---------|-------------|
| `/hub:init` | Criar uma nova sessão de colaboração — tarefa, número de agentes, critérios de avaliação |
| `/hub:spawn` | Lançar N subagentes paralelos em worktrees isolados |
| `/hub:status` | Mostrar estado do DAG, progresso dos agentes, status dos branches |
| `/hub:eval` | Classificar resultados dos agentes por métrica ou juiz LLM |
| `/hub:merge` | Mergear o branch vencedor, arquivar os perdedores |
| `/hub:board` | Ler/escrever no quadro de mensagens dos agentes |
| `/hub:run` | Ciclo de vida completo: init → baseline → spawn → eval → merge |

## Templates de Agentes

Ao usar `--template` no spawn, os agentes seguem um padrão de iteração predefinido:

| Template | Padrão | Caso de Uso |
|----------|---------|----------|
| `optimizer` | Editar → avaliar → manter/descartar → repetir x10 | Desempenho, latência, tamanho |
| `refactorer` | Reestruturar → testar → iterar até verde | Qualidade de código, dívida técnica |
| `test-writer` | Escrever testes → medir cobertura → repetir | Lacunas de cobertura de testes |
| `bug-fixer` | Reproduzir → diagnosticar → corrigir → verificar | Abordagens de correção de bugs |

Templates são definidos em `references/agent-templates.md`.

## Quando Esta Skill É Ativada

Frases de gatilho:
- "tente múltiplas abordagens"
- "faça os agentes competirem"
- "otimização paralela"
- "lance N agentes"
- "compare diferentes soluções"
- "fan-out" ou "torneio"
- "gere variações de conteúdo"
- "compare diferentes rascunhos"
- "teste A/B de copy"
- "explore múltiplas estratégias"

## Protocolo do Coordenador

A sessão principal do Claude Code é o coordenador. Ele segue este ciclo de vida:

```
INIT → DISPATCH → MONITOR → EVALUATE → MERGE
```

### 1. Init

Execute `/hub:init` para criar uma sessão. Isso gera:
- `.agenthub/sessions/{session-id}/config.yaml` — configuração da tarefa
- `.agenthub/sessions/{session-id}/state.json` — máquina de estados
- `.agenthub/board/` — canais do quadro de mensagens

### 2. Dispatch

Execute `/hub:spawn` para lançar os agentes. Para cada agente 1..N:
- Postar atribuição de tarefa em `.agenthub/board/dispatch/`
- Lançar via ferramenta Agent com `isolation: "worktree"`
- Todos os agentes lançados em uma única mensagem (paralelo)

### 3. Monitor

Execute `/hub:status` para verificar o progresso:
- `dag_analyzer.py --status --session {id}` mostra o estado dos branches
- Canal `progress/` do board tem atualizações dos agentes

### 4. Evaluate

Execute `/hub:eval` para classificar os resultados:
- **Modo Métrica**: executar comando de avaliação em cada worktree, analisar resultado numérico
- **Modo Juiz**: ler diffs, coordenador classifica por qualidade
- **Híbrido**: métrica primeiro, juiz LLM para empates

### 5. Merge

Execute `/hub:merge` para finalizar:
- `git merge --no-ff` do vencedor no branch base
- Arquivar perdedores: `git tag hub/archive/{session}/agent-{i}`
- Limpar worktrees
- Postar resumo do merge no board

## Protocolo do Agente

Cada subagente recebe este padrão de prompt:

```
You are agent-{i} in hub session {session-id}.
Your task: {task description}

Instructions:
1. Read your assignment at .agenthub/board/dispatch/{seq}-agent-{i}.md
2. Work in your worktree — make changes, run tests, iterate
3. Commit all changes with descriptive messages
4. Write your result summary to .agenthub/board/results/agent-{i}-result.md
5. Exit when done
```

Os agentes NÃO veem o trabalho uns dos outros. Eles NÃO se comunicam entre si. Eles apenas escrevem no board para o coordenador ler.

## Modelo DAG

### Nomenclatura de Branches

```
hub/{session-id}/agent-{N}/attempt-{M}
```

- Session ID: baseado em timestamp (`YYYYMMDD-HHMMSS`)
- Agente N: sequencial (1 até agent-count)
- Tentativa M: incrementa em retry (geralmente 1)

### Detecção de Fronteira

Fronteira = pontas de branch sem branches filhos. Equivalente à consulta "leaves" do AgentHub.

```bash
python scripts/dag_analyzer.py --frontier --session {id}
```

### Imutabilidade

O DAG é somente-de-adição:
- Nunca faça rebase ou force-push nos branches dos agentes
- Nunca exclua commits (apenas refs de branch após arquivamento)
- Cada abordagem preservada via git tags

## Quadro de Mensagens

Localização: `.agenthub/board/`

### Canais

| Canal | Quem Escreve | Quem Lê | Propósito |
|---------|--------|--------|---------|
| `dispatch/` | Coordenador | Agentes | Atribuições de tarefas |
| `progress/` | Agentes | Coordenador | Atualizações de status |
| `results/` | Agentes + Coordenador | Todos | Resultados finais + resumo do merge |

### Formato das Postagens

```markdown
---
author: agent-1
timestamp: 2026-03-17T14:30:22Z
channel: results
parent: null
---

## Resumo do Resultado

- **Abordagem**: Substituição de ordenação O(n²) por hash map
- **Arquivos alterados**: 3
- **Métrica**: 142ms (baseline: 180ms, delta: -38ms)
- **Confiança**: Alta — todos os testes passando
```

### Regras do Board

- Somente adição: nunca edite ou exclua postagens
- Nomes de arquivo únicos: `{seq:03d}-{author}-{timestamp}.md`
- Frontmatter YAML obrigatório em todas as postagens

## Modos de Avaliação

### Baseado em Métrica

Melhor para: benchmarks, taxas de aprovação em testes, tamanhos de arquivo, tempos de resposta.

```bash
python scripts/result_ranker.py --session {id} \
  --eval-cmd "pytest bench.py --json" \
  --metric p50_ms --direction lower
```

O ranker executa o comando de avaliação no diretório de worktree de cada agente e analisa a métrica do stdout.

### Juiz LLM

Melhor para: qualidade de código, legibilidade, decisões de arquitetura.

O coordenador lê o diff de cada agente (`git diff base...agent-branch`) e classifica por:
1. Correção (resolve a tarefa?)
2. Simplicidade (menos linhas alteradas é melhor)
3. Qualidade (execução limpa, boa estrutura)

### Híbrido

Execute a métrica primeiro. Se os melhores agentes estiverem dentro de 10% um do outro, use o juiz LLM para desempate.

## Ciclo de Vida da Sessão

```
init → running → evaluating → merged
                             → archived (se sem vencedor)
```

Transições de estado gerenciadas por `session_manager.py`:

| De | Para | Gatilho |
|------|----|---------|
| `init` | `running` | `/hub:spawn` concluído |
| `running` | `evaluating` | Todos os agentes retornaram |
| `evaluating` | `merged` | `/hub:merge` concluído |
| `evaluating` | `archived` | Sem vencedor / todos falharam |

## Gatilhos Proativos

O coordenador deve agir quando:

| Sinal | Ação |
|--------|--------|
| Todos os agentes travaram | Postar resumo de falha, sugerir retry com diferentes restrições |
| Sem melhoria sobre o baseline | Arquivar sessão, sugerir diferentes abordagens |
| Worktrees órfãos detectados | Executar `session_manager.py --cleanup {id}` |
| Sessão travada em `running` | Verificar board para progresso, considerar timeout |

## Instalação

```bash
# Copiar para o diretório de skills do Claude Code
cp -r engineering/agenthub ~/.claude/skills/agenthub

# Ou instalar via ClawHub
clawhub install agenthub
```

## Scripts

| Script | Propósito |
|--------|---------|
| `hub_init.py` | Inicializar estrutura `.agenthub/` e sessão |
| `dag_analyzer.py` | Detecção de fronteira, grafo DAG, status de branches |
| `board_manager.py` | CRUD do quadro de mensagens (canais, postagens, threads) |
| `result_ranker.py` | Classificar agentes por métrica ou qualidade de diff |
| `session_manager.py` | Máquina de estados da sessão e limpeza |

## Skills Relacionadas

- **autoresearch-agent** — Loop de otimização de agente único (use AgentHub quando quiser N agentes competindo)
- **self-improving-agent** — Agente auto-modificável (use AgentHub quando quiser competição externa)
- **git-worktree-manager** — Utilitários de git worktree (AgentHub usa worktrees internamente)
