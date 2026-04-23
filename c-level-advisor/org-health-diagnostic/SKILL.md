---
name: "org-health-diagnostic"
description: "Verificação de saúde organizacional interfuncional combinando sinais de todas as funções C-suite. Pontua 8 dimensões em uma escala de semáforo com recomendações detalhadas. Use ao avaliar a saúde geral da empresa, preparar revisões do conselho, identificar funções em risco ou quando o usuário mencionar saúde organizacional, verificação de saúde ou painel de saúde."
license: MIT
metadata:
  version: 1.0.0
  author: Ric Neves - Flowgrammers
  category: c-level
  domain: organizational-health
  updated: 2026-03-05
  frameworks: health-benchmarks
agents:
  - claude-code
---

# Diagnóstico de Saúde Organizacional

Oito dimensões. Semáforos. Benchmarks reais. Identifica os problemas que você não sabe que tem.

## Keywords
org health, saúde organizacional, health diagnostic, health painel, health check, company health, functional health, team health, startup health, health scorecard, health assessment, risk painel

## Início Rápido

```bash
python scripts/health_scorer.py        # CLI guiado — insira métricas, receba painel pontuado
python scripts/health_scorer.py --json # Saída em JSON bruto para integração
```

Ou descreva suas métricas:
```
/health [cole suas métricas principais ou responda às perguntas]
/health:dimension [financial|revenue|product|engineering|people|ops|security|market]
```

## As 8 Dimensões

### 1. 💰 Saúde Financeira (CFO)
**O que mede:** Conseguimos financiar operações e investir em crescimento?

Métricas-chave:
- **Runway** — meses no burn atual (Verde: >12, Amarelo: 6–12, Vermelho: <6)
- **Burn multiple** — burn líquido / novo ARR líquido (Verde: <1,5x, Amarelo: 1,5–2,5x, Vermelho: >2,5x)
- **Margem bruta** — meta SaaS: >65% (Verde: >70%, Amarelo: 55–70%, Vermelho: <55%)
- **Taxa de crescimento mês a mês** — contextual por estágio (veja benchmarks)
- **Concentração de receita** — % do ARR do top cliente (Verde: <15%, Amarelo: 15–25%, Vermelho: >25%)

### 2. 📈 Saúde de Receita (CRO)
**O que mede:** Os clientes estão ficando, crescendo e nos recomendando?

Métricas-chave:
- **NRR (Net Revenue Retention)** — Verde: >110%, Amarelo: 100–110%, Vermelho: <100%
- **Taxa de cancelamento de contas (anualizada)** — Verde: <5%, Amarelo: 5–10%, Vermelho: >10%
- **Cobertura de pipeline (próximo trimestre)** — Verde: >3x, Amarelo: 2–3x, Vermelho: <2x
- **Período de recuperação do CAC** — Verde: <12 meses, Amarelo: 12–18, Vermelho: >18 meses
- **Tendência do ACV médio** — direcional: crescendo, estável, caindo

### 3. 🚀 Saúde do Produto (CPO)
**O que mede:** Os clientes amam e usam o produto?

Métricas-chave:
- **NPS** — Verde: >40, Amarelo: 20–40, Vermelho: <20
- **Razão DAU/MAU** — proxy de engajamento (Verde: >40%, Amarelo: 20–40%, Vermelho: <20%)
- **Adoção da funcionalidade principal** — % de usuários usando a funcionalidade de valor primário (Verde: >60%)
- **Tempo para valor** — dias do cadastro até a primeira ação principal (menor é melhor)
- **Satisfação do cliente (CSAT)** — Verde: >4,2/5, Amarelo: 3,5–4,2, Vermelho: <3,5

### 4. ⚙️ Saúde de Engenharia (CTO)
**O que mede:** Conseguimos entregar de forma confiável e manter a velocidade?

Métricas-chave:
- **Frequência de implantação** — Verde: diária, Amarelo: semanal, Vermelho: mensal ou menos
- **Taxa de falha de mudanças** — % de implantações causando incidentes (Verde: <5%, Vermelho: >15%)
- **Tempo médio de recuperação (MTTR)** — Verde: <1 hora, Amarelo: 1–4 horas, Vermelho: >4 horas
- **Proporção de dívida técnica** — % da capacidade do sprint em dívida (Verde: <20%, Amarelo: 20–35%, Vermelho: >35%)
- **Frequência de incidentes** — P0/P1 por mês (Verde: <2, Amarelo: 2–5, Vermelho: >5)

### 5. 👥 Saúde de Pessoas (CHRO)
**O que mede:** O time é estável, engajado e está crescendo?

Métricas-chave:
- **Attrição lamentável (anualizada)** — Verde: <10%, Amarelo: 10–20%, Vermelho: >20%
- **Pontuação de engajamento** — (eNPS ou similar; Verde: >30, Amarelo: 0–30, Vermelho: <0)
- **Tempo para preencher vaga (média em dias)** — Verde: <45, Amarelo: 45–90, Vermelho: >90
- **Proporção gestor:IC** — Verde: 1:5–1:8, Amarelo: 1:3–1:5 ou 1:8–1:12, Vermelho: fora disso
- **Taxa de promoção interna** — pelo menos 25–30% das funções sênior preenchidas internamente

### 6. 🔄 Saúde Operacional (COO)
**O que mede:** Estamos executando nossa estratégia com disciplina?

Métricas-chave:
- **Taxa de conclusão de OKRs** — % dos key results atingindo a meta (Verde: >70%, Amarelo: 50–70%, Vermelho: <50%)
- **Tempo de ciclo de decisão** — dias da necessidade de decisão à decisão tomada (Verde: <48h, Amarelo: 48h–1 semana)
- **Efetividade de reuniões** — % de reuniões com resultado claro (qualitativo)
- **Maturidade de processos** — escala nível 1–5 (veja advisor COO)
- **Conclusão de iniciativas interfuncionais** — % no prazo, no escopo

### 7. 🔒 Saúde de Segurança (CISO)
**O que mede:** Estamos protegendo clientes e mantendo a conformidade?

Métricas-chave:
- **Incidentes de segurança (últimos 90 dias)** — Verde: 0, Amarelo: 1–2 menores, Vermelho: 1+ maior
- **Status de conformidade** — certificações atuais/em andamento vs. vencidas (inclua LGPD se aplicável)
- **SLA de remediação de vulnerabilidades** — % de CVEs críticos corrigidos dentro do SLA (Verde: 100%)
- **Conclusão de treinamento de segurança** — % do time atualizado (Verde: >95%)
- **Recência do pentest** — Verde: <12 meses, Amarelo: 12–24, Vermelho: >24 meses

### 8. 📣 Saúde de Mercado (CMO)
**O que mede:** Estamos ganhando no mercado e crescendo de forma eficiente?

Métricas-chave:
- **Tendência do CAC** — melhorando, estável ou piorando trimestre a trimestre
- **Mix de leads orgânicos vs. pagos** — mais orgânicos = mais saudável (menos frágil)
- **Taxa de vitória** — % de oportunidades qualificadas fechadas-ganhas (Verde: >25%, Amarelo: 15–25%, Vermelho: <15%)
- **Taxa de vitória competitiva** — contra concorrentes primários especificamente
- **NPS de marca** — pontuações de consciência + preferência no ICP

---

## Pontuação e Semáforos

Cada dimensão é pontuada de 1–10 com semáforo:
- 🟢 **Verde (7–10):** Saudável — manter e otimizar
- 🟡 **Amarelo (4–6):** Monitorar — a tendência importa; melhorando ou piorando?
- 🔴 **Vermelho (1–3):** Ação necessária — abordar em 30 dias

**Pontuação Geral de Saúde:**
Média ponderada por estágio da empresa (veja `references/health-benchmarks.md` para os pesos).

---

## Interações entre Dimensões (Por que Um Problema Cria Outro)

| Se esta dimensão está no vermelho... | Observe estas dimensões a seguir |
|--------------------------------------|----------------------------------|
| Saúde Financeira | Pessoas (congele contratações) → Engenharia (congele infra) → Produto (corte escopo) |
| Saúde de Receita | Financeiro (gap de caixa) → Pessoas (risco de attrição) → Mercado (perde posicionamento) |
| Saúde de Pessoas | Engenharia (velocidade cai) → Produto (qualidade cai) → Receita (churn sobe) |
| Saúde de Engenharia | Produto (funcionalidades deslizam) → Receita (negócios param por produto) |
| Saúde do Produto | Receita (NRR cai, churn sobe) → Mercado (CAC sobe; indicações secam) |
| Saúde Operacional | Todas as dimensões degradam ao longo do tempo (falha de execução em cascata) |

---

## Formato de Saída do Painel

```
DIAGNÓSTICO DE SAÚDE ORGANIZACIONAL — [Empresa] — [Data]
Estágio: [Seed/A/B/C]   Geral: [Pontuação]/10   Tendência: [↑ Melhorando / → Estável / ↓ Caindo]

PONTUAÇÕES POR DIMENSÃO
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
💰 Financeiro    🟢 8,2  Runway 14 meses, burn 1,6x — forte
📈 Receita       🟡 5,8  NRR 104%, pipeline fraco (cobertura 1,8x)
🚀 Produto       🟢 7,4  NPS 42, DAU/MAU 38%
⚙️  Engenharia   🟡 5,2  Dívida em 30%, MTTR 3,2h
👥 Pessoas       🔴 3,8  Attrição 24%, moral de eng. baixo
🔄 Operações     🟡 6,0  Conclusão de OKR 65%
🔒 Segurança     🟢 7,8  SOC 2 Type II concluído, 0 incidentes
📣 Mercado       🟡 5,5  CAC subindo, taxa de vitória caiu para 22%
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

PRIORIDADES PRINCIPAIS
🔴 [1] Pessoas: attrição em 24% — velocidade de engenharia cairá em 60 dias
   Ação: CHRO + CEO para realizar auditoria de retenção; identificar os 5 mais em risco esta semana
🟡 [2] Receita: cobertura de pipeline em 1,8x — risco de perda no T+1 é alto
   Ação: CRO para adicionar 3 oportunidades qualificadas em 30 dias ou reduzir previsão
🟡 [3] Engenharia: dívida técnica em 30% do sprint — entregas vão desacelerar no T3
   Ação: CTO para propor plano de sprint de dívida; COO para proteger a capacidade

MONITORAR
→ Risco de cascata Pessoas → Engenharia se attrição continuar (veja interações de dimensões)
```

---

## Degradação Graciosa

Você não precisa de todas as métricas para rodar um diagnóstico. A ferramenta lida com dados parciais:
- Métrica ausente → excluída da pontuação, sinalizada como "[dados necessários]"
- Pontuação ainda válida para dimensões disponíveis
- Relatório sinaliza as lacunas a preencher no próximo ciclo

## Referências
- `references/health-benchmarks.md` — benchmarks por estágio (Seed, A, B, C)
- `scripts/health_scorer.py` — ferramenta CLI de pontuação com saída em semáforo
