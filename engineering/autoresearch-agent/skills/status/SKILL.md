---
name: "status"
description: "Mostrar painel de experimentos com resultados, loops ativos e progresso."
command: /ar:status
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# /ar:status — Painel de Experimentos

Mostrar resultados de experimentos, loops ativos e progresso em todos os experimentos.

## Uso

```
/ar:status                                  # Painel completo
/ar:status engineering/api-speed            # Detalhe de experimento único
/ar:status --domain engineering             # Todos os experimentos em um domínio
/ar:status --format markdown                # Exportar como markdown
/ar:status --format csv --output results.csv  # Exportar como CSV
```

## O Que Faz

### Experimento único

```bash
python {skill_path}/scripts/log_results.py --experiment {domain}/{name}
```

Também verificar loop ativo:
```bash
cat .autoresearch/{domain}/{name}/loop.json 2>/dev/null
```

Se loop.json existir, mostrar:
```
Loop ativo: a cada {interval} (cron ID: {id}, iniciado: {date})
```

### Visão de domínio

```bash
python {skill_path}/scripts/log_results.py --domain {domain}
```

### Painel completo

```bash
python {skill_path}/scripts/log_results.py --dashboard
```

Para cada experimento, também verificar loop.json e mostrar status do loop.

### Exportar

```bash
# CSV
python {skill_path}/scripts/log_results.py --dashboard --format csv --output {file}

# Markdown
python {skill_path}/scripts/log_results.py --dashboard --format markdown --output {file}
```

## Exemplo de Saída

```
DOMÍNIO         EXPERIMENTO         EXEC  MANTIDOS  MELHOR       MUDANÇA   STATUS   LOOP
engineering     api-speed            47    14   185ms        -76.9%    active   a cada 1h
engineering     bundle-size          23     8   412KB        -58.3%    paused   —
marketing       medium-ctr           31    11   8.4/10       +68.0%    active   diário
prompts         support-tone         15     6   82/100       +46.4%    done     —
```
