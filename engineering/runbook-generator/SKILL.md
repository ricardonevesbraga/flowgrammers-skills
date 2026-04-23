---
name: "runbook-generator"
description: "Gerador de Runbook. Gera runbooks operacionais rapidamente a partir do nome do serviço e personaliza para fluxos de trabalho de implantação, resposta a incidentes, manutenção e rollback."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Runbook Generator

**Nível:** PODEROSO
**Categoria:** Engenharia
**Domínio:** DevOps / Engenharia de Confiabilidade de Sites

---

## Visão Geral

Gere runbooks operacionais rapidamente a partir de um nome de serviço, depois personalize para fluxos de trabalho de implantação, resposta a incidentes, manutenção e rollback.

## Capacidades Principais

- Geração de esqueleto de runbook a partir de uma CLI
- Seções padrão para início/parada/saúde/rollback
- Placeholders estruturados para escalonamento e tratamento de incidentes
- Templates de referência para playbooks de implantação e incidentes

---

## Quando Usar

- Um serviço não tem runbook e precisa de uma linha de base imediatamente
- Os runbooks existentes são inconsistentes entre equipes
- A integração de plantão requer documentação operacional padronizada
- Você precisa de scaffolding de runbook repetível para novos serviços

---

## Início Rápido

```bash
# Imprimir runbook na saída padrão
python3 scripts/runbook_generator.py payments-api

# Gravar arquivo de runbook
python3 scripts/runbook_generator.py payments-api --owner platform --output docs/runbooks/payments-api.md
```

---

## Fluxo de Trabalho Recomendado

1. Gere o esqueleto inicial com `scripts/runbook_generator.py`.
2. Preencha comandos e URLs específicos do serviço.
3. Adicione verificações de validação e gatilhos de rollback.
4. Faça um dry-run em staging.
5. Armazene o runbook em controle de versão próximo ao código do serviço.

---

## Documentos de Referência

- `references/runbook-templates.md`

---

## Armadilhas Comuns

- Gatilhos de rollback ou comandos de rollback ausentes
- Passos sem verificações de saída esperada
- Contatos de propriedade/escalonamento desatualizados
- Runbooks nunca testados fora de incidentes

## Melhores Práticas

1. Mantenha cada comando como copiar e colar.
2. Inclua verificações de saúde após cada passo crítico.
3. Valide os runbooks em uma cadência de revisão fixa.
4. Atualize o conteúdo do runbook após incidentes e post-mortems.
