---
name: "dependency-auditor"
description: "Auditor de Dependências — analisa, audita e gerencia dependências em projetos multi-linguagem, identificando vulnerabilidades, garantindo conformidade de licença, otimizando árvores de dependência e planejando atualizações seguras."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Dependency Auditor

> **Tipo de Skill:** PODEROSO  
> **Categoria:** Engenharia  
> **Domínio:** Gerenciamento de Dependências e Segurança  

## Visão Geral

O **Dependency Auditor** é um toolkit abrangente para analisar, auditar e gerenciar dependências em projetos de software multi-linguagem. Esta skill fornece visibilidade profunda no ecossistema de dependências do seu projeto, permitindo que as equipes identifiquem vulnerabilidades, garantam conformidade de licença, otimizem árvores de dependência e planejem atualizações seguras.

No desenvolvimento de software moderno, as dependências formam teias complexas que podem introduzir riscos significativos de segurança, legais e de manutenção. Um único projeto pode ter centenas de dependências diretas e transitivas, cada uma potencialmente introduzindo vulnerabilidades, conflitos de licença ou carga de manutenção. Esta skill aborda esses desafios por meio de análise automatizada e recomendações acionáveis.

## Capacidades Principais

### 1. Varredura de Vulnerabilidades e Correspondência de CVE

**Análise de Segurança Abrangente**
- Varre dependências contra bancos de dados de vulnerabilidades integrados
- Corresponde padrões de Common Vulnerabilities and Exposures (CVE)
- Identifica problemas de segurança conhecidos em múltiplos ecossistemas
- Analisa vulnerabilidades de dependências transitivas
- Fornece pontuações CVSS e avaliações de exploração
- Rastreia linhas do tempo de divulgação de vulnerabilidades
- Mapeia vulnerabilidades para caminhos de dependência

**Suporte Multi-Linguagem**
- **JavaScript/Node.js**: package.json, package-lock.json, yarn.lock
- **Python**: requirements.txt, pyproject.toml, Pipfile.lock, poetry.lock
- **Go**: go.mod, go.sum
- **Rust**: Cargo.toml, Cargo.lock
- **Ruby**: Gemfile, Gemfile.lock
- **Java/Maven**: pom.xml, gradle.lockfile
- **PHP**: composer.json, composer.lock
- **C#/.NET**: packages.config, project.assets.json

### 2. Conformidade de Licença e Avaliação de Risco Legal

**Sistema de Classificação de Licença**
- **Licenças Permissivas**: MIT, Apache 2.0, BSD (2-cláusulas, 3-cláusulas), ISC
- **Copyleft (Forte)**: GPL (v2, v3), AGPL (v3)
- **Copyleft (Fraco)**: LGPL (v2.1, v3), MPL (v2.0)
- **Proprietárias**: Licenças comerciais, personalizadas ou restritivas
- **Dupla Licença**: Cenários multi-licença e compatibilidade
- **Desconhecidas/Ambíguas**: Licenciamento ausente ou pouco claro

**Detecção de Conflito**
- Identifica combinações de licença incompatíveis
- Avisa sobre contaminação GPL em projetos permissivos
- Analisa herança de licença por cadeias de dependência
- Fornece recomendações de conformidade para distribuição
- Gera matrizes de risco legal para tomada de decisão

### 3. Detecção de Dependências Desatualizadas

**Análise de Versão**
- Identifica dependências com atualizações disponíveis
- Categoriza atualizações por gravidade (patch, minor, major)
- Detecta versões fixadas que podem estar desatualizadas
- Analisa padrões de versionamento semântico
- Identifica especificadores de versão flutuantes
- Rastreia frequências de release e status de manutenção

**Avaliação de Status de Manutenção**
- Identifica pacotes abandonados ou sem manutenção
- Analisa frequência de commits e atividade de contribuidores
- Rastreia datas do último release e disponibilidade de patches de segurança
- Identifica pacotes com datas de fim de vida conhecidas
- Avalia qualidade de manutenção upstream

### 4. Análise de Inchaço de Dependências

**Detecção de Dependências Não Utilizadas**
- Identifica dependências que não são realmente importadas/usadas
- Analisa declarações de importação e padrões de uso
- Detecta dependências redundantes com funcionalidade sobreposta
- Identifica pacotes superdimensionados para casos de uso simples
- Mapeia uso real vs. declarado de dependências

**Análise de Redundância**
- Identifica múltiplos pacotes fornecendo funcionalidade similar
- Detecta conflitos de versão em dependências transitivas
- Analisa impacto do tamanho do bundle de dependências
- Identifica oportunidades de consolidação de dependências
- Mapeia sobreposição e duplicação de dependências

### 5. Planejamento de Caminho de Atualização e Risco de Mudança que Quebra Compatibilidade

**Análise de Versionamento Semântico**
- Analisa padrões semver para prever mudanças que quebram compatibilidade
- Identifica caminhos de atualização seguros (versões patch/minor)
- Sinaliza atualizações de versão major que requerem atenção
- Rastreia mudanças que quebram compatibilidade entre atualizações de dependências
- Fornece estratégias de rollback para atualizações com falha

**Matriz de Avaliação de Risco**
- Baixo Risco: Atualizações patch, correções de segurança
- Médio Risco: Atualizações minor com novas funcionalidades
- Alto Risco: Atualizações de versão major, mudanças de API
- Risco Crítico: Dependências com mudanças que quebram compatibilidade conhecidas

**Priorização de Atualização**
- Patches de segurança: Prioridade mais alta
- Correções de bug: Alta prioridade
- Atualizações de funcionalidade: Prioridade média
- Grandes refatorações: Prioridade planejada
- Funcionalidades depreciadas: Atenção imediata

### 6. Segurança da Cadeia de Suprimentos

**Proveniência de Dependências**
- Verifica assinaturas e checksums de pacotes
- Analisa fontes de download de pacotes e espelhos
- Identifica pacotes suspeitos ou comprometidos
- Rastreia mudanças de propriedade de pacotes e shifts de mantenedor
- Detecta typosquatting e pacotes maliciosos

**Análise de Risco Transitivo**
- Mapeia árvores de dependência completas
- Identifica dependências transitivas de alto risco
- Analisa profundidade e complexidade de dependências
- Rastreia influência de dependências indiretas
- Fornece pontuação de risco da cadeia de suprimentos

### 7. Análise de Lockfile e Builds Determinísticos

**Validação de Lockfile**
- Garante que lockfiles estejam atualizados com manifestos
- Valida hashes de integridade e consistência de versão
- Identifica drift entre ambientes
- Analisa conflitos de lockfile e estratégias de resolução
- Garante builds determinísticos e reproduzíveis

**Consistência de Ambiente**
- Compara dependências entre ambientes (dev/staging/prod)
- Identifica incompatibilidades de versão entre membros da equipe
- Valida consistência de ambiente CI/CD
- Rastreia diferenças de resolução de dependências

## Arquitetura Técnica

### Motor de Varredura (`dep_scanner.py`)
- Parser multi-formato suportando 8+ ecossistemas de pacote
- Banco de dados de vulnerabilidades integrado com 500+ padrões CVE
- Resolução de dependências transitivas a partir de lockfiles
- Formatos de saída JSON e legível por humanos
- Profundidade de varredura configurável e padrões de exclusão

### Analisador de Licença (`license_checker.py`)
- Detecção de licença a partir de metadados e arquivos de pacote
- Matriz de compatibilidade com 20+ tipos de licença
- Motor de detecção de conflito com sugestões de remediação
- Pontuação de risco com base em contexto de distribuição e uso
- Capacidades de exportação para revisão legal

### Planejador de Atualização (`upgrade_planner.py`)
- Análise de versão semântica com previsão de mudança que quebra compatibilidade
- Ordenação de dependências com base em risco e interdependência
- Listas de verificação de migração com recomendações de teste
- Procedimentos de rollback para atualizações com falha
- Estimativa de prazo para ciclos de atualização

## Casos de Uso e Aplicações

### Equipes de Segurança
- **Gerenciamento de Vulnerabilidades**: Varredura contínua para problemas de segurança
- **Resposta a Incidentes**: Avaliação rápida de dependências vulneráveis
- **Monitoramento da Cadeia de Suprimentos**: Rastreamento da postura de segurança de terceiros
- **Relatórios de Conformidade**: Documentação automatizada de conformidade de segurança

### Equipes Jurídicas e de Conformidade
- **Auditoria de Licença**: Verificação abrangente de conformidade de licença
- **Avaliação de Risco**: Análise de risco legal para distribuição de software
- **Due Diligence**: Licenciamento de dependências para atividades de M&A
- **Aplicação de Política**: Conformidade automatizada de política de licença

### Equipes de Desenvolvimento
- **Higiene de Dependências**: Limpeza regular de dependências não utilizadas
- **Planejamento de Atualização**: Agendamento estratégico de atualização de dependências
- **Otimização de Performance**: Otimização do tamanho do bundle por meio de análise de dependências
- **Dívida Técnica**: Identificação e priorização de dívida técnica de dependências

### Equipes de DevOps e Plataforma
- **Otimização de Build**: Builds mais rápidos por meio de otimização de dependências
- **Automação de Segurança**: Varredura automatizada de vulnerabilidades em CI/CD
- **Consistência de Ambiente**: Garantia de dependências consistentes entre ambientes
- **Gerenciamento de Release**: Planejamento de release com consciência de dependências

## Padrões de Integração

### Integração de Pipeline CI/CD
```bash
# Gate de segurança em CI
python dep_scanner.py /project --format json --fail-on-high
python license_checker.py /project --policy strict --format json
```

### Auditoria Agendada
```bash
# Auditoria de dependências semanal
./audit_dependencies.sh > weekly_report.html
python upgrade_planner.py deps.json --timeline 30days
```

### Workflow de Desenvolvimento
```bash
# Verificação de dependência pré-commit
python dep_scanner.py . --quick-scan
python license_checker.py . --warn-conflicts
```

## Funcionalidades Avançadas

### Bancos de Dados de Vulnerabilidades Personalizados
- Suporte para feeds de vulnerabilidade internos/proprietários
- Definições de padrão CVE personalizadas
- Pontuação de risco específica da organização
- Integração com ferramentas de segurança enterprise

### Varredura Baseada em Política
- Políticas de licença configuráveis por tipo de projeto
- Limites de risco personalizados e regras de escalada
- Aplicação automatizada de política e notificações
- Gerenciamento de exceções para violações aprovadas

### Relatórios e Dashboards
- Resumos executivos para gerência
- Relatórios técnicos para equipes de desenvolvimento
- Análise de tendência e métricas de saúde de dependências
- Integração com ferramentas de gerenciamento de projeto

### Análise Multi-Projeto
- Análise de dependências em nível de portfólio
- Análise de impacto de dependências compartilhadas
- Conformidade de licença em toda a organização
- Propagação de vulnerabilidade entre projetos

## Melhores Práticas

### Frequência de Varredura
- **Varreduras de Segurança**: Diariamente ou a cada commit
- **Auditorias de Licença**: Semanal ou mensal
- **Planejamento de Atualização**: Mensal ou trimestral
- **Auditoria Completa de Dependências**: Trimestral

### Gerenciamento de Risco
1. **Priorize Segurança**: Aborde CVEs altos/críticos imediatamente
2. **Licença Primeiro**: Garanta conformidade antes da funcionalidade
3. **Atualizações Graduais**: Atualizações incrementais de dependências
4. **Teste Completamente**: Testes abrangentes após atualizações
5. **Monitore Continuamente**: Monitoramento automatizado e alertas

### Workflows da Equipe
1. **Campeões de Segurança**: Designe proprietários de segurança de dependências
2. **Processo de Revisão**: Revisão obrigatória para novas dependências
3. **Ciclos de Atualização**: Atualizações regulares e agendadas de dependências
4. **Documentação**: Mantenha a justificativa e decisões de dependências
5. **Treinamento**: Educação regular da equipe sobre segurança de dependências

## Métricas e KPIs

### Métricas de Segurança
- Tempo Médio para Patch (MTTP) de vulnerabilidades
- Número de vulnerabilidades altas/críticas
- Percentual de dependências com vulnerabilidades conhecidas
- Taxa de acumulação de dívida de segurança

### Métricas de Conformidade
- Percentual de conformidade de licença
- Número de conflitos de licença
- Tempo para resolver problemas de conformidade
- Frequência de violação de política

### Métricas de Manutenção
- Percentual de dependências atualizadas
- Idade média de dependências
- Número de dependências abandonadas
- Taxa de sucesso de atualização

### Métricas de Eficiência
- Percentual de redução do tamanho do bundle
- Taxa de eliminação de dependências não utilizadas
- Melhoria do tempo de build
- Impacto na produtividade do desenvolvedor

## Guia de Solução de Problemas

### Problemas Comuns
1. **Falsos Positivos**: Ajustar a sensibilidade de detecção de vulnerabilidades
2. **Ambiguidade de Licença**: Resolver licenças pouco claras ou múltiplas
3. **Mudanças que Quebram Compatibilidade**: Gerenciar atualizações de versão major
4. **Impacto de Performance**: Otimizar a varredura para grandes bases de código

### Estratégias de Resolução
- Whitelist de falsos positivos com documentação
- Contato com mantenedores para esclarecimento de licença
- Implementar feature flags para atualizações arriscadas
- Usar varredura incremental para projetos grandes

## Aprimoramentos Futuros

### Funcionalidades Planejadas
- Machine learning para previsão de vulnerabilidades
- Pull requests automatizados de atualização de dependências
- Integração com varredura de imagem de container
- Painéis de monitoramento de dependências em tempo real
- Definição de política em linguagem natural

### Expansão de Ecossistema
- Suporte adicional de linguagem (Swift, Kotlin, Dart)
- Dependências de container e infraestrutura
- Dependências de ferramentas de desenvolvimento e sistema de build
- Rastreamento de dependências de serviços cloud e SaaS

---

## Início Rápido

```bash
# Varrer projeto para vulnerabilidades e licenças
python scripts/dep_scanner.py /path/to/project

# Verificar conformidade de licença
python scripts/license_checker.py /path/to/project --policy strict

# Planejar atualizações de dependências
python scripts/upgrade_planner.py deps.json --risk-threshold medium
```

Para instruções detalhadas de uso, veja [README.md](README.md).

---

*Esta skill fornece capacidades abrangentes de gerenciamento de dependências essenciais para manter projetos de software seguros, conformes e eficientes. O uso regular ajuda as equipes a se anteciparem às ameaças de segurança, manter conformidade legal e otimizar seus ecossistemas de dependências.*
