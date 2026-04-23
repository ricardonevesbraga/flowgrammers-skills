---
name: "init"
description: >-
  Configure o Playwright em um projeto. Use quando o usuário disser "configurar playwright",
  "adicionar testes e2e", "configurar playwright", "setup de testes", "iniciar playwright"
  ou "adicionar infraestrutura de testes".
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Inicializar Projeto Playwright

Configure um ambiente de testes Playwright pronto para produção. Detecte o framework, gere config, estrutura de pastas, teste de exemplo e pipeline de CI.

## Passos

### 1. Analisar o Projeto

Use o subagente `Explore` para escanear o projeto:

- Verificar `package.json` para identificar o framework (React, Next.js, Vue, Angular, Svelte)
- Verificar se existe `tsconfig.json` → usar TypeScript; caso contrário, JavaScript
- Verificar se o Playwright já está instalado (`@playwright/test` nas dependências)
- Verificar diretórios de teste existentes (`tests/`, `e2e/`, `__tests__/`)
- Verificar configuração de CI existente (`.github/workflows/`, `.gitlab-ci.yml`)

### 2. Instalar Playwright

Se ainda não estiver instalado:

```bash
npm init playwright@latest -- --quiet
```

Ou se o usuário preferir configuração manual:

```bash
npm install -D @playwright/test
npx playwright install --with-deps chromium
```

### 3. Gerar `playwright.config.ts`

Adaptar ao framework detectado:

**Next.js:**
```typescript
import { defineConfig, devices } from '@playwright/test';

export default defineConfig({
  testDir: './e2e',
  fullyParallel: true,
  forbidOnly: !!process.env.CI,
  retries: process.env.CI ? 2 : 0,
  workers: process.env.CI ? 1 : undefined,
  reporter: [
    ['html', { open: 'never' }],
    ['list'],
  ],
  use: {
    baseURL: 'http://localhost:3000',
    trace: 'on-first-retry',
    screenshot: 'only-on-failure',
  },
  projects: [
    { name: "chromium", use: { ...devices['Desktop Chrome'] } },
    { name: "firefox", use: { ...devices['Desktop Firefox'] } },
    { name: "webkit", use: { ...devices['Desktop Safari'] } },
  ],
  webServer: {
    command: 'npm run dev',
    url: 'http://localhost:3000',
    reuseExistingServer: !process.env.CI,
  },
});
```

**React (Vite):**
- Alterar `baseURL` para `http://localhost:5173`
- Alterar `webServer.command` para `npm run dev`

**Vue/Nuxt:**
- Alterar `baseURL` para `http://localhost:3000`
- Alterar `webServer.command` para `npm run dev`

**Angular:**
- Alterar `baseURL` para `http://localhost:4200`
- Alterar `webServer.command` para `npm run start`

**Nenhum framework detectado:**
- Omitir o bloco `webServer`
- Definir `baseURL` com base na entrada do usuário ou deixar como placeholder

### 4. Criar Estrutura de Pastas

```
e2e/
├── fixtures/
│   └── index.ts          # Fixtures personalizados
├── pages/
│   └── .gitkeep          # Page object models
├── test-data/
│   └── .gitkeep          # Arquivos de dados de teste
└── example.spec.ts       # Primeiro teste de exemplo
```

### 5. Gerar Teste de Exemplo

```typescript
import { test, expect } from '@playwright/test';

test.describe('Homepage', () => {
  test('should load successfully', async ({ page }) => {
    await page.goto('/');
    await expect(page).toHaveTitle(/.+/);
  });

  test('should have visible navigation', async ({ page }) => {
    await page.goto('/');
    await expect(page.getByRole('navigation')).toBeVisible();
  });
});
```

### 6. Gerar Pipeline de CI

Se `.github/workflows/` existir, criar `playwright.yml`:

```yaml
name: "playwright-tests"

on:
  push:
    branches: [main, dev]
  pull_request:
    branches: [main, dev]

jobs:
  test:
    timeout-minutes: 60
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4
      - uses: actions/setup-node@v4
        with:
          node-version: lts/*
      - name: "install-dependencies"
        run: npm ci
      - name: "install-playwright-browsers"
        run: npx playwright install --with-deps
      - name: "run-playwright-tests"
        run: npx playwright test
      - uses: actions/upload-artifact@v4
        if: ${{ !cancelled() }}
        with:
          name: "playwright-report"
          path: playwright-report/
          retention-days: 30
```

Se `.gitlab-ci.yml` existir, adicionar um stage Playwright no lugar.

### 7. Atualizar `.gitignore`

Adicionar se ainda não estiver presente:

```
/test-results/
/playwright-report/
/blob-report/
/playwright/.cache/
```

### 8. Adicionar Scripts npm

Adicionar ao `package.json` em scripts:

```json
{
  "test:e2e": "playwright test",
  "test:e2e:ui": "playwright test --ui",
  "test:e2e:debug": "playwright test --debug"
}
```

### 9. Verificar Setup

Executar o teste de exemplo:

```bash
npx playwright test
```

Reportar o resultado. Se falhar, diagnosticar e corrigir antes de concluir.

## Saída

Confirmar o que foi criado:
- Caminho do arquivo de config e configurações principais
- Diretório de testes e teste de exemplo
- Pipeline de CI (se aplicável)
- Scripts npm adicionados
- Como executar: `npx playwright test` ou `npm run test:e2e`
