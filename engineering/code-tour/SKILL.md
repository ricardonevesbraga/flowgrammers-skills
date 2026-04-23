---
name: "code-tour"
description: "Use quando o usuário pedir para criar um arquivo CodeTour .tour — walkthroughs passo a passo direcionados a personas que linkam para arquivos reais e números de linha. Gatilho para: criar um tour, tour de integração, tour de arquitetura, tour de revisão de PR, explicar como X funciona, vibe check, tour de RCA, guia do contribuidor, ou qualquer solicitação de walkthrough de código estruturado."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Code Tour

Crie arquivos **CodeTour** — walkthroughs passo a passo direcionados a personas de uma base de código que linkam diretamente para arquivos e números de linha. Os arquivos CodeTour ficam em `.tours/` e funcionam com a [extensão CodeTour do VS Code](https://github.com/microsoft/codetour).

## Visão Geral

Um bom tour é uma **narrativa** — uma história contada a uma pessoa específica sobre o que importa, por que importa e o que fazer em seguida. Crie apenas arquivos `.tour` em JSON. Nunca modifique o código-fonte.

## Quando Usar Esta Skill

- Usuário pede para criar um tour de código, tour de integração ou walkthrough de arquitetura
- Usuário diz "tour para este PR", "explique como X funciona", "vibe check", "tour de RCA"
- Usuário quer um guia do contribuidor, revisão de segurança ou walkthrough de investigação de bug
- Qualquer solicitação de walkthrough estruturado com âncoras de arquivo/linha

## Workflow Principal

### 1. Descobrir o repositório

Antes de perguntar qualquer coisa, explore a base de código:

Em paralelo: liste o diretório raiz, leia o README, verifique os arquivos de configuração.
Depois: identifique linguagem(s), framework(s), propósito do projeto. Mapeie a estrutura de pastas 1-2 níveis de profundidade. Encontre pontos de entrada — cada caminho no tour deve ser real.

Se o repositório tiver menos de 5 arquivos fonte, crie um tour de profundidade rápida independentemente da persona — não há conteúdo suficiente para justificar um tour profundo.

### 2. Inferir a intenção

Uma mensagem deve ser suficiente. Infira persona, profundidade e foco silenciosamente.

| O usuário diz | Persona | Profundidade |
|-----------|---------|-------|
| "tour para este PR" | pr-reviewer | padrão |
| "por que X quebrou" / "RCA" | rca-investigator | padrão |
| "integração" / "novo integrante" | new-joiner | padrão |
| "tour rápido" / "vibe check" | vibecoder | rápido |
| "arquitetura" | architect | profundo |
| "segurança" / "revisão de auth" | security-reviewer | padrão |
| (sem qualificador) | new-joiner | padrão |

Quando a intenção for ambígua, padrão para persona **new-joiner** com profundidade **padrão** — é a mais geralmente útil.

### 3. Ler os arquivos reais

**Todo caminho de arquivo e número de linha deve ser verificado.** Um tour apontando para a linha errada é pior do que nenhum tour.

### 4. Escrever o tour

Salve em `.tours/<persona>-<foco>.tour`.

```json
{
  "$schema": "https://aka.ms/codetour-schema",
  "title": "Título Descritivo — Persona / Objetivo",
  "description": "Para quem é isso e o que eles entenderão depois.",
  "ref": "<branch-ou-commit-atual>",
  "steps": []
}
```

### Tipos de passo

| Tipo | Quando usar | Exemplo |
|------|-------------|---------|
| **Content** | Apenas intro/encerramento (máx. 2) | `{ "title": "Bem-vindo", "description": "..." }` |
| **Directory** | Orientar para um módulo | `{ "directory": "src/services", "title": "..." }` |
| **File + line** | O cavalo de batalha | `{ "file": "src/auth.ts", "line": 42, "title": "..." }` |
| **Selection** | Destacar um bloco de código | `{ "file": "...", "selection": {...}, "title": "..." }` |
| **Pattern** | Correspondência regex (arquivos voláteis) | `{ "file": "...", "pattern": "class App", "title": "..." }` |
| **URI** | Link para PR, issue, doc | `{ "uri": "https://...", "title": "..." }` |

### Contagem de passos

| Profundidade | Passos | Usar para |
|-------|-------|---------|
| Rápido | 5-8 | Vibecoder, exploração rápida |
| Padrão | 9-13 | A maioria das personas |
| Profundo | 14-18 | Architect, RCA |

### Escrevendo descrições — fórmula SMIG

- **S — Situação**: O que o leitor está olhando?
- **M — Mecanismo**: Como este código funciona?
- **I — Implicação**: Por que isso importa para esta persona?
- **G — Armadilha**: O que uma pessoa inteligente erraria?

### 5. Validar

- [ ] Todo caminho de `file` relativo à raiz do repo (sem `/` inicial ou `./`)
- [ ] Todo `file` confirmado como existente
- [ ] Todo `line` verificado lendo o arquivo
- [ ] Primeiro passo tem âncora `file` ou `directory`
- [ ] No máximo 2 passos somente de conteúdo
- [ ] `nextTour` corresponde ao `title` de outro tour exatamente, se definido

## Personas

| Persona | Objetivo | Deve cobrir |
|---------|------|------------|
| **Vibecoder** | Captar o vibe rapidamente | Ponto de entrada, módulos principais. Máx. 8 passos. |
| **New joiner** | Ramp-up estruturado | Diretórios, configuração, contexto de negócio |
| **Bug fixer** | Causa raiz rapidamente | Gatilho -> pontos de falha -> testes |
| **RCA investigator** | Por que falhou | Cadeia de causalidade, âncoras de observabilidade |
| **Feature explainer** | Ponta a ponta | UI -> API -> backend -> armazenamento |
| **PR reviewer** | Revisar corretamente | Histórico de mudanças, invariantes, áreas de risco |
| **Architect** | Forma e razão | Limites, trade-offs, pontos de extensão |
| **Security reviewer** | Limites de confiança | Fluxo de auth, validação, manipulação de segredos |
| **Refactorer** | Reestruturação segura | Junções, dependências ocultas, ordem de extração |
| **External contributor** | Contribuir com segurança | Áreas seguras, convenções, armadilhas |

## Arco Narrativo

1. **Orientação** — passo `file` ou `directory` (nunca passo somente de conteúdo primeiro — fica em branco no VS Code)
2. **Mapa de alto nível** — 1-3 passos de diretório mostrando módulos principais
3. **Caminho principal** — passos de arquivo/linha, o coração do tour
4. **Encerramento** — o que o leitor agora pode fazer, acompanhamentos sugeridos

## Anti-Padrões

| Anti-padrão | Correção |
|---|---|
| **Listagem de arquivos** — "este arquivo contém os modelos" | Conte uma história. Cada passo depende do anterior. |
| **Descrições genéricas** | Nomeie o padrão específico único desta base de código. |
| **Adivinhar números de linha** | Nunca escreva uma linha que não verificou lendo. |
| **Muitos passos** para profundidade rápida | Realmente corte passos. |
| **Arquivos alucinados** | Se não existe, pule o passo. |
| **Encerramento de recapitulação** — "cobrimos X, Y, Z" | Diga ao leitor o que ele agora pode *fazer*. |
| **Passo somente de conteúdo como primeiro** | Ancore o passo 1 a um arquivo ou diretório. |

## Referências Cruzadas

- Relacionado: `engineering/codebase-onboarding` — para integração mais ampla além dos tours
- Relacionado: `engineering/pr-review-expert` — para workflows de revisão de PR automatizados
- Extensão CodeTour: [microsoft/codetour](https://github.com/microsoft/codetour)
- Tours do mundo real: [coder/code-server](https://github.com/coder/code-server/blob/main/.tours/contributing.tour)
