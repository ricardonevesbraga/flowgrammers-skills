---
name: "self-eval"
description: "Avalie honestamente a qualidade do trabalho de IA usando um sistema de pontuação em dois eixos. Use após concluir uma tarefa, revisão de código ou sessão de trabalho para obter uma avaliação imparcial. Detecta inflação de pontuação, força raciocínio do advogado do diabo e persiste pontuações entre sessões."
license: "MIT"
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Self-Eval: Avaliação Honesta do Trabalho

ultrathink

**Nível:** PADRÃO
**Categoria:** Engenharia / Qualidade
**Dependências:** Nenhuma (somente prompt, sem ferramentas externas necessárias)

## Descrição

Self-eval é uma skill do Claude Code que produz avaliações de trabalho honestas e calibradas. Ela substitui a tendência padrão de IA de classificar tudo como 4/5 por um sistema estruturado de pontuação em dois eixos, raciocínio obrigatório do advogado do diabo e detecção de anti-inflação entre sessões.

O insight central: a autoavaliação de IA converge para "tudo é um 4" porque uma pontuação de eixo único conflate dificuldade da tarefa com qualidade de execução. O self-eval separa esses eixos, então os combina via uma matriz fixa que o modelo não pode sobrescrever.

## Funcionalidades

- **Pontuação em dois eixos** — Avalia independentemente a ambição da tarefa (Baixa/Média/Alta) e a qualidade de execução (Ruim/Adequada/Forte), depois combina via uma matriz de consulta
- **Advogado do diabo obrigatório** — Antes de finalizar, deve argumentar tanto para pontuações mais altas QUANTO mais baixas, depois resolver a tensão
- **Persistência de pontuação** — Acrescenta pontuações a `.self-eval-scores.jsonl` no diretório de trabalho, construindo histórico entre sessões
- **Detecção de anti-inflação** — Lê pontuações passadas e sinaliza clustering (4+ dos últimos 5 iguais)
- **Pontuação bloqueada por matriz** — A pontuação composta vem da matriz, não da seleção direta. Ambição baixa limita a 2/5 independentemente da qualidade de execução

## Uso

Após concluir trabalho em uma sessão do Claude Code:

```
/self-eval
```

Com contexto sobre o que avaliar:

```
/self-eval a refatoração de autenticação que acabamos de completar
```

A skill revisa o histórico de conversa, identifica o que foi realizado, pontua em ambos os eixos, executa a verificação do advogado do diabo e acrescenta o resultado ao arquivo de histórico de pontuação.

## Exemplos

### Exemplo 1: Implementação de Funcionalidade

```
/self-eval adicionei paginação à API de lista de usuários
```

Saída:
```
## Autoavaliação

**Tarefa:** Adicionada paginação baseada em cursor ao endpoint de API de lista de usuários
**Ambição:** Média — Nova funcionalidade com padrões estabelecidos, mas requereu cuidado com compatibilidade retroativa
**Execução:** Forte — Todos os testes passam, lida com casos extremos, clientes existentes não afetados

**Advogado do Diabo:**
- Menor: Paginação é bem documentada. O padrão foi copiado de outro endpoint com pequenas mudanças. Poderia argumentar ambição Baixa.
- Maior: O requisito de compatibilidade retroativa tornou isso mais difícil que uma implementação do zero. Tivemos que suportar os modos offset e cursor.
- Resolução: Ambição Média se mantém — a restrição de compatibilidade retroativa adicionou complexidade real além do copiar-e-colar.

**Pontuação: 4** — Execução sólida em trabalho significativo com restrições reais.
```

### Exemplo 2: Correção de Bug

```
/self-eval
```

Saída:
```
## Autoavaliação

**Tarefa:** Corrigida race condition no fluxo de checkout causando pedidos duplicados
**Ambição:** Média — Requereu debugging em 3 serviços para encontrar a causa raiz
**Execução:** Adequada — A correção funciona mas o teste cobre apenas o cenário exato relatado, não a classe geral de race conditions

**Advogado do Diabo:**
- Menor: A correção foi uma única linha (adicionando um mutex). Uma vez encontrado, foi trivial.
- Maior: Encontrar a causa raiz em 3 serviços requereu investigação real. O posicionamento do mutex exigiu entender o fluxo completo.
- Resolução: Ambição Média está correta para a investigação, mas a execução cai para Adequada — uma correção mais completa abordaria o padrão, não apenas a instância.

**Pontuação: 3** — Bom trabalho de debugging mas a correção é estreita.
```

---

## O Que Avaliar

$ARGUMENTS

Se nenhum argumento for fornecido, revise o histórico completo de conversa para identificar o que foi realizado nesta sessão. Resuma o trabalho em uma frase antes de pontuar.

## Como Pontuar — Modelo de Dois Eixos

Pontue em dois eixos independentes, depois combine usando a matriz. NÃO escolha um número primeiro e o racionalize — avalie cada eixo separadamente, depois leia a matriz.

### Eixo 1: Ambição da Tarefa (o que foi tentado)

Avalie a dificuldade e o risco do que foi trabalhado. NÃO quão bem foi feito.

- **Baixa (1)** — Seguro, familiar, rotineiro. Sem risco real de falha. Exemplos: pequenas mudanças de configuração, refatorações simples, copiar-e-colar com pequenas modificações, tarefas que você tinha certeza que completaria antes de começar.
- **Média (2)** — Trabalho significativo com novidade ou desafio. Falha parcial era possível. Exemplos: implementação de nova funcionalidade, integração de API desconhecida, mudanças arquiteturais, debugging de problema complicado.
- **Alta (3)** — Ambicioso, desconhecido ou de alta importância. Risco real de falha completa. Exemplos: construir algo do zero em domínio desconhecido, redesenho complexo de sistema, otimização crítica de desempenho, implantar em produção sob pressão.

**Auto-verificação:** Se você estava confiante do sucesso antes de começar, a ambição é Baixa ou Média, não Alta.

### Eixo 2: Qualidade de Execução (quão bem foi feito)

Avalie a qualidade do resultado real, independente de quão ambiciosa foi a tarefa.

- **Ruim (1)** — Falhas maiores, incompleto, saída errada ou abandonado no meio da tarefa. O entregável não atende aos seus próprios critérios declarados.
- **Adequada (2)** — Concluído mas com lacunas, atalhos ou rigor faltante. Fez a coisa mas deixou melhorias óbvias na mesa.
- **Forte (3)** — Bem executado, completo, saída de qualidade. Sem melhorias óbvias deixadas por fazer dado o escopo.

### Matriz de Pontuação Composta

|                        | Execução Ruim (1) | Execução Adequada (2) | Execução Forte (3) |
|------------------------|:---:|:---:|:---:|
| **Ambição Baixa (1)**   |  1  |  2  |  2  |
| **Ambição Média (2)**|  2  |  3  |  4  |
| **Ambição Alta (3)**  |  2  |  4  |  5  |

**Leia a matriz, não a sobrescreva.** O composto é a sua pontuação. O advogado do diabo abaixo pode fazer você reclassificar um eixo — mas você não pode sobrescrever diretamente o resultado da matriz.

Propriedades principais:
- Ambição baixa limita a 2. Trabalho seguro feito perfeitamente ainda é trabalho seguro.
- Um 5 requer TANTO ambição alta QUANTO execução forte. Deve ser raro.
- Ambição alta + execução ruim = 2. Falha audaciosa dói.
- A pontuação honesta mais comum para trabalho sólido é 3 (ambição média, execução adequada).

## Advogado do Diabo (OBRIGATÓRIO)

Antes de escrever sua pontuação final, você DEVE escrever os três itens a seguir:

1. **Caso para MENOR:** Por que este trabalho pode merecer uma pontuação menor? O que foi fácil, o que foi evitado, o que foi menos ambicioso do que parece? Um revisor cético concordaria com suas classificações de eixo?
2. **Caso para MAIOR:** Por que este trabalho pode merecer uma pontuação maior? O que foi genuinamente desafiador, surpreendente ou superou o plano original?
3. **Resolução:** Se qualquer caso revelar que você classificou mal um eixo, reclassifique-o e recalcule o resultado da matriz. Então declare sua pontuação final com uma justificativa de 1-2 frases que aborde pelo menos um ponto de cada caso.

Se o seu advogado do diabo tiver menos de 3 frases no total, você não está se engajando com ele — tente mais.

## Verificação de Anti-Inflação

Verifique se há um arquivo de histórico de pontuação em `.self-eval-scores.jsonl` no diretório de trabalho atual.

Se o arquivo existir, leia-o e verifique as últimas 5 pontuações. Se 4+ das últimas 5 forem o mesmo número, sinalize:
> **Aviso: Clustering de pontuação detectado.** Últimas 5 pontuações: [lista]. Considere se você está ancorado em um padrão.

Se o arquivo não existir, pergunte a si mesmo: "Um observador externo avaliaria isso da mesma forma que eu?"

## Persistência de Pontuação

Após apresentar sua avaliação, acrescente uma linha a `.self-eval-scores.jsonl` no diretório de trabalho atual:

```json
{"date":"AAAA-MM-DD","score":N,"ambition":"Low|Medium|High","execution":"Poor|Adequate|Strong","task":"resumo de 1 frase"}
```

Isso habilita a verificação de anti-inflação a funcionar entre sessões. Se o arquivo não existir, crie-o.

## Formato de Saída

Apresente sua avaliação como:

## Autoavaliação

**Tarefa:** [resumo de 1 frase do que foi tentado]
**Ambição:** [Baixa/Média/Alta] — [justificativa de 1 frase]
**Execução:** [Ruim/Adequada/Forte] — [justificativa de 1 frase]

**Advogado do Diabo:**
- Menor: [por que pode merecer menos]
- Maior: [por que pode merecer mais]
- Resolução: [raciocínio final]

**Pontuação: [1-5]** — [justificativa final de 1 frase]
