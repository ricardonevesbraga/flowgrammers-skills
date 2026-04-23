---
name: "autoresearch-agent"
description: "Loop autônomo de experimentos que otimiza qualquer arquivo por uma métrica mensurável. Inspirado no autoresearch do Karpathy. O agente edita um arquivo alvo, executa uma avaliação fixa, mantém melhorias (git commit), descarta falhas (git reset) e faz loop indefinidamente. Use quando: o usuário quer otimizar velocidade de código, reduzir tamanho de bundle/imagem, melhorar taxa de aprovação em testes, otimizar prompts, melhorar qualidade de conteúdo (headlines, copy, CTR) ou executar qualquer loop de melhoria mensurável. Requer: um arquivo alvo, um comando de avaliação que gere uma métrica e um repositório git."
license: MIT
metadata:
  version: 2.0.0
  author: Ric Neves - Flowgrammers
  category: engineering
  updated: 2026-03-13
agents:
  - claude-code
---

# Autoresearch Agent

> Você dorme. O agente experimenta. Você acorda para os resultados.

Loop autônomo de experimentos inspirado no [autoresearch do Karpathy](https://github.com/karpathy/autoresearch). O agente edita um arquivo, executa uma avaliação fixa, mantém melhorias, descarta falhas e faz loop indefinidamente.

Não um palpite — cinquenta tentativas medidas, em acumulação.

---

## Slash Commands

| Comando | O que faz |
|---------|-------------|
| `/ar:setup` | Configurar um novo experimento de forma interativa |
| `/ar:run` | Executar uma única iteração de experimento |
| `/ar:loop` | Iniciar loop autônomo com intervalo configurável (10m, 1h, diário, semanal, mensal) |
| `/ar:status` | Mostrar painel e resultados |
| `/ar:resume` | Retomar um experimento pausado |

---

## Quando Esta Skill É Ativada

Reconheça estes padrões do usuário:

- "Deixe isso mais rápido / menor / melhor"
- "Otimize [arquivo] para [métrica]"
- "Melhore minhas [headlines / copy / prompts]"
- "Execute experimentos durante a noite"
- "Quero levar [métrica] de X para Y"
- Qualquer solicitação envolvendo: otimizar, benchmark, melhorar, loop de experimento, autoresearch

Se o usuário descreve um arquivo alvo + uma forma de medir o sucesso → esta skill se aplica.

---

## Configuração

### Primeira Vez — Criar o Experimento

Execute o script de setup. O usuário decide onde os experimentos ficam:

**Nível do projeto** (dentro do repo, rastreado pelo git, compartilhável com a equipe):
```bash
python scripts/setup_experiment.py \
  --domain engineering \
  --name api-speed \
  --target src/api/search.py \
  --eval "pytest bench.py --tb=no -q" \
  --metric p50_ms \
  --direction lower \
  --scope project
```

**Nível do usuário** (pessoal, em `~/.autoresearch/`):
```bash
python scripts/setup_experiment.py \
  --domain marketing \
  --name medium-ctr \
  --target content/titles.md \
  --eval "python evaluate.py" \
  --metric ctr_score \
  --direction higher \
  --evaluator llm_judge_content \
  --scope user
```

O flag `--scope` determina onde `.autoresearch/` fica:
- `project` (padrão) → `.autoresearch/` na raiz do repo. Definições de experimento são rastreadas pelo git. Resultados são gitignored.
- `user` → `~/.autoresearch/` no diretório home. Tudo é pessoal.

### O que o Setup Cria

```
.autoresearch/
├── config.yaml                        ← Configurações globais
├── .gitignore                         ← Ignora results.tsv, *.log
└── {domain}/{experiment-name}/
    ├── program.md                     ← Objetivos, restrições, estratégia
    ├── config.cfg                     ← Alvo, cmd de eval, métrica, direção
    ├── results.tsv                    ← Log de experimentos (gitignored)
    └── evaluate.py                    ← Script de avaliação (se --evaluator usado)
```

**Colunas do results.tsv:** `commit | metric | status | description`
- `commit` — hash git curto
- `metric` — valor float ou "N/A" para falhas
- `status` — keep | discard | crash
- `description` — o que mudou ou por que falhou

### Domínios

| Domínio | Casos de Uso |
|--------|-----------|
| `engineering` | Velocidade de código, memória, tamanho de bundle, taxa de aprovação em testes, tempo de build |
| `marketing` | Headlines, copy para redes sociais, assuntos de email, copy de anúncios, engajamento |
| `content` | Estrutura de artigos, descrições SEO, legibilidade, CTR |
| `prompts` | System prompts, tom de chatbot, instruções de agentes |
| `custom` | Qualquer outra coisa com uma métrica mensurável |

### Se `program.md` Já Existir

O usuário pode ter escrito seu próprio `program.md`. Se encontrado no diretório do experimento, lê-lo. Ele substitui o template. Perguntar apenas o que estiver faltando.

---

## Protocolo do Agente

Você é o loop. Os scripts cuidam da configuração e avaliação — você cuida do trabalho criativo.

### Antes de Começar
1. Ler `.autoresearch/{domain}/{name}/config.cfg` para obter:
   - `target` — o arquivo que você edita
   - `evaluate_cmd` — o comando que mede suas mudanças
   - `metric` — o nome da métrica a procurar na saída do eval
   - `metric_direction` — "lower" ou "higher" é melhor
   - `time_budget_minutes` — tempo máximo por avaliação
2. Ler `program.md` para estratégia, restrições e o que pode/não pode mudar
3. Ler `results.tsv` para histórico de experimentos (colunas: commit, metric, status, description)
4. Fazer checkout do branch do experimento: `git checkout autoresearch/{domain}/{name}`

### Cada Iteração
1. Revisar results.tsv — o que funcionou? O que falhou? O que ainda não foi tentado?
2. Decidir UMA mudança no arquivo alvo. Uma variável por experimento.
3. Editar o arquivo alvo
4. Commit: `git add {target} && git commit -m "experiment: {description}"`
5. Avaliar: `python scripts/run_experiment.py --experiment {domain}/{name} --single`
6. Ler a saída — imprime KEEP, DISCARD ou CRASH com o valor da métrica
7. Ir ao passo 1

### O que o Script Lida (você não precisa)
- Executar o comando de eval com timeout
- Analisar a métrica da saída do eval
- Comparar com o melhor anterior
- Reverter o commit em caso de falha (`git reset --hard HEAD~1`)
- Registrar o resultado em results.tsv

### Iniciando um Experimento

```bash
# Iteração única (o agente chama isso repetidamente)
python scripts/run_experiment.py --experiment engineering/api-speed --single

# Dry run (testar configuração antes de começar)
python scripts/run_experiment.py --experiment engineering/api-speed --dry-run
```

### Escalada de Estratégia
- Execuções 1-5: Frutos de baixo custo (melhorias óbvias, otimizações simples)
- Execuções 6-15: Exploração sistemática (variar um parâmetro por vez)
- Execuções 16-30: Mudanças estruturais (trocas de algoritmo, mudanças de arquitetura)
- Execuções 30+: Experimentos radicais (abordagens completamente diferentes)
- Se sem melhoria em 20+ execuções: atualizar seção de Estratégia do program.md

### Auto-Melhoria
Após cada 10 experimentos, revisar results.tsv para padrões. Atualizar a
seção de Estratégia do program.md com o que aprendeu (ex.: "mudanças de cache
consistentemente melhoram em 5-10%", "tentativas de refatoração nunca melhoram a métrica").
Iterações futuras se beneficiam desse conhecimento acumulado.

### Parando
- Executar até ser interrompido pelo usuário, limite de contexto atingido ou objetivo no program.md alcançado
- Antes de parar: garantir que results.tsv esteja atualizado
- No limite de contexto: a próxima sessão pode retomar — results.tsv e git log persistem

### Regras

- **Uma mudança por experimento.** Não mude 5 coisas de uma vez. Você não saberá o que funcionou.
- **Critério de simplicidade.** Uma pequena melhoria que adiciona complexidade feia não vale a pena. Igual desempenho com código mais simples é uma vitória. Remover código que obtém os mesmos resultados é o melhor resultado.
- **Nunca modificar o avaliador.** `evaluate.py` é a verdade fundamental. Modificá-lo invalida todas as comparações. Parada total se você se pegar fazendo isso.
- **Timeout.** Se uma execução exceder 2,5× o orçamento de tempo, mate-a e trate como crash.
- **Tratamento de crash.** Se for um erro de digitação ou import faltando, corrija e re-execute. Se a ideia está fundamentalmente quebrada, reverta, registre "crash", continue. 5 crashes consecutivos → pause e alerte.
- **Sem novas dependências.** Use apenas o que já está disponível no projeto.

---

## Avaliadores

Scripts de avaliação prontos para uso. Copiados no diretório do experimento durante o setup com `--evaluator`.

### Avaliadores Gratuitos (sem custo de API)

| Avaliador | Métrica | Caso de Uso |
|-----------|--------|----------|
| `benchmark_speed` | `p50_ms` (menor) | Tempo de execução de função/API |
| `benchmark_size` | `size_bytes` (menor) | Tamanho de arquivo, bundle, imagem Docker |
| `test_pass_rate` | `pass_rate` (maior) | Percentual de aprovação da suite de testes |
| `build_speed` | `build_seconds` (menor) | Tempo de build/compilação/Docker build |
| `memory_usage` | `peak_mb` (menor) | Pico de memória durante execução |

### Avaliadores Juiz LLM (usa sua assinatura)

| Avaliador | Métrica | Caso de Uso |
|-----------|--------|----------|
| `llm_judge_content` | `ctr_score` 0-10 (maior) | Headlines, títulos, descrições |
| `llm_judge_prompt` | `quality_score` 0-100 (maior) | System prompts, instruções de agentes |
| `llm_judge_copy` | `engagement_score` 0-10 (maior) | Posts para redes sociais, copy de anúncios, emails |

Juízes LLM chamam o Claude Code que o usuário já está executando. O prompt de avaliação está fixado dentro do `evaluate.py` — o agente não pode modificá-lo. Isso impede o agente de manipular seu próprio avaliador.

A assinatura existente do usuário cobre o custo:
- Claude Code Max → chamadas Claude ilimitadas para avaliação

### Avaliadores Personalizados

Se nenhum avaliador embutido servir, o usuário escreve seu próprio `evaluate.py`. Único requisito: deve imprimir `metric_name: value` no stdout.

```python
#!/usr/bin/env python3
# Meu avaliador personalizado — NÃO MODIFICAR após iniciar o experimento
import subprocess
result = subprocess.run(["my-benchmark", "--json"], capture_output=True, text=True)
# Analisar e gerar saída
print(f"my_metric: {parse_score(result.stdout)}")
```

---

## Visualizando Resultados

```bash
# Experimento único
python scripts/log_results.py --experiment engineering/api-speed

# Todos os experimentos em um domínio
python scripts/log_results.py --domain engineering

# Painel de múltiplos experimentos
python scripts/log_results.py --dashboard

# Formatos de exportação
python scripts/log_results.py --experiment engineering/api-speed --format csv --output results.csv
python scripts/log_results.py --experiment engineering/api-speed --format markdown --output results.md
python scripts/log_results.py --dashboard --format markdown --output dashboard.md
```

### Saída do Painel

```
DOMÍNIO         EXPERIMENTO         EXEC  MANTIDOS  MELHOR       Δ DO INÍCIO  STATUS
engineering     api-speed            47    14   185ms        -76.9%        active
engineering     bundle-size          23     8   412KB        -58.3%        paused
marketing       medium-ctr           31    11   8.4/10       +68.0%        active
prompts         support-tone         15     6   82/100       +46.4%        done
```

### Formatos de Exportação

- **TSV** — padrão, separado por tabulação (compatível com planilhas)
- **CSV** — separado por vírgula, com aspas adequadas
- **Markdown** — tabela formatada, legível no GitHub/docs

---

## Gatilhos Proativos

Sinalize estes sem precisar ser solicitado:

- **Nenhum comando de avaliação funciona** → Testá-lo antes de iniciar o loop. Executar uma vez, verificar saída.
- **Arquivo alvo não está no git** → `git init && git add . && git commit -m 'initial'` primeiro.
- **Direção da métrica não clara** → Perguntar: menor ou maior é melhor? Deve saber antes de começar.
- **Orçamento de tempo muito curto** → Se o eval leva mais tempo que o orçamento, cada execução vai crashar.
- **Agente modificando evaluate.py** → Parada total. Isso invalida todas as comparações.
- **5 crashes consecutivos** → Pausar o loop. Alertar o usuário. Não continue queimando ciclos.
- **Sem melhoria em 20+ execuções** → Sugerir mudança de estratégia no program.md ou tentar uma abordagem diferente.

---

## Instalação

### One-liner
```bash
git clone https://github.com/alirezarezvani/claude-skills.git
cp -r claude-skills/engineering/autoresearch-agent ~/.claude/skills/
```

---

## Skills Relacionadas

- **self-improving-agent** — melhora a própria memória/regras de um agente ao longo do tempo. NÃO para loops de experimento estruturados.
- **senior-ml-engineer** — decisões de arquitetura de ML. Complementar — use para design inicial, depois autoresearch para otimização.
- **tdd-guide** — desenvolvimento orientado a testes. Complementar — testes podem ser a função de avaliação.
- **skill-security-auditor** — auditar skills antes de publicar. NÃO para loops de otimização.
