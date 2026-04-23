---
name: "pr-review-expert"
description: "Use quando o usuário pede para revisar pull requests, analisar mudanças de código, verificar questões de segurança em PRs, ou avaliar a qualidade do código de diffs."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# PR Review Expert

**Nível:** PODEROSO
**Categoria:** Engenharia
**Domínio:** Revisão de Código / Garantia de Qualidade

---

## Visão Geral

Revisão de código estruturada e sistemática para PRs do GitHub e MRs do GitLab. Vai além de comentários de estilo — esta skill realiza análise de raio de impacto, varredura de segurança, detecção de mudanças disruptivas e cálculo de delta de cobertura de testes. Produz um relatório pronto para revisores com uma lista de verificação de mais de 30 itens e achados priorizados.

---

## Capacidades Principais

- **Análise de raio de impacto** — rastreie quais arquivos, serviços e consumidores downstream podem quebrar
- **Varredura de segurança** — SQL injection, XSS, bypass de auth, exposição de segredos, vulnerabilidades de dependências
- **Delta de cobertura de testes** — proporção entre novo código e novos testes
- **Detecção de mudanças disruptivas** — contratos de API, migrações de esquema de banco de dados, chaves de configuração
- **Vinculação de tickets** — verifique se o ticket Jira/Linear existe e corresponde ao escopo
- **Impacto no desempenho** — consultas N+1, regressão de tamanho de bundle, alocações de memória

---

## Quando Usar

- Antes de mesclar qualquer PR/MR que toque bibliotecas compartilhadas, APIs ou esquema de banco de dados
- Quando um PR é grande (mais de 200 linhas alteradas) e precisa de revisão estruturada
- Integrando novos colaboradores cujos PRs precisam de feedback completo
- Caminhos de código sensíveis à segurança (auth, pagamentos, tratamento de PII)
- Após um incidente — revisar PRs similares de forma proativa

---

## Obtendo o Diff

### GitHub (gh CLI)
```bash
# Ver diff no terminal
gh pr diff <PR_NUMBER>

# Obter metadados do PR (título, body, labels, issues vinculados)
gh pr view <PR_NUMBER> --json title,body,labels,assignees,milestone

# Listar arquivos alterados
gh pr diff <PR_NUMBER> --name-only

# Verificar status do CI
gh pr checks <PR_NUMBER>

# Baixar diff para arquivo para análise
gh pr diff <PR_NUMBER> > /tmp/pr-<PR_NUMBER>.diff
```

### GitLab (glab CLI)
```bash
# Ver diff do MR
glab mr diff <MR_IID>

# Detalhes do MR como JSON
glab mr view <MR_IID> --output json

# Listar arquivos alterados
glab mr diff <MR_IID> --name-only

# Baixar diff
glab mr diff <MR_IID> > /tmp/mr-<MR_IID>.diff
```

---

## Fluxo de Trabalho

### Passo 1: Buscar Contexto

```bash
PR=123
gh pr view $PR --json title,body,labels,milestone,assignees | jq .
gh pr diff $PR --name-only
gh pr diff $PR > /tmp/pr-$PR.diff
```

### Passo 2: Análise de Raio de Impacto

Para cada arquivo alterado, identifique:

1. **Dependentes diretos** — quem importa este arquivo?
```bash
# Encontrar todos os arquivos que importam um módulo alterado
grep -r "from ['\"].*changed-module['\"]" src/ --include="*.ts" -l
grep -r "require(['\"].*changed-module" src/ --include="*.js" -l

# Python
grep -r "from changed_module import\|import changed_module" . --include="*.py" -l
```

2. **Limites de serviço** — esta mudança cruza um serviço?
```bash
# Verificar se os arquivos alterados abrangem múltiplos serviços (monorepo)
gh pr diff $PR --name-only | cut -d/ -f1-2 | sort -u
```

3. **Contratos compartilhados** — tipos, interfaces, esquemas
```bash
gh pr diff $PR --name-only | grep -E "types/|interfaces/|schemas/|models/"
```

**Severidade do raio de impacto:**
- CRÍTICO — biblioteca compartilhada, modelo de banco de dados, middleware de auth, contrato de API
- ALTO     — serviço usado por mais de 3 outros, configuração compartilhada, variáveis de ambiente
- MÉDIO   — mudança interna de um único serviço, função utilitária
- BAIXO    — componente de UI, arquivo de teste, documentação

### Passo 3: Varredura de Segurança

```bash
DIFF=/tmp/pr-$PR.diff

# SQL Injection — interpolação de string de consulta bruta
grep -n "query\|execute\|raw(" $DIFF | grep -E '\$\{|f"|%s|format\('

# Segredos hardcoded
grep -nE "(password|secret|api_key|token|private_key)\s*=\s*['\"][^'\"]{8,}" $DIFF

# Padrão de chave AWS
grep -nE "AKIA[0-9A-Z]{16}" $DIFF

# Segredo JWT no código
grep -nE "jwt\.sign\(.*['\"][^'\"]{20,}['\"]" $DIFF

# Vetores XSS (para detectar e corrigir nos PRs revisados)
grep -n "innerHTML\s*=" $DIFF

# Padrões de bypass de auth
grep -n "bypass\|skip.*auth\|noauth\|TODO.*auth" $DIFF

# Algoritmos de hash inseguros
grep -nE "md5\(|sha1\(|createHash\(['\"]md5|createHash\(['\"]sha1" $DIFF

# eval / exec
grep -nE "\beval\(|\bexec\(|\bsubprocess\.call\(" $DIFF

# Poluição de protótipo
grep -n "__proto__\|constructor\[" $DIFF

# Risco de path traversal
grep -nE "path\.join\(.*req\.|readFile\(.*req\." $DIFF
```

### Passo 4: Delta de Cobertura de Testes

```bash
# Contar arquivos fonte vs. de teste alterados
CHANGED_SRC=$(gh pr diff $PR --name-only | grep -vE "\.test\.|\.spec\.|__tests__")
CHANGED_TESTS=$(gh pr diff $PR --name-only | grep -E "\.test\.|\.spec\.|__tests__")

echo "Arquivos fonte alterados: $(echo "$CHANGED_SRC" | wc -w)"
echo "Arquivos de teste alterados:   $(echo "$CHANGED_TESTS" | wc -w)"

# Linhas de nova lógica vs. novas linhas de teste
LOGIC_LINES=$(grep "^+" /tmp/pr-$PR.diff | grep -v "^+++" | wc -l)
echo "Novas linhas adicionadas: $LOGIC_LINES"

# Executar cobertura localmente
npm test -- --coverage --changedSince=main 2>/dev/null | tail -20
pytest --cov --cov-report=term-missing 2>/dev/null | tail -20
```

**Regras de delta de cobertura:**
- Nova função sem testes → sinalizar
- Testes deletados sem código deletado → sinalizar
- Queda de cobertura maior que 5% → bloquear mesclagem
- Caminhos de auth/pagamentos → exigir 100% de cobertura

### Passo 5: Detecção de Mudanças Disruptivas

#### Mudanças de Contrato de API
```bash
# Mudanças de spec OpenAPI/Swagger
grep -n "openapi\|swagger" /tmp/pr-$PR.diff | head -20

# Remoções ou renomeações de rotas REST
grep "^-" /tmp/pr-$PR.diff | grep -E "router\.(get|post|put|delete|patch)\("

# Remoções de esquema GraphQL
grep "^-" /tmp/pr-$PR.diff | grep -E "^-\s*(type |field |Query |Mutation )"

# Remoções de interface TypeScript
grep "^-" /tmp/pr-$PR.diff | grep -E "^-\s*(export\s+)?(interface|type) "
```

#### Mudanças de Esquema de Banco de Dados
```bash
# Arquivos de migração adicionados
gh pr diff $PR --name-only | grep -E "migrations?/|alembic/|knex/"

# Operações destrutivas
grep -E "DROP TABLE|DROP COLUMN|ALTER.*NOT NULL|TRUNCATE" /tmp/pr-$PR.diff

# Remoções de índice (risco de regressão de desempenho)
grep "DROP INDEX\|remove_index" /tmp/pr-$PR.diff
```

#### Mudanças de Config / Variáveis de Ambiente
```bash
# Novas variáveis de ambiente referenciadas no código (podem estar faltando em prod)
grep "^+" /tmp/pr-$PR.diff | grep -oE "process\.env\.[A-Z_]+" | sort -u

# Variáveis de ambiente removidas (podem quebrar instâncias em execução)
grep "^-" /tmp/pr-$PR.diff | grep -oE "process\.env\.[A-Z_]+" | sort -u
```

### Passo 6: Impacto no Desempenho

```bash
# Padrões de consulta N+1 (chamadas de banco de dados dentro de loops)
grep -n "\.find\|\.findOne\|\.query\|db\." /tmp/pr-$PR.diff | grep "^+" | head -20
# Em seguida verifique o contexto ao redor para loops forEach/map/for

# Novas dependências pesadas
grep "^+" /tmp/pr-$PR.diff | grep -E '"[a-z@].*":\s*"[0-9^~]' | head -20

# Loops ilimitados
grep -n "while (true\|while(true" /tmp/pr-$PR.diff | grep "^+"

# await ausente (promises acidentalmente sequenciais)
grep -n "await.*await" /tmp/pr-$PR.diff | grep "^+" | head -10

# Alocações grandes em memória
grep -n "new Array([0-9]\{4,\}\|Buffer\.alloc" /tmp/pr-$PR.diff | grep "^+"
```

---

## Verificação de Vinculação de Ticket

```bash
# Extrair referências de ticket do body do PR
gh pr view $PR --json body | jq -r '.body' | \
  grep -oE "(PROJ-[0-9]+|[A-Z]+-[0-9]+|https://linear\.app/[^)\"]+)" | sort -u

# Verificar se o ticket Jira existe (requer JIRA_API_TOKEN)
TICKET="PROJ-123"
curl -s -u "user@company.com:$JIRA_API_TOKEN" \
  "https://your-org.atlassian.net/rest/api/3/issue/$TICKET" | \
  jq '{key, summary: .fields.summary, status: .fields.status.name}'
```

---

## Lista de Verificação Completa de Revisão (30+ Itens)

```markdown
## Lista de Verificação de Revisão de Código

### Escopo e Contexto
- [ ] O título do PR descreve com precisão a mudança
- [ ] A descrição do PR explica o POR QUÊ, não apenas o O QUÊ
- [ ] O ticket Jira/Linear vinculado existe e corresponde ao escopo
- [ ] Sem mudanças não relacionadas (scope creep)
- [ ] Mudanças disruptivas documentadas no body do PR

### Raio de Impacto
- [ ] Identificados todos os arquivos que importam módulos alterados
- [ ] Dependências entre serviços verificadas
- [ ] Tipos/interfaces/esquemas compartilhados revisados para quebras
- [ ] Novas variáveis de ambiente documentadas em .env.example
- [ ] Migrações de banco de dados são reversíveis (têm down() / rollback)

### Segurança
- [ ] Sem segredos ou chaves de API hardcoded
- [ ] Consultas SQL usam entradas parametrizadas (sem interpolação de string)
- [ ] Entradas de usuário validadas/sanitizadas antes do uso
- [ ] Verificações de auth/autorização em todos os novos endpoints
- [ ] Sem vetores XSS (manipulação insegura de innerHTML)
- [ ] Novas dependências verificadas quanto a CVEs conhecidos
- [ ] Sem dados sensíveis nos logs (PII, tokens, senhas)
- [ ] Uploads de arquivo validados (tipo, tamanho, content-type)
- [ ] CORS configurado corretamente para novos endpoints

### Testes
- [ ] Novas funções públicas têm testes unitários
- [ ] Casos extremos cobertos (vazio, nulo, valores máximos)
- [ ] Caminhos de erro testados (não apenas o caminho feliz)
- [ ] Testes de integração para mudanças de endpoint de API
- [ ] Sem testes deletados sem motivo claro
- [ ] Nomes de testes descrevem claramente o que verificam

### Mudanças Disruptivas
- [ ] Sem endpoints de API removidos sem aviso de depreciação
- [ ] Sem campos obrigatórios adicionados a respostas de API existentes
- [ ] Sem colunas de banco de dados removidas sem plano de migração em duas fases
- [ ] Sem variáveis de ambiente removidas que possam estar definidas em produção
- [ ] Compatível retroativamente para consumidores de API externos

### Desempenho
- [ ] Sem padrões de consulta N+1 introduzidos
- [ ] Índices de banco de dados adicionados para novos padrões de consulta
- [ ] Sem loops ilimitados em conjuntos de dados potencialmente grandes
- [ ] Sem novas dependências pesadas sem justificativa
- [ ] Operações assíncronas corretamente aguardadas
- [ ] Cache considerado para operações repetidas caras

### Qualidade do Código
- [ ] Sem código morto ou importações não utilizadas
- [ ] Tratamento de erros presente (sem blocos catch vazios)
- [ ] Consistente com padrões e convenções existentes
- [ ] Lógica complexa tem comentários explicativos
- [ ] Sem TODOs não resolvidos (ou rastreados em ticket)
```

---

## Formato de Saída

Estruture seu comentário de revisão assim:

```
## Revisão do PR: [Título do PR] (#NÚMERO)

Raio de Impacto: ALTO — altera lib/auth usada por 5 serviços
Segurança: 1 achado (severidade média)
Testes: Delta de cobertura +2%
Mudanças Disruptivas: Nenhuma detectada

--- DEVE CORRIGIR (Bloqueante) ---

1. Risco de SQL Injection em src/db/users.ts:42
   Interpolação de string bruta na cláusula WHERE.
   Correção: db.query("SELECT * WHERE id = $1", [userId])

--- DEVERIA CORRIGIR (Não bloqueante) ---

2. Verificação de auth ausente em POST /api/admin/reset
   Sem verificação de papel antes de operação destrutiva.

--- SUGESTÕES ---

3. Padrão N+1 em src/services/reports.ts:88
   findUser() chamado dentro de results.map() — agrupe com findManyUsers(ids)

--- ESTÁ BOM ---
- Cobertura de testes para novo fluxo de auth é completa
- Migração de banco de dados tem método down() adequado para rollback
- Tratamento de erros consistente com o resto da base de código
```

---

## Armadilhas Comuns

- **Revisar estilo em vez de substância** — deixe o linter lidar com estilo; foque em lógica, segurança, correção
- **Ignorar o raio de impacto** — uma mudança de 5 linhas em um utilitário compartilhado pode quebrar 20 serviços
- **Aprovar caminhos felizes não testados** — sempre verifique se os caminhos de erro têm cobertura
- **Ignorar risco de migração** — adições NOT NULL precisam de um padrão ou plano de migração em duas fases
- **Exposição indireta de segredos** — segredos em mensagens de erro/logs, não apenas valores hardcoded
- **Pular PRs grandes** — se um PR é grande demais para revisar adequadamente, peça que seja dividido

---

## Melhores Práticas

1. Leia o ticket vinculado antes de olhar para o código — contexto previne falsos positivos
2. Verifique o status do CI antes de revisar — não revise código que falha ao construir
3. Priorize raio de impacto e segurança sobre estilo
4. Reproduza localmente para mudanças não triviais de auth ou desempenho
5. Rotule cada comentário claramente: "nit:", "must:", "question:", "suggestion:"
6. Agrupe todos os comentários em uma rodada de revisão — não filtre feedback
7. Reconheça bons padrões, não apenas problemas — elogios específicos melhoram a cultura
