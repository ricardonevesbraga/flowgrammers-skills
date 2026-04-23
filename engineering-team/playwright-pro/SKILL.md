---
name: "playwright-pro"
description: "Toolkit de testes Playwright de nível produção. Use quando o usuário menciona testes Playwright, testes E2E, automação de navegador, correção de testes instáveis, migração de testes, testes CI/CD ou suites de testes. Gere testes, corrija falhas instáveis, migre do Cypress/Selenium, sincronize com TestRail, execute no BrowserStack. 55 templates, 3 agents, relatórios inteligentes."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Playwright Pro

Toolkit de testes Playwright de nível produção para agentes de codificação com IA.

## Comandos Disponíveis

Quando instalado como plugin Claude Code, estes estão disponíveis como comandos `/pw:`:

| Comando | O que faz |
|---|---|
| `/pw:init` | Configurar o Playwright — detecta framework, gera config, CI, primeiro teste |
| `/pw:generate <spec>` | Gerar testes a partir de história de usuário, URL ou componente |
| `/pw:review` | Revisar testes para anti-padrões e lacunas de cobertura |
| `/pw:fix <test>` | Diagnosticar e corrigir testes com falha ou instáveis |
| `/pw:migrate` | Migrar do Cypress ou Selenium para Playwright |
| `/pw:coverage` | Analisar o que está testado vs. o que está faltando |
| `/pw:testrail` | Sincronizar com TestRail — ler casos, enviar resultados |
| `/pw:browserstack` | Executar no BrowserStack, obter relatórios cross-browser |
| `/pw:report` | Gerar relatório de testes no formato preferido |

## Fluxo de Trabalho de Início Rápido

A sequência recomendada para a maioria dos projetos:

```
1. /pw:init          → configura config, pipeline CI e um primeiro teste de fumaça
2. /pw:generate      → gera testes a partir da sua especificação ou URL
3. /pw:review        → valida qualidade e sinaliza anti-padrões      ← sempre executar após generate
4. /pw:fix <test>    → diagnostica e repara quaisquer testes com falha/instáveis  ← executar quando o CI ficar vermelho
```

**Pontos de verificação:**
- Após `/pw:generate` — sempre execute `/pw:review` antes de fazer commit; ele captura anti-padrões de localizador e asserções ausentes automaticamente.
- Após `/pw:fix` — execute a suite completa localmente (`npx playwright test`) para confirmar que a correção não introduz regressões.
- Após `/pw:migrate` — execute `/pw:coverage` para confirmar paridade com a suite antiga antes de descomissionar os testes Cypress/Selenium.

### Exemplo: Gerar → Revisar → Corrigir

```bash
# 1. Gerar testes a partir de uma história de usuário
/pw:generate "As a user I can log in with email and password"

# Gerado: tests/auth/login.spec.ts
# → Playwright Pro cria o arquivo usando o template de auth.

# 2. Revisar os testes gerados
/pw:review tests/auth/login.spec.ts

# → Sinaliza: um teste usou page.locator('input[type=password]') — sugere getByLabel('Password')
# → Correção aplicada automaticamente.

# 3. Executar localmente para confirmar
npx playwright test tests/auth/login.spec.ts --headed

# 4. Se um teste for instável no CI, diagnosticá-lo
/pw:fix tests/auth/login.spec.ts
# → Identifica asserção web-first ausente; substitui waitForTimeout(2000) por expect(locator).toBeVisible()
```

## Regras de Ouro

1. `getByRole()` em vez de CSS/XPath — resistente a mudanças de marcação
2. Nunca `page.waitForTimeout()` — use asserções web-first
3. `expect(locator)` tenta automaticamente; `expect(await locator.textContent())` não
4. Isole cada teste — sem estado compartilhado entre testes
5. `baseURL` na config — zero URLs hardcoded
6. Retries: `2` no CI, `0` localmente
7. Traces: `'on-first-retry'` — depuração rica sem lentidão
8. Fixtures em vez de globais — `test.extend()` para estado compartilhado
9. Um comportamento por teste — múltiplas asserções relacionadas são aceitáveis
10. Simule apenas serviços externos — nunca simule sua própria aplicação

## Prioridade de Localizador

```
1. getByRole()        — botões, links, cabeçalhos, elementos de formulário
2. getByLabel()       — campos de formulário com rótulos
3. getByText()        — texto não interativo
4. getByPlaceholder() — inputs com placeholder
5. getByTestId()      — quando nenhuma opção semântica existe
6. page.locator()     — CSS/XPath como último recurso
```

## O que Está Incluído

- **9 skills** com instruções detalhadas passo a passo
- **3 agents especializados**: test-architect, test-debugger, migration-planner
- **55 templates de teste**: auth, CRUD, checkout, pesquisa, formulários, dashboard, configurações, integração, notificações, API, acessibilidade
- **2 servidores MCP** (TypeScript): integrações TestRail e BrowserStack
- **Hooks inteligentes**: validação automática de qualidade de teste, detecção automática de projetos Playwright
- **6 documentos de referência**: regras de ouro, localizadores, asserções, fixtures, armadilhas, testes instáveis
- **Guias de migração**: tabelas de mapeamento Cypress e Selenium

## Configuração de Integração

### TestRail (Opcional)
```bash
export TESTRAIL_URL="https://your-instance.testrail.io"
export TESTRAIL_USER="your@email.com"
export TESTRAIL_API_KEY="your-api-key"
```

### BrowserStack (Opcional)
```bash
export BROWSERSTACK_USERNAME="your-username"
export BROWSERSTACK_ACCESS_KEY="your-access-key"
```

## Referência Rápida

Veja o diretório `reference/` para:
- `golden-rules.md` — As 10 regras não negociáveis
- `locators.md` — Prioridade completa de localizador com folha de referência
- `assertions.md` — Referência de asserções web-first
- `fixtures.md` — Fixtures personalizados e padrões storageState
- `common-pitfalls.md` — Os 10 erros principais e correções
- `flaky-tests.md` — Comandos de diagnóstico e correções rápidas

Veja `templates/README.md` para o índice completo de templates.
