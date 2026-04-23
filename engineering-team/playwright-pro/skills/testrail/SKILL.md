---
name: "testrail"
description: >-
  Sincronizar testes com TestRail. Use quando o usuário mencionar "testrail", "gestão de testes",
  "casos de teste", "execução de testes", "sincronizar casos de teste", "enviar resultados para testrail"
  ou "importar do testrail".
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Integração com TestRail

Sincronização bidirecional entre testes Playwright e o gerenciamento de testes TestRail.

## Pré-requisitos

As variáveis de ambiente devem estar configuradas:
- `TESTRAIL_URL` — ex.: `https://sua-instancia.testrail.io`
- `TESTRAIL_USER` — seu e-mail
- `TESTRAIL_API_KEY` — chave de API do TestRail

Se não estiverem configuradas, informar ao usuário como configurá-las e parar.

## Capacidades

### 1. Importar Casos de Teste → Gerar Testes Playwright

```
/pw:testrail import --project <id> --suite <id>
```

Passos:
1. Chamar a ferramenta MCP `testrail_get_cases` para buscar os casos de teste
2. Para cada caso de teste:
   - Ler título, pré-condições, passos, resultados esperados
   - Mapear para um teste Playwright usando o template apropriado
   - Incluir o ID do caso TestRail como anotação do teste: `test.info().annotations.push({ type: 'testrail', description: 'C12345' })`
3. Gerar arquivos de teste agrupados por seção
4. Relatório: X casos importados, Y testes gerados

### 2. Enviar Resultados de Testes → TestRail

```
/pw:testrail push --run <id>
```

Passos:
1. Executar testes Playwright com o reporter JSON:
   ```bash
   npx playwright test --reporter=json > test-results.json
   ```
2. Analisar resultados: mapear cada teste para seu ID de caso TestRail (das anotações)
3. Chamar a ferramenta MCP `testrail_add_result` para cada teste:
   - Aprovado → status_id: 1
   - Reprovado → status_id: 5, incluir mensagem de erro
   - Pulado → status_id: 2
4. Relatório: X resultados enviados, Y aprovados, Z reprovados

### 3. Criar Execução de Testes

```
/pw:testrail run --project <id> --name "Sprint 42 Regression"
```

Passos:
1. Chamar a ferramenta MCP `testrail_add_run`
2. Incluir todos os IDs de casos de teste encontrados nas anotações dos testes Playwright
3. Retornar o ID da execução para envio de resultados

### 4. Status de Sincronização

```
/pw:testrail status --project <id>
```

Passos:
1. Buscar casos de teste do TestRail
2. Escanear testes Playwright locais por anotações TestRail
3. Reportar cobertura:
   ```
   Casos TestRail: 150
   Testes Playwright com IDs TestRail: 120
   Casos TestRail sem vínculo: 30
   Testes Playwright sem IDs TestRail: 15
   ```

### 5. Atualizar Casos de Teste no TestRail

```
/pw:testrail update --case <id>
```

Passos:
1. Ler o teste Playwright para este ID de caso
2. Extrair passos e resultados esperados do código de teste
3. Chamar a ferramenta MCP `testrail_update_case` para atualizar os passos

## Ferramentas MCP Utilizadas

| Ferramenta | Quando |
|---|---|
| `testrail_get_projects` | Listar projetos disponíveis |
| `testrail_get_suites` | Listar suites no projeto |
| `testrail_get_cases` | Ler casos de teste |
| `testrail_add_case` | Criar novo caso de teste |
| `testrail_update_case` | Atualizar caso existente |
| `testrail_add_run` | Criar execução de testes |
| `testrail_add_result` | Enviar resultado individual |
| `testrail_get_results` | Ler resultados históricos |

## Formato de Anotação de Teste

Todos os testes Playwright vinculados ao TestRail incluem:

```typescript
test('should login successfully', async ({ page }) => {
  test.info().annotations.push({
    type: 'testrail',
    description: 'C12345',
  });
  // ... código do teste
});
```

Esta anotação é a ponte entre Playwright e TestRail.

## Saída

- Resumo da operação com contagens
- Quaisquer erros ou casos sem correspondência
- Link para a execução/resultados no TestRail
