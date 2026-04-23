---
name: "senior-qa"
description: "Gera testes unitários, testes de integração e testes E2E para aplicações React/Next.js. Escaneia componentes para criar stubs de testes Jest + React Testing Library, analisa relatórios de cobertura Istanbul/LCOV para identificar lacunas, cria scaffolding de arquivos de teste Playwright a partir de rotas Next.js, mocka chamadas de API com MSW, cria fixtures de teste e configura test runners. Use quando o usuário pedir para 'gerar testes', 'escrever testes unitários', 'analisar cobertura de testes', 'criar scaffolding de testes E2E', 'configurar Playwright', 'configurar Jest', 'implementar padrões de teste' ou 'melhorar qualidade de testes'."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Engenheiro de QA Sênior

Automação de testes, análise de cobertura e padrões de garantia de qualidade para aplicações React e Next.js.

---

## Início Rápido

```bash
# Gerar stubs de teste Jest para componentes React
python scripts/test_suite_generator.py src/components/ --output __tests__/

# Analisar cobertura de testes a partir de relatórios Jest/Istanbul
python scripts/coverage_analyzer.py coverage/coverage-final.json --threshold 80

# Criar scaffolding de testes E2E Playwright para rotas Next.js
python scripts/e2e_test_scaffolder.py src/app/ --output e2e/
```

---

## Visão Geral das Ferramentas

### 1. Gerador de Suite de Testes

Escaneia componentes React/TypeScript e gera stubs de testes Jest + React Testing Library com estrutura adequada.

**Entrada:** Diretório de origem contendo componentes React
**Saída:** Arquivos de teste com blocos describe, testes de render, testes de interação

**Uso:**
```bash
# Uso básico - escanear componentes e gerar testes
python scripts/test_suite_generator.py src/components/ --output __tests__/

# Incluir testes de acessibilidade
python scripts/test_suite_generator.py src/ --output __tests__/ --include-a11y

# Gerar com template customizado
python scripts/test_suite_generator.py src/ --template custom-template.tsx
```

**Padrões Suportados:**
- Componentes funcionais com hooks
- Componentes com provedores de Context
- Componentes com busca de dados
- Componentes de formulário com validação

---

### 2. Analisador de Cobertura

Analisa relatórios de cobertura Jest/Istanbul e identifica lacunas, branches não cobertas e fornece recomendações acionáveis.

**Entrada:** Relatório de cobertura (formato JSON ou LCOV)
**Saída:** Análise de cobertura com recomendações

**Uso:**
```bash
# Analisar relatório de cobertura
python scripts/coverage_analyzer.py coverage/coverage-final.json

# Impor threshold (sair com 1 se abaixo)
python scripts/coverage_analyzer.py coverage/ --threshold 80 --strict

# Gerar relatório HTML
python scripts/coverage_analyzer.py coverage/ --format html --output report.html
```

---

### 3. Scaffolder de Testes E2E

Escaneia páginas/diretório app do Next.js e gera arquivos de teste Playwright com interações comuns.

**Entrada:** Diretório de páginas ou app do Next.js
**Saída:** Arquivos de teste Playwright organizados por rota

**Uso:**
```bash
# Criar scaffolding de testes E2E para Next.js App Router
python scripts/e2e_test_scaffolder.py src/app/ --output e2e/

# Incluir classes Page Object Model
python scripts/e2e_test_scaffolder.py src/app/ --output e2e/ --include-pom

# Gerar para rotas específicas
python scripts/e2e_test_scaffolder.py src/app/ --routes "/login,/dashboard,/checkout"
```

---

## Workflows de QA

### Workflow de Geração de Testes Unitários

Use ao configurar testes para componentes React novos ou existentes.

**Passo 1: Escanear o projeto em busca de componentes não testados**
```bash
python scripts/test_suite_generator.py src/components/ --scan-only
```

**Passo 2: Gerar stubs de teste**
```bash
python scripts/test_suite_generator.py src/components/ --output __tests__/
```

**Passo 3: Revisar e personalizar os testes gerados**
```typescript
// __tests__/Button.test.tsx (gerado)
import { render, screen, fireEvent } from '@testing-library/react';
import { Button } from '../src/components/Button';

describe('Button', () => {
  it('renderiza com label', () => {
    render(<Button>Clique aqui</Button>);
    expect(screen.getByRole('button', { name: /clique aqui/i })).toBeInTheDocument();
  });

  it('chama onClick ao clicar', () => {
    const handleClick = jest.fn();
    render(<Button onClick={handleClick}>Clique</Button>);
    fireEvent.click(screen.getByRole('button'));
    expect(handleClick).toHaveBeenCalledTimes(1);
  });

  // TODO: Adicionar seus casos de teste específicos
});
```

**Passo 4: Executar testes e verificar cobertura**
```bash
npm test -- --coverage
python scripts/coverage_analyzer.py coverage/coverage-final.json
```

---

### Workflow de Análise de Cobertura

Use ao melhorar a cobertura de testes ou ao preparar para um release.

**Passo 1: Gerar relatório de cobertura**
```bash
npm test -- --coverage --coverageReporters=json
```

**Passo 2: Analisar lacunas de cobertura**
```bash
python scripts/coverage_analyzer.py coverage/coverage-final.json --threshold 80
```

**Passo 3: Identificar caminhos críticos**
```bash
python scripts/coverage_analyzer.py coverage/ --critical-paths
```

**Passo 4: Gerar stubs de testes ausentes**
```bash
python scripts/test_suite_generator.py src/ --uncovered-only --output __tests__/
```

**Passo 5: Verificar melhoria**
```bash
npm test -- --coverage
python scripts/coverage_analyzer.py coverage/ --compare previous-coverage.json
```

---

### Workflow de Configuração de Testes E2E

Use ao configurar Playwright para um projeto Next.js.

**Passo 1: Inicializar Playwright (se não instalado)**
```bash
npm init playwright@latest
```

**Passo 2: Criar scaffolding de testes E2E a partir de rotas**
```bash
python scripts/e2e_test_scaffolder.py src/app/ --output e2e/
```

**Passo 3: Configurar fixtures de autenticação**
```typescript
// e2e/fixtures/auth.ts (gerado)
import { test as base } from '@playwright/test';

export const test = base.extend({
  authenticatedPage: async ({ page }, use) => {
    await page.goto('/login');
    await page.fill('[name="email"]', 'test@example.com');
    await page.fill('[name="password"]', 'password');
    await page.click('button[type="submit"]');
    await page.waitForURL('/dashboard');
    await use(page);
  },
});
```

**Passo 4: Executar testes E2E**
```bash
npx playwright test
npx playwright show-report
```

**Passo 5: Adicionar ao pipeline CI**
```yaml
# .github/workflows/e2e.yml
- name: "run-e2e-tests"
  run: npx playwright test
- name: "upload-report"
  uses: actions/upload-artifact@v3
  with:
    name: "playwright-report"
    path: playwright-report/
```

---

## Documentação de Referência

| Arquivo | Contém | Use Quando |
|------|----------|----------|
| `references/testing_strategies.md` | Pirâmide de testes, tipos de teste, metas de cobertura, integração CI/CD | Projetando estratégia de testes |
| `references/test_automation_patterns.md` | Page Object Model, mocking (MSW), fixtures, padrões async | Escrevendo código de teste |
| `references/qa_best_practices.md` | Código testável, testes instáveis, debugging, métricas de qualidade | Melhorando qualidade de testes |

---

## Referência Rápida de Padrões Comuns

### Queries do React Testing Library

```typescript
// Preferidas (acessíveis)
screen.getByRole('button', { name: /enviar/i })
screen.getByLabelText(/email/i)
screen.getByPlaceholderText(/buscar/i)

// Fallback
screen.getByTestId('custom-element')
```

### Testes Assíncronos

```typescript
// Aguardar elemento
await screen.findByText(/carregado/i);

// Aguardar remoção
await waitForElementToBeRemoved(() => screen.queryByText(/carregando/i));

// Aguardar condição
await waitFor(() => {
  expect(mockFn).toHaveBeenCalled();
});
```

### Mocking com MSW

```typescript
import { rest } from 'msw';
import { setupServer } from 'msw/node';

const server = setupServer(
  rest.get('/api/users', (req, res, ctx) => {
    return res(ctx.json([{ id: 1, name: 'João' }]));
  })
);

beforeAll(() => server.listen());
afterEach(() => server.resetHandlers());
afterAll(() => server.close());
```

### Locators do Playwright

```typescript
// Preferidos
page.getByRole('button', { name: /enviar/i })
page.getByLabel('Email')
page.getByText('Bem-vindo')

// Encadeamento
page.getByRole('listitem').filter({ hasText: 'Produto' })
```

### Thresholds de Cobertura (jest.config.js)

```javascript
module.exports = {
  coverageThreshold: {
    global: {
      branches: 80,
      functions: 80,
      lines: 80,
      statements: 80,
    },
  },
};
```

---

## Comandos Comuns

```bash
# Jest
npm test                           # Executar todos os testes
npm test -- --watch                # Modo watch
npm test -- --coverage             # Com cobertura
npm test -- Button.test.tsx        # Arquivo único

# Playwright
npx playwright test                # Executar todos os testes E2E
npx playwright test --ui           # Modo UI
npx playwright test --debug        # Modo debug
npx playwright codegen             # Gerar testes

# Cobertura
npm test -- --coverage --coverageReporters=lcov,json
python scripts/coverage_analyzer.py coverage/coverage-final.json
```
