---
name: "snowflake-development"
description: "Use quando escrever SQL Snowflake, construir pipelines de dados com Dynamic Tables ou Streams/Tasks, usar funções Cortex AI, criar Cortex Agents, escrever Snowpark Python, configurar dbt para Snowflake ou solucionar problemas de erros Snowflake."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Desenvolvimento Snowflake

SQL Snowflake, pipelines de dados, Cortex AI e desenvolvimento Snowpark Python. Cobre a regra do prefixo de dois pontos, dados semi-estruturados, upserts MERGE, Dynamic Tables, Streams+Tasks, funções Cortex AI, especificações de agentes, ajuste de performance e hardening de segurança.

> Contribuído originalmente por [James Cha-Earley](https://github.com/jamescha-earley) — aprimorado e integrado pela equipe claude-skills.

## Início Rápido

```bash
# Gerar template de upsert MERGE
python scripts/snowflake_query_helper.py merge --target customers --source staging_customers --key customer_id --columns name,email,updated_at

# Gerar template de Dynamic Table
python scripts/snowflake_query_helper.py dynamic-table --name cleaned_events --warehouse transform_wh --lag "5 minutes"

# Gerar declarações RBAC grant
python scripts/snowflake_query_helper.py grant --role analyst_role --database analytics --schemas public,staging --privileges SELECT,USAGE
```

---

## Melhores Práticas SQL

### Nomenclatura e Estilo

- Use `snake_case` para todos os identificadores. Evite identificadores entre aspas duplas — eles forçam nomes case-sensitive que exigem aspas constantes.
- Use CTEs (cláusulas `WITH`) em vez de subqueries aninhadas.
- Use `CREATE OR REPLACE` para DDL idempotente.
- Use listas de colunas explícitas — nunca `SELECT *` em produção. O armazenamento colunar do Snowflake escaneia apenas colunas referenciadas, então listas explícitas reduzem I/O.

### Stored Procedures — Regra do Prefixo de Dois Pontos

Em stored procedures SQL (blocos BEGIN...END), variáveis e parâmetros **devem** usar o prefixo `:` de dois pontos dentro de declarações SQL. Sem ele, o Snowflake os trata como identificadores de coluna e gera erros de "invalid identifier".

```sql
-- ERRADO: prefixo de dois pontos ausente
SELECT name INTO result FROM users WHERE id = p_id;

-- CORRETO: prefixo de dois pontos em variável e parâmetro
SELECT name INTO :result FROM users WHERE id = :p_id;
```

Isso se aplica a variáveis DECLARE, variáveis LET e parâmetros de procedure quando usados dentro de SELECT, INSERT, UPDATE, DELETE ou MERGE.

### Dados Semi-Estruturados

- VARIANT, OBJECT, ARRAY para JSON/Avro/Parquet/ORC.
- Acessar campos aninhados: `src:customer.name::STRING`. Sempre fazer cast com `::TYPE`.
- VARIANT null vs SQL NULL: JSON `null` é armazenado como string `"null"`. Use `STRIP_NULL_VALUE = TRUE` no carregamento.
- Achatar arrays: `SELECT f.value:name::STRING FROM my_table, LATERAL FLATTEN(input => src:items) f;`

### MERGE para Upserts

```sql
MERGE INTO target t USING source s ON t.id = s.id
WHEN MATCHED THEN UPDATE SET t.name = s.name, t.updated_at = CURRENT_TIMESTAMP()
WHEN NOT MATCHED THEN INSERT (id, name, updated_at) VALUES (s.id, s.name, CURRENT_TIMESTAMP());
```

> Veja `references/snowflake_sql_and_pipelines.md` para padrões SQL mais profundos e anti-padrões.

---

## Pipelines de Dados

### Escolhendo sua Abordagem

| Abordagem | Quando Usar |
|----------|-------------|
| Dynamic Tables | Transformações declarativas. **Escolha padrão.** Defina a query, o Snowflake cuida do refresh. |
| Streams + Tasks | CDC imperativo. Use para lógica procedural, chamadas de stored procedure, ramificação complexa. |
| Snowpipe | Carregamento contínuo de arquivos de armazenamento cloud (S3, GCS, Azure). |

### Dynamic Tables

```sql
CREATE OR REPLACE DYNAMIC TABLE cleaned_events
    TARGET_LAG = '5 minutes'
    WAREHOUSE = transform_wh
    AS
    SELECT event_id, event_type, user_id, event_timestamp
    FROM raw_events
    WHERE event_type IS NOT NULL;
```

Regras principais:
- Defina `TARGET_LAG` progressivamente: mais restrito no topo do DAG, mais frouxo downstream.
- DTs incrementais não podem depender de DTs de refresh completo.
- `SELECT *` quebra em mudanças de schema upstream — use listas de colunas explícitas.
- Views não podem estar entre duas Dynamic Tables no DAG.

### Streams e Tasks

```sql
CREATE OR REPLACE STREAM raw_stream ON TABLE raw_events;

CREATE OR REPLACE TASK process_events
    WAREHOUSE = transform_wh
    SCHEDULE = 'USING CRON 0 */1 * * * America/Los_Angeles'
    WHEN SYSTEM$STREAM_HAS_DATA('raw_stream')
    AS INSERT INTO cleaned_events SELECT ... FROM raw_stream;

-- Tasks começam SUSPENSAS. Você DEVE retomá-las.
ALTER TASK process_events RESUME;
```

> Veja `references/snowflake_sql_and_pipelines.md` para queries de debug de DT e padrões Snowpipe.

---

## Cortex AI

### Referência de Funções

| Função | Propósito |
|----------|---------|
| `AI_COMPLETE` | Completamento de LLM (texto, imagens, documentos) |
| `AI_CLASSIFY` | Classificar texto em categorias (até 500 labels) |
| `AI_FILTER` | Filtro booleano em texto ou imagens |
| `AI_EXTRACT` | Extração estruturada de texto/imagens/documentos |
| `AI_SENTIMENT` | Score de sentimento (-1 a 1) |
| `AI_PARSE_DOCUMENT` | Extração OCR ou layout de documentos |
| `AI_REDACT` | Remoção de PII do texto |

**Nomes obsoletos (NÃO usar):** `COMPLETE`, `CLASSIFY_TEXT`, `EXTRACT_ANSWER`, `PARSE_DOCUMENT`, `SUMMARIZE`, `TRANSLATE`, `SENTIMENT`, `EMBED_TEXT_768`.

### TO_FILE — Armadilha Comum

O caminho do stage e o nome do arquivo são argumentos **separados**:

```sql
-- ERRADO: argumento único combinado
TO_FILE('@stage/file.pdf')

-- CORRETO: dois argumentos
TO_FILE('@db.schema.mystage', 'invoice.pdf')
```

### Cortex Agents

As especificações de agente usam uma estrutura JSON com chaves de nível superior: `models`, `instructions`, `tools`, `tool_resources`.

- Use o delimitador `$spec$` (não `$$`).
- `models` deve ser um objeto, não um array.
- `tool_resources` é uma chave de nível superior separada, não aninhada dentro de `tools`.
- Descrições de ferramentas são o fator mais importante na qualidade do agente.

> Veja `references/cortex_ai_and_agents.md` para exemplos completos de especificação de agente e padrões Cortex Search.

---

## Snowpark Python

```python
from snowflake.snowpark import Session
import os

session = Session.builder.configs({
    "account": os.environ["SNOWFLAKE_ACCOUNT"],
    "user": os.environ["SNOWFLAKE_USER"],
    "password": os.environ["SNOWFLAKE_PASSWORD"],
    "role": "my_role", "warehouse": "my_wh",
    "database": "my_db", "schema": "my_schema"
}).create()
```

- Nunca hardcode credenciais. Use variáveis de ambiente ou autenticação por par de chaves.
- DataFrames são lazy — executados em `collect()` / `show()`.
- NÃO chame `collect()` em DataFrames grandes. Processe no lado do servidor com operações DataFrame.
- Use **UDFs vetorizadas** (10-100x mais rápidas) para workloads de batch e ML.

## dbt no Snowflake

```sql
-- Materialização de dynamic table (marts streaming/quase tempo real):
{{ config(materialized='dynamic_table', snowflake_warehouse='transforming', target_lag='1 hour') }}

-- Materialização incremental (grandes tabelas de fatos):
{{ config(materialized='incremental', unique_key='event_id') }}

-- Configurações específicas Snowflake (combinar com qualquer materialização):
{{ config(transient=true, copy_grants=true, query_tag='team_daily') }}
```

- NÃO use `{{ this }}` sem guarda `{% if is_incremental() %}`.
- Use materialização `dynamic_table` para marts streaming ou quase em tempo real.

## Performance

- **Chaves de cluster**: Apenas para tabelas multi-TB. Aplique em colunas WHERE / JOIN / GROUP BY.
- **Otimização de Pesquisa**: `ALTER TABLE t ADD SEARCH OPTIMIZATION ON EQUALITY(col);`
- **Dimensionamento de warehouse**: Comece com X-Small, escale para cima. Defina `AUTO_SUSPEND = 60`, `AUTO_RESUME = TRUE`.
- **Warehouses separados** por workload (carregamento, transformação, query).

## Segurança

- Siga RBAC com menor privilégio. Use roles de banco de dados para grants em nível de objeto.
- Audite ACCOUNTADMIN regularmente: `SHOW GRANTS OF ROLE ACCOUNTADMIN;`
- Use políticas de rede para allowlisting de IP.
- Use políticas de mascaramento para colunas PII e políticas de acesso por linha para isolamento multi-tenant.

---

## Gatilhos Proativos

Sinalize estes problemas sem ser solicitado quando percebê-los no contexto:

- **Prefixo de dois pontos ausente** em stored procedures SQL — sinalize imediatamente, causa erro "invalid identifier" em runtime.
- **`SELECT *` em Dynamic Tables** — sinalize como uma bomba-relógio de mudança de schema.
- **Nomes de funções Cortex obsoletos** (`CLASSIFY_TEXT`, `SUMMARIZE`, etc.) — sugira os equivalentes `AI_*` atuais.
- **Task não retomada** após criação — lembre que tasks começam SUSPENSAS.
- **Credenciais hardcoded** em código Snowpark — sinalize como risco de segurança.

---

## Erros Comuns

| Erro | Causa | Correção |
|-------|-------|-----|
| "Object does not exist" | Contexto de database/schema errado ou grants ausentes | Qualifique nomes completamente (`db.schema.table`), verifique grants |
| "Invalid identifier" em procedure | Prefixo de dois pontos ausente na variável | Use `:nome_variavel` dentro de declarações SQL |
| "Numeric value not recognized" | Campo VARIANT não convertido | Faça cast explícito: `src:field::NUMBER(10,2)` |
| Task não executando | Esqueceu de retomar após criação | `ALTER TASK task_name RESUME;` |
| Falha de refresh de DT | Mudança de schema upstream ou tracking desabilitado | Use colunas explícitas, verifique change tracking |
| Erro TO_FILE | Caminho combinado como argumento único | Divida em dois args: `TO_FILE('@stage', 'file.pdf')` |

---

## Workflows Práticos

### Workflow 1: Construir um Pipeline de Relatórios (30 min)

1. **Preparar dados brutos**: Criar stage externo apontando para S3/GCS/Azure, configurar Snowpipe para auto-ingestão
2. **Limpar com Dynamic Table**: Criar DT com `TARGET_LAG = '5 minutes'` que filtra nulos, converte tipos, remove duplicatas
3. **Agregar com DT downstream**: Segunda DT que junta dados limpos com tabelas de dimensão, computa métricas
4. **Expor via Secure View**: Criar `SECURE VIEW` para a ferramenta BI / camada API
5. **Conceder acesso**: Use `snowflake_query_helper.py grant` para gerar declarações RBAC

### Workflow 2: Adicionar Classificação AI a Dados Existentes

1. **Identificar a coluna**: Encontrar a coluna de texto para classificar (ex.: tickets de suporte, avaliações)
2. **Testar com AI_CLASSIFY**: `SELECT AI_CLASSIFY(text_col, ['bug', 'feature', 'question']) FROM table LIMIT 10;`
3. **Criar DT de enriquecimento**: Dynamic Table que executa `AI_CLASSIFY` em novas linhas automaticamente
4. **Monitorar custos**: Cortex AI é cobrado por token — amostre antes de executar em tabelas completas

### Workflow 3: Depurar um Pipeline com Falha

1. **Verificar histórico de task**: `SELECT * FROM TABLE(INFORMATION_SCHEMA.TASK_HISTORY()) WHERE STATE = 'FAILED' ORDER BY SCHEDULED_TIME DESC;`
2. **Verificar refresh de DT**: `SELECT * FROM TABLE(INFORMATION_SCHEMA.DYNAMIC_TABLE_REFRESH_HISTORY('my_dt')) ORDER BY REFRESH_END_TIME DESC;`
3. **Verificar staleness de stream**: `SHOW STREAMS; -- verificar coluna stale_after`
4. **Consultar referência de troubleshooting**: Veja `references/troubleshooting.md` para correções específicas de erro

---

## Anti-Padrões

| Anti-Padrão | Por que Falha | Melhor Abordagem |
|---|---|---|
| `SELECT *` em Dynamic Tables | Mudanças de schema upstream quebram a DT silenciosamente | Use listas de colunas explícitas |
| Prefixo de dois pontos ausente em procedures | Erro "Invalid identifier" em runtime | Sempre use `:nome_variavel` em blocos SQL |
| Warehouse único para todos os workloads | Contenção entre carregamento, transformação e query | Warehouses separados por tipo de workload |
| Credenciais hardcoded no Snowpark | Risco de segurança, quebra no CI/CD | Use `os.environ[]` ou autenticação por par de chaves |
| `collect()` em DataFrames grandes | Puxa todo o conjunto de resultados para memória do cliente | Processe no lado do servidor com operações DataFrame |
| Subqueries aninhadas em vez de CTEs | Ilegível, difícil de debugar, Snowflake otimiza CTEs melhor | Use cláusulas `WITH` |
| Usar funções Cortex obsoletas | `CLASSIFY_TEXT`, `SUMMARIZE` etc. serão removidas | Use `AI_CLASSIFY`, `AI_COMPLETE` etc. |
| Tasks sem `WHEN SYSTEM$STREAM_HAS_DATA` | Task executa no agendamento mesmo sem novos dados, desperdiçando créditos | Adicione a cláusula WHEN para tasks acionadas por stream |
| Identificadores entre aspas duplas | Força nomes case-sensitive em todas as queries | Use identificadores `snake_case` sem aspas |

---

## Cross-Referências

| Skill | Relação |
|-------|-------------|
| `engineering/sql-database-assistant` | Padrões SQL gerais — use para bancos de dados que não são Snowflake |
| `engineering/database-designer` | Design de schema — use para modelagem de dados antes da implementação Snowflake |
| `engineering-team/senior-data-engineer` | Engenharia de dados mais ampla — pipelines, Spark, Airflow, qualidade de dados |
| `engineering-team/senior-data-scientist` | Analytics e ML — use junto com Snowpark para feature engineering |
| `engineering-team/senior-devops` | CI/CD para implantações Snowflake (Terraform, GitHub Actions) |

---

## Documentação de Referência

| Documento | Conteúdo |
|----------|----------|
| `references/snowflake_sql_and_pipelines.md` | Padrões SQL, templates MERGE, debug de Dynamic Table, Snowpipe, anti-padrões |
| `references/cortex_ai_and_agents.md` | Funções Cortex AI, estrutura de especificação de agente, Cortex Search, Snowpark |
| `references/troubleshooting.md` | Referência de erros, queries de debug, correções comuns |
