---
name: "competitive-teardown"
description: "Analisa produtos e empresas concorrentes sintetizando dados de páginas de preços, avaliações de app stores, ofertas de emprego, sinais de SEO e redes sociais em inteligência competitiva estruturada. Produz matrizes de comparação de funcionalidades pontuadas em 12 dimensões, análises SWOT, mapas de posicionamento, auditorias de UX, detalhamentos de modelos de precificação, roadmaps de itens de ação e templates de apresentação para partes interessadas. Use ao realizar análise de concorrentes, comparar produtos com competidores, pesquisar o cenário competitivo, criar battle cards para vendas, preparar uma sessão de estratégia ou roadmap de produto, responder a um novo recurso ou mudança de preço de um concorrente, ou realizar uma revisão competitiva trimestral."
agents:
  - claude-code
---

# Análise Competitiva

**Tier:** PODEROSO  
**Categoria:** Time de Produto  
**Domínio:** Inteligência Competitiva, Estratégia de Produto, Análise de Mercado

---

## Quando Usar

- Antes de uma sessão de estratégia ou roadmap de produto
- Quando um concorrente lança uma funcionalidade ou mudança de preço importante
- Revisão competitiva trimestral
- Antes de uma apresentação de vendas onde você precisa de dados de battle card
- Ao entrar em um novo segmento de mercado

---

## Fluxo de Trabalho de Análise

Siga estas etapas em sequência para produzir uma análise completa:

1. **Definir concorrentes** — Listar 2-4 concorrentes para analisar. Confirmar qual é o foco principal.
2. **Coletar dados** — Use `references/data-collection-guide.md` para reunir sinais brutos de pelo menos 3 fontes por concorrente (website, avaliações, ofertas de emprego, SEO, social).  
   _Ponto de validação: Antes de prosseguir, confirme que você tem dados de precificação, pelo menos 20 avaliações e contagem de ofertas de emprego para cada concorrente._
3. **Pontuar usando a rubrica** — Aplique a rubrica de 12 dimensões abaixo para produzir um scorecard numérico para cada concorrente e seu próprio produto.  
   _Ponto de validação: Cada dimensão deve ter uma pontuação e pelo menos uma nota de evidência de suporte._
4. **Gerar saídas** — Preencha os templates em `references/analysis-templates.md` (Matriz de Funcionalidades, Análise de Precificação, SWOT, Mapa de Posicionamento, Auditoria de UX).
5. **Construir plano de ação** — Traduza as descobertas para o template de Itens de Ação (vitórias rápidas / médio prazo / estratégicas).
6. **Empacotar para partes interessadas** — Monte a Apresentação para Partes Interessadas usando saídas das etapas 3-5.

---

## Guia de Coleta de Dados

> Scripts executáveis completos para cada fonte estão em `references/data-collection-guide.md`. Resumos do que capturar estão abaixo.

### 1. Análise de Website

Principais coisas a capturar:
- Tiers de preço e pontos de preço
- Listas de funcionalidades por tier
- CTA principal e mensagem
- Estudos de caso / logos de clientes (sinais de ICP)
- Logos de integração
- Sinais de confiança (certificações, badges de conformidade)

### 2. Avaliações de App Store

Categorias de sentimento das avaliações:
- **Elogios** → o que os usuários amam (defender / fortalecer isso)
- **Solicitações de funcionalidades** → necessidades não atendidas (lacunas de oportunidade)
- **Bugs** → sinais de qualidade
- **Reclamações de UX** → pontos de fricção em que você pode superá-los

**Exemplo de query para App Store (iTunes Search API):**
```
GET https://itunes.apple.com/search?term=<competitor_name>&entity=software&limit=1
# Extrair trackId, então:
GET https://itunes.apple.com/rss/customerreviews/id=<trackId>/sortBy=mostRecent/json?l=en&limit=50
```
Analisar `entry[].content.label` para texto da avaliação e `entry[].im:rating.label` para avaliação em estrelas.

### 3. Ofertas de Emprego (Sinais de Tamanho de Equipe e Stack Tecnológica)

Sinais de ofertas de emprego:
- **Volume de engenharia** → escalando vs. consolidando
- **Menções de tecnologia específicas** → stack (React/Vue, Postgres/Mongo, AWS/GCP)
- **Proporção de Vendas/CS** → movimento orientado a produto vs. orientado a vendas
- **Papéis de Dados/ML** → funcionalidades de IA em breve
- **Papéis de conformidade** → expansão regulatória

### 4. Análise de SEO

Sinais de SEO a capturar:
- Top 20 palavras-chave orgânicas (intenção: informacional / navegacional / comercial)
- Autoridade de domínio / contagem de backlinks
- Cadência de publicação de blog e tópicos
- Quais páginas rankeiam (páginas de produto vs. blog vs. docs)

### 5. Sentimento em Redes Sociais

Capture menções recentes via API v2 do Twitter/X, Reddit ou LinkedIn. Procure elogios recorrentes, reclamações e solicitações de funcionalidades. Veja `references/data-collection-guide.md` para exemplos de queries de API.

---

## Rubrica de Pontuação (12 Dimensões, 1-5)

| # | Dimensão | 1 (Fraco) | 3 (Médio) | 5 (Melhor da Classe) |
|---|----------|-----------|-----------|----------------------|
| 1 | **Funcionalidades** | Apenas o básico, muitas lacunas | Cobertura sólida | Abrangente + únicos |
| 2 | **Precificação** | Confusa / cara demais | Preço de mercado, claro | Transparente, flexível, justo |
| 3 | **UX** | Confusa, alta fricção | Funcional | Delicioso, fricção mínima |
| 4 | **Desempenho** | Lento, não confiável | Aceitável | Rápido, alta disponibilidade |
| 5 | **Documentação** | Esparsa, desatualizada | Cobertura razoável | Abrangente, pesquisável |
| 6 | **Suporte** | Apenas email, lento | Chat + email | 24/7, ótima resposta |
| 7 | **Integrações** | 0-5 integrações | 6-25 | 26+ ou ecossistema profundo |
| 8 | **Segurança** | Sem menções | SOC2 alegado | SOC2 Tipo II, ISO 27001 |
| 9 | **Escalabilidade** | Sem tier enterprise | Pronto para mercado médio | Grau enterprise |
| 10 | **Marca** | Genérica, esquecível | Posicionamento razoável | Forte, diferenciada |
| 11 | **Comunidade** | Nenhuma | Fórum / Slack | Ativa, vibrante |
| 12 | **Inovação** | Sem lançamentos recentes | Trimestral | Frequente, significativo |

**Exemplo de linha preenchida** (Concorrente: Acme Corp, Dimensão 3 – UX):

| Dimensão | Pontuação Acme Corp | Evidência |
|----------|---------------------|-----------|
| UX | 2 | Avaliações da App Store citam "navegação confusa" (38 menções); integração requer 7 etapas antes do TTFV; sem assistente de integração; cartão de crédito necessário no cadastro. |

Aplique este padrão a todas as 12 dimensões para cada concorrente.

---

## Templates

> O markdown completo dos templates está em `references/analysis-templates.md`. Referência resumida abaixo.

### Matriz de Comparação de Funcionalidades

Linhas: funcionalidades principais, tiers de preço, capacidades de plataforma (web, iOS, Android, API).  
Colunas: seu produto + até 3 concorrentes.  
Pontue cada célula de 1-5. Some para obter o total de 60.  
**Legenda de pontuação:** 5=Melhor da classe, 4=Forte, 3=Médio, 2=Abaixo da média, 1=Fraco/Ausente

### Análise de Precificação

Capture por concorrente: tipo de modelo (por assento / baseado em uso / taxa fixa / freemium), pontos de preço entrada/médio/enterprise, duração do período de teste gratuito.  
Resumo: líder de preço, líder de valor, posicionamento premium, sua posição e 2-3 bullets de oportunidade de precificação.

### Análise SWOT

Para cada concorrente: 3-5 bullets por quadrante (Pontos Fortes, Fraquezas, Oportunidades para nós, Ameaças para nós). Ancore cada bullet em um sinal de dados (citação de avaliação, contagem de ofertas de emprego, página de preços, etc.).

### Mapa de Posicionamento

Eixos 2x2 (ex.: Simples ↔ Complexo / Baixo Valor ↔ Alto Valor). Posicione cada concorrente e seu produto. Tamanho da bolha = participação de mercado ou financiamento. Veja `references/analysis-templates.md` para versões ASCII e editáveis.

### Lista de Verificação de Auditoria de UX

Onboarding: TTFV (minutos), etapas para ativação, cartão de crédito necessário, qualidade do assistente de integração.  
Fluxos de trabalho principais: etapas, pontos de fricção, pontuação comparativa (o seu vs. o deles).  
Mobile: avaliações iOS/Android, paridade de funcionalidades, principal reclamação e elogio.  
Navegação: busca global, atalhos de teclado, ajuda no app.

### Itens de Ação

| Horizonte | Esforço | Exemplos |
|-----------|---------|---------|
| Vitórias rápidas (0-4 sem) | Baixo | Adicionar badges de avaliação, publicar landing page de comparação |
| Médio prazo (1-3 meses) | Moderado | Lançar tier gratuito, melhorar TTFV de integração, adicionar integração mais solicitada |
| Estratégico (3-12 meses) | Alto | Entrar em novo mercado, construir API v2, obter SOC2 Tipo II |

### Apresentação para Partes Interessadas (7 slides)

1. **Sumário Executivo** — Nível de ameaça (BAIXO/MÉDIO/ALTO/CRÍTICO), principal ponto forte, principal oportunidade, ação recomendada
2. **Posição de Mercado** — Mapa de posicionamento 2x2
3. **Scorecard de Funcionalidades** — Radar ou tabela de 12 dimensões, pontuações totais
4. **Análise de Precificação** — Tabela de comparação + insight principal
5. **Destaques de UX** — O que eles fazem melhor (3 bullets) vs. onde vencemos (3 bullets)
6. **Voz do Cliente** — Top 3 reclamações de avaliações (citadas ou parafraseadas)
7. **Nosso Plano de Ação** — Vitórias rápidas, médio prazo, prioridades estratégicas; Apêndice com dados brutos

## Skills Relacionadas

- **Estrategista de Produto** (`product-team/product-strategist/`) — Insights competitivos alimentam planejamento de OKR e estratégia
- **Gerador de Landing Page** (`product-team/landing-page-generator/`) — Posicionamento competitivo informa a mensagem da landing page
