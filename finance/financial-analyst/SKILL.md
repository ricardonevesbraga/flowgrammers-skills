---
name: "financial-analyst"
description: Realiza análise de índices financeiros, avaliação DCF, análise de variação orçamentária e construção de previsões contínuas para tomada de decisões estratégicas. Use ao analisar demonstrações financeiras, construir modelos de avaliação, avaliar variações orçamentárias, ou construir projeções financeiras e previsões. Também aplicável quando os usuários mencionarem modelagem financeira, análise de fluxo de caixa, avaliação de empresa, projeções financeiras, or análise de planilhas.
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Skill de Analista Financeiro

## Visão Geral

Kit de análise financeira pronto para produção com análise de índices, avaliação DCF, análise de variação orçamentária e construção de previsões contínuas. Projetado para modelagem financeira, previsão e orçamentação, relatórios gerenciais, análise de desempenho empresarial e análise de investimentos.

## Fluxo de Trabalho em 5 Fases

### Fase 1: Escopo
- Definir objetivos de análise e requisitos das partes interessadas
- Identificar fontes de dados e períodos de tempo
- Estabelecer limites de materialidade e metas de precisão
- Selecionar frameworks analíticos apropriados

### Fase 2: Análise de Dados e Modelagem
- Coletar e validar dados financeiros (demonstração de resultados, balanço patrimonial, fluxo de caixa)
- **Validar a integridade dos dados de entrada** antes de executar os cálculos de índices (verificar campos ausentes, nulos ou valores implausíveis)
- Calcular índices financeiros em 5 categorias (rentabilidade, liquidez, alavancagem, eficiência, avaliação)
- Construir modelos DCF com WACC e cálculos de valor terminal; **verificar os resultados DCF contra limites de sanidade** (ex.: múltiplos implícitos vs. comparáveis)
- Construir análises de variação orçamentária com classificação favorável/desfavorável
- Desenvolver previsões baseadas em drivers com modelagem de cenários

### Fase 3: Geração de Insights
- Interpretar tendências dos índices e comparar com padrões do setor
- Identificar variações materiais e suas causas raiz
- Avaliar faixas de avaliação por meio de análise de sensibilidade
- Avaliar cenários de previsão (base/otimista/pessimista) para apoio à tomada de decisões

### Fase 4: Relatórios
- Gerar resumos executivos com as principais descobertas
- Produzir relatórios detalhados de variação por departamento e categoria
- Entregar relatórios de avaliação DCF com tabelas de sensibilidade
- Apresentar previsões contínuas com análise de tendências

### Fase 5: Acompanhamento
- Rastrear precisão das previsões (meta: +/-5% receita, +/-3% despesas)
- Monitorar pontualidade na entrega de relatórios (meta: 100% no prazo)
- Atualizar modelos com dados reais conforme disponibilizados
- Refinar premissas com base na análise de variação

## Ferramentas

### 1. Calculadora de Índices (`scripts/ratio_calculator.py`)

Calcula e interpreta índices financeiros a partir dos dados das demonstrações financeiras.

**Categorias de Índices:**
- **Rentabilidade:** ROE, ROA, Gross Margin, Operating Margin, Net Margin
- **Liquidez:** Current Ratio, Quick Ratio, Cash Ratio
- **Alavancagem:** Debt-to-Equity, Interest Coverage, DSCR
- **Eficiência:** Asset Turnover, Inventory Turnover, Receivables Turnover, DSO
- **Avaliação:** P/E, P/B, P/S, EV/EBITDA, PEG Ratio

```bash
python scripts/ratio_calculator.py sample_financial_data.json
python scripts/ratio_calculator.py sample_financial_data.json --format json
python scripts/ratio_calculator.py sample_financial_data.json --category profitability
```

### 2. Avaliação DCF (`scripts/dcf_valuation.py`)

Avaliação de empresa e patrimônio por Fluxo de Caixa Descontado com análise de sensibilidade.

**Funcionalidades:**
- Cálculo do WACC via CAPM
- Projeções de receita e fluxo de caixa livre (padrão de 5 anos)
- Valor terminal via crescimento em perpetuidade e métodos de múltiplo de saída
- Derivação de valor da empresa e valor patrimonial
- Análise de sensibilidade bidirecional (taxa de desconto vs taxa de crescimento)

```bash
python scripts/dcf_valuation.py valuation_data.json
python scripts/dcf_valuation.py valuation_data.json --format json
python scripts/dcf_valuation.py valuation_data.json --projection-years 7
```

### 3. Analisador de Variação Orçamentária (`scripts/budget_variance_analyzer.py`)

Analisar desempenho real vs orçado vs ano anterior com filtragem por materialidade.

**Funcionalidades:**
- Cálculo de variação em valores e percentuais
- Filtragem por limiar de materialidade (padrão: 10% ou R$50K)
- Classificação favorável/desfavorável com lógica de receita/despesa
- Detalhamento por departamento e categoria
- Geração de resumo executivo

```bash
python scripts/budget_variance_analyzer.py budget_data.json
python scripts/budget_variance_analyzer.py budget_data.json --format json
python scripts/budget_variance_analyzer.py budget_data.json --threshold-pct 5 --threshold-amt 25000
```

### 4. Construtor de Forecast (`scripts/forecast_builder.py`)

Previsão de receita baseada em drivers com projeção de fluxo de caixa contínua e modelagem de cenários.

**Funcionalidades:**
- Modelo de previsão de receita baseado em drivers
- Projeção de fluxo de caixa contínua de 13 semanas
- Modelagem de cenários (base/otimista/pessimista)
- Análise de tendências usando regressão linear simples (biblioteca padrão)

```bash
python scripts/forecast_builder.py forecast_data.json
python scripts/forecast_builder.py forecast_data.json --format json
python scripts/forecast_builder.py forecast_data.json --scenarios base,bull,bear
```

## Bases de Conhecimento

| Referência | Propósito |
|-----------|---------|
| `references/financial-ratios-guide.md` | Fórmulas de índices, interpretação e benchmarks do setor |
| `references/valuation-methodology.md` | Metodologia DCF, WACC, valor terminal e comparáveis |
| `references/forecasting-best-practices.md` | Previsão baseada em drivers, previsões contínuas, precisão |
| `references/industry-adaptations.md` | Métricas e considerações específicas por setor (SaaS, Varejo, Manufatura, Serviços Financeiros, Saúde) |

## Templates

| Template | Propósito |
|----------|---------|
| `assets/variance_report_template.md` | Template de relatório de variação orçamentária |
| `assets/dcf_analysis_template.md` | Template de análise de avaliação DCF |
| `assets/forecast_report_template.md` | Template de relatório de previsão de receita |

## Métricas e Metas Principais

| Métrica | Meta |
|--------|--------|
| Precisão da previsão (receita) | +/-5% |
| Precisão da previsão (despesas) | +/-3% |
| Entrega de relatórios | 100% no prazo |
| Documentação do modelo | Completa para todas as premissas |
| Explicação de variância | 100% das variações materiais |

## Formato de Dados de Entrada

Todos os scripts aceitam arquivos de entrada em JSON. Veja `assets/sample_financial_data.json` para o schema de entrada completo, cobrindo todas as quatro ferramentas.

## Dependências

**Nenhuma** - Todos os scripts usam apenas a biblioteca padrão do Python (`math`, `statistics`, `json`, `argparse`, `datetime`). Sem necessidade de numpy, pandas ou scipy.
