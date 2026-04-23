---
name: "promote"
description: "Graduar um padrão comprovado da auto-memória (MEMORY.md) para CLAUDE.md ou .claude/rules/ para aplicação permanente."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# /si:promote — Graduar Aprendizados para Regras

Move um padrão comprovado da auto-memória do Claude para o sistema de regras do projeto, onde se torna uma instrução aplicada em vez de uma nota de contexto.

## Uso

```
/si:promote <descrição do padrão>                    # Detectar automaticamente o melhor alvo
/si:promote <padrão> --target claude.md             # Promover para CLAUDE.md
/si:promote <padrão> --target rules/testing.md      # Promover para regra escopada
/si:promote <padrão> --target rules/api.md --paths "src/api/**/*.ts"  # Escopado com caminhos
```

## Fluxo de Trabalho

### Passo 1: Entender o padrão

Analisar a descrição do usuário. Se for vaga, fazer uma pergunta de esclarecimento:
- "Qual comportamento específico o Claude deve seguir?"
- "Isso se aplica a todos os arquivos ou a caminhos específicos?"

### Passo 2: Encontrar o padrão na auto-memória

```bash
# Pesquisar MEMORY.md por entradas relacionadas
MEMORY_DIR="$HOME/.claude/projects/$(pwd | sed 's|/|%2F|g; s|%2F|/|; s|^/||')/memory"
grep -ni "<palavras-chave>" "$MEMORY_DIR/MEMORY.md"
```

Mostrar as entradas correspondentes e confirmar que são o que o usuário quer dizer.

### Passo 3: Determinar o alvo correto

| Escopo do padrão | Alvo | Exemplo |
|---|---|---|
| Aplica-se ao projeto inteiro | `./CLAUDE.md` | "Use pnpm, não npm" |
| Aplica-se a tipos de arquivo específicos | `.claude/rules/<tópico>.md` | "Handlers de API precisam de validação" |
| Aplica-se a todos os seus projetos | `~/.claude/CLAUDE.md` | "Prefira tratamento de erro explícito" |

Se o usuário não especificou um alvo, recomendar um com base no escopo.

### Passo 4: Destilar em uma regra concisa

Transformar o aprendizado do formato de nota do MEMORY.md para o formato de instrução do CLAUDE.md:

**Antes** (MEMORY.md — descritivo):
> O projeto usa workspaces pnpm. Quando tentei npm install falhou. O arquivo de lock é pnpm-lock.yaml. Devo usar pnpm install para dependências.

**Depois** (CLAUDE.md — prescritivo):
```markdown
## Build & Dependências
- Gerenciador de pacotes: pnpm (não npm). Use `pnpm install`.
```

**Regras para destilação:**
- Uma linha por regra quando possível
- Voz imperativa ("Use X", "Sempre Y", "Nunca Z")
- Inclua o comando ou exemplo, não apenas o conceito
- Sem histórico — apenas a instrução

### Passo 5: Escrever no alvo

**Para CLAUDE.md:**
1. Ler o CLAUDE.md existente
2. Encontrar a seção apropriada (ou criar uma)
3. Acrescentar a nova regra sob o cabeçalho correto
4. Se o arquivo exceder 200 linhas, sugerir usar `.claude/rules/`

**Para `.claude/rules/`:**
1. Criar o arquivo se não existir
2. Adicionar frontmatter YAML com `paths` se escopado
3. Escrever o conteúdo da regra

```markdown
---
paths:
  - "src/api/**/*.ts"
  - "tests/api/**/*"
---

# Regras de Desenvolvimento de API

- Todos os endpoints devem validar a entrada com schemas Zod
- Use a classe `ApiError` para respostas de erro (não Error puro)
- Inclua comentários JSDoc OpenAPI nas funções de handler
```

### Passo 6: Limpar a auto-memória

Após promover, remover ou marcar a entrada original no MEMORY.md:

```bash
# Mostrar o que será removido
grep -n "<padrão>" "$MEMORY_DIR/MEMORY.md"
```

Pedir confirmação ao usuário para remoção. Então editar o MEMORY.md para remover a entrada promovida. Isso libera espaço para novos aprendizados.

### Passo 7: Confirmar

```
Promovido para {{alvo}}

Regra: "{{regra destilada}}"
Origem: MEMORY.md linha {{n}} (removida)
MEMORY.md: {{linhas}}/200 linhas restantes

O padrão agora é uma instrução aplicada. O Claude irá segui-la em todas as sessões futuras.
```

## Guia de Decisão de Promoção

### Promover quando:
- O padrão apareceu 3+ vezes na auto-memória
- Você corrigiu o Claude sobre isso mais de uma vez
- É uma convenção do projeto que qualquer colaborador deveria saber
- Previne um erro recorrente

### Não promover quando:
- É uma nota de debugging pontual (deixar na auto-memória)
- É contexto específico de sessão (a memória de sessão cuida disso)
- Pode mudar em breve (ex.: durante uma migração)
- Já está coberto por regras existentes

### CLAUDE.md vs .claude/rules/

| Use CLAUDE.md para | Use .claude/rules/ para |
|---|---|
| Regras globais do projeto | Padrões específicos por tipo de arquivo |
| Comandos de build | Convenções de testes |
| Decisões de arquitetura | Regras de design de API |
| Convenções da equipe | Gotchas específicos de framework |

## Dicas

- Mantenha CLAUDE.md com menos de 200 linhas — use rules/ para overflow
- Uma regra por linha é mais fácil de manter do que parágrafos
- Inclua o comando concreto, não apenas o conceito
- Revise as regras promovidas trimestralmente — remova o que não é mais relevante
