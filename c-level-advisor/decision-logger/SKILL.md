---
name: "decision-logger"
description: "Arquitetura de memória em duas camadas para decisões de reuniões do conselho. Gerencia transcrições brutas (Camada 1) e decisões aprovadas (Camada 2). Use ao registrar decisões após uma reunião do conselho, revisar decisões passadas com /cs:decisions ou verificar itens de ação vencidos com /cs:review. Invocado automaticamente pela skill de reunião do conselho após aprovação do fundador na Fase 5."
license: MIT
metadata:
  version: 1.0.0
  author: Ric Neves - Flowgrammers
  category: c-level
  domain: decision-memory
  updated: 2026-03-05
agents:
  - claude-code
---

# Decision Logger

Sistema de memória em duas camadas. A Camada 1 armazena tudo. A Camada 2 armazena apenas o que o fundador aprovou. Reuniões futuras leem apenas a Camada 2 — isso previne que consenso alucinado de debates passados contamine novas deliberações.

## Keywords
registro de decisões, memory, approved decisions, itens de ação, board minutes, /cs:decisions, /cs:review, conflict detection, DO_NOT_RESURFACE

## Início Rápido

```bash
python scripts/decision_tracker.py --demo             # Veja exemplo de saída
python scripts/decision_tracker.py --summary          # Visão geral + vencidos
python scripts/decision_tracker.py --overdue          # Ações com prazo vencido
python scripts/decision_tracker.py --conflicts        # Detecção de contradições
python scripts/decision_tracker.py --owner "CTO"      # Filtrar por responsável
python scripts/decision_tracker.py --search "pricing" # Pesquisar decisões
```

---

## Comandos

| Comando | Efeito |
|---------|--------|
| `/cs:decisions` | Últimas 10 decisões aprovadas |
| `/cs:decisions --all` | Histórico completo |
| `/cs:decisions --owner CMO` | Filtrar por responsável |
| `/cs:decisions --topic pricing` | Pesquisar por palavra-chave |
| `/cs:review` | Itens de ação com prazo nos próximos 7 dias |
| `/cs:review --overdue` | Itens com prazo vencido |

---

## Arquitetura de Duas Camadas

### Camada 1 — Transcrições Brutas
**Localização:** `memory/board-meetings/YYYY-MM-DD-raw.md`
- Contribuições completas dos agentes na Fase 2, críticas da Fase 3, síntese da Fase 4
- Todos os debates, incluindo argumentos rejeitados
- **NUNCA carregado automaticamente.** Apenas mediante solicitação explícita do fundador.
- Arquivar após 90 dias → `memory/board-meetings/archive/YYYY/`

### Camada 2 — Decisões Aprovadas
**Localização:** `memory/board-meetings/decisions.md`
- APENAS decisões aprovadas pelo fundador, itens de ação, correções do usuário
- **Carregado automaticamente na Fase 1 de cada reunião do conselho**
- Somente adição. Decisões nunca são excluídas — apenas substituídas.
- Gerenciado pelo Chief of Staff após a Fase 5. Nunca escrito diretamente pelos agentes.

---

## Formato de Entrada de Decisão

```markdown
## [YYYY-MM-DD] — [TÍTULO DO ITEM DA PAUTA]

**Decisão:** [Uma declaração clara do que foi decidido.]
**Responsável:** [Uma pessoa ou função — accountable pela execução.]
**Prazo:** [YYYY-MM-DD]
**Revisão:** [YYYY-MM-DD]
**Justificativa:** [Por que esta em vez das alternativas. 1-2 frases.]

**Override do Usuário:** [Se o fundador alterou a recomendação do agente — o quê e por quê. Em branco se não aplicável.]

**Rejeitado:**
- [Proposta] — [motivo] [DO_NOT_RESURFACE]

**Itens de Ação:**
- [ ] [Ação] — Responsável: [nome] — Prazo: [YYYY-MM-DD] — Revisão: [YYYY-MM-DD]

**Substitui:** [DATA da decisão anterior sobre o mesmo tema, se houver]
**Substituído por:** [Preenchido retroativamente se for substituído posteriormente]
**Transcrição bruta:** memory/board-meetings/[DATE]-raw.md
```

---

## Detecção de Conflitos

Antes de registrar, o Chief of Staff verifica:
1. **Violações de DO_NOT_RESURFACE** — nova decisão corresponde a uma proposta rejeitada
2. **Contradições de tema** — duas decisões ativas sobre o mesmo tema com conclusões diferentes
3. **Conflitos de responsável** — mesma ação atribuída a pessoas diferentes em decisões distintas

Quando um conflito é encontrado:
```
⚠️ CONFLITO DE DECISÃO
Novo: [texto]
Conflita com: [DATA] — [texto existente]

Opções: (1) Substituir a antiga  (2) Mesclar  (3) Encaminhar ao fundador
```

**Aplicação de DO_NOT_RESURFACE:**
```
🚫 BLOQUEADO: "[Proposta]" foi rejeitada em [DATA]. Motivo: [motivo].
Para reabrir: o fundador deve explicitamente dizer "reabrir [tema] de [DATA]".
```

---

## Workflow de Registro (Após a Fase 5)

1. Fundador aprova a síntese
2. Escreva a transcrição bruta da Camada 1 → `YYYY-MM-DD-raw.md`
3. Verifique conflitos contra `decisions.md`
4. Apresente conflitos → aguarde resolução do fundador
5. Adicione entradas aprovadas a `decisions.md`
6. Confirme: decisões registradas, ações rastreadas, flags DO_NOT_RESURFACE adicionadas

---

## Marcando Ações como Concluídas

```markdown
- [x] [Ação] — Responsável: [nome] — Concluído em: [DATA] — Resultado: [uma frase]
```

Nunca exclua itens concluídos. O histórico é o registro.

---

## Estrutura de Arquivos

```
memory/board-meetings/
├── decisions.md       # Camada 2: somente adição, aprovado pelo fundador
├── YYYY-MM-DD-raw.md  # Camada 1: transcrição completa por reunião
└── archive/YYYY/      # Arquivos brutos após 90 dias
```

---

## Referências
- `templates/decision-entry.md` — template de entrada única com regras de campo
- `scripts/decision_tracker.py` — parser CLI, rastreador de vencidos, detector de conflitos
