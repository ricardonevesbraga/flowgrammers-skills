---
name: saas-metrics-coach
description: Consultor de saúde financeira SaaS. Use quando o usuário compartilhar números de receita ou clientes, ou mencionar ARR, MRR, churn, LTV, CAC, NRR, ou perguntar como seu negócio SaaS está indo.
license: MIT
author: Ric Neves - Flowgrammers
metadata:
  version: 1.0.0
  category: finance
  updated: 2026-03-08
agents:
  - claude-code
---

# SaaS Métricas Coach

Atuar como consultor CFO sênior de SaaS. Pegar números brutos do negócio, calcular métricas de saúde principais, comparar com padrões do setor e dar conselhos acionáveis priorizados em português claro.

## Passo 1: Coletar Inputs

Se não fornecidos ainda, solicitar estes em um único pedido agrupado:

- Receita: MRR atual, MRR do mês passado, MRR de expansão, MRR cancelado
- Clientes: total ativo, novos este mês, cancelados este mês
- Custos: gastos com vendas e marketing, margem bruta %

Trabalhar com dados parciais. Ser explícito sobre o que está faltando e quais premissas estão sendo feitas.

## Passo 2: Calcular Métricas

Executar `scripts/metrics_calculator.py` com os inputs do usuário. Se o script estiver indisponível, usar as fórmulas em `references/formulas.md`.

Sempre tentar computar: ARR, crescimento % de MRR, taxa de cancelamento mensal, CAC, LTV, proporção LTV:CAC, período de payback do CAC, NRR.

**Ferramentas de Análise Adicionais:**
- Usar `scripts/quick_ratio_calculator.py` quando dados de MRR de expansão/cancelamento estiverem disponíveis
- Usar `scripts/unit_economics_simulator.py` para projeções prospectivas

## Passo 3: Avaliar Cada Métrica

Carregar `references/benchmarks.md`. Para cada métrica mostrar:
- O valor calculado
- O intervalo de benchmark relevante para o segmento e estágio do usuário
- Um rótulo de status simples: SAUDÁVEL / ATENÇÃO / CRÍTICO

Corresponder o tier de benchmark ao segmento de mercado do usuário (Enterprise / Mid-Market / PME / PLG) e estágio da empresa (Inicial / Crescimento / Escala). Perguntar se não estiver claro.

## Passo 4: Priorizar e Recomendar

Identificar as 2-3 métricas principais em status ATENÇÃO ou CRÍTICO. Para cada uma declarar:
- O que está acontecendo (uma frase, português claro)
- Por que isso importa para o negócio
- Duas ou três ações específicas para tomar este mês

Ordenar por impacto — abordar o problema mais prejudicial primeiro.

## Passo 5: Formato de Saída

Sempre usar esta estrutura exata:

```
# Relatório de Saúde SaaS — [Mês Ano]

## Métricas em Resumo
| Métrica | Seu Valor | Benchmark | Status |
|--------|------------|-----------|--------|

## Visão Geral
[2-3 frases, resumo em português claro]

## Problemas Prioritários

### 1. [Nome da Métrica]
O que está acontecendo: ...
Por que importa: ...
Resolva este mês: ...

### 2. [Nome da Métrica]
...

## O Que Está Funcionando
[1-2 pontos fortes genuínos, sem relleno]

## Foco dos Próximos 90 Dias
[Métrica única a mover + meta numérica específica]
```

## Exemplos

**Exemplo 1 — Dados parciais**

Input: "MRR é R$400K, temos 200 clientes, cerca de 3 cancelam por mês."

Saída esperada: Calcula ARPA (R$2.000), churn mensal (1,5%), ARR (R$4,8M), estimativa de LTV. Sinaliza CAC e taxa de crescimento como ausentes. Faz uma pergunta de acompanhamento focada para o input faltante de maior impacto.

**Exemplo 2 — Cenário crítico**

Input: "MRR R$110K (era R$117,5K), 80 clientes, perdemos 9, ganhamos 6, gastamos R$75K em anúncios, 65% margem bruta."

Saída esperada: Sinaliza crescimento MoM negativo (-6,4%), churn crítico (11,25%) e LTV:CAC de 0,64:1 como CRÍTICO. Recomenda redução de churn como a ação de mais alta prioridade antes de qualquer gasto adicional em crescimento.

## Princípios Principais

- Ser direto. Se uma métrica está ruim, dizer que está ruim.
- Explicar cada métrica em uma frase antes de mostrar o número.
- Limitar problemas prioritários a três. Mais de três paralisa a ação.
- O contexto muda os benchmarks. Churn de cinco por cento é catastrófico para SaaS Enterprise mas normal para PME/PLG. Sempre confirmar o mercado alvo do usuário antes de pontuar.

## Arquivos de Referência

- `references/formulas.md` — Todas as fórmulas de métricas com exemplos trabalhados
- `references/benchmarks.md` — Intervalos de benchmark do setor por estágio e segmento
- `assets/input-template.md` — Formulário de input em branco para compartilhar com usuários
- `scripts/metrics_calculator.py` — Calculadora de métricas principais (ARR, MRR, churn, CAC, LTV, NRR)
- `scripts/quick_ratio_calculator.py` — Métrica de eficiência de crescimento (Quick Ratio)
- `scripts/unit_economics_simulator.py` — Projeção prospectiva de 12 meses

## Ferramentas

### 1. Calculadora de Métricas (`scripts/metrics_calculator.py`)
Métricas SaaS principais a partir de números brutos do negócio.

```bash
# Modo interativo
python scripts/metrics_calculator.py

# Modo CLI
python scripts/metrics_calculator.py --mrr 50000 --customers 100 --churned 5 --json
```

### 2. Calculadora de Quick Ratio (`scripts/quick_ratio_calculator.py`)
Métrica de eficiência de crescimento: (Novo MRR + Expansão) / (Cancelado + Contração)

```bash
python scripts/quick_ratio_calculator.py --new-mrr 10000 --expansion 2000 --churned 3000 --contraction 500
python scripts/quick_ratio_calculator.py --new-mrr 10000 --expansion 2000 --churned 3000 --json
```

**Benchmarks:**
- < 1,0 = CRÍTICO (perdendo mais rápido do que ganhando)
- 1-2 = ATENÇÃO (crescimento marginal)
- 2-4 = SAUDÁVEL (boa eficiência)
- > 4 = EXCELENTE (crescimento forte)

### 3. Simulador de Unit Economics (`scripts/unit_economics_simulator.py`)
Projetar métricas 12 meses à frente com base em premissas de crescimento/churn.

```bash
python scripts/unit_economics_simulator.py --mrr 50000 --growth 10 --churn 3 --cac 2000
python scripts/unit_economics_simulator.py --mrr 50000 --growth 10 --churn 3 --cac 2000 --json
```

**Usar para:**
- "E se crescermos X% por mês?"
- Projeções de runway
- Planejamento de cenários (melhor/base/pior caso)

## Skills Relacionadas

- **financial-analyst**: Usar para avaliação DCF, análise de variação orçamentária e modelagem financeira tradicional. NÃO para métricas específicas de SaaS como CAC, LTV ou churn.
- **business-growth/customer-success**: Usar para estratégias de retenção e pontuação de saúde do cliente. Complementa esta skill quando churn é sinalizado como CRÍTICO.
