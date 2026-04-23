---
name: product-analytics
description: Use ao definir KPIs de produto, construir dashboards de métricas, executar análise de coorte ou retenção, ou interpretar tendências de adoção de funcionalidades em diferentes estágios de produto.
agents:
  - claude-code
---

# Analytics de Produto

Definir, rastrear e interpretar métricas de produto em estágios de descoberta, crescimento e produto maduro.

## Quando Usar

Use esta skill para:
- Seleção de framework de métricas (AARRR, North Star, HEART)
- Definição de KPI por estágio de produto (pré-PMF, crescimento, maduro)
- Design de dashboard e hierarquia de métricas
- Análise de coorte e retenção
- Adoção de funcionalidades e interpretação de funil

## Fluxo de Trabalho

1. Selecionar framework de métricas
- AARRR para loops de crescimento e visibilidade de funil
- North Star para alinhamento estratégico interfuncional
- HEART para qualidade de UX e medição de experiência do usuário

2. Definir KPIs adequados ao estágio
- Pré-PMF: ativação, retenção inicial, sucesso qualitativo
- Crescimento: eficiência de aquisição, expansão, velocidade de conversão
- Maduro: profundidade de retenção, qualidade de receita, eficiência operacional

3. Projetar camadas do dashboard
- Camada executiva: 5-7 métricas direcionais
- Camada de saúde do produto: aquisição, ativação, retenção, engajamento
- Camada de funcionalidade: adoção, profundidade, uso repetido, correlação de resultado

4. Executar análise de coorte + retenção
- Segmentar por coorte de cadastro ou coorte de exposição a funcionalidade
- Comparar curvas de retenção, não snapshots de ponto único
- Identificar pontos de inflexão em torno do onboarding e primeiro momento de valor

5. Interpretar e agir
- Conectar movimento de métricas a mudanças de produto e linha do tempo de lançamento
- Distinguir sinal do ruído usando contexto período a período
- Propor uma ação de produto clara por risco/oportunidade de métrica principal

## Orientação de KPI por Estágio

### Pré-PMF
- Taxa de ativação
- Retenção na semana 1
- Tempo para primeiro valor
- Pontuação de entrevista de fit problema-solução

### Crescimento
- Conversão de funil por estágio
- Usuários retidos mensalmente
- Adoção de funcionalidades entre novos coortes
- Métricas proxy de expansão / upsell

### Maduro
- Métricas de produto alinhadas à retenção líquida de receita
- Participação de power users e profundidade de uso
- Indicadores de risco de churn por segmento
- Métricas de produto de confiabilidade e deflexão de suporte

## Princípios de Design de Dashboard

- Mostre tendências, não estimativas de ponto isoladas.
- Mantenha um responsável por KPI.
- Pareie cada KPI com meta, limiar e regra de decisão.
- Use filtros de coorte e segmento por padrão.
- Prefira janelas de tempo comparáveis (semanal vs semanal, mensal vs mensal).

Veja:
- `references/metrics-frameworks.md`
- `references/dashboard-templates.md`

## Método de Análise de Coorte

1. Definir evento âncora do coorte (cadastro, ativação, primeira compra).
2. Definir comportamento retido (dia ativo, ação principal, sessão repetida).
3. Construir matriz de retenção por semana/mês do coorte e período de idade.
4. Comparar formato de curva entre coortes.
5. Sinalizar pontos de queda iniciais e investigar fricção na jornada.

## Interpretação da Curva de Retenção

- Queda inicial acentuada, platô baixo: descompasso de onboarding ou valor inicial fraco.
- Queda moderada, platô estável: audiência principal saudável com churn previsível.
- Estabilizando em nível baixo: produto usado ocasionalmente, revisite a métrica de valor.
- Melhorando em coortes mais recentes: melhorias de onboarding ou posicionamento estão funcionando.

## Antipadrões

| Antipadrão | Correção |
|------------|----------|
| **Métricas de vaidade** — rastrear pageviews ou cadastros totais sem contexto de ativação | Sempre pareie métricas de aquisição com taxa de ativação e retenção |
| **Retenção de ponto único** — reportar "retenção de 30 dias é 20%" | Comparar curvas de retenção entre coortes, não snapshots isolados |
| **Sobrecarga de dashboard** — 30+ métricas em uma tela | Camada executiva: 5-7 métricas. Camada de funcionalidade: somente por funcionalidade |
| **Sem regra de decisão** — rastrear um KPI sem limiar ou plano de ação | Todo KPI precisa: meta, limiar, responsável e "se abaixo de X, então Y" |
| **Média entre segmentos** — reportar métricas combinadas que ocultam diferenças de segmento | Sempre segmente por coorte, tier de plano, canal ou geografia |
| **Ignorar sazonalidade** — comparar esta semana com a semana passada sem ajuste | Use contexto período a período com mesma semana do ano anterior |

## Ferramentas

### `scripts/metrics_calculator.py`

Utilitário CLI para análise de retenção, coorte e funil a partir de dados CSV. Suporta saída em texto e JSON.

```bash
# Análise de retenção
python3 scripts/metrics_calculator.py retention events.csv
python3 scripts/metrics_calculator.py retention events.csv --format json

# Matriz de coorte
python3 scripts/metrics_calculator.py cohort events.csv --cohort-grain month
python3 scripts/metrics_calculator.py cohort events.csv --cohort-grain week --format json

# Conversão de funil
python3 scripts/metrics_calculator.py funnel funnel.csv --stages visit,signup,activate,pay
python3 scripts/metrics_calculator.py funnel funnel.csv --stages visit,signup,activate,pay --format json
```

**Formato CSV para retenção/coorte:**
```csv
user_id,cohort_date,activity_date
u001,2026-01-01,2026-01-01
u001,2026-01-01,2026-01-03
u002,2026-01-02,2026-01-02
```

**Formato CSV para funil:**
```csv
user_id,stage
u001,visit
u001,signup
u001,activate
u002,visit
u002,signup
```

## Referências Cruzadas

- Relacionado: `product-team/experiment-designer` — para planejamento de teste A/B após identificar oportunidades de métrica
- Relacionado: `product-team/product-manager-toolkit` — para priorização RICE de funcionalidades orientadas por métricas
- Relacionado: `product-team/product-discovery` — para mapeamento de suposições quando métricas revelam desconhecidos
- Relacionado: `finance/saas-metrics-coach` — para métricas específicas de SaaS (ARR, MRR, churn, LTV)
