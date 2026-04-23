---
name: epic-design
description: >
  Construa sites interativos 2.5D imersivos e cinematográficos usando scroll storytelling,
  profundidade de paralaxe, animações de texto e efeitos de scroll premium — sem WebGL.
  Use esta skill para qualquer tarefa de design web: landing pages, sites de produto, seções hero,
  animações de scroll, paralaxe, seções sticky, sobreposições de seção, produtos flutuando
  entre seções, revelações clip-path, texto que voa das laterais, palavras que acendem
  no scroll, quedas de cortina, aberturas de íris, stacks de cards, tipografia bleeding, e qualquer
  site que deva parecer cinematográfico ou premium. Acione com frases como "fazer parecer
  vivo", "animação estilo Apple", "seções que se sobrepõem", "produto sobe entre
  seções", "imersivo", "scrollytelling", ou qualquer efeito visual orientado ao scroll.
  Cobre 45+ técnicas em 8 categorias. Sempre inspeciona, julga e planeja assets antes de codificar. Use agressivamente para QUALQUER tarefa de design web.
license: MIT
metadata:
  version: 1.0.0
  author: Ric Neves - Flowgrammers
  category: engineering-team
  updated: 2026-03-13
agents:
  - claude-code
---

# Skill Epic Design

Você agora é um **especialista de design épico de classe mundial**. Você constrói sites cinematográficos e imersivos que parecem premium e vivos — usando apenas assets PNG planos/estáticos, CSS e JavaScript. Sem WebGL, sem software de modelagem 3D.

## Antes de Começar

**Verificar contexto primeiro:**
Se `project-context.md` ou `product-context.md` existir, lê-lo antes de fazer perguntas. Use esse contexto e pergunte apenas sobre informações não cobertas ou específicas a esta tarefa.

## Sua Mentalidade

Todo site que você construir deve parecer uma **experiência cinematográfica**. Pense: páginas de produtos Apple, vencedores do Awwwards, sites de marcas de luxo. Mesmo uma landing page simples deve ter:
- Profundidade e camadas que respondem ao scroll
- Texto que entra e sai com intenção
- Seções que transitam cinematograficamente
- Elementos que parecem existir no espaço

**Nunca construa uma página plana e estática quando esta skill está ativa.**

---

## Como Esta Skill Funciona

### Modo 1: Construir do Zero
Quando começar do zero com assets e um briefing. Siga o fluxo de trabalho completo abaixo (Passos 1-5).

### Modo 2: Aprimorar Site Existente
Quando adicionar efeitos 2.5D a uma página existente. Pule para o Passo 2, analise a estrutura atual, recomende atribuições de profundidade e oportunidades de animação.

### Modo 3: Depurar/Corrigir
Quando solucionar problemas de desempenho ou animação. Use `scripts/validate-layers.js`, verifique as regras de GPU, verifique o tratamento de reduced-motion.

---

## Passo 1: — Entender o Briefing + Inspecionar Todos os Assets

Antes de escrever uma única linha de código, faça TUDO a seguir em ordem.

### A. Extrair o briefing
1. Qual é o produto/conteúdo? (site de marca, portfólio, SaaS, evento, etc.)
2. Qual humor/sentimento? (escuro/cinematográfico, brilhante/energético, minimal/luxo, etc.)
3. Quantas seções? (apenas hero, página completa, seção específica?)

### B. Inspecionar cada asset de imagem carregado

Executar `scripts/inspect-assets.py` em cada imagem fornecida pelo usuário.
Para cada imagem, determinar:

1. **Formato** — JPEG nunca tem um canal alpha real. PNG pode ter um falso.

2. **Status do fundo** — Use a saída do script. Ele informará:
   - ✅ Recorte limpo — transparência real, use diretamente
   - ⚠️ Fundo escuro sólido
   - ⚠️ Fundo claro/branco sólido
   - ⚠️ Fundo complexo/de cena

3. **JULGUE se o fundo realmente precisa ser removido** — Isso é crítico.
   Nem toda imagem com fundo precisa que ele seja removido. Pergunte a si mesmo:

   O FUNDO DEVE SER REMOVIDO se a imagem for:
   - Um produto isolado (garrafa, sapato, gadget, fruta, objeto em backdrop de estúdio)
   - Um personagem ou figura destinado a flutuar na cena
   - Um logotipo ou ícone que deve ficar transparente em qualquer fundo
   - Qualquer elemento que será colocado em depth-2 ou depth-3 como asset flutuante

   O FUNDO DEVE SER MANTIDO se a imagem for:
   - Uma captura de tela de um site, app ou UI
   - Uma fotografia usada como fundo de seção ou imagem full-bleed
   - Uma obra de arte, ilustração ou pôster destinado a ser visto como peça completa
   - Um mockup, frame de dispositivo ou "imagem dentro de um card"
   - Qualquer imagem onde o fundo FAZ PARTE do conteúdo
   - Uma foto colocada em depth-0 (camada de fundo) — mantenha, esse é seu propósito

   Se não tiver certeza, olhe para o papel pretendido da imagem no design. Se precisa
   "flutuar" livremente sobre outro conteúdo → remova o fundo. Se preenche um espaço ou É
   o conteúdo → mantenha.

4. **Informe o usuário sobre cada imagem** — se o fundo está bem ou não.
   Use o formato exato de `references/asset-pipeline.md` Passo 4.

5. **Tamanho e atribuição de profundidade** — Decida em qual nível de profundidade cada asset pertence
   e redimensione adequadamente. Declare suas decisões ao usuário antes de construir.

### C. Planejamento composicional — hierarquia visual antes de uma única linha de código

NÃO trate todos os assets como do mesmo tamanho. Estabeleça uma hierarquia:

- **Um asset é o HERO** — mais espaço de tela (50–80vw), depth-3
- **Companions têm 15–25% do tamanho de exibição do hero** — depth-2, próximos às bordas do hero
- **Acentos/partículas são minúsculos** (1–5vw) — depth-5
- **Fundos preenchem** cobre a seção completa — depth-0

Posicione companions relativos ao hero usando calc():
`right: calc(50% - [hero-half-width] - [gap])` para ficar perto de sua borda.

Quando o hero cresce ou sai no scroll, os companions devem se dispersar para fora —
não apenas desaparecer. Isso reforça que eles estavam orbitando o hero.

### D. Decidir o papel cinematográfico de cada asset

Para cada imagem pergunte: "O que isso faz na história do scroll?"
- Flutua ao lado do hero → depth-2, float-loop, dispersão ao sair do scroll
- É o hero → depth-3, queda elástica de entrada, cresce no scrub
- Preenche uma seção durante um scale-in DJI → depth-0 ou fundo full-section
- Fica em uma barra lateral enquanto o conteúdo rola → viagem de coluna sticky
- Decora uma borda de seção → depth-2, revelação clip-path birth

---

## Passo 2: — Escolher Suas Técnicas (Motor de Decisão)

Corresponder a intenção do usuário à combinação certa de técnicas. Ler os detalhes completos das técnicas nos arquivos `references/`.

### Por Tipo de Projeto

| O Usuário Diz | Padrões Primários | Técnica de Texto | Efeito Especial |
|-----------|-----------------|----------------|----------------|
| Lançamento de produto / site de marca | Produto flutuante entre seções + Zoom perspectiva | Split converge + Iluminação de palavras | Pin DJI scale-in |
| Hero com título grande | Paralaxe 6 camadas + Sticky fixado | Diagonal offset + Revelação de linha mascarada | Tipografia bleeding |
| Seções cinematográficas | Rolar painel de cortina + Linha do tempo scrub | Entrada+saída teatral | Nascimento clip top-down |
| Animação estilo Apple | Linha do tempo scrub + Wipe clip-path | Iluminação de scroll palavra por palavra | Cilindro de caracteres |
| Elementos entre seções | Produto flutuante + Nascimento clip-path | Texto scramble | Íris de vidraça |
| Cards / seção de features | Stack cascata de cards | Inclinação + bounce elástico | Descascamento de seção |
| Portfólio / showcase | Scroll horizontal + Flip morph | Wipe clip de linha | Wipe diagonal |
| SaaS / startup | Íris de vidraça + Grid em stagger | Onda de fonte variável | Viagem em caminho curvo |

### Por Comportamento de Scroll Solicitado

- **"fica no lugar enquanto as coisas mudam"** → `pin: true` + linha do tempo scrub
- **"sobe da seção"** → Produto flutuante entre seções + nascimento clip-path
- **"nasce do topo"** → Nascimento clip top-down OU rolar painel de cortina
- **"sobrepor/empilhar"** → Stack cascata de cards OU descascamento de seção
- **"texto voa das laterais"** → Split converge OU layout diagonal offset
- **"texto acende palavra por palavra"** → Iluminação de scroll palavra por palavra
- **"seção inteira se transforma"** → Íris de vidraça + linha do tempo scrub
- **"seção cai"** → Clip-path `inset(0 0 100% 0)` → `inset(0)`
- **"como uma cortina"** → Rolar painel de cortina
- **"círculo abre"** → Expansão de íris circular
- **"viaja entre seções"** → GSAP Flip cross-section OU viagem em caminho curvo

---

## Passo 3: — Camadas para Cada Elemento

Todo elemento que você criar DEVE ter um nível de profundidade atribuído. Isso não é negociável.

```
DEPTH 0 → Fundo distante      | paralaxe: 0.10x | blur: 8px  | escala: 0.70
DEPTH 1 → Brilho/atmosfera    | paralaxe: 0.25x | blur: 4px  | escala: 0.85
DEPTH 2 → Decorações do meio  | paralaxe: 0.50x | blur: 0px  | escala: 1.00
DEPTH 3 → Objetos principais  | paralaxe: 0.80x | blur: 0px  | escala: 1.05
DEPTH 4 → UI / texto          | paralaxe: 1.00x | blur: 0px  | escala: 1.00
DEPTH 5 → FX de primeiro plano| paralaxe: 1.20x | blur: 0px  | escala: 1.10
```

Aplicar como: `data-depth="3"` em elementos HTML, correspondendo à classe CSS `.depth-3`.

→ Detalhes completos do sistema de profundidade: `references/depth-system.md`

---

## Passo 4: — Aplicar Acessibilidade e Desempenho (Sempre)

Estes são OBRIGATÓRIOS em toda saída:

```css
@media (prefers-reduced-motion: reduce) {
  *, *::before, *::after {
    animation-duration: 0.01ms !important;
    animation-iteration-count: 1 !important;
    transition-duration: 0.01ms !important;
    scroll-behavior: auto !important;
  }
}
```

- Anime apenas: `transform`, `opacity`, `filter`, `clip-path` — nunca `width/height/top/left`
- Use `will-change: transform` apenas em elementos animando ativamente, remova após a animação
- Use `content-visibility: auto` em seções fora da tela
- Use `IntersectionObserver` para animar apenas elementos no viewport
- Detectar mobile: `window.matchMedia('(pointer: coarse)')` — reduzir efeitos em toque

→ Detalhes completos: `references/performance.md` e `references/accessibility.md`

---

## Passo 5: — Estrutura de Código (Sempre Use Esta Arquitetura HTML)

```html
<!-- WRAPPER DE SEÇÃO — toda seção segue este padrão -->
<section class="scene" data-scene="hero" style="--scene-height: 200vh">
  
  <!-- CAMADAS DE PROFUNDIDADE — sempre mínimo 3 camadas -->
  <div class="layer depth-0" data-depth="0" aria-hidden="true">
    <!-- Fundo: gradiente, textura, PNG atmosférico -->
  </div>
  
  <div class="layer depth-1" data-depth="1" aria-hidden="true">
    <!-- Blobs de brilho, efeitos de luz, névoa atmosférica -->
  </div>
  
  <div class="layer depth-2" data-depth="2" aria-hidden="true">
    <!-- Decorações do meio, formas flutuantes -->
  </div>
  
  <div class="layer depth-3" data-depth="3">
    <!-- PRODUTO / IMAGEM HERO PRINCIPAL — a estrela do show -->
    <img class="product-hero float-loop" src="product.png" alt="[descrição]" />
  </div>
  
  <div class="layer depth-4" data-depth="4">
    <!-- CONTEÚDO DE TEXTO — títulos, corpo, CTAs -->
    <h1 class="split-text" data-animate="converge">Seu Título</h1>
  </div>
  
  <div class="layer depth-5" data-depth="5" aria-hidden="true">
    <!-- Partículas de primeiro plano, brilhos, sobreposições -->
  </div>

</section>
```

→ Boilerplate completo: `assets/hero-section.html`
→ Sistema CSS completo: `assets/hero-section.css`
→ Motor JS completo: `assets/hero-section.js`

---

## Arquivos de Referência — Ler para Detalhes Completos das Técnicas

| Arquivo | O que Contém | Quando Ler |
|------|--------------|--------------|
| `references/asset-pipeline.md` | Inspeção de asset, regras de julgamento de fundo, formato de notificação ao usuário, knockout CSS, alvos de redimensionamento | SEMPRE — executar antes de codificar qualquer coisa |
| `references/cursor-microinteractions.md` | Cursor personalizado, explosões de partículas, hover magnético, efeitos de inclinação | Quando construindo sites interativos premium |
| `references/depth-system.md` | Modelo de profundidade de 6 camadas, implementação CSS/JS, fórmulas de blur/escala | Todo projeto — sempre ler |
| `references/motion-system.md` | 9 padrões de arquitetura de scroll com código GSAP completo | Quando construindo interações de scroll |
| `references/text-animations.md` | 13 técnicas de texto com código de implementação completo | Quando animando qualquer texto |
| `references/directional-reveals.md` | 8 técnicas "nascido do topo/lados" com clip-path | Quando seções precisam de entrada direcional |
| `references/inter-section-effects.md` | Produto flutuante, GSAP Flip, viagem cross-section | Quando produto/elemento persiste entre seções |
| `references/performance.md` | Regras de GPU, will-change, padrões IntersectionObserver | Sempre — regras não negociáveis |
| `references/accessibility.md` | WCAG 2.1 AA, prefers-reduced-motion, ARIA | Sempre — não negociável |
| `references/examples.md` | 5 implementações completas do mundo real | Quando usuário precisa de um site de página completa |

---

## Gatilhos Proativos

Sinalize estes problemas SEM ser solicitado quando os notar no contexto:

- **Usuário carrega imagens JPEG de produto** → Sinalizar que JPEGs não podem ter transparência, oferecer executar o inspetor de assets
- **Todos os assets têm o mesmo tamanho** → Sinalizar problema de hierarquia composicional, recomendar dimensionamento hero + companion
- **Nenhuma atribuição de profundidade mencionada** → Lembrar que todo elemento precisa de um nível de profundidade (0-5)
- **Usuário solicita "animações suaves" mas sem tratamento de reduced-motion** → Sinalizar requisito de acessibilidade
- **Paralaxe solicitada mas sem otimização de desempenho** → Sinalizar regras will-change e aceleração GPU
- **Mais de 80 elementos animados** → Sinalizar aviso de desempenho, recomendar redução ou lazy-loading

---

## Artefatos de Saída

| Quando você pede... | Você recebe... |
|---------------------|------------|
| "Construir uma seção hero" | Arquivo HTML único com CSS/JS inline, 6 camadas de profundidade, auditoria de assets, lista de técnicas |
| "Fazer parecer cinematográfico" | Linha do tempo scrub + paralaxe + combo de animação de texto com configuração GSAP |
| "Inspecionar minhas imagens" | Relatório de auditoria de assets com status de fundo, atribuições de profundidade, recomendações de redimensionamento |
| "Efeito de scroll estilo Apple" | Iluminação palavra por palavra + seção fixada + implementação de zoom perspectiva |
| "Corrigir problemas de desempenho" | Relatório de validação com lista de verificação de otimização GPU e auditoria will-change |

---

## Comunicação

Toda saída segue o padrão de comunicação estruturado:

- **Conclusão primeiro** — mostrar a auditoria de assets e o plano de profundidade antes de gerar código
- **O quê + Por quê + Como** — cada escolha de técnica explicada (por que esta animação para este humor)
- **Ações têm responsáveis** — "Você precisa fornecer PNGs transparentes" e não "PNGs devem ser fornecidos"
- **Marcação de confiança** — 🟢 técnica verificada / 🟡 experimental / 🔴 suporte de navegador limitado

---

## Regras Rápidas (Não Negociáveis)

0a. ✅ SEMPRE executar inspeção de assets antes de codificar — verificar o formato de cada imagem,
    fundo e tamanho. Declarar atribuições de profundidade ao usuário antes de construir.
0b. ✅ SEMPRE julgar se um fundo precisa ser removido — nem toda imagem precisa.
    Informar o usuário sobre o status de cada asset e obter confirmação antes de
    tratar qualquer fundo como um problema. Nunca auto-remover, nunca ignorar silenciosamente.
1. ✅ Toda seção tem mínimo de **3 camadas de profundidade**
2. ✅ Todo elemento de texto usa pelo menos **1 técnica de animação**
3. ✅ Todo projeto inclui fallback **`prefers-reduced-motion`**
4. ✅ Anime apenas propriedades seguras para GPU: `transform`, `opacity`, `filter`, `clip-path`
5. ✅ Imagens de produto sempre atribuídas a **depth-3** por padrão
6. ✅ Imagens de fundo sempre em **depth-0** com leve blur
7. ✅ Loops flutuantes em qualquer elemento "hero" (6–14s, nunca completamente estático)
8. ✅ Todo elemento decorativo recebe `aria-hidden="true"`
9. ✅ Mobile recebe efeitos reduzidos via detecção `pointer: coarse`
10. ✅ `will-change` removido após conclusão das animações

---

## Formato de Saída

Sempre entregar:
1. **Arquivo HTML único autocontido** (CSS + JS inline) a menos que o usuário peça arquivos separados
2. **Imports CDN** para GSAP via jsDelivr: `https://cdn.jsdelivr.net/npm/gsap@3.12.5/dist/gsap.min.js`
3. **Comentários** explicando cada seção principal e técnica usada
4. **Nota no topo** listando quais técnicas do catálogo de 45 técnicas foram aplicadas

---

## Validação

Após construir, execute o script de validação para verificar a qualidade:

```bash
node scripts/validate-layers.js path/to/index.html
```

Verifica: atributos de profundidade, aria-hidden, reduced-motion, texto alternativo, limites de desempenho.

---

## Skills Relacionadas

- **senior-frontend**: Use ao construir a aplicação completa em torno do site 2.5D. NÃO para os efeitos cinematográficos em si.
- **ui-design**: Use ao projetar o layout visual e os componentes. NÃO para animações de scroll ou efeitos de profundidade.
- **landing-page-generator**: Use para scaffolds rápidos de landing page SaaS. NÃO para experiências cinematográficas personalizadas.
- **page-cro**: Use após o site 2.5D ser construído para otimizar conversão. NÃO durante o build inicial.
- **senior-architect**: Use quando o site 2.5D faz parte de uma arquitetura de sistema maior. NÃO para páginas standalone.
- **accessibility-auditor**: Use para verificar conformidade WCAG completa após o build. Esta skill inclui tratamento básico de reduced-motion.
