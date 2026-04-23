---
name: "git-worktree-manager"
description: "Gerenciador de Git Worktree — executa trabalho paralelo em funcionalidades com segurança usando worktrees Git, com isolamento de branch, alocação de porta, sincronização de ambiente e limpeza padronizados."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Git Worktree Manager

**Nível:** PODEROSO  
**Categoria:** Engenharia  
**Domínio:** Desenvolvimento Paralelo e Isolamento de Branch

## Visão Geral

Use esta skill para executar trabalho paralelo em funcionalidades com segurança usando Git worktrees. Ela padroniza isolamento de branch, alocação de porta, sincronização de ambiente e limpeza para que cada worktree se comporte como um app local independente sem interferir em outro branch.

Esta skill é otimizada para workflows multi-agente onde cada agente ou sessão de terminal possui um worktree.

## Capacidades Principais

- Criar worktrees a partir de branches novos ou existentes com nomenclatura determinística
- Alocar automaticamente portas não conflitantes por worktree e persistir atribuições
- Copiar arquivos de ambiente locais (`.env*`) do repo principal para o novo worktree
- Opcionalmente instalar dependências com base na detecção de lockfile
- Detectar worktrees obsoletos e mudanças não commitadas antes da limpeza
- Identificar branches mergeados e remover worktrees desatualizados com segurança

## Quando Usar

- Você precisa de 2+ branches concorrentes abertos localmente
- Você quer servidores de dev isolados para funcionalidade, hotfix e validação de PR
- Você está trabalhando com múltiplos agentes que não devem compartilhar um branch
- Seu branch atual está bloqueado mas você precisa enviar uma correção rápida agora
- Você quer limpeza repetível em vez de operações `rm -rf` ad-hoc

## Workflows Principais

### 1. Criar um Worktree Totalmente Preparado

1. Escolha um nome de branch e nome de worktree.
2. Execute o script do gerenciador (cria o branch se estiver ausente).
3. Revise o mapa de porta gerado.
4. Inicie o app usando as portas alocadas.

```bash
python scripts/worktree_manager.py \
  --repo . \
  --branch feature/new-auth \
  --name wt-auth \
  --base-branch main \
  --install-deps \
  --format text
```

Se você usar entrada de automação JSON:

```bash
cat config.json | python scripts/worktree_manager.py --format json
# ou
python scripts/worktree_manager.py --input config.json --format json
```

### 2. Executar Sessões Paralelas

Convenção recomendada:

- Repo principal: branch de integração (`main`/`develop`) na porta padrão
- Worktree A: branch de funcionalidade + portas com offset
- Worktree B: branch de hotfix + próximo offset

Cada worktree contém `.worktree-ports.json` com as portas atribuídas.

### 3. Limpeza com Verificações de Segurança

1. Escaneie todos os worktrees e idade obsoleta.
2. Inspecione árvores sujas e status de merge do branch.
3. Remova apenas worktrees mergeados + limpos, ou force explicitamente.

```bash
python scripts/worktree_cleanup.py --repo . --stale-days 14 --format text
python scripts/worktree_cleanup.py --repo . --remove-merged --format text
```

### 4. Padrão Docker Compose

Use arquivos de override por worktree mapeados das portas alocadas. O script produz um mapa de porta determinístico; aplique-o ao `docker-compose.worktree.yml`.

Veja [docker-compose-patterns.md](references/docker-compose-patterns.md) para templates concretos.

### 5. Estratégia de Alocação de Porta

A estratégia padrão é `base + (índice * stride)` com verificações de colisão:

- App: `3000`
- Postgres: `5432`
- Redis: `6379`
- Stride: `10`

Veja [port-allocation-strategy.md](references/port-allocation-strategy.md) para a estratégia completa e casos extremos.

## Interfaces dos Scripts

- `python scripts/worktree_manager.py --help`
  - Criar/listar worktrees
  - Alocar/persistir portas
  - Copiar arquivos `.env*`
  - Instalação opcional de dependências
- `python scripts/worktree_cleanup.py --help`
  - Detecção de obsoleto por idade
  - Detecção de estado sujo
  - Detecção de branch mergeado
  - Remoção segura opcional

Ambas as ferramentas suportam stdin JSON e modo de arquivo `--input` para pipelines de automação.

## Armadilhas Comuns

1. Criar worktrees dentro do diretório do repo principal
2. Reutilizar `localhost:3000` em todos os branches
3. Compartilhar uma URL de banco de dados entre branches de funcionalidade isolados
4. Remover um worktree com mudanças não commitadas
5. Esquecer de podar metadados antigos após exclusão de branch
6. Assumir status de merge sem verificar contra o branch alvo

## Melhores Práticas

1. Um branch por worktree, um agente por worktree.
2. Mantenha os worktrees de curta duração; remova após o merge.
3. Use um padrão de nomenclatura determinístico (`wt-<tópico>`).
4. Persista mapeamentos de porta em arquivo, não em memória ou notas de terminal.
5. Execute varredura de limpeza semanalmente em repos ativos.
6. Use `--format json` para fluxos de máquina e `--format text` para revisão humana.
7. Nunca force-remova worktrees sujos a menos que as mudanças sejam intencionalmente descartadas.

## Lista de Verificação de Validação

Antes de declarar a configuração completa:

1. `git worktree list` mostra caminho + branch esperado.
2. `.worktree-ports.json` existe e contém portas únicas.
3. Arquivos `.env` copiados com sucesso (se presentes no repo de origem).
4. O comando de instalação de dependências sai com código `0` (se habilitado).
5. A varredura de limpeza não reporta árvores sujas obsoletas não intencionais.

## Referências

- [port-allocation-strategy.md](references/port-allocation-strategy.md)
- [docker-compose-patterns.md](references/docker-compose-patterns.md)
- [README.md](README.md) para início rápido e detalhes de instalação

## Matriz de Decisão

Use este seletor rápido antes de criar um novo worktree:

- Precisa de dependências isoladas e portas de servidor -> crie um novo worktree
- Precisa apenas de uma revisão de diff local rápida -> fique na árvore atual
- Precisa de hotfix enquanto o branch de funcionalidade está sujo -> crie worktree de hotfix dedicado
- Precisa de branch de reprodução efêmero para triagem de bug -> crie worktree temporário e faça limpeza no mesmo dia

## Lista de Verificação Operacional

### Antes da Criação

1. Confirme que o repo principal tem baseline limpo ou commits WIP intencionais.
2. Confirme a convenção de nomenclatura do branch alvo.
3. Confirme que o branch base necessário existe (`main`/`develop`).
4. Confirme que nenhuma porta local reservada já está ocupada por serviços fora do repo.

### Após a Criação

1. Verifique se o branch `git status` corresponde ao branch esperado.
2. Verifique se `.worktree-ports.json` existe.
3. Verifique se o app inicializa na porta de app alocada.
4. Verifique se os endpoints de BD e cache apontam para portas isoladas.

### Antes da Remoção

1. Verifique se o branch tem upstream e está mergeado quando pretendido.
2. Verifique se nenhum arquivo não commitado permanece.
3. Verifique se nenhum container/processo em execução depende deste caminho de worktree.

## Integração com CI e Equipe

- Use nomenclatura de caminho de worktree que mapeie para o ID da tarefa (`wt-1234-auth`).
- Inclua o caminho do worktree no título do terminal para evitar commits na janela errada.
- Em configurações automatizadas, persista metadados de criação em artefatos/logs de CI.
- Acione relatório de limpeza em jobs agendados e poste resumo no canal da equipe.

## Recuperação de Falha

- Se `git worktree add` falhar devido ao caminho existente: inspecione o caminho, não sobrescreva.
- Se a instalação de dependências falhar: mantenha o worktree criado, marque o status e continue a recuperação manual.
- Se a cópia de env falhar: continue com aviso e lista explícita de arquivos ausentes.
- Se a alocação de porta colidir com serviço externo: reexecute com portas base ajustadas.
