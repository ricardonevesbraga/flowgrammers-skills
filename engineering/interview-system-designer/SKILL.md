---
name: "interview-system-designer"
description: "Esta skill deve ser usada quando o usuário pedir para 'projetar processos de entrevista', 'criar pipelines de contratação', 'calibrar loops de entrevista', 'gerar perguntas de entrevista', 'projetar matrizes de competência', 'analisar viés do entrevistador', 'criar rubricas de pontuação', 'construir bancos de perguntas' ou 'otimizar sistemas de contratação'. Use para projetar loops de entrevista específicos por função, avaliações de competência e sistemas de calibração de contratação."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Interview System Designer

Planejamento abrangente de loop de entrevista e suporte de calibração para sistemas de contratação baseados em função.

## Visão Geral

Use esta skill para criar loops de entrevista estruturados, padronizar a qualidade das perguntas e manter o sinal de contratação consistente entre os entrevistadores.

## Capacidades Principais

- Planejamento de loop de entrevista por função e nível
- Recomendações de foco e timing rodada a rodada
- Conjuntos de perguntas sugeridas por tipo de rodada
- Suporte a framework para pontuação e calibração
- Orientação para redução de viés e consistência de processo

## Início Rápido

```bash
# Gerar um plano de loop para uma função e nível
python3 scripts/interview_planner.py --role "Senior Software Engineer" --level senior

# Saída JSON para integração com ferramentas internas
python3 scripts/interview_planner.py --role "Product Manager" --level mid --json
```

## Workflow Recomendado

1. Execute `scripts/interview_planner.py` para gerar um loop de baseline.
2. Alinhe as rodadas às competências específicas da função.
3. Valide a consistência da rubrica de pontuação com os líderes do painel de entrevistadores.
4. Revise os controles de viés antes do lançamento.
5. Recalibre trimestralmente usando dados de resultado de contratação.

## Referências

- `references/interview-frameworks.md`
- `references/bias_mitigation_checklist.md`
- `references/competency_matrix_templates.md`
- `references/debrief_facilitation_guide.md`

## Armadilhas Comuns

- Dar peso excessivo a uma rodada enquanto ignora outros sinais de competência
- Usar entrevistas não estruturadas sem pontuação padronizada
- Pular sessões de calibração para entrevistadores
- Mudar o padrão de contratação sem documentar a justificativa

## Melhores Práticas

1. Mantenha os objetivos das rodadas explícitos e sem sobreposição.
2. Exija evidências para cada recomendação de pontuação.
3. Use a mesma rubrica de baseline em funções comparáveis.
4. Revise o design do loop com base nos resultados de qualidade da contratação.
