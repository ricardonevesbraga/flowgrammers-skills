---
name: "campaign-analytics"
description: Analisa a performance de campanhas com atribuição multi-touch, análise de conversão do funil e cálculo de ROI para otimização de marketing. Use ao analisar campanhas de marketing, performance de anúncios, modelos de atribuição, taxas de conversão ou ao calcular ROI, ROAS, CPA e métricas de campanha entre canais.
license: MIT
metadata:
  version: 1.0.0
  author: Ric Neves - Flowgrammers
  category: marketing
  domain: campaign-analytics
  updated: 2026-02-06
  tech-stack: marketing-analytics, attribution-modeling
agents:
  - claude-code
---

# Analytics de Campanha

Análise de performance de campanhas com modelagem de atribuição multi-touch, análise de conversão do funil e cálculo de ROI de nível produção. Três ferramentas Python CLI fornecem analytics determinísticos e repetíveis usando apenas a biblioteca padrão — sem dependências externas, sem chamadas de API, sem modelos de ML.

---

## Requisitos de Entrada

Todos os scripts aceitam um arquivo JSON como argumento de entrada posicional. Veja `assets/sample_campaign_data.json` para exemplos completos.

### Attribution Analyzer

```json
{
  "journeys": [
    {
      "journey_id": "j1",
      "touchpoints": [
        {"channel": "organic_search", "timestamp": "2025-10-01T10:00:00", "interaction": "click"},
        {"channel": "email", "timestamp": "2025-10-05T14:30:00", "interaction": "open"},
        {"channel": "paid_search", "timestamp": "2025-10-08T09:15:00", "interaction": "click"}
      ],
      "converted": true,
      "revenue": 500.00
    }
  ]
}
```

### Funnel Analyzer

```json
{
  "funnel": {
    "stages": ["Consciência", "Interesse", "Consideração", "Intenção", "Compra"],
    "counts": [10000, 5200, 2800, 1400, 420]
  }
}
```

### Campaign ROI Calculator

```json
{
  "campaigns": [
    {
      "name": "Campanha de Email Primavera",
      "channel": "email",
      "spend": 5000.00,
      "revenue": 25000.00,
      "impressions": 50000,
      "clicks": 2500,
      "leads": 300,
      "customers": 45
    }
  ]
}
```

### Validação de Entrada

Antes de executar os scripts, verifique se seu JSON é válido e corresponde ao schema esperado. Erros comuns:

- **Chaves obrigatórias ausentes** (ex.: `journeys`, `funnel.stages`, `campaigns`) → script sai com um `KeyError` descritivo
- **Comprimentos de array incompatíveis** nos dados do funil (`stages` e `counts` devem ter o mesmo comprimento) → levanta `ValueError`
- **Valores monetários não numéricos** nos dados de ROI → levanta `TypeError`

Use `python -m json.tool seu_arquivo.json` para validar a sintaxe JSON antes de passar para qualquer script.

---

## Formatos de Saída

Todos os scripts suportam dois formatos de saída via flag `--format`:

- `--format text` (padrão): Tabelas e resumos legíveis por humanos para revisão
- `--format json`: JSON legível por máquina para integrações e pipelines

---

## Fluxo de Trabalho Típico de Análise

Para uma revisão completa de campanha, execute os três scripts em sequência:

```bash
# Passo 1 — Atribuição: entender quais canais impulsionam conversões
python scripts/attribution_analyzer.py campaign_data.json --model time-decay

# Passo 2 — Funil: identificar onde os prospects desistem no caminho para a conversão
python scripts/funnel_analyzer.py funnel_data.json

# Passo 3 — ROI: calcular lucratividade e comparar com benchmarks do setor
python scripts/campaign_roi_calculator.py campaign_data.json
```

Use os resultados de atribuição para identificar os canais de melhor desempenho, depois concentre a análise do funil nos segmentos desses canais, e por fim valide as métricas de ROI para priorizar a realocação de budget.

---

## Como Usar

### Análise de Atribuição

```bash
# Execute todos os 5 modelos de atribuição
python scripts/attribution_analyzer.py campaign_data.json

# Execute um modelo específico
python scripts/attribution_analyzer.py campaign_data.json --model time-decay

# Saída JSON para integração com pipeline
python scripts/attribution_analyzer.py campaign_data.json --format json

# Meia-vida personalizada para time-decay (padrão: 7 dias)
python scripts/attribution_analyzer.py campaign_data.json --model time-decay --half-life 14
```

### Análise de Funil

```bash
# Análise básica do funil
python scripts/funnel_analyzer.py funnel_data.json

# Saída JSON
python scripts/funnel_analyzer.py funnel_data.json --format json
```

### Cálculo de ROI de Campanha

```bash
# Calcular métricas de ROI para todas as campanhas
python scripts/campaign_roi_calculator.py campaign_data.json

# Saída JSON
python scripts/campaign_roi_calculator.py campaign_data.json --format json
```

---

## Scripts

### 1. attribution_analyzer.py

Implementa cinco modelos de atribuição padrão do setor para alocar crédito de conversão entre canais de marketing:

| Modelo | Descrição | Melhor Para |
|--------|-----------|------------|
| First-Touch | 100% de crédito para a primeira interação | Campanhas de conscientização de marca |
| Last-Touch | 100% de crédito para a última interação | Campanhas de resposta direta |
| Linear | Crédito igual para todos os pontos de contato | Avaliação equilibrada multi-canal |
| Time-Decay | Mais crédito para pontos de contato recentes | Ciclos de vendas curtos |
| Position-Based | Divisão 40/20/40 (primeiro/meio/último) | Marketing de funil completo |

### 2. funnel_analyzer.py

Analisa funis de conversão para identificar gargalos e oportunidades de otimização:

- Taxas de conversão estágio a estágio e porcentagens de abandono
- Identificação automática de gargalos (maiores quedas absolutas e relativas)
- Taxa de conversão geral do funil
- Comparação de segmento quando múltiplos segmentos são fornecidos

### 3. campaign_roi_calculator.py

Calcula métricas abrangentes de ROI com benchmarking do setor:

- **ROI**: Porcentagem de retorno sobre investimento
- **ROAS**: Razão de retorno sobre o gasto em anúncios
- **CPA**: Custo por aquisição
- **CPL**: Custo por lead
- **CAC**: Custo de aquisição de cliente
- **CTR**: Taxa de cliques
- **CVR**: Taxa de conversão (leads para clientes)
- Sinaliza campanhas com desempenho abaixo dos benchmarks do setor

---

## Guias de Referência

| Guia | Local | Propósito |
|------|-------|-----------|
| Guia de Modelos de Atribuição | `references/attribution-models-guide.md` | Mergulho profundo nos 5 modelos com fórmulas, prós/contras, critérios de seleção |
| Benchmarks de Métricas de Campanha | `references/campaign-metricas-benchmarks.md` | Benchmarks do setor por canal e vertical para CTR, CPC, CPM, CPA, ROAS |
| Framework de Otimização de Funil | `references/funil-optimization-framework.md` | Estratégias de otimização estágio por estágio, gargalos comuns, melhores práticas |

---

## Melhores Práticas

1. **Use múltiplos modelos de atribuição** — Compare pelo menos 3 modelos para triangular o valor do canal; nenhum modelo único conta a história completa.
2. **Defina janelas de lookback apropriadas** — Combine sua meia-vida de time-decay com o comprimento médio do seu ciclo de vendas.
3. **Segmente seus funis** — Compare segmentos (canal, coorte, geografia) para identificar drivers de performance.
4. **Avalie o desempenho contra seu próprio histórico primeiro** — Benchmarks do setor fornecem contexto, mas dados históricos são a comparação mais relevante.
5. **Execute análise de ROI em intervalos regulares** — Semanalmente para campanhas ativas, mensalmente para revisão.
6. **Inclua todos os custos** — Considere custos de criativo, ferramentas e mão-de-obra junto com o gasto em mídia para um ROI preciso.
7. **Documente testes A/B rigorosamente** — Use o template fornecido para garantir validade estatística e critérios de decisão claros.

---

## Limitações

- **Sem testes de significância estatística** — Scripts fornecem apenas métricas descritivas; cálculos de valor-p requerem ferramentas externas.
- **Somente biblioteca padrão** — Sem bibliotecas estatísticas avançadas. Adequado para a maioria dos tamanhos de campanha, mas não otimizado para datasets acima de 100K jornadas.
- **Análise offline** — Scripts analisam snapshots JSON estáticos; sem conexões de dados em tempo real ou integrações de API.
- **Moeda única** — Todos os valores monetários assumidos na mesma moeda (BRL por padrão); sem suporte a conversão de moeda.
- **Time-decay simplificado** — Decaimento exponencial baseado em meia-vida configurável; não considera padrões de dia de semana/fim de semana ou sazonais.
- **Sem rastreamento entre dispositivos** — Atribuição opera nos dados de jornada fornecidos como estão; resolução de identidade entre dispositivos deve ser tratada upstream.

## Skills Relacionadas

- **analytics-tracking**: Para configurar rastreamento. NÃO para analisar dados (isso é esta skill).
- **ab-test-setup**: Para projetar experimentos para testar o que o analytics revela.
- **marketing-ops**: Para rotear insights para a skill de execução correta.
- **paid-ads**: Para otimizar o gasto em anúncios com base nas descobertas do analytics.
