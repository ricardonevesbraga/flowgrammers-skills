---
name: "api-design-reviewer"
description: "Revisão e análise completa de designs de API com foco em convenções REST, melhores práticas e padrões da indústria. Fornece linting automatizado, detecção de mudanças disruptivas e scorecards de design."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# API Design Reviewer

**Nível:** POWERFUL  
**Categoria:** Engineering / Architecture  

## Visão Geral

A skill API Design Reviewer fornece análise e revisão abrangente de designs de API, focando em convenções REST, melhores práticas e padrões da indústria. Esta skill ajuda equipes de engenharia a construir APIs consistentes, manuteníveis e bem projetadas por meio de linting automatizado, detecção de mudanças disruptivas e scorecards de design.

## Capacidades Principais

### 1. Linting de API e Análise de Convenções
- **Convenções de Nomenclatura de Recursos**: Aplica kebab-case para recursos, camelCase para campos
- **Uso de Métodos HTTP**: Valida uso adequado de GET, POST, PUT, PATCH, DELETE
- **Estrutura de URL**: Analisa padrões de endpoint para consistência e design RESTful
- **Conformidade de Status Code**: Garante uso de códigos de status HTTP apropriados
- **Formatos de Resposta de Erro**: Valida estruturas de resposta de erro consistentes
- **Cobertura de Documentação**: Verifica descrições ausentes e lacunas na documentação

### 2. Detecção de Mudanças Disruptivas
- **Remoção de Endpoints**: Detecta endpoints removidos ou depreciados
- **Mudanças no Shape de Resposta**: Identifica modificações nas estruturas de resposta
- **Remoção de Campos**: Rastreia campos removidos ou renomeados nas respostas da API
- **Mudanças de Tipo**: Detecta modificações de tipo de campo que podem quebrar clientes
- **Adições de Campos Obrigatórios**: Sinaliza novos campos obrigatórios que podem quebrar integrações existentes
- **Mudanças de Status Code**: Detecta mudanças nos status codes esperados

### 3. Pontuação e Avaliação de Design de API
- **Análise de Consistência** (30%): Avalia convenções de nomenclatura, padrões de resposta e consistência estrutural
- **Qualidade da Documentação** (20%): Avalia completude e clareza da documentação da API
- **Implementação de Segurança** (20%): Revisa autenticação, autorização e cabeçalhos de segurança
- **Design de Usabilidade** (15%): Analisa facilidade de uso, descoberta e experiência do desenvolvedor
- **Padrões de Desempenho** (15%): Avalia cache, paginação e padrões de eficiência

## Princípios de Design REST

### Convenções de Nomenclatura de Recursos
```
✅ Bons Exemplos:
- /api/v1/users
- /api/v1/user-profiles
- /api/v1/orders/123/line-items

❌ Maus Exemplos:
- /api/v1/getUsers
- /api/v1/user_profiles
- /api/v1/orders/123/lineItems
```

### Uso de Métodos HTTP
- **GET**: Recuperar recursos (seguro, idempotente)
- **POST**: Criar novos recursos (não idempotente)
- **PUT**: Substituir recursos inteiros (idempotente)
- **PATCH**: Atualizações parciais de recursos (não necessariamente idempotente)
- **DELETE**: Remover recursos (idempotente)

### Melhores Práticas de Estrutura de URL
```
Recursos de Coleção: /api/v1/users
Recursos Individuais: /api/v1/users/123
Recursos Aninhados: /api/v1/users/123/orders
Ações: /api/v1/users/123/activate (POST)
Filtragem: /api/v1/users?status=active&role=admin
```

## Estratégias de Versionamento

### 1. Versionamento por URL (Recomendado)
```
/api/v1/users
/api/v2/users
```
**Vantagens**: Claro, explícito, fácil de rotear  
**Desvantagens**: Proliferação de URLs, complexidade de cache

### 2. Versionamento por Header
```
GET /api/users
Accept: application/vnd.api+json;version=1
```
**Vantagens**: URLs limpas, negociação de conteúdo  
**Desvantagens**: Menos visível, mais difícil de testar manualmente

### 3. Versionamento por Media Type
```
GET /api/users
Accept: application/vnd.myapi.v1+json
```
**Vantagens**: RESTful, suporta múltiplas representações  
**Desvantagens**: Complexo, mais difícil de implementar

### 4. Versionamento por Parâmetro de Query
```
/api/users?version=1
```
**Vantagens**: Simples de implementar  
**Desvantagens**: Não é RESTful, pode ser ignorado

## Padrões de Paginação

### Paginação Baseada em Offset
```json
{
  "data": [...],
  "pagination": {
    "offset": 20,
    "limit": 10,
    "total": 150,
    "hasMore": true
  }
}
```

### Paginação Baseada em Cursor
```json
{
  "data": [...],
  "pagination": {
    "nextCursor": "eyJpZCI6MTIzfQ==",
    "hasMore": true
  }
}
```

### Paginação Baseada em Página
```json
{
  "data": [...],
  "pagination": {
    "page": 3,
    "pageSize": 10,
    "totalPages": 15,
    "totalItems": 150
  }
}
```

## Formatos de Resposta de Erro

### Estrutura de Erro Padrão
```json
{
  "error": {
    "code": "VALIDATION_ERROR",
    "message": "The request contains invalid parameters",
    "details": [
      {
        "field": "email",
        "code": "INVALID_FORMAT",
        "message": "Email address is not valid"
      }
    ],
    "requestId": "req-123456",
    "timestamp": "2024-02-16T13:00:00Z"
  }
}
```

### Uso de Códigos de Status HTTP
- **400 Bad Request**: Sintaxe de requisição ou parâmetros inválidos
- **401 Unauthorized**: Autenticação necessária
- **403 Forbidden**: Acesso negado (autenticado, mas não autorizado)
- **404 Not Found**: Recurso não encontrado
- **409 Conflict**: Conflito de recurso (duplicata, incompatibilidade de versão)
- **422 Unprocessable Entity**: Sintaxe válida, mas erros semânticos
- **429 Too Many Requests**: Limite de taxa excedido
- **500 Internal Server Error**: Erro inesperado do servidor

## Padrões de Autenticação e Autorização

### Autenticação por Bearer Token
```
Authorization: Bearer <token>
```

### Autenticação por API Key
```
X-API-Key: <api-key>
Authorization: Api-Key <api-key>
```

### Fluxo OAuth 2.0
```
Authorization: Bearer <oauth-access-token>
```

### Controle de Acesso Baseado em Papel (RBAC)
```json
{
  "user": {
    "id": "123",
    "roles": ["admin", "editor"],
    "permissions": ["read:users", "write:orders"]
  }
}
```

## Implementação de Rate Limiting

### Headers
```
X-RateLimit-Limit: 1000
X-RateLimit-Remaining: 999
X-RateLimit-Reset: 1640995200
```

### Resposta ao Exceder o Limite
```json
{
  "error": {
    "code": "RATE_LIMIT_EXCEEDED",
    "message": "Too many requests",
    "retryAfter": 3600
  }
}
```

## HATEOAS (Hypermedia as the Engine of Application State)

### Exemplo de Implementação
```json
{
  "id": "123",
  "name": "John Doe",
  "email": "john@example.com",
  "_links": {
    "self": { "href": "/api/v1/users/123" },
    "orders": { "href": "/api/v1/users/123/orders" },
    "profile": { "href": "/api/v1/users/123/profile" },
    "deactivate": { 
      "href": "/api/v1/users/123/deactivate",
      "method": "POST"
    }
  }
}
```

## Idempotência

### Métodos Idempotentes
- **GET**: Sempre seguro e idempotente
- **PUT**: Deve ser idempotente (substituir recurso inteiro)
- **DELETE**: Deve ser idempotente (mesmo resultado)
- **PATCH**: Pode ou não ser idempotente

### Chaves de Idempotência
```
POST /api/v1/payments
Idempotency-Key: 123e4567-e89b-12d3-a456-426614174000
```

## Diretrizes de Compatibilidade Retroativa

### Mudanças Seguras (Não Disruptivas)
- Adicionar campos opcionais às requisições
- Adicionar campos às respostas
- Adicionar novos endpoints
- Tornar campos obrigatórios opcionais
- Adicionar novos valores de enum (com tratamento gracioso)

### Mudanças Disruptivas (Requerem Bump de Versão)
- Remover campos das respostas
- Tornar campos opcionais obrigatórios
- Alterar tipos de campos
- Remover endpoints
- Alterar estruturas de URL
- Modificar formatos de resposta de erro

## Validação OpenAPI/Swagger

### Componentes Obrigatórios
- **Informações da API**: Título, descrição, versão
- **Informações do Servidor**: URLs base e descrições
- **Definições de Path**: Todos os endpoints com métodos
- **Definições de Parâmetro**: Parâmetros de query, path e header
- **Schemas de Request/Response**: Modelos de dados completos
- **Definições de Segurança**: Esquemas de autenticação
- **Respostas de Erro**: Formatos de erro padrão

### Melhores Práticas
- Usar convenções de nomenclatura consistentes
- Fornecer descrições detalhadas para todos os componentes
- Incluir exemplos para objetos complexos
- Definir componentes e schemas reutilizáveis
- Validar contra a especificação OpenAPI

## Considerações de Desempenho

### Estratégias de Cache
```
Cache-Control: public, max-age=3600
ETag: "123456789"
Last-Modified: Wed, 21 Oct 2015 07:28:00 GMT
```

### Transferência Eficiente de Dados
- Usar métodos HTTP apropriados
- Implementar seleção de campos (`?fields=id,name,email`)
- Suportar compressão (gzip)
- Implementar paginação eficiente
- Usar ETags para requisições condicionais

### Otimização de Recursos
- Evitar consultas N+1
- Implementar operações em lote
- Usar processamento assíncrono para operações pesadas
- Suportar atualizações parciais (PATCH)

## Melhores Práticas de Segurança

### Validação de Entrada
- Validar todos os parâmetros de entrada
- Sanitizar dados do usuário
- Usar consultas parametrizadas
- Implementar limites de tamanho de requisição

### Segurança de Autenticação
- Usar HTTPS em todo lugar
- Implementar armazenamento seguro de tokens
- Suportar expiração e refresh de tokens
- Usar mecanismos de autenticação fortes

### Controles de Autorização
- Implementar princípio do menor privilégio
- Usar permissões baseadas em recursos
- Suportar controle de acesso granular
- Auditar padrões de acesso

## Ferramentas e Scripts

### api_linter.py
Analisa especificações de API para conformidade com convenções REST e melhores práticas.

**Funcionalidades:**
- Validação de spec OpenAPI/Swagger
- Verificações de convenção de nomenclatura
- Validação de uso de método HTTP
- Consistência de formato de erro
- Análise de completude da documentação

### breaking_change_detector.py
Compara versões de especificação de API para identificar mudanças disruptivas.

**Funcionalidades:**
- Comparação de endpoints
- Detecção de mudanças de schema
- Rastreamento de remoção/modificação de campos
- Geração de guia de migração
- Avaliação de severidade de impacto

### api_scorecard.py
Fornece pontuação abrangente da qualidade do design de API.

**Funcionalidades:**
- Pontuação multidimensional
- Recomendações detalhadas de melhoria
- Avaliação por nota (A-F)
- Comparações de desempenho
- Rastreamento de progresso

## Exemplos de Integração

### Integração CI/CD
```yaml
- name: "api-linting"
  run: python scripts/api_linter.py openapi.json

- name: "breaking-change-detection"
  run: python scripts/breaking_change_detector.py openapi-v1.json openapi-v2.json

- name: "api-scorecard"
  run: python scripts/api_scorecard.py openapi.json
```

### Pre-commit Hooks
```bash
#!/bin/bash
python engineering/api-design-reviewer/scripts/api_linter.py api/openapi.json
if [ $? -ne 0 ]; then
  echo "API linting failed. Please fix the issues before committing."
  exit 1
fi
```

## Resumo de Melhores Práticas

1. **Consistência Primeiro**: Manter nomenclatura, formatos de resposta e padrões consistentes
2. **Documentação**: Fornecer documentação de API abrangente e atualizada
3. **Versionamento**: Planejar a evolução com estratégias claras de versionamento
4. **Tratamento de Erros**: Implementar respostas de erro consistentes e informativas
5. **Segurança**: Construir segurança em cada camada da API
6. **Desempenho**: Projetar para escala e eficiência desde o início
7. **Compatibilidade Retroativa**: Minimizar mudanças disruptivas e fornecer caminhos de migração
8. **Testes**: Implementar testes abrangentes incluindo testes de contrato
9. **Monitoramento**: Adicionar observabilidade para uso e desempenho da API
10. **Experiência do Desenvolvedor**: Priorizar facilidade de uso e documentação clara

## Anti-Padrões a Evitar

1. **URLs Baseadas em Verbos**: Use substantivos para recursos, não ações
2. **Formatos de Resposta Inconsistentes**: Manter estruturas de resposta padrão
3. **Aninhamento Excessivo**: Evitar hierarquias de recursos profundamente aninhadas
4. **Ignorar Status Codes HTTP**: Usar status codes apropriados para diferentes cenários
5. **Mensagens de Erro Ruins**: Fornecer informações de erro específicas e acionáveis
6. **Paginação Ausente**: Sempre paginar endpoints de lista
7. **Sem Estratégia de Versionamento**: Planejar a evolução da API desde o primeiro dia
8. **Expor Estrutura Interna**: Projetar APIs para consumo externo, não conveniência interna
9. **Rate Limiting Ausente**: Proteger sua API contra abuso e sobrecarga
10. **Testes Inadequados**: Testar todos os aspectos incluindo casos de erro e condições extremas

## Conclusão

A skill API Design Reviewer fornece um framework abrangente para construir, revisar e manter APIs REST de alta qualidade. Seguindo estas diretrizes e usando as ferramentas fornecidas, equipes de desenvolvimento podem criar APIs consistentes, bem documentadas, seguras e manuteníveis.

O uso regular das ferramentas de linting, detecção de mudanças disruptivas e pontuação garante melhoria contínua e ajuda a manter a qualidade da API ao longo do ciclo de vida de desenvolvimento.
