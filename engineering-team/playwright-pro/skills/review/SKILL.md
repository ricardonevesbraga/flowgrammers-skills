---
name: "review"
description: >-
  Revisar testes Playwright para qualidade. Use quando o usuário disser "revisar testes",
  "verificar qualidade dos testes", "auditar testes", "melhorar testes", "revisão de código de testes"
  ou "verificação de melhores práticas do Playwright".
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Revisar Testes Playwright

Revisar sistematicamente arquivos de testes Playwright em busca de anti-padrões, melhores práticas não seguidas e lacunas de cobertura.

## Entrada

`$ARGUMENTS` pode ser:
- Um caminho de arquivo: revisar esse arquivo de teste específico
- Um diretório: revisar todos os arquivos de teste no diretório
- Vazio: revisar todos os testes no `testDir` do projeto

## Passos

### 1. Coletar Contexto

- Ler `playwright.config.ts` para as configurações do projeto
- Listar todos os arquivos `*.spec.ts` / `*.spec.js` no escopo
- Se estiver revisando um único arquivo, verificar também os page objects e fixtures relacionados

### 2. Verificar Cada Arquivo em Busca de Anti-Padrões

Carregar `anti-patterns.md` do diretório desta skill. Verificar todos os 20 anti-padrões.

**Críticos (obrigatório corrigir):**
1. Uso de `waitForTimeout()`
2. Asserções não web-first (`expect(await ...)`)
3. URLs hardcoded em vez de `baseURL`
4. Seletores CSS/XPath quando existe seletor baseado em role
5. `await` ausente em chamadas Playwright
6. Estado mutável compartilhado entre testes
7. Dependências na ordem de execução dos testes

**Aviso (deve corrigir):**
8. Testes com mais de 50 linhas (considere dividir)
9. Strings mágicas sem constantes nomeadas
10. Testes de casos de erro/borda ausentes
11. `page.evaluate()` para coisas que locators podem fazer
12. `test.describe()` aninhados com mais de 2 níveis de profundidade
13. Nomes de testes genéricos ("should work", "test 1")

**Informativo (considere):**
14. Sem page objects para páginas com 5+ locators
15. Dados de teste inline em vez de factory/fixture
16. Asserções de acessibilidade ausentes
17. Sem testes de regressão visual para páginas com muito UI
18. Asserções de erros de console não verificadas
19. Esperas por idle de rede em vez de asserções específicas
20. Agrupamento com `test.describe()` ausente

### 3. Pontuar Cada Arquivo

Avaliar de 1 a 10 com base em:
- **9-10**: Pronto para produção, segue todas as regras de ouro
- **7-8**: Bom, pequenas melhorias possíveis
- **5-6**: Funcional, mas tem anti-padrões
- **3-4**: Problemas significativos, provavelmente instável
- **1-2**: Precisa ser reescrito

### 4. Gerar Relatório de Revisão

Para cada arquivo:
```
## <nome_do_arquivo> — Pontuação: X/10

### Críticos
- Linha 15: `waitForTimeout(2000)` → use `expect(locator).toBeVisible()`
- Linha 28: Seletor CSS `.btn-submit` → `getByRole('button', { name: "submit" })`

### Avisos
- Linha 42: Nome do teste "test login" → "should redirect to dashboard after login"

### Sugestões
- Considere adicionar caso de erro: o que acontece com credenciais inválidas?
```

### 5. Para Revisão de Todo o Projeto

Se estiver revisando um suite de testes inteiro:
- Iniciar sub-agentes por arquivo para revisão paralela (até 5 simultâneos)
- Ou usar `/batch` para suites muito grandes
- Agregar resultados em uma tabela de resumo

### 6. Oferecer Correções

Para cada problema crítico, fornecer o código corrigido. Perguntar ao usuário: "Aplicar essas correções? [Sim/Não]"

Se sim, aplicar todas as correções usando a ferramenta `Edit`.

## Saída

- Revisão arquivo por arquivo com pontuações
- Resumo: total de arquivos, pontuação média, contagem de problemas críticos
- Lista de correções acionáveis
- Lacunas de cobertura identificadas (páginas/funcionalidades sem testes)
