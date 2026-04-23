---
name: "prompt-engineer-toolkit"
description: "Analisa e reescreve prompts para melhor saída de IA, cria templates de prompt reutilizáveis para casos de uso de marketing (copy de anúncios, campanhas de e-mail, mídia social) e estrutura fluxos de trabalho de conteúdo de IA de ponta a ponta. Use quando o usuário quer melhorar prompts para marketing assistido por IA, construir templates de prompt ou otimizar fluxos de trabalho de conteúdo de IA. Use também quando o usuário mencionar 'engenharia de prompt', 'melhorar meus prompts', 'qualidade de escrita com IA', 'templates de prompt' ou 'fluxo de trabalho de conteúdo com IA'."
license: MIT
metadata:
  version: 1.0.0
  author: Ric Neves - Flowgrammers
  category: marketing
  updated: 2026-03-06
agents:
  - claude-code
---

# Toolkit de Engenharia de Prompt

## Visão Geral

Use esta skill para mover prompts de rascunhos ad-hoc para ativos de produção com testes repetíveis, versionamento e segurança de regressão. Ela enfatiza qualidade mensurável sobre intuição. Aplique-a quando lançar um novo recurso de LLM que precisa de saídas confiáveis, quando a qualidade do prompt piora após mudanças de modelo ou instrução, quando múltiplos membros do time editam prompts e precisam de histórico/diffs, quando você precisa de escolha de prompt baseada em evidências para implantação em produção, ou quando você quer governança de prompt consistente entre ambientes.

## Capacidades Principais

- Avaliação de prompt A/B contra casos de teste estruturados
- Pontuação quantitativa para aderência, relevância e verificações de segurança
- Rastreamento de versão de prompt com histórico imutável e changelog
- Diffs de prompt para revisar edições com impacto no comportamento
- Templates de prompt reutilizáveis e orientação de seleção
- Fluxos de trabalho favoráveis à regressão para atualizações de modelo/prompt

## Fluxos de Trabalho Principais

### 1. Executar Teste A/B de Prompt

Prepare casos de teste JSON e execute:

```bash
python3 scripts/prompt_tester.py \
  --prompt-a-file prompts/a.txt \
  --prompt-b-file prompts/b.txt \
  --cases-file testcases.json \
  --runner-cmd 'my-llm-cli --prompt {prompt} --input {input}' \
  --format text
```

A entrada também pode vir de stdin/`--input` JSON payload.

### 2. Escolher Vencedor com Evidências

O testador pontua saídas por caso e agrega:

- cobertura de conteúdo esperado
- violações de conteúdo proibido
- conformidade de regex/formato
- sanidade de comprimento de saída

Use o prompt de maior pontuação como baseline candidato, depois execute a suite de regressão.

### 3. Versionar Prompts

```bash
# Adicionar versão
python3 scripts/prompt_versioner.py add \
  --name support_classifier \
  --prompt-file prompts/support_v3.txt \
  --author alice

# Diff de versões
python3 scripts/prompt_versioner.py diff --name support_classifier --from-version 2 --to-version 3

# Changelog
python3 scripts/prompt_versioner.py changelog --name support_classifier
```

### 4. Loop de Regressão

1. Armazene versão baseline.
2. Proponha edições de prompt.
3. Execute novamente o teste A/B.
4. Promova apenas se pontuação e restrições de segurança melhorarem.

## Interfaces de Script

- `python3 scripts/prompt_tester.py --help`
  - Lê prompts/casos de stdin ou `--input`
  - Comando de runner externo opcional
  - Emite métricas de texto ou JSON
- `python3 scripts/prompt_versioner.py --help`
  - Gerencia histórico de prompt (`add`, `list`, `diff`, `changelog`)
  - Armazena metadados e snapshots de conteúdo localmente

## Armadilhas, Melhores Práticas & Checklist de Revisão

**Evite esses erros:**
1. Escolher prompts de saídas de caso único — use uma suite de teste realista e rica em casos extremos.
2. Mudar prompt e modelo simultaneamente — sempre isole variáveis.
3. Perder verificações de `must_not_contain` (conteúdo proibido) nos critérios de avaliação.
4. Editar prompts sem metadados de versão, autor ou justificativa de mudança.
5. Pular diffs semânticos antes de implantar uma nova versão de prompt.
6. Otimizar um benchmark enquanto prejudica casos extremos — rastreie a suite completa.
7. Troca de modelo sem reexecutar a suite A/B baseline.

**Antes de promover qualquer prompt, confirme:**
- [ ] A intenção da tarefa é explícita e inequívoca.
- [ ] O schema/formato de saída é explícito.
- [ ] Restrições de segurança e exclusão são explícitas.
- [ ] Sem instruções contraditórias.
- [ ] Sem tokens de verbosidade desnecessários.
- [ ] A pontuação A/B melhora e a contagem de violação permanece zero.

## Referências

- [references/prompt-templates.md](references/prompt-templates.md)
- [references/technique-guide.md](references/technique-guide.md)
- [references/evaluation-rubric.md](references/evaluation-rubric.md)
- [README.md](README.md)

## Design de Avaliação

Cada caso de teste deve definir:

- `input`: entrada realista similar à produção
- `expected_contains`: marcadores/conteúdo obrigatórios
- `forbidden_contains`: frases ou conteúdo inseguro não permitido
- `expected_regex`: padrões estruturais obrigatórios

Isso habilita gradação determinística entre variantes de prompt.

## Política de Versionamento

- Use identificadores de prompt semânticos por funcionalidade (`support_classifier`, `ad_copy_shortform`).
- Registre autor + nota de mudança para cada revisão.
- Nunca sobrescreva versões históricas.
- Faça diff antes de promover um novo prompt para produção.

## Estratégia de Implantação

1. Crie versão de prompt baseline.
2. Proponha prompt candidato.
3. Execute suite A/B contra os mesmos casos.
4. Promova apenas se o vencedor melhora a média e mantém a contagem de violação em zero.
5. Rastreie feedback pós-lançamento e alimente novos casos de falha de volta na suite de teste.
