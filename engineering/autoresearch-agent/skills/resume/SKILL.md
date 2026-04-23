---
name: "resume"
description: "Retomar um experimento pausado. Faz checkout do branch do experimento, lê o histórico de resultados e continua iterando."
command: /ar:resume
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# /ar:resume — Retomar Experimento

Retomar um experimento pausado ou interrompido por limite de contexto. Lê todo o histórico e continua de onde parou.

## Uso

```
/ar:resume                                  # Listar experimentos, deixar usuário escolher
/ar:resume engineering/api-speed            # Retomar experimento específico
```

## O Que Faz

### Passo 1: Listar experimentos se necessário

Se nenhum experimento especificado:

```bash
python {skill_path}/scripts/setup_experiment.py --list
```

Mostrar status de cada um (ativo/pausado/concluído com base na idade do results.tsv). Deixar o usuário escolher.

### Passo 2: Carregar contexto completo

```bash
# Fazer checkout do branch do experimento
git checkout autoresearch/{domain}/{name}

# Ler configuração
cat .autoresearch/{domain}/{name}/config.cfg

# Ler estratégia
cat .autoresearch/{domain}/{name}/program.md

# Ler histórico completo de resultados
cat .autoresearch/{domain}/{name}/results.tsv

# Ler log git recente do branch
git log --oneline -20
```

### Passo 3: Reportar estado atual

Resumir para o usuário:

```
Retomando: engineering/api-speed
  Alvo: src/api/search.py
  Métrica: p50_ms (menor é melhor)
  Experimentos: 23 total — 8 mantidos, 12 descartados, 3 com crash
  Melhor: 185ms (-42% do baseline de 320ms)
  Último experimento: "added response caching" → KEEP (185ms)

  Padrões recentes:
  - Mudanças de cache: 3 mantidas, 1 descartada (consistentemente útil)
  - Mudanças de algoritmo: 2 descartadas, 1 com crash (alto risco, baixa recompensa até agora)
  - Otimização de I/O: 2 mantidas (direção promissora)
```

### Passo 4: Perguntar próxima ação

```
Como você gostaria de continuar?
  1. Iteração única (/ar:run)  — Farei uma mudança e avaliarei
  2. Iniciar um loop (/ar:loop)     — Autônomo com intervalo agendado
  3. Apenas mostrar os resultados    — Vou revisar e decidir
```

Se o usuário escolher loop, passar para `/ar:loop` com o experimento pré-selecionado.
Se escolher único, passar para `/ar:run`.
