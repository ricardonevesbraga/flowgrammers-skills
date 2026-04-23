---
name: "a11y-audit"
description: "Skill de auditoria de acessibilidade para escanear, corrigir e verificar a conformidade WCAG 2.2 Nível A e AA em codebases React, Next.js, Vue, Angular, Svelte e HTML puro. Use ao auditar acessibilidade, corrigir violações de a11y, verificar contraste de cores, gerar relatórios de conformidade ou integrar verificações de acessibilidade em pipelines CI/CD."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Auditoria de Acessibilidade

Skill de Auditoria e Remediação de Acessibilidade WCAG 2.2

## Descrição

A skill a11y-audit fornece um pipeline completo de auditoria de acessibilidade para aplicações web modernas. Implementa um fluxo de trabalho em três fases — Escanear, Corrigir, Verificar — que identifica violações WCAG 2.2 Nível A e AA, gera código de correção preciso por framework e produz relatórios de conformidade prontos para partes interessadas.

Para cada violação encontrada, fornece o código de correção preciso antes/depois, adaptado ao seu framework (React, Next.js, Vue, Angular, Svelte ou HTML puro).

**O que esta skill faz:**

1. **Escaneia** seu codebase em busca de todas as violações WCAG 2.2 Nível A e AA, categorizadas por severidade (Crítica, Maior, Menor)
2. **Corrige** cada violação com padrões de código antes/depois específicos para o framework
3. **Verifica** que as correções resolvem as violações originais e não introduzem regressões
4. **Reporta** os resultados em formato estruturado adequado para desenvolvedores, PMs e partes interessadas em conformidade
5. **Integra** em pipelines CI/CD para prevenir regressões de acessibilidade

## Funcionalidades

| Funcionalidade | Descrição |
|---------|-------------|
| **Escaneamento WCAG 2.2 Completo** | Verifica todos os critérios de sucesso Nível A e AA em seu codebase |
| **Detecção de Framework** | Detecta automaticamente React, Next.js, Vue, Angular, Svelte ou HTML puro |
| **Classificação de Severidade** | Categoriza cada violação como Crítica, Maior ou Menor |
| **Geração de Código de Correção** | Produz diffs de código antes/depois para cada problema |
| **Verificador de Contraste de Cores** | Valida pares de cores de primeiro e segundo plano contra as proporções AA e AAA |
| **Relatórios de Conformidade** | Gera relatórios para partes interessadas com resumos de aprovação/reprovação |
| **Integração CI/CD** | Configurações de pipeline para GitHub Actions, GitLab CI, Azure DevOps |
| **Auditoria de Navegação por Teclado** | Detecta gerenciamento de foco ausente e problemas de ordem de tabulação |
| **Validação ARIA** | Verifica atributos ARIA incorretos, redundantes ou ausentes |

### Definições de Severidade

| Severidade | Definição | Exemplo | SLA |
|----------|-----------|---------|-----|
| **Crítica** | Bloqueia o acesso para grupos inteiros de usuários | Texto alternativo ausente, sem acesso por teclado à navegação | Corrigir antes do lançamento |
| **Maior** | Barreira significativa que degrada a experiência | Contraste de cores insuficiente, rótulos de formulário ausentes | Corrigir dentro do sprint atual |
| **Menor** | Problema de usabilidade que causa atrito | Funções ARIA redundantes, hierarquia de cabeçalhos subótima | Corrigir nos próximos 2 sprints |

## Uso

### Início Rápido

```bash
# Escanear projeto inteiro
python scripts/a11y_scanner.py /path/to/project

# Escanear com saída JSON para ferramentas
python scripts/a11y_scanner.py /path/to/project --json

# Verificar contraste de cores para valores específicos
python scripts/contrast_checker.py --fg "#777777" --bg "#ffffff"

# Verificar contraste em um arquivo CSS/Tailwind
python scripts/contrast_checker.py --file /path/to/styles.css
```

### Slash Command

```
/a11y-audit                    # Auditar o projeto atual
/a11y-audit --scope src/       # Auditar diretório específico
/a11y-audit --fix              # Auditar e aplicar correções automaticamente
/a11y-audit --report           # Gerar relatório para partes interessadas
/a11y-audit --ci               # Saída de resultados compatível com CI
```

### Fluxo de Trabalho em Três Fases

**Fase 1: Escanear** — Percorrer a árvore de código-fonte, detectar framework, aplicar conjunto de regras.

```bash
python scripts/a11y_scanner.py /path/to/project --format table
```

**Fase 2: Corrigir** — Aplicar correções específicas para o framework em cada violação.

> Veja [references/framework-a11y-patterns.md](references/framework-a11y-patterns.md) para o catálogo completo de padrões de correção.

**Fase 3: Verificar** — Executar novamente o scanner para confirmar as correções e verificar regressões.

```bash
python scripts/a11y_scanner.py /path/to/project --baseline audit-baseline.json
```

## Exemplo: Auditoria de Componente React

```tsx
// ANTES: src/components/ProductCard.tsx
function ProductCard({ product }) {
  return (
    <div onClick={() => navigate(`/product/${product.id}`)}>
      <img src={product.image} />
      <div style={{ color: '#aaa', fontSize: '12px' }}>{product.name}</div>
      <span style={{ color: '#999' }}>${product.price}</span>
    </div>
  );
}
```

| # | WCAG | Severidade | Problema |
|---|------|----------|-------|
| 1 | 1.1.1 | Crítica | `<img>` sem atributo `alt` |
| 2 | 2.1.1 | Crítica | `<div onClick>` não acessível por teclado |
| 3 | 1.4.3 | Maior | Cor `#aaa` no branco falha no contraste (2.32:1, necessita 4.5:1) |
| 4 | 1.4.3 | Maior | Cor `#999` no branco falha no contraste (2.85:1, necessita 4.5:1) |
| 5 | 4.1.2 | Maior | Elemento interativo sem role e nome acessível |

```tsx
// DEPOIS: src/components/ProductCard.tsx
function ProductCard({ product }) {
  return (
    <a href={`/product/${product.id}`} className="product-card"
       aria-label={`View ${product.name} - $${product.price}`}>
      <img src={product.image} alt={product.imageAlt || product.name} />
      <div style={{ color: '#595959', fontSize: '12px' }}>{product.name}</div>
      <span style={{ color: '#767676' }}>${product.price}</span>
    </a>
  );
}
```

> Veja [references/examples-by-framework.md](references/examples-by-framework.md) para exemplos em Vue, Angular, Next.js e Svelte.

## Referência de Ferramentas

### a11y_scanner.py

```
Uso: python scripts/a11y_scanner.py <caminho> [opções]

Opções:
  --json                  Saída dos resultados como JSON
  --format {table,csv}    Formato de saída (padrão: table)
  --severity {critical,major,minor}  Filtrar por severidade mínima
  --framework {react,vue,angular,svelte,html,auto}  Forçar framework (padrão: auto)
  --baseline FILE         Comparar com resultados de escaneamento anteriores
  --report                Gerar relatório para partes interessadas
  --output FILE           Escrever resultados em arquivo
  --quiet                 Suprimir saída, apenas código de saída
  --ci                    Modo CI: saída não-zero em problemas críticos
```

### contrast_checker.py

```
Uso: python scripts/contrast_checker.py [opções]

Opções:
  --fg COLOR              Cor de primeiro plano (hex)
  --bg COLOR              Cor de segundo plano (hex)
  --file FILE             Escanear arquivo CSS para pares de cores
  --tailwind DIR          Escanear diretório para classes de cores Tailwind
  --json                  Saída dos resultados como JSON
  --suggest               Sugerir alternativas acessíveis para falhas
  --level {aa,aaa}        Nível de conformidade alvo (padrão: aa)
```

## Armadilhas Comuns

| Armadilha | Abordagem Correta |
|---------|------------------|
| `role="button"` em um `<div>` | Use `<button>` nativo — inclui tratamento de teclado gratuitamente |
| `tabindex="0"` em tudo | Apenas elementos interativos precisam de foco; use elementos nativos |
| `aria-label` em elementos não-interativos | Use `aria-labelledby` apontando para texto visível |
| `display: none` para ocultar de leitores de tela | Use a classe `.sr-only` |
| Cor apenas para transmitir significado | Adicione ícones, rótulos de texto ou padrões junto com a cor |
| Placeholder como único rótulo | Sempre forneça um `<label>` visível |
| `outline: none` sem substituição | Sempre forneça um indicador de foco visível via `focus-visible` |
| `alt=""` vazio em imagens informacionais | Imagens informacionais precisam de texto alternativo descritivo |
| Pular níveis de cabeçalho (h1 -> h3) | Níveis de cabeçalho devem ser sequenciais |
| `onClick` sem `onKeyDown` | Adicione suporte a teclado ou prefira elementos nativos |
| Ignorar `prefers-reduced-motion` | Envolva animações em `@media (prefers-reduced-motion: no-preference)` |

## Skills Relacionadas

| Skill | Relação |
|-------|-------------|
| **senior-frontend** | Padrões de frontend usados em correções de a11y |
| **code-reviewer** | Incluir verificações de a11y em fluxos de trabalho de revisão de código |
| **senior-qa** | Integração de testes de a11y em processos de QA |
| **playwright-pro** | Testes automatizados de navegador com asserções de acessibilidade |
| **epic-design** | Animações e scroll storytelling em conformidade com WCAG 2.1 AA |
| **tdd-guide** | Padrões de desenvolvimento orientado a testes para casos de teste de a11y |

## Documentação de Referência

| Referência | Descrição |
|-----------|-------------|
| [wcag-quick-ref.md](references/wcag-quick-ref.md) | Referência rápida dos critérios WCAG 2.2 Nível A e AA |
| [wcag-22-new-criteria.md](references/wcag-22-new-criteria.md) | Novos critérios de sucesso WCAG 2.2 (Aparência de Foco, Tamanho Meta, etc.) |
| [aria-patterns.md](references/aria-patterns.md) | Padrões ARIA, interação por teclado e regiões ao vivo |
| [framework-a11y-patterns.md](references/framework-a11y-patterns.md) | Padrões de correção específicos por framework (React, Vue, Angular, Svelte, HTML) |
| [color-contrast-guide.md](references/color-contrast-guide.md) | Detalhes do verificador de contraste de cores, mapeamento de paleta Tailwind, classe sr-only |
| [ci-cd-integration.md](references/ci-cd-integration.md) | Configurações de GitHub Actions, GitLab CI, Azure DevOps, pre-commit hook |
| [audit-report-template.md](references/audit-report-template.md) | Modelo de relatório de auditoria pronto para partes interessadas |
| [testing-checklist.md](references/testing-checklist.md) | Lista de verificação de testes manuais (teclado, leitor de tela, visual, formulários) |
| [examples-by-framework.md](references/examples-by-framework.md) | Exemplos completos de auditoria para Vue, Angular, Next.js e Svelte |

## Recursos

- [WCAG 2.2 Specification](https://www.w3.org/TR/WCAG22/)
- [WAI-ARIA Autoring Practices 1.2](https://www.w3.org/WAI/ARIA/apg/)
- [Deque axe-core Rules](https://github.com/dequelabs/axe-core/blob/develop/doc/rule-descriptions.md)
- [eslint-plugin-jsx-a11y](https://github.com/jsx-eslint/eslint-plugin-jsx-a11y)
