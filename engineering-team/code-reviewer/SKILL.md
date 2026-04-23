---
name: "code-reviewer"
description: Automação de revisão de código para TypeScript, JavaScript, Python, Go, Swift, Kotlin. Analisa PRs quanto a complexidade e risco, verifica qualidade de código para violações SOLID e code smells, gera relatórios de revisão. Use ao revisar pull requests, analisar qualidade de código, identificar problemas ou gerar checklists de revisão.
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Code Reviewer

Ferramentas automatizadas de revisão de código para analisar pull requests, detectar problemas de qualidade de código e gerar relatórios de revisão.

---

## Sumário

- [Ferramentas](#ferramentas)
  - [PR Analyzer](#pr-analyzer)
  - [Code Quality Checker](#code-quality-checker)
  - [Gerador de Relatório de Revisão](#gerador-de-relatório-de-revisão)
- [Guias de Referência](#guias-de-referência)
- [Linguagens Suportadas](#linguagens-suportadas)

---

## Ferramentas

### PR Analyzer

Analisa o git diff entre branches para avaliar a complexidade de revisão e identificar riscos.

```bash
# Analisar branch atual contra main
python scripts/pr_analyzer.py /path/to/repo

# Comparar branches específicas
python scripts/pr_analyzer.py . --base main --head feature-branch

# Saída JSON para integração
python scripts/pr_analyzer.py /path/to/repo --json
```

**O que detecta:**
- Segredos hardcoded (senhas, chaves de API, tokens)
- Padrões de injeção SQL (concatenação de strings em consultas)
- Statements de depuração (debugger, console.log)
- Desabilitação de regras ESLint
- Tipos `any` do TypeScript
- Comentários TODO/FIXME

**A saída inclui:**
- Pontuação de complexidade (1-10)
- Categorização de risco (crítico, alto, médio, baixo)
- Priorização de arquivos para ordem de revisão
- Validação de mensagem de commit

---

### Code Quality Checker

Analisa código-fonte para problemas estruturais, code smells e violações SOLID.

```bash
# Analisar um diretório
python scripts/code_quality_checker.py /path/to/code

# Analisar linguagem específica
python scripts/code_quality_checker.py . --language python

# Saída JSON
python scripts/code_quality_checker.py /path/to/code --json
```

**O que detecta:**
- Funções longas (>50 linhas)
- Arquivos grandes (>500 linhas)
- God classes (>20 métodos)
- Aninhamento profundo (>4 níveis)
- Muitos parâmetros (>5)
- Alta complexidade ciclomática
- Tratamento de erro ausente
- Importações não utilizadas
- Números mágicos

**Limites:**

| Problema | Limite |
|-------|-----------|
| Função longa | >50 linhas |
| Arquivo grande | >500 linhas |
| God class | >20 métodos |
| Muitos parâmetros | >5 |
| Aninhamento profundo | >4 níveis |
| Alta complexidade | >10 branches |

---

### Gerador de Relatório de Revisão

Combina análise de PR e resultados de qualidade de código em relatórios de revisão estruturados.

```bash
# Gerar relatório para repositório atual
python scripts/review_report_generator.py /path/to/repo

# Saída em Markdown
python scripts/review_report_generator.py . --format markdown --output review.md

# Usar análises pré-computadas
python scripts/review_report_generator.py . \
  --pr-analysis pr_results.json \
  --quality-analysis quality_results.json
```

**O relatório inclui:**
- Veredicto de revisão (aprovar, solicitar mudanças, bloquear)
- Pontuação (0-100)
- Itens de ação priorizados
- Resumo de problemas por severidade
- Ordem de revisão sugerida

**Veredictos:**

| Pontuação | Veredicto |
|-------|---------|
| 90+ sem problemas altos | Aprovar |
| 75+ com ≤2 problemas altos | Aprovar com sugestões |
| 50-74 | Solicitar mudanças |
| <50 ou problemas críticos | Bloquear |

---

## Guias de Referência

### Lista de Verificação de Revisão de Código
`references/code_review_checklist.md`

Listas de verificação sistemáticas cobrindo:
- Verificações pré-revisão (build, testes, higiene do PR)
- Correção (lógica, tratamento de dados, tratamento de erros)
- Segurança (validação de entrada, prevenção de injeção)
- Desempenho (eficiência, cache, escalabilidade)
- Manutenibilidade (qualidade de código, nomenclatura, estrutura)
- Testes (cobertura, qualidade, mocking)
- Verificações específicas por linguagem

### Padrões de Código
`references/coding_standards.md`

Padrões específicos por linguagem para:
- TypeScript (anotações de tipo, segurança de null, async/await)
- JavaScript (declarações, padrões, módulos)
- Python (type hints, exceções, design de classes)
- Go (tratamento de erros, structs, concorrência)
- Swift (opcionais, protocolos, erros)
- Kotlin (segurança de null, data classes, coroutines)

### Anti-Padrões Comuns
`references/common_antipatterns.md`

Catálogo de anti-padrões com exemplos e correções:
- Estruturais (god class, método longo, aninhamento profundo)
- Lógicos (boolean blindness, código stringly typed)
- Segurança (injeção SQL, credenciais hardcoded)
- Desempenho (queries N+1, coleções ilimitadas)
- Testes (duplicação, testar implementação)
- Async (floating promises, callback hell)

---

## Linguagens Suportadas

| Linguagem | Extensões |
|----------|------------|
| Python | `.py` |
| TypeScript | `.ts`, `.tsx` |
| JavaScript | `.js`, `.jsx`, `.mjs` |
| Go | `.go` |
| Swift | `.swift` |
| Kotlin | `.kt`, `.kts` |
