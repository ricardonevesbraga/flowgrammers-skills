---
name: "senior-ml-engineer"
description: "Skill de engenharia de ML para colocar modelos em produção, construir pipelines MLOps e integrar LLMs. Cobre implantação de modelos, feature stores, monitoramento de drift, sistemas RAG e otimização de custos. Use quando o usuário perguntar sobre implantar modelos de ML em produção, configurar infraestrutura MLOps (MLflow, Kubeflow, Kubernetes, Docker), monitorar performance ou drift de modelos, construir pipelines RAG ou integrar APIs de LLM com lógica de retry e controles de custo."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Engenheiro de ML Sênior

Padrões de engenharia de ML em produção para implantação de modelos, infraestrutura MLOps e integração de LLM.

---

## Sumário

- [Workflow de Implantação de Modelo](#model-deployment-workflow)
- [Configuração de Pipeline MLOps](#mlops-pipeline-setup)
- [Workflow de Integração de LLM](#llm-integration-workflow)
- [Implementação de Sistema RAG](#rag-system-implementation)
- [Monitoramento de Modelo](#model-monitoring)
- [Documentação de Referência](#documentação-de-referência)
- [Ferramentas](#ferramentas)

---

## Workflow de Implantação de Modelo

Implante um modelo treinado em produção com monitoramento:

1. Exporte o modelo para formato padronizado (ONNX, TorchScript, SavedModel)
2. Empacote o modelo com dependências em container Docker
3. Implante no ambiente de staging
4. Execute testes de integração no staging
5. Implante canary (5% do tráfego) em produção
6. Monitore latência e taxas de erro por 1 hora
7. Promova para produção completa se as métricas passarem
8. **Validação:** latência p95 < 100ms, taxa de erro < 0,1%

### Template de Container

```dockerfile
FROM python:3.11-slim

COPY requirements.txt .
RUN pip install --no-cache-dir -r requirements.txt

COPY model/ /app/model/
COPY src/ /app/src/

HEALTHCHECK CMD curl -f http://localhost:8080/health || exit 1

EXPOSE 8080
CMD ["uvicorn", "src.server:app", "--host", "0.0.0.0", "--port", "8080"]
```

### Opções de Serving

| Opção | Latência | Throughput | Caso de Uso |
|--------|---------|------------|----------|
| FastAPI + Uvicorn | Baixa | Médio | REST APIs, modelos pequenos |
| Triton Inference Server | Muito Baixa | Muito Alto | Inferência GPU, batching |
| TensorFlow Serving | Baixa | Alto | Modelos TensorFlow |
| TorchServe | Baixa | Alto | Modelos PyTorch |
| Ray Serve | Média | Alto | Pipelines complexos, multi-modelo |

---

## Configuração de Pipeline MLOps

Estabeleça treinamento e implantação automatizados:

1. Configure feature store (Feast, Tecton) para dados de treinamento
2. Configure tracking de experimentos (MLflow, Weights & Biases)
3. Crie pipeline de treinamento com logging de hiperparâmetros
4. Registre o modelo no model registry com metadados de versão
5. Configure implantação em staging acionada por eventos do registry
6. Configure infraestrutura de teste A/B para comparação de modelos
7. Habilite monitoramento de drift com alertas
8. **Validação:** Novos modelos avaliados automaticamente contra baseline

### Padrão de Feature Store

```python
from feast import Entity, Feature, FeatureView, FileSource

user = Entity(name="user_id", value_type=ValueType.INT64)

user_features = FeatureView(
    name="user_features",
    entities=["user_id"],
    ttl=timedelta(days=1),
    features=[
        Feature(name="purchase_count_30d", dtype=ValueType.INT64),
        Feature(name="avg_order_value", dtype=ValueType.FLOAT),
    ],
    online=True,
    source=FileSource(path="data/user_features.parquet"),
)
```

### Gatilhos de Retreinamento

| Gatilho | Detecção | Ação |
|---------|-----------|--------|
| Agendado | Cron (semanal/mensal) | Retreinamento completo |
| Queda de performance | Acurácia < threshold | Retreinamento imediato |
| Drift de dados | PSI > 0,2 | Avaliar, depois retreinar |
| Volume de novos dados | X novas amostras | Atualização incremental |

---

## Workflow de Integração de LLM

Integre APIs de LLM em aplicações de produção:

1. Crie camada de abstração de provedor para flexibilidade de vendor
2. Implemente lógica de retry com backoff exponencial
3. Configure fallback para provedor secundário
4. Configure contagem de tokens e truncamento de contexto
5. Adicione cache de resposta para queries repetidas
6. Implemente rastreamento de custo por requisição
7. Adicione validação de saída estruturada com Pydantic
8. **Validação:** Resposta parseia corretamente, custo dentro do orçamento

### Abstração de Provedor

```python
from abc import ABC, abstractmethod
from tenacity import retry, stop_after_attempt, wait_exponential

class LLMProvider(ABC):
    @abstractmethod
    def complete(self, prompt: str, **kwargs) -> str:
        pass

@retry(stop=stop_after_attempt(3), wait=wait_exponential(min=1, max=10))
def call_llm_with_retry(provider: LLMProvider, prompt: str) -> str:
    return provider.complete(prompt)
```

### Gerenciamento de Custos

| Provedor | Custo de Entrada | Custo de Saída |
|----------|------------|-------------|
| GPT-4 | $0,03/1K | $0,06/1K |
| GPT-3.5 | $0,0005/1K | $0,0015/1K |
| Claude 3 Opus | $0,015/1K | $0,075/1K |
| Claude 3 Haiku | $0,00025/1K | $0,00125/1K |

---

## Implementação de Sistema RAG

Construa pipeline de geração aumentada por recuperação:

1. Escolha o banco de dados vetorial (Pinecone, Qdrant, Weaviate)
2. Selecione o modelo de embedding com base na relação qualidade/custo
3. Implemente estratégia de chunking de documentos
4. Crie pipeline de ingestão com extração de metadados
5. Construa recuperação com embedding de query
6. Adicione reranking para melhoria de relevância
7. Formate o contexto e envie para o LLM
8. **Validação:** Resposta referencia contexto recuperado, sem alucinações

### Seleção de Banco de Dados Vetorial

| Banco de Dados | Hospedagem | Escala | Latência | Melhor Para |
|----------|---------|-------|---------|----------|
| Pinecone | Gerenciado | Alta | Baixa | Produção, gerenciado |
| Qdrant | Ambos | Alta | Muito Baixa | Crítico em performance |
| Weaviate | Ambos | Alta | Baixa | Busca híbrida |
| Chroma | Self-hosted | Média | Baixa | Prototipagem |
| pgvector | Self-hosted | Média | Média | Postgres existente |

### Estratégias de Chunking

| Estratégia | Tamanho do Chunk | Sobreposição | Melhor Para |
|----------|------------|---------|----------|
| Fixo | 500-1000 tokens | 50-100 | Texto geral |
| Por sentença | 3-5 sentenças | 1 sentença | Texto estruturado |
| Semântico | Variável | Baseado em significado | Artigos de pesquisa |
| Recursivo | Hierárquico | Parent-child | Documentos longos |

---

## Monitoramento de Modelo

Monitore modelos em produção para drift e degradação:

1. Configure rastreamento de latência (p50, p95, p99)
2. Configure alertas de taxa de erro
3. Implemente detecção de drift nos dados de entrada
4. Rastreie mudanças na distribuição de predições
5. Registre ground truth quando disponível
6. Compare versões de modelo com métricas A/B
7. Configure gatilhos de retreinamento automatizados
8. **Validação:** Alertas disparam antes de degradação visível ao usuário

### Detecção de Drift

```python
from scipy.stats import ks_2samp

def detect_drift(reference, current, threshold=0.05):
    statistic, p_value = ks_2samp(reference, current)
    return {
        "drift_detected": p_value < threshold,
        "ks_statistic": statistic,
        "p_value": p_value
    }
```

### Thresholds de Alerta

| Métrica | Atenção | Crítico |
|--------|---------|----------|
| Latência p95 | > 100ms | > 200ms |
| Taxa de erro | > 0,1% | > 1% |
| PSI (drift) | > 0,1 | > 0,2 |
| Queda de acurácia | > 2% | > 5% |

---

## Documentação de Referência

### Padrões de Produção MLOps

`references/mlops_production_patterns.md` contém:

- Pipeline de implantação de modelo com manifestos Kubernetes
- Arquitetura de feature store com exemplos Feast
- Monitoramento de modelo com código de detecção de drift
- Infraestrutura de teste A/B com divisão de tráfego
- Pipeline de retreinamento automatizado com MLflow

### Guia de Integração de LLM

`references/llm_integration_guide.md` contém:

- Padrão de camada de abstração de provedor
- Estratégias de retry e fallback com tenacity
- Templates de prompt engineering (few-shot, CoT)
- Otimização de tokens com tiktoken
- Cálculo e rastreamento de custos

### Arquitetura de Sistema RAG

`references/rag_system_architecture.md` contém:

- Implementação do pipeline RAG com código
- Comparação e integração de banco de dados vetorial
- Estratégias de chunking (fixo, semântico, recursivo)
- Guia de seleção de modelo de embedding
- Padrões de busca híbrida e reranking

---

## Ferramentas

### Pipeline de Implantação de Modelo

```bash
python scripts/model_deployment_pipeline.py --model model.pkl --target staging
```

Gera artefatos de implantação: Dockerfile, manifestos Kubernetes, health checks.

### RAG System Builder

```bash
python scripts/rag_system_builder.py --config rag_config.yaml --analyze
```

Cria scaffolding do pipeline RAG com integração de vector store e lógica de recuperação.

### Suite de Monitoramento de ML

```bash
python scripts/ml_monitoring_suite.py --config monitoring.yaml --deploy
```

Configura detecção de drift, alertas e painéis de performance.

---

## Tech Stack

| Categoria | Ferramentas |
|----------|-------|
| Frameworks de ML | PyTorch, TensorFlow, Scikit-learn, XGBoost |
| Frameworks LLM | LangChain, LlamaIndex, DSPy |
| MLOps | MLflow, Weights & Biases, Kubeflow |
| Dados | Spark, Airflow, dbt, Kafka |
| Implantação | Docker, Kubernetes, Triton |
| Bancos de Dados | PostgreSQL, BigQuery, Pinecone, Redis |
