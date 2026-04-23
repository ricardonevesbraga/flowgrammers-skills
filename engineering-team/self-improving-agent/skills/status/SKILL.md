---
name: "status"
description: "Painel de saúde da memória mostrando contagens de linhas, arquivos por tópico, capacidade, entradas desatualizadas e recomendações."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# /si:status — Painel de Saúde da Memória

Visão geral rápida do estado da memória do seu projeto em todos os sistemas de memória.

## Uso

```
/si:status                    # Painel completo
/si:status --brief            # Resumo em uma linha
```

## O que Reporta

### Passo 1: Localizar todos os arquivos de memória

```bash
# Diretório de auto-memória
MEMORY_DIR="$HOME/.claude/projects/$(pwd | sed 's|/|%2F|g; s|%2F|/|; s|^/||')/memory"

# Contar linhas no MEMORY.md
wc -l "$MEMORY_DIR/MEMORY.md" 2>/dev/null || echo "0"

# Listar arquivos por tópico
ls "$MEMORY_DIR/"*.md 2>/dev/null | grep -v MEMORY.md

# CLAUDE.md
wc -l ./CLAUDE.md 2>/dev/null || echo "0"
wc -l ~/.claude/CLAUDE.md 2>/dev/null || echo "0"

# Diretório de regras
ls .claude/rules/*.md 2>/dev/null | wc -l
```

### Passo 2: Analisar capacidade

| Métrica | Saudável | Atenção | Crítico |
|--------|---------|---------|----------|
| Linhas MEMORY.md | < 120 | 120-180 | > 180 |
| Linhas CLAUDE.md | < 150 | 150-200 | > 200 |
| Arquivos por tópico | 0-3 | 4-6 | > 6 |
| Entradas desatualizadas | 0 | 1-3 | > 3 |

### Passo 3: Verificação rápida de desatualização

Para cada entrada no MEMORY.md que referencia um caminho de arquivo:
```bash
# Verificar se os arquivos referenciados ainda existem
grep -oE '[a-zA-Z0-9_/.-]+\.(ts|js|py|md|json|yaml|yml)' "$MEMORY_DIR/MEMORY.md" | while read f; do
  [ ! -f "$f" ] && echo "DESATUALIZADO: $f"
done
```

### Passo 4: Saída

```
Status da Memória

  Auto-Memória (MEMORY.md):
    Linhas:        {{n}}/200 ({{bar}}) {{emoji}}
    Arquivos por tópico: {{count}} ({{names}})
    Última atualização: {{date}}

  Regras do Projeto:
    CLAUDE.md:    {{n}} linhas
    Regras:        {{count}} arquivos em .claude/rules/
    Global do usuário: {{n}} linhas (~/.claude/CLAUDE.md)

  Saúde:
    Capacidade:     {{saudável/atenção/crítico}}
    Referências desatualizadas: {{count}} (arquivos que não existem mais)
    Duplicatas:   {{count}} (entradas repetidas entre arquivos)

  {{se recomendações}}
  Recomendações:
    - {{recomendação}}
  {{fim se}}
```

### Modo resumido

```
/si:status --brief
```

Saída: `Memória: {{n}}/200 linhas | {{count}} regras | {{status_emoji}} {{status_word}}`

## Interpretação

- **Verde (< 60%)**: Espaço suficiente. A auto-memória está funcionando bem.
- **Amarelo (60-90%)**: Ficando cheia. Considere executar `/si:review` para promover ou limpar.
- **Vermelho (> 90%)**: Perto da capacidade. A auto-memória pode começar a descartar entradas mais antigas. Execute `/si:review` agora.

## Dicas

- Execute `/si:status --brief` como uma verificação rápida a qualquer momento
- Se a capacidade estiver amarela+, execute `/si:review` para identificar candidatos a promoção
- Entradas desatualizadas desperdiçam espaço — exclua referências a arquivos que não existem mais
- Arquivos por tópico são normais — o Claude os cria para manter o MEMORY.md abaixo de 200 linhas
