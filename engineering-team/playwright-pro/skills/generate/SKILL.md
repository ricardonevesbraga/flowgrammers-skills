---
name: "generate"
description: >-
  Gere testes Playwright. Use quando o usuário disser "escrever testes", "gerar testes",
  "adicionar testes para", "testar este componente", "teste e2e", "criar teste para",
  "testar esta página" ou "testar esta funcionalidade".
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Gerar Testes Playwright

Gere testes Playwright prontos para produção a partir de uma história de usuário, URL, nome de componente ou descrição de funcionalidade.

## Entrada

`$ARGUMENTS` contém o que testar. Exemplos:
- `"user can log in with email and password"`
- `"the checkout flow"`
- `"src/components/UserProfile.tsx"`
- `"the search page with filters"`

## Passos

### 1. Entender a Meta

Analisar `$ARGUMENTS` para determinar:
- **História de usuário**: Extrair o comportamento a verificar
- **Caminho do componente**: Ler o código-fonte do componente
- **Página/URL**: Identificar a rota e seus elementos
- **Nome da funcionalidade**: Mapear para áreas relevantes da aplicação

### 2. Explorar o Codebase

Use o subagente `Explore` para coletar contexto:

- Ler `playwright.config.ts` para `testDir`, `baseURL`, `projects`
- Verificar testes existentes em `testDir` para padrões, fixtures e convenções
- Se um caminho de componente for fornecido, ler o componente para entender seus props, estados e interações
- Verificar por page objects existentes em `pages/`
- Verificar por fixtures existentes em `fixtures/`
- Verificar por configuração de auth (`auth.setup.ts` ou config `storageState`)

### 3. Selecionar Templates

Verificar `templates/` neste plugin para padrões correspondentes:

| Se testando... | Carregar template de |
|---|---|
| Fluxo de login/auth | `templates/auth/login.md` |
| Operações CRUD | `templates/crud/` |
| Checkout/pagamento | `templates/checkout/` |
| UI de pesquisa/filtro | `templates/search/` |
| Envio de formulário | `templates/forms/` |
| Dashboard/dados | `templates/dashboard/` |
| Página de configurações | `templates/settings/` |
| Fluxo de integração | `templates/onboarding/` |
| Endpoints de API | `templates/api/` |
| Acessibilidade | `templates/accessibility/` |

Adaptar o template à aplicação específica — substituir `{{placeholders}}` por seletores, URLs e dados reais.

### 4. Gerar o Teste

Seguir estas regras:

**Estrutura:**
```typescript
import { test, expect } from '@playwright/test';
// Importar fixtures personalizados se o projeto os usar

test.describe('Feature Name', () => {
  // Agrupar comportamentos relacionados

  test('should <expected behavior>', async ({ page }) => {
    // Arranjar: navegar, configurar estado
    // Agir: executar ação do usuário
    // Asserir: verificar resultado
  });
});
```

**Prioridade de localizador** (use o primeiro que funcionar):
1. `getByRole()` — botões, links, cabeçalhos, elementos de formulário
2. `getByLabel()` — campos de formulário com rótulos
3. `getByText()` — conteúdo de texto não interativo
4. `getByPlaceholder()` — inputs com texto de placeholder
5. `getByTestId()` — quando opções semânticas não estão disponíveis

**Asserções** — sempre web-first:
```typescript
// BOM — tenta automaticamente
await expect(page.getByRole('heading')).toBeVisible();
await expect(page.getByRole('alert')).toHaveText('Success');

// RUIM — sem retry
const text = await page.textContent('.msg');
expect(text).toBe('Success');
```

**Nunca use:**
- `page.waitForTimeout()`
- `page.$(selector)` ou `page.$$(selector)`
- Seletores CSS simples a menos que absolutamente necessário
- `page.evaluate()` para coisas que localizadores podem fazer

**Sempre inclua:**
- Nomes de teste descritivos que explicam o comportamento
- Testes de erro/caso extremo junto ao caminho feliz
- `await` adequado em toda chamada Playwright
- Navegação relativa ao `baseURL` (`page.goto('/')` não `page.goto('http://...')`)

### 5. Corresponder às Convenções do Projeto

- Se o projeto usa TypeScript → gerar `.spec.ts`
- Se o projeto usa JavaScript → gerar `.spec.js` com imports `require()`
- Se o projeto tem page objects → usá-los em vez de localizadores inline
- Se o projeto tem fixtures personalizados → importar e usar
- Se o projeto tem um diretório de dados de teste → criar arquivos de dados de teste lá

### 6. Gerar Arquivos de Suporte (Se Necessário)

- **Page object**: Se o teste toca 5+ localizadores únicos em uma página, criar um page object
- **Fixture**: Se o teste precisa de configuração compartilhada (auth, dados), criar ou estender um fixture
- **Dados de teste**: Se o teste usa dados estruturados, criar um arquivo JSON em `test-data/`

### 7. Verificar

Executar o teste gerado:

```bash
npx playwright test <arquivo-gerado> --reporter=list
```

Se falhar:
1. Ler o erro
2. Corrigir o teste (não a aplicação)
3. Executar novamente
4. Se for um problema da aplicação, reportar ao usuário

## Saída

- Arquivo(s) de teste gerado(s) com caminho
- Quaisquer arquivos de suporte criados (page objects, fixtures, dados)
- Resultado da execução do teste
- Nota de cobertura: quais comportamentos agora estão testados
