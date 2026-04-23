---
name: "senior-backend"
description: "Projeta e implementa sistemas backend incluindo REST APIs, microsserviços, arquiteturas de banco de dados, fluxos de autenticação e hardening de segurança. Use quando o usuário pedir para 'design REST APIs', 'optimize database queries', 'implement authentication', 'build microsserviços', 'review backend code', 'set up GraphQL', 'handle database migrations', ou 'load test APIs'. Cobre desenvolvimento Node.js/Express/Fastify, otimização PostgreSQL, segurança de API e padrões de arquitetura backend."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Engenheiro Backend Sênior

Padrões de desenvolvimento backend, design de API, otimização de banco de dados e práticas de segurança.

---

## Início Rápido

```bash
# Gerar rotas de API a partir da spec OpenAPI
python scripts/api_scaffolder.py openapi.yaml --framework express --output src/routes/

# Analisar schema de banco de dados e gerar migrações
python scripts/database_migration_tool.py --connection postgres://localhost/mydb --analyze

# Teste de carga em um endpoint de API
python scripts/api_load_tester.py https://api.example.com/users --concurrency 50 --duration 30
```

---

## Visão Geral das Ferramentas

### 1. API Scaffolder

Gera handlers de rotas de API, middleware e especificações OpenAPI a partir de definições de schema.

**Entrada:** Spec OpenAPI (YAML/JSON) ou schema de banco de dados
**Saída:** Handlers de rota, middleware de validação, tipos TypeScript

**Uso:**
```bash
# Gerar rotas Express a partir da spec OpenAPI
python scripts/api_scaffolder.py openapi.yaml --framework express --output src/routes/
# Saída: Generated 12 route handlers, validation middleware, and TypeScript types

# Gerar a partir do schema do banco de dados
python scripts/api_scaffolder.py --from-db postgres://localhost/mydb --output src/routes/

# Gerar spec OpenAPI a partir de rotas existentes
python scripts/api_scaffolder.py src/routes/ --generate-spec --output openapi.yaml
```

**Frameworks Suportados:**
- Express.js (`--framework express`)
- Fastify (`--framework fastify`)
- Koa (`--framework koa`)

---

### 2. Ferramenta de Migração de Banco de Dados

Analisa schemas de banco de dados, detecta mudanças e gera arquivos de migração com suporte a rollback.

**Entrada:** String de conexão do banco de dados ou arquivos de schema
**Saída:** Arquivos de migração, relatório de diff de schema, sugestões de otimização

**Uso:**
```bash
# Analisar schema atual e sugerir otimizações
python scripts/database_migration_tool.py --connection postgres://localhost/mydb --analyze
# Saída: Missing indexes, N+1 query risks, and suggested migration files

# Gerar migração a partir do diff de schema
python scripts/database_migration_tool.py --connection postgres://localhost/mydb \
  --compare schema/v2.sql --output migrations/

# Executar migração em modo dry-run
python scripts/database_migration_tool.py --connection postgres://localhost/mydb \
  --migrate migrations/20240115_add_user_indexes.sql --dry-run
```

---

### 3. Testador de Carga de API

Realiza teste de carga HTTP com concorrência configurável, medindo percentis de latência e throughput.

**Entrada:** URL do endpoint de API e configuração do teste
**Saída:** Relatório de desempenho com distribuição de latência, taxas de erro, métricas de throughput

**Uso:**
```bash
# Teste de carga básico
python scripts/api_load_tester.py https://api.example.com/users --concurrency 50 --duration 30
# Saída: Throughput (req/sec), latency percentiles (P50/P95/P99), error counts, and scaling recommendations

# Testar com headers e body personalizados
python scripts/api_load_tester.py https://api.example.com/orders \
  --method POST \
  --header "Authorization: Bearer token123" \
  --body '{"product_id": 1, "quantity": 2}' \
  --concurrency 100 \
  --duration 60

# Comparar dois endpoints
python scripts/api_load_tester.py https://api.example.com/v1/users https://api.example.com/v2/users \
  --compare --concurrency 50 --duration 30
```

---

## Fluxos de Trabalho de Desenvolvimento Backend

### Fluxo de Trabalho de Design de API

Use quando projetar uma nova API ou refatorar endpoints existentes.

**Passo 1: Definir recursos e operações**
```yaml
# openapi.yaml
openapi: 3.0.3
info:
  title: User Service API
  version: 1.0.0
paths:
  /users:
    get:
      summary: Listar usuários
      parameters:
        - name: "limit"
          in: query
          schema:
            type: integer
            default: 20
    post:
      summary: Criar usuário
      requestBody:
        required: true
        content:
          application/json:
            schema:
              $ref: '#/components/schemas/CreateUser'
```

**Passo 2: Gerar scaffolding de rotas**
```bash
python scripts/api_scaffolder.py openapi.yaml --framework express --output src/routes/
```

**Passo 3: Implementar lógica de negócio**
```typescript
// src/routes/users.ts (gerado, depois personalizado)
export const createUser = async (req: Request, res: Response) => {
  const { email, name } = req.body;

  // Adicionar lógica de negócio
  const user = await userService.create({ email, name });

  res.status(201).json(user);
};
```

**Passo 4: Adicionar middleware de validação**
```bash
# Validação é auto-gerada a partir do schema OpenAPI
# src/middleware/validators.ts inclui:
# - Validação do corpo da requisição
# - Validação de parâmetros de query
# - Validação de parâmetros de caminho
```

**Passo 5: Gerar spec OpenAPI atualizada**
```bash
python scripts/api_scaffolder.py src/routes/ --generate-spec --output openapi.yaml
```

---

### Fluxo de Trabalho de Otimização de Banco de Dados

Use quando as queries estão lentas ou o desempenho do banco de dados precisa de melhoria.

**Passo 1: Analisar o desempenho atual**
```bash
python scripts/database_migration_tool.py --connection $DATABASE_URL --analyze
```

**Passo 2: Identificar queries lentas**
```sql
-- Verificar planos de execução de queries
EXPLAIN ANALYZE SELECT * FROM orders
WHERE user_id = 123
ORDER BY created_at DESC
LIMIT 10;

-- Procurar: Seq Scan (ruim), Index Scan (bom)
```

**Passo 3: Gerar migrações de índice**
```bash
python scripts/database_migration_tool.py --connection $DATABASE_URL \
  --suggest-indexes --output migrations/
```

**Passo 4: Testar migração (dry-run)**
```bash
python scripts/database_migration_tool.py --connection $DATABASE_URL \
  --migrate migrations/add_indexes.sql --dry-run
```

**Passo 5: Aplicar e verificar**
```bash
# Aplicar migração
python scripts/database_migration_tool.py --connection $DATABASE_URL \
  --migrate migrations/add_indexes.sql

# Verificar melhoria
python scripts/database_migration_tool.py --connection $DATABASE_URL --analyze
```

---

### Fluxo de Trabalho de Hardening de Segurança

Use ao preparar uma API para produção ou após uma revisão de segurança.

**Passo 1: Revisar configuração de autenticação**
```typescript
// Verificar configuração JWT
const jwtConfig = {
  secret: process.env.JWT_SECRET,  // Deve vir do env, nunca hardcoded
  expiresIn: '1h',                 // Tokens de curta duração
  algorithm: 'RS256'               // Preferir assimétrico
};
```

**Passo 2: Adicionar limitação de taxa**
```typescript
import rateLimit from 'express-rate-limit';

const apiLimiter = rateLimit({
  windowMs: 15 * 60 * 1000,  // 15 minutos
  max: 100,                   // 100 requisições por janela
  standardHeaders: true,
  legacyHeaders: false,
});

app.use('/api/', apiLimiter);
```

**Passo 3: Validar todas as entradas**
```typescript
import { z } from 'zod';

const CreateUserSchema = z.object({
  email: z.string().email().max(255),
  name: z.string().min(1).max(100),
  age: z.number().int().positive().optional()
});

// Usar no handler de rota
const data = CreateUserSchema.parse(req.body);
```

**Passo 4: Teste de carga com padrões de ataque**
```bash
# Testar limitação de taxa
python scripts/api_load_tester.py https://api.example.com/login \
  --concurrency 200 --duration 10 --expect-rate-limit

# Testar validação de entrada
python scripts/api_load_tester.py https://api.example.com/users \
  --method POST \
  --body '{"email": "not-an-email"}' \
  --expect-status 400
```

**Passo 5: Revisar cabeçalhos de segurança**
```typescript
import helmet from 'helmet';

app.use(helmet({
  contentSecurityPolicy: true,
  crossOriginEmbedderPolicy: true,
  crossOriginOpenerPolicy: true,
  crossOriginResourcePolicy: true,
  hsts: { maxAge: 31536000, includeSubDomains: true },
}));
```

---

## Documentação de Referência

| Arquivo | Contém | Use Quando |
|------|----------|----------|
| `references/api_design_patterns.md` | REST vs GraphQL, versionamento, tratamento de erros, paginação | Projetando novas APIs |
| `references/database_optimization_guide.md` | Estratégias de indexação, otimização de queries, soluções N+1 | Corrigindo queries lentas |
| `references/backend_security_practices.md` | OWASP Top 10, padrões de autenticação, validação de entrada | Hardening de segurança |

---

## Referência Rápida de Padrões Comuns

### Formato de Resposta REST
```json
{
  "data": { "id": 1, "name": "John" },
  "meta": { "requestId": "abc-123" }
}
```

### Formato de Resposta de Erro
```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "Invalid email format",
    "details": [{ "field": "email", "message": "must be valid email" }]
  },
  "meta": { "requestId": "abc-123" }
}
```

### Códigos de Status HTTP
| Código | Caso de Uso |
|------|----------|
| 200 | Sucesso (GET, PUT, PATCH) |
| 201 | Criado (POST) |
| 204 | Sem Conteúdo (DELETE) |
| 400 | Erro de validação |
| 401 | Autenticação necessária |
| 403 | Permissão negada |
| 404 | Recurso não encontrado |
| 429 | Limite de taxa excedido |
| 500 | Erro interno do servidor |

### Estratégia de Índice de Banco de Dados
```sql
-- Coluna única (buscas por igualdade)
CREATE INDEX idx_users_email ON users(email);

-- Composto (queries multi-coluna)
CREATE INDEX idx_orders_user_status ON orders(user_id, status);

-- Parcial (queries filtradas)
CREATE INDEX idx_orders_active ON orders(created_at) WHERE status = 'active';

-- Cobrindo (evitar busca na tabela)
CREATE INDEX idx_users_email_name ON users(email) INCLUDE (name);
```

---

## Comandos Comuns

```bash
# Desenvolvimento de API
python scripts/api_scaffolder.py openapi.yaml --framework express
python scripts/api_scaffolder.py src/routes/ --generate-spec

# Operações de Banco de Dados
python scripts/database_migration_tool.py --connection $DATABASE_URL --analyze
python scripts/database_migration_tool.py --connection $DATABASE_URL --migrate file.sql

# Testes de Desempenho
python scripts/api_load_tester.py https://api.example.com/endpoint --concurrency 50
python scripts/api_load_tester.py https://api.example.com/endpoint --compare baseline.json
```
