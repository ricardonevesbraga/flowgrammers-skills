---
name: "changelog-generator"
description: "Gerador de Changelog — produz notas de versão consistentes e auditáveis a partir de Conventional Commits, com detecção de bump semântico e renderização de seções Keep a Changelog."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Changelog Generator

**Nível:** PODEROSO  
**Categoria:** Engenharia  
**Domínio:** Gerenciamento de Releases / Documentação

## Visão Geral

Use esta skill para produzir notas de release consistentes e auditáveis a partir de Conventional Commits. Ela separa o parsing de commits, a lógica de bump semântico e a renderização do changelog para que as equipes possam automatizar releases sem perder controle editorial.

## Capacidades Principais

- Analisar mensagens de commit usando regras de Conventional Commit
- Detectar bump semântico (`major`, `minor`, `patch`) a partir do stream de commits
- Renderizar seções Keep a Changelog (`Added`, `Changed`, `Fixed`, etc.)
- Gerar entradas de release a partir de ranges git ou input de commit fornecido
- Aplicar formato de commit com um script de linter dedicado
- Suportar integração CI via saída em JSON legível por máquina

## Quando Usar

- Antes de publicar uma tag de release
- Durante CI para gerar notas de release automaticamente
- Durante verificações de PR para bloquear formatos de mensagem de commit inválidos
- Em monorepos onde os changelogs de pacotes exigem filtragem por escopo
- Ao converter histórico bruto do git em notas voltadas ao usuário

## Workflows Principais

### 1. Gerar Entrada de Changelog a Partir do Git

```bash
python3 scripts/generate_changelog.py \
  --from-tag v1.3.0 \
  --to-tag v1.4.0 \
  --next-version v1.4.0 \
  --format markdown
```

### 2. Gerar Entrada a Partir de stdin/Arquivo de Entrada

```bash
git log v1.3.0..v1.4.0 --pretty=format:'%s' | \
  python3 scripts/generate_changelog.py --next-version v1.4.0 --format markdown

python3 scripts/generate_changelog.py --input commits.txt --next-version v1.4.0 --format json
```

### 3. Atualizar `CHANGELOG.md`

```bash
python3 scripts/generate_changelog.py \
  --from-tag v1.3.0 \
  --to-tag HEAD \
  --next-version v1.4.0 \
  --write CHANGELOG.md
```

### 4. Fazer Lint de Commits Antes do Merge

```bash
python3 scripts/commit_linter.py --from-ref origin/main --to-ref HEAD --strict --format text
```

Ou via arquivo/stdin:

```bash
python3 scripts/commit_linter.py --input commits.txt --strict
cat commits.txt | python3 scripts/commit_linter.py --format json
```

## Regras de Conventional Commit

Tipos suportados:

- `feat`, `fix`, `perf`, `refactor`, `docs`, `test`, `build`, `ci`, `chore`
- `security`, `deprecated`, `remove`

Mudanças que quebram compatibilidade:

- `type(scope)!: resumo`
- Rodapé/corpo inclui `BREAKING CHANGE:`

Mapeamento SemVer:

- breaking -> `major`
- `feat` sem breaking -> `minor`
- todos os outros -> `patch`

## Interfaces dos Scripts

- `python3 scripts/generate_changelog.py --help`
  - Lê commits do git ou stdin/`--input`
  - Renderiza markdown ou JSON
  - Opcional prepend de changelog in-place
- `python3 scripts/commit_linter.py --help`
  - Valida o formato do commit
  - Retorna código diferente de zero no modo `--strict` em violações

## Armadilhas Comuns

1. Misturar mensagens de commit de merge com o parsing de commit de release
2. Usar resumos de commit vagos que não podem se tornar notas de release
3. Falhar em incluir orientação de migração para mudanças que quebram compatibilidade
4. Tratar mudanças de docs/chore como funcionalidades voltadas ao usuário
5. Sobrescrever seções históricas do changelog em vez de adicionar ao início

## Melhores Práticas

1. Mantenha commits pequenos e orientados por intenção.
2. Escope mensagens de commit (`feat(api): ...`) em repos com múltiplos pacotes.
3. Aplique verificações de linter nos pipelines de PR.
4. Revise o markdown gerado antes de publicar.
5. Crie tags de release somente após o sucesso da geração do changelog.
6. Mantenha uma seção `[Unreleased]` para curadoria manual quando necessário.

## Referências

- [references/ci-integration.md](references/ci-integration.md)
- [references/changelog-formatting-guide.md](references/changelog-formatting-guide.md)
- [references/monorepo-strategy.md](references/monorepo-strategy.md)
- [README.md](README.md)

## Governança de Release

Use este fluxo de release para previsibilidade:

1. Faça lint do histórico de commits para o range de release alvo.
2. Gere um rascunho de changelog a partir dos commits.
3. Ajuste manualmente a redação para clareza do cliente.
4. Valide a recomendação de bump semver.
5. Crie a tag de release somente após o changelog ser aprovado.

## Verificações de Qualidade da Saída

- Cada item é significativo para o usuário, não é ruído de implementação.
- Mudanças que quebram compatibilidade incluem ação de migração.
- Correções de segurança são isoladas na seção `Security`.
- Seções sem entradas são omitidas.
- Itens duplicados entre seções são removidos.

## Política de CI

- Execute `commit_linter.py --strict` em todos os PRs.
- Bloqueie o merge em commits convencionais inválidos.
- Gere automaticamente rascunhos de notas de release no push de tag.
- Exija aprovação humana antes de gravar no `CHANGELOG.md` na branch main.

## Orientação para Monorepo

- Prefira escopos de commit alinhados aos nomes dos pacotes.
- Filtre o stream de commits por escopo para releases específicos de pacotes.
- Mantenha mudanças em toda a infraestrutura no changelog raiz.
- Armazene changelogs de pacotes próximos às raízes dos pacotes para clareza de propriedade.

## Tratamento de Falhas

- Se nenhum commit convencional válido for encontrado: falhe cedo, não gere notas vazias enganosas.
- Se o range git for inválido: mostre o range explícito na saída de erro.
- Se o destino de escrita estiver ausente: crie um scaffolding seguro de cabeçalho de changelog.
