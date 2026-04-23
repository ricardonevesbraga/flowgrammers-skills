---
name: "scenario-war-room"
description: "Modelagem interfuncional de cenários hipotéticos com efeitos cascata e múltiplas variáveis. Ao contrário do teste de estresse de premissa única, este modela adversidade composta em todas as funções do negócio simultaneamente. Use ao enfrentar cenários de risco complexos, decisões estratégicas com grande desvantagem ou quando o usuário perguntar 'e se X E Y acontecerem ao mesmo tempo?'"
license: MIT
metadata:
  version: 1.0.0
  author: Ric Neves - Flowgrammers
  category: c-level
  domain: strategic-planning
  updated: 2026-03-05
  frameworks: scenario-planning
agents:
  - claude-code
---

# Scenario War Room

Modele cenários hipotéticos em cascata por todas as funções do negócio. Não testes de estresse de premissa única — adversidade composta que mostra como um problema cria o próximo.

## Keywords
scenario planning, war room, what-if analysis, risk modeling, cascading effects, compound risk, adversity planning, contingency planning, stress test, crisis planning, multi-variable scenario, pre-mortem

## Início Rápido

```bash
python scripts/scenario_modeler.py   # Construtor interativo de cenários com modelagem em cascata
```

Ou descreva o cenário:
```
/war-room "E se perdermos nosso cliente principal E perdermos a captação do T3?"
/war-room "E se 3 engenheiros saírem E precisarmos entregar até o T3?"
/war-room "E se nosso mercado encolher 30% E um concorrente captar R$250M?"
```

## O que Este Framework Não É

- **Não** é um teste de estresse de premissa única (isso é `/em:stress-test`)
- **Não** é apenas modelagem financeira — cada função é modelada
- **Não** é apenas pior cenário — modela 3 níveis de severidade
- **Não** é paralisia por análise — produz hedges e gatilhos concretos

## Framework: Modelo de Cascata em 6 Passos

### Passo 1: Defina as Variáveis do Cenário (máx. 3)
Declare cada variável com:
- **O que muda** — específico, quantificado se possível
- **Probabilidade** — sua melhor estimativa
- **Prazo** — quando ocorre

```
Variável A: Cliente principal (28% ARR) envia aviso de rescisão de 60 dias
  Probabilidade: 15% | Prazo: Dentro de 90 dias

Variável B: Captação Série A atrasada 6 meses além do fechamento alvo
  Probabilidade: 25% | Prazo: T3

Variável C: Engenheiro principal pede demissão
  Probabilidade: 20% | Prazo: Desconhecido
```

### Passo 2: Mapeamento de Impacto por Domínio

Para cada variável, cada função relevante modela o impacto:

| Domínio | Responsável | Modela |
|---------|-------------|--------|
| Caixa e runway | CFO | Impacto no burn, mudança no runway, opções de bridge |
| Receita | CRO | Gap de ARR, risco de cascata de churn, pipeline |
| Produto | CPO | Impacto no roadmap, risco de PMF |
| Engenharia | CTO | Impacto na velocidade, risco de pessoa-chave |
| Pessoas | CHRO | Cascata de attrição, implicações do congelamento de contratação |
| Operações | COO | Capacidade, impacto nos OKRs, risco de processo |
| Segurança | CISO | Risco de prazo de conformidade |
| Mercado | CMO | Impacto no CAC, exposição competitiva |

### Passo 3: Mapeamento de Efeitos em Cascata

Este é o núcleo. Mostre como a Variável A desencadeia consequências em domínios que ativam os efeitos da Variável B:

```
GATILHO: Churn de cliente (R$2,8M ARR)
  ↓
CFO: Runway cai de 14 → 8 meses
  ↓
CHRO: Congelamento de contratação; risco de retenção aumenta (impacto no moral)
  ↓
CTO: 3 vagas de engenharia abertas congeladas; roadmap desliza
  ↓
CPO: Lançamento de funcionalidade do T4 atrasado → risco de retenção de clientes
  ↓
CRO: NRR cai; contas existentes veem velocidade reduzida → mais risco de churn
  ↓
CFO: [Cascata secundária — espiral de morte potencial se não interrompida]
```

Nomeie a cascata explicitamente. Mostre onde ela pode ser interrompida.

### Passo 4: Matriz de Severidade

Modele três cenários:

| Cenário | Definição | Recuperação |
|---------|-----------|-------------|
| **Base** | Uma variável ocorre; as outras não | Gerenciável com plano |
| **Estresse** | Duas variáveis ocorrem simultaneamente | Requer resposta significativa |
| **Severo** | Todas as variáveis ocorrem; cascata total | Existencial; requer intervenção do conselho |

Para cada nível de severidade:
- Impacto no runway
- Impacto no ARR
- Impacto no headcount
- Prazo para estado inaceitável (ponto de gatilho)

### Passo 5: Pontos de Gatilho (Sinais de Alerta Precoce)

Defina o sinal mensurável que indica que um cenário está se desdobrando **antes** de ser confirmado:

```
Gatilho para Risco de Churn de Cliente:
  - Patrocinador não responde por >3 semanas
  - Uso cai >25% mês a mês
  - Nenhuma QBR do T1 confirmada até 1° de dezembro

Gatilho para Atraso na Captação:
  - <3 term sheets após 60 dias de processo
  - Investidor-líder solicita extensão >30 dias na due diligence
  - Concorrente capta a avaliação mais baixa (sinal de mercado)

Gatilho para Attrição de Engenharia:
  - Atividade no Glassdoor do time de engenharia
  - 2+ pedidos de entrevista de indicação de engenheiros
  - Contra-oferta acima do mercado exigida nos últimos 3 meses
```

### Passo 6: Estratégias de Hedge

Para cada cenário: ações a tomar **agora** (antes do cenário se materializar) que reduzem o impacto se ocorrer.

| Hedge | Custo | Impacto | Responsável | Prazo |
|-------|-------|---------|-------------|-------|
| Estabelecer linha de crédito de R$2,5M | R$25K/ano | Ganha 3 meses se churn ocorrer | CFO | 60 dias |
| Bônus de retenção de 12 meses para 3 engenheiros-chave | R$450K | Fideliza time durante a captação | CHRO | 30 dias |
| Diversificar para <20% de concentração de receita por cliente | Esforço de vendas | Reduz risco de cliente único | CRO | 2 trimestres |
| Comprima prazo de captação, inicie processo paralelo | Tempo do CEO | Fecha antes que as pistas de runway se unam | CEO | Imediato |

---

## Formato de Saída

Cada sessão de war room produz:

```
CENÁRIO: [Nome]
Variáveis: [A, B, C]
Caminho mais provável: [qual combinação realmente se desenvolve, com probabilidade]

NÍVEIS DE SEVERIDADE
Base (apenas A): [impacto no runway/ARR] — recuperação: [X ações]
Estresse (A+B): [impacto no runway/ARR] — recuperação: [X ações]
Severo (A+B+C): [impacto no runway/ARR] — risco existencial: [sim/não]

MAPA DE CASCATA
[A → impacto no domínio → gatilho B → impacto no domínio → estado final]

SINAIS DE ALERTA PRECOCE
- [Sinal 1 → qual cenário indica]
- [Sinal 2 → qual cenário indica]
- [Sinal 3 → qual cenário indica]

HEDGES (tome estas ações agora)
1. [Ação] — custo: R$X — impacto: [o que compra] — responsável: [função] — prazo: [data]
2. [Ação] — custo: R$X — impacto: [o que compra] — responsável: [função] — prazo: [data]
3. [Ação] — custo: R$X — impacto: [o que compra] — responsável: [função] — prazo: [data]

DECISÃO RECOMENDADA
[Um parágrafo. O que fazer, em que ordem e por quê.]
```

---

## Regras para Boas Sessões de War Room

**Máximo 3 variáveis por cenário.** Mais de 3 é ruído — você não consegue se preparar significativamente para um colapso de 5 variáveis. Modele as 3 que realmente te preocupam.

**Quantifique ou estime.** "Receita cai" não é útil. "R$2,1M ARR em risco em 60 dias" é. Use intervalos se incerto.

**Não pare nos efeitos de primeira ordem.** O dano está sempre na cascata, não no impacto inicial.

**Modele a recuperação, não apenas o impacto.** Todo cenário deve ter um caminho de "o que fazemos".

**Separe o cenário base da sensibilidade.** Não confunda "o que provavelmente acontece" com "o que poderia acontecer".

**Não exceda na modelagem.** 3–4 cenários por ciclo de planejamento é o número certo. Mais cria paralisia por análise.

---

## Cenários Comuns por Estágio

**Seed:**
- Co-fundador sai + produto perde o prazo de lançamento
- Financiamento acaba + termos de bridge desfavoráveis

**Série A:**
- Perde meta de ARR + captação atrasada
- Cliente-chave cancela + concorrente capta recursos

**Série B:**
- Contração de mercado + burn multiple dispara
- Investidor-líder quer pivô + time resiste

## Integração com Funções C-Suite

| Tipo de Cenário | Funções Primárias | Cascata Para |
|----------------|-------------------|--------------|
| Perda de receita | CRO, CFO | CMO (pipeline), COO (cortes), CHRO (layoffs) |
| Saída de pessoa-chave | CHRO, COO | CTO (se eng.), CRO (se vendas) |
| Falha na captação | CFO, CEO | COO (extensão do runway), CHRO (congelamento de contratação) |
| Violação de segurança | CISO, CTO | CEO (comunicação), CFO (custo), CRO (impacto no cliente) |
| Mudança de mercado | CEO, CPO | CMO (reposicionamento), CRO (novos segmentos) |
| Movimento de concorrente | CMO, CRO | CPO (resposta no roadmap), CEO (estratégia) |

## Referências
- `references/scenario-planning.md` — metodologia Shell, pre-mortem, Monte Carlo, frameworks de cascata
- `scripts/scenario_modeler.py` — ferramenta CLI para modelagem estruturada de cenários
