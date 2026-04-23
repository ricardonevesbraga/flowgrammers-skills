---
name: "extract"
description: "Transformar um padrão comprovado ou solução de debugging em uma skill standalone reutilizável com SKILL.md, documentação de referência e exemplos."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# /si:extract — Criar Skills a partir de Padrões

Transforma um padrão recorrente ou solução de debugging em uma skill standalone e portável que pode ser instalada em qualquer projeto.

## Uso

```
/si:extract <descrição do padrão>                  # Extração interativa
/si:extract <padrão> --name docker-m1-fixes        # Especificar nome da skill
/si:extract <padrão> --output ./skills/             # Diretório de saída personalizado
/si:extract <padrão> --dry-run                     # Prévia sem criar arquivos
```

## Quando Extrair

Um aprendizado se qualifica para extração de skill quando QUALQUER uma das condições for verdadeira:

| Critério | Sinal |
|---|---|
| **Recorrente** | Mesmo problema em 2+ projetos |
| **Não óbvio** | Exigiu debugging real para descobrir |
| **Amplamente aplicável** | Não está vinculado a um código específico |
| **Solução complexa** | Correção multi-etapa fácil de esquecer |
| **Sinalizado pelo usuário** | "Salve isso como skill", "quero reutilizar isso" |

## Fluxo de Trabalho

### Passo 1: Identificar o padrão

Ler a descrição do usuário. Pesquisar a auto-memória por entradas relacionadas:

```bash
MEMORY_DIR="$HOME/.claude/projects/$(pwd | sed 's|/|%2F|g; s|%2F|/|; s|^/||')/memory"
grep -rni "<palavras-chave>" "$MEMORY_DIR/"
```

Se encontrado na auto-memória, use essas entradas como material de origem. Se não, use a descrição do usuário diretamente.

### Passo 2: Determinar o escopo da skill

Perguntar (máximo 2 perguntas):
- "Que problema isso resolve?" (se não estiver claro)
- "Isso deve incluir exemplos de código?" (se aplicável)

### Passo 3: Gerar nome da skill

Regras para nomenclatura:
- Minúsculas, hífens entre palavras
- Descritivo mas conciso (2-4 palavras)
- Exemplos: `docker-m1-fixes`, `api-timeout-patterns`, `pnpm-workspace-setup`

### Passo 4: Criar os arquivos da skill

**Iniciar o agente `skill-extractor`** para a geração real dos arquivos.

O agente cria:

```
<skill-name>/
├── SKILL.md            # Arquivo principal da skill com frontmatter
├── README.md           # Visão geral legível por humanos
└── reference/          # (opcional) Documentação de suporte
    └── examples.md     # Exemplos concretos e casos extremos
```

### Passo 5: Estrutura do SKILL.md

O SKILL.md gerado deve seguir este formato:

```markdown
---
name: "skill-name"
description: "<descrição de uma linha>. Use quando: <condições de gatilho>."
---

# <Título da Skill>

> Resumo de uma linha do que esta skill resolve.

## Referência Rápida

| Problema | Solução |
|---------|----------|
| {{problema 1}} | {{solução 1}} |
| {{problema 2}} | {{solução 2}} |

## O Problema

{{2-3 frases explicando o que dá errado e por que não é óbvio.}}

## Soluções

### Opção 1: {{Nome}} (Recomendada)

{{Passo a passo com exemplos de código.}}

### Opção 2: {{Alternativa}}

{{Para quando a Opção 1 não se aplica.}}

## Trade-offs

| Abordagem | Prós | Contras |
|----------|------|------|
| Opção 1 | {{prós}} | {{contras}} |
| Opção 2 | {{prós}} | {{contras}} |

## Casos Extremos

- {{caso extremo 1 e como lidar}}
- {{caso extremo 2 e como lidar}}
```

### Passo 6: Verificações de qualidade

Antes de finalizar, verificar:

- [ ] SKILL.md tem frontmatter YAML válido com `name` e `description`
- [ ] `name` corresponde ao nome da pasta (minúsculas, hífens)
- [ ] A descrição inclui condições de gatilho "Use quando:"
- [ ] As soluções são autocontidas (sem contexto externo necessário)
- [ ] Exemplos de código são completos e copiáveis
- [ ] Sem valores hardcoded específicos do projeto (caminhos, URLs, credenciais)
- [ ] Sem dependências desnecessárias

### Passo 7: Relatório

```
Skill extraída: {{skill-name}}

Arquivos criados:
  {{path}}/SKILL.md          ({{lines}} linhas)
  {{path}}/README.md         ({{lines}} linhas)
  {{path}}/reference/examples.md  ({{lines}} linhas)

Instalar: /plugin install (copiar para seu diretório de skills)

Origem: Entradas MEMORY.md nas linhas {{n, m, ...}} (mantidas — a skill é portável, a memória é específica do projeto)
```

## Exemplos

### Extraindo um padrão de debugging

```
/si:extract "Correção para builds Docker falhando no Apple Silicon com incompatibilidade de plataforma"
```

Cria `docker-m1-fixes/SKILL.md` com:
- A mensagem de erro de incompatibilidade de plataforma
- Três soluções (flag de build, Dockerfile, docker-compose)
- Tabela de trade-offs
- Nota de desempenho sobre emulação Rosetta 2

### Extraindo um padrão de fluxo de trabalho

```
/si:extract "Sempre regenerar o cliente TypeScript de API após modificar a spec OpenAPI"
```

Cria `api-client-regen/SKILL.md` com:
- Por que a regeneração manual é necessária
- A sequência exata de comandos
- Trecho de integração CI
- Modos de falha comuns

## Dicas

- Extraia padrões que economizariam tempo em um *projeto diferente*
- Mantenha as skills focadas — um problema por skill
- Inclua as mensagens de erro que as pessoas procurariam
- Teste a skill lendo-a sem o contexto original — faz sentido?
