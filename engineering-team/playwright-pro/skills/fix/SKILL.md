---
name: "fix"
description: >-
  Corrija testes Playwright com falha ou instáveis. Use quando o usuário disser "corrigir teste",
  "teste instável", "teste falhando", "depurar teste", "teste quebrado", "teste passa
  às vezes" ou "falha intermitente".
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Corrigir Testes com Falha ou Instáveis

Diagnosticar e corrigir um teste Playwright que falha ou passa intermitentemente usando uma taxonomia sistemática.

## Entrada

`$ARGUMENTS` contém:
- Um caminho de arquivo de teste: `e2e/login.spec.ts`
- Um nome de teste: `"should redirect after login"`
- Uma descrição: `"o teste de checkout falha no CI mas passa localmente"`

## Passos

### 1. Reproduzir a Falha

Executar o teste para capturar o erro:

```bash
npx playwright test <arquivo> --reporter=list
```

Se o teste passar, provavelmente é instável. Executar burn-in:

```bash
npx playwright test <arquivo> --repeat-each=10 --reporter=list
```

Se ainda passar, tentar com workers paralelos:

```bash
npx playwright test --fully-parallel --workers=4 --repeat-each=5
```

### 2. Capturar Trace

Executar com rastreamento completo:

```bash
npx playwright test <arquivo> --trace=on --retries=0
```

Ler a saída do trace. Use `/debug` para analisar arquivos de trace se disponível.

### 3. Categorizar a Falha

Carregar `flaky-taxonomy.md` deste diretório de skill.

Todo teste com falha se enquadra em uma das quatro categorias:

| Categoria | Sintoma | Diagnóstico |
|---|---|---|
| **Timing/Async** | Falha intermitentemente em todo lugar | `--repeat-each=20` reproduz localmente |
| **Isolamento de Teste** | Falha na suite, passa sozinho | `--workers=1 --grep "nome do teste"` passa |
| **Ambiente** | Falha no CI, passa localmente | Comparar capturas de tela/traces CI vs local |
| **Infraestrutura** | Aleatório, sem padrão | Erro referencia internos do navegador |

### 4. Aplicar Correção Direcionada

**Timing/Async:**
- Substituir `waitForTimeout()` por asserções web-first
- Adicionar `await` a chamadas Playwright ausentes
- Aguardar respostas de rede específicas antes de asserir
- Usar `toBeVisible()` antes de interagir com elementos

**Isolamento de Teste:**
- Remover estado mutável compartilhado entre testes
- Criar dados de teste por teste via API ou fixtures
- Usar identificadores únicos (timestamps, strings aleatórias) para dados de teste
- Verificar vazamentos de estado de banco de dados

**Ambiente:**
- Corresponder tamanhos de viewport entre local e CI
- Considerar diferenças de renderização de fonte em capturas de tela
- Usar `docker` localmente para corresponder ao ambiente CI
- Verificar asserções dependentes de fuso horário

**Infraestrutura:**
- Aumentar timeout para runners CI lentos
- Adicionar retries na config CI (`retries: 2`)
- Verificar OOM do navegador (reduzir workers paralelos)
- Garantir que as dependências do navegador estejam instaladas

### 5. Verificar a Correção

Executar o teste 10 vezes para confirmar estabilidade:

```bash
npx playwright test <arquivo> --repeat-each=10 --reporter=list
```

Todos os 10 devem passar. Se algum falhar, voltar ao passo 3.

### 6. Prevenir Recorrência

Sugerir:
- Adicionar ao CI com `retries: 2` se ainda não estiver
- Habilitar `trace: 'on-first-retry'` na config
- Adicionar o padrão de correção ao documento de convenções de teste do projeto

## Saída

- Categoria da causa raiz e problema específico
- A correção aplicada (com diff)
- Resultado de verificação (10/10 aprovações)
- Recomendação de prevenção
