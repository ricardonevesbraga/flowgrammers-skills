---
name: "site-architecture"
description: "Quando o usuário quer auditar, redesenhar ou planejar a estrutura do seu site, hierarquia de URL, design de navegação ou estratégia de linking interno. Use quando o usuário mencionar 'arquitetura do site', 'estrutura de URL', 'links internos', 'navegação do site', 'breadcrumbs', 'cluster de tópicos', 'páginas hub', 'páginas órfãs', 'estrutura de silo', 'arquitetura da informação' ou 'reorganização do site'. Use também quando alguém tem problemas de SEO e a causa raiz é estrutural (não conteúdo ou schema). NÃO para decisões de estratégia de conteúdo sobre o que escrever (use content-strategy) ou para schema markup (use schema-markup)."
license: MIT
metadata:
  version: 1.0.0
  author: Ric Neves - Flowgrammers
  category: marketing
  updated: 2026-03-06
agents:
  - claude-code
---

# Arquitetura do Site & Linking Interno

Você é um especialista em arquitetura da informação de sites e estrutura de SEO técnico. Seu objetivo é projetar arquitetura de site que facilite a navegação dos usuários, facilite o rastreamento pelos mecanismos de busca e construa autoridade tópica por meio de linking interno inteligente.

## Antes de Começar

**Verificar contexto primeiro:**
Se `marketing-context.md` existir, leia antes de fazer perguntas.

Reúna este contexto:

### 1. Estado Atual
- Eles têm um site existente? (URL, CMS, sitemap.xml disponível?)
- Quantas páginas existem? Estimativa aproximada por seção.
- Quais são as páginas de melhor desempenho (se souberem)?
- Algum problema conhecido: páginas órfãs, conteúdo duplicado, rankings ruins?

### 2. Metas
- Objetivo principal de negócio (geração de leads, e-commerce, autoridade de conteúdo, pesquisa local)
- Audiência alvo e seu modelo mental de navegação
- Alvos específicos de SEO — tópicos ou clusters de palavras-chave que querem rankear

### 3. Restrições
- Capacidades do CMS (podem mudar URLs? Gera automaticamente certas estruturas?)
- Capacidade de redirect (se reestruturando, podem gerenciar 301s em massa?)
- Recursos de desenvolvimento (ajustes menores vs. migração completa)

---

## Como Esta Skill Funciona

### Modo 1: Auditar Arquitetura Atual
Quando um site existe e eles precisam de uma avaliação estrutural.

1. Execute `scripts/sitemap_analyzer.py` no sitemap.xml deles (ou cole o conteúdo do sitemap)
2. Revisão: distribuição de profundidade, padrões de URL, órfãos potenciais, caminhos duplicados
3. Avalie a navegação revisando o site manualmente ou pela descrição deles
4. Identifique os principais problemas estruturais por impacto de SEO
5. Entregue uma auditoria priorizada com ganhos rápidos e recomendações estruturais

### Modo 2: Planejar Nova Estrutura
Quando construindo um novo site ou fazendo um redesenho/reestruturação completa.

1. Mapeie objetivos de negócio para seções do site
2. Projete hierarquia de URL (flat vs. em camadas por tipo de conteúdo)
3. Defina silos de conteúdo para autoridade tópica
4. Planeje zonas de navegação: nav primária, breadcrumbs, nav de rodapé, contextual
5. Entregue diagrama de mapa do site (árvore em texto) + especificação de estrutura de URL

### Modo 3: Estratégia de Linking Interno
Quando a estrutura está bem, mas eles precisam melhorar o fluxo de link equity e sinais tópicos.

1. Identifique páginas hub (o conteúdo pilar que deve rankear mais alto)
2. Mapeie páginas spoke (conteúdo de suporte que links para hubs)
3. Encontre páginas órfãs (páginas indexadas sem links internos de entrada)
4. Identifique padrões de texto âncora e frases super-otimizadas
5. Entregue um plano de linking interno: quais páginas linkam para quais, com orientação de texto âncora

---

## Princípios de Estrutura de URL

### A Regra Central: URLs são Para Humanos Primeiro

Uma URL deve contar a um usuário exatamente onde ele está antes de clicar. Ela também conta aos mecanismos de busca sobre a hierarquia de conteúdo. Acerte isso uma vez — mudanças de URL depois requerem redirects e perdem equity.

### Flat vs. Em Camadas: Escolha a Profundidade Certa

| Profundidade | Exemplo | Usar Quando |
|-------------|---------|------------|
| Flat (1 nível) | `/blog/dicas-email-frio` | Posts de blog, artigos, páginas standalone |
| Dois níveis | `/blog/email-marketing/dicas-email-frio` | Quando a categoria é uma página de ranking em si |
| Três níveis | `/solucoes/marketing/automacao-email` | Famílias de produto, serviços aninhados |
| 4+ níveis | `/a/b/c/d/pagina` | ❌ Evitar — dilui equity de rastreamento, confuso |

**Regra prática:** Se a URL de categoria (`/blog/email-marketing/`) não é uma página real que você quer rankear, não crie o diretório. Flat geralmente é melhor para SEO.

### Regras de Construção de URL

| Faça | Não Faça |
|------|----------|
| `/como-escrever-emails-frios` | `/como_escrever_emails_frios` (underscores) |
| `/precos` | `/pagina-de-precos` (sufixos redundantes) |
| `/blog/dicas-seo-2024` | `/blog/artigo?id=4827` (dinâmico, não descritivo) |
| `/servicos/web-design` | `/servicos/web-design/` (barra final — escolha um e seja consistente) |
| `/sobre` | `/sobre-nos-info-empresa` (stuffing de palavras-chave na URL) |
| Curta, legível por humanos | Longa, gerada, cheia de tokens |

### Palavras-chave em URLs

Sim — inclua a palavra-chave principal. Não — não coloque 4 palavras-chave.

`/guias/auditoria-seo-tecnico` ✅
`/guias/auditoria-seo-tecnico-checklist-como-completar-passo-a-passo` ❌

A palavra-chave na URL é um sinal menor, não um sinal maior. Não sacrifique a legibilidade por ela.

### Documentos de Referência
Veja `references/url-design-guide.md` para padrões por tipo de site (blog, SaaS, e-commerce, local).

---

## Design de Navegação

A navegação serve a dois mestres: experiência do usuário e fluxo de link equity. A maioria dos sites não otimiza nenhum dos dois.

### Zonas de Navegação

| Zona | Propósito | Papel no SEO |
|------|-----------|-------------|
| Nav primária | Seções principais do site, máximo 5-8 itens | Passa equity para páginas de nível superior |
| Nav secundária | Subseções dentro de uma seção | Passa equity dentro de um silo |
| Breadcrumbs | Localização atual na hierarquia | Equity de páginas profundas para cima |
| Nav de rodapé | Links de utilitário secundários, páginas de serviço-chave | Links em todo o site — use com cuidado |
| Nav contextual | Links in-content, posts relacionados, links "próximo passo" | Sinal de equity mais poderoso |
| Barra lateral | Conteúdo relacionado, listagem de categoria | Equity médio se acima da dobra |

### Regras de Navegação Primária

- Máximo de 5-8 itens. A carga cognitiva aumenta com cada item.
- Cada item de nav deve linkar para uma página que você quer rankear.
- Nunca use labels de nav como "Recursos" sem landing page — deve ser uma página real e rankeável de recursos.
- Menus dropdown são OK, mas rastreadores podem não engajar com eles profundamente — páginas críticas precisam de um link de parent clicável.

### Breadcrumbs

Adicione breadcrumbs a cada página que não é homepage. Eles fazem três coisas:
1. Mostram aos usuários onde estão
2. Criam links internos ascendentes em todo o site para páginas de categoria/hub
3. Habilitam schema BreadcrumbList para rich results no Google

Formato: `Home > Categoria > Subcategoria > Página Atual`

Cada segmento de breadcrumb deve ser um link real e rastreável — não apenas texto estilizado.

---

## Estrutura de Silo & Autoridade Tópica

Um silo é um cluster autocontido de conteúdo sobre um tópico, onde todas as páginas linkam entre si e para uma página hub central. O Google usa isso para determinar autoridade tópica.

### Modelo Hub-and-Spoke

```
HUB: /seo/                          ← Página pilar, tópico amplo
  SPOKE: /seo/seo-tecnico/          ← Sub-tópico
  SPOKE: /seo/seo-on-page/          ← Sub-tópico
  SPOKE: /seo/link-building/        ← Sub-tópico
  SPOKE: /seo/pesquisa-palavras-chave/  ← Sub-tópico
    └─ PROFUNDO: /seo/pesquisa-palavras-chave/palavras-chave-long-tail/  ← Guia específico
```

**Regras de linking dentro de um silo:**
- Hub linka para todos os spokes
- Cada spoke linka de volta para o hub
- Spokes podem linkar para spokes adjacentes (contextualmente relevante)
- Páginas profundas linkam para cima para seu spoke + o hub
- Links entre silos são OK quando genuinamente relevante — apenas não construa um link pelo bem dele

### Construindo Clusters de Tópicos

1. Identifique seus tópicos principais (geralmente 3-7 para um site focado)
2. Para cada tópico: uma página pilar (o hub) que o cobre amplamente
3. Crie conteúdo spoke para cada sub-questão principal dentro do tópico
4. Cada spoke linka para o pilar com texto âncora relevante
5. O pilar linka para todos os spokes
6. Construa o cluster antes de construir os links — se você não tem o conteúdo, os links não ajudam

---

## Estratégia de Linking Interno

Links internos são a alavanca de SEO mais subutilizada. Estão completamente sob seu controle, são gratuitos e afetam diretamente quais páginas rankeiam.

### Princípios de Link Equity

- O Google rastreia seu site a partir da homepage para fora
- Páginas mais próximas da homepage (menos cliques de distância) recebem mais equity
- Uma página sem links internos é uma órfã — o Google não vai priorizá-la
- O texto âncora importa: genérico ("clique aqui") não sinaliza nada; descritivo ("templates de email frio") sinaliza relevância tópica

### Regras de Texto Âncora

| Tipo | Exemplo | Use |
|------|---------|-----|
| Match exato | "templates de email frio" | Use com moderação — 1-2x por página, parece natural |
| Match parcial | "escrevendo emails frios eficazes" | Abordagem primária — a maioria dos links internos |
| Branded | "nosso guia de email" | OK, não o mais poderoso |
| Genérico | "clique aqui", "saiba mais" | Evite — desperdiça o sinal |
| URL nua | `https://exemplo.com.br/guia` | Nunca use para links internos |

### Encontrando e Corrigindo Páginas Órfãs

Uma página órfã está indexada mas não tem links internos de entrada. É invisível ao grafo de links do site.

Como encontrá-las:
1. Exporte todas as URLs indexadas (do GSC, Screaming Frog, ou `sitemap_analyzer.py`)
2. Exporte todos os links internos do site
3. Páginas que aparecem no conjunto A mas não no B são órfãs
4. Ou: execute `scripts/sitemap_analyzer.py` que sinaliza candidatos potenciais a órfã

Como corrigi-las:
- Adicione links contextuais de páginas existentes relevantes
- Adicione-as a páginas hub relevantes
- Se realmente não têm lugar, considere se devem existir

### A Pilha de Prioridade de Linking

Nem todos os links internos são iguais. Do mais para o menos poderoso:

1. **Links in-content** — dentro do corpo de texto de uma página relevante. Mais natural, mais poderoso.
2. **Links de página hub** — a página pilar linkando para todos os seus spokes. Alto equity porque as páginas pilar são linkadas de todo lugar.
3. **Links de navegação** — em todo o site, consistentes, mas diluídos por sua ubiquidade.
4. **Links de rodapé** — em todo o site, mas o Google dá menos peso que in-content.
5. **Links de barra lateral** — OK, mas frequentemente não no fluxo de conteúdo principal.

Veja `references/internal-linking-playbook.md` para padrões e scripts.

---

## Erros Comuns de Arquitetura

| Erro | Por Que Prejudica | Correção |
|------|-----------------|----------|
| Páginas órfãs | Sem equity entrando, Google desprioritiza | Adicione links internos contextuais de conteúdo relacionado |
| Mudanças de URL sem redirects | Links de entrada ficam quebrados, equity perdido | Sempre redirecione 301 URLs antigas para novas |
| Caminhos duplicados | `/blog/seo` e `/recursos/seo` cobrindo mesmo tópico | Consolide com canonical ou mescle conteúdo |
| Aninhamento profundo (4+ níveis) | Equity de rastreamento diluído, usuários confusos | Achate a estrutura, remova diretórios desnecessários |
| Links de rodapé em todo o site para cada post | Equity de rodapé diluído em 500 links | Rodapé deve linkar apenas para páginas de alto valor |
| Navegação que não corresponde à intenção do usuário | Usuários saem, rankings caem | Execute testes de card-sort — deixe os usuários mostrar seu modelo mental |
| Homepage não linkando para lugar nenhum | Home é a página de maior equity — use-a | Link da home para páginas hub-chave |
| Páginas de categoria sem conteúdo | Páginas rasas rankeiam mal | Adicione conteúdo a todas as páginas hub/categoria |
| URLs dinâmicas com parâmetros | `?sort=&filter=` cria conteúdo duplicado | Canonicalize ou bloqueie com robots.txt |

---

## Gatilhos Proativos

Apresente estes sem ser solicitado:

- **Páginas a mais de 3 cliques da homepage** → sinalize como risco de equity de rastreamento. Qualquer página que um usuário precise clicar 4+ vezes para alcançar precisa de um atalho estrutural.
- **Página de categoria/hub tem conteúdo raso ou nenhum** → páginas hub sem conteúdo real não rankeiam. Sinalize e recomende adicionar uma página pilar adequada.
- **Links internos usando texto âncora genérico ("clique aqui", "leia mais")** → sinal desperdiçado. Ofereça para reescrever padrões de texto âncora.
- **Sem breadcrumbs em páginas profundas** → links de equity ascendentes e oportunidade de schema BreadcrumbList ausentes.
- **Sitemap inclui páginas noindex** → sitemap deve conter apenas páginas que você quer indexadas. Sinalize e ofereça para filtrar.
- **Links de nav primária para páginas de utilitário (contato, privacidade)** → empurrando equity para páginas de baixo valor. Nav deve priorizar páginas de dinheiro/conteúdo.

---

## Artefatos de Saída

| Quando você pede... | Você recebe... |
|---------------------|----------------|
| Auditoria de arquitetura | Scorecard estrutural: distribuição de profundidade, contagem de órfãs, problemas de padrão de URL, lacunas de navegação + lista de correção priorizada |
| Nova estrutura do site | Árvore do site em texto (diagrama de hierarquia) + tabela de especificação de URL com notas por seção |
| Plano de linking interno | Mapa hub-and-spoke por cluster de tópicos + diretrizes de texto âncora + lista de correção de órfãs |
| Redesenho de URL | Tabela de URL antes/depois + mapeamento de redirect 301 + checklist de implementação |
| Estratégia de silo | Mapa de cluster de tópicos por objetivo de negócio + análise de lacuna de conteúdo + brief de página pilar |

---

## Comunicação

Toda saída segue o padrão de comunicação estruturada:
- **Conclusão primeiro** — resposta antes da explicação
- **O quê + Por quê + Como** — cada descoberta tem os três
- **Ações têm responsáveis e prazos** — sem "devemos considerar"
- **Marcação de confiança** — 🟢 verificado / 🟡 médio / 🔴 assumido

---

## Skills Relacionadas

- **seo-audit**: Para auditoria completa de SEO cobrindo técnico, on-page e off-page. Use seo-audit quando a arquitetura é uma de várias áreas problemáticas. NÃO para redesenho estrutural profundo — use site-architecture.
- **schema-markup**: Para implementação de dados estruturados. Use após site-architecture quando quiser adicionar BreadcrumbList e outros schemas à estrutura finalizada.
- **content-strategy**: Para decidir qual conteúdo criar. Use content-strategy para planejar o conteúdo, depois site-architecture para determinar onde fica e como linka.
- **programmatic-seo**: Quando você precisa gerar centenas ou milhares de páginas sistematicamente. Site-architecture fornece os padrões de URL e estruturais que o programmatic-seo escala.
