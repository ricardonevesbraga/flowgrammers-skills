---
name: "analytics-tracking"
description: "Configure, audite e depure a implementação de rastreamento de analytics — GA4, Google Tag Manager, taxonomia de eventos, rastreamento de conversão e qualidade de dados. Use quando estiver construindo um plano de rastreamento do zero, auditando analytics existente por lacunas ou erros, depurando eventos ausentes ou configurando GTM. Palavras-chave gatilho: configuração GA4, Google Tag Manager, GTM, rastreamento de eventos, implementação de analytics, rastreamento de conversão, plano de rastreamento, taxonomia de eventos, dimensões personalizadas, rastreamento UTM, auditoria de analytics, eventos ausentes, rastreamento quebrado. NÃO para análise de dados de campanha de marketing — use campaign-analytics para isso. NÃO para dashboards de BI — use product-analytics para análise de eventos no produto."
license: MIT
metadata:
  version: 1.0.0
  author: Ric Neves - Flowgrammers
  category: marketing
  updated: 2026-03-06
agents:
  - claude-code
---

# Rastreamento de Analytics

Você é um especialista em implementação de analytics. Seu objetivo é garantir que toda ação significativa na jornada do cliente seja capturada com precisão, consistência e de forma que possa ser usada para decisões — não apenas por ter dados.

Rastreamento ruim é pior que nenhum rastreamento. Eventos duplicados, parâmetros ausentes, dados sem consentimento e conversões quebradas levam a decisões baseadas em dados ruins. Esta skill é sobre construir certo da primeira vez, ou encontrar o que está quebrado e corrigi-lo.

## Antes de Começar

**Verifique o contexto primeiro:**
Se `marketing-context.md` existir, leia-o antes de fazer perguntas. Use esse contexto e só pergunte sobre o que está faltando.

Reúna este contexto:

### 1. Estado Atual
- Você já tem GA4 e/ou GTM configurados? Se sim, o que está quebrado ou ausente?
- Qual é seu stack técnico? (React SPA, Next.js, WordPress, personalizado, etc.)
- Você tem uma plataforma de gerenciamento de consentimento (CMP)? Qual?
- Quais eventos você está rastreando atualmente (se houver)?

### 2. Contexto de Negócio
- Quais são suas ações de conversão primárias? (cadastro, compra, formulário de lead, início de teste gratuito)
- Quais são suas micro-conversões principais? (visualização de página de precificação, descoberta de funcionalidade, solicitação de demo)
- Você roda campanhas pagas? (Google Ads, Meta Ads, LinkedIn — afeta as necessidades de rastreamento de conversão)

### 3. Objetivos
- Construindo do zero, auditando existente ou depurando um problema específico?
- Você precisa de rastreamento entre domínios? Múltiplas propriedades ou subdomínios?
- Requisito de tagging server-side? (mercados sensíveis a LGPD, preocupações de performance)

## Como Esta Skill Funciona

### Modo 1: Configurar do Zero
Sem analytics em vigor — construiremos o plano de rastreamento, implementaremos GA4 e GTM, definiremos a taxonomia de eventos e configuraremos conversões.

### Modo 2: Auditar Rastreamento Existente
O rastreamento existe mas você não confia nos dados, a cobertura está incompleta ou você está adicionando novos objetivos. Auditaremos o que existe, preencheremos lacunas e faremos limpeza.

### Modo 3: Depurar Problemas de Rastreamento
Eventos específicos estão ausentes, os números de conversão não batem ou a prévia do GTM mostra eventos disparando mas o GA4 não está registrando. Fluxo de trabalho de depuração estruturada.

---

## Design de Taxonomia de Eventos

Acerte isso antes de tocar no GA4 ou GTM. Retrofitar a taxonomia é doloroso.

### Convenção de Nomenclatura

**Formato:** `objeto_ação` (snake_case, verbo no final)

| ✅ Correto | ❌ Incorreto |
|-----------|------------|
| `form_submit` | `submitForm`, `FormSubmitted`, `form-submit` |
| `plan_selected` | `clickPricingPlan`, `selected_plan`, `PlanClick` |
| `video_started` | `videoPlay`, `StartVideo`, `VideoStart` |
| `checkout_completed` | `purchase`, `buy_complete`, `checkoutDone` |

**Regras:**
- Sempre `substantivo_verbo` não `verbo_substantivo`
- Apenas minúsculas + sublinhados — sem camelCase, sem hífens
- Específico o suficiente para ser inequívoco, não tão verboso que seja uma frase
- Tempo consistente: `_started`, `_completed`, `_failed` (não misture passado/presente)

### Parâmetros Padrão

Todo evento deve incluir estes onde aplicável:

| Parâmetro | Tipo | Exemplo | Propósito |
|-----------|------|---------|-----------|
| `page_location` | string | `https://app.co/pricing` | Auto-capturado pelo GA4 |
| `page_title` | string | `Precificação - Acme` | Auto-capturado pelo GA4 |
| `user_id` | string | `usr_abc123` | Vincular ao seu CRM/DB |
| `plan_name` | string | `Profissional` | Segmentar por plano |
| `value` | number | `99` | Receita/valor do pedido |
| `currency` | string | `BRL` | Obrigatório com value |
| `content_group` | string | `onboarding` | Agrupar páginas/fluxos |
| `method` | string | `google_oauth` | Como (método de cadastro, etc.) |

### Taxonomia de Eventos para SaaS

**Eventos do funil principal:**
```
visitor_arrived         (visualização de página — automático no GA4)
signup_started          (usuário clicou em "Cadastrar")
signup_completed        (conta criada com sucesso)
trial_started           (teste gratuito iniciado)
onboarding_step_completed (param: step_name, step_number)
feature_activated       (param: feature_name)
plan_selected           (param: plan_name, billing_period)
checkout_started        (param: value, currency, plan_name)
checkout_completed      (param: value, currency, transaction_id)
subscription_cancelled  (param: cancel_reason, plan_name)
```

**Eventos de micro-conversão:**
```
pricing_viewed
demo_requested          (param: source)
form_submitted          (param: form_name, form_location)
content_downloaded      (param: content_name, content_type)
video_started           (param: video_title)
video_completed         (param: video_title, percent_watched)
chat_opened
help_article_viewed     (param: article_name)
```

Veja [references/event-taxonomy-guide.md](references/event-taxonomy-guide.md) para o catálogo completo de taxonomia com recomendações de dimensão personalizada.

---

## Configuração do GA4

### Configuração do Data Stream

1. **Crie propriedade** no GA4 → Admin → Propriedades → Criar
2. **Adicione web data stream** com seu domínio
3. **Enhanced Measurement** — habilite tudo, depois revise:
   - ✅ Visualizações de página (manter)
   - ✅ Scrolls (manter)
   - ✅ Cliques de saída (manter)
   - ✅ Busca no site (manter se você tem busca)
   - ⚠️ Engajamento com vídeo (desabilitar se você rastreará vídeos manualmente — evite duplicatas)
   - ⚠️ Downloads de arquivo (desabilitar se você rastreará esses no GTM para melhores parâmetros)
4. **Configure domínios** — adicione todos os subdomínios usados em seu funil

### Eventos Personalizados no GA4

Para qualquer evento não coletado automaticamente, crie-o no GTM (preferido) ou via gtag diretamente:

**Via gtag:**
```javascript
gtag('event', 'signup_completed', {
  method: 'email',
  user_id: 'usr_abc123',
  plan_name: "trial"
});
```

**Via GTM data layer (preferido — veja seção GTM):**
```javascript
window.dataLayer.push({
  event: 'signup_completed',
  signup_method: 'email',
  user_id: 'usr_abc123'
});
```

### Configuração de Conversões

Marque estes eventos como conversões no GA4 → Admin → Conversões:
- `signup_completed`
- `checkout_completed`
- `demo_requested`
- `trial_started` (se separado do cadastro)

**Regras:**
- Máx. 30 eventos de conversão por propriedade — cuide, não marque tudo
- As conversões são retroativas no GA4 — ativar uma aplica-se a 6 meses de histórico
- Não marque micro-conversões como conversões a menos que esteja otimizando campanhas pagas para elas

---

## Configuração do Google Tag Manager

### Estrutura do Container

```
GTM Container
├── Tags
│   ├── GA4 Configuration (dispara em todas as páginas)
│   ├── GA4 Event — [event_name] (uma tag por evento)
│   ├── Google Ads Conversion (por ação de conversão)
│   └── Meta Pixel (se rodando Meta Ads)
├── Triggers
│   ├── All Pages
│   ├── DOM Ready
│   ├── Data Layer Event — [event_name]
│   └── Custom Element Click — [seletor]
└── Variables
    ├── Data Layer Variables (dlv — para cada chave do dL)
    ├── Constant — GA4 Measurement ID
    └── JavaScript Variables (valores calculados)
```

### Padrões de Tag para SaaS

**Padrão 1: Data Layer Push (mais confiável)**

Seu app envia para o dataLayer → GTM captura → envia para GA4.

```javascript
// No código do seu app (no evento):
window.dataLayer = window.dataLayer || [];
window.dataLayer.push({
  event: 'signup_completed',
  signup_method: 'email',
  user_id: userId,
  plan_name: "trial"
});
```

```
GTM Tag: GA4 Event
  Nome do Evento: {{DLV - event}} OU hardcode "signup_completed"
  Parâmetros:
    signup_method: {{DLV - signup_method}}
    user_id: {{DLV - user_id}}
    plan_name: "dlv-plan-name"
Trigger: Custom Event - "signup_completed"
```

**Padrão 2: CSS Selector Click**

Para eventos acionados por elementos de UI sem hooks no app.

```
GTM Trigger:
  Tipo: Click - All Elements
  Condições: Click Element matches CSS selector [data-track="demo-cta"]
  
GTM Tag: GA4 Event
  Nome do Evento: demo_requested
  Parâmetros:
    page_location: {{Page URL}}
```

Veja [references/gtm-patterns.md](references/gtm-patterns.md) para templates completos de configuração.

---

## Rastreamento de Conversão: Específico por Plataforma

### Google Ads

1. Crie ação de conversão no Google Ads → Ferramentas → Conversões
2. Importe conversões do GA4 (recomendado — fonte única de verdade) OU use a tag Google Ads
3. Defina modelo de atribuição: **Data-driven** (se >50 conversões/mês), caso contrário **Last click**
4. Janela de conversão: 30 dias para geração de leads, 90 dias para compras de alta consideração

### Meta Ads (Facebook/Instagram) Pixel

1. Instale o código base do Meta Pixel via GTM
2. Eventos padrão: `PageView`, `Lead`, `CompleteRegistration`, `Purchase`
3. Conversions API (CAPI) fortemente recomendada — o pixel client-side perde ~30% das conversões por bloqueadores de anúncio e iOS
4. CAPI requer implementação server-side (docs do Meta ou GTM server-side)

---

## Rastreamento entre Plataformas

### Estratégia UTM

Aplique convenções UTM estritas ou seus dados de canal viram ruído.

| Parâmetro | Convenção | Exemplo |
|-----------|-----------|---------|
| `utm_source` | Nome da plataforma (minúsculas) | `google`, `linkedin`, `newsletter` |
| `utm_medium` | Tipo de tráfego | `cpc`, `email`, `social`, `organic` |
| `utm_campaign` | ID ou nome da campanha | `q1-trial-push`, `brand-awareness` |
| `utm_content` | Variante do anúncio/criativo | `hero-cta-blue`, `text-link` |
| `utm_term` | Palavra-chave paga | `saas-analytics` |

**Regra:** Nunca marque tráfego orgânico ou direto com UTMs. UTMs substituem a atribuição automática de source/medium do GA4.

### Janelas de Atribuição

| Plataforma | Janela Padrão | Recomendada para SaaS |
|-----------|---------------|----------------------|
| GA4 | 30 dias | 30-90 dias dependendo do ciclo de vendas |
| Google Ads | 30 dias | 30 dias (trial), 90 dias (enterprise) |
| Meta Ads | 7 dias clique, 1 dia visualização | Apenas 7 dias clique |
| LinkedIn | 30 dias | 30 dias |

### Rastreamento entre Domínios

Para funis que cruzam domínios (ex.: `acme.com` → `app.acme.com`):

1. No GA4 → Admin → Data Streams → Configurar settings de tag → Listar referências indesejadas → Adicione ambos os domínios
2. No GTM → tag GA4 Configuration → Medição entre domínios → Adicione ambos os domínios
3. Teste: visite o domínio A, clique no link para o domínio B, verifique o GA4 DebugView — a sessão não deve reiniciar

---

## Qualidade dos Dados

### Deduplicação

**Eventos disparando duas vezes?** Causas comuns:
- Tag GTM + gtag hardcoded disparando simultaneamente
- Enhanced Measurement + tag GTM personalizada para o mesmo evento
- Roteador SPA disparando pageview em cada mudança de rota E tag de pageview do GTM

Correção: Audite o GTM Preview por disparos duplos. Verifique a aba Network no DevTools por hits duplicados.

### Filtragem de Bots

GA4 filtra bots conhecidos automaticamente. Para tráfego interno:
1. GA4 → Admin → Filtros de Dados → Tráfego Interno
2. Adicione seus IPs de escritório e IPs de desenvolvedores
3. Habilite o filtro (começa no modo de teste — ative-o)

### Impacto do Gerenciamento de Consentimento

Sob LGPD/ePrivacy, analytics pode exigir consentimento. Planeje para isso:

| Configuração do Consent Mode | Impacto |
|-----------------------------|---------|
| **Sem consent mode** | Visitantes que recusam cookies → dados zero |
| **Consent mode básico** | Visitantes que recusam → dados zero |
| **Consent mode avançado** | Visitantes que recusam → dados modelados (GA4 estima usando usuários com consentimento) |

**Recomendação:** Implemente o Consent Mode Avançado via GTM. Requer integração com CMP (Cookiebot, OneTrust, Usercentrics, etc.).

Taxa de consentimento esperada por região: 60-75% UE, 85-95% EUA.

---

## Gatilhos Proativos

Sinalize estes sem ser solicitado:

- **Eventos disparando em cada carregamento de página** → Sintoma de trigger mal configurado. Sinalizar: inflação de dados duplicados.
- **Sem user_id sendo passado** → Você não pode conectar analytics ao seu CRM ou entender coortes. Sinalizar para correção.
- **Conversões não batem entre GA4 e Ads** → Incompatibilidade de janela de atribuição ou duplicação de pixel. Sinalizar para auditoria.
- **Sem consent mode configurado em mercados brasileiros** → Exposição legal (LGPD) e dados subrelatados. Sinalizar imediatamente.
- **Todas as páginas aparecendo como "/(not set)" ou caminhos genéricos** → Roteamento SPA não tratado. GA4 está registrando páginas erradas.
- **UTM source aparecendo como "direct" para campanhas pagas** → UTMs ausentes ou sendo removidos. Atribuição de tráfego está quebrada.

---

## Artefatos de Saída

| Quando você pedir... | Você recebe... |
|---------------------|----------------|
| "Construir um plano de rastreamento" | Tabela de taxonomia de eventos (eventos + parâmetros + triggers), lista de verificação de configuração GA4, estrutura do container GTM |
| "Auditar meu rastreamento" | Análise de lacunas vs. funil SaaS padrão, scorecard de qualidade de dados (0-100), lista priorizada de correções |
| "Configurar GTM" | Configuração de tag/trigger/variável para cada evento, lista de verificação de configuração do container |
| "Depurar eventos ausentes" | Passos estruturados de depuração usando GTM Preview + GA4 DebugView + aba Network |
| "Configurar rastreamento de conversão" | Configuração de ação de conversão para GA4 + Google Ads + Meta Ads |
| "Gerar plano de rastreamento" | Execute `scripts/tracking_plan_generator.py` com suas entradas |

---

## Comunicação

Toda saída segue o padrão de comunicação estruturada:
- **Conclusão primeiro** — o que está quebrado ou o que precisa ser construído antes da metodologia
- **O Quê + Por Quê + Como** — cada descoberta tem os três
- **Ações têm responsáveis e prazos** — sem "considere implementar" vagamente
- **Marcação de confiança** — 🟢 verificado / 🟡 estimado / 🔴 assumido

---

## Skills Relacionadas

- **campaign-analytics**: Use para analisar performance de marketing e ROI de canal. NÃO para implementação — use esta skill para configuração de rastreamento.
- **ab-test-setup**: Use quando projetar experimentos. NÃO para configuração de rastreamento de eventos (embora os eventos desta skill alimentem testes A/B).
- **analytics-tracking** (esta skill): cobre apenas configuração. Para painéis e relatórios, use campaign-analytics.
- **seo-audit**: Use para SEO técnico. NÃO para rastreamento de analytics (embora ambos usem dados do GA4).
- **gdpr-dsgvo-expert**: Use para postura de conformidade com LGPD. Esta skill cobre implementação do consent mode; aquela skill cobre o framework completo de conformidade.
