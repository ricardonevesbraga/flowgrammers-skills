---
name: roadmap-communicator
description: Use ao preparar narrativas de roadmap, notas de versão, changelogs ou atualizações para partes interessadas adaptadas para executivos, equipes de engenharia e clientes.
agents:
  - claude-code
---

# Comunicador de Roadmap

Criar artefatos claros de comunicação de roadmap para partes interessadas internas e externas.

## Quando Usar

Use esta skill para:
- Construir apresentações de roadmap em diferentes formatos
- Escrever atualizações para partes interessadas (conselho, engenharia, clientes)
- Produzir notas de versão (voltadas ao usuário e internas)
- Gerar changelogs a partir do histórico do git
- Estruturar anúncios de funcionalidades

## Formatos de Roadmap

1. Agora / Em seguida / Depois
- Melhor para incerteza e flexibilidade estratégica.
- Comunica direção sem falsa precisão.

2. Roadmap de cronograma
- Melhor para compromissos de data fixa e coordenação de lançamento.
- Requer gerenciamento ativo de risco e dependência.

3. Roadmap baseado em temas
- Melhor para planejamento orientado a resultados e alinhamento entre equipes.
- Agrupa iniciativas por espaço de problema ou objetivo estratégico.

Veja `references/roadmap-templates.md` para templates.

## Padrões de Atualização para Partes Interessadas

### Conselho / Executivo
- Orientado a resultado e risco
- Foco no progresso em relação aos objetivos estratégicos
- Destaque trade-offs e decisões necessárias

### Engenharia
- Clareza sobre escopo, dependências e sequenciamento
- Status, bloqueadores e implicações de recursos

### Clientes
- Narrativa de valor e janela de tempo
- O que está disponível agora vs o que vem a seguir
- Definição clara de expectativas

Veja `references/communication-templates.md` para templates reutilizáveis.

## Orientação sobre Notas de Versão

### Notas de Versão Voltadas ao Usuário
- Lidere com valor para o usuário, não com detalhes de implementação interna.
- Agrupe por fluxos de trabalho ou jobs do usuário.
- Inclua mudanças de migração/comportamento explicitamente.

### Notas de Versão Internas
- Inclua detalhes técnicos, impacto operacional e problemas conhecidos.
- Capture plano de rollout, critérios de rollback e notas de monitoramento.

## Geração de Changelog

Use:
```bash
python3 scripts/changelog_generator.py --from v1.0.0 --to HEAD
```

Funcionalidades:
- Lê intervalo do git log
- Analisa prefixos de commit convencional
- Agrupa entradas por tipo (`feat`, `fix`, `chore`, etc.)
- Produz markdown ou texto simples

## Framework de Anúncio de Funcionalidade

1. Contexto do problema
2. O que mudou
3. Por que isso importa
4. Quem se beneficia mais
5. Como começar
6. Call to action e canal de feedback

## Lista de Verificação de Qualidade de Comunicação

- [ ] O enquadramento específico para a audiência está explícito.
- [ ] Resultados e trade-offs estão claros.
- [ ] A terminologia é consistente entre os artefatos.
- [ ] Riscos e dependências não estão ocultos.
- [ ] Próximas ações e responsáveis estão especificados.
