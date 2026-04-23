---
name: "remember"
description: "Salvar explicitamente conhecimento importante na auto-memória com timestamp e contexto. Use quando uma descoberta é importante demais para depender da captura automática."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# /si:remember — Salvar Conhecimento Explicitamente

Escreve uma entrada explícita na auto-memória quando algo é importante o suficiente para não querer depender do Claude percebendo automaticamente.

## Uso

```
/si:remember <o que lembrar>
/si:remember "O CI deste projeto requer Node 20 LTS — v22 quebra o build"
/si:remember "O endpoint /api/auth usa uma biblioteca JWT personalizada, não passport"
/si:remember "Reza prefere tratamento de erro explícito a padrões try-catch genéricos"
```

## Quando Usar

| Situação | Exemplo |
|-----------|---------|
| Insight de debugging difícil de obter | "Erros CORS em /api/upload são causados pelo CDN, não pelo backend" |
| Convenção do projeto não presente no CLAUDE.md | "Usamos barrel exports em src/components/" |
| Gotcha específico de ferramenta | "Jest precisa do flag `--forceExit` ou fica travado em testes de DB" |
| Decisão de arquitetura | "Escolhemos Drizzle em vez de Prisma por SQL type-safe" |
| Preferência que você quer que o Claude aprenda | "Não adicione comentários explicando código óbvio" |

## Fluxo de Trabalho

### Passo 1: Analisar o conhecimento

Extrair da entrada do usuário:
- **O quê**: O fato ou padrão concreto
- **Por que importa**: Contexto (se fornecido)
- **Escopo**: Específico do projeto ou global?

### Passo 2: Verificar duplicatas

```bash
MEMORY_DIR="$HOME/.claude/projects/$(pwd | sed 's|/|%2F|g; s|%2F|/|; s|^/||')/memory"
grep -ni "<palavras-chave>" "$MEMORY_DIR/MEMORY.md" 2>/dev/null
```

Se existir uma entrada semelhante:
- Mostrar ao usuário
- Perguntar: "Atualizar a entrada existente ou adicionar uma nova?"

### Passo 3: Escrever no MEMORY.md

Acrescentar ao final do `MEMORY.md`:

```markdown
- {{fato ou padrão conciso}}
```

Mantenha as entradas concisas — uma linha quando possível. Entradas de auto-memória não precisam de timestamps, IDs ou metadados. São notas, não registros de banco de dados.

Se o MEMORY.md tiver mais de 180 linhas, avisar o usuário:

```
MEMORY.md está com {{n}}/200 linhas. Considere executar /si:review para liberar espaço.
```

### Passo 4: Sugerir promoção

Se o conhecimento parecer uma regra (imperativa, sempre/nunca, convenção):

```
Este parece que poderia ser uma regra CLAUDE.md em vez de uma entrada de memória.
Regras são aplicadas com prioridade maior. Deseja usar /si:promote em vez disso?
```

### Passo 5: Confirmar

```
Salvo na auto-memória

  "{{entrada}}"

  MEMORY.md: {{n}}/200 linhas
  O Claude verá isso no início de cada sessão neste projeto.
```

## O que NÃO usar /si:remember para

- **Contexto temporário**: Use memória de sessão ou simplesmente diga ao Claude na conversa
- **Regras aplicadas**: Use `/si:promote` para escrever diretamente no CLAUDE.md
- **Conhecimento entre projetos**: Use `~/.claude/CLAUDE.md` para regras globais
- **Dados sensíveis**: Nunca armazene credenciais, tokens ou segredos em arquivos de memória

## Dicas

- Seja conciso — uma linha supera um parágrafo
- Inclua o comando ou valor concreto, não apenas o conceito
  - "Build com `pnpm build`, testes com `pnpm test:e2e`"
  - Evite: "O projeto usa pnpm para build e testes"
- Se você está lembrando a mesma coisa duas vezes, promova para CLAUDE.md
