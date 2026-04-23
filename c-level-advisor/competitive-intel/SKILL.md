---
name: "competitive-intel"
description: "Rastreamento sistemático de concorrentes que alimenta o posicionamento do CMO, battlecards do CRO e decisões de roadmap do CPO. Use ao analisar concorrentes, construir battlecards de vendas, rastrear movimentos de mercado, posicionar-se contra alternativas ou quando o usuário mencionar inteligência competitiva, análise competitiva, pesquisa de concorrentes, battlecards, win/loss ou posicionamento de mercado."
license: MIT
metadata:
  version: 1.0.0
  author: Ric Neves - Flowgrammers
  category: c-level
  domain: competitive-strategy
  updated: 2026-03-05
  frameworks: ci-playbook, battlecard-template
agents:
  - claude-code
---

# Inteligência Competitiva

Rastreamento sistemático de concorrentes. Não obsessão — inteligência que conduz decisões reais.

## Palavras-chave
inteligência competitiva, análise de concorrentes, battlecard, análise win/loss, posicionamento competitivo, rastreamento competitivo, inteligência de mercado, pesquisa de concorrentes, SWOT, mapa competitivo, análise de lacunas de funcionalidades, estratégia competitiva

## Início Rápido

```
/ci:landscape         — Mapeie seu espaço competitivo (direto, indireto, futuro)
/ci:battlecard [nome] — Construa um battlecard de vendas para um concorrente específico
/ci:winloss           — Analise vitórias e derrotas recentes por motivo
/ci:update [nome]     — Rastreie o que um concorrente fez recentemente
/ci:map               — Construa mapa de posicionamento competitivo
```

## Framework: Sistema de Inteligência de 5 Camadas

### Camada 1: Identificação de Concorrentes

**Concorrentes diretos:** Mesmo ICP, mesmo problema, solução comparável, ponto de preço semelhante.
**Concorrentes indiretos:** Mesmo orçamento, solução diferente (incluindo "não fazer nada" e "construir internamente").
**Concorrentes futuros:** Startups bem financiadas em espaço adjacente; grandes incumbentes com sobreposição declarada de roadmap.

**A Matriz de Ameaça 2x2:**

| | Mesmo ICP | ICP Diferente |
|---|---|---|
| **Mesmo problema** | Ameaça direta | Adjacente (observar) |
| **Problema diferente** | Risco de deslocamento | Ignore por enquanto |

Atualize isto trimestralmente. Quem mudou de quadrante?

### Camada 2: Dimensões de Rastreamento

Rastreie estas 8 dimensões por concorrente:

| Dimensão | Fontes | Cadência |
|-----------|---------|---------|
| **Movimentos de produto** | Changelog, avaliações G2/Capterra, Twitter/LinkedIn | Mensal |
| **Mudanças de preço** | Página de preços, inteligência de calls de vendas, feedback de clientes | Acionado |
| **Captação** | Crunchbase, TechCrunch, LinkedIn | Acionado |
| **Sinais de contratação** | Vagas no LinkedIn, Indeed | Mensal |
| **Parcerias** | Press releases, co-marketing | Acionado |
| **Vitórias de clientes** | Cases, sites de avaliação, LinkedIn | Mensal |
| **Perda de clientes** | Entrevistas win/loss, contas churned | Contínuo |
| **Mudanças de mensagens** | Homepage, anúncios (Biblioteca de Anúncios do Facebook/Google) | Trimestral |

### Camada 3: Frameworks de Análise

**SWOT por Concorrente:**
- Forças: O que eles fazem bem? Onde eles vencem?
- Fraquezas: Onde eles perdem? O que os clientes reclamam?
- Oportunidades: O que eles poderiam fazer que ameaçaria você?
- Ameaças: Qual é o risco existencial deles?

**Mapa de Posicionamento Competitivo (2 eixos):**
Escolha eixos que importam para seus compradores:
- Comuns: Preço vs. Profundidade de funcionalidade; Pronto para enterprise vs. Pronto para PME; Fácil de implementar vs. Configurável
- Escolha eixos que mostram SUA diferenciação claramente

**Análise de Lacunas de Funcionalidades:**
| Funcionalidade | Você | Concorrente A | Concorrente B | Status da lacuna |
|---------|-----|-------------|-------------|------------|
| [Funcionalidade] | ✅ | ✅ | ❌ | Sua vantagem |
| [Funcionalidade] | ❌ | ✅ | ✅ | Lacuna — no roadmap? |
| [Funcionalidade] | ✅ | ❌ | ❌ | Fosso |
| [Funcionalidade] | ❌ | ❌ | ✅ | Apenas Concorrente B |

### Camada 4: Formatos de Saída

**Para Vendas (CRO):** Battlecards — uma página por concorrente, projetado para preparação pré-call.
Veja `templates/battlecard-template.md`

**Para Marketing (CMO):** Atualização de posicionamento — mudanças de mensagem, novos diferenciais, afirmações para parar ou começar a fazer.

**Para Produto (CPO):** Resumo de lacunas de funcionalidades — o que os clientes pedem que não temos, o que os concorrentes lançam, o que repriorizar.

**Para CEO/Conselho:** Resumo competitivo mensal — 1 página: quem se moveu, o que significa, respostas recomendadas.

### Camada 5: Cadência de Inteligência

**Mensal (agendado):**
- Revise todos os concorrentes tier-1 (ameaças diretas, top 3)
- Atualize battlecards com nova inteligência
- Publique resumo de 1 página para a liderança

**Acionado (baseado em evento):**
- Concorrente capta recursos → avalie implicações em 48 horas
- Concorrente lança funcionalidade importante → resposta de produto + vendas em 1 semana
- Concorrente rouba cliente-chave → entrevista win/loss em 2 semanas
- Concorrente muda preços → analise e responda em 1 semana

**Trimestral:**
- Revisão completa do panorama competitivo
- Atualize o mapa de posicionamento
- Atualize a avaliação de ameaça competitiva do ICP
- Adicione/remova empresas da lista de rastreamento

---

## Análise Win/Loss

Este é o dado competitivo de maior sinal que você tem. A maioria das empresas o faz com pouca frequência.

**Quando entrevistar:**
- Todo negócio perdido > R$50K ACV
- Todo churn com > 6 meses de posse
- Toda vitória competitiva (aprenda por quê — pode não ser o que você pensa)

**Quem conduz:**
- NÃO o AE que trabalhou no negócio (muito próximo, o prospect não será franco)
- Sucesso do cliente, time de produto ou pesquisador externo

**Estrutura de perguntas:**
1. "Me fale sobre seu processo de avaliação"
2. "Quem mais você estava considerando?"
3. "Quais foram os 3 critérios principais na sua decisão?"
4. "Onde o [nosso produto] ficou aquém?"
5. "Qual foi o fator decisivo?"
6. "O que teria mudado sua decisão?"

**Agregue os achados mensalmente:**
- Motivos de vitória (classifique por frequência)
- Motivos de derrota (classifique por frequência)
- Taxas de vitória dos concorrentes (por concorrente, por segmento)
- Padrões ao longo do tempo

---

## O Equilíbrio: Inteligência Sem Obsessão

**Sinais de que você está rastreando concorrentes demais:**
- Decisões de roadmap são principalmente motivadas por "eles acabaram de lançar X"
- O moral do time cai quando concorrentes captam recursos
- Você está lançando funcionalidades em que não acredita para combinar com o checklist deles
- Discussões de preços sempre começam com "bem, eles cobram X"

**Sinais de que você está rastreando concorrentes de menos:**
- Seus AEs são pegos de surpresa em calls
- Os prospects sabem mais sobre concorrentes do que seu time
- Você perdeu um lançamento importante de produto até que os clientes te contaram
- Seu posicionamento não mudou em 12+ meses apesar de movimentos de mercado

**A postura certa:**
- Conheça os concorrentes bem o suficiente para vencer contra eles
- Não deixe que eles definam sua agenda
- Seu roadmap é liderado por problemas do cliente, informado por lacunas competitivas

---

## Distribuindo Inteligência

| Público | Formato | Cadência | Responsável |
|----------|--------|---------|-------|
| AEs + SDRs | Battlecards atualizados no CRM | Mensal + acionado | CRO |
| Produto | Análise de lacunas de funcionalidades | Trimestral | CPO |
| Marketing | Briefing de posicionamento | Trimestral | CMO |
| Liderança | Resumo competitivo de 1 página | Mensal | CEO/COO |
| Conselho | Slide de panorama competitivo | Trimestral | CEO |

**Uma fonte de verdade:** Toda inteligência competitiva fica em um lugar (Notion, Confluence, Salesforce). Evite distribuição apenas por Slack — ela desaparece.

---

## Sinais de Alerta em Inteligência Competitiva

| Sinal | O que significa |
|--------|---------------|
| Taxa de vitória do concorrente >50% no seu segmento principal | Problema fundamental de posicionamento, não problema de vendas |
| Mesma objeção em 5+ negócios: "o concorrente tem X" | Lacuna de funcionalidade que é real, não apenas percepção |
| Concorrente contratou 10 engenheiros no seu domínio | Grande investimento de produto chegando |
| Concorrente captou >R$20M e mira no seu ICP | Runway de 12 meses para eles competirem agressivamente |
| Prospects avaliam você para justificar decisão pelo concorrente | Você é o "check box" — corrija a percepção ou mude de segmento |

## Integração com Papéis do C-Suite

| Tipo de Inteligência | Alimenta | Formato de Saída |
|------------------|----------|---------------|
| Movimentos de produto | CPO | Input de roadmap, análise de lacunas de funcionalidades |
| Mudanças de preço | CRO, CFO | Recomendações de resposta de preços |
| Rodadas de captação | CEO, CFO | Atualização de posicionamento estratégico |
| Sinais de contratação | CHRO, CTO | Inteligência do mercado de talentos |
| Vitórias/perdas de clientes | CRO, CMO | Atualizações de battlecard, mudanças de posicionamento |
| Campanhas de marketing | CMO | Contra-posicionamento, inteligência de canais |

## Referências
- `references/ci-playbook.md` — fontes OSINT, framework win/loss, construção de mapa de posicionamento
- `templates/battlecard-template.md` — template de battlecard de vendas
