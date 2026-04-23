---
name: "loop"
description: "Iniciar um loop autônomo de experimentos com intervalo selecionado pelo usuário (10min, 1h, diário, semanal, mensal). Usa CronCreate para agendamento."
command: /ar:loop
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# /ar:loop — Loop Autônomo de Experimentos

Iniciar um loop de experimentos recorrente que é executado em um intervalo selecionado pelo usuário.

## Uso

```
/ar:loop engineering/api-speed             # Iniciar loop (solicita intervalo)
/ar:loop engineering/api-speed 10m         # A cada 10 minutos
/ar:loop engineering/api-speed 1h          # A cada hora
/ar:loop engineering/api-speed daily       # Diariamente às ~9h
/ar:loop engineering/api-speed weekly      # Semanalmente na segunda às ~9h
/ar:loop engineering/api-speed monthly     # Mensalmente no dia 1 às ~9h
/ar:loop stop engineering/api-speed        # Parar um loop ativo
```

## O Que Faz

### Passo 1: Resolver experimento

Se nenhum experimento especificado, listar experimentos e deixar o usuário escolher.

### Passo 2: Selecionar intervalo

Se o intervalo não for fornecido como argumento, apresentar opções:

```
Selecione o intervalo do loop:
  1. A cada 10 minutos  (rápido — ficar e observar)
  2. A cada hora         (em segundo plano — verificar depois)
  3. Diariamente às ~9h  (experimentos noturnos)
  4. Semanalmente na segunda   (experimentos de longa duração)
  5. Mensalmente no dia 1     (experimentos lentos)
```

Mapear para expressões cron:

| Intervalo | Expressão Cron | Atalho |
|----------|----------------|-----------|
| 10 minutos | `*/10 * * * *` | `10m` |
| 1 hora | `7 * * * *` | `1h` |
| Diário | `57 8 * * *` | `daily` |
| Semanal | `57 8 * * 1` | `weekly` |
| Mensal | `57 8 1 * *` | `monthly` |

### Passo 3: Criar o job recorrente

Use `CronCreate` com este prompt (preencher com os detalhes do experimento):

```
You are running autoresearch experiment "{domain}/{name}".

1. Read .autoresearch/{domain}/{name}/config.cfg for: target, evaluate_cmd, metric, metric_direction
2. Read .autoresearch/{domain}/{name}/program.md for strategy and constraints
3. Read .autoresearch/{domain}/{name}/results.tsv for experiment history
4. Run: git checkout autoresearch/{domain}/{name}

Then do exactly ONE iteration:
- Review results.tsv: what worked, what failed, what hasn't been tried
- Edit the target file with ONE change (strategy escalation based on run count)
- Commit: git add {target} && git commit -m "experiment: {description}"
- Evaluate: python {skill_path}/scripts/run_experiment.py --experiment {domain}/{name} --single
- Read the output (KEEP/DISCARD/CRASH)

Rules:
- ONE change per experiment
- NEVER modify the evaluator
- If 5 consecutive crashes in results.tsv, delete this cron job (CronDelete) and alert
- After every 10 experiments, update Strategy section of program.md

Current best metric: {read from results.tsv or "no baseline yet"}
Total experiments so far: {count from results.tsv}
```

### Passo 4: Armazenar metadados do loop

Escrever em `.autoresearch/{domain}/{name}/loop.json`:

```json
{
  "cron_id": "{id from CronCreate}",
  "interval": "{user selection}",
  "started": "{ISO timestamp}",
  "experiment": "{domain}/{name}"
}
```

### Passo 5: Confirmar ao usuário

```
Loop iniciado para {domain}/{name}
  Intervalo: {descrição do intervalo}
  Cron ID: {id}
  Expira automaticamente: em 3 dias (limite do CronCreate)

  Para verificar progresso: /ar:status
  Para parar o loop:  /ar:loop stop {domain}/{name}

  Nota: Jobs recorrentes expiram automaticamente após 3 dias.
  Execute /ar:loop novamente para reiniciar após a expiração.
```

## Parando um Loop

Quando o usuário executa `/ar:loop stop {experiment}`:

1. Ler `.autoresearch/{domain}/{name}/loop.json` para obter o cron ID
2. Chamar `CronDelete` com esse ID
3. Excluir `loop.json`
4. Confirmar: "Loop parado para {experiment}. {n} experimentos concluídos."

## Limitações Importantes

- **Expiração automática em 3 dias**: Jobs CronCreate expiram após 3 dias. Para experimentos mais longos, o usuário deve re-executar `/ar:loop` para reiniciar. Os resultados persistem — o novo loop retoma de onde o anterior parou.
- **Um loop por experimento**: Não inicie múltiplos loops para o mesmo experimento.
- **Experimentos concorrentes**: Múltiplos experimentos podem fazer loop simultaneamente APENAS se estiverem em diferentes branches git (o que acontece por padrão — cada experimento obtém `autoresearch/{domain}/{name}`).
