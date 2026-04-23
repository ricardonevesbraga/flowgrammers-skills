---
name: "rag-architect"
description: "Use quando o usuário pede para projetar pipelines RAG, otimizar estratégias de recuperação, escolher modelos de embedding, implementar busca vetorial ou construir sistemas de recuperação de conhecimento."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# RAG Architect - Skill de Nível PODEROSO

## Visão Geral

A skill RAG (Retrieval-Augmented Generation) Architect fornece ferramentas e conhecimento abrangentes para projetar, implementar e otimizar pipelines RAG de nível produção. Esta skill cobre todo o ecossistema RAG, desde estratégias de chunking de documentos até frameworks de avaliação, permitindo que você construa sistemas de recuperação escaláveis, eficientes e precisos.

## Competências Principais

### 1. Processamento de Documentos e Estratégias de Chunking

#### Chunking de Tamanho Fixo
- **Chunking por caractere**: Divisão simples por contagem de caracteres (ex.: 512, 1024, 2048 chars)
- **Chunking por token**: Divisão por contagem de tokens para respeitar limites do modelo
- **Estratégias de sobreposição**: 10-20% de sobreposição para manter continuidade de contexto
- **Prós**: Tamanhos de chunk previsíveis, implementação simples, tempo de processamento consistente
- **Contras**: Pode quebrar unidades semânticas, limites de contexto ignorados
- **Melhor para**: Documentos uniformes, quando tamanhos de chunk consistentes são críticos

#### Chunking Baseado em Frases
- **Detecção de limite de frase**: Usando NLTK, spaCy ou padrões regex
- **Agrupamento de frases**: Combinando frases até atingir o limite de tamanho
- **Preservação de parágrafos**: Evitando divisões no meio de parágrafos quando possível
- **Prós**: Preserva limites de linguagem natural, melhor legibilidade
- **Contras**: Tamanhos de chunk variáveis, potencial para chunks muito curtos/longos
- **Melhor para**: Texto narrativo, artigos, livros

#### Chunking Baseado em Parágrafos
- **Detecção de parágrafo**: Duas novas linhas, tags HTML, formatação markdown
- **Divisão hierárquica**: Respeitando a estrutura do documento (seções, subseções)
- **Balanceamento de tamanho**: Mesclando parágrafos pequenos, dividindo parágrafos grandes
- **Prós**: Preserva a estrutura lógica do documento, mantém coerência de tópico
- **Contras**: Tamanhos altamente variáveis, pode criar chunks muito grandes
- **Melhor para**: Documentos estruturados, documentação técnica

#### Chunking Semântico
- **Modelagem de tópicos**: Usando TF-IDF, similaridade de embeddings para detecção de tópicos
- **Divisão consciente de títulos**: Respeitando a hierarquia do documento (H1, H2, H3)
- **Limites baseados em conteúdo**: Detectando mudanças de tópico usando similaridade semântica
- **Prós**: Mantém coerência semântica, respeita a estrutura do documento
- **Contras**: Implementação complexa, computacionalmente caro
- **Melhor para**: Conteúdo longo, manuais técnicos, artigos de pesquisa

#### Chunking Recursivo
- **Abordagem hierárquica**: Tente chunks maiores primeiro, divida recursivamente se necessário
- **Divisão em múltiplos níveis**: Diferentes estratégias em diferentes níveis
- **Otimização de tamanho**: Minimize o número de chunks respeitando os limites de tamanho
- **Prós**: Utilização ótima de chunk, preserva contexto quando possível
- **Contras**: Lógica complexa, potencial overhead de desempenho
- **Melhor para**: Tipos de conteúdo mistos, quando otimização de contagem de chunks é importante

#### Chunking Consciente de Documento
- **Detecção de tipo de arquivo**: Páginas de PDF, seções de Word, elementos HTML
- **Preservação de metadados**: Cabeçalhos, rodapés, números de página, seções
- **Tratamento de tabela e imagem**: Processamento especial para elementos não textuais
- **Prós**: Preserva estrutura do documento e metadados
- **Contras**: Implementação específica de formato necessária
- **Melhor para**: Coleções de documentos multi-formato, quando metadados são importantes

### 2. Seleção de Modelo de Embedding

#### Considerações de Dimensão
- **128-256 dimensões**: Recuperação rápida, menor uso de memória, adequado para domínios simples
- **512-768 dimensões**: Desempenho equilibrado, bom para a maioria das aplicações
- **1024-1536 dimensões**: Alta qualidade, melhor para domínios complexos, maior custo
- **2048+ dimensões**: Qualidade máxima, casos de uso especializados, recursos significativos

#### Tradeoffs de Velocidade vs. Qualidade
- **Modelos rápidos**: sentence-transformers/all-MiniLM-L6-v2 (384 dim, ~14k tokens/seg)
- **Modelos equilibrados**: sentence-transformers/all-mpnet-base-v2 (768 dim, ~2.8k tokens/seg)
- **Modelos de qualidade**: text-embedding-ada-002 (1536 dim, API OpenAI)
- **Modelos especializados**: Modelos fine-tuned específicos de domínio

#### Categorias de Modelos
- **Propósito geral**: all-MiniLM, all-mpnet, Universal Sentence Encoder
- **Embeddings de código**: CodeBERT, GraphCodeBERT, CodeT5
- **Texto científico**: SciBERT, BioBERT, ClinicalBERT
- **Multilíngue**: LaBSE, multilingual-e5, paraphrase-multilingual

### 3. Seleção de Banco de Dados Vetorial

#### Pinecone
- **Serviço gerenciado**: Totalmente hospedado, auto-escalonamento
- **Funcionalidades**: Filtragem de metadados, busca híbrida, atualizações em tempo real
- **Preços**: $70/mês para 1M vetores (1536 dim), escalonamento pago por uso
- **Melhor para**: Aplicações de produção, quando serviço gerenciado é preferido
- **Contras**: Lock-in de fornecedor, custos podem escalar rapidamente

#### Weaviate
- **Open source**: Opções auto-hospedadas ou em nuvem disponíveis
- **Funcionalidades**: API GraphQL, busca multimodal, vetorização automática
- **Escalabilidade**: Escalonamento horizontal, indexação HNSW
- **Melhor para**: Tipos de dados complexos, quando API GraphQL é preferida
- **Contras**: Curva de aprendizado, requer gerenciamento de infraestrutura

#### Qdrant
- **Baseado em Rust**: Alto desempenho, baixo consumo de memória
- **Funcionalidades**: Filtragem de payload, clustering, implantação distribuída
- **API**: Interfaces REST e gRPC
- **Melhor para**: Requisitos de alto desempenho, ambientes com recursos limitados
- **Contras**: Comunidade menor, menos integrações

#### Chroma
- **Banco de dados embarcado**: Baseado em SQLite, fácil desenvolvimento local
- **Funcionalidades**: Coleções, filtragem de metadados, persistência
- **Escalabilidade**: Limitada, adequada para prototipagem e implantações pequenas
- **Melhor para**: Desenvolvimento, testes, aplicações de pequena escala
- **Contras**: Não adequado para escala de produção

#### pgvector (PostgreSQL)
- **Integração SQL**: Aproveite infraestrutura PostgreSQL existente
- **Funcionalidades**: Conformidade ACID, joins com dados relacionais, ecossistema maduro
- **Desempenho**: Indexação ivfflat e HNSW, processamento de consultas paralelo
- **Melhor para**: Quando você já usa PostgreSQL, precisa de conformidade ACID
- **Contras**: Requer expertise em PostgreSQL, menos especializado que bancos dedicados

### 4. Estratégias de Recuperação

#### Recuperação Densa
- **Similaridade semântica**: Usando similaridade de cosseno de embedding
- **Vantagens**: Captura significado semântico, lida bem com paráfrases
- **Limitações**: Pode perder correspondências exatas de palavras-chave, requer bons embeddings
- **Implementação**: Busca de similaridade vetorial com algoritmos k-NN ou ANN

#### Recuperação Esparsa
- **Baseada em palavras-chave**: TF-IDF, BM25, Elasticsearch
- **Vantagens**: Correspondência exata de palavras-chave, resultados interpretáveis
- **Limitações**: Perde similaridade semântica, vulnerável a incompatibilidade de vocabulário
- **Implementação**: Índices invertidos, análise de frequência de termos

#### Recuperação Híbrida
- **Abordagem combinada**: Recuperação densa + esparsa com fusão de pontuações
- **Estratégias de fusão**: Reciprocal Rank Fusion (RRF), combinação ponderada
- **Benefícios**: Combina compreensão semântica com correspondência exata
- **Complexidade**: Requer ajuste de pesos de fusão, infraestrutura mais complexa

#### Reranking
- **Abordagem em dois estágios**: Recuperação inicial seguida de reranking
- **Modelos de reranking**: Cross-encoders, transformers de reranking especializados
- **Benefícios**: Maior precisão, pode usar modelos mais sofisticados para classificação final
- **Tradeoff**: Latência adicional, custo computacional

### 5. Técnicas de Transformação de Consulta

#### HyDE (Hypothetical Document Embeddings)
- **Abordagem**: Gere resposta hipotética, faça embedding da resposta em vez da consulta
- **Benefícios**: Melhora a recuperação ao corresponder ao estilo do documento em vez do estilo da consulta
- **Implementação**: Use LLM para gerar documento hipotético, faça embedding desse
- **Casos de uso**: Quando consultas e documentos têm estilos diferentes

#### Geração de Múltiplas Consultas
- **Abordagem**: Gere múltiplas variações de consulta, recupere para cada uma, mescle resultados
- **Benefícios**: Aumenta o recall, lida com ambiguidade de consulta
- **Implementação**: LLM gera 3-5 variações de consulta, desduplique resultados
- **Considerações**: Maior custo e latência devido a múltiplas recuperações

#### Step-Back Prompting
- **Abordagem**: Gere versão mais ampla e geral de consulta específica
- **Benefícios**: Recupera contexto mais geral que ajuda a responder perguntas específicas
- **Implementação**: Transforme "Qual é a capital da França?" em "Quais são as capitais europeias?"
- **Casos de uso**: Quando perguntas específicas precisam de contexto geral

### 6. Otimização de Janela de Contexto

#### Montagem Dinâmica de Contexto
- **Ordenação por relevância**: Chunks mais relevantes primeiro
- **Otimização de diversidade**: Evite informações redundantes
- **Gerenciamento de orçamento de token**: Caiba dentro dos limites de contexto do modelo
- **Inclusão hierárquica**: Inclua resumos antes de chunks detalhados

#### Compressão de Contexto
- **Sumarização**: Comprima chunks menos relevantes preservando informações-chave
- **Extração de informações-chave**: Extraia apenas fatos/entidades relevantes
- **Compressão baseada em template**: Use formatos estruturados para reduzir uso de tokens
- **Inclusão seletiva**: Inclua apenas chunks acima do threshold de relevância

### 7. Frameworks de Avaliação

#### Métricas de Fidelidade
- **Definição**: Quão bem as respostas geradas estão fundamentadas no contexto recuperado
- **Medição**: Verificação de fatos contra documentos fonte
- **Implementação**: Modelos NLI para verificar implicação entre resposta e contexto
- **Threshold**: >90% para sistemas de produção

#### Métricas de Relevância
- **Relevância de contexto**: Quão relevantes são os chunks recuperados para a consulta
- **Relevância de resposta**: Quão bem a resposta aborda a pergunta original
- **Medição**: Similaridade de embedding, avaliação humana, LLM-como-juiz
- **Metas**: Relevância de contexto >0,8, Relevância de resposta >0,85

#### Precisão e Recall de Contexto
- **Precision@K**: Porcentagem dos K principais resultados que são relevantes
- **Recall@K**: Porcentagem de documentos relevantes encontrados nos K principais resultados
- **Mean Reciprocal Rank (MRR)**: Média das classificações recíprocas do primeiro resultado relevante
- **NDCG@K**: Normalized Discounted Cumulative Gain em K

#### Métricas de Ponta a Ponta
- **RAGAS**: Framework abrangente de avaliação de RAG
- **Correção**: Precisão factual das respostas geradas
- **Completude**: Cobertura de todos os aspectos relevantes
- **Consistência**: Consistência entre múltiplas execuções com a mesma consulta

### 8. Padrões de Produção

#### Estratégias de Cache
- **Cache no nível de consulta**: Cache de resultados para consultas idênticas
- **Cache semântico**: Cache para consultas semanticamente similares
- **Cache no nível de chunk**: Cache de computações de embedding
- **Cache em múltiplos níveis**: Redis para consultas quentes, disco para consultas mornas

#### Recuperação por Streaming
- **Carregamento progressivo**: Resultados de stream conforme ficam disponíveis
- **Geração incremental**: Gere respostas enquanto ainda recupera
- **Atualizações em tempo real**: Lide com atualizações de documentos sem reprocessamento completo
- **Gerenciamento de conexão**: Lide com desconexões de cliente graciosamente

#### Mecanismos de Fallback
- **Degradação graciosa**: Fallback para recuperação mais simples se a primária falhar
- **Fallbacks de cache**: Sirva resultados desatualizados quando a recuperação estiver indisponível
- **Fontes alternativas**: Múltiplos bancos de dados vetoriais para redundância
- **Tratamento de erros**: Recuperação abrangente de erros e comunicação ao usuário

### 9. Otimização de Custos

#### Gerenciamento de Custo de Embedding
- **Processamento em lote**: Agrupe documentos para embedding e reduza custos de API
- **Estratégias de cache**: Faça cache de embeddings para evitar recomputação
- **Seleção de modelo**: Equilibre custo vs. qualidade para modelos de embedding
- **Otimização de atualização**: Re-faça embedding apenas de documentos alterados

#### Otimização de Banco de Dados Vetorial
- **Otimização de índice**: Escolha tipos de índice adequados para o caso de uso
- **Compressão**: Use quantização para reduzir custos de armazenamento
- **Armazenamento em camadas**: Estratégias de dados quentes/mornos/frios
- **Escalabilidade de recursos**: Auto-escalonamento com base em padrões de consulta

#### Otimização de Consultas
- **Roteamento de consulta**: Roteie consultas simples para métodos mais baratos
- **Cache de resultados**: Evite recuperações caras repetidas
- **Consultas em lote**: Processe múltiplas consultas juntas quando possível
- **Filtragem inteligente**: Use filtros de metadados para reduzir o espaço de busca

### 10. Guardrails e Segurança

#### Filtragem de Conteúdo
- **Detecção de toxicidade**: Filtre conteúdo prejudicial ou inapropriado
- **Detecção de PII**: Identifique e lide com informações pessoalmente identificáveis
- **Validação de conteúdo**: Garanta que o conteúdo recuperado atenda aos padrões de qualidade
- **Verificação de fonte**: Valide autenticidade e confiabilidade do documento

#### Segurança de Consulta
- **Prevenção de injeção**: Previna ataques maliciosos de injeção de consulta
- **Limitação de taxa**: Previna abuso e garanta uso justo
- **Validação de consulta**: Sanitize e valide entradas de usuário
- **Controles de acesso**: Garanta que usuários possam acessar apenas conteúdo autorizado

#### Segurança de Resposta
- **Detecção de alucinação**: Identifique quando o modelo gera afirmações não suportadas
- **Pontuação de confiança**: Forneça níveis de confiança para respostas geradas
- **Atribuição de fonte**: Sempre forneça fontes para afirmações factuais
- **Tratamento de incerteza**: Lide graciosamente com casos onde a resposta é incerta

## Melhores Práticas de Implementação

### Fluxo de Trabalho de Desenvolvimento
1. **Levantamento de requisitos**: Entenda o caso de uso, escala e requisitos de qualidade
2. **Análise de dados**: Analise as características do corpus de documentos
3. **Desenvolvimento de protótipo**: Construa um pipeline RAG mínimo viável
4. **Otimização de chunking**: Teste diferentes estratégias de chunking
5. **Ajuste de recuperação**: Otimize parâmetros e thresholds de recuperação
6. **Configuração de avaliação**: Implemente métricas de avaliação abrangentes
7. **Implantação de produção**: Implementação pronta para escala com monitoramento

### Monitoramento e Observabilidade
- **Análise de consultas**: Rastreie padrões de consulta e desempenho
- **Métricas de recuperação**: Monitore precisão, recall e latência
- **Qualidade de geração**: Rastreie pontuações de fidelidade e relevância
- **Saúde do sistema**: Monitore desempenho e disponibilidade do banco de dados
- **Rastreamento de custos**: Monitore custos de embedding e banco de dados vetorial

### Manutenção e Atualizações
- **Atualização de documentos**: Lide com novos documentos e atualizações
- **Manutenção de índice**: Otimização regular do banco de dados vetorial
- **Atualizações de modelo**: Avalie e migre para modelos melhorados
- **Ajuste de desempenho**: Otimização contínua com base em padrões de uso
- **Atualizações de segurança**: Avaliações de segurança e atualizações regulares

## Problemas Comuns e Soluções

### Estratégia de Chunking Ruim
- **Problema**: Chunks quebram no meio de frases ou perdem contexto
- **Solução**: Use chunking consciente de limites com sobreposição

### Baixa Precisão de Recuperação
- **Problema**: Chunks recuperados não são relevantes para a consulta
- **Solução**: Melhore o modelo de embedding, adicione reranking, ajuste o threshold de similaridade

### Alta Latência
- **Problema**: Recuperação e geração lentas
- **Solução**: Otimize indexação vetorial, implemente cache, use modelos de embedding mais rápidos

### Qualidade Inconsistente
- **Problema**: Qualidade de resposta variável entre diferentes consultas
- **Solução**: Implemente avaliação abrangente, adicione pontuação de qualidade, melhore fallbacks

### Problemas de Escalabilidade
- **Problema**: O sistema não escala com o aumento da carga
- **Solução**: Implemente cache adequado, sharding de banco de dados e auto-escalonamento

## Conclusão

Construir sistemas RAG eficazes requer consideração cuidadosa de cada componente no pipeline. A chave para o sucesso é entender os tradeoffs entre diferentes abordagens e escolher a combinação certa de técnicas para seu caso de uso específico. Comece com abordagens simples e adicione sofisticação gradualmente com base em resultados de avaliação e requisitos de produção.

Esta skill fornece a base para tomar decisões informadas ao longo do ciclo de vida de desenvolvimento do RAG, desde o design inicial até a implantação em produção e manutenção contínua.
