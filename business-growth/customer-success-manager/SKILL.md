---
name: "customer-success-manager"
description: Monitora saúde do cliente, prevê risco de churn e identifica oportunidades de expansão usando modelos de pontuação ponderada para sucesso do cliente SaaS. Use ao analisar contas de clientes, revisar métricas de retenção, pontuar clientes em risco, ou quando o usuário mencionar churn, pontuações de saúde do cliente, oportunidades de upsell, receita de expansão, análise de retenção ou análise de clientes. Executa três ferramentas Python CLI para produzir pontuações de saúde determinísticas, tiers de risco de churn e recomendações de expansão priorizadas em segmentos Enterprise, Mid-Market e PME.
license: MIT
author: Ric Neves - Flowgrammers
metadata:
  version: 1.0.0
  category: business-growth
  domain: customer-success
  updated: 2026-02-06
  tech-stack: customer-success, saas-metrics, health-scoring
agents:
  - claude-code
---

# Customer Success Manager

Analytics de sucesso do cliente de nível de produção com pontuação de saúde multidimensional, previsão de risco de churn e identificação de oportunidades de expansão. Três ferramentas Python CLI fornecem análise determinística e repetível usando apenas biblioteca padrão — sem dependências externas, sem chamadas de API, sem modelos de ML.

---

## Sumário

- [Requisitos de Entrada](#requisitos-de-entrada)
- [Formatos de Saída](#formatos-de-saída)
- [Como Usar](#como-usar)
- [Scripts](#scripts)
- [Guias de Referência](#guias-de-referência)
- [Templates](#templates)
- [Melhores Práticas](#melhores-práticas)
- [Limitações](#limitações)

---

## Requisitos de Entrada

Todos os scripts aceitam um arquivo JSON como argumento de entrada posicional. Veja `assets/sample_customer_data.json` para exemplos completos de schema e dados de amostra.

### Calculadora de Pontuação de Saúde

Campos obrigatórios por objeto de cliente: `customer_id`, `name`, `segment`, `arr` e objetos aninhados `usage` (login_frequency, feature_adoption, dau_mau_ratio), `engagement` (support_ticket_volume, meeting_attendance, nps_score, csat_score), `support` (open_tickets, escalation_rate, avg_resolution_hours), `relationship` (executive_sponsor_engagement, multi_threading_depth, renewal_sentiment) e pontuações `previous_period` para análise de tendências.

### Analisador de Risco de Churn

Campos obrigatórios por objeto de cliente: `customer_id`, `name`, `segment`, `arr`, `contract_end_date` e objetos aninhados `usage_decline`, `engagement_drop`, `support_issues`, `relationship_signals` e `commercial_factors`.

### Pontuador de Oportunidades de Expansão

Campos obrigatórios por objeto de cliente: `customer_id`, `name`, `segment`, `arr` e objetos aninhados `contract` (licensed_seats, active_seats, plan_tier, available_tiers), `product_usage` (sinalizações de adoção e percentuais de uso por módulo) e `departments` (atuais e potenciais).

---

## Formatos de Saída

Todos os scripts suportam dois formatos de saída via flag `--format`:

- **`text`** (padrão): Saída formatada legível por humanos para visualização no terminal
- **`json`**: Saída JSON legível por máquina para integrações e pipelines

---

## Como Usar

### Início Rápido

```bash
# Pontuação de saúde
python scripts/health_score_calculator.py assets/sample_customer_data.json
python scripts/health_score_calculator.py assets/sample_customer_data.json --format json

# Análise de risco de churn
python scripts/churn_risk_analyzer.py assets/sample_customer_data.json
python scripts/churn_risk_analyzer.py assets/sample_customer_data.json --format json

# Pontuação de oportunidades de expansão
python scripts/expansion_opportunity_scorer.py assets/sample_customer_data.json
python scripts/expansion_opportunity_scorer.py assets/sample_customer_data.json --format json
```

### Integração de Fluxo de Trabalho

```bash
# 1. Pontuar saúde do cliente em todo o portfólio
python scripts/health_score_calculator.py customer_portfolio.json --format json > health_results.json
# Verificar: confirmar que health_results.json contém o número esperado de registros de clientes antes de continuar

# 2. Identificar contas em risco
python scripts/churn_risk_analyzer.py customer_portfolio.json --format json > risk_results.json
# Verificar: confirmar que risk_results.json não está vazio e tiers de risco estão presentes para cada cliente

# 3. Encontrar oportunidades de expansão em contas saudáveis
python scripts/expansion_opportunity_scorer.py customer_portfolio.json --format json > expansion_results.json
# Verificar: confirmar que expansion_results.json lista oportunidades classificadas por prioridade

# 4. Preparar QBR usando templates
# Referência: assets/qbr_template.md
```

**Tratamento de erros:** Se um script sair com erro, verificar que:
- O JSON de entrada corresponde ao schema obrigatório para aquele script (veja Requisitos de Entrada acima)
- Todos os campos obrigatórios estão presentes e corretamente tipados
- Python 3.7+ está sendo usado (`python --version`)
- Arquivos de saída de etapas anteriores não estão vazios antes de canalizar para etapas seguintes

---

## Scripts

### 1. health_score_calculator.py

**Propósito:** Pontuação de saúde multidimensional do cliente com análise de tendências e benchmarking consciente do segmento.

**Dimensões e Pesos:**
| Dimensão | Peso | Métricas |
|-----------|--------|---------|
| Uso | 30% | Frequência de login, adoção de funcionalidade, proporção DAU/MAU |
| Engajamento | 25% | Volume de ticket de suporte, participação em reuniões, NPS/CSAT |
| Suporte | 20% | Tickets abertos, taxa de escalação, tempo médio de resolução |
| Relacionamento | 25% | Engajamento do patrocinador executivo, profundidade de multi-threading, sentimento de renovação |

**Classificação:**
- Verde (75-100): Saudável — cliente alcançando valor
- Amarelo (50-74): Precisa de atenção — monitorar de perto
- Vermelho (0-49): Em risco — intervenção imediata necessária

**Uso:**
```bash
python scripts/health_score_calculator.py customer_data.json
python scripts/health_score_calculator.py customer_data.json --format json
```

### 2. churn_risk_analyzer.py

**Propósito:** Identificar contas em risco com detecção de sinais comportamentais e recomendações de intervenção baseadas em tier.

**Pesos de Sinais de Risco:**
| Categoria de Sinal | Peso | Indicadores |
|----------------|--------|------------|
| Declínio de Uso | 30% | Tendência de login, mudança de adoção de funcionalidade, mudança de DAU/MAU |
| Queda de Engajamento | 25% | Cancelamentos de reunião, tempo de resposta, mudança de NPS |
| Problemas de Suporte | 20% | Escalações abertas, críticos não resolvidos, tendência de satisfação |
| Sinais de Relacionamento | 15% | Campeão saiu, mudança de patrocinador, menções de concorrente |
| Fatores Comerciais | 10% | Tipo de contrato, reclamações de preço, cortes de orçamento |

**Tiers de Risco:**
- Crítico (80-100): Escalação executiva imediata
- Alto (60-79): Intervenção urgente do CSM
- Médio (40-59): Contato proativo
- Baixo (0-39): Monitoramento padrão

**Uso:**
```bash
python scripts/churn_risk_analyzer.py customer_data.json
python scripts/churn_risk_analyzer.py customer_data.json --format json
```

### 3. expansion_opportunity_scorer.py

**Propósito:** Identificar oportunidades de upsell, cross-sell e expansão com estimativa de receita e classificação por prioridade.

**Tipos de Expansão:**
- **Upsell**: Upgrade para tier superior ou mais do produto existente
- **Cross-sell**: Adicionar novos módulos de produto
- **Expansão**: Assentos ou departamentos adicionais

**Uso:**
```bash
python scripts/expansion_opportunity_scorer.py customer_data.json
python scripts/expansion_opportunity_scorer.py customer_data.json --format json
```

---

## Guias de Referência

| Referência | Descrição |
|-----------|-------------|
| `references/health-scoring-framework.md` | Metodologia completa de pontuação de saúde, definições de dimensão, justificativa de ponderação, calibração de limiar |
| `references/cs-playbooks.md` | Playbooks de intervenção para cada tier de risco, integração, renovação, expansão e procedimentos de escalação |
| `references/cs-metrics-benchmarks.md` | Benchmarks do setor para NRR, GRR, taxa de cancelamento, pontuações de saúde, taxas de expansão por segmento e setor |

---

## Templates

| Template | Propósito |
|----------|---------|
| `assets/qbr_template.md` | Estrutura de apresentação de Quarterly Business Review |
| `assets/success_plan_template.md` | Plano de sucesso do cliente com metas, marcos e métricas |
| `assets/onboarding_checklist_template.md` | Lista de verificação de integração de 90 dias com gates de fase |
| `assets/executive_business_review_template.md` | Revisão de partes interessadas executivas para contas |

---

## Melhores Práticas

1. **Combinar sinais**: Usar todos os três scripts juntos para uma visão completa do cliente
2. **Agir sobre tendências, não instantâneos**: Um Verde em declínio é mais urgente do que um Amarelo estável
3. **Calibrar limiares**: Ajustar benchmarks de segmento com base no seu produto e setor conforme `references/health-scoring-framework.md`
4. **Preparar com dados**: Executar scripts antes de cada QBR e reunião executiva; referenciar `references/cs-playbooks.md` para orientação de intervenção

---

## Limitações

- **Sem dados em tempo real**: Scripts analisam instantâneos pontuais de arquivos JSON de entrada
- **Sem integração com CRM**: Dados devem ser exportados manualmente do seu CRM/plataforma de CS
- **Somente determinístico**: Sem ML preditivo — pontuação é algorítmica com base em sinais ponderados
- **Ajuste de limiar**: Limiares padrão são padrões do setor mas podem precisar de calibração para o seu negócio
- **Estimativas de receita**: Estimativas de receita de expansão são aproximações com base em padrões de uso

---

**Última Atualização:** Fevereiro 2026
**Ferramentas:** 3 ferramentas Python CLI
**Dependências:** Apenas biblioteca padrão Python 3.7+
