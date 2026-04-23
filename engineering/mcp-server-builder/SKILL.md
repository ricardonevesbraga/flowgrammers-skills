---
name: "mcp-server-builder"
description: "Construtor de servidores MCP. Use para projetar e entregar servidores MCP prontos para produção a partir de contratos de API, em vez de wrappers manuais de ferramentas. Foca em scaffolding rápido, qualidade de esquema, validação e evolução segura."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# MCP Server Builder

**Nível:** PODEROSO
**Categoria:** Engenharia
**Domínio:** IA / Integração de API

## Visão Geral

Use esta skill para projetar e entregar servidores MCP prontos para produção a partir de contratos de API, em vez de wrappers manuais de ferramentas avulsos. O foco está em scaffolding rápido, qualidade de esquema, validação e evolução segura.

O fluxo de trabalho suporta implementações MCP tanto em Python quanto em TypeScript e trata o OpenAPI como fonte da verdade.

## Capacidades Principais

- Converter caminhos/operações OpenAPI em definições de ferramentas MCP
- Gerar scaffolds iniciais de servidor (Python ou TypeScript)
- Garantir consistência de nomenclatura, descrições e esquema
- Validar manifestos de ferramentas MCP para falhas comuns em produção
- Aplicar verificações de versionamento e compatibilidade retroativa
- Separar decisões de transporte/runtime do design de contrato de ferramenta

## Quando Usar

- Você precisa expor uma API REST interna/externa a um agente LLM
- Você está substituindo automação de navegador frágil por ferramentas tipadas
- Você quer um servidor MCP compartilhado entre equipes e assistentes
- Você precisa de verificações de qualidade repetíveis antes de publicar ferramentas MCP
- Você quer inicializar um servidor MCP a partir de specs OpenAPI existentes

## Fluxos de Trabalho Principais

### 1. OpenAPI para Scaffold MCP

1. Comece com uma spec OpenAPI válida.
2. Gere o manifesto de ferramentas + código inicial do servidor.
3. Revise a nomenclatura e a estratégia de autenticação.
4. Adicione lógica de runtime específica do endpoint.

```bash
python3 scripts/openapi_to_mcp.py \
  --input openapi.json \
  --server-name billing-mcp \
  --language python \
  --output-dir ./out \
  --format text
```

Também suporta stdin:

```bash
cat openapi.json | python3 scripts/openapi_to_mcp.py --server-name billing-mcp --language typescript
```

### 2. Validar Definições de Ferramentas MCP

Execute o validador antes dos testes de integração:

```bash
python3 scripts/mcp_validator.py --input out/tool_manifest.json --strict --format text
```

As verificações incluem nomes duplicados, formato de esquema inválido, descrições ausentes, campos obrigatórios vazios e higiene de nomenclatura.

### 3. Seleção de Runtime

- Escolha **Python** para iteração rápida e backends com muitos dados.
- Escolha **TypeScript** para stacks JS unificados e maior reutilização de contrato frontend/backend.
- Mantenha contratos de ferramentas estáveis mesmo que transporte/runtime mude.

### 4. Design de Autenticação e Segurança

- Mantenha segredos em variáveis de ambiente, não nos esquemas de ferramentas.
- Prefira listas de permissão explícitas para hosts de saída.
- Retorne erros estruturados (`code`, `message`, `details`) para recuperação do agente.
- Evite operações destrutivas sem entradas de confirmação explícitas.

### 5. Estratégia de Versionamento

- Campos aditivos apenas para atualizações não disruptivas.
- Nunca renomeie nomes de ferramentas no local.
- Introduza novos IDs de ferramentas para mudanças de comportamento disruptivas.
- Mantenha changelog de contratos de ferramentas por release.

## Interfaces de Script

- `python3 scripts/openapi_to_mcp.py --help`
  - Lê OpenAPI do stdin ou `--input`
  - Produz manifesto + scaffold do servidor
  - Emite resumo JSON ou relatório em texto
- `python3 scripts/mcp_validator.py --help`
  - Valida manifestos e configuração de runtime opcional
  - Retorna saída não-zero no modo strict quando há erros

## Armadilhas Comuns

1. Nomes de ferramentas derivados diretamente de caminhos brutos (`get__v1__users___id`)
2. Descrições de operação ausentes (agentes escolhem ferramentas mal)
3. Esquemas de parâmetros ambíguos sem campos obrigatórios
4. Mistura de erros de transporte e erros de domínio em uma mensagem opaca
5. Construção de contratos de ferramentas que expõem valores secretos
6. Quebra de clientes ao alterar chaves de esquema sem versionamento

## Melhores Práticas

1. Use `operationId` como nome canônico da ferramenta quando disponível.
2. Mantenha um intento de tarefa por ferramenta; evite mega-ferramentas.
3. Adicione descrições concisas com verbos de ação.
4. Valide contratos no CI usando o modo strict.
5. Mantenha o scaffold gerado comprometido, depois personalize incrementalmente.
6. Combine mudanças de contrato com entradas no changelog.

## Material de Referência

- [references/openapi-extraction-guide.md](references/openapi-extraction-guide.md)
- [references/python-server-template.md](references/python-server-template.md)
- [references/typescript-server-template.md](references/typescript-server-template.md)
- [references/validation-checklist.md](references/validation-checklist.md)
- [README.md](README.md)

## Decisões de Arquitetura

Escolha a abordagem do servidor por restrição:

- Runtime Python: iteração mais rápida, pipelines de dados, equipes com backend pesado
- Runtime TypeScript: tipos compartilhados com stack JS, equipes com frontend pesado
- Servidor MCP único: operações mais simples, maior raio de impacto
- Servidores de domínio separados: propriedade mais clara e limites de mudança mais seguros

## Portões de Qualidade do Contrato

Antes de publicar um manifesto:

1. Cada ferramenta tem nome claro com verbo primeiro.
2. A descrição de cada ferramenta explica o intento e o resultado esperado.
3. Cada campo obrigatório é explicitamente tipado.
4. Ações destrutivas incluem parâmetros de confirmação.
5. O formato de payload de erro é consistente em todas as ferramentas.
6. O validador retorna zero erros no modo strict.

## Estratégia de Testes

- Unitário: valide a transformação de operação OpenAPI para esquema de ferramenta MCP.
- Contrato: faça snapshot de `tool_manifest.json` e revise diffs no PR.
- Integração: chame os handlers de ferramentas gerados contra a API de staging.
- Resiliência: simule erros upstream 4xx/5xx e verifique respostas estruturadas.

## Práticas de Implantação

- Fixe as dependências do runtime MCP por ambiente.
- Implante atualizações do servidor atrás de endpoint/processo versionado.
- Mantenha compatibilidade retroativa por no mínimo uma janela de release.
- Adicione notas de changelog para contratos de ferramentas novos/removidos/alterados.

## Controles de Segurança

- Mantenha a lista de permissão de hosts de saída explícita.
- Não faça proxy de URLs arbitrários a partir de entradas fornecidas pelo usuário.
- Remova segredos e cabeçalhos de autenticação dos logs.
- Limite a taxa de ferramentas de alto custo e adicione timeouts de requisição.
