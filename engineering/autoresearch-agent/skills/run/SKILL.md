---
name: "run"
description: "Executar uma única iteração de experimento. Editar o arquivo alvo, avaliar, manter ou descartar."
command: /ar:run
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# /ar:run — Iteração Única de Experimento

Executar exatamente UMA iteração de experimento: revisar histórico, decidir uma mudança, editar, fazer commit, avaliar.

## Uso

```
/ar:run engineering/api-speed              # Executar uma iteração
/ar:run                                     # Listar experimentos, deixar usuário escolher
```

## O Que Faz

### Passo 1: Resolver experimento

Se nenhum experimento especificado, executar `python {skill_path}/scripts/setup_experiment.py --list` e pedir ao usuário para escolher.

### Passo 2: Carregar contexto

```bash
# Ler configuração do experimento
cat .autoresearch/{domain}/{name}/config.cfg

# Ler estratégia e restrições
cat .autoresearch/{domain}/{name}/program.md

# Ler histórico do experimento
cat .autoresearch/{domain}/{name}/results.tsv

# Fazer checkout do branch do experimento
git checkout autoresearch/{domain}/{name}
```

### Passo 3: Decidir o que tentar

Revisar results.tsv:
- Quais mudanças foram mantidas? Que padrão elas compartilham?
- O que foi descartado? Evitar repetir essas abordagens.
- O que travou? Entender o porquê.
- Quantas execuções até agora? (Escalar a estratégia de acordo)

**Escalada de estratégia:**
- Execuções 1-5: Frutos de baixo custo (melhorias óbvias)
- Execuções 6-15: Exploração sistemática (variar um parâmetro)
- Execuções 16-30: Mudanças estruturais (trocas de algoritmo)
- Execuções 30+: Experimentos radicais (abordagens completamente diferentes)

### Passo 4: Fazer UMA mudança

Editar apenas o arquivo alvo especificado em config.cfg. Alterar uma coisa. Manter simples.

### Passo 5: Commit e avaliar

```bash
git add {target}
git commit -m "experiment: {descrição curta do que mudou}"

python {skill_path}/scripts/run_experiment.py \
  --experiment {domain}/{name} --single
```

### Passo 6: Reportar resultado

Ler a saída do script. Informar ao usuário:
- **KEEP**: "Melhoria! {metric}: {value} ({delta} do melhor anterior)"
- **DISCARD**: "Sem melhoria. {metric}: {value} vs melhor {best}. Revertido."
- **CRASH**: "Avaliação falhou: {reason}. Revertido."

### Passo 7: Verificação de auto-melhoria

Após cada 10º experimento (verificar contagem de linhas do results.tsv), atualizar a seção de Estratégia do program.md com padrões aprendidos.

## Regras

- UMA mudança por iteração. Não mude 5 coisas de uma vez.
- NUNCA modificar o avaliador (evaluate.py). É a verdade fundamental.
- Simplicidade vence. Igual desempenho com código mais simples é uma melhoria.
- Sem novas dependências.
