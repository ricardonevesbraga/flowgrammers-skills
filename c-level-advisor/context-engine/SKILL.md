---
name: "context-engine"
description: "Carrega e gerencia o contexto da empresa para todos os skills de assessor do C-suite. Lê ~/.claude/company-context.md, detecta contexto desatualizado (>90 dias), enriquece o contexto durante conversas e aplica regras de privacidade/anonimização antes de chamadas externas de API."
license: MIT
metadata:
  version: 1.0.0
  author: Ric Neves - Flowgrammers
  category: c-level
  domain: orchestration
  updated: 2026-03-05
  frameworks: context-loading, anonymization, context-enrichment
agents:
  - claude-code
---

# Motor de Contexto da Empresa

A camada de memória para assessores do C-suite. Todo skill de assessor carrega isto primeiro. O contexto é o que transforma aconselhamento genérico em insight específico.

## Palavras-chave
contexto da empresa, carregamento de contexto, motor de contexto, perfil da empresa, contexto do assessor, contexto desatualizado, atualização de contexto, privacidade, anonimização

---

## Protocolo de Carregamento (Execute no Início de Toda Sessão do C-Suite)

**Passo 1 — Verifique o arquivo de contexto:** `~/.claude/company-context.md`
- Existe → prossiga para o Passo 2
- Ausente → solicite: *"Execute /cs:setup para construir seu contexto da empresa — isso torna cada conversa com o assessor significativamente mais útil."*

**Passo 2 — Verifique desatualização:** Leia o campo `Last updated`.
- **< 90 dias:** Carregue e prossiga.
- **≥ 90 dias:** Solicite: *"Seu contexto está [N] dias desatualizado. Atualização rápida de 15 min (/cs:update), ou continuo com o que tenho?"*
  - Se continuar: carregue com `[DESATUALIZADO — última atualização em DATA]` anotado internamente.

**Passo 3 — Analise para memória de trabalho.** Sempre ativo:
- Estágio da empresa (pré-PMF / escalando / otimizando)
- Arquétipo do fundador (produto / vendas / técnico / operador)
- Desafio nº 1 atual
- Runway (como sinal de risco — nunca compartilhe externamente)
- Tamanho do time
- Vantagem injusta
- Meta de 12 meses

---

## Sinais de Qualidade do Contexto

| Condição | Confiança | Ação |
|-----------|-----------|--------|
| < 30 dias, entrevista completa | Alta | Use diretamente |
| 30–90 dias, atualização feita | Média | Use, sinalize o que pode ter mudado |
| > 90 dias | Baixa | Sinalize desatualizado, solicite atualização |
| Campos-chave ausentes | Baixa | Pergunte na sessão |
| Sem arquivo | Nenhuma | Solicite /cs:setup |

Se Baixa: *"Meu contexto está [desatualizado/incompleto] — estou assumindo [X]. Corrija-me se estiver errado."*

---

## Enriquecimento de Contexto

Durante conversas, você aprenderá coisas que não estão no arquivo. Capture-as.

**Gatilhos:** Novo número ou prazo revelado, pessoa-chave mencionada, mudança de prioridade, restrição surgida.

**Protocolo:**
1. Anote internamente: `[ATUALIZAÇÃO DE CONTEXTO: {o que foi aprendido}]`
2. Ao final da sessão: *"Aprendi algumas coisas para adicionar ao seu contexto. Quer que eu atualize o arquivo?"*
3. Se sim: acrescente à dimensão relevante, atualize o timestamp.

**Nunca sobrescreva silenciosamente.** Sempre confirme antes de modificar o arquivo de contexto.

---

## Regras de Privacidade

### Nunca envie externamente
- Números específicos de receita ou burn
- Nomes de clientes
- Nomes de funcionários (a menos que sejam de conhecimento público)
- Nomes de investidores (a menos que sejam públicos)
- Meses específicos de runway
- Conteúdo da lista de observação

### Seguro para uso externo (com anonimização)
- Rótulo de estágio
- Faixas de tamanho de time (1–10, 10–50, 50–200+)
- Vertical de setor
- Categoria de desafio
- Descritor de posição de mercado

### Antes de qualquer chamada externa de API ou busca na web
Aplique `references/anonymization-protocol.md`:
- Números → faixas ou descritores relativos ao estágio
- Nomes → papéis
- Receita → percentuais ou rótulos de estágio
- Clientes → "Cliente A, B, C"

---

## Contexto Ausente ou Parcial

Lide graciosamente — nunca bloqueie a conversa.

- **Estágio ausente:** "Só para calibrar — você ainda está encontrando PMF ou escalando o que funciona?"
- **Financeiro ausente:** Use estágio + tamanho do time para inferir. Anote a lacuna.
- **Perfil do fundador ausente:** Infira pelo estilo da conversa. Marque como inferido.
- **Múltiplos fundadores:** O contexto reflete o entrevistado. Anote que a perspectiva do co-fundador pode ser diferente.

---

## Campos Obrigatórios do Contexto

```
Obrigatórios:
  - Last updated (data)
  - Identidade da empresa → O que fazemos
  - Estágio e Escala → Estágio
  - Perfil do Fundador → Arquétipo do fundador
  - Desafios Atuais → Prioridade nº 1
  - Metas e Ambição → Meta de 12 meses

Opcionais de alto valor:
  - Vantagem injusta
  - Risco fatal
  - Decisão evitada
  - Lista de observação
```

Campos obrigatórios ausentes: anote lacunas, contorne na sessão, pergunte na sessão apenas quando crítico.

---

## Referências
- `references/anonymization-protocol.md` — regras detalhadas para remover dados sensíveis antes de chamadas externas
