---
name: "monorepo-navigator"
description: "Navegador de Monorepo. Navega, gerencia e otimiza monorepos com Turborepo, Nx, pnpm workspaces e Lerna. Análise de impacto entre pacotes, builds seletivos, cache remoto e visualização de grafo de dependências."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Monorepo Navigator

**Nível:** PODEROSO
**Categoria:** Engenharia
**Domínio:** Arquitetura de Monorepo / Sistemas de Build

---

## Visão Geral

Navegue, gerencie e otimize monorepos. Cobre Turborepo, Nx, pnpm workspaces e Lerna. Habilita análise de impacto entre pacotes, builds/testes seletivos apenas nos pacotes afetados, cache remoto, visualização de grafo de dependências e migrações estruturadas de multi-repo para monorepo. Inclui configuração do Claude Code para desenvolvimento com consciência de workspace.

---

## Capacidades Principais

- **Análise de impacto entre pacotes** — determine quais apps quebram quando um pacote compartilhado muda
- **Comandos seletivos** — execute testes/builds apenas nos pacotes afetados (não em tudo)
- **Grafo de dependências** — visualize relacionamentos entre pacotes como diagramas Mermaid
- **Otimização de build** — cache remoto, builds incrementais, execução paralela
- **Migração** — passo a passo de multi-repo → monorepo sem perda de histórico
- **Publicação** — changesets para versionamento, canais de pré-release, fluxos de trabalho npm publish
- **Configuração do Claude Code** — CLAUDE.md com consciência de workspace com instruções por pacote

---

## Quando Usar

Use quando:
- Múltiplos pacotes/apps compartilham código (componentes UI, utilitários, tipos, clientes de API)
- Os tempos de build são lentos porque tudo reconstrói quando qualquer coisa muda
- Migrando de múltiplos repositórios para um único repositório
- Precisar publicar pacotes no npm com versionamento coordenado
- Equipes trabalham em múltiplos pacotes e precisam de ferramentas unificadas

Pule quando:
- Projeto de app único sem pacotes compartilhados
- Limites de equipe/projeto são completamente isolados (polyrepo está bem)
- O código compartilhado é mínimo e o overhead de copiar e colar é aceitável

---

## Seleção de Ferramenta

| Ferramenta | Melhor Para | Funcionalidade-Chave |
|---|---|---|
| **Turborepo** | Monorepos JS/TS, configuração de pipeline simples | Cache remoto de melhor categoria, configuração mínima |
| **Nx** | Grandes empresas, ecossistema de plugins | Grafo de projeto, geração de código, comandos afetados |
| **pnpm workspaces** | Protocolo workspace, eficiência de disco | `workspace:*` para referências de pacotes locais |
| **Lerna** | Publicação npm, versionamento | Publicação em lote, commits convencionais |
| **Changesets** | Versionamento moderno (preferido ao Lerna) | Geração de changelog, canais de pré-release |

Configuração moderna mais comum: **pnpm workspaces + Turborepo + Changesets**

---

## Turborepo
→ Veja references/monorepo-tooling-reference.md para detalhes

## Analisador de Workspace

```bash
python3 scripts/monorepo_analyzer.py /caminho/para/monorepo
python3 scripts/monorepo_analyzer.py /caminho/para/monorepo --json
```

Veja também `references/monorepo-patterns.md` para arquitetura comum e padrões de CI.

## Armadilhas Comuns

| Armadilha | Correção |
|---|---|
| Executar `turbo run build` sem `--filter` em cada PR | Sempre use `--filter=...[origin/main]` no CI |
| Refs `workspace:*` causam falhas de publicação | Use `pnpm changeset publish` — substitui `workspace:*` por versões reais automaticamente |
| Todos os pacotes reconstruindo quando arquivo não relacionado muda | Ajuste `inputs` no turbo.json para excluir docs e configurações das chaves de cache |
| tsconfig compartilhado faz um pacote quebrar todas as verificações de tipo | Use `extends` corretamente — cada pacote estende a raiz mas sobrepõe `rootDir` / `outDir` |
| Histórico git perdido durante migração | Use `git filter-repo --to-subdirectory-filter` antes de mesclar — nunca mova arquivos manualmente |
| Cache remoto não funcionando no CI | Verifique variáveis de ambiente TURBO_TOKEN e TURBO_TEAM; verifique com `turbo run build --summarize` |
| CLAUDE.md genérico demais — Claude modifica o pacote errado | Adicione regras explícitas "Ao trabalhar em X, mexa apenas em arquivos em apps/X" por CLAUDE.md do pacote |

---

## Melhores Práticas

1. **CLAUDE.md raiz define o mapa** — documente cada pacote, seu propósito e regras de dependência
2. **CLAUDE.md por pacote define as regras** — o que é permitido, o que é proibido, comandos de teste
3. **Sempre delimite comandos com --filter** — executar tudo em cada mudança anula o propósito
4. **Cache remoto não é opcional** — sem ele, o CI do monorepo é mais lento que o CI de multi-repo
5. **Changesets em vez de versionamento manual** — nunca edite versions de package.json manualmente em um monorepo
6. **Configurações compartilhadas na raiz, estendidas nos pacotes** — tsconfig.base.json, .eslintrc.base.js, jest.base.config.js
7. **Análise de impacto antes de mesclar mudanças em pacotes compartilhados** — execute a verificação de afetados, comunique o raio de impacto
8. **Mantenha packages/types como TypeScript puro** — sem código de runtime, sem dependências, rápido de construir e verificar tipos
