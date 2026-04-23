---
name: "migrate"
description: >-
  Migre do Cypress ou Selenium para o Playwright. Use quando o usuário mencionar
  "cypress", "selenium", "migrar testes", "converter testes", "migrar para
  playwright", "sair do cypress" ou "substituir selenium".
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Migrar para o Playwright

Migração interativa do Cypress ou Selenium para o Playwright com conversão arquivo por arquivo.

## Entrada

`$ARGUMENTS` pode ser:
- `"from cypress"` — migrar suite de testes Cypress
- `"from selenium"` — migrar testes Selenium/WebDriver
- Um caminho de arquivo: converter um arquivo de teste específico
- Vazio: detectar automaticamente o framework de origem

## Passos

### 1. Detectar o Framework de Origem

Use o subagente `Explore` para escanear:
- Diretório `cypress/` ou `cypress.config.ts` → Cypress
- `selenium`, `webdriver` nas dependências do `package.json` → Selenium
- Arquivos `.py` com imports de `selenium` → Selenium (Python)

### 2. Avaliar o Escopo da Migração

Contar arquivos e categorizar:

```
Avaliação de Migração:
- Total de arquivos de teste: X
- Comandos customizados Cypress: Y
- Fixtures Cypress: Z
- Esforço estimado: [pequeno|médio|grande]
```

| Tamanho | Arquivos | Abordagem |
|---|---|---|
| Pequeno (1-10) | Converter sequencialmente | Conversão direta |
| Médio (11-30) | Em lotes de 5 | Usar subagentes |
| Grande (31+) | Usar `/batch` | Conversão paralela com `/batch` |

### 3. Configurar Playwright (Se Não Estiver Presente)

Executar `/pw:init` primeiro se o Playwright não estiver configurado.

### 4. Converter Arquivos

Para cada arquivo, aplicar o mapeamento apropriado:

#### Cypress → Playwright

Carregar `cypress-mapping.md` para referência completa.

Traduções principais:
```
cy.visit(url)           → page.goto(url)
cy.get(selector)        → page.locator(selector) ou page.getByRole(...)
cy.contains(text)       → page.getByText(text)
cy.find(selector)       → locator.locator(selector)
cy.click()              → locator.click()
cy.type(text)           → locator.fill(text)
cy.should('be.visible') → expect(locator).toBeVisible()
cy.should('have.text')  → expect(locator).toHaveText(text)
cy.intercept()          → page.route()
cy.wait('@alias')       → page.waitForResponse()
cy.fixture()            → import JSON ou arquivo de dados de teste
```

**Comandos customizados Cypress** → fixtures ou funções helper do Playwright
**Plugins Cypress** → config ou fixtures do Playwright
**`before`/`beforeEach`** → `test.beforeAll()` / `test.beforeEach()`

#### Selenium → Playwright

Carregar `selenium-mapping.md` para referência completa.

Traduções principais:
```
driver.get(url)                    → page.goto(url)
driver.findElement(By.id('x'))     → page.locator('#x') ou page.getByTestId('x')
driver.findElement(By.css('.x'))   → page.locator('.x') ou page.getByRole(...)
element.click()                    → locator.click()
element.sendKeys(text)             → locator.fill(text)
element.getText()                  → locator.textContent()
WebDriverWait + ExpectedConditions → expect(locator).toBeVisible()
driver.switchTo().frame()          → page.frameLocator()
Actions                            → locator.hover(), locator.dragTo()
```

### 5. Atualizar Localizadores

Durante a conversão, atualizar seletores para as melhores práticas do Playwright:
- `#id` → `getByTestId()` ou `getByRole()`
- `.class` → `getByRole()` ou `getByText()`
- `[data-testid]` → `getByTestId()`
- XPath → localizadores baseados em role

### 6. Converter Comandos Customizados / Utilitários

- Comandos customizados Cypress → fixtures customizados do Playwright via `test.extend()`
- Page objects Selenium → page objects do Playwright (manter estrutura, atualizar API)
- Helpers compartilhados → funções utilitárias TypeScript

### 7. Verificar Cada Arquivo Convertido

Após converter cada arquivo:

```bash
npx playwright test <arquivo-convertido> --reporter=list
```

Corrigir erros de compilação ou de execução antes de avançar para o próximo arquivo.

### 8. Limpeza

Após todos os arquivos serem convertidos:
- Remover dependências Cypress/Selenium do `package.json`
- Remover arquivos de configuração antigos (`cypress.config.ts`, etc.)
- Atualizar pipeline de CI para usar o Playwright
- Atualizar README com novos comandos de teste

Perguntar ao usuário antes de deletar qualquer coisa.

## Saída

- Resumo da conversão: arquivos convertidos, total de testes migrados
- Testes que não puderam ser convertidos automaticamente (intervenção manual necessária)
- Config de CI atualizada
- Comparação antes/depois dos resultados de execução dos testes
