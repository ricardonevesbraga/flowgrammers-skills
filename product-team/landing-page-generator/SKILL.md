---
name: "landing-page-generator"
description: "Gera landing pages de alta conversão como componentes Next.js/React (TSX) completos com Tailwind CSS. Cria seções hero, grids de funcionalidades, tabelas de preços, accordions de FAQ, blocos de depoimentos e seções CTA usando frameworks de copy comprovados (PAS, AIDA, BAB). Produz meta tags SEO, dados estruturados e código otimizado para desempenho visando Core Web Vitals (LCP < 1s, CLS < 0.1). Use quando o usuário pede para criar uma landing page, página de marketing, homepage, site de página única, página de captura de leads, página de campanha, página de promoção ou página web otimizada para conversão — ou quando quer testar variantes de landing page A/B ou substituir uma página estática por uma projetada para converter."
agents:
  - claude-code
---

# Gerador de Landing Page

Gerar landing pages de alta conversão a partir de uma descrição de produto. Produzir componentes Next.js/React completos com múltiplas variantes de seção, frameworks de copy comprovados, otimização de SEO e padrões de desempenho em primeiro lugar. Não lorem ipsum — copy real que converte.

**Meta:** LCP < 1s · CLS < 0.1 · FID < 100ms  
**Saída:** Componentes TSX + estilos Tailwind + meta SEO + variantes de copy

---

## Capacidades Principais

- 5 variantes de seção hero (centrado, dividido, gradiente, vídeo de fundo, minimalista)
- Seções de funcionalidades (grid, alternado, cards com ícones)
- Tabelas de preços (2-4 tiers com listas de funcionalidades e toggle)
- FAQ accordion com schema markup
- Depoimentos (grid, carrossel, citação única)
- Seções CTA (banner, página completa, inline)
- Rodapé (simples, mega, minimalista)
- 4 estilos de design com conjuntos de classes Tailwind

---

## Fluxo de Trabalho de Geração

Siga estas etapas em ordem para cada solicitação de landing page:

1. **Coletar inputs** — colete nome do produto, tagline, audiência, ponto de dor, benefício principal, tiers de preço, estilo de design e framework de copy usando o formato de gatilho abaixo. Pergunte apenas pelos campos ausentes.
2. **Analisar voz da marca** (recomendado) — se o usuário tiver conteúdo de marca existente (copy do website, posts de blog, materiais de marketing), execute-o pelo `marketing-skill/content-production/scripts/brand_voice_analyzer.py` para obter um perfil de voz (formalidade, tom, perspectiva). Use o perfil para informar a seleção de estilo de design e framework de copy:
   - formal + profissional → estilo **enterprise**, framework **AIDA**
   - casual + amigável → estilo **bold-startup**, framework **BAB**
   - profissional + autoritário → estilo **dark-saas**, framework **PAS**
   - casual + conversacional → estilo **clean-minimal**, framework **BAB**
3. **Selecionar estilo de design** — mapeie a escolha do usuário (ou infira da análise de voz da marca) para um dos quatro conjuntos de classes Tailwind na Referência de Estilo de Design.
4. **Aplicar framework de copy** — escreva todo o copy de headline e corpo usando o framework escolhido (PAS / AIDA / BAB) antes de gerar componentes. Corresponda a formalidade e tom do perfil de voz ao longo.
5. **Gerar seções em ordem** — Hero → Funcionalidades → Preços → FAQ → Depoimentos → CTA → Rodapé. Pule seções não relevantes para o produto.
6. **Validar conforme a lista de verificação de SEO** — passe por cada item da Lista de Verificação de SEO antes de produzir o código final. Corrija quaisquer lacunas inline.
7. **Produzir componentes finais** — entregue arquivos TSX completos e prontos para copiar e colar com todas as classes Tailwind, meta SEO e dados estruturados incluídos.

---

## Acionando Esta Skill

```
Product: [nome]
Tagline: [proposta de valor em uma frase]
Target audience: [quem são eles]
Key pain point: [qual problema você resolve]
Key benefit: [resultado principal]
Pricing tiers: [free/pro/enterprise ou descreva]
Design style: dark-saas | clean-minimal | bold-startup | enterprise
Copy framework: PAS | AIDA | BAB
```

---

## Referência de Estilo de Design

| Estilo | Fundo | Destaque | Cards | Botão CTA |
|--------|-------|----------|-------|-----------|
| **Dark SaaS** | `bg-gray-950 text-white` | `violet-500/400` | `bg-gray-900 border border-gray-800` | `bg-violet-600 hover:bg-violet-500` |
| **Clean Minimal** | `bg-white text-gray-900` | `blue-600` | `bg-gray-50 border border-gray-200 rounded-2xl` | `bg-blue-600 hover:bg-blue-700` |
| **Bold Startup** | `bg-white text-gray-900` | `orange-500` | `shadow-xl rounded-3xl` | `bg-orange-500 hover:bg-orange-600 text-white` |
| **Enterprise** | `bg-slate-50 text-slate-900` | `slate-700` | `bg-white border border-slate-200 shadow-sm` | `bg-slate-900 hover:bg-slate-800 text-white` |

> Títulos **Bold Startup**: adicione `font-black tracking-tight` a todos os elementos `<h1>`/`<h2>`.

---

## Frameworks de Copy

**PAS (Problema → Agravar → Solução)**
- H1: Estado doloroso em que estão
- Sub: O que acontece se não corrigirem
- CTA: O que você oferece
- *Exemplo — H1:* "Sua equipe desperdiça 3 horas por dia em relatórios manuais" / *Sub:* "Cada hora gasta em planilhas é uma hora a menos fechando negócios. Seus concorrentes já estão automatizados." / *CTA:* "Automatize seus relatórios em 10 minutos →"

**AIDA (Atenção → Interesse → Desejo → Ação)**
- H1: Declaração bold que chama atenção → Sub: Fato ou benefício interessante → Funcionalidades: Pontos de prova que constroem desejo → CTA: Ação clara

**BAB (Antes → Depois → Ponte)**
- H1: "[Estado Antes] → [Estado Depois]" → Sub: "Veja como [produto] cria a ponte" → Funcionalidades: Como funciona (a ponte)

---

## Componente Representativo: Hero (Gradiente Centralizado — Dark SaaS)

Use isto como template estrutural para todas as variantes de hero. Troque as classes de layout, direção do gradiente e posição da imagem para variantes divididas, vídeo de fundo e minimalistas.

```tsx
export function HeroCentered() {
  return (
    <section className="relative flex min-h-screen flex-col items-center justify-center overflow-hidden bg-gray-950 px-4 text-center">
      <div className="absolute inset-0 bg-gradient-to-b from-violet-900/20 to-transparent" />
      <div className="pointer-events-none absolute -top-40 left-1/2 h-[600px] w-[600px] -translate-x-1/2 rounded-full bg-violet-600/20 blur-3xl" />
      <div className="relative z-10 max-w-4xl">
        <div className="mb-6 inline-flex items-center gap-2 rounded-full border border-violet-500/30 bg-violet-500/10 px-4 py-1.5 text-sm text-violet-300">
          <span className="h-1.5 w-1.5 rounded-full bg-violet-400" />
          Now in public beta
        </div>
        <h1 className="mb-6 text-5xl font-bold tracking-tight text-white md:text-7xl">
          Ship faster.
          <span className="bg-gradient-to-r from-violet-400 to-pink-400 bg-clip-text text-transparent">
            Break less.
          </span>
        </h1>
        <p className="mx-auto mb-10 max-w-2xl text-xl text-gray-400">
          The deployment platform that catches errors before your users do.
          Zero config. Instant rollbacks. Real-time monitoring.
        </p>
        <div className="flex flex-col items-center gap-4 sm:flex-row sm:justify-center">
          <Button size="lg" className="bg-violet-600 text-white hover:bg-violet-500 px-8">
            Start free trial
          </Button>
          <Button size="lg" variant="outline" className="border-gray-700 text-gray-300">
            See how it works
          </Button>
        </div>
        <p className="mt-4 text-sm text-gray-500">No credit card required · 14-day free trial</p>
      </div>
    </section>
  )
}
```

---

## Outros Padrões de Seção

### Seção de Funcionalidades (Alternado)

Mapear sobre um array `features` com `{ title, description, image, badge }`. Alternar direção do layout com `i % 2 === 1 ? "lg:flex-row-reverse" : ""`. Usar `<Image>` com `width`/`height` explícitos e `rounded-2xl shadow-xl`. Envolver em `<section className="py-24">` com container `max-w-6xl`.

### Tabela de Preços

Mapear sobre um array `plans` com `{ name, price, description, features[], cta, highlighted }`. Plano destacado recebe `border-2 border-violet-500 bg-violet-950/50 ring-4 ring-violet-500/20`; outros recebem `border border-gray-800 bg-gray-900`. Renderizar preço `null` como "Personalizado". Usar ícone `<Check>` por linha de funcionalidade. Layout: `grid gap-8 lg:grid-cols-3`.

### FAQ com Schema Markup

Injetar JSON-LD `FAQPage` via script tag com `type="application/ld+json"` dentro da seção. Sempre sanitize o conteúdo antes de renderizá-lo para evitar vulnerabilidades XSS. Mapear FAQs com `{ q, a }` no `<Accordion>` do shadcn com `type="single" collapsible`. Container: `max-w-3xl`.

### Depoimentos, CTA, Rodapé

- **Depoimentos:** Grid (`grid-cols-1 md:grid-cols-3`) ou bloco de citação hero único com avatar, nome, cargo e texto da citação.
- **Banner CTA:** Seção de largura total com headline, subtítulo e dois botões (primário + ghost). Adicionar sinais de confiança (garantia de devolução do dinheiro, tira de logos) imediatamente abaixo.
- **Rodapé:** Logo + colunas de navegação + links sociais + informações legais. Usar separador `border-t border-gray-800`.

---

## Lista de Verificação de SEO

- [ ] Tag `<title>`: palavra-chave principal + marca (50-60 chars)
- [ ] Meta description: benefício + CTA (150-160 chars)
- [ ] OG image: 1200×630px com nome do produto e tagline
- [ ] H1: um por página, inclui palavra-chave principal
- [ ] Dados estruturados: schema FAQPage, Product ou Organization
- [ ] URL canônica definida
- [ ] Texto alternativo de imagem em todos os componentes `<Image>`
- [ ] robots.txt e sitemap.xml configurados
- [ ] Core Web Vitals: LCP < 1s, CLS < 0.1
- [ ] Meta tag de viewport mobile presente
- [ ] Links internos para preços e docs

> **Etapa de validação:** Antes de produzir o código final, verifique se cada item da lista de verificação acima está satisfeito. Corrija quaisquer lacunas inline — não pule itens.

---

## Metas de Desempenho

| Métrica | Meta | Técnica |
|---------|------|---------|
| LCP | < 1s | Pré-carregar imagem hero, usar `priority` em Next/Image |
| CLS | < 0.1 | Definir width/height explícitos em todas as imagens |
| FID/INP | < 100ms | Adiar JS não crítico, usar `loading="lazy"` |
| TTFB | < 200ms | Usar ISR ou geração estática para landing pages |
| Bundle | < 100KB JS | Auditar com `@next/bundle-analyzer` |

---

## Armadilhas Comuns

- Imagem hero não pré-carregada — adicionar prop `priority` ao primeiro `<Image>`
- Breakpoints mobile ausentes — sempre design mobile-first com prefixos `sm:`
- Copy de CTA muito vaga — "Começar" é melhor que "Saiba mais"; "Iniciar teste gratuito" é melhor que "Cadastre-se"
- Página de preços sem sinais de confiança — adicionar garantia de devolução e depoimentos próximos ao CTA
- Sem CTA acima da dobra no mobile — garantir que o botão seja visível sem rolar em viewport de 375px

---

## Skills Relacionadas

- **Analisador de Voz da Marca** (`marketing-skill/content-production/scripts/brand_voice_analyzer.py`) — Executar antes da geração para estabelecer perfil de voz e garantir consistência do copy
- **Sistema de UI Design** (`product-team/ui-design-system/`) — Gerar design tokens da cor da marca antes de construir a página
- **Análise Competitiva** (`product-team/competitive-teardown/`) — Posicionamento competitivo informa a mensagem da landing page e a diferenciação
