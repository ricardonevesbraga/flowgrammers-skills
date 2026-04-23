---
name: "partnerships-manager"
description: "Partnerships Manager / Business Development sênior para parcerias estratégicas, alianças tecnológicas, canal de vendas (resellers, integradores), co-marketing, programas de afiliados, marketplace e go-to-market conjunto. Use ao estruturar programa de parceiros, negociar acordos comerciais, construir canal indireto, planejar co-marketing, priorizar parceiros ou quando o usuário mencionar partnerships, BD, business development, canal, parceiros, reseller, integrador, marketplace ou aliança."
license: MIT
metadata:
  version: 1.0.0
  author: Ric Neves - Flowgrammers
  category: business-growth
  domain: partnerships
  updated: 2026-04-23
agents:
  - claude-code
---

# Partnerships Manager / Business Development Sênior

Frameworks para construir parcerias estratégicas, canal de vendas indireto, alianças tecnológicas e go-to-market conjunto no contexto brasileiro.

## Palavras-chave
Partnerships, Business Development, BD, aliança estratégica, canal de vendas, reseller, integrador, SI, ISV, marketplace, co-marketing, MDF, market development funds, partner program, affiliates, referral, go-to-market

## Tipos de Parceria

### 1. Parcerias Tecnológicas (Integration Partners)
- Integração API/SDK com complementos
- Objetivo: reduzir fricção de adoção, aumentar stickiness
- Exemplo: ERP integrado com seu SaaS de faturamento
- Métrica: % de clientes ativando integração

### 2. Canal de Revenda (Resellers)
- Terceiros que vendem seu produto sob sua marca
- Comissão típica: 15-30% do primeiro ano, 5-15% recorrente
- Exemplo: revendedores regionais de software no Brasil
- Métrica: % do pipeline originado pelo canal

### 3. Integradores de Sistema (SIs)
- Consultorias que implementam seu produto
- Margem: serviços de implementação (cliente final paga)
- Exemplo: consultoria SAP implementa seu módulo
- Métrica: Certificados ativos × projetos concluídos

### 4. Co-Selling / Co-Marketing
- Vender juntos (account mapping)
- Campanhas conjuntas (webinars, whitepapers)
- Exemplo: seu produto + hyperscaler (AWS, GCP, Azure)
- Métrica: Influenced pipeline, ARR co-originado

### 5. Marketplace
- Listagem em catálogos de terceiros
- AWS Marketplace, Salesforce AppExchange, HubSpot App Marketplace
- Taxa: 3-20% da transação
- Métrica: Listings ativos × deal flow

### 6. Affiliates / Referral
- Indicações pagas (individual ou empresa)
- Self-service (link tracking, paypal payout)
- Exemplo: referral program de SaaS
- Métrica: LTV por origem de afiliado

## Framework de Decisão: Construir Canal?

**Perguntas chave:**

1. **PMF existe?** Canal amplifica o que já funciona — não conserta o que está quebrado.
2. **ACV é compatível?** Canal típico precisa de ACV > R$ 10k/ano para parceiro monetizar.
3. **Time de suporte existe?** Parceiros requerem enablement, MDF, pipeline review.
4. **Segmentos geograficamente/verticalmente distintos?** Canal vence onde direct não consegue ir.

**Quando NÃO construir canal:**
- PLG product-led (self-service funciona melhor)
- Ticket muito baixo (não cabe margem)
- Time comercial sem maturidade (parceiro canibaliza)
- Produto muda rápido demais (parceiro não acompanha)

## Partner Program: Estrutura Padrão

### Tiers (3 níveis)

| Tier | Nome típico | Requisitos | Benefícios |
|------|-------------|------------|------------|
| Bronze | Authorized | Acordo + treinamento | Portal, marketing básico |
| Silver | Certified | 3 clientes ativos + 2 certificações | Deal registration, 15% margem |
| Gold | Elite | 10+ clientes + revenue target | Priority support, 25% margem, MDF |

### Deal Registration

**Regra de ouro:** recompense quem traz o deal, não quem fecha.

```markdown
# Deal Registration Policy

## Critérios de aprovação
- Oportunidade NÃO está no CRM como ativa
- Parceiro identifica stakeholder com nome/email
- Parceiro tem contato verificado (não só BDR)
- Janela de exclusividade: 90 dias

## Override
- Deal fica com parceiro mesmo se cliente final falar com sales direct
- Protege relacionamento e incentiva proativo
```

### Comissionamento

**Modelos:**
- **Flat fee**: R$ X por cliente fechado (simples, bom para lead gen)
- **Revenue share**: 20% do primeiro ano, 10% recorrente (padrão SaaS)
- **Tiered**: 15% até R$ 500k/ano, 25% acima (acelera com volume)

**Cuidado:**
- Payout claro (quando, via quê, ex.: NF-e)
- Clawback se churn < 6 meses
- Auditoria anual

### MDF (Market Development Funds)

Verba para parceiro gerar demanda:
- Budget: 2-5% da receita influenciada
- Atividades: eventos, webinars, conteúdo, feira
- Prestação de contas com proof-of-performance

## Priorização de Parceiros

**Matriz de impacto:**

|  | Esforço Baixo | Esforço Alto |
|--|--------------|--------------|
| **Impacto Alto** | Top priority | Strategic bets |
| **Impacto Baixo** | Quick wins | Cortar |

**Critérios de impacto:**
- Sobreposição de ICP (Ideal Customer Profile)
- Tamanho e alcance do parceiro
- Complementaridade de produto
- Reputação de mercado
- Motivação/comprometimento

**Critérios de esforço:**
- Tempo para enablement
- Dependências técnicas (APIs, conectores)
- Exigência de customização
- Complexidade do contrato

## Negociação: Joint Business Plan

**Estrutura:**

1. **Objetivos compartilhados** (números, 12 meses)
2. **Proposta de valor conjunta** (cliente final)
3. **Go-to-market conjunto**
   - Account mapping
   - Campanhas
   - Pipeline joint
4. **Investimento de ambos os lados**
   - Pessoas (SDRs/AMs dedicados?)
   - Marketing (MDF, eventos)
   - Técnico (integração, certificações)
5. **QBR conjunto** — revisar trimestralmente

## Contratos Essenciais

### Partner Agreement (MSA)

Cláusulas críticas:
- **Território e exclusividade** (quase nunca exclusivo)
- **IP ownership** (quem fica com as derivações)
- **Branding** (uso de logo, limites)
- **Non-solicitation** (não roubar clientes)
- **Term & termination** (saída sem prejuízo)
- **Liability cap** (limite de responsabilidade)

### Reseller / Distribution Agreement

Adiciona:
- Pricing wholesale vs. retail
- Minimum commitments
- Training e certification requirements
- End-customer contract flow
- Returns e cancellations

## Red Flags em Parceiros

- "Podemos fechar deals grandes, só precisamos de ajuda com X" (sem provar)
- Procura desconto como primeira conversa
- Sem time dedicado (o "Sócio X" faz tudo)
- Representa 20+ produtos concorrentes (foco zero)
- Atrasa sempre para reuniões (disrespect)
- Não investe em enablement (não vai vender)

## Métricas de Partnerships

| Métrica | Benchmark |
|---------|-----------|
| **% pipeline originado por parceiros** | > 30% em canal maduro |
| **% ARR originado/influenciado** | > 25% |
| **Partner-sourced win rate** | >= direct (sinal de saúde) |
| **Partner activation rate** | % de parceiros produtivos em 90 dias |
| **Partner NPS** | > 40 |
| **Time to first deal** | < 180 dias |

## Perguntas-Chave

- "Se este parceiro sumir amanhã, quanto MRR eu perco?"
- "Nossos parceiros estão lucrativos no nosso programa? (Se não, eles vão sair.)"
- "Estamos recrutando parceiros ou formando parceiros?"
- "Qual é a única parceria que se dobrasse mudaria o negócio?"
- "Nosso produto é realmente integrável ou só promete isso?"

## Playbooks Brasileiros Relevantes

- **B2B enterprise**: SIs (Accenture, Deloitte, IBM, TOTVS parceiros) movem o mercado
- **SMB**: revendedores regionais e contadores para fintechs
- **Hyperscalers**: AWS/GCP/Azure Marketplace Brasil é real para ACV > R$ 100k
- **Fintech**: BACEN PIX e Open Finance criaram ecossistema de parceiros
- **Edtech**: parcerias com instituições e editoras (VR Benefícios, Estácio)

## Veja Também

- `revenue-operations/` — métricas e forecast
- `contract-and-proposal-writer/` — contratos comerciais
- `customer-success-manager/` — handoff pós-venda
- `../c-level-advisor/cro-advisor/` — revenue strategy
- `../c-level-advisor/cmo-advisor/` — co-marketing
- `../marketing-skill/launch-strategy/` — go-to-market
