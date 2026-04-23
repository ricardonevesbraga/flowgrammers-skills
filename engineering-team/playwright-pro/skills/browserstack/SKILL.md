---
name: "browserstack"
description: >-
  Execute testes no BrowserStack. Use quando o usuário menciona "browserstack",
  "cross-browser", "testes em nuvem", "matriz de navegadores", "testar no safari",
  "testar no firefox" ou "compatibilidade de navegadores".
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Integração BrowserStack

Execute testes Playwright na grade de nuvem do BrowserStack para testes cross-browser e cross-device.

## Pré-requisitos

As variáveis de ambiente devem estar definidas:
- `BROWSERSTACK_USERNAME` — seu nome de usuário do BrowserStack
- `BROWSERSTACK_ACCESS_KEY` — sua chave de acesso

Se não estiverem definidas, informe o usuário como obtê-las em [browserstack.com/accounts/settings](https://www.browserstack.com/accounts/settings) e pare.

## Capacidades

### 1. Configurar para BrowserStack

```
/pw:browserstack setup
```

Passos:
1. Verificar o `playwright.config.ts` atual
2. Adicionar opções de conexão BrowserStack:

```typescript
// Adicionar ao playwright.config.ts
import { defineConfig } from '@playwright/test';

const isBS = !!process.env.BROWSERSTACK_USERNAME;

export default defineConfig({
  // ... configuração existente
  projects: isBS ? [
    {
      name: "chromelatestwindows-11",
      use: {
        connectOptions: {
          wsEndpoint: `wss://cdp.browserstack.com/playwright?caps=${encodeURIComponent(JSON.stringify({
            'browser': 'chrome',
            'browser_version': 'latest',
            'os': 'Windows',
            'os_version': '11',
            'browserstack.username': process.env.BROWSERSTACK_USERNAME,
            'browserstack.accessKey': process.env.BROWSERSTACK_ACCESS_KEY,
          }))}`,
        },
      },
    },
    {
      name: "firefoxlatestwindows-11",
      use: {
        connectOptions: {
          wsEndpoint: `wss://cdp.browserstack.com/playwright?caps=${encodeURIComponent(JSON.stringify({
            'browser': 'playwright-firefox',
            'browser_version': 'latest',
            'os': 'Windows',
            'os_version': '11',
            'browserstack.username': process.env.BROWSERSTACK_USERNAME,
            'browserstack.accessKey': process.env.BROWSERSTACK_ACCESS_KEY,
          }))}`,
        },
      },
    },
    {
      name: "webkitlatestos-x-ventura",
      use: {
        connectOptions: {
          wsEndpoint: `wss://cdp.browserstack.com/playwright?caps=${encodeURIComponent(JSON.stringify({
            'browser': 'playwright-webkit',
            'browser_version': 'latest',
            'os': 'OS X',
            'os_version': 'Ventura',
            'browserstack.username': process.env.BROWSERSTACK_USERNAME,
            'browserstack.accessKey': process.env.BROWSERSTACK_ACCESS_KEY,
          }))}`,
        },
      },
    },
  ] : [
    // ... fallback de projetos locais
  ],
});
```

3. Adicionar script npm: `"test:e2e:cloud": "npx playwright test --project='chrome@*' --project='firefox@*' --project='webkit@*'"`

### 2. Executar Testes no BrowserStack

```
/pw:browserstack run
```

Passos:
1. Verificar se as credenciais estão definidas
2. Executar testes com projetos BrowserStack:
   ```bash
   BROWSERSTACK_USERNAME=$BROWSERSTACK_USERNAME \
   BROWSERSTACK_ACCESS_KEY=$BROWSERSTACK_ACCESS_KEY \
   npx playwright test --project='chrome@*' --project='firefox@*'
   ```
3. Monitorar execução
4. Reportar resultados por navegador

### 3. Obter Resultados do Build

```
/pw:browserstack results
```

Passos:
1. Chamar a ferramenta MCP `browserstack_get_builds`
2. Obter as sessões do build mais recente
3. Para cada sessão:
   - Status (passou/falhou)
   - Navegador e SO
   - Duração
   - URL do vídeo
   - URLs de logs
4. Formatar como tabela de resumo

### 4. Verificar Navegadores Disponíveis

```
/pw:browserstack browsers
```

Passos:
1. Chamar a ferramenta MCP `browserstack_get_browsers`
2. Filtrar para navegadores compatíveis com Playwright
3. Exibir combinações de navegador/SO disponíveis

### 5. Testes Locais

```
/pw:browserstack local
```

Para testar localhost ou staging atrás de firewall:
1. Instalar BrowserStack Local: `npm install -D browserstack-local`
2. Adicionar túnel local à config
3. Fornecer instruções de configuração

## Ferramentas MCP Utilizadas

| Ferramenta | Quando |
|---|---|
| `browserstack_get_plan` | Verificar limites da conta |
| `browserstack_get_browsers` | Listar navegadores disponíveis |
| `browserstack_get_builds` | Listar builds recentes |
| `browserstack_get_sessions` | Obter sessões em um build |
| `browserstack_get_session` | Obter detalhes da sessão (vídeo, logs) |
| `browserstack_update_session` | Marcar passou/falhou |
| `browserstack_get_logs` | Obter logs de texto/rede |

## Saída

- Tabela de resultados de testes cross-browser
- Status de passou/falhou por navegador
- Links para o painel BrowserStack para vídeo/capturas de tela
- Quaisquer falhas específicas de navegador destacadas
