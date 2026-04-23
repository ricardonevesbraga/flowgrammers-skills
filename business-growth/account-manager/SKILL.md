---
name: "account-manager"
description: "Gerente de Contas (Account Manager) B2B sênior para gestão de carteira, QBRs, expansão (upsell/cross-sell), renovação, prevenção de churn, relacionamento executivo e planos de contas estratégicas. Use ao construir Account Plan, preparar QBR, planejar upsell, renovar contratos, mapear stakeholders, conduzir executive business review ou quando o usuário mencionar Account Manager, AM, Key Account, KAM, renovação, upsell, cross-sell, QBR ou expansão de receita."
license: MIT
metadata:
  version: 1.0.0
  author: Ric Neves - Flowgrammers
  category: business-growth
  domain: account-management
  updated: 2026-04-23
agents:
  - claude-code
---

# Gerente de Contas (Account Manager) B2B

Frameworks para gestão de carteira B2B: Account Plan, QBR, expansão, renovação, stakeholder mapping e relacionamento executivo.

## Palavras-chave
Account Manager, AM, Key Account Manager, KAM, gestão de contas, QBR, Quarterly Business Review, EBR, Executive Business Review, upsell, cross-sell, renovação, churn, NRR, Net Revenue Retention, expansão, stakeholder map, champion

## Responsabilidades Principais

### 1. Segmentação de Carteira

**Matriz Valor × Potencial:**

|  | Baixo Potencial | Alto Potencial |
|--|----------------|----------------|
| **Alto Valor Atual** | Defender (renovar) | Expandir (crescer) |
| **Baixo Valor Atual** | Eficiência (automação) | Desenvolver (invest) |

**Regra de alocação de tempo (Account Manager sênior):**
- 50% nas contas Expandir (maior ROI)
- 25% nas Defender (evitar churn grande)
- 15% nas Desenvolver (construir futuro)
- 10% nas Eficiência (self-service, automação)

### 2. Account Plan (documento vivo)

**Estrutura mínima:**

```markdown
# Account Plan: [Cliente]

## 1. Snapshot
- **Receita atual**: R$ XXX/ano (MRR R$ XX)
- **Produtos**: [lista]
- **Usuários**: [nº ativos / contratados]
- **Renewal date**: [data]
- **Health score**: Verde / Amarelo / Vermelho
- **NPS último**: 9

## 2. Stakeholder Map
| Pessoa | Cargo | Influência | Suporte | Nosso relacionamento |
|--------|-------|------------|---------|---------------------|
| Ana | VP Operações | Decisora | Campeã | Forte (semanal) |
| Bruno | CFO | Bloqueador | Cético | Fraco (1x/tri) |
| Carla | IT Manager | Influência | Neutro | Médio |

## 3. Business Context
- **Prioridades estratégicas 2026**: [3 principais do cliente]
- **Iniciativas em andamento**: [impactam nosso produto?]
- **Cenário competitivo**: [nosso share, alternativas]

## 4. Value Realized (YTD)
- Economia de R$ XX comprovada
- Produtividade: X horas/mês economizadas
- Ticket redução: XX%
- Case study publicável? [sim/não]

## 5. Crescimento — Próximos 12 meses
- **Upsell**: mover para tier superior (+R$ XX/ano)
- **Cross-sell**: adicionar módulo Y (+R$ XX/ano)
- **Expansão**: novos usuários / BU (+R$ XX/ano)
- **Total potencial**: R$ XX

## 6. Riscos
- [Risco 1: probabilidade × impacto × mitigação]

## 7. Próximas Ações
- [ ] QBR agendado para [data]
- [ ] Executive touch com CFO em [data]
- [ ] Proposta de upsell até [data]
```

### 3. QBR / EBR (Quarterly/Executive Business Review)

**QBR — foco operacional (trimestral)**

Agenda padrão (60 min):
1. **Check-in de saúde** (5 min) — alinhamento rápido
2. **Resultados do trimestre** (15 min) — valor entregue, casos
3. **Uso e adoção** (10 min) — dashboards, gap
4. **Prioridades do próximo trimestre** (15 min) — plano conjunto
5. **Feedback e roadmap** (10 min) — sugestões do cliente, o que vem
6. **Ações e follow-ups** (5 min)

**EBR — foco estratégico (semestral/anual)**

- **Audiência**: C-level / VPs
- **Duração**: 90 min
- **Entregável**: Business Case do parceiro

Estrutura:
1. Executive summary (1 slide)
2. Valor comprovado em R$
3. Alinhamento com prioridades estratégicas do cliente
4. Roadmap de expansão conjunta
5. Benchmarks de mercado
6. Decisões necessárias

### 4. Renovação (Renewal)

**Linha do tempo ideal (contrato anual):**
- **T-180 dias**: Health check + EBR
- **T-120 dias**: Expansão proposta, renewal pricing proposto
- **T-90 dias**: Negociação inicial, riscos mapeados
- **T-60 dias**: Decisor formal confirmado
- **T-30 dias**: Contrato em revisão
- **T-15 dias**: Assinatura

**Red flags para escalação:**
- Champion saiu ou mudou de área
- Champion evita reuniões
- Procurement entrou no processo sem aviso
- Ticket de reclamação aberto
- Uso em queda há 60+ dias
- CFO pedindo "revisão de custos"

**Conversa difícil: aumento de preço**
- Entregue valor comprovado ANTES de falar do aumento
- Ancore no índice (IPCA) + valor incremental entregue
- Ofereça trocas (lock 2 anos por desconto, mais volume)
- Nunca minta sobre "todos estão passando por isso"

### 5. Upsell e Cross-sell

**Sinais de prontidão (Champion Score):**
- Uso > 80% dos contratados
- NPS do usuário > 8
- Executive patrocinador identificado
- Caso de sucesso interno documentado

**Framework de abordagem:**

| Situação | Tática |
|----------|--------|
| Uso saturado | Expansão de volume/usuários |
| Feature pedida | Pacote superior com a feature |
| Dor adjacente | Cross-sell de módulo complementar |
| BU separada | Replicação em outra área |

**Regra 70-20-10 para contatos:**
- 70% entrega de valor (educação, casos, best practices)
- 20% ouvir (descoberta de novas dores)
- 10% pitch explícito de expansão

### 6. Gestão de Churn

**Early warning signs:**
- Queda de uso > 30% em 2 meses
- NPS cai para < 7
- Champion troca de emprego
- Atraso de pagamento
- Ticket crítico sem solução > 30 dias
- Silêncio prolongado (> 45 dias sem contato)

**Playbook de recuperação:**
1. **Diagnose** — por que está saindo? Técnico, político ou valor?
2. **Escalate** — engaje SVP/CCO se conta estratégica
3. **Tactical** — plano 30/60/90 com entregas específicas
4. **Commercial** — desconto, pause, downgrade antes de perder tudo
5. **Offboard gracioso** se inevitável — ponte para retorno futuro

### 7. Handoff de Sales → AM

**Kickoff call (primeiros 30 dias):**
- Objetivos de negócio e sucesso definidos
- Stakeholder map inicial
- Timeline de onboarding
- Success metrics alinhadas
- Executive sponsor identificado dos dois lados

**Documentos do handoff:**
- Proposta/contrato
- Notas de descoberta do Sales
- Compromissos explícitos feitos
- Pricing e termos especiais
- Pontos sensíveis/red flags

## Métricas do AM

| Métrica | Benchmark SaaS |
|---------|----------------|
| **NRR (Net Revenue Retention)** | > 110% (elite > 130%) |
| **GRR (Gross Revenue Retention)** | > 90% |
| **Logo churn** | < 10% anual |
| **Revenue churn** | < 5% anual |
| **Expansion MRR** | > 20% de new MRR |
| **QBR coverage** | 100% das contas Tier 1 |
| **Executive touches** | >= 2/tri em Tier 1 |
| **Health score verde** | > 80% da carteira |

## Perguntas-Chave que um AM Sênior Faz

- "Se meu champion sair amanhã, perco a conta?"
- "Qual valor em R$ nós entregamos este trimestre — e o cliente sabe?"
- "Quem na cadeia de decisão ainda não conheci?"
- "Se eu aumentasse o preço em 15% amanhã, o cliente ficaria?"
- "Que produto adjacente este cliente está comprando de outro fornecedor?"

## Veja Também

- `customer-success-manager/` — foco em adoção e saúde
- `revenue-operations/` — métricas, forecast, comp
- `contract-and-proposal-writer/` — negociação e contratos
- `../c-level-advisor/cro-advisor/` — estratégia de revenue
