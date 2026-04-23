---
name: "marketing-demand-acquisition"
description: Cria campanhas de geração de demanda, otimiza investimentos em anúncios pagos no LinkedIn, Google e Meta, desenvolve estratégias de SEO e estrutura programas de parceria para startups Série A+ em expansão internacional. Use quando estiver planejando estratégia de marketing, growth marketing, campanhas de publicidade, otimização de PPC, geração de leads, geração de pipeline ou orçamentos de marketing para startups. Cobre aquisição multicanal (Google Ads, LinkedIn Ads, Meta Ads), análise de CAC, fluxos de trabalho MQL/SQL, modelagem de atribuição, SEO técnico e parcerias de co-marketing para movimentos híbridos PLG/Liderado por Vendas nos mercados BR/EU/US/Canada.
triggers:
  - demand gen
  - demand generation
  - paid ads
  - paid media
  - LinkedIn ads
  - Google ads
  - Meta ads
  - CAC
  - customer acquisition cost
  - lead generation
  - MQL
  - SQL
  - pipeline generation
  - acquisition strategy
  - HubSpot campaigns
metadata:
  version: 1.1.0
  author: Ric Neves - Flowgrammers
  category: marketing
  domain: demand-generation
  updated: 2025-01
agents:
  - claude-code
---

# Marketing de Demanda & Aquisição

Playbook de aquisição para startups Série A+ em expansão internacional (BR/EU/US/Canada) com movimento híbrido PLG/Liderado por Vendas.

## Sumário

- [KPIs Principais](#core-kpis)
- [Framework de Geração de Demanda](#demand-generation-framework)
- [Canais de Mídia Paga](#paid-media-channels)
- [Estratégia de SEO](#seo-strategy)
- [Parcerias](#partnerships)
- [Atribuição](#attribution)
- [Ferramentas](#tools)
- [Referências](#references)

---

## KPIs Principais

**Geração de Demanda:** Volume MQL/SQL, custo por oportunidade, pipeline originado pelo marketing R$, taxa MQL→SQL

**Mídia Paga:** CAC, ROAS, CPL, CPA, índice de eficiência por canal

**SEO:** Sessões orgânicas, % de tráfego não-branded, rankings de palavras-chave, pontuação de saúde técnica

**Parcerias:** Pipeline originado por parceiros R$, CAC de parceiros, ROI de co-marketing

---

## Framework de Geração de Demanda

### Estágios do Funil

| Estágio | Táticas | Meta |
|---------|---------|------|
| TOFU | Social pago, display, sindicalização de conteúdo, SEO | Reconhecimento de marca, tráfego |
| MOFU | Pesquisa paga, retargeting, conteúdo protegido, nutrição por e-mail | MQLs, solicitações de demo |
| BOFU | Pesquisa de marca, outreach direto, estudos de caso, trials | SQLs, pipeline R$ |

### Fluxo de Trabalho de Planejamento de Campanha

1. Definir objetivo, orçamento, duração e audiência
2. Selecionar canais com base no estágio do funil
3. Criar campanha no HubSpot com estrutura de UTM adequada
4. Configurar pontuação de leads e regras de atribuição
5. Lançar com orçamento de teste, validar rastreamento
6. **Validação:** Parâmetros UTM aparecem nos registros de contato do HubSpot

### Estrutura de UTM

```
utm_source={channel}       // linkedin, google, meta
utm_medium={type}          // cpc, display, email
utm_campaign={campaign-id} // q1-2025-linkedin-enterprise
utm_content={variant}      // ad-a, email-1
utm_term={keyword}         // [apenas pesquisa paga]
```

---

## Canais de Mídia Paga

### Matriz de Seleção de Canal

| Canal | Melhor Para | Faixa de CAC | Prioridade Série A |
|-------|-------------|--------------|-------------------|
| LinkedIn Ads | B2B, Enterprise, ABM | R$750-2000 | Alta |
| Google Search | Alta intenção, BOFU | R$400-1250 | Alta |
| Google Display | Retargeting | R$250-750 | Média |
| Meta Ads | PME, produtos visuais | R$300-1000 | Média |

### Configuração do LinkedIn Ads

1. Criar grupo de campanha para a iniciativa
2. Estrutura: campanhas de Consciência → Consideração → Conversão
3. Alvo: Diretor+, 50-5000 funcionários, setores relevantes
4. Iniciar com R$250/dia por campanha
5. Escalar 20% semanalmente se CAC < meta
6. **Validação:** LinkedIn Insight Tag disparando em todas as páginas

### Configuração do Google Ads

1. Priorizar: Marca → Concorrente → Solução → Palavras-chave de categoria
2. Estruturar grupos de anúncios com 5-10 palavras-chave temáticas
3. Criar 3 anúncios de pesquisa responsivos por grupo (15 títulos, 4 descrições)
4. Manter lista de palavras-chave negativas (100+)
5. Iniciar com CPC Manual, mudar para CPA Alvo após 50+ conversões
6. **Validação:** Rastreamento de conversão ativo, termos de pesquisa revisados semanalmente

### Alocação de Orçamento (Série A, R$200k/mês)

| Canal | Orçamento | SQLs Esperados |
|-------|-----------|----------------|
| LinkedIn | R$75k | 10 |
| Google Search | R$60k | 20 |
| Google Display | R$25k | 5 |
| Meta | R$25k | 8 |
| Parcerias | R$15k | 5 |

Veja [campaign-templates.md](references/campaign-templates.md) para estruturas detalhadas.

---

## Estratégia de SEO

### Checklist de Fundação Técnica

- [ ] Sitemap XML enviado ao Search Console
- [ ] Robots.txt configurado corretamente
- [ ] HTTPS habilitado
- [ ] Velocidade de página >90 mobile
- [ ] Core Web Vitals aprovados
- [ ] Dados estruturados implementados
- [ ] Tags canônicas em todas as páginas
- [ ] Tags hreflang para internacional
- **Validação:** Executar crawl do Screaming Frog, zero erros críticos

### Estratégia de Palavras-chave

| Camada | Tipo | Volume | Prioridade |
|--------|------|--------|-----------|
| 1 | Alta intenção BOFU | 100-1k | Primeiro |
| 2 | MOFU com consciência de solução | 500-5k | Segundo |
| 3 | TOFU com consciência do problema | 1k-10k | Terceiro |

### Otimização On-Page

1. URL: incluir palavra-chave principal, 3-5 palavras
2. Tag de título: palavra-chave principal + marca (60 caracteres)
3. Meta descrição: CTA + proposta de valor (155 caracteres)
4. H1: corresponder à intenção de busca (um por página)
5. Conteúdo: 2000-3000 palavras para tópicos abrangentes
6. Links internos: 3-5 páginas relevantes
7. **Validação:** Google Search Console mostra página indexada, sem erros

### Prioridades de Link Building

1. Digital PR (pesquisas originais, relatórios do setor)
2. Guest posting (apenas sites com DA 40+)
3. Co-marketing com parceiros (SaaS complementares)
4. Engajamento em comunidades (Reddit, Quora, fóruns BR)

---

## Parcerias

### Níveis de Parceria

| Nível | Tipo | Esforço | ROI |
|-------|------|---------|-----|
| 1 | Integrações estratégicas | Alto | Muito alto |
| 2 | Parceiros afiliados | Médio | Médio-alto |
| 3 | Indicações de clientes | Baixo | Médio |
| 4 | Listagens em marketplaces | Médio | Baixo-médio |

### Fluxo de Trabalho de Parceria

1. Identificar parceiros com ICP sobreposto e sem concorrência
2. Realizar outreach com proposta específica de integração/co-marketing
3. Definir métricas de sucesso, modelo de receita e prazo
4. Criar ativos co-branded e rastreamento de parceiros
5. Habilitar equipe de vendas do parceiro com treinamento de demo
6. **Validação:** Rastreamento UTM de parceiro funcional, leads roteados corretamente

### Configuração de Programa de Afiliados

1. Selecionar plataforma (PartnerStack, Impact, Rewardful)
2. Configurar estrutura de comissão (20-30% recorrente)
3. Criar kit de habilitação de afiliados (ativos, links, conteúdo)
4. Recrutar via outbound, inbound, eventos
5. **Validação:** Testar se link de afiliado rastreia até a conversão

Veja [international-playbooks.md](references/international-playbooks.md) para táticas regionais.

---

## Atribuição

### Seleção de Modelo

| Modelo | Caso de Uso |
|--------|-------------|
| Primeiro Toque | Campanhas de reconhecimento |
| Último Toque | Resposta direta |
| W-Shaped (40-20-40) | PLG/Vendas híbrido (recomendado) |

### Configuração de Atribuição no HubSpot

1. Navegar para Marketing → Relatórios → Atribuição
2. Selecionar modelo W-Shaped para movimento híbrido
3. Definir evento de conversão (negócio criado)
4. Definir janela de lookback de 90 dias
5. **Validação:** Executar relatório dos últimos 90 dias, todos os canais exibem dados

### Dashboard de Métricas Semanais

| Métrica | Meta |
|---------|------|
| MQLs | Meta semanal |
| SQLs | Meta semanal |
| Taxa MQL→SQL | >15% |
| CAC Combinado | <R$1.500 |
| Velocidade do Pipeline | <60 dias |

Veja [attribution-guide.md](references/attribution-guide.md) para configuração detalhada.

---

## Ferramentas

### scripts/

| Script | Propósito | Uso |
|--------|-----------|-----|
| `calculate_cac.py` | Calcular CAC combinado e por canal | `python scripts/calculate_cac.py --spend 200000 --customers 50` |

### Integração HubSpot

- Rastreamento de campanha com parâmetros UTM
- Pontuação de leads e fluxos de trabalho MQL/SQL
- Relatórios de atribuição (multi-toque)
- Roteamento de leads de parceiros

Veja [hubspot-workflows.md](references/hubspot-workflows.md) para templates de fluxo de trabalho.

---

## Referências

| Arquivo | Conteúdo |
|---------|---------|
| [hubspot-workflows.md](references/hubspot-workflows.md) | Pontuação de leads, nutrição, fluxos de trabalho de atribuição |
| [campaign-templates.md](references/campaign-templates.md) | Estruturas de campanha LinkedIn, Google, Meta |
| [international-playbooks.md](references/international-playbooks.md) | Táticas para mercados BR, EU, US, Canada |
| [attribution-guide.md](references/attribution-guide.md) | Atribuição multi-toque, painéis, teste A/B |

---

## Benchmarks de Canal (B2B SaaS Série A)

| Métrica | LinkedIn | Google Search | SEO | E-mail |
|---------|----------|---------------|-----|--------|
| CTR | 0,4-0,9% | 2-5% | 1-3% | 15-25% |
| CVR | 1-3% | 3-7% | 2-5% | 2-5% |
| CAC | R$750-2000 | R$400-1250 | R$250-750 | R$100-400 |
| MQL→SQL | 10-20% | 15-25% | 12-22% | 8-15% |

---

## Handoff MQL→SQL

### Critérios de SQL

```
Obrigatório:
✅ Cargo: Diretor+ ou autoridade de orçamento
✅ Tamanho da empresa: 50-5000 funcionários
✅ Orçamento: R$50k+ anual
✅ Prazo: Comprando nos próximos 90 dias
✅ Engajamento: Demo solicitado ou ação de alta intenção
```

### SLA

| Handoff | Meta |
|---------|------|
| SDR responde ao MQL | 4 horas |
| AE agenda demo com SQL | 24 horas |
| Primeiro demo agendado | 3 dias úteis |

**Validação:** Testar lead pelo fluxo de trabalho, verificar notificações e roteamento.

## Gatilhos Proativos

- **Dependência excessiva de um único canal** → Dependência de canal único é risco de negócio. Diversifique.
- **Sem pontuação de leads** → Nem todos os leads são iguais. Encaminhar para operações de receita para pontuação.
- **CAC superando LTV** → Geração de demanda não é lucrativa. Otimizar ou cortar canais.
- **Sem nutrição para leads não prontos** → 80% dos leads não estão prontos para comprar. Nutrição os converte depois.

## Skills Relacionadas

- **paid-ads**: Para executar campanhas de aquisição paga.
- **content-strategy**: Para geração de demanda orientada por conteúdo.
- **email-sequence**: Para sequências de nutrição no funil de demanda.
- **campaign-analytics**: Para medir a eficácia da geração de demanda.
