---
name: "postmortem"
description: "/em:postmortem — Análise Honesta do que Deu Errado"
---

# /em:postmortem — Análise Honesta do que Deu Errado

**Comando:** `/em:postmortem <event>`

Não culpa. Compreensão. O negócio perdido, o trimestre perdido, a funcionalidade que falhou, a contratação que não deu certo. O que realmente aconteceu, por quê e o que muda como resultado.

---

## Por que a Maioria dos Post-Mortems Falha

Eles se tornam uma de duas coisas:

**A sessão de culpa** — alguém é bode expiatório, muros defensivos sobem, as causas reais não são examinadas e o mesmo problema acontece novamente em uma forma diferente.

**O branqueamento** — "Aprendemos muito, vamos fazer melhor, aqui estão 12 itens de ação vagos." Nada muda. Mesmo problema, trimestre diferente.

Um post-mortem real não é nenhum dos dois. É uma investigação rigorosa de uma falha de sistema. Não "de quem foi a culpa" mas "quais condições tornaram esse resultado previsível em retrospectiva?"

**O propósito:** extrair o máximo de valor de aprendizado de uma falha para que você possa prevenir a recorrência e melhorar o sistema.

---

## O Framework

### Passo 1: Defina o Evento com Precisão

Antes da análise: descreva exatamente o que aconteceu.

- Qual era o resultado esperado?
- Qual foi o resultado real?
- Quando a lacuna ficou visível pela primeira vez?
- Qual foi o impacto (financeiro, operacional, reputacional)?

Precisão importa. "Perdemos a receita do T3" não é preciso o suficiente. "Fechamos R$2,1M em novo ARR vs. meta de R$3,4M — uma perda de R$1,3M impulsionada principalmente por três negócios que deslizaram para o T4 e um negócio perdido para um concorrente" é preciso.

### Passo 2: Os 5 Porquês — Feitos Corretamente

O objetivo: ir de **o que aconteceu** (o sintoma) para **por que aconteceu** (a causa raiz).

5 Porquês ruins padrão:
- Por que perdemos receita? Porque negócios deslizaram.
- Por que os negócios deslizaram? Porque o ciclo de vendas foi mais longo que o esperado.
- Por quê? Porque o processo de compra do cliente é complexo.
- Por quê? Porque estamos vendendo para enterprise.
- Por quê? É assim que funciona a venda enterprise.

→ Conclusão: Nada a fazer. É apenas enterprise.

5 Porquês reais:
- Por que perdemos receita? Três negócios deslizaram fora do trimestre.
- Por que esses negócios deslizaram? Nenhum deles havia identificado um champion com autoridade orçamentária.
- Por que avançamos negócios sem um champion? Nossos critérios de qualificação não exigiam isso.
- Por que nossos critérios de qualificação não exigiam? Quando construímos os critérios há 8 meses, estávamos em PME, não em enterprise.
- Por que não atualizamos os critérios conforme o ICP mudou? Sem responsável, sem processo de revisão de critérios.

→ Causa raiz: Critérios de qualificação desatualizados, sem responsável, sem processo de revisão.
→ Correção: Atualizar critérios, atribuir responsável, adicionar revisão trimestral.

**O teste para uma boa causa raiz:** Você poderia prevenir a recorrência com uma mudança específica e concreta? Se sim, encontrou algo real.

### Passo 3: Distinga Fatores Contribuintes da Causa Raiz

A maioria dos eventos tem múltiplos fatores contribuintes. Nem todos são causas raiz.

**Fator contribuinte:** Piorou a situação, mas não é o motivo central. Se removido, o resultado poderia ter sido diferente — mas o mesmo tipo de problema se repetiria.

**Causa raiz:** A condição fundamental que tornou o resultado provável. Corrija isso e esse tipo de problema não se repete.

Exemplo — contratação mal sucedida:
- Fatores contribuintes: processo apressado, verificações de referências puladas, time sob pressão para contratar
- Causa raiz: Nenhum framework de competências definido, então o processo de entrevista variava dependendo de quem conduzia

**A distinção importa.** Se você aborda apenas os fatores contribuintes, terá uma falha estruturalmente idêntica com aparência diferente na próxima vez.

### Passo 4: Identifique os Sinais de Aviso que Foram Ignorados

Toda falha tem precursores. Em retrospectiva, são óbvios. O valor deste passo é torná-los óbvios prospectivamente.

Pergunte:
- Em que ponto o resultado negativo era previsível?
- Quais sinais eram visíveis naquele ponto?
- Quem os viu? O que aconteceu quando os levantaram?
- Por que não foram acionados?

**Padrões comuns:**
- Sinal foi levantado, mas descartado por uma pessoa sênior
- Sinal não foi levantado porque ninguém se sentiu seguro para dizê-lo
- Sinal foi visto, mas ninguém tinha responsabilidade clara para agir
- Dados estavam disponíveis, mas ninguém os estava analisando
- O time estava otimista demais para levar sinais negativos a sério

Este passo é particularmente importante para problemas sistêmicos — "não nos sentíamos seguros para levantar a preocupação" é uma causa raiz muito mais profunda do que "a qualificação do negócio estava errada."

### Passo 5: Distinga o que Estava sob Controle vs. Fora do Controle

Algumas falhas acontecem apesar de decisões corretas. Algumas acontecem por causa de decisões incorretas. Saber a diferença previne tanto a supercorreção quanto a subcorreção.

- **Sob controle:** Processo, critérios, capacidade do time, alocação de recursos, decisões tomadas
- **Fora do controle:** Condições de mercado, decisões de clientes, ações de concorrentes, eventos macro

Para coisas fora do controle: o que pode ser feito para ser mais resiliente a eventos semelhantes?
Para coisas sob controle: o que especificamente precisa mudar?

**Aviso:** "Estava fora do nosso controle" às vezes é usado para evitar responsabilidade. Seja rigoroso.

### Passo 6: Construa o Registro de Mudanças

Todo post-mortem termina com um registro de mudanças — compromissos específicos, com responsável e data.

**Itens de ação ruins:**
- "Vamos melhorar nosso processo de qualificação"
- "A comunicação será melhor"
- "Seremos mais rigorosos com as previsões"

**Itens de ação bons:**
- "Ravi é responsável por reescrever os critérios de qualificação até 15/03 para incluir identificação de champion como requisito obrigatório. Novos critérios revisados no standup semanal de vendas a partir de 22/03."
- "Até 10/03, Elena adiciona flag de risco de deslizamento ao CRM para qualquer oportunidade aberta >60 dias sem demonstração do produto"
- "Maria conduz uma retrospectiva de 30 min com o time de vendas enterprise a cada 6 semanas a partir de 01/04, revisando dados de ganhos/perdas"

**Para cada ação:**
- O que exatamente está mudando?
- Quem é responsável?
- Até quando?
- Como você verificará que funcionou?

### Passo 7: Data de Verificação

O passo mais frequentemente pulado. Post-mortems são inúteis se ninguém verifica se as mudanças realmente aconteceram e realmente funcionaram.

Defina uma data de verificação: "Revisaremos se os critérios de qualificação foram atualizados e se a taxa de deslizamento de negócios melhorou na reunião do conselho de junho."

Sem isso, post-mortems são teatro.

---

## Formato de Saída do Post-Mortem

```
EVENTO: [Nome e data]
ESPERADO: [O que deveria ter acontecido]
REAL: [O que aconteceu]
IMPACTO: [Quantificado]

LINHA DO TEMPO
[Data]: [O que aconteceu ou era visível]
[Data]: ...

5 PORQUÊS
1. [Por que X aconteceu?] → Porque [Y]
2. [Por que Y aconteceu?] → Porque [Z]
3. [Por que Z aconteceu?] → Porque [A]
4. [Por que A aconteceu?] → Porque [B]
5. [Por que B aconteceu?] → Porque [CAUSA RAIZ]

CAUSA RAIZ: [Uma frase clara]

FATORES CONTRIBUINTES
• [Fator] — como contribuiu
• [Fator] — como contribuiu

SINAIS DE AVISO PERDIDOS
• [Sinal visível em que data] — por que não foi acionado

O QUE ESTAVA SOB CONTROLE: [Lista]
O QUE NÃO ESTAVA: [Lista]

REGISTRO DE MUDANÇAS
| Ação | Responsável | Prazo | Verificação |
|------|-------------|-------|-------------|
| [Mudança específica] | [Nome] | [Data] | [Como verificar] |

DATA DE VERIFICAÇÃO: [Data do check-in]
```

---

## O Tom dos Bons Post-Mortems

Culpa é fácil. Compreensão é difícil.

O objetivo não é estabelecer que alguém cometeu um erro. O objetivo é entender por que o sistema produziu aquele resultado — para que o sistema possa ser melhorado.

"O vendedor não qualificou o negócio adequadamente" é culpa.
"Nosso framework de qualificação não havia sido atualizado quando subimos de segmento, e ninguém era responsável por mantê-lo atual" é compreensão.

A primeira versão demite ou envergonha alguém. A segunda versão constrói uma organização mais resiliente.

Ambas podem ser verdadeiras simultaneamente. A distinção é: qual delas realmente previne a recorrência?
