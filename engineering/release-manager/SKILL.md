---
name: "release-manager"
description: "Use quando o usuário pede para planejar releases, gerenciar changelogs, coordenar implantações, criar branches de release ou automatizar versionamento."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Release Manager

**Nível:** PODEROSO
**Categoria:** Engenharia
**Domínio:** Gerenciamento de Release de Software e DevOps

## Visão Geral

A skill Release Manager fornece ferramentas e conhecimento abrangentes para gerenciar releases de software de ponta a ponta. Desde a análise de commits convencionais até a geração de changelogs, determinação de versões e orquestração de processos de release, esta skill garante releases de software confiáveis, previsíveis e bem documentados.

## Capacidades Principais

- **Geração Automatizada de Changelog** a partir do histórico git usando commits convencionais
- **Bump de Versão Semântica** com base na análise de commits e mudanças disruptivas
- **Avaliação de Prontidão de Release** com listas de verificação e validação abrangentes
- **Planejamento e Coordenação de Release** com templates de comunicação com stakeholders
- **Planejamento de Rollback** com procedimentos de recuperação automatizados
- **Gerenciamento de Hotfix** para releases de emergência
- **Integração com Feature Flags** para rollouts progressivos

## Componentes Principais

### Scripts

1. **changelog_generator.py** - Analisa logs git e gera changelogs estruturados
2. **version_bumper.py** - Determina bumps de versão corretos a partir de commits convencionais
3. **release_planner.py** - Avalia a prontidão do release e gera planos de coordenação

### Documentação

- Metodologia abrangente de gerenciamento de release
- Especificação e exemplos de commits convencionais
- Comparações de fluxo de trabalho de release (Git Flow, Trunk-based, GitHub Flow)
- Procedimentos de hotfix e protocolos de resposta de emergência

## Metodologia de Gerenciamento de Release

### Versionamento Semântico (SemVer)

O Versionamento Semântico segue o formato MAJOR.MINOR.PATCH onde:

- **MAJOR** versão quando você faz mudanças incompatíveis de API
- **MINOR** versão quando você adiciona funcionalidade de forma compatível retroativamente
- **PATCH** versão quando você faz correções de bugs compatíveis retroativamente

#### Versões de Pré-release

Versões de pré-release são denotadas anexando um hífen e identificadores:
- `1.0.0-alpha.1` - Releases alpha para testes iniciais
- `1.0.0-beta.2` - Releases beta para testes mais amplos
- `1.0.0-rc.1` - Release candidates para validação final

#### Precedência de Versão

A precedência de versão é determinada comparando cada identificador:
1. `1.0.0-alpha` < `1.0.0-alpha.1` < `1.0.0-alpha.beta` < `1.0.0-beta`
2. `1.0.0-beta` < `1.0.0-beta.2` < `1.0.0-beta.11` < `1.0.0-rc.1`
3. `1.0.0-rc.1` < `1.0.0`

### Commits Convencionais

Os Commits Convencionais fornecem um formato estruturado para mensagens de commit que habilita ferramentas automatizadas:

#### Formato
```
<tipo>[escopo opcional]: <descrição>

[corpo opcional]

[rodapé(s) opcional(ais)]
```

#### Tipos
- **feat**: Uma nova funcionalidade (correlaciona com bump de versão MINOR)
- **fix**: Uma correção de bug (correlaciona com bump de versão PATCH)
- **docs**: Mudanças apenas na documentação
- **style**: Mudanças que não afetam o significado do código
- **refactor**: Uma mudança de código que nem corrige um bug nem adiciona uma funcionalidade
- **perf**: Uma mudança de código que melhora o desempenho
- **test**: Adicionando testes ausentes ou corrigindo testes existentes
- **chore**: Mudanças no processo de build ou ferramentas auxiliares
- **ci**: Mudanças em configurações e scripts de CI
- **build**: Mudanças que afetam o sistema de build ou dependências externas
- **breaking**: Introduz uma mudança disruptiva (correlaciona com bump de versão MAJOR)

#### Exemplos
```
feat(user-auth): adicionar integração OAuth2

fix(api): resolver race condition na criação de usuário

docs(readme): atualizar instruções de instalação

feat!: remover API de pagamento descontinuada
BREAKING CHANGE: A API de pagamento legada foi removida
```

### Geração Automatizada de Changelog

Os changelogs são gerados automaticamente a partir de commits convencionais, organizados por:

#### Estrutura
```markdown
# Changelog

## [Não Lançado]
### Adicionado
### Modificado
### Descontinuado
### Removido
### Corrigido
### Segurança

## [1.2.0] - 2024-01-15
### Adicionado
- Suporte a autenticação OAuth2 (#123)
- Painel de preferências do usuário (#145)

### Corrigido
- Race condition na criação de usuário (#134)
- Vazamento de memória no processamento de imagem (#156)

### Mudanças Disruptivas
- Removida API de pagamento legada
```

#### Regras de Agrupamento
- **Adicionado** para novas funcionalidades (feat)
- **Corrigido** para correções de bugs (fix)
- **Modificado** para mudanças em funcionalidades existentes
- **Descontinuado** para funcionalidades prestes a serem removidas
- **Removido** para funcionalidades já removidas
- **Segurança** para correções de vulnerabilidades

#### Extração de Metadados
- Link para pull requests e issues: `(#123)`
- Mudanças disruptivas destacadas com proeminência
- Agrupamento por escopo: `auth:`, `api:`, `ui:`
- Co-authored-by para reconhecimento de colaboradores

### Estratégias de Bump de Versão

Os bumps de versão são determinados pela análise dos commits desde o último release:

#### Regras de Detecção Automática
1. **MAJOR**: Qualquer commit com `BREAKING CHANGE` ou `!` após o tipo
2. **MINOR**: Qualquer commit do tipo `feat` sem mudanças disruptivas
3. **PATCH**: Commits dos tipos `fix`, `perf`, `security`
4. **SEM BUMP**: Apenas `docs`, `style`, `test`, `chore`, `ci`, `build`

#### Tratamento de Pré-release
```python
# Alpha: 1.0.0-alpha.1 → 1.0.0-alpha.2
# Beta: 1.0.0-alpha.5 → 1.0.0-beta.1  
# RC: 1.0.0-beta.3 → 1.0.0-rc.1
# Release: 1.0.0-rc.2 → 1.0.0
```

#### Considerações para Monorepos
Para monorepos com múltiplos pacotes:
- Analise commits que afetam cada pacote independentemente
- Suporte a bumps de versão com escopo: `@scope/package@1.2.3`
- Gere planos de release coordenados entre pacotes

### Fluxos de Trabalho de Branch de Release

#### Git Flow
```
main (produção) ← release/1.2.0 ← develop ← feature/login
                                         ← hotfix/critical-fix
```

**Vantagens:**
- Clara separação de preocupações
- Branch main estável
- Desenvolvimento paralelo de funcionalidades
- Processo de release estruturado

**Processo:**
1. Crie branch de release a partir de develop: `git checkout -b release/1.2.0 develop`
2. Finalize o release (bump de versão, changelog)
3. Mescle para main e develop
4. Crie tag do release: `git tag v1.2.0`
5. Implante a partir de main

#### Desenvolvimento Trunk-based
```
main ← feature/login (curta duração)
    ← feature/payment (curta duração)  
    ← hotfix/critical-fix
```

**Vantagens:**
- Fluxo de trabalho simplificado
- Integração mais rápida
- Conflitos de merge reduzidos
- Amigável para integração contínua

**Processo:**
1. Branches de funcionalidade de curta duração (1-3 dias)
2. Commits frequentes para main
3. Feature flags para funcionalidades incompletas
4. Portões de testes automatizados
5. Implantação a partir de main com feature toggles

#### GitHub Flow
```
main ← feature/login
    ← hotfix/critical-fix
```

**Vantagens:**
- Simples e leve
- Ciclo de implantação rápido
- Bom para aplicações web
- Overhead mínimo

**Processo:**
1. Crie branch de funcionalidade a partir de main
2. Commits e pushes regulares
3. Abra pull request quando estiver pronto
4. Implante a partir do branch de funcionalidade para testes
5. Mescle para main e implante

### Integração com Feature Flags

As feature flags habilitam rollouts seguros e progressivos:

#### Tipos de Feature Flags
- **Flags de release**: Controle a visibilidade da funcionalidade em produção
- **Flags de experimento**: Testes A/B e rollouts graduais
- **Flags operacionais**: Circuit breakers e toggles de desempenho
- **Flags de permissão**: Acesso a funcionalidades baseado em papel

#### Estratégia de Implementação
```python
# Exemplo de rollout progressivo
if feature_flag("new_payment_flow", user_id):
    return new_payment_processor.process(payment)
else:
    return legacy_payment_processor.process(payment)
```

#### Coordenação de Release
1. Implante código com funcionalidade atrás de flag (desabilitada)
2. Habilite gradualmente para porcentagem de usuários
3. Monitore métricas e taxas de erro
4. Rollout completo ou rollback rápido com base nos dados
5. Remova a flag no release subsequente

### Listas de Verificação de Prontidão de Release

#### Validação Pré-Release
- [ ] Todas as funcionalidades planejadas implementadas e testadas
- [ ] Mudanças disruptivas documentadas com guia de migração
- [ ] Documentação de API atualizada
- [ ] Migrações de banco de dados testadas
- [ ] Revisão de segurança concluída para mudanças sensíveis
- [ ] Testes de desempenho passaram nos thresholds
- [ ] Strings de internacionalização atualizadas
- [ ] Integrações de terceiros validadas

#### Portões de Qualidade
- [ ] Cobertura de testes unitários ≥ 85%
- [ ] Testes de integração passando
- [ ] Testes de ponta a ponta passando
- [ ] Análise estática limpa
- [ ] Varredura de segurança aprovada
- [ ] Auditoria de dependências limpa
- [ ] Testes de carga concluídos

#### Requisitos de Documentação
- [ ] CHANGELOG.md atualizado
- [ ] README.md reflete novas funcionalidades
- [ ] Documentação de API gerada
- [ ] Guia de migração escrito para mudanças disruptivas
- [ ] Notas de implantação preparadas
- [ ] Procedimento de rollback documentado

#### Aprovações de Stakeholders
- [ ] Aprovação do Product Manager
- [ ] Aprovação do Tech Lead de Engenharia
- [ ] Validação de QA concluída
- [ ] Liberação da equipe de segurança
- [ ] Revisão jurídica (se aplicável)
- [ ] Verificação de conformidade (se regulado)

### Coordenação de Implantação

#### Plano de Comunicação
**Stakeholders Internos:**
- Equipe de engenharia: Mudanças técnicas e procedimentos de rollback
- Equipe de produto: Descrições de funcionalidades e impacto no usuário
- Equipe de suporte: Problemas conhecidos e guias de troubleshooting
- Equipe de vendas: Mudanças voltadas ao cliente e pontos de discussão

**Comunicação Externa:**
- Notas de release para usuários
- Changelog de API para desenvolvedores
- Guia de migração para mudanças disruptivas
- Notificações de downtime se aplicável

#### Sequência de Implantação
1. **Pré-implantação** (T-24h): Validação final, congele o código
2. **Migrações de banco de dados** (T-2h): Execute e valide mudanças de esquema
3. **Implantação blue-green** (T-0): Mude o tráfego gradualmente
4. **Pós-implantação** (T+1h): Monitore métricas e logs
5. **Janela de rollback** (T+4h): Ponto de decisão para rollback

#### Monitoramento e Validação
- Verificações de saúde da aplicação
- Monitoramento de taxa de erro
- Rastreamento de métricas de desempenho
- Monitoramento de experiência do usuário
- Validação de métricas de negócio
- Saúde de integrações de terceiros

### Procedimentos de Hotfix

Os hotfixes abordam problemas críticos de produção que requerem implantação imediata:

#### Classificação de Severidade
**P0 - Crítico**: Interrupção completa do sistema, perda de dados, violação de segurança
- **SLA**: Corrija em 2 horas
- **Processo**: Implantação de emergência, todos as mãos no deck
- **Aprovação**: Tech Lead de Engenharia + Gerente de Plantão

**P1 - Alto**: Funcionalidade principal quebrada, impacto significativo no usuário
- **SLA**: Corrija em 24 horas
- **Processo**: Revisão e implantação aceleradas
- **Aprovação**: Tech Lead de Engenharia + Product Manager

**P2 - Médio**: Problemas menores de funcionalidade, impacto limitado no usuário
- **SLA**: Corrija no próximo ciclo de release
- **Processo**: Processo normal de revisão
- **Aprovação**: Revisão padrão de PR

#### Processo de Resposta de Emergência
1. **Declaração de incidente**: Acione a equipe de plantão
2. **Avaliação**: Determine severidade e impacto
3. **Branch de hotfix**: Crie a partir do último release estável
4. **Correção mínima**: Aborde apenas a causa raiz
5. **Testes acelerados**: Testes automatizados + validação manual
6. **Implantação de emergência**: Implante em produção
7. **Pós-incidente**: Análise de causa raiz e prevenção

### Planejamento de Rollback

Todo release deve ter um plano de rollback testado:

#### Gatilhos de Rollback
- **Pico na taxa de erro**: Mais de 2x a linha de base em 30 minutos
- **Degradação de desempenho**: Aumento de latência >50%
- **Falhas de funcionalidade**: Funcionalidade principal quebrada
- **Incidente de segurança**: Vulnerabilidade explorada
- **Corrupção de dados**: Integridade do banco de dados comprometida

#### Tipos de Rollback
**Rollback de Código:**
- Reverta para a imagem Docker anterior
- Apenas mudanças de código compatíveis com banco de dados
- Desabilitação de feature flag preferível ao rollback de código

**Rollback de Banco de Dados:**
- Apenas para migrações não destrutivas
- Backup de dados obrigatório antes da migração
- Migrações somente para frente preferidas (adicione colunas, não remova)

**Rollback de Infraestrutura:**
- Troca de implantação blue-green
- Reversão de configuração de balanceador de carga
- Mudanças de DNS (tempo de propagação maior)

#### Rollback Automatizado
```python
# Exemplo de automação de rollback
def monitor_deployment():
    if error_rate() > THRESHOLD:
        alert_oncall("Pico na taxa de erro detectado")
        if auto_rollback_enabled():
            execute_rollback()
```

### Métricas e Analytics de Release

#### Indicadores-Chave de Desempenho
- **Lead Time**: Do commit à produção
- **Frequência de Implantação**: Releases por semana/mês
- **Tempo Médio de Recuperação**: Do incidente à resolução
- **Taxa de Falha de Mudança**: Porcentagem de releases causando incidentes

#### Métricas de Qualidade
- **Taxa de Rollback**: Porcentagem de releases revertidos
- **Taxa de Hotfix**: Hotfixes por release regular
- **Taxa de Escape de Bugs**: Bugs de produção por release
- **Tempo para Detecção**: Quão rapidamente os problemas são identificados

#### Métricas de Processo
- **Tempo de Revisão**: Tempo gasto em revisão de código
- **Tempo de Testes**: Duração de testes automatizados + manuais
- **Ciclo de Aprovação**: Tempo do PR à mesclagem
- **Preparação de Release**: Tempo gasto em atividades de release

### Integração de Ferramentas

#### Sistemas de Controle de Versão
- **Git**: VCS primário com análise de commits convencionais
- **GitHub/GitLab**: Automação de pull request e CI/CD
- **Bitbucket**: Integração de pipeline e portões de implantação

#### Plataformas CI/CD
- **Jenkins**: Orquestração de pipeline e automação de implantação
- **GitHub Actions**: Automação de workflow e publicação de release
- **GitLab CI**: Pipelines integrados com gerenciamento de ambiente
- **CircleCI**: Builds baseados em container e implantações

#### Monitoramento e Alertas
- **DataDog**: Monitoramento de desempenho da aplicação
- **New Relic**: Rastreamento de erros e insights de desempenho
- **Sentry**: Agregação de erros e rastreamento de releases
- **PagerDuty**: Resposta a incidentes e escalonamento

#### Plataformas de Comunicação
- **Slack**: Notificações de release e coordenação
- **Microsoft Teams**: Comunicação com stakeholders
- **Email**: Notificações externas para clientes
- **Páginas de Status**: Comunicação pública de incidentes

## Melhores Práticas

### Planejamento de Release
1. **Cadência regular**: Estabeleça um calendário de release previsível
2. **Congelamento de funcionalidades**: Bloqueie mudanças 48h antes do release
3. **Avaliação de riscos**: Avalie mudanças para potencial impacto
4. **Alinhamento de stakeholders**: Garanta que todas as equipes estejam preparadas

### Garantia de Qualidade
1. **Testes automatizados**: Cobertura abrangente de testes
2. **Ambiente de staging**: Ambiente de testes semelhante ao de produção
3. **Releases canário**: Rollout gradual para um subconjunto de usuários
4. **Monitoramento**: Detecção proativa de problemas

### Comunicação
1. **Cronogramas claros**: Comunique os agendamentos com antecedência
2. **Atualizações regulares**: Relatórios de status durante o processo de release
3. **Transparência de problemas**: Comunicação honesta sobre problemas
4. **Post-mortems**: Aprenda com incidentes e melhore

### Automação
1. **Reduza etapas manuais**: Automatize tarefas repetitivas
2. **Processo consistente**: Os mesmos passos toda vez
3. **Trilhas de auditoria**: Registre todas as atividades de release
4. **Autoatendimento**: Habilite equipes a implantar com segurança

## Anti-Padrões Comuns

### Anti-Padrões de Processo
- **Implantações manuais**: Sujeitas a erros e inconsistentes
- **Mudanças de última hora**: Introdução de risco sem testes adequados
- **Pular testes**: Implantar sem validação
- **Comunicação ruim**: Stakeholders alheios às mudanças

### Anti-Padrões Técnicos
- **Releases monolíticos**: Releases grandes e infrequentes com alto risco
- **Implantações acopladas**: Serviços que devem ser implantados juntos
- **Sem plano de rollback**: Incapaz de se recuperar rapidamente de problemas
- **Deriva de ambiente**: Produção difere do staging

### Anti-Padrões Culturais
- **Cultura de culpa**: Medo de fazer mudanças ou relatar problemas
- **Cultura de herói**: Depender de indivíduos em vez de processo
- **Perfeccionismo**: Atrasar releases por melhorias menores
- **Aversão ao risco**: Evitar mudanças necessárias por medo

## Primeiros Passos

1. **Avaliação**: Avalie o processo de release atual e pontos de dor
2. **Configuração de ferramentas**: Configure scripts para o seu repositório
3. **Definição de processo**: Escolha o fluxo de trabalho adequado para a sua equipe
4. **Automação**: Implemente pipelines CI/CD e portões de qualidade
5. **Treinamento**: Eduque a equipe sobre novos processos e ferramentas
6. **Monitoramento**: Configure métricas e alertas para releases
7. **Iteração**: Melhore continuamente com base em feedback e métricas

A skill Release Manager transforma implantações caóticas em releases previsíveis e confiáveis que constroem confiança em toda a organização.
