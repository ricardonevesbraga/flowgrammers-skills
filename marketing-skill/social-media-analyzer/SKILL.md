---
name: "social-media-analyzer"
description: Análise de campanhas de mídia social e rastreamento de desempenho. Calcula taxas de engajamento, ROI e benchmarks entre plataformas. Use para analisar desempenho de mídia social, calcular taxa de engajamento, medir ROI de campanha, comparar métricas de plataforma ou fazer benchmark de engajamento contra padrões do setor.
triggers:
  - analyze social media
  - calculate engagement rate
  - social media ROI
  - campaign performance
  - compare platforms
  - benchmark engagement
  - Instagram analytics
  - Facebook metrics
  - TikTok performance
  - LinkedIn engagement
agents:
  - claude-code
---

# Analisador de Mídia Social

Análise de desempenho de campanhas com métricas de engajamento, cálculos de ROI e benchmarks de plataforma.

---

## Sumário

- [Fluxo de Trabalho de Análise](#analysis-workflow)
- [Métricas de Engajamento](#engagement-metrics)
- [Cálculo de ROI](#roi-calculation)
- [Benchmarks de Plataforma](#platform-benchmarks)
- [Ferramentas](#tools)
- [Exemplos](#examples)

---

## Fluxo de Trabalho de Análise

Analise o desempenho de campanhas de mídia social:

1. Validar completude dos dados de entrada (alcance > 0, datas válidas)
2. Calcular métricas de engajamento por post
3. Agregar métricas a nível de campanha
4. Calcular ROI se gasto com anúncios fornecido
5. Comparar com benchmarks de plataforma
6. Identificar os melhores e piores performers
7. Gerar recomendações
8. **Validação:** Taxa de engajamento < 100%, ROI corresponde aos dados de gasto

### Requisitos de Entrada

| Campo | Obrigatório | Descrição |
|-------|------------|-----------|
| platform | Sim | instagram, facebook, twitter, linkedin, tiktok |
| posts[] | Sim | Array de dados de post |
| posts[].likes | Sim | Contagem de curtidas/reações |
| posts[].comments | Sim | Contagem de comentários |
| posts[].reach | Sim | Usuários únicos alcançados |
| posts[].impressions | Não | Total de visualizações |
| posts[].shares | Não | Contagem de compartilhamentos/retweets |
| posts[].saves | Não | Contagem de salvamentos/bookmarks |
| posts[].clicks | Não | Cliques em links |
| total_spend | Não | Gasto com anúncios (para ROI) |

### Verificações de Validação de Dados

Antes da análise, verifique:

- [ ] Alcance > 0 para todos os posts (evitar divisão por zero)
- [ ] Contagens de engajamento são não negativas
- [ ] Intervalo de datas é válido (início < fim)
- [ ] Plataforma é reconhecida
- [ ] Gasto > 0 se ROI solicitado

---

## Métricas de Engajamento

### Cálculo da Taxa de Engajamento

```
Taxa de Engajamento = (Curtidas + Comentários + Compartilhamentos + Salvamentos) / Alcance × 100
```

### Definições de Métricas

| Métrica | Fórmula | Interpretação |
|---------|---------|---------------|
| Taxa de Engajamento | Engajamentos / Alcance × 100 | Nível de interação da audiência |
| CTR | Cliques / Impressões × 100 | Apelo de clique do conteúdo |
| Taxa de Alcance | Alcance / Seguidores × 100 | Distribuição do conteúdo |
| Taxa de Viralidade | Compartilhamentos / Impressões × 100 | Capacidade de compartilhamento |
| Taxa de Salvamento | Salvamentos / Alcance × 100 | Valor do conteúdo |

### Categorias de Desempenho

| Classificação | Taxa de Engajamento | Ação |
|--------------|---------------------|------|
| Excelente | > 6% | Escale e replique |
| Bom | 3-6% | Otimize e expanda |
| Médio | 1-3% | Teste melhorias |
| Ruim | < 1% | Analise e pivote |

---

## Cálculo de ROI

Calcule o retorno sobre o gasto com anúncios:

1. Some o total de engajamentos entre posts
2. Calcule custo por engajamento (CPE)
3. Calcule custo por clique (CPC) se cliques disponíveis
4. Estime o valor do engajamento usando taxas de benchmark
5. Calcule porcentagem de ROI
6. **Validação:** ROI = (Valor - Gasto) / Gasto × 100

### Fórmulas de ROI

| Métrica | Fórmula |
|---------|---------|
| Custo Por Engajamento (CPE) | Gasto Total / Engajamentos Totais |
| Custo Por Clique (CPC) | Gasto Total / Cliques Totais |
| Custo Por Mil (CPM) | (Gasto / Impressões) × 1000 |
| Retorno sobre Gasto com Anúncios (ROAS) | Receita / Gasto com Anúncios |

### Estimativas de Valor de Engajamento

| Ação | Valor (R$) | Justificativa |
|------|-----------|--------------|
| Curtida | R$2,50 | Reconhecimento de marca |
| Comentário | R$10,00 | Engajamento ativo |
| Compartilhamento | R$25,00 | Amplificação |
| Salvamento | R$15,00 | Sinal de intenção |
| Clique | R$7,50 | Valor de tráfego |

### Interpretação de ROI

| ROI % | Classificação | Recomendação |
|-------|--------------|-------------|
| > 500% | Excelente | Escale o orçamento significativamente |
| 200-500% | Bom | Aumente o orçamento moderadamente |
| 100-200% | Aceitável | Otimize antes de escalar |
| 0-100% | Break-even | Revise segmentação e criativo |
| < 0% | Negativo | Pause e reestruture |

---

## Benchmarks de Plataforma

### Taxa de Engajamento por Plataforma

| Plataforma | Média | Boa | Excelente |
|----------|-------|-----|-----------|
| Instagram | 1,22% | 3-6% | >6% |
| Facebook | 0,07% | 0,5-1% | >1% |
| Twitter/X | 0,05% | 0,1-0,5% | >0,5% |
| LinkedIn | 2,0% | 3-5% | >5% |
| TikTok | 5,96% | 8-15% | >15% |

### CTR por Plataforma

| Plataforma | Média | Boa | Excelente |
|----------|-------|-----|-----------|
| Instagram | 0,22% | 0,5-1% | >1% |
| Facebook | 0,90% | 1,5-2,5% | >2,5% |
| LinkedIn | 0,44% | 1-2% | >2% |
| TikTok | 0,30% | 0,5-1% | >1% |

### CPC por Plataforma

| Plataforma | Média | Bom |
|----------|-------|-----|
| Facebook | R$4,85 | <R$2,50 |
| Instagram | R$6,00 | <R$3,50 |
| LinkedIn | R$26,30 | <R$15,00 |
| TikTok | R$5,00 | <R$2,50 |

Veja `references/platform-benchmarks.md` para dados completos de benchmark.

---

## Ferramentas

### Calcular Métricas

```bash
python scripts/calculate_metrics.py assets/sample_input.json
```

Calcula taxa de engajamento, CTR, taxa de alcance para cada post e totais da campanha.

### Analisar Desempenho

```bash
python scripts/analyze_performance.py assets/sample_input.json
```

Gera análise completa de desempenho com ROI, benchmarks e recomendações.

**A saída inclui:**
- Métricas a nível de campanha
- Breakdown post por post
- Comparações de benchmark
- Top performers rankeados
- Recomendações acionáveis

---

## Exemplos

### Entrada de Exemplo

Veja `assets/sample_input.json`:

```json
{
  "platform": "instagram",
  "total_spend": 2500,
  "posts": [
    {
      "post_id": "post_001",
      "content_type": "image",
      "likes": 342,
      "comments": 28,
      "shares": 15,
      "saves": 45,
      "reach": 5200,
      "impressions": 8500,
      "clicks": 120
    }
  ]
}
```

### Saída de Exemplo

Veja `assets/expected_output.json`:

```json
{
  "campaign_metrics": {
    "total_engagements": 1521,
    "avg_engagement_rate": 8.36,
    "ctr": 1.55
  },
  "roi_metrics": {
    "total_spend": 2500.0,
    "cost_per_engagement": 1.64,
    "roi_percentage": 660.5
  },
  "insights": {
    "overall_health": "excellent",
    "benchmark_comparison": {
      "engagement_status": "excellent",
      "engagement_benchmark": "1.22%",
      "engagement_actual": "8.36%"
    }
  }
}
```

### Interpretação

A campanha de exemplo mostra:
- **Taxa de engajamento 8,36%** vs benchmark de 1,22% = Excelente (6,8x acima da média)
- **CTR 1,55%** vs benchmark de 0,22% = Excelente (7x acima da média)
- **ROI 660%** = Retorno excepcional sobre R$2.500 de gasto
- **Recomendação:** Escale o orçamento, replique elementos bem-sucedidos

---

## Documentação de Referência

### Benchmarks de Plataforma

`references/platform-benchmarks.md` contém:

- Benchmarks de taxa de engajamento por plataforma e setor
- Benchmarks de CTR para conteúdo orgânico e pago
- Benchmarks de custo (CPC, CPM, CPE)
- Desempenho de tipo de conteúdo por plataforma
- Horários e frequências ideais de postagem
- Fórmulas de cálculo de ROI

## Gatilhos Proativos

- **Taxa de engajamento abaixo da média da plataforma** → Conteúdo não está ressoando. Analise os top performers para padrões.
- **Crescimento de seguidores estagnado** → Problema de distribuição ou frequência de conteúdo. Audite padrões de postagem.
- **Muitas impressões, baixo engajamento** → Alcance sem ressonância. Problema de qualidade do conteúdo.
- **Concorrente com desempenho significativamente superior** → Lacuna de conteúdo. Analise os posts bem-sucedidos deles.

## Artefatos de Saída

| Quando você pede... | Você recebe... |
|---------------------|----------------|
| "Auditoria de mídia social" | Análise de desempenho entre plataformas com benchmarks |
| "O que está performando?" | Análise de conteúdo top com padrões e recomendações |
| "Análise social do concorrente" | Comparação de mídia social competitiva com lacunas |

## Comunicação

Toda saída passa por verificação de qualidade:
- Autovalidação: atribuição de fonte, auditoria de suposições, pontuação de confiança
- Formato de saída: Conclusão → O quê (com confiança) → Por quê → Como Agir
- Apenas resultados. Cada descoberta marcada: 🟢 verificado, 🟡 médio, 🔴 assumido.

## Skills Relacionadas

- **social-content**: Para criar posts sociais. Use esta skill para analisar desempenho.
- **campaign-analytics**: Para analytics multicanal incluindo social.
- **content-strategy**: Para planejar temas de conteúdo social.
- **marketing-context**: Fornece contexto de audiência para melhor análise.
