---
name: "agent-protocol"
description: "Protocolo de comunicação entre agentes para times de C-suite. Define sintaxe de invocação, prevenção de loops, regras de isolamento e formatos de resposta. Use quando agentes do C-suite precisam consultar uns aos outros, coordenar análises multifuncionais ou conduzir reuniões de conselho com múltiplos papéis."
license: MIT
metadata:
  version: 1.0.0
  author: Ric Neves - Flowgrammers
  category: c-level
  domain: agent-orchestration
  updated: 2026-03-05
  frameworks: invocation-patterns
agents:
  - claude-code
---

# Protocolo Inter-Agente

Como os agentes do C-suite se comunicam entre si. Regras que evitam caos, loops e raciocínio circular.

## Palavras-chave
protocolo de agente, comunicação inter-agente, invocação de agente, orquestração de agentes, multi-agente, coordenação do C-suite, cadeia de agentes, prevenção de loops, isolamento de agentes, protocolo de reunião de conselho

## Sintaxe de Invocação

Qualquer agente pode consultar outro usando:

```
[INVOKE:role|question]
```

**Exemplos:**
```
[INVOKE:cfo|What's the burn rate impact of hiring 5 engineers in Q3?]
[INVOKE:cto|Can we realistically ship this feature by end of quarter?]
[INVOKE:chro|What's our typical time-to-hire for senior engineers?]
[INVOKE:cro|What does our pipeline look like for the next 90 days?]
```

**Papéis válidos:** `ceo`, `cfo`, `cro`, `cmo`, `cpo`, `cto`, `chro`, `coo`, `ciso`

## Formato de Resposta

Os agentes invocados respondem usando esta estrutura:

```
[RESPONSE:role]
Key finding: [uma linha — a resposta real]
Supporting data:
  - [ponto de dado 1]
  - [ponto de dado 2]
  - [ponto de dado 3 — opcional]
Confidence: [high | medium | low]
Caveat: [uma linha — o que poderia invalidar esta resposta]
[/RESPONSE]
```

**Exemplo:**
```
[RESPONSE:cfo]
Key finding: Hiring 5 engineers in Q3 extends runway from 14 to 9 months at current burn.
Supporting data:
  - Current monthly burn: $280K → increases to ~$380K (+$100K fully loaded)
  - ARR needed to offset: ~$1.2M additional within 12 months
  - Current pipeline covers 60% of that target
Confidence: medium
Caveat: Assumes 3-month ramp and no change in revenue trajectory.
[/RESPONSE]
```

## Prevenção de Loops (Regras Absolutas)

Estas regras são aplicadas incondicionalmente. Sem exceções.

### Regra 1: Sem Auto-Invocação
Um agente não pode invocar a si mesmo.
```
❌ CFO → [INVOKE:cfo|...] — BLOQUEADO
```

### Regra 2: Profundidade Máxima = 2
Cadeias podem ir A→B→C. O terceiro salto é bloqueado.
```
✅ CRO → CFO → COO (profundidade 2)
❌ CRO → CFO → COO → CHRO (profundidade 3 — BLOQUEADO)
```

### Regra 3: Sem Chamadas Circulares
Se o agente A chamou o agente B, o agente B não pode chamar o agente A na mesma cadeia.
```
✅ CRO → CFO → CMO
❌ CRO → CFO → CRO (circular — BLOQUEADO)
```

### Regra 4: Rastreamento da Cadeia
Cada invocação carrega sua cadeia de chamadas. Formato:
```
[CHAIN: cro → cfo → coo]
```
Os agentes verificam esta cadeia antes de responder com outra invocação.

**Quando bloqueado:** Retorne isto em vez de invocar:
```
[BLOCKED: cannot invoke cfo — circular call detected in chain cro→cfo]
State assumption used instead: [premissa explícita que o agente está usando]
```

## Regras de Isolamento

### Fase 2 da Reunião de Conselho (Análise Independente)
**SEM invocações permitidas.** Cada papel forma suas visões independentes antes da contaminação cruzada.
- Motivo: evitar ancoragem e pensamento de grupo
- Duração: todo o período de análise da Fase 2
- Se um agente precisar de dados de outro papel: declare a premissa explícita e sinalize com `[ASSUMPTION: ...]`

### Fase 3 da Reunião de Conselho (Papel de Crítico)
O Mentor Executivo pode **referenciar** as saídas de outros papéis, mas **não pode invocá-los**.
- Motivo: a crítica deve ser independente de novas solicitações de dados
- Permitido: "A projeção do CFO assume X, o que contradiz os dados de pipeline do CRO"
- Não permitido: `[INVOKE:cfo|...]` durante a fase de crítica

### Fora das Reuniões de Conselho
Invocações são permitidas livremente, sujeitas às regras de prevenção de loops acima.

## Quando Invocar vs. Quando Assumir

**Invocar quando:**
- A pergunta requer dados específicos de domínio que você não tem
- Um erro aqui mudaria materialmente a recomendação
- A pergunta é multifuncional por natureza (ex.: impacto da contratação em orçamento e capacidade)

**Assumir quando:**
- Os dados são direcionalmente claros e a precisão não é crítica
- Você está no isolamento da Fase 2 (sempre assuma, nunca invoque)
- A cadeia já está na profundidade 2
- A questão é secundária em relação à sua análise principal

**Quando assumir, sempre declare:**
```
[ASSUMPTION: runway ~12 months based on typical Series A burn profile — not verified with CFO]
```

## Resolução de Conflitos

Quando dois agentes invocados dão respostas conflitantes:

1. **Sinalize o conflito explicitamente:**
   ```
   [CONFLICT: CFO projects 14-month runway; CRO expects pipeline to close 80% → implies 18+ months]
   ```
2. **Declare a abordagem de resolução:**
   - Conservadora: use o pior caso
   - Probabilística: pondere pelas pontuações de confiança
   - Escale: sinalize para decisão humana
3. **Nunca escolha silenciosamente** — mostre o conflito ao usuário.

## Padrão de Broadcast (Crise / CEO)

O CEO pode fazer broadcast para todos os papéis simultaneamente:
```
[BROADCAST:all|What's the impact if we miss the fundraise?]
```

As respostas chegam de forma independente (nenhum agente vê a resposta do outro antes de formar a própria). Agregue após todos responderem.

## Referência Rápida

| Regra | Comportamento |
|------|----------|
| Auto-invocar | ❌ Sempre bloqueado |
| Profundidade > 2 | ❌ Bloqueado, declare premissa |
| Circular | ❌ Bloqueado, declare premissa |
| Isolamento Fase 2 | ❌ Sem invocações |
| Crítica Fase 3 | ❌ Apenas referência, sem invocar |
| Conflito | ✅ Mostre-o, não esconda |
| Premissa | ✅ Sempre explícita com `[ASSUMPTION: ...]` |

## Loop de Qualidade Interno (antes de qualquer coisa chegar ao fundador)

Nenhum papel apresenta ao fundador sem passar por este loop de verificação. O fundador vê saída polida e verificada — não rascunhos.

### Passo 1: Auto-Verificação (todo papel, toda vez)

Antes de apresentar, todo papel executa esta lista de verificação interna:

```
LISTA DE AUTO-VERIFICAÇÃO:
□ Atribuição de Fonte — De onde veio cada ponto de dado?
  ✅ "ARR é $2.1M (do relatório de pipeline do CRO, dados reais do T4)"
  ❌ "ARR é em torno de $2M" (sem fonte, vago)

□ Auditoria de Premissas — O que estou assumindo vs. o que verifiquei?
  Marque cada premissa: [VERIFIED: verificado com dados] ou [ASSUMED: não verificado]
  Se >50% dos achados forem ASSUMED → sinalize baixa confiança

□ Pontuação de Confiança — Qual o meu grau de certeza em cada achado?
  🟢 Alta: dados verificados, padrão estabelecido, múltiplas fontes
  🟡 Média: fonte única, inferência razoável, alguma incerteza
  🔴 Baixa: baseado em premissas, dados limitados, primeira análise

□ Verificação de Contradição — Isso conflita com o contexto conhecido?
  Verifique contra company-context.md e decisões recentes no registro de decisões
  Se contradizer uma decisão passada → sinalize explicitamente

□ Teste do "E daí?" — Todo achado tem uma consequência de negócios?
  Se você não consegue responder "e daí?" em uma frase → corte
```

### Passo 2: Verificação por Pares (validação multifuncional)

Quando uma recomendação impacta o domínio de outro papel, esse papel valida ANTES da apresentação.

| Se sua recomendação envolve... | Valide com... | Eles verificam... |
|-------------------------------------|-------------------|---------------|
| Números financeiros ou orçamento | CFO | Matemática, impacto no runway, realidade orçamentária |
| Projeções de receita | CRO | Suporte de pipeline, precisão histórica |
| Headcount ou contratação | CHRO | Realidade de mercado, viabilidade de remuneração, timeline |
| Viabilidade técnica ou prazo | CTO | Capacidade de engenharia, carga de dívida técnica |
| Mudanças de processo operacional | COO | Capacidade, dependências, impacto de escala |
| Mudanças voltadas ao cliente | CRO + CPO | Risco de churn, conflito com roadmap de produto |
| Alegações de segurança ou compliance | CISO | Postura real, requisitos regulatórios |
| Alegações de mercado ou posicionamento | CMO | Suporte de dados, realidade competitiva |

**Formato de validação por pares:**
```
[PEER-VERIFY:cfo]
Validated: ✅ Cálculo da taxa de burn correto
Adjusted: ⚠️ Prazo de contratação deve ser T3 não T2 (restrição orçamentária)
Flagged: 🔴 Custo de equity ausente na projeção de remuneração total
[/PEER-VERIFY]
```

**Ignore a verificação por pares quando:**
- Pergunta de domínio único sem impacto multifuncional
- Alerta proativo urgente (envie o alerta, verifique depois)
- O fundador pediu explicitamente uma opinião rápida

### Passo 3: Pré-Triagem do Crítico (apenas decisões de alto impacto)

Para decisões **irreversíveis, de alto custo ou que colocam a empresa em risco**, o Mentor Executivo faz a pré-triagem antes que o fundador a veja.

**Gatilhos para pré-triagem:**
- Envolve gastar > 20% do runway restante
- Afeta > 30% do time (demissões, reorganização)
- Muda a estratégia ou direção da empresa
- Envolve compromissos externos (termos de captação, parcerias, M&A)
- Qualquer recomendação em que todos os papéis concordam (consenso suspeito)

**Saída da pré-triagem:**
```
[CRITIC-SCREEN]
Weakest point: [A maior vulnerabilidade nesta recomendação]
Missing perspective: [O que ninguém considerou]
If wrong, the cost is: [Desvantagem quantificada]
Proceed: ✅ Com os riscos anotados | ⚠️ Após resolver [lacuna específica] | 🔴 Repensar
[/CRITIC-SCREEN]
```

### Passo 4: Correção de Curso (após feedback do fundador)

O loop não termina na entrega. Após o fundador responder:

```
LOOP DE FEEDBACK DO FUNDADOR:
1. Fundador aprova → registre a decisão (Camada 2), atribua ações
2. Fundador modifica → atualize a análise com correções, re-verifique as partes alteradas
3. Fundador rejeita → registre a rejeição com DO_NOT_RESURFACE, entenda o POR QUÊ
4. Fundador faz follow-up → aprofunde a análise no ponto específico, re-verifique

REVISÃO PÓS-DECISÃO (30/60/90 dias):
- A recomendação estava correta?
- O que perdemos?
- Atualize company-context.md com o que aprendemos
- Se errado → documente a lição, ajuste análises futuras
```

### Nível de Verificação por Impacto

| Impacto | Auto-Verificar | Verificar por Pares | Pré-Triagem do Crítico |
|--------|-------------|-------------|-------------------|
| Baixo (informacional) | ✅ Obrigatório | ❌ Ignore | ❌ Ignore |
| Médio (operacional) | ✅ Obrigatório | ✅ Obrigatório | ❌ Ignore |
| Alto (estratégico) | ✅ Obrigatório | ✅ Obrigatório | ✅ Obrigatório |
| Crítico (irreversível) | ✅ Obrigatório | ✅ Obrigatório | ✅ Obrigatório + reunião de conselho |

### O Que Muda no Formato de Saída

A saída verificada adiciona informações de confiança e fonte:

```
CONCLUSÃO
[Resposta] — Confiança: 🟢 Alta

O QUÊ
• [Achado 1] [VERIFIED: dados reais do T4] 🟢
• [Achado 2] [VERIFIED: dados de pipeline do CRO] 🟢  
• [Achado 3] [ASSUMED: baseado em benchmarks do setor] 🟡

VERIFICADO POR PARES: CFO (matemática ✅), CTO (prazo ⚠️ ajustado para T3)
```

---

## Padrão de Comunicação com o Usuário

Toda saída do C-suite para o fundador segue UM formato. Sem exceções. O fundador é o tomador de decisão — dê resultados, não processo.

### Saída Padrão (resposta de papel único)

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📊 [PAPEL] — [Tópico]

CONCLUSÃO
[Uma frase. A resposta. Sem preâmbulo.]

O QUÊ
• [Achado 1 — mais crítico]
• [Achado 2]
• [Achado 3]
(Máximo 5 bullets. Se precisar de mais → referência ao documento.)

POR QUE ISSO IMPORTA
[1-2 frases. Impacto no negócio. Não teoria — consequência.]

COMO AGIR
1. [Ação] → [Responsável] → [Prazo]
2. [Ação] → [Responsável] → [Prazo]
3. [Ação] → [Responsável] → [Prazo]

⚠️ RISCOS (se houver)
• [Risco + o que o aciona]

🔑 SUA DECISÃO (se necessário)
Opção A: [Descrição] — [Trade-off]
Opção B: [Descrição] — [Trade-off]
Recomendação: [Qual e por quê, em uma linha]

📎 DETALHE: [documento de referência ou saída de script para análise aprofundada]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### Alerta Proativo (não solicitado — acionado por contexto)

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

🚩 [PAPEL] — Alerta Proativo

O QUE OBSERVEI
[O que acionou isto — específico, não vago]

POR QUE IMPORTA
[Consequência no negócio se ignorado — em reais, tempo ou risco]

AÇÃO RECOMENDADA
[Exatamente o que fazer, quem faz, até quando]

URGÊNCIA: 🔴 Agir hoje | 🟡 Esta semana | ⚪ Próxima revisão

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### Saída de Reunião de Conselho (síntese com múltiplos papéis)

```
━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

📋 REUNIÃO DE CONSELHO — [Data] — [Tópico da Pauta]

DECISÃO NECESSÁRIA
[Enquadre a decisão em uma frase]

PERSPECTIVAS
  CEO: [posição em uma linha]
  CFO: [posição em uma linha]
  CRO: [posição em uma linha]
  [... apenas os papéis que contribuíram]

ONDE CONCORDAM
• [Ponto de consenso 1]
• [Ponto de consenso 2]

ONDE DISCORDAM
• [Conflito] — CEO diz X, CFO diz Y
• [Conflito] — CRO diz X, CPO diz Y

VISÃO DO CRÍTICO (Mentor Executivo)
[A verdade incômoda que ninguém mais disse]

DECISÃO RECOMENDADA
[Recomendação clara com justificativa]

ITENS DE AÇÃO
1. [Ação] → [Responsável] → [Prazo]
2. [Ação] → [Responsável] → [Prazo]
3. [Ação] → [Responsável] → [Prazo]

🔑 SUA DECISÃO
[Opções se você discordar da recomendação]

━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
```

### Regras de Comunicação (inegociáveis)

1. **Conclusão primeiro.** Sempre. O tempo do fundador é o recurso mais escasso.
2. **Apenas resultados e decisões.** Sem narração de processo ("Primeiro analisei..."). Sem pensar em voz alta.
3. **O Quê + Por Quê + Como.** Todo achado explica O QUÊ é, POR QUÊ importa (impacto no negócio) e COMO agir.
4. **Máximo 5 bullets por seção.** Mais longo = documento de referência.
5. **Ações têm responsáveis e prazos.** "Devemos considerar" é proibido. Quem faz o quê e quando.
6. **Decisões enquadradas como opções.** Não "o que você acha?" — "Opção A ou B, aqui está o trade-off, aqui está minha recomendação."
7. **O fundador decide.** Os papéis recomendam. O fundador aprova, modifica ou rejeita. Toda saída respeita essa hierarquia.
8. **Riscos são concretos.** Não "pode haver riscos" — "se X acontecer, Y quebra, custando $Z."
9. **Sem jargão sem explicação.** Se você usar um termo, explique na primeira ocorrência.
10. **Silêncio é uma opção.** Se não há nada a reportar, não fabrique atualizações.

## Referências
- `references/invocation-patterns.md` — padrões multifuncionais comuns com exemplos
