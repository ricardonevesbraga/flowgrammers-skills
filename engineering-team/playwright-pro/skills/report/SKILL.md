---
name: "report"
description: >-
  Gerar relatório de testes. Use quando o usuário disser "relatório de testes", "resumo de resultados",
  "status dos testes", "mostrar resultados", "painel de testes" ou "como foram os testes".
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Relatório Inteligente de Testes

Gerar relatórios de testes que se integram ao fluxo de trabalho existente do usuário. Sem novas ferramentas.

## Passos

### 1. Executar Testes (Se Ainda Não Executados)

Verificar se existem resultados recentes:

```bash
ls -la test-results/ playwright-report/ 2>/dev/null
```

Se não houver resultados recentes, executar os testes:

```bash
npx playwright test --reporter=json,html,list 2>&1 | tee test-output.log
```

### 2. Analisar Resultados

Ler o relatório JSON:

```bash
npx playwright test --reporter=json 2> /dev/null
```

Extrair:
- Total de testes, aprovados, reprovados, pulados, instáveis
- Duração por teste e total
- Nomes dos testes reprovados com mensagens de erro
- Testes instáveis (aprovados na nova tentativa)

### 3. Detectar Destino do Relatório

Verificar o que está configurado e rotear automaticamente:

| Verificar | Se encontrado | Ação |
|---|---|---|
| Variável de ambiente `TESTRAIL_URL` | TestRail configurado | Enviar resultados via `/pw:testrail push` |
| Variável de ambiente `SLACK_WEBHOOK_URL` | Slack configurado | Postar resumo no Slack |
| `.github/workflows/` | GitHub Actions | Resultados vão para comentário de PR via artifacts |
| `playwright-report/` | Reporter HTML | Abrir ou servir o relatório |
| Nenhuma das opções acima | Padrão | Gerar relatório em markdown |

### 4. Gerar Relatório

#### Relatório em Markdown (Sempre Gerado)

```markdown
# Resultados dos Testes — {{date}}

## Resumo
- ✅ Aprovados: {{passed}}
- ❌ Reprovados: {{failed}}
- ⏭️ Pulados: {{skipped}}
- 🔄 Instáveis: {{flaky}}
- ⏱️ Duração: {{duration}}

## Testes Reprovados
| Teste | Erro | Arquivo |
|---|---|---|
| {{name}} | {{error}} | {{file}}:{{line}} |

## Testes Instáveis
| Teste | Tentativas | Arquivo |
|---|---|---|
| {{name}} | {{retries}} | {{file}} |

## Por Projeto
| Navegador | Aprovados | Reprovados | Duração |
|---|---|---|---|
| Chromium | X | Y | Zs |
| Firefox | X | Y | Zs |
| WebKit | X | Y | Zs |
```

Salvar em `test-reports/{{date}}-report.md`.

#### Resumo no Slack (Se Webhook Configurado)

```bash
curl -X POST "$SLACK_WEBHOOK_URL" \
  -H 'Content-Type: application/json' \
  -d '{
    "text": "🧪 Resultados dos Testes: ✅ {{passed}} | ❌ {{failed}} | ⏱️ {{duration}}\n{{failed_details}}"
  }'
```

#### Envio ao TestRail (Se Configurado)

Invocar `/pw:testrail push` com os resultados JSON.

#### Relatório HTML

```bash
npx playwright show-report
```

Ou se estiver em CI:
```bash
echo "Relatório HTML disponível em: playwright-report/index.html"
```

### 5. Análise de Tendências (Se Houver Dados Históricos)

Se existirem relatórios anteriores em `test-reports/`:
- Comparar taxa de aprovação ao longo do tempo
- Identificar testes que ficaram instáveis recentemente
- Destacar novas falhas vs. falhas recorrentes

## Saída

- Resumo com contagens de aprovação/reprovação/pulado/instável
- Detalhes dos testes reprovados com mensagens de erro
- Confirmação do destino do relatório
- Comparação de tendências (se dados históricos disponíveis)
- Recomendação de próxima ação (corrigir falhas ou celebrar os resultados verdes)
