---
name: "growth-product-manager"
description: "Growth Product Manager sênior especializado em aquisição, ativação, retenção, receita e referral (AARRR), growth loops, experimentação em escala (A/B tests, multi-arm bandits), PLG, onboarding, activation engineering, north-star metrics e tooling de experimentação. Use ao estruturar time de growth, priorizar experimentos, definir north-star metric, construir growth model, otimizar funil ou quando o usuário mencionar Growth PM, PLG, product-led growth, growth loops, activation, AARRR, north-star metric ou experimentação."
license: MIT
metadata:
  version: 1.0.0
  author: Ric Neves - Flowgrammers
  category: product-team
  domain: growth-product
  updated: 2026-04-23
agents:
  - claude-code
---

# Growth Product Manager Sênior

Frameworks para growth product management: north-star metric, growth loops, funil AARRR, experimentação em escala, activation engineering e PLG.

## Palavras-chave
Growth PM, Growth Product Manager, product-led growth, PLG, growth loops, AARRR, north-star metric, input metrics, activation, aha moment, experimentação, A/B test, multi-arm bandit, funnel, retention curve, engagement

## Princípios Fundamentais

### 1. Growth ≠ Marketing, Growth ≠ Sales
Growth PM trabalha DENTRO do produto para mover métricas. Marketing traz tráfego, Sales converte tráfego, Growth PM transforma produto em máquina de crescimento.

### 2. Growth Loops > Funis
**Funil**: linear, com leak em cada etapa (100 entram → 10 saem)
**Loop**: saída alimenta nova entrada (cada ação gera mais ações)

Exemplos de loops:
- **Viral**: Usuário convida amigos → amigos entram → amigos convidam (Dropbox, Notion)
- **Content**: Usuário cria → SEO indexa → busca traz → cria mais (Pinterest, Quora)
- **UGC**: Usuário posta → outros descobrem → engajam → postam (TikTok, Instagram)
- **Paid**: LTV > CAC → lucro → mais CAC → mais LTV (empresas mid-market)

### 3. North-Star Metric (NSM)
Uma métrica que captura o valor real entregue ao cliente.

**Testes para boa NSM:**
- Previsível do sucesso do negócio de longo prazo?
- Reflete valor entregue ao cliente (não valor extraído)?
- Acionável pelo time?
- Medível semanalmente?

**Exemplos:**
| Empresa | NSM |
|---------|-----|
| Airbnb | Noites reservadas |
| Spotify | Minutos ouvidos |
| WhatsApp | Mensagens enviadas |
| Dropbox | Arquivos sincronizados por usuário ativo |
| Notion | Páginas criadas por workspace ativo |

**Armadilha:** DAU não é NSM. Uso não é valor. Pergunte "o que mede que o cliente recebeu o que veio buscar?"

## Framework AARRR (Funil Pirata)

| Estágio | Pergunta | Métrica exemplo |
|---------|----------|-----------------|
| **A**cquisition | Como descobrem? | CAC por canal |
| **A**ctivation | Veem valor rápido? | % aha moment em 7d |
| **R**etention | Voltam? | Retenção D1/D7/D30/D90 |
| **R**eferral | Trazem outros? | K-factor, viral coefficient |
| **R**evenue | Pagam? | % conversão free → paid |

**Onde focar (ordem):**
1. **Retention FIRST** — sem retenção, nada importa
2. **Activation** — amplifica retenção
3. **Referral e Revenue** — amplia o que funciona
4. **Acquisition** — escala só depois de o resto funcionar

## Activation Engineering

**Aha moment**: primeira ação que correlaciona com retenção de longo prazo.

**Como descobrir:**
1. Defina "retido" (ex: ativo no D90)
2. Olhe ações dos retidos no D1-D14
3. Teste correlações: "usuários que fizeram X dentro de Y tempo retêm Z×"
4. Facebook (clássico): 7 amigos em 10 dias
5. Slack: 2000 mensagens enviadas pela equipe

**Activation loop típico:**
```
Signup → Onboarding → First value action (aha) → Habit → Payment
```

**Otimizações por etapa:**
| Etapa | Tática |
|-------|--------|
| Signup | Magic link vs. senha, SSO, forms curtos |
| Onboarding | Progressive disclosure, tooltips, empty states úteis |
| First value | Templates, pre-populated data, quick wins em 90s |
| Habit | Notifications inteligentes, daily use hooks, streaks |
| Payment | Soft paywall, usage-based, trial estendido |

## Experimentação em Escala

### Framework de priorização: ICE

| Critério | Definição |
|----------|-----------|
| **I**mpact | Se funcionar, quanto move a métrica? (1-10) |
| **C**onfidence | Qual a chance de funcionar? (1-10) |
| **E**ase | Quão fácil é testar? (1-10) |

**Score ICE** = I × C × E / 3. Priorize top 20% do backlog.

**RICE** adiciona **R**each. Use quando tiver segmentos muito diferentes.

### Rigor estatístico

**Sample size calculation:**
```python
# Exemplo: teste de conversão baseline 5%, MDE 10% (lift relativo)
from scipy import stats
import numpy as np

def min_sample_size(p_baseline, mde_rel, alpha=0.05, power=0.8):
    p1 = p_baseline
    p2 = p_baseline * (1 + mde_rel)
    effect = abs(p2 - p1) / np.sqrt((p1*(1-p1) + p2*(1-p2)) / 2)
    z_a = stats.norm.ppf(1 - alpha/2)
    z_b = stats.norm.ppf(power)
    n = ((z_a + z_b) / effect) ** 2
    return int(np.ceil(n))

# 5% baseline, 10% lift desejado → 15.721 por variante
```

**Regras de ouro:**
- Nunca pare teste sem atingir sample size (peeking viola 5%)
- Pré-registre métricas primária e secundárias
- 1 ciclo de negócio completo (geralmente 2 semanas)
- Verifique Sample Ratio Mismatch (SRM) — se |control - treatment| / expected > 1%, anular
- Segmente por persona para entender heterogeneidade

### Multi-arm bandit (quando usar)

**A/B test clássico:** explora igual, aprende, depois explora melhor
**Bandit:** explora mais a opção que já está ganhando, menos pessoas expostas a loser

**Use bandit quando:**
- Tráfego alto (>10k/dia)
- Decisão de exposição (qual ad, qual thumbnail)
- Sensível a custo de oportunidade

**Use A/B test quando:**
- Precisa resposta estatística clara
- Decisão de ship-or-kill (funcionalidade)
- Quer generalizar aprendizado

## Growth Model (Driver-based)

**Modelo simples (exemplo B2B SaaS freemium):**

```python
# Inputs
paid_traffic = 50_000  # visitantes/mês
organic_traffic = 30_000
direct_traffic = 15_000

# Taxas
signup_rate_paid = 0.03
signup_rate_organic = 0.05
signup_rate_direct = 0.08
activation_rate = 0.40  # signup → ativado
paid_conversion = 0.10  # ativado → pagando
retention_1y = 0.85

# Outputs
signups = (
    paid_traffic * signup_rate_paid
    + organic_traffic * signup_rate_organic
    + direct_traffic * signup_rate_direct
)  # = 4.200
activated = signups * activation_rate  # = 1.680
paying = activated * paid_conversion  # = 168
revenue_y1 = paying * arpu_year * retention_1y
```

**Uso:** mude 1 driver por vez, veja impacto no output. Foque no driver com maior elasticidade.

## PLG (Product-Led Growth) — Quando e Como

**Adequado quando:**
- Valor do produto é auto-evidente
- Onboarding pode ser feito sozinho (< 15 min)
- Preço permite tier free ou trial
- Segmento tolera self-service (SMB mais que Enterprise)

**Estrutura PLG:**
1. **Free plan / trial** real (não mutilado)
2. **Onboarding** guiado (checklist, tooltips, templates)
3. **Expansion triggers** (limites que incentivam upgrade)
4. **In-product upgrade path** (paywall contextual)
5. **Self-serve checkout** (Stripe, cartão, instantâneo)

**Armadilha:** PLG puro raramente funciona em ACV > R$ 20k/ano. Híbrido (PLG + Sales-assist) é padrão em mid-market.

## Stack de Growth (ferramentas 2026)

| Categoria | Ferramentas |
|-----------|-------------|
| Analytics | Amplitude, Mixpanel, GA4, PostHog |
| A/B test | Statsig, GrowthBook, Optimizely, PostHog |
| CDP | Segment, RudderStack, Hightouch |
| Data warehouse | BigQuery, Snowflake, Databricks |
| Reverse ETL | Hightouch, Census |
| Customer messaging | Customer.io, Braze, Intercom |
| Product tour | Userflow, Pendo, Appcues |
| Session replay | Hotjar, FullStory, PostHog |

## Métricas do Growth PM

- **% experimentos rodados/mês**: >= 6 para time sênior
- **Win rate**: 30-40% (elite 50%)
- **Lift agregado**: soma dos lifts que foram ao ar
- **Velocidade de learning**: tempo médio de hipótese a decisão
- **NSM growth**: MoM / YoY
- **Activation rate**: depende do produto, mas >= 35% típico SaaS

## Board Update do Growth PM

```markdown
# Growth Update — Abril 2026

## North Star: Minutos úteis por usuário ativo
- **Abril**: 28.4 min/usuário (vs. 25.1 em Mar, +13%)
- **YoY**: +44%

## Funil (usuários novos)
- Signup → Activated: 42% (meta 45%, -3pp)
- Activated → Habit: 38% (meta 35%, +3pp)
- Free → Paid: 8.2% (meta 7%, +1.2pp)

## Experimentos do mês
- 9 rodados, 4 ganhos (44% win rate)
- Ganhos: Novo onboarding (+14% activation), Email D7 (+8% retention)
- Perdas: Paywall agressivo (-22% free → paid), Social proof no landing (neutro)

## Próximo mês
- Landscape de referral loop
- Refinar aha moment por persona
- Instrumentar cohort de power users
```

## Perguntas-Chave

- "Qual é nosso aha moment — e quantos % dos usuários chegam lá?"
- "Se eu tivesse R$ 100k para investir em crescimento, onde iria primeiro?"
- "Nossa growth model depende de qual driver mais e o que acontece se ele quebrar?"
- "Estamos escalando retenção ou só aquisição?"
- "Qual experimento falhado mais informou o roadmap?"

## Veja Também

- `product-manager-toolkit/` — PM tradicional
- `agile-product-owner/` — priorização e sprints
- `experiment-designer/` — setup de experimentos
- `product-analytics/` — instrumentação e dashboards
- `../marketing-skill/ab-test-setup/` — experimentação marketing
- `../c-level-advisor/cpo-advisor/` — estratégia de produto
