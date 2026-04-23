---
name: "marketing-strategy-pmm"
description: Skill de product marketing para posicionamento, estratégia GTM, inteligência competitiva e lançamentos de produto. Use quando o usuário perguntar sobre posicionamento de produto, planejamento de go-to-market, análise competitiva, definição de público-alvo, definição de ICP, pesquisa de mercado, planos de lançamento ou capacitação de vendas. Cobre posicionamento April Dunford, definição de ICP, battlecards competitivos, playbooks de lançamento e entrada em mercados internacionais. Produz entregáveis incluindo declarações de posicionamento, documentos de battlecard, planos de lançamento e estratégias go-to-market.
triggers:
  - product marketing
  - PMM
  - positioning
  - GTM strategy
  - go-to-market
  - competitive analysis
  - battlecard
  - product launch
  - market entry
  - sales enablement
  - win loss analysis
agents:
  - claude-code
---

# Estratégia de Marketing & PMM

Padrões de product marketing para posicionamento, estratégia GTM e inteligência competitiva.

---

## Sumário

- [Fluxo de Trabalho de Definição de ICP](#icp-definition-workflow)
- [Desenvolvimento de Posicionamento](#positioning-development)
- [Inteligência Competitiva](#competitive-intelligence)
- [Planejamento de Lançamento de Produto](#product-launch-planning)
- [Capacitação de Vendas](#sales-enablement)
- [Expansão Internacional](#international-expansion)
- [Documentação de Referência](#reference-documentation)

---

## Fluxo de Trabalho de Definição de ICP

Defina o perfil de cliente ideal para segmentação:

1. Analisar clientes existentes (top 20% por LTV)
2. Identificar firmográficos comuns (tamanho, setor, receita)
3. Mapear tecnográficos (ferramentas, maturidade, integrações)
4. Documentar psicográficos (nível de dor, motivação, tolerância a risco)
5. Definir 3-5 personas de comprador (econômico, técnico, usuário)
6. Validar contra dados de ciclo de vendas e churn
7. Pontuar prospects A/B/C/D com base no fit com ICP
8. **Validação:** Clientes A-fit têm menor churn e fechamento mais rápido

### Template de Firmográficos

| Dimensão | Faixa Alvo | Justificativa |
|----------|------------|---------------|
| Funcionários | 50-5000 | Sweet spot Série A |
| Receita | R$25M-R$2,5B | Orçamento disponível |
| Setor | SaaS, Tecnologia, Serviços | Fit do produto |
| Geografia | BR, US, UK, DACH | Prioridade de mercado |
| Funding | Seed a Growth | Disposição para adotar |

### Personas de Comprador

| Persona | Cargo | Objetivos | Mensagem |
|---------|-------|-----------|---------|
| Comprador Econômico | VP, Diretor, Head de [Departamento] | ROI, produtividade do time, redução de custos | Resultados de negócio, ROI, estudos de caso |
| Comprador Técnico | Engenheiro, Arquiteto, Tech Lead | Fit técnico, integração fácil | Arquitetura, segurança, documentação |
| Usuário/Champion | Gerente, Team Lead, Power User | Facilita o trabalho, ganhos rápidos | UX, facilidade de uso, economia de tempo |

### Checklist de Validação de ICP

- [ ] 5+ clientes pagantes correspondem a este perfil
- [ ] Ciclos de vendas mais rápidos (< mediana)
- [ ] Maior LTV (> mediana)
- [ ] Menor churn (< 5% anual)
- [ ] Forte engajamento com o produto
- [ ] Disposição para participar de estudos de caso

---

## Desenvolvimento de Posicionamento

Desenvolva posicionamento usando a metodologia April Dunford:

1. Listar alternativas competitivas (diretas, adjacentes, status quo)
2. Isolar atributos únicos (funcionalidades que só você tem)
3. Mapear atributos para valor do cliente (por que importa)
4. Definir clientes de melhor fit (quem se importa mais)
5. Escolher categoria de mercado (frente a frente, nicho, nova categoria)
6. Adicionar tendências relevantes (justificativa de timing)
7. Testar com 10+ entrevistas com clientes
8. **Validação:** 7+ clientes descrevem o valor espontaneamente

### Template de Declaração de Posicionamento

```
PARA [cliente alvo]
QUE [declaração de necessidade]
O [produto] É UM [categoria]
QUE [benefício principal]
AO CONTRÁRIO DE [alternativa competitiva]
NOSSO PRODUTO [diferenciação principal]
```

### Fórmula de Proposta de Valor

Template: `[Produto] ajuda [Cliente Alvo] a [Alcançar Objetivo] por meio de [Abordagem Única]`

Exemplo: "Acme ajuda times de SaaS de médio porte a entregar 2x mais rápido automatizando fluxos de trabalho de projetos com IA"

### Hierarquia de Mensagens

| Nível | Conteúdo | Exemplo |
|-------|---------|---------|
| Título | 5-7 palavras | "Entregue mais rápido com automação de IA" |
| Subtítulo | 1 frase | "Automatize fluxos de trabalho para que os times foquem no que importa" |
| Benefícios | 3-4 bullets | Velocidade, qualidade, colaboração, custo |
| Funcionalidades | Evidências de suporte | Automação IA → 10h/semana economizadas |
| Prova | Prova social | Logos de clientes, estatísticas, estudos de caso |

---

## Inteligência Competitiva

Construa base de conhecimento competitivo:

1. Identificar tier 1 (direto), tier 2 (adjacente), tier 3 (status quo)
2. Se inscrever nos produtos dos concorrentes (avaliação prática)
3. Monitorar sites, preços e mensagens dos concorrentes
4. Analisar gravações de chamadas de vendas para menções de concorrentes
5. Ler avaliações no G2/Capterra (prós e contras)
6. Rastrear vagas de emprego dos concorrentes (sinais de roadmap)
7. Atualizar battlecards mensalmente
8. **Validação:** Time de vendas usa battlecards em 80%+ dos negócios competitivos

### Estrutura de Tiers Competitivos

| Tier | Definição | Exemplos |
|------|-----------|----------|
| 1 | Concorrente direto, mesma categoria | [Concorrente A, B] |
| 2 | Solução adjacente, caso de uso sobreposto | [Solução Alt C, D] |
| 3 | Status quo (o que fazem hoje) | Planilhas, manual, interno |

### Template de Battlecard

```
CONCORRENTE: [Nome]
VISÃO GERAL: Fundado em [ano], Funding [estágio], Tamanho [funcionários]

POSICIONAMENTO:
- Eles dizem: "[Afirmação deles]"
- Realidade: [Sua avaliação]

PONTOS FORTES:
1. [O que fazem bem]
2. [O que fazem bem]

PONTOS FRACOS:
1. [Onde ficam aquém]
2. [Onde ficam aquém]

NOSSAS VANTAGENS:
1. [Sua vantagem + evidência]
2. [Sua vantagem + evidência]

QUANDO GANHAMOS:
- [Cenário onde você ganha]

QUANDO PERDEMOS:
- [Cenário onde eles ganham]

SCRIPT DE CONVERSA:
Objeção: "[Objeção comum]"
Resposta: "[Sua resposta]"
```

### Análise de Win/Loss

Rastrear mensalmente:
- Taxa de win por concorrente
- Principais razões de vitória (fit do produto, facilidade de uso, preço)
- Principais razões de perda (funcionalidade faltante, preço, relacionamento)
- Itens de ação para produto, vendas, marketing

---

## Planejamento de Lançamento de Produto

Planeje lançamentos por tier:

| Tier | Escopo | Tempo de Prep | Orçamento |
|------|--------|---------------|-----------|
| 1 | Novo produto, funcionalidade maior | 6-8 semanas | R$250-500k |
| 2 | Funcionalidade significativa, integração | 3-4 semanas | R$50-125k |
| 3 | Pequena melhoria | 1 semana | <R$25k |

### Fluxo de Trabalho de Lançamento Tier 1

Execute lançamento principal de produto:

1. Reunião de kickoff com Produto, Marketing, Vendas, CS
2. Definir metas (pipeline R$, MQLs, cobertura de imprensa)
3. Desenvolver posicionamento e mensagens
4. Criar capacitação de vendas (deck, demo, battlecard)
5. Construir ativos de campanha (landing page, e-mails, anúncios)
6. Treinar times de vendas e CS
7. Executar dia do lançamento (imprensa, e-mail, anúncios, outbound)
8. Monitorar e otimizar por 30 dias
9. **Validação:** Pipeline no caminho da meta até a semana 2

### Checklist do Dia do Lançamento

- [ ] Press release distribuído
- [ ] Anúncio por e-mail enviado
- [ ] Posts em redes sociais ao vivo
- [ ] Anúncios pagos com orçamento completo
- [ ] Blitz de outbound de vendas lançado
- [ ] Notificação in-app ativa
- [ ] Métricas monitoradas a cada 2 horas

### Métricas de Lançamento

| Métrica | Leading (Diária) | Lagging (Semanal) |
|---------|------------------|-------------------|
| Tráfego | Visitantes da landing page | - |
| Engajamento | Solicitações de demo, cadastros | % de adoção de funcionalidade |
| Pipeline | MQLs gerados | SQLs, pipeline R$ |
| Receita | - | Negócios fechados, receita |

---

## Capacitação de Vendas

Equipe o time de vendas com ativos de PMM:

1. Criar deck de vendas (15-20 slides, visual em primeiro lugar)
2. Construir one-pagers (produto, competitivo, estudo de caso)
3. Desenvolver script de demo (30-45 min com discovery)
4. Escrever templates de e-mail (outreach, acompanhamento, fechamento)
5. Criar calculadora de ROI (input custos, output economias)
6. Conduzir chamadas mensais de capacitação
7. Entregar treinamento trimestral (posicionamento, competitivo)
8. **Validação:** Vendas usa ativos em 80%+ das oportunidades

### Estrutura do Deck de Vendas

| Slide | Conteúdo |
|-------|---------|
| 1-2 | Título, agenda |
| 3-4 | Introdução da empresa, declaração do problema |
| 5-7 | Solução, benefícios principais, demo |
| 8-10 | Diferenciação, estudo de caso, precificação |
| 11-12 | Implementação, suporte, próximos passos |

### Fluxo de Demo

```
1. Introdução (2 min): Quem somos, agenda
2. Discovery (5 min): Necessidades e pontos de dor deles
3. Demo (20 min): Produto focado no caso de uso deles
4. Q&A (10 min): Tratamento de objeções
5. Próximos passos (3 min): Trial, POC, proposta
```

### Handoff Vendas-Marketing

| Handoff | Frequência | Conteúdo |
|---------|-----------|---------|
| Sync semanal | 30 min | Win/loss, competitivo, novos ativos |
| Capacitação mensal | 60 min | Atualizações de produto, treinamento |
| Revisão trimestral | Meio dia | Resultados, estratégia, planejamento |

---

## Expansão Internacional

Entre em novos mercados sistematicamente:

1. Validar demanda de mercado (leads inbound, análise de TAM)
2. Localizar website, preços, jurídico
3. Estabelecer cobertura de vendas (contratar ou agência)
4. Adaptar mensagens para fit cultural
5. Construir parcerias e referências locais
6. Lançar campanhas localizadas
7. Monitorar CAC e conversão por mercado
8. **Validação:** 3+ clientes pagantes do mercado nos primeiros 90 dias

### Prioridade de Mercado (Série A)

| Mercado | Prazo | % Orçamento | ARR Alvo |
|---------|-------|-------------|---------|
| Brasil | Meses 1-6 | 40% | R$5M |
| US | Meses 4-9 | 30% | R$2,5M |
| UK | Meses 7-12 | 15% | R$1,5M |
| DACH | Meses 10-15 | 10% | R$1M |
| Canada | Meses 7-12 | 5% | R$500k |

### Checklist de Localização

- [ ] Tradução do website (profissional, não machine translation)
- [ ] Moeda e preços localizados (R$ para Brasil)
- [ ] Número de telefone e endereço locais
- [ ] Conformidade legal (LGPD, GDPR, PIPEDA)
- [ ] Métodos de pagamento locais (PIX para Brasil)
- [ ] Cobertura de vendas durante horário local
- [ ] Estudos de caso e referências locais

---

## Documentação de Referência

### Frameworks de Posicionamento

`references/positioning-frameworks.md` contém:

- Processo de posicionamento em 5 etapas de April Dunford
- Template de declaração de posicionamento de Geoffrey Moore
- Protocolo de entrevista de validação de posicionamento
- Construção de mapa de posicionamento competitivo

### Checklists de Lançamento

`references/launch-checklists.md` contém:

- Checklists de lançamento Tier 1/2/3
- Cronograma de lançamento semana a semana
- Runbook do dia de lançamento
- Painel de métricas pós-lançamento

### GTM Internacional

`references/international-gtm.md` contém:

- Playbooks para BR, US, UK, DACH, France, Canada
- Mix de canal e mensagens específicos por mercado
- Requisitos de localização por mercado
- Cronograma de entrada e alocação de orçamento

### Templates de Mensagens

`references/messaging-templates.md` contém:

- Fórmulas de proposta de valor
- Mensagens específicas por persona
- Scripts de resposta competitiva
- Templates de tratamento de objeções
- Copy específico por canal (landing pages, e-mails, anúncios)

---

## KPIs de PMM

| Métrica | Meta | Medição |
|---------|------|---------|
| Adoção de produto | >40% em 90 dias | Uso de funcionalidade após lançamento |
| Taxa de win | >30% competitivo | Negócios ganhos vs. concorrentes |
| Velocidade de vendas | -20% YoY | Dias de SQL ao fechamento |
| Tamanho do negócio | +25% YoY | Valor médio de contrato |
| Pipeline de lançamento | 3:1 ROMI | Pipeline R$ : gasto de marketing |

---

## Referência Rápida

### Ritmo Mensal de PMM

| Semana | Foco |
|--------|------|
| 1 | Revisar métricas, atualizar battlecards |
| 2 | Criar ativos, publicar conteúdo |
| 3 | Suportar lançamentos, otimizar campanhas |
| 4 | Relatório mensal, planejar próximo mês |

## Gatilhos Proativos

- **Sem posicionamento documentado** → Sem posicionamento claro, todo marketing é adivinhação.
- **Mensagens diferem entre canais** → História inconsistente confunde compradores.
- **Sem ICP definido** → Vender para todos significa vender para ninguém.
- **Reposicionamento de concorrente** → Mudança de mercado detectada. Revise seu posicionamento.

## Artefatos de Saída

| Quando você pede... | Você recebe... |
|---------------------|----------------|
| "Posicione meu produto" | Framework de posicionamento (método April Dunford) com saída |
| "Estratégia GTM" | Plano go-to-market com canais, mensagens e cronograma |
| "Posicionamento competitivo" | Mapa de posicionamento com lacunas e oportunidades competitivas |

## Comunicação

Toda saída passa por verificação de qualidade:
- Autovalidação: atribuição de fonte, auditoria de suposições, pontuação de confiança
- Formato de saída: Conclusão → O quê (com confiança) → Por quê → Como Agir
- Apenas resultados. Cada descoberta marcada: 🟢 verificado, 🟡 médio, 🔴 assumido.

## Skills Relacionadas

- **marketing-context**: Para capturar posicionamento fundamental. PMM constrói sobre isso.
- **launch-strategy**: Para executar lançamentos de produto planejados pelo PMM.
- **competitive-intel** (C-Suite): Para inteligência competitiva estratégica.
- **cmo-advisor** (C-Suite): Para decisões de orçamento de marketing e modelo de crescimento.
