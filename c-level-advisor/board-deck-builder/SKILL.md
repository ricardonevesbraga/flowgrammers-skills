---
name: "board-deck-builder"
description: "Monta apresentações abrangentes para conselhos e atualizações para investidores, reunindo perspectivas de todos os papéis do C-suite. Use ao preparar reuniões de conselho, atualizações para investidores, revisões trimestrais de negócios ou narrativas de captação. Cobre estrutura, framework narrativo, entrega de más notícias e erros comuns."
license: MIT
metadata:
  version: 1.0.0
  author: Ric Neves - Flowgrammers
  category: c-level
  domain: board-governance
  updated: 2026-03-05
  frameworks: deck-frameworks, board-deck-template
agents:
  - claude-code
---

# Construtor de Deck para o Conselho

Construa apresentações para o conselho que contam uma história — não apenas mostram dados. Cada seção tem um responsável, uma narrativa e um "e daí?"

## Palavras-chave
apresentação para o conselho, atualização para investidores, reunião de conselho, board pack, relações com investidores, revisão trimestral, apresentação para o conselho, deck de captação, deck para investidores, narrativa do conselho, QBR, revisão trimestral de negócios

## Início Rápido

```
/board-deck [quarterly|monthly|fundraising] [stage: seed|seriesA|seriesB]
```

Forneça as métricas disponíveis. O construtor preenche lacunas com marcadores explícitos — nunca inventa números.

## Estrutura do Deck (Ordem Padrão)

Cada seção segue: **Título → Dados → Narrativa → Solicitação/Próximo passo**

### 1. Sumário Executivo (CEO)
**3 frases. Não mais.**
- Frase 1: Estado do negócio (onde estamos)
- Frase 2: A maior coisa que aconteceu neste período
- Frase 3: Para onde vamos no próximo trimestre

*Ruim:* "Tivemos um bom trimestre com muito progresso em todas as áreas."
*Bom:* "Encerramos o T3 com ARR de R$2,4M (+22% QoQ), assinamos nosso maior contrato enterprise e entramos no T4 com runway de 14 meses. A mudança estratégica para o mid-market está funcionando — ACV subiu 40% e o ciclo de vendas caiu 3 semanas. Prioridade do T4: fechar a Série A de R$3M e atingir ARR de R$2,8M."

### 2. Painel de Métricas Principais (COO)
**6-8 métricas no máximo. Use uma tabela.**

| Métrica | Este Período | Período Anterior | Meta | Status |
|--------|-------------|-------------|--------|--------|
| ARR | R$2,4M | R$1,97M | R$2,3M | ✅ |
| Crescimento MoM | 8,1% | 7,2% | 7,5% | ✅ |
| Burn multiple | 1,8x | 2,1x | <2x | ✅ |
| NRR | 112% | 108% | >110% | ✅ |
| Payback do CAC | 11 meses | 14 meses | <12 meses | ✅ |
| Headcount | 24 | 21 | 25 | 🟡 |

Escolha métricas que o conselho realmente acompanha. Substitua qualquer coisa que eles disseram não se importar.

### 3. Atualização Financeira (CFO)
- Resumo de P&L: Receita, CMV, Margem bruta, OpEx, Burn líquido
- Posição de caixa e runway (meses)
- Tendência do burn multiple (visão de 3 trimestres)
- Variância em relação ao plano (o que foi diferente e por quê)
- Atualização de previsão para o próximo trimestre

**Uma frase sobre cada variância.** O conselho odeia "a receita ficou abaixo da meta" sem explicação. Diga por quê.

### 4. Receita e Pipeline (CRO)
- Cascata de ARR: inicial → novo → expansão → churn → final
- NRR e taxa de cancelamento por logo
- Pipeline por estágio (em R$, não apenas contagem)
- Previsão: próximo trimestre com nível de confiança
- Top 3 negócios: nome/valor/data de fechamento/risco

**A previsão deve ter um nível de confiança.** "Esperamos R$2,8M" é fraco. "Alta confiança de R$2,6M, potencial de R$2,9M se dois negócios em estágio avançado fecharem" é útil.

### 5. Atualização de Produto (CPO)
- Entregues neste trimestre: 3-5 bullets, impacto no usuário para cada um
- Entregues no próximo trimestre: 3-5 bullets com datas-alvo
- Sinal de PMF: tendência de NPS, razão DAU/MAU, adoção de funcionalidades
- Um aprendizado-chave da pesquisa com clientes

**Sem listas de funcionalidades.** Apenas funcionalidades com evidência de impacto no usuário.

### 6. Crescimento e Marketing (CMO)
- CAC por canal (tabela)
- Contribuição de pipeline por canal (R$)
- Métricas de marca/awareness relevantes ao estágio (tráfego, share of voice)
- O que está funcionando, o que está sendo cortado, o que está sendo testado

### 7. Engenharia e Técnico (CTO)
- Tendência de velocidade de entrega (últimos 4 trimestres)
- Razão de dívida técnica e plano
- Infraestrutura: uptime, incidentes, tendência de custo
- Postura de segurança (uma linha, sinalize qualquer coisa pendente)

**Mantenha isso curto, a menos que haja um problema material.** O conselho não precisa de detalhes de sprint.

### 8. Time e Pessoas (CHRO)
- Headcount: real vs. plano
- Contratação: ofertas abertas, pipeline, tendência de tempo para preencher
- Attrition: lamentável vs. não lamentável
- Engajamento: última pontuação de pesquisa, tendência
- Contratações-chave neste trimestre, vagas-chave em aberto

### 9. Risco e Segurança (CISO)
- Postura de segurança: status dos controles críticos
- Compliance: certificações em andamento, prazos
- Incidentes neste trimestre (se houver): impacto, resolução, prevenção
- Top 3 riscos e status de mitigação

### 10. Perspectiva Estratégica (CEO)
- Prioridades do próximo trimestre: 3-5 itens, classificados
- Decisões necessárias do conselho
- Solicitações: orçamento, apresentações, conselhos, votos

**O slide de "solicitações" é o mais importante.** Seja específico. "Gostaríamos de 3 apresentações quentes a CFOs em empresas Série B" supera "qualquer ajuda seria apreciada."

### 11. Apêndice
- Modelo financeiro detalhado
- Dados completos de pipeline
- Gráficos de retenção por coorte
- Cases de clientes
- Detalhamento detalhado de headcount

---

## Framework Narrativo

O conselho vê mais de 10 decks por trimestre. O seu precisa de um fio condutor.

**A Estrutura de 4 Atos:**
1. **Onde dissemos que estaríamos** (metas do último trimestre)
2. **Onde realmente estamos** (avaliação honesta)
3. **Por que a lacuna existe** (uma causa por variância, não desculpas)
4. **O que estamos fazendo a respeito** (ações específicas com data)

Isso funciona para boas notícias E más notícias. É crível porque reconhece a realidade.

**Enquadramento de abertura:** Comece com a única coisa que mais importa — o conselho deve conhecer a mensagem-chave até o slide 3, não o slide 30.

---

## Entregando Más Notícias

Nunca esconda. O conselho descobre eventualmente. Descobrir tarde piora a situação.

**Framework:**
1. **Declare diretamente** — "Perdemos a meta de ARR do T3 em R$300K (lacuna de 12%)"
2. **Assuma a causa** — "Fator principal foi o ciclo de vendas mais longo do que o esperado no segmento enterprise"
3. **Mostre que entende** — "Analisamos 8 negócios perdidos/travados; o padrão é X"
4. **Apresente a correção** — "Fizemos 3 mudanças: [mudanças específicas com data]"
5. **Atualize a previsão** — "Meta revisada do T4 é R$2,6M; aqui está a construção de baixo para cima"

**O que NÃO fazer:**
- Não lidere com boas notícias para suavizar as más — o conselho percebe e desconfia do enquadramento
- Não explique sem assumir — "condições de mercado" não é uma causa, é um contexto
- Não apresente uma correção sem dados por trás dela
- Não mostre uma previsão revisada sem mostrar suas premissas

---

## Erros Comuns no Deck para o Conselho

| Erro | Correção |
|---------|-----|
| Slides demais (>25) | Corte sem piedade — se não consegue explicar na sala, o slide está errado |
| Métricas sem metas | Toda métrica precisa de uma meta e um status |
| Sem narrativa | Dados sem história forçam o conselho a tirar suas próprias conclusões |
| Esconder más notícias | Lidere com elas, assuma, corrija |
| Solicitações vagas | Apenas solicitações específicas, acionáveis, atribuídas a uma pessoa |
| Sem explicação de variância | Toda lacuna em relação à meta precisa de uma causa em uma frase |
| Apêndice desatualizado | O apêndice só é útil se estiver atualizado |
| Projetado para o leitor, não para a sala | Decks são apresentados — precisam funcionar quando falados em voz alta |

---

## Notas de Cadência

**Trimestral (padrão):** Deck completo, todas as seções, 20-30 slides. Enviado 48 horas antes.
**Mensal (para estágios iniciais):** Condensado — painel de métricas, financeiro, pipeline, principais riscos. 8-12 slides.
**Captação:** Abre com mercado/visão, fecha com solicitação. Veja `references/deck-frameworks.md` para o formato Sequoia.

## Referências
- `references/deck-frameworks.md` — formato de board pack SaaS, estrutura Sequoia, adaptação para investidores
- `templates/board-deck-template.md` — template preenchível para apresentações completas ao conselho
