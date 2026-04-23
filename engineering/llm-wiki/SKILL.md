---
name: llm-wiki
description: Use quando estiver construindo ou mantendo uma base de conhecimento pessoal persistente (segundo cérebro) no Obsidian, onde um LLM ingere fontes de forma incremental, atualiza páginas de entidades/conceitos, mantém referências cruzadas e mantém uma síntese atualizada. Gatilhos incluem "segundo cérebro", "wiki no Obsidian", "gestão de conhecimento pessoal", "ingerir este paper/artigo/livro", "construir um wiki de pesquisa", "conhecimento acumulado", "Memex", ou sempre que o usuário quiser que o conhecimento se acumule entre sessões em vez de ser redescoberto por RAG a cada consulta.
context: fork
version: 1.0.0
author: Ric Neves - Flowgrammers
license: MIT
tags: [knowledge-management, obsidian, second-brain, pkm, rag-alternative, wiki, karpathy, memex]
agents:
  - claude-code
---

# LLM Wiki — Segundo Cérebro para Claude Code + Obsidian

Inspirado no padrão LLM Wiki de Andrej Karpathy ([gist](https://gist.github.com/karpathy/442a6bf555914893e9891c11519de94f)). Esta skill transforma o Claude Code em um mantenedor disciplinado de wiki que **constrói e mantém incrementalmente** um vault Obsidian persistente e interligado à medida que você alimenta fontes. O conhecimento se acumula — referências cruzadas, contradições e sínteses já estão lá quando você consulta.

## Princípio central

A maioria dos fluxos de trabalho LLM+docs é **RAG**: recupere fragmentos no momento da consulta, sintetize do zero, esqueça. O wiki é **acumulativo**: as fontes são lidas uma vez, integradas em uma base de conhecimento markdown persistente e mantidas atualizadas. Você curada e pergunta; o LLM lê, arquiva, faz referências cruzadas e mantém.

> O Obsidian é a IDE. O LLM é o programador. O wiki é a base de código.

## Quando usar

- **Pessoal**: rastrear objetivos, saúde, psicologia, diário, autodesenvolvimento
- **Pesquisa**: análises aprofundadas ao longo de semanas sobre um tema — papers, artigos, relatórios, tese em evolução
- **Companheiro de livro**: arquive capítulos à medida que lê; construa um companheiro estilo fan-wiki para personagens, temas, linhas de enredo
- **Negócios/equipe**: wiki interno alimentado por Slack, notas de reunião, chamadas — LLM faz a manutenção que ninguém quer fazer
- **Análise competitiva, due diligence, planejamento de viagens, notas de curso, hobbies profundos**

**NÃO use quando:** você precisa de Q&A pontual sobre um documento fixo (use RAG), não planeja adicionar fontes ao longo do tempo, ou não quer o Obsidian no fluxo.

## Arquitetura (três camadas)

```
vault/
├── raw/                    # Camada 1 — IMUTÁVEL fonte da verdade
│   ├── <arquivos de fonte> # Artigos, papers, PDFs, imagens, dados
│   └── assets/             # Imagens baixadas de artigos clonados
├── wiki/                   # Camada 2 — base de conhecimento do LLM
│   ├── index.md            # Catálogo de conteúdo (LLM atualiza a cada ingestão)
│   ├── log.md              # Linha do tempo append-only (## [AAAA-MM-DD] <op> | <título>)
│   ├── entities/           # Páginas de Pessoa/Org/Local
│   ├── concepts/           # Ideias, teorias, frameworks
│   ├── sources/            # Uma página de resumo por fonte ingerida
│   ├── comparisons/        # Páginas de análise entre fontes
│   └── synthesis/          # Sínteses de alto nível, teses, visões gerais
├── CLAUDE.md               # Esquema + convenções (Claude Code)
└── AGENTS.md               # Mesmo conteúdo, para outros agentes
```

- **Camada 1 (raw/)** — você é o dono. O LLM apenas lê; nunca escreve.
- **Camada 2 (wiki/)** — o LLM é o dono. Ele cria, atualiza e faz referências cruzadas de páginas. Você a lê.
- **Camada 3 (CLAUDE.md / AGENTS.md)** — o *esquema*. Convenções, fluxos de trabalho, regras de frontmatter. Co-evoluído por você e o LLM.

## Três operações principais

1. **Ingestão** — LLM lê uma fonte, discute os insights com você, escreve um resumo da fonte, atualiza 10-15 páginas relevantes, atualiza o índice, adiciona ao log. Veja `references/ingest-workflow.md`.
2. **Consulta** — LLM lê `index.md` primeiro, aprofunda nas páginas relevantes, sintetiza com citações. Boas respostas são **arquivadas de volta no wiki** para que as explorações se acumulem. Veja `references/query-workflow.md`.
3. **Lint** — Verificação de saúde: contradições, afirmações desatualizadas, páginas órfãs, referências cruzadas ausentes, conceitos mencionados mas sem página própria, lacunas de dados a preencher com busca na web. Veja `references/lint-workflow.md`.

## Início rápido

```bash
# 1. Inicializar um vault (no diretório do vault do Obsidian)
python scripts/init_vault.py --path ~/vaults/research --topic "LLM interpretability"

# 2. Coloque uma fonte em raw/, depois ingira
/wiki-ingest ~/vaults/research/raw/anthropic-monosemanticity.pdf

# 3. Faça perguntas (respostas podem ser arquivadas de volta no wiki)
/wiki-query "como a monossemanticidade se compara à interpretabilidade mecanicista?"

# 4. Verificação periódica de saúde
/wiki-lint

# 5. Veja a linha do tempo
/wiki-log --last 10
```

## Slash commands (este plugin inclui)

| Comando | Propósito |
|---|---|
| `/wiki-init` | Inicializar um novo vault com arquivos de esquema + estrutura inicial |
| `/wiki-ingest <caminho>` | Ler uma fonte, discutir, atualizar o wiki, registrar |
| `/wiki-query <pergunta>` | Pesquisar no wiki, sintetizar resposta, oferecer arquivamento |
| `/wiki-lint` | Executar verificação de saúde — contradições, órfãos, afirmações desatualizadas, lacunas |
| `/wiki-log` | Mostrar entradas de log recentes (usa ferramentas unix em `log.md`) |

## Sub-agentes (este plugin inclui)

| Agente | Quando é despachado |
|---|---|
| `wiki-ingestor` | Fluxo de ingestão delegado — lê a fonte, propõe atualizações, aplica após sua aprovação |
| `wiki-linter` | Executa o fluxo de trabalho de verificação de saúde de forma independente, relata achados |
| `wiki-librarian` | Responde consultas usando busca index-first, sintetiza com citações |

## Ferramentas Python (`scripts/`)

Todas as ferramentas usam **apenas biblioteca padrão** (sem instalações pip). Execute com `python scripts/<tool>.py --help`.

| Script | Propósito |
|---|---|
| `init_vault.py` | Criar estrutura de pastas + semear CLAUDE.md, AGENTS.md, index.md, log.md |
| `ingest_source.py` | Auxiliar: extrair texto/frontmatter de um arquivo fonte, pronto para revisão do LLM |
| `update_index.py` | Regenerar `index.md` a partir do frontmatter das páginas do wiki (categoria, data, contagem de fontes) |
| `append_log.py` | Adicionar uma entrada de log padronizada `## [AAAA-MM-DD] <op> \| <título>` |
| `wiki_search.py` | Busca BM25 sobre páginas do wiki (fallback autônomo quando index.md não é suficiente) |
| `lint_wiki.py` | Encontrar órfãos (sem links de entrada), páginas desatualizadas, referências cruzadas ausentes, links quebrados |
| `graph_analyzer.py` | Computar estatísticas do grafo de links — hubs, órfãos, clusters, componentes desconectados |
| `export_marp.py` | Renderizar uma página do wiki (ou subárvore) para um slide deck Marp |

## Compatibilidade entre ferramentas

O **esquema** do vault fica em CLAUDE.md (Claude Code) ou AGENTS.md (outros agentes). O mesmo conteúdo funciona em ambos. Este plugin inclui ambos os templates.

```
CLAUDE.md       → Claude Code
AGENTS.md       → outros agentes CLI
```

Os scripts são Python puro stdlib → executam de forma idêntica em qualquer lugar. Apenas o arquivo de carregamento muda por ferramenta.

## Configuração do Obsidian (recomendada)

- **Obsidian Web Clipper** — extensão de navegador; converte artigos da web para markdown e os deposita em `raw/`
- **Baixar imagens localmente** — Configurações → Arquivos e links → Caminho da pasta de anexos = `raw/assets/`. Configurações → Atalhos de teclado → vincule "Baixar anexos do arquivo atual" a `Ctrl+Shift+D`
- **Visão de grafo** — veja hubs/órfãos; essencial para detectar problemas estruturais
- **Plugin Marp** — slide decks baseados em Markdown diretamente das páginas do wiki
- **Plugin Dataview** — tabelas/listas dinâmicas sobre frontmatter das páginas (tags, datas, contagens de fontes)
- **Git** — o vault é um repositório markdown simples; versione-o

Guia completo de configuração: `references/obsidian-setup.md`

## Por que isso funciona (vs. RAG simples)

| RAG Simples | LLM Wiki |
|---|---|
| Redescobre o conhecimento a cada consulta | O conhecimento se acumula |
| Referências cruzadas recomputadas toda vez | Referências cruzadas pré-escritas e mantidas |
| Contradições surgem apenas se você perguntar | Contradições sinalizadas durante a ingestão |
| Explorações desaparecem no histórico de chat | Boas respostas arquivadas como novas páginas |
| Escala por infraestrutura de embeddings | Escala por markdown + `index.md` + busca local opcional |

Em ~100 fontes / centenas de páginas, `index.md` + busca no sistema de arquivos é suficiente. Além disso, adicione uma ferramenta de busca local como [qmd](https://github.com/tobi/qmd) ou use `scripts/wiki_search.py`.

## Skills relacionadas (encadeiam via `context: fork`)

Esta skill está marcada com `context: fork` para que outras skills possam encadeá-la:

- **`para-memory-files`** — memória pelo método PARA; complementar como memória pessoal de longo prazo que alimenta fontes no wiki
- **`obsidian-vault`** (mattpocock) — auxiliar leve do Obsidian; esta skill é a camada de wiki mantida no topo
- **`rag-design`** — quando o wiki ultrapassa ~500 páginas, use rag-design para adicionar uma camada de recuperação
- **`mcp-design`** — expor o wiki como uma ferramenta MCP
- **`agent-communication`** — para manutenção multi-agente do wiki (ingestor + linter + librarian)

## Documentos de referência

- `references/wiki-schema.md` — layout completo do vault, frontmatter de páginas, convenções de nomes
- `references/page-formats.md` — templates de entidade, conceito, fonte, comparação, síntese
- `references/ingest-workflow.md` — o fluxo de ingestão detalhado que o agente wiki-ingestor segue
- `references/query-workflow.md` — padrões de consulta, formato de citação, arquivamento de respostas
- `references/lint-workflow.md` — heurísticas de verificação de saúde
- `references/obsidian-setup.md` — plugins do Obsidian, atalhos de teclado, configuração do vault
- `references/cross-tool-setup.md` — configuração por ferramenta
- `references/memex-principles.md` — o Memex de Bush, por que o LLM muda a matemática de manutenção

## Templates (`assets/`)

- `CLAUDE.md.template`, `AGENTS.md.template` — carregadores de esquema por ferramenta
- `index.md.template`, `log.md.template` — índice e log iniciais
- `page-templates/` — entidade, conceito, resumo de fonte, comparação, síntese
- `example-vault/` — pequeno exemplo trabalhado que você pode estudar ou copiar

## Regra de ferro

**O LLM nunca edita arquivos em `raw/`.** Jamais. As fontes são imutáveis. Todas as escritas do LLM vão para `wiki/`. Se você precisar corrigir uma fonte, faça isso em `raw/` você mesmo — depois reingestione.
