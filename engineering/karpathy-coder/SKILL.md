---
name: karpathy-coder
description: Use quando escrever, revisar ou commitar código para aplicar os 4 princípios de codificação de Karpathy — explicite suposições antes de codificar, mantenha simples, faça mudanças cirúrgicas, defina objetivos verificáveis. Gatilhos em "revise meu diff", "verifique complexidade", "estou complicando demais?", "karpathy check", "antes de commitar", ou qualquer preocupação de qualidade de código onde o LLM possa estar sobrecodificando.
context: fork
version: 2.3.0
author: Ric Neves - Flowgrammers
license: MIT
tags: [code-quality, discipline, karpathy, simplicity, surgical-changes, anti-patterns, review]
agents:
  - claude-code
---

# Karpathy Coder — Disciplina Ativa de Codificação

Derivado das [observações de Andrej Karpathy](https://x.com/karpathy/status/2015883857489522876) sobre armadilhas de codificação de LLM. Isso **não são apenas diretrizes** — inclui ferramentas Python que detectam violações, um agente de revisão, um slash command e um hook pré-commit.

> "Os modelos fazem suposições erradas em seu nome e simplesmente as seguem sem verificar. Eles não gerenciam sua confusão, não buscam esclarecimentos, não identificam inconsistências, não apresentam trade-offs, não se opõem quando deveriam."
>
> "Eles realmente gostam de complicar código e APIs, inflar abstrações, não limpar código morto... implementar uma construção inflada em mais de 1000 linhas quando 100 seriam suficientes."
>
> "LLMs são excepcionalmente bons em fazer loops até atingirem objetivos específicos... Não diga o que fazer, dê critérios de sucesso e observe."
>
> — Andrej Karpathy

## Os quatro princípios

### 1. Pense Antes de Codificar

**Não assuma. Não esconda confusão. Explicite trade-offs.**

- Declare suposições explicitamente. Se incerto, pergunte.
- Se existirem múltiplas interpretações, apresente-as — não escolha silenciosamente.
- Se uma abordagem mais simples existir, diga. Oponha-se quando justificado.
- Se algo for pouco claro, pare. Nomeie o que é confuso. Pergunte.

### 2. Simplicidade Primeiro

**Código mínimo que resolve o problema. Nada especulativo.**

- Sem funcionalidades além do que foi solicitado.
- Sem abstrações para código de uso único.
- Sem "flexibilidade" ou "configurabilidade" que não foi solicitada.
- Sem tratamento de erro para cenários impossíveis.
- Se você escrever 200 linhas e puderem ser 50, reescreva.

**O teste:** Um engenheiro sênior diria que isso está supercomplexo? Se sim, simplifique.

### 3. Mudanças Cirúrgicas

**Toque apenas no que é necessário. Limpe apenas sua própria bagunça.**

- Não "melhore" código adjacente, comentários ou formatação.
- Não refatore coisas que não estão quebradas.
- Combine o estilo existente, mesmo que você faria diferente.
- Se você notar código morto não relacionado, mencione — não exclua.
- Remova imports/variáveis/funções que SUAS mudanças tornaram não utilizadas.
- Não remova código morto pré-existente a menos que solicitado.

**O teste:** Cada linha alterada deve rastrear diretamente para a solicitação do usuário.

### 4. Execução Orientada por Objetivo

**Defina critérios de sucesso. Faça loop até verificado.**

| Em vez de... | Transforme para... |
|---|---|
| "Adicione validação" | "Escreva testes para entradas inválidas, então faça-os passar" |
| "Corrija o bug" | "Escreva um teste que o reproduz, então faça-o passar" |
| "Refatore X" | "Garanta que os testes passem antes e depois" |

Para tarefas com múltiplos passos, declare um plano breve:

```
1. [Passo] → verificar: [checagem]
2. [Passo] → verificar: [checagem]
3. [Passo] → verificar: [checagem]
```

## Slash command

`/karpathy-check` — Execute a revisão completa dos 4 princípios em suas mudanças staged.

## Ferramentas Python (`scripts/`)

Todas as ferramentas são somente stdlib. Execute com `--help`.

| Script | O que detecta |
|---|---|
| `complexity_checker.py` | Excesso de engenharia: muitas classes, aninhamento profundo, alta complexidade ciclomática, parâmetros não usados, abstrações prematuras |
| `diff_surgeon.py` | Ruído de diff: linhas que não rastreiam para o objetivo declarado — mudanças de comentário, drift de estilo, refatorações por impulso |
| `assumption_linter.py` | Suposições ocultas em um plano: funcionalidades não solicitadas, esclarecimentos ausentes, escolhas de interpretação silenciosas |
| `goal_verifier.py` | Critérios de sucesso fracos: planos vagos sem checagens verificáveis, asserções de teste ausentes |

## Sub-agente

`karpathy-reviewer` — Executa todos os 4 princípios contra um diff. Despachado por `/karpathy-check` ou manualmente antes de commitar.

## Hook pré-commit

`hooks/karpathy-gate.sh` — executa `complexity_checker.py` e `diff_surgeon.py` em arquivos staged. Avisa (não bloqueante) quando violações são encontradas. Conecte via `.claude/settings.json` ou Husky.

## Referências

- `references/karpathy-principles.md` — as citações fonte, contexto mais profundo, quando relaxar cada princípio
- `references/anti-patterns.md` — 10+ exemplos antes/depois em Python, TypeScript e shell
- `references/enforcement-patterns.md` — como conectar hooks, integração CI, adoção pela equipe

## Quando relaxar

Estes princípios tendem para **cautela sobre velocidade**. Para tarefas triviais (correções de typo, one-liners óbvios), use o julgamento. Os princípios importam mais em:

- Implementações não triviais (>20 linhas alteradas)
- Código que você não entende completamente
- Tarefas com múltiplos passos com requisitos pouco claros
- Qualquer coisa que será revisada por humanos

## Compatibilidade com ferramentas

Instale via plugin para Claude Code. Para outras ferramentas, copie os princípios para seu arquivo de schema:

| Ferramenta | Arquivo de schema |
|---|---|
| Claude Code | `CLAUDE.md` (carregado automaticamente pelo plugin) |

## Skills relacionadas (encadeadas via `context: fork`)

- **`self-eval`** — pontuação honesta de qualidade após concluir o trabalho
- **`code-reviewer`** — revisão de código mais ampla; karpathy-coder foca nas 4 armadilhas específicas de LLM
- **`llm-wiki`** — conhecimento composto; karpathy-coder garante que você não complique demais ao construí-lo
