---
name: "scrum-master"
description: "Skill avançada de Scrum Master para análise e coaching de equipes ágeis baseados em dados. Use quando o usuário perguntar sobre planejamento de sprint, rastreamento de velocidade, retrospectivas, facilitação de standup, grooming de backlog, story points, burndown charts, resolução de bloqueadores ou saúde de equipes ágeis. Executa scripts Python para analisar exportações JSON de sprint do Jira ou ferramentas similares: velocity_analyzer.py para previsão Monte Carlo de sprint, sprint_health_scorer.py para pontuação de saúde multidimensional e retrospective_analyzer.py para rastreamento de itens de ação e temas. Produz previsões com intervalo de confiança, relatórios de nota de saúde e tendências de velocidade de melhoria para equipes Scrum de alto desempenho."
license: MIT
author: Ric Neves - Flowgrammers
metadata:
  version: 2.0.0
  category: project-management
  domain: agile-development
  updated: 2026-02-15
  tech-stack: scrum, agile-coaching, team-dynamics, data-analysis
agents:
  - claude-code
---

# Especialista em Scrum Master

Skill de Scrum Master orientada por dados combinando análise de sprint, previsão probabilística e coaching de desenvolvimento de equipe. O valor único está nos três scripts Python de análise e seus fluxos de trabalho — consulte `references/` e `assets/` para detalhes mais profundos do framework.

---

## Sumário

- [Ferramentas de Análise e Uso](#ferramentas-de-análise-e-uso)
- [Requisitos de Entrada](#requisitos-de-entrada)
- [Fluxos de Trabalho de Execução de Sprint](#fluxos-de-trabalho-de-execução-de-sprint)
- [Fluxo de Trabalho de Desenvolvimento de Equipe](#fluxo-de-trabalho-de-desenvolvimento-de-equipe)
- [Métricas e Metas Principais](#métricas-e-metas-principais)
- [Limitações](#limitações)

---

## Ferramentas de Análise e Uso

### 1. Analisador de Velocidade (`scripts/velocity_analyzer.py`)

Executa médias móveis, detecção de tendência por regressão linear e simulação Monte Carlo sobre o histórico de sprints.

```bash
# Relatório de texto
python velocity_analyzer.py sprint_data.json --format text

# Saída JSON para processamento downstream
python velocity_analyzer.py sprint_data.json --format json > analysis.json
```

**Produz**: tendência de velocidade (melhorando/estável/declining), coeficiente de variação, previsão Monte Carlo de 6 sprints em intervalos de confiança de 50 / 70 / 85 / 95%, sinalizações de anomalia com sugestões de causa raiz.

**Validação**: Se menos de 3 sprints estiverem presentes na entrada, parar e avisar o usuário: *"A análise de velocidade precisa de pelo menos 3 sprints. Por favor, forneça dados adicionais de sprint."* 6+ sprints são recomendados para resultados Monte Carlo estatisticamente significativos.

---

### 2. Pontuador de Saúde do Sprint (`scripts/sprint_health_scorer.py`)

Pontua a saúde da equipe em 6 dimensões ponderadas, produzindo uma nota geral de 0–100.

| Dimensão | Peso | Meta |
|---|---|---|
| Confiabilidade de Comprometimento | 25% | >85% metas de sprint atingidas |
| Estabilidade de Escopo | 20% | <15% mudanças no meio do sprint |
| Resolução de Bloqueadores | 15% | <3 dias em média |
| Engajamento em Cerimônias | 15% | >90% de participação |
| Distribuição de Conclusão de Histórias | 15% | Alta proporção de histórias totalmente concluídas |
| Previsibilidade de Velocidade | 10% | CV <20% |

```bash
python sprint_health_scorer.py sprint_data.json --format text
```

**Produz**: pontuação de saúde geral + nota, pontuações por dimensão com recomendações, tendência sprint a sprint, matriz de prioridade de intervenção.

**Validação**: Requer 2+ sprints com dados de cerimônia e conclusão de história. Se os dados estiverem faltando, reportar quais dimensões não podem ser pontuadas e pedir ao usuário que forneça as lacunas.

---

### 3. Analisador de Retrospectiva (`scripts/retrospective_analyzer.py`)

Rastreia conclusão de itens de ação, temas recorrentes, tendências de sentimento e progressão de maturidade da equipe.

```bash
python retrospective_analyzer.py sprint_data.json --format text
```

**Produz**: taxa de conclusão de itens de ação por prioridade/responsável, pontuações de persistência de temas recorrentes, nível de maturidade da equipe (forming/storming/norming/performing), tendência de velocidade de melhoria.

**Validação**: Requer 3+ retrospectivas com rastreamento de itens de ação. Com menos, observar a limitação e oferecer apenas análise parcial de temas.

---

## Requisitos de Entrada

Todos os scripts aceitam JSON seguindo o schema em `assets/sample_sprint_data.json`:

```json
{
  "team_info": { "name": "string", "size": "number", "scrum_master": "string" },
  "sprints": [
    {
      "sprint_number": "number",
      "planned_points": "number",
      "completed_points": "number",
      "stories": [...],
      "blockers": [...],
      "ceremonies": {...}
    }
  ],
  "retrospectives": [
    {
      "sprint_number": "number",
      "went_well": ["string"],
      "to_improve": ["string"],
      "action_items": [...]
    }
  ]
}
```

O Jira e ferramentas similares podem exportar dados de sprint; mapear os campos exportados para este schema antes de executar os scripts. Veja `assets/sample_sprint_data.json` para um exemplo completo de 6 sprints e `assets/expected_output.json` para resultados esperados correspondentes (velocidade média 20,2 pts, CV 12,7%, pontuação de saúde 78,3/100, conclusão de itens de ação 46,7%).

---

## Fluxos de Trabalho de Execução de Sprint

### Planejamento de Sprint

1. Executar análise de velocidade: `python velocity_analyzer.py sprint_data.json --format text`
2. Usar o intervalo de confiança de 70% como teto de comprometimento recomendado para o backlog do sprint.
3. Revisar as pontuações de Confiabilidade de Comprometimento e Estabilidade de Escopo do pontuador de saúde para calibrar a negociação com o Product Owner.
4. Se a saída Monte Carlo mostrar alta volatilidade (CV >20%), apresentar isso às partes interessadas com estimativas de intervalo em vez de previsões de ponto único.
5. Documentar premissas de capacidade (licenças, dependências) para comparação na retrospectiva.

### Daily Standup

1. Rastrear participação e padrões de busca de ajuda — alimentar dados de cerimônia no `sprint_health_scorer.py` ao final do sprint.
2. Registrar cada bloqueador com data de abertura; o tempo de resolução alimenta a dimensão de Resolução de Bloqueadores.
3. Se um bloqueador estiver sem resolução após 2 dias, escalar proativamente e registrar nos dados do sprint.

### Sprint Review

1. Apresentar tendência de velocidade e pontuação de saúde ao lado da demo para dar contexto de entrega às partes interessadas.
2. Capturar solicitações de mudança de escopo levantadas durante a review; registrar como eventos de mudança de escopo nos dados do sprint para o próximo ciclo de pontuação.

### Retrospectiva de Sprint

1. Executar todos os três scripts antes da sessão:
   ```bash
   python sprint_health_scorer.py sprint_data.json --format text > health.txt
   python retrospective_analyzer.py sprint_data.json --format text > retro.txt
   ```
2. Abrir com a pontuação de saúde e as dimensões mais sinalizadas para focar a discussão.
3. Usar a taxa de conclusão de itens de ação do analisador de retrospectiva para determinar quantos novos itens de ação a equipe pode absorver realisticamente (meta: ≤3 se taxa de conclusão <60%).
4. Atribuir a cada item de ação um responsável e critério de sucesso mensurável antes de encerrar a sessão.
5. Registrar novos itens de ação em `sprint_data.json` para rastreamento no próximo ciclo.

---

## Fluxo de Trabalho de Desenvolvimento de Equipe

### Avaliação

```bash
python sprint_health_scorer.py team_data.json > health_assessment.txt
python retrospective_analyzer.py team_data.json > retro_insights.txt
```

- Mapear a saída de maturidade do analisador de retrospectiva para o estágio de desenvolvimento apropriado.
- Complementar com uma pesquisa de pulso de segurança psicológica anônima (escala de 7 pontos de Edmondson) e observações individuais de 1:1.
- Se a saída de maturidade for `forming` ou `storming`, priorizar intervenções de segurança e facilitação de conflitos antes da otimização de processo.

### Intervenção

Aplicar facilitação específica ao estágio (detalhes em `references/team-dynamics-framework.md`):

| Estágio | Foco |
|---|---|
| Forming | Estrutura, educação sobre processo, construção de confiança |
| Storming | Facilitação de conflitos, manutenção de segurança psicológica |
| Norming | Construção de autonomia, transferência de propriedade do processo |
| Performing | Introdução de desafios, suporte à inovação |

### Medição de Progresso

- **Cadência de sprint**: reexecutar pontuador de saúde; meta de melhoria geral de ≥5 pontos por trimestre.
- **Mensal**: pesquisa de pulso de segurança psicológica; meta >4,0/5,0.
- **Trimestral**: reavaliação completa de maturidade via analisador de retrospectiva.
- Se as pontuações platinarem ou regredirem por 2 sprints consecutivos, escalar estratégia de intervenção (veja `references/team-dynamics-framework.md`).

---

## Métricas e Metas Principais

| Métrica | Meta |
|---|---|
| Pontuação Geral de Saúde | >80/100 |
| Índice de Segurança Psicológica | >4,0/5,0 |
| CV de Velocidade (previsibilidade) | <20% |
| Confiabilidade de Comprometimento | >85% |
| Estabilidade de Escopo | <15% mudanças no meio do sprint |
| Tempo de Resolução de Bloqueador | <3 dias |
| Engajamento em Cerimônias | >90% |
| Conclusão de Itens de Ação de Retrospectiva | >70% |

---

## Limitações

- **Tamanho da amostra**: menos de 6 sprints reduz a confiança Monte Carlo; sempre declarar intervalos de confiança, não estimativas de ponto.
- **Completude dos dados**: campos de cerimônia ou conclusão de história ausentes suprimem dimensões de pontuação afetadas — reportar lacunas explicitamente.
- **Sensibilidade ao contexto**: as recomendações do script devem ser interpretadas junto com contexto organizacional e de equipe não capturado nos dados JSON.
- **Viés quantitativo**: métricas não substituem observação qualitativa; combinar pontuações com interação direta com a equipe.
- **Tamanho da equipe**: as técnicas são otimizadas para equipes de 5–9 membros; grupos maiores podem exigir adaptação.
- **Fatores externos**: dependências entre equipes e restrições organizacionais não são totalmente modeladas por métricas de equipe única.

---

## Skills Relacionadas

- **Agile Product Owner** (`product-team/agile-product-owner/`) — Histórias de usuário e backlog alimentam o planejamento de sprint
- **Senior PM** (`project-management/senior-pm/`) — Contexto de saúde de portfólio informa prioridades de sprint

---

*Para referências profundas de framework veja `references/velocity-forecasting-guide.md` e `references/team-dynamics-framework.md`. Para ativos de template veja `assets/sprint_report_template.md` e `assets/team_health_check_template.md`.*
