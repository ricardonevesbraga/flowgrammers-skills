---
name: "challenge"
description: "/em:challenge — Análise Pre-Mortem de Planos"
---

# /em:challenge — Análise Pre-Mortem de Planos

**Comando:** `/em:challenge <plan>`

Encontra sistematicamente fraquezas em qualquer plano antes que a realidade o faça. Não para matar o plano — para fazê-lo sobreviver ao contato com a realidade.

---

## A Ideia Central

A maioria dos planos falha por razões previsíveis. Não é má sorte — são premissas ruins. Demanda superestimada. Complexidade subestimada. Dependências que ninguém questionou. Timing que fazia sentido em uma planilha, mas não no mundo real.

A técnica de pre-mortem: **imagine que são 12 meses no futuro e este plano falhou espetacularmente. Agora trabalhe de trás para frente. Por quê?**

Isso não é pessimismo. É como você constrói algo que não desmorona.

---

## Quando Executar um Challenge

- Antes de comprometer recursos significativos em um plano
- Antes de apresentar ao conselho ou investidores
- Quando você percebe que só está ouvindo feedback positivo sobre o plano
- Quando o plano requer que múltiplas dependências externas se alinhem
- Quando há pressão para mover rápido e "resolver depois"
- Quando você se sente entusiasmado com o plano (entusiasmo é um sinal para escrutinar mais)

---

## O Framework de Challenge

### Passo 1: Extraia as Premissas Centrais
Antes de testar um plano, você precisa identificar tudo o que ele assume ser verdadeiro.

Para cada seção do plano, pergunte:
- O que precisa ser verdade para isso funcionar?
- O que estamos assumindo sobre o comportamento do cliente?
- O que estamos assumindo sobre a resposta do concorrente?
- O que estamos assumindo sobre nossa própria capacidade de execução?
- De quais fatores externos isso depende?

**Categorias comuns de premissas:**
- **Premissas de mercado** — tamanho, taxa de crescimento, disposição do cliente para pagar, ciclo de compra
- **Premissas de execução** — capacidade do time, velocidade, sem necessidade de contratações importantes
- **Premissas de cliente** — eles têm o problema, sabem que têm, pagarão para resolver
- **Premissas competitivas** — incumbentes não reagirão, nenhum novo entrante, o fosso se mantém
- **Premissas financeiras** — taxa de burn, timing de receita, relações CAC/LTV
- **Premissas de dependência** — o parceiro entregará, a API não mudará, os regulamentos não mudarão

### Passo 2: Avalie Cada Premissa

Para cada premissa extraída, classifique em duas dimensões:

**Nível de confiança (quão certo você está de que é verdade):**
- **Alto** — verificado com dados, conversas com clientes, pesquisa de mercado
- **Médio** — direcionalmente certo, mas não validado
- **Baixo** — plausível, mas não testado
- **Desconhecido** — simplesmente não sabemos

**Impacto se errado (o que acontece se esta premissa falhar):**
- **Crítico** — o plano falha completamente
- **Alto** — grande atraso ou estouro de custo
- **Médio** — retrabalho significativo necessário
- **Baixo** — ajuste gerenciável

### Passo 3: Mapeie as Vulnerabilidades

A matriz de confiança Baixa/Desconhecida × impacto Crítico/Alto = suas premissas de maior risco.

**Vulnerabilidade = Baixa confiança + Alto impacto**

Estes não são problemas a ignorar. São as apostas que você está fazendo. A questão é: você as está fazendo conscientemente?

### Passo 4: Encontre a Cadeia de Dependências

Muitos planos falham não porque alguma premissa isolada esteja errada, mas porque múltiplas premissas precisam estar certas simultaneamente.

Mapeie a cadeia:
- A premissa B depende da premissa A ser verdadeira primeiro?
- Se a primeira coisa der errado, quantas coisas subsequentes quebram?
- Qual é o caminho crítico? O que não tem margem de manobra?

### Passo 5: Teste a Reversibilidade

Para cada vulnerabilidade crítica: se esta premissa se mostrar errada no mês 3, o que você faz?

- Você consegue pivotar?
- Você consegue reduzir o escopo?
- O dinheiro já foi gasto?
- Compromissos já foram feitos?

Quanto menos reversível, mais rigorosamente você precisa validar antes de comprometer.

---

## Formato de Saída

**Relatório de Challenge: [Nome do Plano]**

```
PREMISSAS CENTRAIS (extraídas)
1. [Premissa] — Confiança: [A/M/B/?] — Impacto se errado: [Crítico/Alto/Médio/Baixo]
2. ...

MAPA DE VULNERABILIDADES
Riscos críticos (agir antes de prosseguir):
• [#N] [Premissa] — POR QUE pode estar errada — O QUE quebra se estiver

Riscos altos (validar antes de escalar):
• ...

CADEIA DE DEPENDÊNCIAS
[Premissa A] → depende de → [Premissa B] → que possibilita → [Premissa C]
Elo mais fraco: [X] — se isso quebrar, [Y] e [Z] também falham

AVALIAÇÃO DE REVERSIBILIDADE
• Apostas reversíveis: [lista]
• Compromissos irreversíveis: [lista — tratar com extremo cuidado]

GATILHOS DE SAÍDA
O que precisaria ser verdade em [30/60/90 dias] para continuar vs. encerrar/pivotar?
• Continuar se: ...
• Encerrar/pivotar se: ...

AÇÕES DE FORTALECIMENTO
1. [Validação específica a fazer antes de prosseguir]
2. [Abordagem alternativa a considerar]
3. [Contingência a incorporar no plano]
```

---

## Padrões de Challenge por Tipo de Plano

### Roadmap de Produto
- Estamos construindo o que os clientes pagarão, ou o que disseram querer?
- A estimativa de velocidade considera a capacidade real do time (não a teórica)?
- O que acontece se a funcionalidade principal levar 3× mais tempo que o estimado?
- Quem toma decisões quando os requisitos entram em conflito?

### Plano de Go-to-Market
- Qual é a taxa de conversão real do ICP, não a esperada?
- Quantos contatos para fechar e você tem a capacidade de vendas para isso?
- O que acontece se os primeiros 10 negócios levarem 3 meses em vez de 1?
- "Land and expand" é uma movimentação real ou uma esperança?

### Plano de Contratação
- O que acontece se a contratação-chave levar 4 meses para encontrar, não 6 semanas?
- O plano depende de reter pessoas específicas que podem sair?
- O plano considera o tempo de ramp (geralmente 3–6 meses antes da produtividade plena)?
- Qual é o impacto no burn se o headcount liderar a receita em 6 meses?

### Plano de Captação
- Qual é o seu plano B se o investidor-líder passar?
- Você modelou o cronograma se levar 6 meses, não 3?
- Qual é o seu runway no burn atual se a rodada fechar no limite inferior?
- Quais premissas quebram se você captar 50% do valor-alvo?

---

## As Perguntas Mais Difíceis

Estas são as que as pessoas pulam:
- "Qual é o cenário pessimista, não o cenário base?"
- "Se este exato plano fosse executado por um time em quem não confiamos, funcionaria?"
- "O que não estamos dizendo em voz alta porque é desconfortável?"
- "Quem tem incentivos para fazer este plano parecer melhor do que é?"
- "O que um inimigo deste plano atacaria primeiro?"

---

## Entregável

A saída de `/em:challenge` não é permissão para parar. É um mapa de vulnerabilidades. Agora você pode tomar decisões conscientes: validar as premissas arriscadas, fazer hedge nas críticas ou aceitar as apostas que está fazendo de forma consciente.

Riscos desconhecidos são perigosos. Riscos conhecidos são gerenciáveis.
