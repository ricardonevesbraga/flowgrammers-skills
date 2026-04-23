---
name: "ui-design-system"
description: Kit de ferramentas de sistema de UI design para Designer UI Sênior incluindo geração de design tokens, documentação de componentes, cálculos de design responsivo e ferramentas de handoff para desenvolvedores. Use para criar sistemas de design, manter consistência visual e facilitar a colaboração design-dev.
agents:
  - claude-code
---

# Sistema de UI Design

Gerar design tokens, criar paletas de cores, calcular escalas tipográficas, construir sistemas de componentes e preparar documentação de handoff para desenvolvedores.

---

## Sumário

- [Termos de Gatilho](#termos-de-gatilho)
- [Fluxos de Trabalho](#fluxos-de-trabalho)
  - [Fluxo de Trabalho 1: Gerar Design Tokens](#fluxo-de-trabalho-1-gerar-design-tokens)
  - [Fluxo de Trabalho 2: Criar Sistema de Componentes](#fluxo-de-trabalho-2-criar-sistema-de-componentes)
  - [Fluxo de Trabalho 3: Design Responsivo](#fluxo-de-trabalho-3-design-responsivo)
  - [Fluxo de Trabalho 4: Handoff para Desenvolvedores](#fluxo-de-trabalho-4-handoff-para-desenvolvedores)
- [Referência de Ferramentas](#referência-de-ferramentas)
- [Tabelas de Referência Rápida](#tabelas-de-referência-rápida)
- [Base de Conhecimento](#base-de-conhecimento)

---

## Termos de Gatilho

Use esta skill quando precisar:

- "gerar design tokens"
- "criar paleta de cores"
- "construir escala tipográfica"
- "calcular sistema de espaçamento"
- "criar sistema de design"
- "gerar variáveis CSS"
- "exportar tokens SCSS"
- "configurar arquitetura de componentes"
- "documentar biblioteca de componentes"
- "calcular breakpoints responsivos"
- "preparar handoff para desenvolvedores"
- "converter cor da marca em paleta"
- "verificar contraste WCAG"
- "construir sistema de grid 8pt"

---

## Fluxos de Trabalho

### Fluxo de Trabalho 1: Gerar Design Tokens

**Situação:** Você tem uma cor de marca e precisa de um sistema completo de design tokens.

**Etapas:**

1. **Identificar cor da marca e estilo**
   - Cor primária da marca (formato hex)
   - Preferência de estilo: `modern` | `classic` | `playful`

2. **Gerar tokens usando o script**
   ```bash
   python scripts/design_token_generator.py "#0066CC" modern json
   ```

3. **Revisar categorias geradas**
   - Cores: primária, secundária, neutra, semântica, superfície
   - Tipografia: fontFamily, fontSize, fontWeight, lineHeight
   - Espaçamento: escala baseada em grid 8pt (0-64)
   - Bordas: radius, width
   - Sombras: none até 2xl
   - Animação: duration, easing
   - Breakpoints: xs até 2xl

4. **Exportar no formato alvo**
   ```bash
   # Propriedades customizadas CSS
   python scripts/design_token_generator.py "#0066CC" modern css > design-tokens.css

   # Variáveis SCSS
   python scripts/design_token_generator.py "#0066CC" modern scss > _design-tokens.scss

   # JSON para Figma/ferramentas
   python scripts/design_token_generator.py "#0066CC" modern json > design-tokens.json
   ```

5. **Validar acessibilidade**
   - Verificar se o contraste de cores atende WCAG AA (4.5:1 texto normal, 3:1 texto grande)
   - Verificar se cores semânticas têm cores de contraste definidas

---

### Fluxo de Trabalho 2: Criar Sistema de Componentes

**Situação:** Você precisa estruturar uma biblioteca de componentes usando design tokens.

**Etapas:**

1. **Definir hierarquia de componentes**
   - Átomos: Button, Input, Icon, Label, Badge
   - Moléculas: FormField, SearchBar, Card, ListItem
   - Organismos: Header, Footer, DataTable, Modal
   - Templates: DashboardLayout, AuthLayout

2. **Mapear tokens para componentes**

   | Componente | Tokens Usados |
   |------------|---------------|
   | Button | colors, sizing, borders, shadows, typography |
   | Input | colors, sizing, borders, spacing |
   | Card | colors, borders, shadows, spacing |
   | Modal | colors, shadows, spacing, z-index, animation |

3. **Definir padrões de variante**

   Variantes de tamanho:
   ```
   sm: height 32px, paddingX 12px, fontSize 14px
   md: height 40px, paddingX 16px, fontSize 16px
   lg: height 48px, paddingX 20px, fontSize 18px
   ```

   Variantes de cor:
   ```
   primary: background primary-500, text white
   secondary: background neutral-100, text neutral-900
   ghost: background transparent, text neutral-700
   ```

4. **Documentar API de componente**
   - Interface de props com tipos
   - Opções de variante
   - Tratamento de estado (hover, active, focus, disabled)
   - Requisitos de acessibilidade

5. **Referência:** Veja `references/component-architecture.md`

---

### Fluxo de Trabalho 3: Design Responsivo

**Situação:** Você precisa de breakpoints, tipografia fluida ou espaçamento responsivo.

**Etapas:**

1. **Definir breakpoints**

   | Nome | Largura | Meta |
   |------|---------|------|
   | xs | 0 | Celulares pequenos |
   | sm | 480px | Celulares grandes |
   | md | 640px | Tablets |
   | lg | 768px | Laptops pequenos |
   | xl | 1024px | Desktops |
   | 2xl | 1280px | Telas grandes |

2. **Calcular tipografia fluida**

   Fórmula: `clamp(min, preferred, max)`

   ```css
   /* 16px a 24px entre viewport de 320px e 1200px */
   font-size: clamp(1rem, 0.5rem + 2vw, 1.5rem);
   ```

   Escalas pré-calculadas:
   ```css
   --fluid-h1: clamp(2rem, 1rem + 3.6vw, 4rem);
   --fluid-h2: clamp(1.75rem, 1rem + 2.3vw, 3rem);
   --fluid-h3: clamp(1.5rem, 1rem + 1.4vw, 2.25rem);
   --fluid-body: clamp(1rem, 0.95rem + 0.2vw, 1.125rem);
   ```

3. **Configurar espaçamento responsivo**

   | Token | Mobile | Tablet | Desktop |
   |-------|--------|--------|---------|
   | --space-md | 12px | 16px | 16px |
   | --space-lg | 16px | 24px | 32px |
   | --space-xl | 24px | 32px | 48px |
   | --space-section | 48px | 80px | 120px |

4. **Referência:** Veja `references/responsive-calculations.md`

---

### Fluxo de Trabalho 4: Handoff para Desenvolvedores

**Situação:** Você precisa transferir design tokens para a equipe de desenvolvimento.

**Etapas:**

1. **Exportar tokens nos formatos necessários**
   ```bash
   # Para projetos CSS
   python scripts/design_token_generator.py "#0066CC" modern css

   # Para projetos SCSS
   python scripts/design_token_generator.py "#0066CC" modern scss

   # Para JavaScript/TypeScript
   python scripts/design_token_generator.py "#0066CC" modern json
   ```

2. **Preparar integração com framework**

   **React + Variáveis CSS:**
   ```tsx
   import './design-tokens.css';

   <button className="btn btn-primary">Click</button>
   ```

   **Config Tailwind:**
   ```javascript
   const tokens = require('./design-tokens.json');

   module.exports = {
     theme: {
       colors: tokens.colors,
       fontFamily: tokens.typography.fontFamily
     }
   };
   ```

   **styled-components:**
   ```typescript
   import tokens from './design-tokens.json';

   const Button = styled.button`
     background: ${tokens.colors.primary['500']};
     padding: ${tokens.spacing['2']} ${tokens.spacing['4']};
   `;
   ```

3. **Sincronizar com Figma**
   - Instalar plugin Tokens Studio
   - Importar design-tokens.json
   - Tokens sincronizam automaticamente com estilos do Figma

4. **Lista de verificação de handoff**
   - [ ] Arquivos de token adicionados ao projeto
   - [ ] Pipeline de build configurado
   - [ ] Tema/variáveis CSS importadas
   - [ ] Biblioteca de componentes alinhada
   - [ ] Documentação gerada

5. **Referência:** Veja `references/developer-handoff.md`

---

## Referência de Ferramentas

### design_token_generator.py

Gera sistema completo de design tokens a partir da cor da marca.

| Argumento | Valores | Padrão | Descrição |
|-----------|---------|--------|-----------|
| brand_color | Cor Hex | #0066CC | Cor primária da marca |
| style | modern, classic, playful | modern | Preset de estilo de design |
| format | json, css, scss, summary | json | Formato de saída |

**Exemplos:**

```bash
# Gerar tokens JSON (padrão)
python scripts/design_token_generator.py "#0066CC"

# Estilo classic com saída CSS
python scripts/design_token_generator.py "#8B4513" classic css

# Resumo de estilo playful
python scripts/design_token_generator.py "#FF6B6B" playful summary
```

**Categorias de Saída:**

| Categoria | Descrição | Valores Principais |
|-----------|-----------|-------------------|
| colors | Paletas de cores | primary, secondary, neutral, semantic, surface |
| typography | Sistema de fontes | fontFamily, fontSize, fontWeight, lineHeight |
| spacing | Grid 8pt | escala 0-64, semântico (xs-3xl) |
| sizing | Tamanhos de componentes | container, button, input, icon |
| borders | Valores de borda | radius (por estilo), width |
| shadows | Estilos de sombra | none até 2xl, inner |
| animation | Tokens de movimento | duration, easing, keyframes |
| breakpoints | Responsivo | xs, sm, md, lg, xl, 2xl |
| z-index | Sistema de camadas | base até notification |

---

## Tabelas de Referência Rápida

### Geração de Escala de Cores

| Step | Brilho | Saturação | Caso de Uso |
|------|--------|-----------|-------------|
| 50 | 95% fixo | 30% | Fundos sutis |
| 100 | 95% fixo | 38% | Fundos claros |
| 200 | 95% fixo | 46% | Estados hover |
| 300 | 95% fixo | 54% | Bordas |
| 400 | 95% fixo | 62% | Estados desabilitados |
| 500 | Original | 70% | Cor base/padrão |
| 600 | Original × 0.8 | 78% | Hover (escuro) |
| 700 | Original × 0.6 | 86% | Estados ativos |
| 800 | Original × 0.4 | 94% | Texto |
| 900 | Original × 0.2 | 100% | Títulos |

### Escala Tipográfica (Razão 1.25x)

| Tamanho | Valor | Cálculo |
|---------|-------|---------|
| xs | 10px | 16 ÷ 1.25² |
| sm | 13px | 16 ÷ 1.25¹ |
| base | 16px | Base |
| lg | 20px | 16 × 1.25¹ |
| xl | 25px | 16 × 1.25² |
| 2xl | 31px | 16 × 1.25³ |
| 3xl | 39px | 16 × 1.25⁴ |
| 4xl | 49px | 16 × 1.25⁵ |
| 5xl | 61px | 16 × 1.25⁶ |

### Requisitos de Contraste WCAG

| Nível | Texto Normal | Texto Grande |
|-------|-------------|--------------|
| AA | 4.5:1 | 3:1 |
| AAA | 7:1 | 4.5:1 |

Texto grande: ≥18pt regular ou ≥14pt negrito

### Presets de Estilo

| Aspecto | Modern | Classic | Playful |
|---------|--------|---------|---------|
| Fonte Sans | Inter | Helvetica | Poppins |
| Fonte Mono | Fira Code | Courier | Source Code Pro |
| Radius Padrão | 8px | 4px | 16px |
| Sombras | Camadas, sutis | Camada única | Suaves, pronunciadas |

---

## Base de Conhecimento

Guias de referência detalhados em `references/`:

| Arquivo | Conteúdo |
|---------|----------|
| `token-generation.md` | Algoritmos de cor, espaço HSV, contraste WCAG, escalas de tipo |
| `component-architecture.md` | Design atômico, convenções de nomenclatura, padrões de props |
| `responsive-calculations.md` | Breakpoints, tipografia fluida, sistemas de grid |
| `developer-handoff.md` | Formatos de exportação, configuração de framework, sincronização com Figma |

---

## Lista de Verificação de Validação

### Geração de Tokens
- [ ] Cor da marca fornecida em formato hex
- [ ] Estilo corresponde aos requisitos do projeto
- [ ] Todas as categorias de token geradas
- [ ] Cores semânticas incluem valores de contraste

### Sistema de Componentes
- [ ] Todos os tamanhos implementados (sm, md, lg)
- [ ] Todas as variantes implementadas (primary, secondary, ghost)
- [ ] Todos os estados funcionando (hover, active, focus, disabled)
- [ ] Usa apenas design tokens (sem valores hardcoded)

### Acessibilidade
- [ ] Contraste de cores atende WCAG AA
- [ ] Indicadores de foco visíveis
- [ ] Alvos de toque ≥ 44×44px
- [ ] Elementos HTML semânticos usados

### Handoff para Desenvolvedores
- [ ] Tokens exportados no formato necessário
- [ ] Integração com framework documentada
- [ ] Ferramenta de design sincronizada
- [ ] Documentação de componentes completa
