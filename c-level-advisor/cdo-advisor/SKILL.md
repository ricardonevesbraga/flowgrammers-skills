---
name: "cdo-advisor"
description: "Assessor de Chief Data Officer (CDO) para estratégia de dados, governança, arquitetura de plataforma de dados, qualidade, LGPD e monetização. Use ao definir estratégia de dados corporativa, desenhar data governance, implementar data mesh/lakehouse, garantir conformidade com LGPD, preparar relatórios para conselho sobre dados, ou quando o usuário mencionar CDO, Chief Data Officer, estratégia de dados, governança de dados, data platform, data quality, data catalog, MDM ou monetização de dados."
license: MIT
metadata:
  version: 1.0.0
  author: Ric Neves - Flowgrammers
  category: c-level
  domain: data-leadership
  updated: 2026-04-23
agents:
  - claude-code
---

# Assessor de CDO (Chief Data Officer)

Frameworks para liderança de dados corporativa: estratégia, governança, plataforma, qualidade, conformidade (LGPD) e monetização.

## Palavras-chave
CDO, Chief Data Officer, estratégia de dados, governança de dados, data platform, data mesh, data lakehouse, data quality, data catalog, MDM, master data management, LGPD, data monetization, data product, data literacy, data-driven

## Responsabilidades Principais

### 1. Estratégia de Dados Corporativa
Traduza a estratégia do negócio em capacidades de dados. Não basta ter dados — é preciso torná-los acionáveis.

**Framework de 4 camadas:**
- **Captura**: Onde os dados nascem (operacional, digital, terceiros)
- **Processamento**: Como dados viram informação (ETL/ELT, streaming)
- **Consumo**: Quem usa e como (BI, ML, APIs, produtos)
- **Governança**: Políticas, qualidade, conformidade

**Horizontes:**
- 90 dias: inventário + linhagem + quick wins de qualidade
- 6 meses: plataforma centralizada + catálogo + self-service BI
- 18 meses: data products + ML em produção + monetização

### 2. Governança e Conformidade (LGPD)
No Brasil, LGPD (Lei 13.709/18) é não-negociável. Multa de até 2% do faturamento (R$ 50 milhões por infração).

**Checklist LGPD para o CDO:**
- Mapeamento de dados pessoais (RoPA — Registro de Operações de Tratamento)
- Bases legais documentadas (consentimento, legítimo interesse, execução de contrato)
- Direitos do titular operacionalizados (acesso, retificação, exclusão, portabilidade)
- DPIA (Data Protection Impact Assessment) para processamentos de alto risco
- Encarregado (DPO) nomeado e acessível
- Incidentes reportados à ANPD em até 72h

**Data governance além de compliance:**
- Data ownership: cada domínio tem um dono de negócio
- Data stewardship: cada data product tem um steward técnico
- Políticas de classificação (pública / interna / confidencial / restrita)
- Retenção por tipo de dado e contrato

### 3. Arquitetura de Plataforma
Escolha entre data warehouse, data lake, lakehouse ou data mesh baseado no estágio.

**Matriz de decisão:**

| Estágio | Arquitetura | Ferramentas típicas (BR) |
|---------|-------------|--------------------------|
| Seed/Series A | Warehouse + BI | BigQuery, Snowflake, Metabase |
| Series B | Lakehouse | Databricks, dbt, Airbyte |
| Series C+ | Data Mesh | Databricks + dbt + Kafka + catálogo federado |

### 4. Qualidade e Observabilidade de Dados
Dados ruins destroem confiança. Confiança é a moeda do CDO.

**Dimensões da qualidade:**
- Completude (% de campos preenchidos)
- Validade (conformidade com schema)
- Precisão (match com realidade)
- Consistência (cross-sistema)
- Atualidade (freshness SLA)
- Unicidade (dedup)

**SLAs típicos para produtos críticos de dados:**
- Freshness: dados < 4h de atraso em 99% dos dias
- Qualidade: > 98% de registros válidos
- Disponibilidade: 99.5% de uptime do pipeline

### 5. Monetização e Cultura de Dados
Dados têm valor de uso (interno) e valor de troca (externo).

**Padrões de monetização:**
- Reporting-as-a-Service para clientes (dashboards white-label)
- APIs pagas de dados derivados
- Modelos preditivos como produto (scoring, recomendações)
- Benchmarks anonimizados do setor

**Cultura de dados:**
- Data literacy: todo líder lê e questiona um dashboard
- Decisions log: decisões-chave têm análise de dados anexa
- Experimentação: hipóteses testáveis antes de grandes apostas

## Métricas do CDO

- **Time-to-insight**: mediana de tempo entre pergunta de negócio e resposta com dados
- **% self-service BI**: queries feitas sem envolver o time de dados
- **Qualidade média**: DQ score agregado dos data products
- **Cobertura LGPD**: % dos dados pessoais mapeados e com base legal
- **ROI de iniciativas de dados**: valor capturado / investimento

## Perguntas-Chave que um CDO Faz

- "Se eu saísse amanhã, o time conseguiria encontrar, confiar e usar os dados?"
- "Qual é o pior cenário de privacidade — e estamos preparados?"
- "Estamos otimizando para reduzir custo ou para acelerar decisões?"
- "Quais dados são ativos estratégicos versus commodity?"
- "Nossas decisões de produto estão sendo informadas por dados ou por opinião?"

## Artefatos Essenciais

- **Estratégia de Dados (1 página)**: visão, 3 pilares, KPIs, roadmap 12 meses
- **Política de Governança**: domínios, ownership, classificação, retenção
- **RoPA LGPD**: inventário de tratamentos
- **Catálogo de Data Products**: nome, owner, SLA, consumidores
- **Board Update Trimestral**: saúde da plataforma, incidentes, ROI, roadmap

## Integração com Outros Papéis

| Papel | Interface |
|-------|-----------|
| CTO | Arquitetura de plataforma, segurança |
| CISO | Classificação, acessos, incidentes |
| CMO/CRO | Atribuição, CDP, ICP |
| CFO | Forecast, unit economics |
| DPO | Conformidade LGPD operacional |

## Veja Também

- `ciso-advisor/` — segurança da informação (ISO 27001)
- `cto-advisor/` — decisões técnicas de plataforma
- `../engineering/database-designer/` — modelagem de dados
- `../engineering/rag-architect/` — dados para IA
- `../ra-qm-team/gdpr-dsgvo-expert/` — LGPD detalhado
