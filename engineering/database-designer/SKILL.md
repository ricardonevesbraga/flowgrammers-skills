---
name: "database-designer"
description: "Use quando o usuário pedir para projetar schemas de banco de dados, planejar migrações de dados, otimizar queries, escolher entre SQL e NoSQL, ou modelar relacionamentos de dados."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Database Designer - Skill de Nível PODEROSO

## Visão Geral

Uma skill abrangente de design de banco de dados que fornece análise em nível de especialista, otimização e capacidades de migração para sistemas de banco de dados modernos. Esta skill combina princípios teóricos com ferramentas práticas para ajudar arquitetos e desenvolvedores a criar schemas de banco de dados escaláveis, performáticos e mantíveis.

## Competências Principais

### Design e Análise de Schema
- **Análise de Normalização**: Detecção automatizada de níveis de normalização (1NF a BCNF)
- **Estratégia de Desnormalização**: Recomendações inteligentes para otimização de performance
- **Otimização de Tipos de Dados**: Identificação de tipos inadequados e problemas de tamanho
- **Análise de Restrições**: Foreign keys ausentes, restrições únicas e verificações de nulos
- **Validação de Convenções de Nomenclatura**: Padrões consistentes de nomenclatura de tabelas e colunas
- **Geração de ERD**: Criação automática de diagrama Mermaid a partir de DDL

### Otimização de Índices
- **Análise de Lacunas de Índice**: Identificação de índices ausentes em foreign keys e padrões de query
- **Estratégia de Índice Composto**: Ordenação ótima de colunas para índices multi-coluna
- **Detecção de Redundância de Índice**: Eliminação de índices sobrepostos e não utilizados
- **Modelagem de Impacto de Performance**: Estimativa de seletividade e análise de custo de query
- **Seleção de Tipo de Índice**: B-tree, hash, parcial, covering e índices especializados

### Gerenciamento de Migrações
- **Migrações sem Downtime**: Implementação do padrão expand-contract
- **Evolução de Schema**: Adições, exclusões e mudanças de tipo de coluna seguras
- **Scripts de Migração de Dados**: Transformação e validação automatizadas de dados
- **Estratégia de Rollback**: Capacidades completas de reversão com validação
- **Planejamento de Execução**: Passos de migração ordenados com resolução de dependência

## Princípios de Design de Banco de Dados
→ Veja references/database-design-reference.md para detalhes

## Melhores Práticas

### Design de Schema
1. **Use nomes significativos**: Convenções de nomenclatura claras e consistentes
2. **Escolha tipos de dados apropriados**: Colunas do tamanho certo para eficiência de armazenamento
3. **Defina restrições adequadas**: Foreign keys, check constraints, índices únicos
4. **Considere crescimento futuro**: Planeje para escala desde o início
5. **Documente relacionamentos**: Relacionamentos claros de foreign key e regras de negócio

### Otimização de Performance
1. **Indexe estrategicamente**: Cubra padrões de query comuns sem over-indexar
2. **Monitore a performance de queries**: Análise regular de queries lentas
3. **Particione tabelas grandes**: Melhore a performance de queries e manutenção
4. **Use níveis de isolamento apropriados**: Balance consistência com performance
5. **Implemente connection pooling**: Utilização eficiente de recursos

### Considerações de Segurança
1. **Princípio do menor privilégio**: Conceda permissões mínimas necessárias
2. **Criptografe dados sensíveis**: Em repouso e em trânsito
3. **Audite padrões de acesso**: Monitore e registre o acesso ao banco de dados
4. **Valide entradas**: Previna ataques de SQL injection
5. **Atualizações de segurança regulares**: Mantenha o software de banco de dados atualizado

## Padrões de Geração de Query

### SELECT com JOINs

```sql
-- INNER JOIN: apenas linhas correspondentes
SELECT o.id, c.name, o.total
FROM orders o
INNER JOIN customers c ON c.id = o.customer_id;

-- LEFT JOIN: todas as linhas à esquerda, NULLs para não correspondências
SELECT c.name, COUNT(o.id) AS order_count
FROM customers c
LEFT JOIN orders o ON o.customer_id = c.id
GROUP BY c.name;

-- Auto-join: dados hierárquicos (funcionários/gerentes)
SELECT e.name AS employee, m.name AS manager
FROM employees e
LEFT JOIN employees m ON m.id = e.manager_id;
```

### Common Table Expressions (CTEs)

```sql
-- CTE recursiva para organograma
WITH RECURSIVE org AS (
  SELECT id, name, manager_id, 1 AS depth
  FROM employees WHERE manager_id IS NULL
  UNION ALL
  SELECT e.id, e.name, e.manager_id, o.depth + 1
  FROM employees e INNER JOIN org o ON o.id = e.manager_id
)
SELECT * FROM org ORDER BY depth, name;
```

### Funções de Janela

```sql
-- ROW_NUMBER para paginação / dedup
SELECT *, ROW_NUMBER() OVER (PARTITION BY customer_id ORDER BY created_at DESC) AS rn
FROM orders;

-- RANK com lacunas, DENSE_RANK sem lacunas
SELECT name, score, RANK() OVER (ORDER BY score DESC) AS rank FROM leaderboard;

-- LAG/LEAD para comparar linhas adjacentes
SELECT date, revenue,
  revenue - LAG(revenue) OVER (ORDER BY date) AS daily_change
FROM daily_sales;
```

### Padrões de Agregação

```sql
-- Cláusula FILTER (PostgreSQL) para agregação condicional
SELECT
  COUNT(*) AS total,
  COUNT(*) FILTER (WHERE status = 'active') AS active,
  AVG(amount) FILTER (WHERE amount > 0) AS avg_positive
FROM accounts;

-- GROUPING SETS para rollups em múltiplos níveis
SELECT region, product, SUM(revenue)
FROM sales
GROUP BY GROUPING SETS ((region, product), (region), ());
```

---

## Padrões de Migração

### Scripts de Migração Up/Down

Cada migração deve ter uma contraparte reversível. Nomeie os arquivos com um prefixo de timestamp para ordenação:

```
migrations/
├── 20260101_000001_create_users.up.sql
├── 20260101_000001_create_users.down.sql
├── 20260115_000002_add_users_email_index.up.sql
└── 20260115_000002_add_users_email_index.down.sql
```

### Migrações sem Downtime (Expand/Contract)

Use o padrão expand-contract para evitar bloqueio ou quebra do código em execução:

1. **Expand** — adicione a nova coluna/tabela (nullable, com padrão)
2. **Migrar dados** — backfill em lotes; dual-write a partir da aplicação
3. **Transição** — a aplicação lê da nova coluna; pare de escrever na antiga
4. **Contract** — remova a coluna antiga em uma migração de acompanhamento

### Estratégias de Backfill de Dados

```sql
-- Atualização em lote para evitar bloqueios de longa duração
UPDATE users SET email_normalized = LOWER(email)
WHERE id IN (SELECT id FROM users WHERE email_normalized IS NULL LIMIT 5000);
-- Repita em um loop até que 0 linhas sejam afetadas
```

### Procedimentos de Rollback

- Sempre teste o `down.sql` em staging antes de implantar o `up.sql` em produção
- Mantenha a janela de rollback curta — se o passo de contração já foi executado, o rollback requer uma nova migração para frente
- Para mudanças irreversíveis (descartando colunas com dados), faça primeiro um backup lógico

---

## Otimização de Performance

### Estratégias de Indexação

| Tipo de Índice | Caso de Uso | Exemplo |
|------------|----------|---------|
| **B-tree** (padrão) | Igualdade, range, ORDER BY | `CREATE INDEX idx_users_email ON users(email);` |
| **GIN** | Busca full-text, JSONB, arrays | `CREATE INDEX idx_docs_body ON docs USING gin(to_tsvector('english', body));` |
| **GiST** | Geometria, tipos de range, vizinho mais próximo | `CREATE INDEX idx_locations ON places USING gist(coords);` |
| **Parcial** | Subconjunto de linhas (reduz tamanho) | `CREATE INDEX idx_active ON users(email) WHERE active = true;` |
| **Covering** | Varreduras somente de índice | `CREATE INDEX idx_cov ON orders(customer_id) INCLUDE (total, created_at);` |

### Leitura de Plano EXPLAIN

```sql
EXPLAIN (ANALYZE, BUFFERS, FORMAT TEXT) SELECT ...;
```

Sinais principais a observar:
- **Seq Scan** em tabelas grandes — índice ausente
- **Nested Loop** com estimativas de linha altas — considere join hash/merge ou adicione índice
- **Buffers shared read** muito maior que **hit** — conjunto de trabalho excede a memória

### Detecção de Query N+1

Sintomas: a aplicação emite uma query por linha (ex.: buscando registros relacionados em um loop).

Correções:
- Use `JOIN` ou subquery para buscar em uma única viagem de ida e volta
- Carregamento eager do ORM (`select_related` / `includes` / `with`)
- Padrão DataLoader para resolvers GraphQL

### Connection Pooling

| Ferramenta | Protocolo | Melhor Para |
|------|----------|----------|
| **PgBouncer** | PostgreSQL | Pooling de transação/statement, baixa sobrecarga |
| **ProxySQL** | MySQL | Roteamento de query, separação leitura/escrita |
| **Pool integrado** (HikariCP, SQLAlchemy pool) | Qualquer | Pooling em nível de aplicação |

**Regra geral:** Defina o tamanho do pool como `(2 * núcleos de CPU) + spindles de disco`. Para SSDs na nuvem, comece com `2 * vCPUs` e ajuste.

### Réplicas de Leitura e Roteamento de Query

- Roteie todas as queries `SELECT` para réplicas; escritas para o primário
- Leve em conta o lag de replicação (tipicamente <1s para async, 0 para sync)
- Use `pg_last_wal_replay_lsn()` para detectar lag antes de ler dados críticos

---

## Matriz de Decisão Multi-Banco de Dados

| Critério | PostgreSQL | MySQL | SQLite | SQL Server |
|----------|-----------|-------|--------|------------|
| **Melhor para** | Queries complexas, JSONB, extensões | Apps web, cargas de trabalho de leitura intensa | Embarcado, dev/test, edge | Stacks .NET enterprise |
| **Suporte a JSON** | Excelente (JSONB + GIN) | Bom (tipo JSON) | Mínimo | Bom (OPENJSON) |
| **Replicação** | Streaming, lógica | Replicação em grupo, cluster InnoDB | N/A | Always On AG |
| **Licenciamento** | Open source (Licença PostgreSQL) | Open source (GPL) / comercial | Domínio público | Comercial |
| **Tamanho máximo prático** | Multi-TB | Multi-TB | ~1 TB (single-writer) | Multi-TB |

**Quando escolher:**
- **PostgreSQL** — escolha padrão para novos projetos; melhor extensibilidade e conformidade com padrões
- **MySQL** — ecossistema MySQL existente; aplicações web simples com leitura intensa
- **SQLite** — apps mobile, ferramentas CLI, bancos de dados de testes unitários, IoT/edge
- **SQL Server** — mandato de política enterprise; integração profunda com .NET/Azure

### Considerações NoSQL

| Banco de Dados | Modelo | Usar Quando |
|----------|-------|----------|
| **MongoDB** | Documento | Flexibilidade de schema, prototipagem rápida, gerenciamento de conteúdo |
| **Redis** | Chave-valor / cache | Store de sessão, limitação de taxa, leaderboards, pub/sub |
| **DynamoDB** | Wide-column | Apps AWS serverless, latência de um dígito em milissegundos em qualquer escala |

> Use SQL como padrão. Recorra ao NoSQL apenas quando o padrão de acesso claramente se beneficiar.

---

## Sharding e Replicação

### Particionamento Horizontal vs. Vertical

- **Particionamento vertical**: Divida colunas entre tabelas (ex.: colunas BLOB separadas). Reduz I/O para queries estreitas.
- **Particionamento horizontal (sharding)**: Divida linhas entre bancos de dados/servidores. Necessário quando um único nó não consegue armazenar o conjunto de dados ou lidar com o throughput.

### Estratégias de Sharding

| Estratégia | Como Funciona | Prós | Contras |
|----------|-------------|------|------|
| **Hash** | `shard = hash(key) % N` | Distribuição uniforme | Resharding é caro |
| **Range** | Shard por data ou range de ID | Simples, bom para séries temporais | Pontos quentes no shard mais recente |
| **Geográfico** | Shard por região do usuário | Localidade de dados, conformidade | Queries entre regiões são difíceis |

### Padrões de Replicação

| Padrão | Consistência | Latência | Caso de Uso |
|---------|------------|---------|----------|
| **Síncrono** | Forte | Maior latência de escrita | Transações financeiras |
| **Assíncrono** | Eventual | Baixa latência de escrita | Apps web com leitura intensa |
| **Semi-síncrono** | Pelo menos uma réplica confirmada | Moderada | Equilíbrio de segurança e velocidade |

---

## Referências Cruzadas

- **sql-database-assistant** — escrita de query, otimização e depuração para trabalho SQL do dia a dia
- **database-schema-designer** — modelagem ERD, análise de normalização e geração de schema
- **migration-architect** — planejamento de migração em grande escala entre engines de banco de dados ou grandes reformulações de schema
- **senior-backend** — padrões em nível de aplicação (connection pooling, melhores práticas de ORM)
- **senior-devops** — provisionamento de infraestrutura para clusters e réplicas de banco de dados

---

## Conclusão

O design eficaz de banco de dados exige equilibrar múltiplas preocupações concorrentes: performance, escalabilidade, manutenibilidade e requisitos de negócio. Esta skill fornece as ferramentas e o conhecimento para tomar decisões informadas ao longo do ciclo de vida do banco de dados, desde o design inicial do schema até a otimização em produção e evolução.

As ferramentas incluídas automatizam tarefas comuns de análise e otimização, enquanto os guias abrangentes fornecem a base teórica para tomar decisões arquiteturais sólidas. Seja construindo um novo sistema ou otimizando um existente, esses recursos fornecem orientação em nível de especialista para criar soluções de banco de dados robustas e escaláveis.
