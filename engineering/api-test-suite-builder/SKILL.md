---
name: "api-test-suite-builder"
description: "Use quando o usuário pede para gerar testes de API, criar suites de testes de integração, testar endpoints REST ou construir testes de contrato."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# API Test Suite Builder

**Nível:** POWERFUL
**Categoria:** Engineering
**Domínio:** Testing / Qualidade de API

---

## Visão Geral

Escaneia definições de rotas de API em diferentes frameworks (Next.js App Router, Express, FastAPI, Django REST) e
auto-gera suites de testes abrangentes cobrindo autenticação, validação de entrada, códigos de erro, paginação, uploads de
arquivo e limitação de taxa. Produz arquivos de teste prontos para execução com Vitest+Supertest (Node) ou Pytest+httpx
(Python).

---

## Capacidades Principais

- **Detecção de rotas** — escanear arquivos-fonte para extrair todos os endpoints de API
- **Cobertura de autenticação** — tokens válidos/inválidos/expirados, header de auth ausente
- **Validação de entrada** — campos ausentes, tipos errados, valores de limite, tentativas de injeção
- **Matriz de códigos de erro** — 400/401/403/404/422/500 para cada rota
- **Paginação** — primeira/última/vazia/páginas muito grandes
- **Uploads de arquivo** — válidos, muito grandes, tipo MIME errado, vazio
- **Rate limiting** — detecção de burst, limites por usuário vs. global

---

## Quando Usar

- Nova API adicionada — gerar scaffold de testes antes de escrever a implementação (TDD)
- API legada sem testes — escanear e gerar cobertura de baseline
- Revisão de contrato de API — verificar se os testes existentes correspondem às definições de rota atuais
- Verificação de regressão pré-release — garantir que todas as rotas tenham pelo menos testes de fumaça
- Preparação para auditoria de segurança — gerar testes de entrada adversariais

---

## Detecção de Rotas

### Next.js App Router
```bash
# Encontrar todos os handlers de rota
find ./app/api -name "route.ts" -o -name "route.js" | sort

# Extrair métodos HTTP de cada arquivo de rota
grep -rn "export async function\|export function" app/api/**/route.ts | \
  grep -oE "(GET|POST|PUT|PATCH|DELETE|HEAD|OPTIONS)" | sort -u

# Mapa completo de rotas
find ./app/api -name "route.ts" | while read f; do
  route=$(echo $f | sed 's|./app||' | sed 's|/route.ts||')
  methods=$(grep -oE "export (async )?function (GET|POST|PUT|PATCH|DELETE)" "$f" | \
    grep -oE "(GET|POST|PUT|PATCH|DELETE)")
  echo "$methods $route"
done
```

### Express
```bash
# Encontrar todos os arquivos de router
find ./src -name "*.ts" -o -name "*.js" | xargs grep -l "router\.\(get\|post\|put\|delete\|patch\)" 2>/dev/null

# Extrair rotas com números de linha
grep -rn "router\.\(get\|post\|put\|delete\|patch\)\|app\.\(get\|post\|put\|delete\|patch\)" \
  src/ --include="*.ts" | grep -oE "(get|post|put|delete|patch)\(['\"][^'\"]*['\"]"

# Gerar mapa de rotas
grep -rn "router\.\|app\." src/ --include="*.ts" | \
  grep -oE "\.(get|post|put|delete|patch)\(['\"][^'\"]+['\"]" | \
  sed "s/\.\(.*\)('\(.*\)'/\U\1 \2/"
```

### FastAPI
```bash
# Encontrar todos os decoradores de rota
grep -rn "@app\.\|@router\." . --include="*.py" | \
  grep -E "@(app|router)\.(get|post|put|delete|patch)"

# Extrair com path e nome da função
grep -rn "@\(app\|router\)\.\(get\|post\|put\|delete\|patch\)" . --include="*.py" | \
  grep -oE "@(app|router)\.(get|post|put|delete|patch)\(['\"][^'\"]*['\"]"
```

### Django REST Framework
```bash
# Extração de urlpatterns
grep -rn "path\|re_path\|url(" . --include="*.py" | grep "urlpatterns" -A 50 | \
  grep -E "path\(['\"]" | grep -oE "['\"][^'\"]+['\"]" | head -40

# Registro de router ViewSet
grep -rn "router\.register\|DefaultRouter\|SimpleRouter" . --include="*.py"
```

---

## Padrões de Geração de Testes

### Matriz de Testes de Autenticação

Para cada endpoint autenticado, gerar:

| Caso de Teste | Status Esperado |
|-----------|----------------|
| Sem header Authorization | 401 |
| Formato de token inválido | 401 |
| Token válido, papel de usuário errado | 403 |
| Token JWT expirado | 401 |
| Token válido, papel correto | 2xx |
| Token de usuário excluído | 401 |

### Matriz de Validação de Entrada

Para cada endpoint POST/PUT/PATCH com corpo de requisição:

| Caso de Teste | Status Esperado |
|-----------|----------------|
| Corpo vazio `{}` | 400 ou 422 |
| Campos obrigatórios ausentes (um por vez) | 400 ou 422 |
| Tipo errado (string onde int é esperado) | 400 ou 422 |
| Limite: valor em min-1 | 400 ou 422 |
| Limite: valor em min | 2xx |
| Limite: valor em max | 2xx |
| Limite: valor em max+1 | 400 ou 422 |
| Injeção SQL em campo string | 400 ou 200 (sanitizado) |
| Payload XSS em campo string | 400 ou 200 (sanitizado) |
| Valores null para campos obrigatórios | 400 ou 422 |

---

## Exemplos de Arquivos de Teste
→ Ver references/example-test-files.md para detalhes

## Gerando Testes a Partir do Escaneamento de Rotas

Quando dado uma base de código, siga este processo:

1. **Escanear rotas** usando os comandos de detecção acima
2. **Ler cada handler de rota** para entender:
   - Schema do corpo da requisição esperado
   - Requisitos de autenticação (middleware, decoradores)
   - Tipos de retorno e status codes
   - Regras de negócio (propriedade, verificações de papel)
3. **Gerar arquivo de teste** por grupo de rotas usando os padrões acima
4. **Nomear testes descritivamente**: `"retorna 401 quando o token está expirado"` não `"teste de auth 3"`
5. **Usar factories/fixtures** para dados de teste — nunca codificar IDs diretamente
6. **Verificar o shape da resposta**, não apenas o status code

---

## Armadilhas Comuns

- **Testar apenas caminhos felizes** — 80% dos bugs vivem nos caminhos de erro; teste esses primeiro
- **IDs de dados de teste codificados** — use factories/fixtures; IDs mudam entre ambientes
- **Estado compartilhado entre testes** — sempre limpe em afterEach/afterAll
- **Testar implementação, não comportamento** — teste o que a API retorna, não como ela faz
- **Testes de limite ausentes** — erros de um-a-mais são extremamente comuns em paginação e limites
- **Não testar expiração de token** — tokens expirados se comportam diferente de tokens inválidos
- **Ignorar Content-Type** — teste que a API rejeita tipos de conteúdo errados (xml quando json é esperado)

---

## Melhores Práticas

1. Um bloco describe por endpoint — mantém falhas isoladas e legíveis
2. Semeie dados mínimos — não carregue o banco inteiro; crie apenas o que o teste precisa
3. Use `beforeAll` para configuração compartilhada, `afterAll` para limpeza — não `beforeEach` para operações caras
4. Verifique mensagens/campos de erro específicos, não apenas status codes
5. Teste que campos sensíveis (senha, secret) nunca aparecem nas respostas
6. Para testes de autenticação, sempre teste o caso de "header ausente" separadamente de "token inválido"
7. Adicione testes de rate limit por último — podem interferir com outras suites de testes se executados em paralelo
