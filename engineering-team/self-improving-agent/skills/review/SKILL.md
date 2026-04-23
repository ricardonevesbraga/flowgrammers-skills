---
name: "review"
description: "Analisar a auto-memória em busca de candidatos a promoção, entradas desatualizadas, oportunidades de consolidação e métricas de saúde."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# /si:review — Analisar Auto-Memória

Realiza uma auditoria abrangente da auto-memória do Claude Code e produz recomendações acionáveis.

## Uso

```
/si:review                    # Revisão completa
/si:review --quick            # Apenas resumo (contagens + top 3 candidatos)
/si:review --stale            # Focar em entradas desatualizadas
/si:review --candidates       # Mostrar apenas candidatos a promoção
```

## O que Faz

### Passo 1: Localizar o diretório de memória

```bash
# Encontrar o diretório de auto-memória do projeto
MEMORY_DIR="$HOME/.claude/projects/$(pwd | sed 's|/|%2F|g; s|%2F|/|; s|^/||')/memory"

# Fallback: verificar padrões de caminho comuns
# ~/.claude/projects/<usuario>/<projeto>/memory/
# ~/.claude/projects/<caminho-absoluto>/memory/

# Listar todos os arquivos de memória
ls -la "$MEMORY_DIR"/
```

Se o diretório de memória não existir, reportar que a auto-memória pode estar desabilitada. Sugerir verificar com `/memory`.

### Passo 2: Ler e analisar MEMORY.md

Ler o arquivo `MEMORY.md` completo. Contar linhas e verificar contra o limite de 200 linhas na inicialização.

Analisar cada entrada para:

1. **Indicadores de recorrência**
   - O mesmo conceito aparece múltiplas vezes (redação diferente)
   - Referências a "novamente" ou "ainda" ou "continua acontecendo"
   - Entradas semelhantes em arquivos por tópico

2. **Indicadores de desatualização**
   - Referências a arquivos que não existem mais (verificar com `find`)
   - Menciona ferramentas, versões ou comandos desatualizados
   - Contradiz regras atuais do CLAUDE.md

3. **Oportunidades de consolidação**
   - Múltiplas entradas sobre o mesmo tópico (ex.: três linhas sobre testes)
   - Entradas que poderiam se fundir em uma regra concisa

4. **Candidatos a promoção** — entradas que atendem a TODOS os critérios:
   - Apareceu em 2+ sessões (verificar padrões de redação)
   - Não é trivia específica do projeto (amplamente útil)
   - Acionável (pode ser escrita como regra concreta)
   - Não está já no CLAUDE.md ou `.claude/rules/`

### Passo 3: Ler arquivos por tópico

Se `MEMORY.md` referencia ou o diretório contém arquivos adicionais (`debugging.md`, `patterns.md`, etc.):
- Ler cada um
- Verificar cruzamentos com MEMORY.md para duplicatas
- Verificar entradas que pertencem ao arquivo principal (alto valor) vs. arquivos por tópico (detalhes)

### Passo 4: Verificação cruzada com CLAUDE.md

Ler o `CLAUDE.md` do projeto (se existir) e comparar:
- Existem entradas no MEMORY.md que duplicam regras do CLAUDE.md? (→ remover da memória)
- Existem entradas no MEMORY.md que contradizem o CLAUDE.md? (→ sinalizar conflito)
- Existem padrões no MEMORY.md ainda não presentes no CLAUDE.md que deveriam estar? (→ candidato a promoção)

Verificar também o diretório `.claude/rules/` por regras escopadas existentes.

### Passo 5: Gerar relatório

Produzir no formato:

```
Revisão de Auto-Memória

Saúde da Memória:
  MEMORY.md:        {{linhas}}/200 linhas ({{percent}}%)
  Arquivos por tópico: {{count}} ({{names}})
  CLAUDE.md:        {{linhas}} linhas
  Regras:           {{count}} arquivos em .claude/rules/

Candidatos a Promoção ({{count}}):
  1. "{{padrão}}" — visto {{n}}x, aplica-se amplamente
     → Sugestão: {{alvo}} (CLAUDE.md / .claude/rules/{{name}}.md)
  2. ...

Entradas Desatualizadas ({{count}}):
  1. Linha {{n}}: "{{entrada}}" — {{motivo}}
  2. ...

Consolidação ({{count}} grupos):
  1. Linhas {{a}}, {{b}}, {{c}} todas sobre {{tópico}} → fundir em 1 entrada
  2. ...

Conflitos ({{count}}):
  1. MEMORY.md linha {{n}} contradiz CLAUDE.md: {{detalhe}}

Recomendações:
  - {{sugestão acionável}}
  - {{sugestão acionável}}
```

## Quando Usar

- Após concluir uma funcionalidade importante ou sessão de debugging
- Quando `/si:status` mostra MEMORY.md com mais de 150 linhas
- Semanalmente durante desenvolvimento ativo
- Antes de iniciar uma nova fase do projeto
- Após integrar um novo membro da equipe (revisar o que o Claude aprendeu)

## Dicas

- Execute `/si:review --quick` frequentemente (baixo overhead)
- A revisão completa é mais valiosa quando o MEMORY.md está ficando cheio
- Aja sobre candidatos a promoção prontamente — são padrões comprovados
- Não hesite em excluir entradas desatualizadas — a auto-memória reaprendrá se necessário
