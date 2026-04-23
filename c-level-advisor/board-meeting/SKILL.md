---
name: "board-meeting"
description: "Protocolo de reunião de conselho com múltiplos agentes para tomada de decisões. Executa uma deliberação estruturada em 6 fases: carregamento de contexto, contribuições independentes do C-suite (isoladas, sem contaminação cruzada), análise crítica, síntese, revisão do fundador e extração de decisão. Use quando o usuário invocar /cs:board, solicitar uma reunião de conselho ou querer deliberação executiva estruturada com múltiplas perspectivas sobre uma questão estratégica."
license: MIT
metadata:
  version: 1.0.0
  author: Ric Neves - Flowgrammers
  category: c-level
  domain: board-protocol
  updated: 2026-03-05
  frameworks: 6-phase-board, two-layer-memory, independent-contributions
agents:
  - claude-code
---

# Protocolo de Reunião de Conselho

Deliberação multi-agente estruturada que evita pensamento de grupo, captura visões minoritárias e produz decisões limpas e acionáveis.

## Palavras-chave
reunião de conselho, deliberação executiva, decisão estratégica, C-suite, multi-agente, /cs:board, revisão do fundador, extração de decisão, perspectivas independentes

## Invocação
`/cs:board [tópico]` — ex.: `/cs:board Devemos expandir para São Paulo no T3?`

---

## O Protocolo de 6 Fases

### FASE 1: Coleta de Contexto
1. Carregue `memory/company-context.md`
2. Carregue `memory/board-meetings/decisions.md` **(Apenas Camada 2 — nunca transcrições brutas)**
3. Reinicie o estado da sessão — sem contaminação de conversas anteriores
4. Apresente a pauta + papéis ativados → aguarde confirmação do fundador

**O Chief of Staff seleciona os papéis relevantes** com base no tópico (não todos os 9 toda vez):
| Tópico | Ativar |
|-------|----------|
| Expansão de mercado | CEO, CMO, CFO, CRO, COO |
| Direção de produto | CEO, CPO, CTO, CMO |
| Contratação/org | CEO, CHRO, CFO, COO |
| Precificação | CMO, CFO, CRO, CPO |
| Tecnologia | CTO, CPO, CFO, CISO |

---

### FASE 2: Contribuições Independentes (ISOLADAS)

**Sem contaminação cruzada. Cada agente executa antes de ver as saídas dos outros.**

Ordem: Pesquisa (se necessário) → CMO → CFO → CEO → CTO → COO → CHRO → CRO → CISO → CPO

**Técnicas de raciocínio:** CEO: Árvore de Pensamento (3 futuros) | CFO: Cadeia de Pensamento (mostre a matemática) | CMO: Recursão de Pensamento (rascunho→crítica→refinamento) | CPO: Primeiros Princípios | CRO: Cadeia de Pensamento (matemática de pipeline) | COO: Passo a Passo (mapa de processo) | CTO: ReAct (pesquisa→analise→aja) | CISO: Baseado em Risco (P×I) | CHRO: Empatia + Dados

**Formato de contribuição (máximo 5 pontos-chave, auto-verificados):**
```
## [PAPEL] — [DATA]

Pontos-chave (máximo 5):
• [Achado] — [VERIFIED/ASSUMED] — 🟢/🟡/🔴
• [Achado] — [VERIFIED/ASSUMED] — 🟢/🟡/🔴

Recomendação: [posição clara]
Confiança: Alta / Média / Baixa
Fonte: [de onde vieram os dados]
O que mudaria minha opinião: [condição específica]
```

Cada agente se auto-verifica antes de contribuir: atribuição de fonte, auditoria de premissas, pontuação de confiança. Sem afirmações sem marcação.

---

### FASE 3: Análise Crítica
O Mentor Executivo recebe TODAS as saídas da Fase 2 simultaneamente. Papel: revisor adversarial, não sintetizador.

Lista de verificação:
- Onde os agentes concordaram com muita facilidade? (consenso suspeito = sinal de alerta)
- Quais premissas são compartilhadas mas não validadas?
- Quem está faltando na sala? (voz do cliente? operações de linha de frente?)
- Qual risco ninguém mencionou?
- Qual agente operou fora do seu domínio?

---

### FASE 4: Síntese
O Chief of Staff entrega usando o formato de **Saída de Reunião de Conselho** (definido em `agent-protocol/SKILL.md`):
- Decisão Necessária (uma frase)
- Perspectivas (uma linha por papel contribuinte)
- Onde Concordam / Onde Discordam
- Visão do Crítico (a verdade incômoda)
- Decisão Recomendada + Itens de Ação (responsáveis, prazos)
- Sua Decisão (opções se o fundador discordar)

---

### FASE 5: Fundador no Loop ⏸️

**Parada completa. Aguarde o fundador.**

```
⏸️ REVISÃO DO FUNDADOR — [Cole a síntese]

Opções: ✅ Aprovar | ✏️ Modificar | ❌ Rejeitar | ❓ Fazer follow-up
```

**Regras:**
- Correções do usuário SUBSTITUEM as propostas dos agentes. Sem objeções. Sem "mas o CFO disse..."
- Inatividade de 30 min → fechar automaticamente como "revisão pendente"
- Reabrir a qualquer momento com `/cs:board resume`

---

### FASE 6: Extração de Decisão
Após aprovação do fundador:
- **Camada 1:** Escreva a transcrição completa → `memory/board-meetings/YYYY-MM-DD-raw.md`
- **Camada 2:** Adicione decisões aprovadas → `memory/board-meetings/decisions.md`
- Marque propostas rejeitadas com `[DO_NOT_RESURFACE]`
- Confirme ao fundador com contagem de decisões registradas, ações rastreadas, sinalizações adicionadas

---

## Estrutura de Memória
```
memory/board-meetings/
├── decisions.md          # Camada 2 — apenas aprovadas pelo fundador (Fase 1 carrega este)
├── YYYY-MM-DD-raw.md     # Camada 1 — transcrições completas (nunca carregadas automaticamente)
└── archive/YYYY/         # Transcrições brutas após 90 dias
```

**Reuniões futuras carregam apenas a Camada 2.** Nunca a Camada 1. Isso evita consenso alucinado.

---

## Referência Rápida de Modos de Falha
| Falha | Correção |
|---------|-----|
| Pensamento de grupo (todos concordam) | Re-execute a Fase 2 isolada; force "argumento mais forte contra" |
| Paralisia de análise | Limite a 5 pontos; force recomendação mesmo com confiança Baixa |
| Bikeshedding | Registre como item de ação assíncrono; volte à pauta principal |
| Contaminação de papel (CFO tomando decisões de produto) | O Crítico sinaliza; exclua da síntese |
| Contaminação de camada | Fase 1 carrega apenas decisions.md — regra absoluta |

---

## Referências
- `templates/meeting-agenda.md` — formato de pauta
- `templates/meeting-minutes.md` — formato de saída final
- `references/meeting-facilitation.md` — gestão de conflitos, timing, modos de falha
