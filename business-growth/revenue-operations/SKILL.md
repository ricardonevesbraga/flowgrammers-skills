---
name: "revenue-operations"
description: Analisa saúde do pipeline de vendas, precisão de previsão de receita e métricas de eficiência go-to-market para otimização de receita SaaS. Use ao analisar cobertura do pipeline de vendas, prever receita, avaliar desempenho go-to-market, revisar métricas de vendas, avaliar análise de pipeline, rastrear precisão de previsão com MAPE, calcular eficiência GTM ou medir eficiência de vendas e unit economics para equipes SaaS.
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Revenue Operations

Análise de pipeline, rastreamento de precisão de previsão e medição de eficiência GTM para equipes de receita SaaS.

> **Formatos de saída:** Todos os scripts suportam `--format text` (legível por humanos) e `--format json` (painéis/integrações).

---

## Início Rápido

```bash
# Analisar saúde e cobertura do pipeline
python scripts/pipeline_analyzer.py --input assets/sample_pipeline_data.json --format text

# Rastrear precisão de previsão ao longo de múltiplos períodos
python scripts/forecast_accuracy_tracker.py assets/sample_forecast_data.json --format text

# Calcular métricas de eficiência GTM
python scripts/gtm_efficiency_calculator.py assets/sample_gtm_data.json --format text
```

---

## Visão Geral das Ferramentas

### 1. Analisador de Pipeline

Analisa saúde do pipeline de vendas incluindo taxas de cobertura, taxas de conversão por estágio, velocidade de negócio, riscos de envelhecimento e riscos de concentração.

**Entrada:** Arquivo JSON com negócios, cota e configuração de estágio
**Saída:** Taxas de cobertura, taxas de conversão, métricas de velocidade, sinalizações de envelhecimento, avaliação de riscos

**Uso:**

```bash
python scripts/pipeline_analyzer.py --input pipeline.json --format text
```

**Principais Métricas Calculadas:**
- **Taxa de Cobertura do Pipeline** — Valor total do pipeline / meta de cota (saudável: 3-4x)
- **Taxas de Conversão por Estágio** — Taxas de progressão de estágio para estágio
- **Velocidade de Vendas** — (Oportunidades x Tamanho Médio do Negócio x Taxa de Vitória) / Ciclo Médio de Vendas
- **Envelhecimento de Negócios** — Sinaliza negócios que excedem 2x o tempo médio de ciclo por estágio
- **Risco de Concentração** — Avisa quando >40% do pipeline está em um único negócio
- **Análise de Lacuna de Cobertura** — Identifica trimestres com pipeline insuficiente

**Schema de Entrada:**

```json
{
  "quota": 500000,
  "stages": ["Discovery", "Qualification", "Proposal", "Negotiation", "Closed Won"],
  "average_cycle_days": 45,
  "deals": [
    {
      "id": "D001",
      "name": "Empresa ABC",
      "stage": "Proposal",
      "value": 85000,
      "age_days": 32,
      "close_date": "2025-03-15",
      "owner": "rep_1"
    }
  ]
}
```

### 2. Rastreador de Precisão de Previsão

Rastreia a precisão da previsão ao longo do tempo usando MAPE, detecta viés sistemático, analisa tendências e fornece breakdowns por categoria.

**Entrada:** Arquivo JSON com períodos de previsão e breakdowns por categoria opcionais
**Saída:** Pontuação MAPE, análise de viés, tendências, breakdown por categoria, classificação de precisão

**Uso:**

```bash
python scripts/forecast_accuracy_tracker.py forecast_data.json --format text
```

**Principais Métricas Calculadas:**
- **MAPE** — mean(|real - previsão| / |real|) x 100
- **Viés de Previsão** — Tendência de superprevisão (positiva) vs. subprevisão (negativa)
- **Precisão Ponderada** — MAPE ponderado pelo valor do negócio para materialidade
- **Tendências de Período** — Precisão melhorando, estável ou declinando ao longo do tempo
- **Breakdown por Categoria** — Precisão por representante, produto, segmento ou qualquer dimensão personalizada

**Classificações de Precisão:**
| Classificação | Faixa de MAPE | Interpretação |
|--------|-----------|----------------|
| Excelente | <10% | Altamente previsível, processo orientado por dados |
| Bom | 10-15% | Previsão confiável com variância menor |
| Regular | 15-25% | Necessita de melhoria de processo |
| Ruim | >25% | Lacunas significativas na metodologia de previsão |

**Schema de Entrada:**

```json
{
  "forecast_periods": [
    {"period": "2025-Q1", "forecast": 480000, "actual": 520000},
    {"period": "2025-Q2", "forecast": 550000, "actual": 510000}
  ],
  "category_breakdowns": {
    "by_rep": [
      {"category": "Rep A", "forecast": 200000, "actual": 210000},
      {"category": "Rep B", "forecast": 280000, "actual": 310000}
    ]
  }
}
```

### 3. Calculadora de Eficiência GTM

Calcula métricas de eficiência GTM SaaS principais com benchmarking do setor, classificações e recomendações de melhoria.

**Entrada:** Arquivo JSON com métricas de receita, custo e cliente
**Saída:** Magic Number, LTV:CAC, Payback do CAC, Burn Multiple, Regra dos 40, NDR com classificações

**Uso:**

```bash
python scripts/gtm_efficiency_calculator.py gtm_data.json --format text
```

**Principais Métricas Calculadas:**

| Métrica | Fórmula | Meta |
|--------|---------|--------|
| Magic Number | ARR Líquido Novo / Gasto S&M Período Anterior | >0,75 |
| LTV:CAC | (ARPA x Margem Bruta / Taxa de Churn) / CAC | >3:1 |
| Payback do CAC | CAC / (ARPA x Margem Bruta) meses | <18 meses |
| Burn Multiple | Queima Líquida / ARR Líquido Novo | <2x |
| Regra dos 40 | % Crescimento de Receita + % Margem FCF | >40% |
| Retenção Líquida em Dólares | (ARR Inicial + Expansão - Contração - Churn) / ARR Inicial | >110% |

**Schema de Entrada:**

```json
{
  "revenue": {
    "current_arr": 5000000,
    "prior_arr": 3800000,
    "net_new_arr": 1200000,
    "arpa_monthly": 2500,
    "revenue_growth_pct": 31.6
  },
  "costs": {
    "sales_marketing_spend": 1800000,
    "cac": 18000,
    "gross_margin_pct": 78,
    "total_operating_expense": 6500000,
    "net_burn": 1500000,
    "fcf_margin_pct": 8.4
  },
  "customers": {
    "beginning_arr": 3800000,
    "expansion_arr": 600000,
    "contraction_arr": 100000,
    "churned_arr": 300000,
    "annual_churn_rate_pct": 8
  }
}
```

---

## Fluxos de Trabalho de Revenue Operations

### Revisão Semanal do Pipeline

Usar este fluxo de trabalho para sua cadência semanal de inspeção do pipeline.

1. **Verificar dados de entrada:** Confirmar que a exportação do pipeline está atual e que todos os campos obrigatórios (estágio, valor, data de fechamento, responsável) estão preenchidos antes de prosseguir.

2. **Gerar relatório do pipeline:**
   ```bash
   python scripts/pipeline_analyzer.py --input current_pipeline.json --format text
   ```

3. **Verificar totais de saída** contra seu sistema CRM de origem para confirmar integridade dos dados.

4. **Revisar indicadores principais:**
   - Taxa de cobertura do pipeline (está acima de 3x da cota?)
   - Negócios envelhecendo além do limiar (quais negócios precisam de intervenção?)
   - Risco de concentração (estamos muito dependentes de poucos grandes negócios?)
   - Distribuição por estágio (há uma forma saudável de funil?)

5. **Documentar usando template:** Usar `assets/pipeline_review_template.md`

6. **Itens de ação:** Abordar negócios envelhecendo, redistribuir concentração do pipeline, preencher lacunas de cobertura

### Revisão de Precisão de Previsão

Usar mensalmente ou trimestralmente para avaliar e melhorar a disciplina de previsão.

1. **Verificar dados de entrada:** Confirmar que todos os períodos de previsão têm reais correspondentes e nenhum período está faltando antes de executar.

2. **Gerar relatório de precisão:**
   ```bash
   python scripts/forecast_accuracy_tracker.py forecast_history.json --format text
   ```

3. **Verificar reais** contra registros de negócios ganhos em seu CRM antes de tirar conclusões.

4. **Analisar padrões:**
   - O MAPE está diminuindo (melhorando)?
   - Quais representantes ou segmentos têm as maiores taxas de erro?
   - Há superprevisão ou subprevisão sistemática?

5. **Documentar usando template:** Usar `assets/forecast_report_template.md`

6. **Ações de melhoria:** Treinar representantes com viés alto, ajustar metodologia, melhorar higiene de dados

### Auditoria de Eficiência GTM

Usar trimestralmente ou durante preparação de board para avaliar eficiência go-to-market.

1. **Verificar dados de entrada:** Confirmar que os valores de receita, custo e cliente reconciliam com registros financeiros antes de executar.

2. **Calcular métricas de eficiência:**
   ```bash
   python scripts/gtm_efficiency_calculator.py quarterly_data.json --format text
   ```

3. **Verificar totais calculados de ARR e gastos** contra seu sistema financeiro antes de compartilhar resultados.

4. **Avaliar desempenho em relação às metas:**
   - Magic Number (>0,75)
   - LTV:CAC (>3:1)
   - Payback do CAC (<18 meses)
   - Regra dos 40 (>40%)

5. **Documentar usando template:** Usar `assets/gtm_dashboard_template.md`

6. **Decisões estratégicas:** Ajustar alocação de gastos, otimizar canais, melhorar retenção

### Quarterly Business Review

Combinar todas as três ferramentas para uma análise completa de QBR.

1. Executar analisador de pipeline para cobertura prospectiva
2. Executar rastreador de previsão para precisão retrospectiva
3. Executar calculadora GTM para benchmarks de eficiência
4. Cruzar saúde do pipeline com precisão de previsão
5. Alinhar métricas de eficiência GTM com metas de crescimento

---

## Documentação de Referência

| Referência | Descrição |
|-----------|-------------|
| [Guia de Métricas RevOps](references/revops-metrics-guide.md) | Hierarquia completa de métricas, definições, fórmulas e interpretação |
| [Framework de Gestão de Pipeline](references/pipeline-management-framework.md) | Melhores práticas de pipeline, definições de estágio, benchmarks de conversão |
| [Benchmarks de Eficiência GTM](references/gtm-efficiency-benchmarks.md) | Benchmarks SaaS por estágio, padrões do setor, estratégias de melhoria |

---

## Templates

| Template | Caso de Uso |
|----------|----------|
| [Template de Revisão do Pipeline](assets/pipeline_review_template.md) | Documentação de inspeção semanal/mensal do pipeline |
| [Template de Relatório de Previsão](assets/forecast_report_template.md) | Relatório de precisão de previsão e análise de tendências |
| [Template de Dashboard GTM](assets/gtm_dashboard_template.md) | Painel de eficiência GTM para revisão da liderança |
| [Dados de Pipeline de Amostra](assets/sample_pipeline_data.json) | Entrada de exemplo para pipeline_analyzer.py |
| [Saída Esperada](assets/expected_output.json) | Saída de referência de pipeline_analyzer.py |
