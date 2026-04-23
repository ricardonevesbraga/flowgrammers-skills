---
name: "ci-cd-pipeline-builder"
description: "Construtor de Pipeline CI/CD — gera pipelines pragmáticos a partir de sinais detectados do stack do projeto, com estágios de lint, test, build e deploy, e suporte a GitHub Actions e GitLab CI."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# CI/CD Pipeline Builder

**Nível:** PODEROSO  
**Categoria:** Engenharia  
**Domínio:** DevOps / Automação

## Visão Geral

Use esta skill para gerar pipelines CI/CD pragmáticos a partir de sinais detectados do stack do projeto, não de suposições. Ela se concentra em geração rápida de baseline, verificações repetíveis e estágios de implantação com consciência de ambiente.

## Capacidades Principais

- Detectar linguagem/runtime/ferramental a partir dos arquivos do repositório
- Recomendar estágios de CI (`lint`, `test`, `build`, `deploy`)
- Gerar pipelines iniciais para GitHub Actions ou GitLab CI
- Incluir estratégia de cache e matrix com base no stack detectado
- Emitir saída de detecção legível por máquina para automação
- Manter a lógica do pipeline alinhada com lockfiles e comandos de build do projeto

## Quando Usar

- Inicializando CI para um novo repositório
- Substituindo arquivos de pipeline copiados e frágeis
- Migrando entre GitHub Actions e GitLab CI
- Auditando se os passos do pipeline correspondem ao stack atual
- Criando um baseline reproduzível antes do hardening personalizado

## Workflows Principais

### 1. Detectar Stack

```bash
python3 scripts/stack_detector.py --repo . --format text
python3 scripts/stack_detector.py --repo . --format json > detected-stack.json
```

Suporta entrada via stdin ou arquivo `--input` para payloads de análise offline.

### 2. Gerar Pipeline a Partir da Detecção

```bash
python3 scripts/pipeline_generator.py \
  --input detected-stack.json \
  --platform github \
  --output .github/workflows/ci.yml \
  --format text
```

Ou de ponta a ponta diretamente do repo:

```bash
python3 scripts/pipeline_generator.py --repo . --platform gitlab --output .gitlab-ci.yml
```

### 3. Validar Antes do Merge

1. Confirme que os comandos existem no projeto (`test`, `lint`, `build`).
2. Execute o pipeline gerado localmente quando possível.
3. Garanta que secrets/variáveis de ambiente necessários estejam documentados.
4. Mantenha os jobs de deploy limitados por branches/ambientes protegidos.

### 4. Adicionar Estágios de Implantação com Segurança

- Comece apenas com CI (`lint/test/build`).
- Adicione deploy de staging com contexto de ambiente explícito.
- Adicione deploy de produção com gate/aprovação manual.
- Mantenha comandos de rollout/rollback explícitos e auditáveis.

## Interfaces dos Scripts

- `python3 scripts/stack_detector.py --help`
  - Detecta sinais de stack a partir dos arquivos do repositório
  - Lê entrada JSON opcional de stdin/`--input`
- `python3 scripts/pipeline_generator.py --help`
  - Gera YAML GitHub/GitLab a partir do payload de detecção
  - Escreve para stdout ou `--output`

## Armadilhas Comuns

1. Copiar um pipeline Node para repos Python/Go
2. Habilitar jobs de deploy antes de ter testes estáveis
3. Esquecer chaves de cache de dependência
4. Executar builds matrix caros para cada branch trivial
5. Faltam proteções de branch em torno de jobs de deploy para produção
6. Hardcodear secrets no YAML em vez de usar stores de secret do CI

## Melhores Práticas

1. Detecte o stack primeiro, depois gere o pipeline.
2. Mantenha o baseline gerado sob controle de versão.
3. Adicione uma otimização por vez (cache, matrix, jobs divididos).
4. Exija CI verde antes dos jobs de implantação.
5. Use ambientes protegidos para credenciais de produção.
6. Regenere o pipeline quando o stack mudar significativamente.

## Referências

- [references/github-actions-templates.md](references/github-actions-templates.md)
- [references/gitlab-ci-templates.md](references/gitlab-ci-templates.md)
- [references/deployment-gates.md](references/deployment-gates.md)
- [README.md](README.md)

## Heurísticas de Detecção

O detector de stack prioriza sinais determinísticos de arquivo sobre heurísticas:

- Lockfiles determinam a preferência do gerenciador de pacotes
- Manifestos de linguagem determinam famílias de runtime
- Comandos de script (se presentes) conduzem comandos de lint/test/build
- Scripts ausentes acionam comandos placeholder conservadores

## Estratégia de Geração

Comece com um pipeline mínimo e confiável:

1. Checkout e configuração do runtime
2. Instalar dependências com estratégia de cache
3. Executar lint, test, build em passos separados
4. Publicar artefatos somente após verificações bem-sucedidas

Depois adicione comportamento avançado (builds matrix, scans de segurança, gates de deploy).

## Notas de Decisão de Plataforma

- GitHub Actions para integração estreita com o ecossistema GitHub
- GitLab CI para SCM + CI integrados em ambientes auto-hospedados
- Mantenha uma fonte canônica de pipeline por repo para reduzir drift

## Lista de Verificação de Validação

1. O YAML gerado é analisado com sucesso.
2. Todos os comandos referenciados existem no repo.
3. A estratégia de cache corresponde ao gerenciador de pacotes.
4. Secrets necessários estão documentados, não embutidos.
5. Regras de branch/ambiente protegido correspondem à política da organização.

## Orientação de Escala

- Divida jobs longos por estágio quando o tempo de execução exceder 10 minutos.
- Introduza matrix de teste somente quando a compatibilidade realmente exigir.
- Separe jobs de deploy de jobs de CI para manter o feedback rápido.
- Rastreie duração do pipeline e instabilidade como métricas de primeira classe.
