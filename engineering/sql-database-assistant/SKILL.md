---
name: "sql-database-assistant"
description: "Use quando o usuário pede para escrever queries SQL, otimizar desempenho de banco de dados, gerar migrações, explorar esquemas de banco de dados, ou trabalhar com ORMs como Prisma, Drizzle, TypeORM ou SQLAlchemy."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# SQL Database Assistant - Skill de Nível PODEROSO

## Visão Geral

O companheiro operacional para design de banco de dados. Enquanto **database-designer** foca na arquitetura de esquemas e **database-schema-designer** lida com modelagem ERD, esta skill cobre o dia a dia: escrever queries, otimizar desempenho, gerar migrações e fazer a ponte entre o código da aplicação e os motores de banco de dados.

### Capacidades Principais

- **Linguagem Natural para SQL** — traduzir requisitos em queries corretas e performáticas
- **Exploração de Esquema** — introspectar bancos de dados ao vivo em PostgreSQL, MySQL, SQLite, SQL Server
- **Otimização de Queries** — análise EXPLAIN, recomendações de índice, detecção de N+1, padrões de reescrita
- **Geração de Migração** — scripts up/down, estratégias de zero-downtime, planos de rollback
- **Integração com ORM** — padrões e escapes hatch para Prisma, Drizzle, TypeORM, SQLAlchemy
- **Suporte Multi-Banco** — SQL com awareness de dialeto e orientação de compatibilidade

### Ferramentas

| Script | Propósito |
|--------|---------|
| `scripts/query_optimizer.py` | Análise estática de queries SQL para problemas de desempenho |
| `scripts/migration_generator.py` | Gerar templates de arquivos de migração a partir de descrições de mudanças |
| `scripts/schema_explorer.py` | Gerar documentação de esquema a partir de queries de introspecção |

---

## Linguagem Natural para SQL

### Padrões de Tradução

Ao converter requisitos para SQL, siga esta sequência:

1. **Identificar entidades** — mapear substantivos para tabelas
2. **Identificar relacionamentos** — mapear verbos para JOINs ou subqueries
3. **Identificar filtros** — mapear adjetivos/condições para cláusulas WHERE
4. **Identificar agregações** — mapear "total", "média", "contagem" para GROUP BY
5. **Identificar ordenação** — mapear "top", "mais recente", "mais alto" para ORDER BY + LIMIT

### Templates Comuns de Queries

**Top-N por grupo (função de janela)**
```sql
SELECT * FROM (
  SELECT *, ROW_NUMBER() OVER (PARTITION BY department_id ORDER BY salary DESC) AS rn
  FROM employees
) ranked WHERE rn <= 3;
```

**Totais acumulados**
```sql
SELECT date, amount,
  SUM(amount) OVER (ORDER BY date ROWS BETWEEN UNBOUNDED PRECEDING AND CURRENT ROW) AS running_total
FROM transactions;
```

**Detecção de lacunas**
```sql
SELECT curr.id, curr.seq_num, prev.seq_num AS prev_seq
FROM records curr
LEFT JOIN records prev ON prev.seq_num = curr.seq_num - 1
WHERE prev.id IS NULL AND curr.seq_num > 1;
```

**UPSERT (PostgreSQL)**
```sql
INSERT INTO settings (key, value, updated_at)
VALUES ('theme', 'dark', NOW())
ON CONFLICT (key) DO UPDATE SET value = EXCLUDED.value, updated_at = EXCLUDED.updated_at;
```

**UPSERT (MySQL)**
```sql
INSERT INTO settings (key_name, value, updated_at)
VALUES ('theme', 'dark', NOW())
ON DUPLICATE KEY UPDATE value = VALUES(value), updated_at = VALUES(updated_at);
```

> Consulte references/query_patterns.md para JOINs, CTEs, funções de janela, operações JSON e muito mais.

---

## Exploração de Esquema

### Queries de Introspecção

**PostgreSQL — listar tabelas e colunas**
```sql
SELECT table_name, column_name, data_type, is_nullable, column_default
FROM information_schema.columns
WHERE table_schema = 'public'
ORDER BY table_name, ordinal_position;
```

**PostgreSQL — chaves estrangeiras**
```sql
SELECT tc.table_name, kcu.column_name,
  ccu.table_name AS foreign_table, ccu.column_name AS foreign_column
FROM information_schema.table_constraints tc
JOIN information_schema.key_column_usage kcu ON tc.constraint_name = kcu.constraint_name
JOIN information_schema.constraint_column_usage ccu ON tc.constraint_name = ccu.constraint_name
WHERE tc.constraint_type = 'FOREIGN KEY';
```

**MySQL — tamanhos de tabela**
```sql
SELECT table_name, table_rows,
  ROUND(data_length / 1024 / 1024, 2) AS data_mb,
  ROUND(index_length / 1024 / 1024, 2) AS index_mb
FROM information_schema.tables
WHERE table_schema = DATABASE()
ORDER BY data_length DESC;
```

**SQLite — dump de esquema**
```sql
SELECT name, sql FROM sqlite_master WHERE type = 'table' ORDER BY name;
```

**SQL Server — colunas com tipos**
```sql
SELECT t.name AS table_name, c.name AS column_name,
  ty.name AS data_type, c.max_length, c.is_nullable
FROM sys.columns c
JOIN sys.tables t ON c.object_id = t.object_id
JOIN sys.types ty ON c.user_type_id = ty.user_type_id
ORDER BY t.name, c.column_id;
```

### Gerando Documentação do Esquema

Use `scripts/schema_explorer.py` para produzir documentação em markdown ou JSON:

```bash
python scripts/schema_explorer.py --dialect postgres --tables all --format md
python scripts/schema_explorer.py --dialect mysql --tables users,orders --format json --json
```

---

## Otimização de Queries

### Fluxo de Trabalho de Análise EXPLAIN

1. **Executar EXPLAIN ANALYZE** (PostgreSQL) ou **EXPLAIN FORMAT=JSON** (MySQL)
2. **Identificar o nó mais custoso** — Seq Scan em tabelas grandes, Nested Loop com estimativas altas de linhas
3. **Verificar índices ausentes** — varreduras sequenciais em colunas filtradas
4. **Procurar erros de estimativa** — divergência entre linhas planejadas e reais sinaliza estatísticas desatualizadas
5. **Avaliar ordem de JOIN** — garantir que o menor conjunto de resultados direcione o join

### Lista de Verificação de Recomendação de Índice

- Colunas em cláusulas WHERE com alta seletividade
- Colunas em condições JOIN (chaves estrangeiras)
- Colunas em ORDER BY quando combinadas com LIMIT
- Índices compostos correspondendo a predicados WHERE de múltiplas colunas (coluna mais seletiva primeiro)
- Índices parciais para queries com filtros constantes (ex.: `WHERE status = 'active'`)
- Índices de cobertura para evitar lookups de tabela em queries de leitura intensa

### Padrões de Reescrita de Queries

| Anti-Padrão | Reescrita |
|-------------|---------|
| `SELECT * FROM orders` | `SELECT id, status, total FROM orders` (colunas explícitas) |
| `WHERE YEAR(created_at) = 2025` | `WHERE created_at >= '2025-01-01' AND created_at < '2026-01-01'` (sargável) |
| Subquery correlacionada no SELECT | LEFT JOIN com agregação |
| `NOT IN (SELECT ...)` com NULLs | `NOT EXISTS (SELECT 1 ...)` |
| `UNION` (dedup) quando não necessário | `UNION ALL` |
| `LIKE '%search%'` | Índice de busca full-text (GIN/FULLTEXT) |
| `ORDER BY RAND()` | Amostragem aleatória no lado da aplicação ou `TABLESAMPLE` |

### Detecção de N+1

**Sintomas:**
- Loop de aplicação que executa uma query por linha pai
- Carregamento lazy de ORM de entidades relacionadas dentro de um loop
- Log de queries mostra centenas de padrões SELECT idênticos com IDs diferentes

**Correções:**
- Usar carregamento eager (`include` no Prisma, `joinedload` no SQLAlchemy)
- Queries em lote com `WHERE id IN (...)`
- Usar padrão DataLoader para resolvers GraphQL

### Ferramenta de Análise Estática

```bash
python scripts/query_optimizer.py --query "SELECT * FROM orders WHERE status = 'pending'" --dialect postgres
python scripts/query_optimizer.py --query queries.sql --dialect mysql --json
```

> Consulte references/optimization_guide.md para leitura de planos EXPLAIN, tipos de índice e pooling de conexão.

---

## Geração de Migração

### Padrões de Migração com Zero Downtime

**Adicionar uma coluna (seguro)**
```sql
-- Up
ALTER TABLE users ADD COLUMN phone VARCHAR(20);

-- Down
ALTER TABLE users DROP COLUMN phone;
```

**Renomear uma coluna (expand-contract)**
```sql
-- Passo 1: Adicionar nova coluna
ALTER TABLE users ADD COLUMN full_name VARCHAR(255);
-- Passo 2: Preencher retroativamente
UPDATE users SET full_name = name;
-- Passo 3: Implantar app lendo ambas as colunas
-- Passo 4: Implantar app escrevendo apenas na nova coluna
-- Passo 5: Remover coluna antiga
ALTER TABLE users DROP COLUMN name;
```

**Adicionar uma coluna NOT NULL (sequência segura)**
```sql
-- Passo 1: Adicionar como nullable
ALTER TABLE orders ADD COLUMN region VARCHAR(50);
-- Passo 2: Preencher com padrão
UPDATE orders SET region = 'unknown' WHERE region IS NULL;
-- Passo 3: Adicionar restrição
ALTER TABLE orders ALTER COLUMN region SET NOT NULL;
ALTER TABLE orders ALTER COLUMN region SET DEFAULT 'unknown';
```

**Criação de índice (não-bloqueante, PostgreSQL)**
```sql
CREATE INDEX CONCURRENTLY idx_orders_status ON orders (status);
```

### Estratégias de Preenchimento de Dados

- **Atualizações em lote** — processar em blocos de 1000-10000 linhas para evitar contenção de lock
- **Jobs em background** — executar preenchimentos de forma assíncrona com rastreamento de progresso
- **Escrita dupla** — escrever em colunas antigas e novas durante o período de transição
- **Queries de validação** — verificar contagens de linhas e integridade de dados após cada lote

### Estratégias de Rollback

Toda migração deve ter um script down reversível. Para mudanças irreversíveis:

1. **Backup antes da execução** — `pg_dump` das tabelas afetadas
2. **Flags de funcionalidade** — a aplicação pode alternar entre leituras de esquema antigo/novo
3. **Tabelas sombra** — manter uma cópia da tabela original durante a janela de migração

### Ferramenta de Geração de Migração

```bash
python scripts/migration_generator.py --change "add email_verified boolean to users" --dialect postgres --format sql
python scripts/migration_generator.py --change "rename column name to full_name in customers" --dialect mysql --format alembic --json
```

---

## Suporte Multi-Banco

### Diferenças de Dialeto

| Funcionalidade | PostgreSQL | MySQL | SQLite | SQL Server |
|---------|-----------|-------|--------|------------|
| UPSERT | `ON CONFLICT DO UPDATE` | `ON DUPLICATE KEY UPDATE` | `ON CONFLICT DO UPDATE` | `MERGE` |
| Boolean | `BOOLEAN` nativo | `TINYINT(1)` | `INTEGER` | `BIT` |
| Auto-incremento | `SERIAL` / `GENERATED` | `AUTO_INCREMENT` | `INTEGER PRIMARY KEY` | `IDENTITY` |
| JSON | `JSONB` (indexado) | `JSON` | Text (ext) | `NVARCHAR(MAX)` |
| Array | `ARRAY` nativo | Não suportado | Não suportado | Não suportado |
| CTE (recursivo) | Suporte total | 8.0+ | 3.8.3+ | Suporte total |
| Funções de janela | Suporte total | 8.0+ | 3.25.0+ | Suporte total |
| Busca full-text | `tsvector` + GIN | Índice `FULLTEXT` | Extensão FTS5 | Catálogo full-text |
| LIMIT/OFFSET | `LIMIT n OFFSET m` | `LIMIT n OFFSET m` | `LIMIT n OFFSET m` | `OFFSET m ROWS FETCH NEXT n ROWS ONLY` |

### Dicas de Compatibilidade

- **Sempre use queries parametrizadas** — previne SQL injection em todos os dialetos
- **Evite funções específicas de dialeto no código compartilhado** — envolva em camada adaptadora
- **Testar migrações no motor de destino** — `information_schema` varia entre motores
- **Use formato de data ISO** — `'YYYY-MM-DD'` funciona em todos
- **Aspas em identificadores** — use aspas duplas (padrão SQL) ou backticks (MySQL)

---

## Padrões de ORM

### Prisma

**Definição de esquema**
```prisma
model User {
  id        Int      @id @default(autoincrement())
  email     String   @unique
  name      String?
  posts     Post[]
  createdAt DateTime @default(now())
}

model Post {
  id       Int    @id @default(autoincrement())
  title    String
  author   User   @relation(fields: [authorId], references: [id])
  authorId Int
}
```

**Migrações**: `npx prisma migrate dev --name add_user_email`
**API de Query**: `prisma.user.findMany({ where: { email: { contains: '@' } }, include: { posts: true } })`
**Escape hatch para SQL bruto**: `prisma.$queryRaw\`SELECT * FROM users WHERE id = ${userId}\``

### Drizzle

**Definição schema-first**
```typescript
export const users = pgTable('users', {
  id: serial('id').primaryKey(),
  email: varchar('email', { length: 255 }).notNull().unique(),
  name: text('name'),
  createdAt: timestamp('created_at').defaultNow(),
});
```

**Query builder**: `db.select().from(users).where(eq(users.email, email))`
**Migrações**: `npx drizzle-kit generate:pg` depois `npx drizzle-kit push:pg`

### TypeORM

**Decoradores de entidade**
```typescript
@Entity()
export class User {
  @PrimaryGeneratedColumn()
  id: number;

  @Column({ unique: true })
  email: string;

  @OneToMany(() => Post, post => post.author)
  posts: Post[];
}
```

**Padrão de repositório**: `userRepo.find({ where: { email }, relations: ['posts'] })`
**Migrações**: `npx typeorm migration:generate -n AddUserEmail`

### SQLAlchemy

**Modelos declarativos**
```python
class User(Base):
    __tablename__ = 'users'
    id = Column(Integer, primary_key=True)
    email = Column(String(255), unique=True, nullable=False)
    name = Column(String(255))
    posts = relationship('Post', back_populates='author')
```

**Gerenciamento de sessão**: Sempre use `with Session() as session:` como gerenciador de contexto
**Migrações Alembic**: `alembic revision --autogenerate -m "add user email"`

> Consulte references/orm_patterns.md para comparações lado a lado e fluxos de trabalho de migração por ORM.

---

## Integridade de Dados

### Estratégia de Restrições

- **Chaves primárias** — toda tabela deve ter uma; prefira chaves substitutas (serial/UUID)
- **Chaves estrangeiras** — aplicar integridade referencial; definir comportamento ON DELETE explicitamente
- **Restrições UNIQUE** — para unicidade de nível de negócio (email, slug, chave de API)
- **Restrições CHECK** — validar intervalos, enums e regras de negócio no nível do BD
- **NOT NULL** — padrão para NOT NULL; tornar nullable apenas quando genuinamente opcional

### Níveis de Isolamento de Transação

| Nível | Leitura Suja | Leitura Não-Repetível | Leitura Fantasma | Caso de Uso |
|-------|-----------|-------------------|-------------|----------|
| READ UNCOMMITTED | Sim | Sim | Sim | Nunca recomendado |
| READ COMMITTED | Não | Sim | Sim | Padrão para PostgreSQL, OLTP geral |
| REPEATABLE READ | Não | Não | Sim (InnoDB: Não) | Cálculos financeiros |
| SERIALIZABLE | Não | Não | Não | Consistência crítica (faturamento, estoque) |

### Prevenção de Deadlock

1. **Ordem consistente de lock** — sempre adquirir locks na mesma ordem de tabela/linha
2. **Transações curtas** — minimizar o tempo entre o primeiro lock e o commit
3. **Locks Advisory** — usar `pg_advisory_lock()` para coordenação no nível da aplicação
4. **Lógica de retry** — capturar erros de deadlock e fazer retry com backoff exponencial

---

## Backup e Restauração

### PostgreSQL
```bash
# Backup completo
pg_dump -Fc --no-owner dbname > backup.dump
# Restauração
pg_restore -d dbname --clean --no-owner backup.dump
# Recuperação ponto-no-tempo: configurar arquivamento WAL + restore_command
```

### MySQL
```bash
# Backup completo
mysqldump --single-transaction --routines --triggers dbname > backup.sql
# Restauração
mysql dbname < backup.sql
# Log binário para PITR: mysqlbinlog --start-datetime="2025-01-01 00:00:00" binlog.000001
```

### SQLite
```bash
# Backup (seguro com leituras concorrentes)
sqlite3 dbname ".backup backup.db"
```

### Melhores Práticas de Backup
- **Automatizar** — cron ou systemd timer, nunca apenas manual
- **Testar restaurações** — backups não testados não são backups
- **Cópias offsite** — S3, GCS ou região separada
- **Política de retenção** — diário por 7 dias, semanal por 4 semanas, mensal por 12 meses
- **Monitorar tamanho e duração do backup** — mudanças repentinas sinalizam problemas

---

## Anti-Padrões

| Anti-Padrão | Problema | Correção |
|-------------|---------|-----|
| `SELECT *` | Transfere dados desnecessários, quebra em mudanças de esquema | Lista explícita de colunas |
| Índices ausentes em colunas FK | JOINs lentos e exclusões em cascata | Adicionar índices em todas as chaves estrangeiras |
| Queries N+1 | 1 + N round trips para o banco de dados | Carregamento eager ou queries em lote |
| Coerção de tipo implícita | `WHERE id = '123'` impede uso de índice | Corresponder tipos em predicados |
| Sem pooling de conexão | Esgota conexões sob carga | PgBouncer, ProxySQL ou pool do ORM |
| Queries ilimitadas | Sem LIMIT arrrisca retornar milhões de linhas | Sempre paginar |
| Armazenar dinheiro como FLOAT | Erros de arredondamento | Usar `DECIMAL(19,4)` ou centavos como inteiro |
| Tabelas deus | Uma tabela com 50+ colunas | Normalizar ou usar particionamento vertical |
| Soft deletes em todo lugar | Complica toda query com `WHERE deleted_at IS NULL` | Tabelas de arquivo ou event sourcing |
| Concatenação de string bruta | SQL injection | Sempre usar queries parametrizadas |

---

## Referências Cruzadas

| Skill | Relacionamento |
|-------|-------------|
| **database-designer** | Arquitetura de esquema, análise de normalização, geração ERD |
| **database-schema-designer** | Modelagem visual ERD, mapeamento de relacionamentos |
| **migration-architect** | Orquestração de migração complexa em múltiplos passos |
| **api-design-reviewer** | Garantir que endpoints de API se alinhem com padrões de query |
| **observability-designer** | Monitoramento de desempenho de queries, alertas de query lenta |
