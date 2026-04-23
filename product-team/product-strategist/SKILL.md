---
name: "product-strategist"
description: Kit de ferramentas de liderança estratégica de produto para Head of Product cobrindo geração de cascata OKR, planejamento trimestral, análise do cenário competitivo, documentos de visão de produto e propostas de escalabilidade de equipe. Use ao criar documentos OKR trimestrais, definir metas ou KPIs de produto, construir roadmap de produto, executar análise competitiva, redigir estrutura de equipe ou planos de contratação, alinhar estratégia de produto entre engenharia e design, ou gerar hierarquias de metas em cascata do nível da empresa ao nível da equipe.
agents:
  - claude-code
---

# Estrategista de Produto

Kit de ferramentas estratégico para Head of Product impulsionar visão, alinhamento e excelência organizacional.

---

## Capacidades Principais

| Capacidade | Descrição | Ferramenta |
|------------|-----------|------------|
| **Cascata OKR** | Gerar OKRs alinhados da empresa ao nível de equipe | `okr_cascade_generator.py` |
| **Pontuação de Alinhamento** | Medir alinhamento vertical e horizontal | Integrado ao gerador |
| **Templates de Estratégia** | 5 tipos de estratégia pré-construídos | Crescimento, Retenção, Receita, Inovação, Operacional |
| **Configuração de Equipe** | Personalizar para sua estrutura organizacional | flag `--teams` |

---

## Início Rápido

```bash
# Estratégia de crescimento com equipes padrão
python scripts/okr_cascade_generator.py growth

# Estratégia de retenção com equipes personalizadas
python scripts/okr_cascade_generator.py retention --teams "Engineering,Design,Data"

# Estratégia de receita com 40% de contribuição de produto
python scripts/okr_cascade_generator.py revenue --contribution 0.4

# Exportar como JSON para integração
python scripts/okr_cascade_generator.py growth --json > okrs.json
```

---

## Fluxo de Trabalho: Planejamento Estratégico Trimestral

### Passo 1: Definir Foco Estratégico

| Estratégia | Quando Usar |
|------------|-------------|
| **Crescimento** | Escalando base de usuários, expansão de mercado |
| **Retenção** | Reduzindo churn, melhorando LTV |
| **Receita** | Aumentando ARPU, nova monetização |
| **Inovação** | Diferenciação de mercado, novas capacidades |
| **Operacional** | Melhorando eficiência, escalando operações |

Veja `references/strategy_types.md` para orientação detalhada.

### Passo 2: Coletar Métricas de Entrada

```json
{
  "current": 100000,      // MAU atual
  "target": 150000,       // MAU meta
  "current_nps": 40,      // NPS atual
  "target_nps": 60        // NPS meta
}
```

### Passo 3: Configurar Equipes e Executar Gerador

```bash
# Equipes padrão
python scripts/okr_cascade_generator.py growth

# Estrutura organizacional personalizada com percentual de contribuição
python scripts/okr_cascade_generator.py growth \
  --teams "Core,Platform,Mobile,AI" \
  --contribution 0.3
```

### Passo 4: Revisar Pontuações de Alinhamento

| Pontuação | Meta | Ação se Abaixo |
|-----------|------|----------------|
| Alinhamento Vertical | >90% | Garantir que todos os objetivos conectem ao pai |
| Alinhamento Horizontal | >75% | Verificar lacunas de coordenação entre equipes |
| Cobertura | >80% | Validar que todos os OKRs da empresa são endereçados |
| Equilíbrio | >80% | Redistribuir se uma equipe estiver sobrecarregada |
| **Geral** | **>80%** | <60% precisa de reestruturação |

### Passo 5: Refinar, Validar e Exportar

Antes de finalizar:

- [ ] Revisar objetivos gerados com partes interessadas
- [ ] Ajustar atribuições de equipe com base na capacidade
- [ ] Validar que os percentuais de contribuição são realistas
- [ ] Garantir que não há objetivos conflitantes entre equipes
- [ ] Definir cadência de rastreamento (check-ins quinzenais)

```bash
# Exportar JSON para ferramentas como Lattice, Ally, Workboard
python scripts/okr_cascade_generator.py growth --json > q1_okrs.json
```

---

## Gerador de Cascata OKR

### Uso

```bash
python scripts/okr_cascade_generator.py [strategy] [options]
```

**Estratégias:** `growth` | `retention` | `revenue` | `innovation` | `operational`

### Opções de Configuração

| Opção | Descrição | Padrão |
|-------|-----------|--------|
| `--teams`, `-t` | Nomes de equipes separados por vírgula | Growth,Platform,Mobile,Data |
| `--contribution`, `-c` | Contribuição do produto para OKRs da empresa (0-1) | 0.3 (30%) |
| `--json`, `-j` | Produzir como JSON em vez de dashboard | False |
| `--metrics`, `-m` | Métricas como string JSON | Métricas de exemplo |

### Exemplos de Saída

#### Saída de Dashboard (estratégia `growth`)

```
============================================================
OKR CASCADE DASHBOARD
Quarter: Q1 2025  |  Strategy: GROWTH
Teams: Growth, Platform, Mobile, Data  |  Product Contribution: 30%
============================================================

🏢 COMPANY OKRS
📌 CO-1: Accelerate user acquisition and market expansion
   └─ CO-1-KR1: Increase MAU from 100,000 to 150,000
   └─ CO-1-KR2: Achieve 50% MoM growth rate
   └─ CO-1-KR3: Expand to 3 new markets

📌 CO-2: Achieve product-market fit in new segments
📌 CO-3: Build sustainable growth engine

🚀 PRODUCT OKRS
📌 PO-1: Build viral product features and market expansion
   ↳ Supports: CO-1
   └─ PO-1-KR1: Increase product MAU to 45,000
   └─ PO-1-KR2: Achieve 45% feature adoption rate

👥 TEAM OKRS
Growth Team:
  📌 GRO-1: Build viral product features through acquisition and activation
     └─ GRO-1-KR1: Increase product MAU to 11,250
     └─ GRO-1-KR2: Achieve 11.25% feature adoption rate

🎯 ALIGNMENT SCORES
✓ Vertical Alignment: 100.0%
! Horizontal Alignment: 75.0%
✓ Coverage: 100.0%  |  ✓ Balance: 97.5%  |  ✓ Overall: 94.0%
✅ Overall alignment is GOOD (≥80%)
```

#### Saída JSON (`retention --json`, truncado)

```json
{
  "quarter": "Q1 2025",
  "strategy": "retention",
  "company": {
    "objectives": [
      {
        "id": "CO-1",
        "title": "Create lasting customer value and loyalty",
        "key_results": [
          { "id": "CO-1-KR1", "title": "Improve retention from 70% to 85%", "current": 70, "target": 85 }
        ]
      }
    ]
  },
  "product": { "contribution": 0.3, "objectives": ["..."] },
  "teams": ["..."],
  "alignment_scores": {
    "vertical_alignment": 100.0, "horizontal_alignment": 75.0,
    "coverage": 100.0, "balance": 97.5, "overall": 94.0
  }
}
```

Veja `references/examples/sample_growth_okrs.json` para um exemplo completo.

---

## Documentos de Referência

| Documento | Descrição |
|-----------|-----------|
| `references/okr_framework.md` | Metodologia OKR, diretrizes de escrita, pontuação de alinhamento |
| `references/strategy_types.md` | Detalhamento de todos os 5 tipos de estratégia com exemplos |
| `references/examples/sample_growth_okrs.json` | Saída de exemplo completa para estratégia de crescimento |

---

## Melhores Práticas

### Cascata OKR

- Limite a 3-5 objetivos por nível, cada um com 3-5 key results
- Key results devem ser mensuráveis com valores atual e meta
- Valide relacionamentos pai-filho antes de finalizar

### Pontuação de Alinhamento

- Meta >80% de alinhamento geral; investigue qualquer pontuação abaixo de 60%
- Pontuações de equilíbrio garantem que nenhuma equipe esteja sobrecarregada
- Alinhamento horizontal evita metas conflitantes entre equipes

### Configuração de Equipe

- Configure as equipes para corresponder à sua estrutura organizacional real
- Ajuste percentuais de contribuição com base no tamanho da equipe
- Equipes de Plataforma/Infraestrutura frequentemente suportam todos os objetivos
- Equipes especializadas (ML, Data) podem suportar apenas objetivos relevantes

## Skills Relacionadas

- **Senior PM** (`project-management/senior-pm/`) — Gestão de portfólio e análise de risco informam o planejamento estratégico
- **Análise Competitiva** (`product-team/competitive-teardown/`) — Inteligência competitiva alimenta a estratégia de produto
