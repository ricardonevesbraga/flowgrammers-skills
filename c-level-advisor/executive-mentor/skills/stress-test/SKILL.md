---
name: "stress-test"
description: "/em:stress-test — Teste de Estresse de Premissas de Negócio"
---

# /em:stress-test — Teste de Estresse de Premissas de Negócio

**Comando:** `/em:stress-test <assumption>`

Pegue qualquer premissa de negócio e quebre-a antes que o mercado o faça. Projeções de receita. Tamanho de mercado. Fosso competitivo. Velocidade de contratação. Retenção de clientes.

---

## Por que a Maioria das Premissas Está Errada

Fundadores são otimistas por natureza. Isso é uma característica — você precisa de otimismo para começar algo do zero. Mas se torna uma desvantagem quando as premissas nos modelos de negócio são infladas pelo mesmo otimismo que o fez começar.

**As premissas mais perigosas são aquelas com as quais todos concordam.**

Quando o time inteiro acredita que o mercado de R$250M é real, quando cada conversa com investidor vai bem então você assume que a rodada fechará, quando seu modelo mostra R$10M ARR em dezembro e ninguém questiona — é quando você está mais exposto.

Teste de estresse não é pessimismo. É calibração.

---

## A Metodologia de Teste de Estresse

### Passo 1: Isole a Premissa

Declare explicitamente. Não "nosso mercado é grande" mas "o mercado total endereçável para software de gestão de despesas B2B para PMEs brasileiras é R$11,5B."

Quanto mais específica a premissa, mais testável ela é. Premissas vagas são infalsificáveis — e portanto inúteis.

**Tipos comuns de premissas:**
- **Tamanho de mercado** — TAM, SAM, SOM; taxa de crescimento; segmentos de clientes
- **Comportamento do cliente** — disposição para pagar, churn, expansão, indicações
- **Modelo de receita** — taxas de conversão, tamanho do negócio, ciclo de vendas, CAC
- **Posição competitiva** — durabilidade do fosso, velocidade de resposta do concorrente, custo de troca
- **Execução** — velocidade do time, cronograma de contratação, cronograma de produto, escalabilidade operacional
- **Macro** — ambiente regulatório, condições econômicas, disponibilidade de tecnologia

### Passo 2: Encontre as Evidências Contrárias

Para cada premissa, busque ativamente evidências de que está errada.

Pergunte:
- Quem tentou isso e falhou?
- Quais dados contradizem esta premissa?
- Como é o cenário pessimista?
- Se um cético inteligente estivesse analisando isso, no que ele apontaria?
- Qual é a taxa base para premissas como esta?

**Fontes de evidências contrárias:**
- Empresas comparáveis que falharam em mercados adjacentes
- Dados de churn de clientes de negócios semelhantes
- Precisão histórica de previsões similares
- Relatórios do setor com dados conflitantes
- O que concorrentes que tentaram isso descobriram

O objetivo não é encontrar uma razão para parar — é identificar o que você não sabe.

### Passo 3: Modele o Cenário Pessimista

A maioria dos planos modela o cenário base e o otimista. O teste de estresse significa modelar o cenário pessimista explicitamente.

**Para premissas quantitativas (receita, crescimento, conversão):**

| Cenário | Valor da Premissa | Probabilidade | Impacto |
|---------|------------------|---------------|---------|
| Caso base | [Valor original] | ? | |
| Caso pessimista | -30% | ? | |
| Caso de estresse | -50% | ? | |
| Catastrófico | -80% | ? | |

Pergunta-chave em cada nível: **O negócio sobrevive? O plano faz sentido?**

**Para premissas qualitativas (fosso, product-market fit, capacidade do time):**

- Qual é o sinal mais precoce de que esta premissa está errada?
- Quanto tempo levaria para você perceber?
- O que acontece entre quando quebra e quando você detecta?

### Passo 4: Calcule a Sensibilidade

Algumas premissas importam mais que outras. Análise de sensibilidade responde: **se esta premissa mudar, o quanto o resultado muda?**

Exemplo:
- Se o CAC dobrar, como isso muda o runway?
- Se o churn for de 5% para 10%, como isso muda o NRR em 24 meses?
- Se o ciclo de negócios for 6 meses em vez de 3, como isso afeta a receita do T3?

Alta sensibilidade = a premissa é uma alavanca chave. Se errada = grande problema.

### Passo 5: Proponha o Hedge

Para cada premissa de alto risco, deve haver um hedge:

- **Hedge de validação** — teste antes de apostar (piloto, conversa com cliente, pequeno experimento)
- **Hedge de contingência** — se estiver errado, qual é o Plano B?
- **Hedge de alerta precoce** — qual é o indicador antecedente que diria que está quebrando antes que seja tarde demais para agir?

---

## Padrões de Teste de Estresse por Tipo de Premissa

### Projeções de Receita

**Falhas comuns:**
- Modelo bottom-up assume que 100% do pipeline converte
- Não considera deslizamento de negócios, churn, sazonalidade
- Novo canal assumido como funcional antes de testado em escala

**Perguntas de estresse:**
- Qual é sua taxa de vitória histórica real no pipeline?
- Se seus 3 principais negócios deslizarem para o próximo trimestre, o que acontece com o número?
- Como fica o modelo se seu novo representante de vendas levar 4 meses para atingir desempenho pleno, não 2?
- Se a receita de expansão não se materializar, qual é a taxa de crescimento?

**Teste:** Construa o modelo de receita a partir de taxas de vitória históricas, não das esperadas.

### Tamanho de Mercado

**Falhas comuns:**
- TAM calculado de cima para baixo a partir de relatórios setoriais sem validação bottom-up
- Confundir mercado total com mercado endereçável
- Assumir que 100% do SAM é alcançável

**Perguntas de estresse:**
- Quantas empresas no seu ICP realmente existem e você consegue nomeá-las?
- Qual é o seu mercado endereçável obtenível nos anos 1–3?
- Que percentual do seu ICP atualmente gasta em qualquer solução para este problema?
- Como é "vencer" e qual participação de mercado isso requer?

**Teste:** Construa uma lista de contas-alvo. Conte-as. Multiplique pelo ACV. Esse é o seu SAM.

### Fosso Competitivo

**Falhas comuns:**
- Fosso é vantagem tecnológica que pode ser construída em 6 meses
- Efeitos de rede que ainda não se materializaram
- Vantagem de dados que requer escala que você não tem

**Perguntas de estresse:**
- Se um concorrente bem financiado copiasse sua melhor funcionalidade em 90 dias, o que os clientes fariam?
- Qual é sua taxa de retenção entre clientes que experimentaram alternativas?
- O fosso é real hoje ou teórico em escala?
- Quanto custaria a um concorrente atingir paridade de funcionalidades?

**Teste:** Pergunte aos clientes que churnaramque os fez sair e se um concorrente poderia tê-los retido.

### Plano de Contratação

**Falhas comuns:**
- Tempo para contratar assume ciclo de recrutamento padrão, não o mercado atual
- Tempo de ramp não modelado (3–6 meses antes da produtividade plena)
- Dependência de contratação-chave: o plano só funciona se uma pessoa específica for contratada

**Perguntas de estresse:**
- O que acontece se a contratação do VP de Vendas levar 5 meses, não 2?
- Como fica a execução se você contratar apenas 70% do headcount planejado?
- Qual pessoa única, se saísse amanhã, mais prejudicaria o plano?
- O plano é realizável com o time atual se a contratação for congelada?

**Teste:** Modele o plano com 0 novas contratações líquidas. O que ainda funciona?

### Resposta Competitiva

**Falhas comuns:**
- Assume que incumbentes não reagirão (eles reagirão se você estiver ganhando)
- Subestima a velocidade de resposta
- Não modela a assimetria de recursos

**Perguntas de estresse:**
- Se o líder de mercado copiar seu produto em 6 meses, como os preços mudam?
- Qual é sua resposta se um concorrente captar R$150M para atacar seu espaço?
- Quais dos seus clientes têm relacionamentos com seus concorrentes?

---

## A Saída do Teste de Estresse

```
PREMISSA: [Declaração exata]
FONTE: [De onde isso veio — modelo, pitch para investidor, intuição do time]

EVIDÊNCIAS CONTRÁRIAS
• [Evidência específica que desafia esta premissa]
• [Caso comparável de falha]
• [Ponto de dados que contradiz a premissa]

MODELO PESSIMISTA
• Caso pessimista (-30%): [Impacto no plano]
• Caso de estresse (-50%): [Impacto no plano]
• Catastrófico (-80%): [Impacto no plano — o negócio sobrevive?]

SENSIBILIDADE
Esta premissa tem sensibilidade [ALTA / MÉDIA / BAIXA].
Uma mudança de 10% → mudança de [X] no resultado.

HEDGE
• Validação: [Como testar antes de apostar nisso]
• Contingência: [Plano B se estiver errado]
• Alerta precoce: [Indicador antecedente a acompanhar — e em que limiar agir]
```
