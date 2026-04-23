---
name: "setup"
description: "Configurar um novo experimento de autoresearch de forma interativa. Coleta domínio, arquivo alvo, comando de avaliação, métrica, direção e avaliador."
command: /ar:setup
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# /ar:setup — Criar Novo Experimento

Configurar um novo experimento de autoresearch com toda a configuração necessária.

## Uso

```
/ar:setup                                    # Modo interativo
/ar:setup engineering api-speed src/api.py "pytest bench.py" p50_ms lower
/ar:setup --list                             # Mostrar experimentos existentes
/ar:setup --list-evaluators                  # Mostrar avaliadores disponíveis
```

## O Que Faz

### Se argumentos fornecidos

Passá-los diretamente ao script de setup:

```bash
python {skill_path}/scripts/setup_experiment.py \
  --domain {domain} --name {name} \
  --target {target} --eval "{eval_cmd}" \
  --metric {metric} --direction {direction} \
  [--evaluator {evaluator}] [--scope {scope}]
```

### Se sem argumentos (modo interativo)

Coletar cada parâmetro um de cada vez:

1. **Domínio** — Perguntar: "Qual domínio? (engineering, marketing, content, prompts, custom)"
2. **Nome** — Perguntar: "Nome do experimento? (ex.: api-speed, blog-titles)"
3. **Arquivo alvo** — Perguntar: "Qual arquivo otimizar?" Verificar se existe.
4. **Comando de avaliação** — Perguntar: "Como medir? (ex.: pytest bench.py, python evaluate.py)"
5. **Métrica** — Perguntar: "Qual métrica a avaliação gera? (ex.: p50_ms, ctr_score)"
6. **Direção** — Perguntar: "Menor ou maior é melhor?"
7. **Avaliador** (opcional) — Mostrar avaliadores embutidos. Perguntar: "Usar um avaliador embutido ou o seu próprio?"
8. **Escopo** — Perguntar: "Armazenar no projeto (.autoresearch/) ou no usuário (~/.autoresearch/)?"

Então executar `setup_experiment.py` com os parâmetros coletados.

### Listagem

```bash
# Mostrar experimentos existentes
python {skill_path}/scripts/setup_experiment.py --list

# Mostrar avaliadores disponíveis
python {skill_path}/scripts/setup_experiment.py --list-evaluators
```

## Avaliadores Embutidos

| Nome | Métrica | Caso de Uso |
|------|--------|----------|
| `benchmark_speed` | `p50_ms` (menor) | Tempo de execução de função/API |
| `benchmark_size` | `size_bytes` (menor) | Tamanho de arquivo, bundle, imagem Docker |
| `test_pass_rate` | `pass_rate` (maior) | Percentual de aprovação da suite de testes |
| `build_speed` | `build_seconds` (menor) | Tempo de build/compilação/Docker build |
| `memory_usage` | `peak_mb` (menor) | Pico de memória durante execução |
| `llm_judge_content` | `ctr_score` (maior) | Headlines, títulos, descrições |
| `llm_judge_prompt` | `quality_score` (maior) | System prompts, instruções de agentes |
| `llm_judge_copy` | `engagement_score` (maior) | Posts para redes sociais, copy de anúncios, emails |

## Após o Setup

Reportar ao usuário:
- Caminho do experimento e nome do branch
- Se o comando de avaliação funcionou e a métrica de baseline
- Sugerir: "Execute `/ar:run {domain}/{name}` para começar a iterar, ou `/ar:loop {domain}/{name}` para o modo autônomo."
