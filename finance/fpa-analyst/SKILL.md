---
name: "fpa-analyst"
description: "Analista de FP&A (Financial Planning & Analysis) sênior para orçamento anual, forecast contínuo, análise de variação, unit economics, modelagem financeira 3 statements, business partnering e apresentação ao conselho. Use ao montar budget, fazer rolling forecast, analisar variações, modelar cenários, calcular unit economics ou quando o usuário mencionar FP&A, planejamento financeiro, budget, forecast, variance analysis, unit economics, 3 statements ou board deck financeiro."
license: MIT
metadata:
  version: 1.0.0
  author: Ric Neves - Flowgrammers
  category: finance
  domain: financial-planning-analysis
  updated: 2026-04-23
agents:
  - claude-code
---

# Analista FP&A (Financial Planning & Analysis) Sênior

Frameworks para planejamento financeiro corporativo: budget, forecast contínuo, análise de variações, modelagem, unit economics e business partnering.

## Palavras-chave
FP&A, Financial Planning & Analysis, orçamento, budget, forecast, rolling forecast, variance analysis, unit economics, 3-statement model, driver-based planning, scenario planning, board deck, KPI dashboard, business partnering

## Responsabilidades Principais

### 1. Orçamento Anual (Annual Operating Plan — AOP)

**Top-down vs. Bottom-up:**
- **Top-down**: CEO/board define meta (ex: crescer 40%)
- **Bottom-up**: áreas detalham premissas e drivers
- **Reconciliação**: FP&A negocia o gap

**Cronograma padrão (Q4):**
- **Semana 1-2**: Kick-off, premissas macro (câmbio, inflação), templates
- **Semana 3-4**: Áreas submetem bottom-up
- **Semana 5-6**: Consolidação, análise de gap, negociação
- **Semana 7-8**: Review com CFO + CEO
- **Semana 9-10**: Board approval
- **Dezembro**: Lock e comunicação

**Estrutura por centro de responsabilidade:**

```
[AOP 2026 — Empresa X]
├── Revenue
│   ├── New Business (ACV × # novos clientes)
│   ├── Expansion (NRR × base instalada)
│   └── Churn (GRR)
├── Gross Margin
│   ├── COGS (hosting, third-party, suporte)
├── OpEx
│   ├── Sales & Marketing
│   ├── R&D
│   ├── G&A (admin, jurídico, finance)
├── EBITDA
├── Cash
│   ├── Working capital
│   ├── CapEx
│   └── Free Cash Flow
```

### 2. Rolling Forecast

**Por que rolling (e não só annual):**
- Mercado muda rápido demais para plano anual rígido
- Força time de negócio a pensar 4-6 trimestres à frente
- Corrige curso antes que desvio vire crise

**Cadência recomendada:**
- **Mensal**: atualizar próximos 12 meses
- **Trimestral**: review profundo com líderes
- **Ad-hoc**: quando evento material (M&A, perda grande, funding)

**Driver-based (crítico):**
```
Revenue_M = Clientes_ativos_M * ARPU_M
Clientes_ativos_M = Clientes_ativos_M-1 + Novos_M - Churn_M
Novos_M = Leads_qualificados_M * Taxa_conversão * % fechados em M

COGS_M = Revenue_M * (1 - Gross_Margin_target)
OpEx_M = Headcount_M * Custo_médio_por_headcount + Despesas_variáveis_M
```

**Vantagem**: atualizar driver (ex: taxa de conversão cai 10%) reprojeta tudo automaticamente.

### 3. Variance Analysis (Actual vs. Budget vs. Forecast)

**Framework PVM (Price-Volume-Mix):**

Para variação de receita:
```
Var_Volume = (Qty_actual - Qty_budget) × Price_budget
Var_Price = (Price_actual - Price_budget) × Qty_actual
Var_Mix = efeito do mix de produtos (resto)
```

**Template de comentário:**

```markdown
# Variance Report Janeiro 2026

## Revenue
- **Actual**: R$ 4,2M | **Budget**: R$ 4,5M | **Var**: -R$ 300k (-6,7%)

### Drivers
- **Volume**: -R$ 400k (atraso em 3 deals grandes — Q2)
- **Price**: +R$ 100k (lift em novos clientes por reposicionamento)
- **Mix**: 0

### Ação
- Deals atrasados confirmados em Q2 — sem perda permanente
- Revisão de pipeline coverage (atual 2,8x vs meta 3,5x)
- CEO falará diretamente com CRO na sexta
```

**Regra dos 5%:** só detalhe linhas com variação absoluta > 5% ou > R$ 100k. Resto vai em anexo.

### 4. Modelagem 3-Statement

**Integração obrigatória:**
```
DRE → Net Income
  ↓
Balance Sheet (Retained Earnings)
  ↓
Cash Flow Statement (CFO = NI + ajustes não-caixa + Δ Working Capital)
```

**Structure para SaaS:**

```
# DRE
Revenue (MRR × 12 + one-time)
- COGS (Hosting, 3rd party, Suporte direto)
= Gross Profit
- S&M (Salário + Comissão + MKT + Eventos)
- R&D (Salário eng + cloud dev)
- G&A (Admin, Legal, Finance)
= EBITDA
- D&A
= EBIT
- Juros (líquido)
= LAIR
- IR (34% Lucro Real)
= Net Income

# Balanço (snapshot trimestral)
Ativo Circulante (Caixa, AR, Estoque)
Não Circulante (Imobilizado, Intangível)
Passivo Circulante (AP, Salários, Impostos)
Não Circulante (Dívida LP)
PL (Capital + Retained Earnings + Reservas)

# DFC (indireto)
Net Income
+ Depreciação & Amortização
+/- Δ Working Capital (AR, AP, Estoque)
= Cash Flow Operacional
- CapEx
= Free Cash Flow
- Dívida (Amortização)
+ Funding (Equity, Debt)
= Net Change in Cash
```

**Sanity checks:**
- Balance sheet balanceia (Ativo = Passivo + PL) em TODOS os períodos
- Cash do BS = Cash do DFC
- Retained Earnings = RE anterior + Net Income - Dividends

### 5. Unit Economics (SaaS foco)

**Métricas-chave:**

| Métrica | Fórmula | Benchmark saudável |
|---------|---------|-------------------|
| **CAC** | S&M / Novos clientes | Contextual |
| **LTV** | ARPU × Gross Margin / Churn rate | — |
| **LTV:CAC** | LTV / CAC | > 3:1 |
| **CAC Payback** | CAC / (ARPU × GM) | < 12-18 meses |
| **Gross Margin** | (Revenue - COGS) / Revenue | > 75% SaaS |
| **Rule of 40** | Growth % + EBITDA margin % | >= 40 |
| **Magic Number** | ΔARR trimestre / S&M anterior trimestre | >= 1 |
| **Burn Multiple** | Net Burn / Net New ARR | < 1 excelente, < 2 OK |

**Análise de coorte (obrigatório):**
- GRR e NRR por coorte de aquisição
- Identifica se ICP melhorou ou piorou
- Permite previsão de LTV real (vs. teórico)

### 6. Scenario Planning

**Base / Upside / Downside:**

Defina drivers que flexem entre cenários:
- Conversão top-of-funnel (±20%)
- ACV médio (±15%)
- Churn rate (±2pp)
- CAC (±25%)
- Headcount plan

**Triggers para mudar cenário:**
```yaml
pipeline_coverage:
  green: "> 3.5x"
  yellow: "2.5x - 3.5x"
  red: "< 2.5x"

runway:
  green: "> 24 months"
  yellow: "12-24 months"
  red: "< 12 months"

nrr:
  green: "> 110%"
  yellow: "95-110%"
  red: "< 95%"
```

### 7. Board Deck Financeiro

**Conteúdo mínimo (10-15 slides):**

1. Executive Summary (1 slide)
2. Revenue: actual × plan × forecast (trend + cohort)
3. Cash position + runway
4. Unit Economics dashboard
5. S&M efficiency (CAC payback, Magic Number)
6. Top 5 riscos financeiros + mitigação
7. Pedido / decisões do board

**Golden rules:**
- 1 slide = 1 ideia
- Números GRANDES; detalhes no anexo
- Sempre mostre trend (não pontos isolados)
- Compare com meta E com trimestre anterior
- Narrative > planilha

### 8. Business Partnering

**Modelo operacional:**
- **Weekly** com líderes de área (revisão tática)
- **Monthly** MBR (Monthly Business Review) com C-level
- **Quarterly** QBR com board

**FP&A como parceiro (não policial):**
- Oferece hipóteses e dados, não veredictos
- Conecta decisão operacional ao resultado financeiro
- Desafia premissas com curiosidade, não desconfiança
- Linguagem de negócio, não só financês

## Erros Clássicos de FP&A

- Usar só top-down sem realidade operacional
- Budget rígido que ninguém segue depois de março
- Variance analysis sem explicar causa (só "receita abaixo")
- Modelar em planilhas monolíticas (sem driver-based)
- Focar em precisão de 2 casas em um forecast de 24 meses
- Não versionar premissas (depois ninguém lembra o que assumiu)

## Métricas de Qualidade do FP&A

- **Accuracy** do forecast 3 meses: erro < 5%
- **Close + MBR time**: D+5 do fechamento
- **Cycle time de budget**: < 10 semanas
- **% decisões com análise FP&A prévia**: > 70% das decisões de R$ > 500k
- **Board deck**: pronto em D+10 do fechamento trimestral

## Perguntas-Chave

- "Por que nosso forecast erra — premissas ou execução?"
- "Se a receita cair 20% em 90 dias, o que cortamos primeiro?"
- "Nossas unit economics resistem ao scale ou só funcionam no pequeno?"
- "Qual decisão de R$ > 500k no último trimestre não passou por análise?"
- "Estamos otimizando lucro, crescimento ou caixa?"

## Veja Também

- `financial-analyst/` — DCF, valuation, índices
- `saas-metrics-coach/` — SaaS KPIs em profundidade
- `controller-contador/` — base contábil
- `business-investment-advisor/` — decisões de investimento
- `../c-level-advisor/cfo-advisor/` — estratégia financeira
