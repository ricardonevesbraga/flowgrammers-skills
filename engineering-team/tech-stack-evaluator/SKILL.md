---
name: "tech-stack-evaluator"
description: "Avaliação e comparação de stacks tecnológicos com análise TCO, avaliação de segurança e pontuação de saúde do ecossistema. Use ao comparar frameworks, avaliar stacks de tecnologia, calcular custo total de propriedade, avaliar caminhos de migração ou analisar viabilidade de ecossistema."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Avaliador de Stack Tecnológico

Avalie e compare tecnologias, frameworks e provedores cloud com análise orientada a dados e recomendações acionáveis.

## Sumário

- [Capacidades](#capacidades)
- [Início Rápido](#início-rápido)
- [Formatos de Entrada](#formatos-de-entrada)
- [Tipos de Análise](#tipos-de-análise)
- [Scripts](#scripts)
- [Referências](#referências)

---

## Capacidades

| Capacidade | Descrição |
|------------|-------------|
| Comparação de Tecnologia | Comparar frameworks e bibliotecas com pontuação ponderada |
| Análise TCO | Calcular custo total de propriedade em 5 anos incluindo custos ocultos |
| Saúde do Ecossistema | Avaliar métricas GitHub, adoção npm, força da comunidade |
| Avaliação de Segurança | Avaliar vulnerabilidades e prontidão para conformidade |
| Análise de Migração | Estimar esforço, riscos e timeline para migrações |
| Comparação Cloud | Comparar AWS, Azure, GCP para workloads específicos |

---

## Início Rápido

### Comparar Duas Tecnologias

```
Compare React vs Vue para um painel SaaS.
Prioridades: produtividade do desenvolvedor (40%), ecossistema (30%), performance (30%).
```

### Calcular TCO

```
Calcule TCO de 5 anos para Next.js no Vercel.
Equipe: 8 desenvolvedores. Hospedagem: $2.500/mês. Crescimento: 40%/ano.
```

### Avaliar Migração

```
Avalie a migração de Angular.js para React.
Base de código: 50.000 linhas, 200 componentes. Equipe: 6 desenvolvedores.
```

---

## Formatos de Entrada

O avaliador aceita três formatos de entrada:

**Texto** - Queries em linguagem natural
```
Compare PostgreSQL vs MongoDB para nossa plataforma de e-commerce.
```

**YAML** - Entrada estruturada para automação
```yaml
comparison:
  technologies: ["React", "Vue"]
  use_case: "painel SaaS"
  weights:
    ecosystem: 30
    performance: 25
    developer_experience: 45
```

**JSON** - Integração programática
```json
{
  "technologies": ["React", "Vue"],
  "use_case": "painel SaaS"
}
```

---

## Tipos de Análise

### Comparação Rápida (200-300 tokens)
- Scores ponderados e recomendação
- Top 3 fatores de decisão
- Nível de confiança

### Análise Padrão (500-800 tokens)
- Matriz de comparação
- Visão geral do TCO
- Resumo de segurança

### Relatório Completo (1.200-1.500 tokens)
- Todas as métricas e cálculos
- Análise de migração
- Recomendações detalhadas

---

## Scripts

### stack_comparator.py

Compara tecnologias com critérios ponderados personalizáveis.

```bash
python scripts/stack_comparator.py --help
```

### tco_calculator.py

Calcula custo total de propriedade em projeções plurianuais.

```bash
python scripts/tco_calculator.py --input assets/sample_input_tco.json
```

### ecosystem_analyzer.py

Analisa saúde do ecossistema a partir de métricas GitHub, npm e comunidade.

```bash
python scripts/ecosystem_analyzer.py --technology react
```

### security_assessor.py

Avalia postura de segurança e prontidão para conformidade.

```bash
python scripts/security_assessor.py --technology express --compliance soc2,gdpr
```

### migration_analyzer.py

Estima complexidade de migração, esforço e riscos.

```bash
python scripts/migration_analyzer.py --from angular-1.x --to react
```

---

## Referências

| Documento | Conteúdo |
|----------|---------|
| `references/metrics.md` | Algoritmos de pontuação detalhados e fórmulas de cálculo |
| `references/examples.md` | Exemplos de entrada/saída para todos os tipos de análise |
| `references/workflows.md` | Workflows de avaliação passo a passo |

---

## Níveis de Confiança

| Nível | Score | Interpretação |
|-------|-------|----------------|
| Alto | 80-100% | Vencedor claro, dados sólidos |
| Médio | 50-79% | Trade-offs presentes, incerteza moderada |
| Baixo | < 50% | Decisão próxima, dados limitados |

---

## Quando Usar

- Comparar frameworks frontend/backend para novos projetos
- Avaliar provedores cloud para workloads específicos
- Planejar migrações de tecnologia com avaliação de riscos
- Calcular decisões de build vs. buy com TCO
- Avaliar viabilidade de biblioteca open-source

## Quando NÃO Usar

- Decisões triviais entre ferramentas similares (use preferência da equipe)
- Escolhas de tecnologia mandatadas (decisão já tomada)
- Problemas urgentes de produção (use ferramentas de monitoramento)
