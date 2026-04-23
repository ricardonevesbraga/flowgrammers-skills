---
name: "senior-data-engineer"
description: "Skill de engenharia de dados para construção de pipelines de dados escaláveis, sistemas ETL/ELT e infraestrutura de dados. Expertise em Python, SQL, Spark, Airflow, dbt, Kafka e o stack de dados moderno. Inclui modelagem de dados, orquestração de pipeline, qualidade de dados e DataOps. Use quando projetar arquiteturas de dados, construir pipelines de dados, otimizar fluxos de trabalho de dados, implementar governança de dados ou solucionar problemas de dados."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Engenheiro de Dados Sênior

Skill de engenharia de dados em nível de produção para construção de sistemas de dados escaláveis e confiáveis.

## Sumário

1. [Frases de Gatilho](#frases-de-gatilho)
2. [Início Rápido](#início-rápido)
3. [Fluxos de Trabalho](#fluxos-de-trabalho)
   - [Construindo um Pipeline ETL em Batch](#fluxo-de-trabalho-1-construindo-um-pipeline-etl-em-batch)
   - [Implementando Streaming em Tempo Real](#fluxo-de-trabalho-2-implementando-streaming-em-tempo-real)
   - [Configuração de Framework de Qualidade de Dados](#fluxo-de-trabalho-3-configuração-de-framework-de-qualidade-de-dados)
4. [Framework de Decisão de Arquitetura](#framework-de-decisão-de-arquitetura)
5. [Tech Stack](#tech-stack)
6. [Documentação de Referência](#documentação-de-referência)
7. [Solução de Problemas](#solução-de-problemas)

---

## Frases de Gatilho

Ative esta skill quando ver:

**Design de Pipeline:**
- "Projetar um pipeline de dados para..."
- "Construir um processo ETL/ELT..."
- "Como ingerir dados de..."
- "Configurar extração de dados de..."

**Arquitetura:**
- "Devo usar batch ou streaming?"
- "Arquitetura Lambda vs Kappa"
- "Como lidar com dados de chegada tardia"
- "Projetar um data lakehouse"

**Modelagem de Dados:**
- "Criar um modelo dimensional..."
- "Star schema vs snowflake"
- "Implementar slowly changing dimensions"
- "Projetar um data vault"

**Qualidade de Dados:**
- "Adicionar validação de dados a..."
- "Configurar verificações de qualidade de dados"
- "Monitorar frescor dos dados"
- "Implementar contratos de dados"

**Desempenho:**
- "Otimizar este job Spark"
- "Query está rodando lenta"
- "Reduzir tempo de execução do pipeline"
- "Ajustar DAG do Airflow"

---

## Início Rápido

### Ferramentas Principais

```bash
# Gerar configuração de orquestração de pipeline
python scripts/pipeline_orchestrator.py generate \
  --type airflow \
  --source postgres \
  --destination snowflake \
  --schedule "0 5 * * *"

# Validar qualidade de dados
python scripts/data_quality_validator.py validate \
  --input data/sales.parquet \
  --schema schemas/sales.json \
  --checks freshness,completeness,uniqueness

# Otimizar desempenho ETL
python scripts/etl_performance_optimizer.py analyze \
  --query queries/daily_aggregation.sql \
  --engine spark \
  --recommend
```

---

## Fluxos de Trabalho
→ Veja references/workflows.md para detalhes

## Framework de Decisão de Arquitetura

Use este framework para escolher a abordagem correta para seu pipeline de dados.

### Batch vs Streaming

| Critério | Batch | Streaming |
|----------|-------|-----------|
| **Requisito de latência** | Horas a dias | Segundos a minutos |
| **Volume de dados** | Grandes conjuntos históricos | Fluxos contínuos de eventos |
| **Complexidade de processamento** | Transformações complexas, ML | Agregações simples, filtragem |
| **Sensibilidade a custo** | Mais econômico | Custo de infraestrutura maior |
| **Tratamento de erros** | Mais fácil reprocessar | Requer design cuidadoso |

**Árvore de Decisão:**
```
Insights em tempo real são necessários?
├── Sim → Use streaming
│   └── Semântica exactly-once é necessária?
│       ├── Sim → Kafka + Flink/Spark Structured Streaming
│       └── Não → Kafka + consumer groups
└── Não → Use batch
    └── Volume de dados > 1TB diário?
        ├── Sim → Spark/Databricks
        └── Não → dbt + computação do warehouse
```

### Arquitetura Lambda vs Kappa

| Aspecto | Lambda | Kappa |
|--------|--------|-------|
| **Complexidade** | Dois codebases (batch + stream) | Codebase único |
| **Manutenção** | Maior (sincronizar lógica batch/stream) | Menor |
| **Reprocessamento** | Camada batch nativa | Replay a partir da origem |
| **Caso de uso** | Treinamento ML + serving em tempo real | Puramente orientado a eventos |

**Quando escolher Lambda:**
- Necessidade de treinar modelos ML em dados históricos
- Transformações batch complexas não viáveis em streaming
- Infraestrutura batch existente

**Quando escolher Kappa:**
- Arquitetura orientada a eventos
- Todo o processamento pode ser expresso como operações de stream
- Começando do zero sem sistemas legados

### Data Warehouse vs Data Lakehouse

| Funcionalidade | Warehouse (Snowflake/BigQuery) | Lakehouse (Delta/Iceberg) |
|---------|-------------------------------|---------------------------|
| **Melhor para** | BI, analytics SQL | ML, dados não estruturados |
| **Custo de armazenamento** | Maior (formato proprietário) | Menor (formatos abertos) |
| **Flexibilidade** | Schema-on-write | Schema-on-read |
| **Desempenho** | Excelente para SQL | Bom, melhorando |
| **Ecossistema** | Ferramentas BI maduras | Ferramentas ML crescentes |

---

## Tech Stack

| Categoria | Tecnologias |
|----------|--------------|
| **Linguagens** | Python, SQL, Scala |
| **Orquestração** | Airflow, Prefect, Dagster |
| **Transformação** | dbt, Spark, Flink |
| **Streaming** | Kafka, Kinesis, Pub/Sub |
| **Armazenamento** | S3, GCS, Delta Lake, Iceberg |
| **Warehouses** | Snowflake, BigQuery, Redshift, Databricks |
| **Qualidade** | Great Expectations, testes dbt, Monte Carlo |
| **Monitoramento** | Prometheus, Grafana, Datadog |

---

## Documentação de Referência

### 1. Arquitetura de Pipeline de Dados
Veja `references/data_pipeline_architecture.md` para:
- Padrões de arquitetura Lambda vs Kappa
- Processamento batch com Spark e Airflow
- Processamento de stream com Kafka e Flink
- Implementação de semântica exactly-once
- Tratamento de erros e dead letter queues

### 2. Padrões de Modelagem de Dados
Veja `references/data_modeling_patterns.md` para:
- Modelagem dimensional (Star/Snowflake)
- Slowly Changing Dimensions (SCD Tipos 1-6)
- Modelagem Data Vault
- Melhores práticas dbt
- Particionamento e clustering

### 3. Melhores Práticas DataOps
Veja `references/dataops_best_practices.md` para:
- Frameworks de teste de dados
- Contratos de dados e validação de schema
- CI/CD para pipelines de dados
- Observabilidade e lineage
- Resposta a incidentes

---

## Solução de Problemas
→ Veja references/troubleshooting.md para detalhes
