---
name: "self-improving-agent"
description: "Curar a auto-memória do Claude Code em conhecimento duradouro de projeto. Analisa MEMORY.md em busca de padrões, promove aprendizados comprovados para CLAUDE.md e .claude/rules/, extrai soluções recorrentes em skills reutilizáveis. Use quando: (1) revisando o que o Claude aprendeu sobre seu projeto, (2) graduando um padrão de notas para regras aplicadas, (3) transformando uma solução de debugging em uma skill, (4) verificando saúde e capacidade da memória."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Self-Improving Agent

> A auto-memória captura. Este plugin cuida.

A auto-memória do Claude Code (v2.1.32+) registra automaticamente padrões do projeto, insights de debugging e suas preferências em `MEMORY.md`. Este plugin adiciona a camada de inteligência: analisa o que o Claude aprendeu, promove padrões comprovados para regras do projeto e extrai soluções recorrentes em skills reutilizáveis.

## Referência Rápida

| Comando | O que faz |
|---------|-------------|
| `/si:review` | Analisar MEMORY.md — encontrar candidatos a promoção, entradas desatualizadas, oportunidades de consolidação |
| `/si:promote` | Graduar um padrão de MEMORY.md → CLAUDE.md ou `.claude/rules/` |
| `/si:extract` | Transformar um padrão comprovado em uma skill standalone |
| `/si:status` | Painel de saúde da memória — contagens de linhas, arquivos por tópico, recomendações |
| `/si:remember` | Salvar explicitamente conhecimento importante na auto-memória |

## Como se Encaixa

```
┌─────────────────────────────────────────────────────────┐
│              Pilha de Memória do Claude Code             │
├─────────────┬──────────────────┬────────────────────────┤
│  CLAUDE.md  │   Auto-Memória   │   Memória de Sessão    │
│  (você escreve)│ (Claude escreve)│ (Claude escreve)    │
│  Regras &   │   MEMORY.md      │   Logs de conversa     │
│  padrões    │   + arquivos     │   + continuidade       │
│  Carrega    │   por tópico     │                        │
│  completo   │   200 primeiras  │   Carga contextual     │
│             │   linhas         │                        │
├─────────────┴──────────────────┴────────────────────────┤
│              ↑ /si:promote        ↑ /si:review          │
│         Self-Improving Agent (este plugin)               │
│              ↓ /si:extract    ↓ /si:remember            │
├─────────────────────────────────────────────────────────┤
│  .claude/rules/    │    Novas Skills    │   Logs de Erro │
│  (regras escopadas)│   (extraídas)      │   (capturados) │
└─────────────────────────────────────────────────────────┘
```

## Instalação

### Claude Code (Plugin)
```
/plugin marketplace add alirezarezvani/claude-skills
/plugin install self-improving-agent@claude-code-skills
```

## Arquitetura de Memória

### Onde as coisas ficam

| Arquivo | Quem escreve | Escopo | Carregado |
|------|-----------|-------|--------|
| `./CLAUDE.md` | Você (+ `/si:promote`) | Regras do projeto | Arquivo completo, toda sessão |
| `~/.claude/CLAUDE.md` | Você | Preferências globais | Arquivo completo, toda sessão |
| `~/.claude/projects/<path>/memory/MEMORY.md` | Claude (auto) | Aprendizados do projeto | Primeiras 200 linhas |
| `~/.claude/projects/<path>/memory/*.md` | Claude (overflow) | Notas por tópico | Sob demanda |
| `.claude/rules/*.md` | Você (+ `/si:promote`) | Regras escopadas | Quando arquivos correspondentes são abertos |

### O ciclo de vida da promoção

```
1. Claude descobre padrão → auto-memória (MEMORY.md)
2. Padrão recorre 2-3x → /si:review o sinaliza como candidato a promoção
3. Você aprova → /si:promote o gradua para CLAUDE.md ou rules/
4. Padrão se torna uma regra aplicada, não apenas uma nota
5. Entrada no MEMORY.md é removida → libera espaço para novos aprendizados
```

## Conceitos Centrais

### Auto-memória é captura, não curadoria

A auto-memória é excelente para registrar o que o Claude aprende. Mas ela não tem julgamento sobre:
- Quais aprendizados são temporários vs. permanentes
- Quais padrões devem se tornar regras aplicadas
- Quando o limite de 200 linhas está desperdiçando espaço com entradas desatualizadas
- Quais soluções são boas o suficiente para se tornarem skills reutilizáveis

É isso que este plugin faz.

### Promoção = graduação

Quando você promove um aprendizado, ele move do rascunho do Claude (MEMORY.md) para o sistema de regras do projeto (CLAUDE.md ou `.claude/rules/`). A diferença importa:

- **MEMORY.md**: "Percebi que este projeto usa pnpm" (contexto de fundo)
- **CLAUDE.md**: "Use pnpm, não npm" (instrução aplicada)

Regras promovidas têm prioridade maior e carregam completamente (não truncadas a 200 linhas).

### Diretório de regras para conhecimento escopado

Nem tudo pertence ao CLAUDE.md. Use `.claude/rules/` para padrões que se aplicam apenas a tipos de arquivo específicos:

```yaml
# .claude/rules/api-testing.md
---
paths:
  - "src/api/**/*.test.ts"
  - "tests/api/**/*"
---
- Use supertest para testes de endpoints de API
- Simule serviços externos com msw
- Sempre teste respostas de erro, não apenas casos de sucesso
```

Isso carrega apenas quando o Claude trabalha com arquivos de teste de API — zero overhead caso contrário.

## Agentes

### memory-analyst
Analisa MEMORY.md e arquivos por tópico para identificar:
- Entradas que recorrem entre sessões (candidatos a promoção)
- Entradas desatualizadas referenciando arquivos excluídos ou padrões antigos
- Entradas relacionadas que devem ser consolidadas
- Lacunas entre o que o MEMORY.md sabe e o que o CLAUDE.md aplica

### skill-extractor
Pega um padrão comprovado e gera uma skill completa:
- SKILL.md com frontmatter adequado
- Documentação de referência
- Exemplos e casos extremos
- Pronto para `/plugin install` ou publicação

## Hooks

### error-capture (PostToolUse → Bash)
Monitora a saída de comandos em busca de erros. Quando detectado, acrescenta uma entrada estruturada à auto-memória com:
- O comando que falhou
- Saída de erro (truncada)
- Timestamp e contexto
- Categoria sugerida

**Overhead de tokens:** Zero em caso de sucesso. ~30 tokens apenas quando um erro é detectado.

## Suporte de Plataforma

| Plataforma | Sistema de Memória | Plugin Funciona? |
|----------|--------------|---------------|
| Claude Code | Auto-memória (MEMORY.md) | Suporte completo |

## Relacionados

- [Documentação de Memória do Claude Code](https://code.claude.com/docs/en/memory)
- [pskoett/self-improving-agent](https://clawhub.ai/pskoett/self-improving-agent) — inspiração
- [playwright-pro](../playwright-pro/) — plugin irmão neste repositório
