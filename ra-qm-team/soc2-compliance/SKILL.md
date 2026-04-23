---
name: "soc2-compliance"
description: "Use quando o usuário pedir para preparar auditorias SOC 2, mapear Critérios de Serviço de Confiança, construir matrizes de controles, coletar evidências de auditoria, realizar análise de lacunas ou avaliar a prontidão para SOC 2 Tipo I versus Tipo II."
---

# SOC 2 Compliance

Preparação para conformidade SOC 2 Tipo I e Tipo II para empresas SaaS. Cobre mapeamento dos Critérios de Serviço de Confiança, geração de matriz de controles, coleta de evidências, análise de lacunas e avaliação de prontidão para auditoria.

## Sumário

- [Visão Geral](#visão-geral)
- [Critérios de Serviço de Confiança](#critérios-de-serviço-de-confiança)
- [Geração de Matriz de Controles](#geração-de-matriz-de-controles)
- [Fluxo de Trabalho de Análise de Lacunas](#fluxo-de-trabalho-de-análise-de-lacunas)
- [Coleta de Evidências](#coleta-de-evidências)
- [Lista de Verificação de Prontidão para Auditoria](#lista-de-verificação-de-prontidão-para-auditoria)
- [Gestão de Fornecedores](#gestão-de-fornecedores)
- [Conformidade Contínua](#conformidade-contínua)
- [Anti-Padrões](#anti-padrões)
- [Ferramentas](#ferramentas)
- [Referências](#referências)
- [Referências Cruzadas](#referências-cruzadas)

---

## Visão Geral

### O que é SOC 2?

SOC 2 (System and Organization Controls 2) é um framework de auditoria desenvolvido pelo AICPA que avalia como uma organização de serviços gerencia os dados de clientes. Aplica-se a qualquer empresa de tecnologia que armazena, processa ou transmite informações de clientes — principalmente SaaS, infraestrutura em nuvem e provedores de serviços gerenciados.

### Tipo I vs Tipo II

| Aspecto | Tipo I | Tipo II |
|--------|--------|---------|
| **Escopo** | Design dos controles em um ponto no tempo | Design E eficácia operacional ao longo de um período |
| **Duração** | Snapshot (data única) | Janela de observação (3-12 meses, tipicamente 6) |
| **Evidência** | Descrições de controles, políticas | Descrições de controles + evidências operacionais (logs, tickets, capturas de tela) |
| **Custo** | $20K-$50K (honorários de auditoria) | $30K-$100K+ (honorários de auditoria) |
| **Prazo** | 1-2 meses (fase de auditoria) | 6-12 meses (observação + auditoria) |
| **Melhor Para** | Primeira conformidade, necessidade rápida de mercado | Organizações maduras, clientes enterprise |

### Quem Precisa de SOC 2?

- **Empresas SaaS** vendendo para clientes enterprise
- **Provedores de infraestrutura em nuvem** gerenciando cargas de trabalho de clientes
- **Processadores de dados** gerenciando PII, PHI ou dados financeiros
- **Provedores de serviços gerenciados** com acesso a sistemas de clientes
- **Qualquer fornecedor** cujos clientes exijam asseguração de terceiros

### Jornada Típica

```
Avaliação de Lacunas → Remediação → Auditoria Tipo I → Período de Observação → Auditoria Tipo II → Renovação Anual
    (4-8 sem)          (8-16 sem)     (4-6 sem)          (6-12 meses)            (4-6 sem)          (contínuo)
```

---

## Critérios de Serviço de Confiança

O SOC 2 é organizado em torno de cinco categorias de Critérios de Serviço de Confiança (TSC). **Segurança** é obrigatória para todo relatório SOC 2; as outras quatro são opcionais e selecionadas com base na necessidade do negócio.

### Segurança (Critérios Comuns CC1-CC9) — Obrigatório

A base de todo relatório SOC 2. Mapeia para os princípios COSO 2013.

| Critério | Domínio | Controles-Chave |
|----------|--------|-------------|
| **CC1** | Ambiente de Controle | Integridade/ética, supervisão do conselho, estrutura org., competência, accountability |
| **CC2** | Comunicação e Informação | Comunicação interna/externa, qualidade da informação |
| **CC3** | Avaliação de Riscos | Identificação de riscos, risco de fraude, análise de impacto de mudanças |
| **CC4** | Atividades de Monitoramento | Monitoramento contínuo, avaliação de deficiências, ações corretivas |
| **CC5** | Atividades de Controle | Políticas/procedimentos, controles tecnológicos, implantação por políticas |
| **CC6** | Acesso Lógico e Físico | Provisionamento de acesso, autenticação, criptografia, restrições físicas |
| **CC7** | Operações do Sistema | Gestão de vulnerabilidades, detecção de anomalias, resposta a incidentes |
| **CC8** | Gestão de Mudanças | Autorização de mudanças, teste, aprovação, mudanças emergenciais |
| **CC9** | Mitigação de Riscos | Gestão de riscos de fornecedores/parceiros de negócios |

### Disponibilidade (A1) — Opcional

| Critério | Foco | Controles-Chave |
|----------|-------|-------------|
| **A1.1** | Gestão de capacidade | Escalamento de infraestrutura, monitoramento de recursos, planejamento de capacidade |
| **A1.2** | Operações de recuperação | Procedimentos de backup, recuperação de desastres, teste de BCP |
| **A1.3** | Teste de recuperação | Simulações de DR, teste de failover, validação de RTO/RPO |

**Selecionar quando:** Clientes dependem da sua disponibilidade; você tem SLAs; indisponibilidade causa impacto direto no negócio.

### Confidencialidade (C1) — Opcional

| Critério | Foco | Controles-Chave |
|----------|-------|-------------|
| **C1.1** | Identificação | Política de classificação de dados, inventário de dados confidenciais |
| **C1.2** | Proteção | Criptografia em repouso e em trânsito, DLP, restrições de acesso |
| **C1.3** | Descarte | Procedimentos de exclusão segura, sanitização de mídia, aplicação de retenção |

**Selecionar quando:** Você trata segredos comerciais, dados proprietários ou informações contratualmente confidenciais.

### Integridade do Processamento (PI1) — Opcional

| Critério | Foco | Controles-Chave |
|----------|-------|-------------|
| **PI1.1** | Precisão | Validação de entrada, verificações de processamento, verificação de saída |
| **PI1.2** | Completude | Monitoramento de transações, reconciliação, tratamento de erros |
| **PI1.3** | Pontualidade | Monitoramento de SLA, alertas de atraso de processamento, monitoramento de jobs em lote |
| **PI1.4** | Autorização | Controles de autorização de processamento, segregação de funções |

**Selecionar quando:** A precisão dos dados é crítica (processamento financeiro, registros de saúde, plataformas de analytics).

### Privacidade (P1-P8) — Opcional

| Critério | Foco | Controles-Chave |
|----------|-------|-------------|
| **P1** | Aviso | Política de privacidade, aviso de coleta de dados, limitação de propósito |
| **P2** | Escolha e Consentimento | Opt-in/opt-out, gestão de consentimento, rastreamento de preferências |
| **P3** | Coleta | Coleta mínima, base legal, especificação de propósito |
| **P4** | Uso, Retenção, Descarte | Limitação de propósito, cronogramas de retenção, descarte seguro |
| **P5** | Acesso | Solicitações de acesso de titulares, direitos de correção |
| **P6** | Divulgação e Notificação | Compartilhamento com terceiros, notificação de violações |
| **P7** | Qualidade | Verificação de precisão dos dados, mecanismos de correção |
| **P8** | Monitoramento e Aplicação | Monitoramento do programa de privacidade, tratamento de reclamações |

**Selecionar quando:** Você processa PII e os clientes esperam garantia de privacidade (complementa a conformidade LGPD/GDPR).

---

## Geração de Matriz de Controles

Uma matriz de controles mapeia cada critério TSC para controles específicos, responsáveis, evidências e procedimentos de teste.

### Estrutura da Matriz

| Campo | Descrição |
|-------|-------------|
| **ID do Controle** | Identificador único (ex.: SEC-001, AVL-003) |
| **Mapeamento TSC** | Quais critérios o controle trata (ex.: CC6.1, A1.2) |
| **Descrição do Controle** | O que o controle faz |
| **Tipo de Controle** | Preventivo, Detectivo ou Corretivo |
| **Responsável** | Pessoa/equipe responsável |
| **Frequência** | Contínua, Diária, Semanal, Mensal, Trimestral, Anual |
| **Tipo de Evidência** | Captura de tela, Log, Política, Configuração, Ticket |
| **Procedimento de Teste** | Como o auditor verifica o controle |

### Convenção de Nomenclatura de Controles

```
{CATEGORIA}-{NÚMERO}
SEC-001 até SEC-NNN  → Segurança
AVL-001 até AVL-NNN  → Disponibilidade
CON-001 até CON-NNN  → Confidencialidade
PRI-001 até PRI-NNN  → Integridade do Processamento
PRV-001 até PRV-NNN  → Privacidade
```

### Fluxo de Trabalho

1. Selecionar categorias TSC aplicáveis com base nas necessidades do negócio
2. Executar `control_matrix_builder.py` para gerar a matriz de linha de base
3. Customizar controles para corresponder ao ambiente real
4. Atribuir responsáveis e requisitos de evidência
5. Validar cobertura — cada critério TSC selecionado deve ter pelo menos um controle

---

## Fluxo de Trabalho de Análise de Lacunas

### Fase 1: Avaliação do Estado Atual

1. **Documentar controles existentes** — inventariar todas as políticas de segurança, procedimentos e controles técnicos
2. **Mapear para TSC** — alinhar controles existentes com os Critérios de Serviço de Confiança
3. **Coletar amostras de evidências** — reunir provas de que os controles existem e operam
4. **Entrevistar donos de controles** — verificar compreensão e execução

### Fase 2: Identificação de Lacunas

Executar `gap_analyzer.py` em relação aos controles atuais para identificar:

- **Controles ausentes** — critérios TSC sem controle correspondente
- **Parcialmente implementados** — controle existe, mas falta evidência ou consistência
- **Lacunas de design** — controle projetado, mas não trata adequadamente o critério
- **Lacunas operacionais** (apenas Tipo II) — controle projetado corretamente, mas não operando efetivamente

### Fase 3: Planejamento de Remediação

Para cada lacuna, definir:

| Campo | Descrição |
|-------|-------------|
| ID da Lacuna | Identificador de referência |
| Critério TSC | Critérios afetados |
| Descrição da Lacuna | O que está faltando ou é insuficiente |
| Ação de Remediação | Etapas específicas para fechar a lacuna |
| Responsável | Pessoa responsável pela remediação |
| Prioridade | Crítica / Alta / Média / Baixa |
| Data Alvo | Prazo de conclusão |
| Dependências | Outras lacunas ou projetos que devem ser concluídos primeiro |

### Fase 4: Planejamento de Cronograma

| Prioridade | Remediação Alvo |
|----------|--------------------|
| Crítica | 2-4 semanas |
| Alta | 4-8 semanas |
| Média | 8-12 semanas |
| Baixa | 12-16 semanas |

---

## Coleta de Evidências

### Tipos de Evidências por Categoria de Controle

| Área de Controle | Evidência Primária | Evidência Secundária |
|--------------|-----------------|-------------------|
| Gestão de Acesso | Revisões de acesso de usuários, tickets de provisionamento | Matriz de funções, logs de acesso |
| Gestão de Mudanças | Tickets de mudança, registros de aprovação | Logs de implantação, resultados de testes |
| Resposta a Incidentes | Tickets de incidentes, postmortems | Runbooks, registros de escalonamento |
| Gestão de Vulnerabilidades | Relatórios de varredura, registros de patches | Cronogramas de remediação |
| Criptografia | Capturas de tela de configuração, inventário de certificados | Logs de rotação de chaves |
| Backup e Recuperação | Logs de backup, resultados de testes de DR | Medições de tempo de recuperação |
| Monitoramento | Configurações de alertas, capturas de tela de painéis | Agendas de plantão, registros de escalonamento |
| Gestão de Políticas | Políticas assinadas, histórico de versões | Registros de conclusão de treinamento |
| Gestão de Fornecedores | Avaliações de fornecedores, relatórios SOC 2 | Revisões de contratos, registros de risco |

### Oportunidades de Automação

| Área | Abordagem de Automação |
|------|-------------------|
| Revisões de acesso | Integrar IAM com ticketing (gatilhos automáticos de revisão trimestral) |
| Evidências de configuração | Snapshots de infraestrutura-como-código, ferramentas de compliance-as-code |
| Varreduras de vulnerabilidades | Varredura programada com relatórios gerados automaticamente |
| Gestão de mudanças | Trilha de auditoria baseada em Git (commits, PRs, aprovações) |
| Monitoramento de uptime | Painéis de SLA automatizados com dados históricos |
| Verificação de backup | Testes de restauração automatizados com registro de sucesso/falha |

### Monitoramento Contínuo

Migrar da coleta de evidências pontual para conformidade contínua:

1. **Coleta automatizada de evidências** — scripts que coletam evidências em horários programados
2. **Painéis de controles** — visibilidade em tempo real do status dos controles
3. **Monitoramento baseado em alertas** — notificar quando um controle sair de conformidade
4. **Repositório de evidências** — armazenamento centralizado, com carimbo de data/hora

---

## Lista de Verificação de Prontidão para Auditoria

### Preparação Pré-Auditoria (4-6 Semanas Antes)

- [ ] Todos os controles documentados com descrições, responsáveis e frequências
- [ ] Evidências coletadas para todo o período de observação (Tipo II)
- [ ] Matriz de controles revisada e lacunas remediadas
- [ ] Políticas assinadas e distribuídas nos últimos 12 meses
- [ ] Revisões de acesso concluídas dentro da frequência obrigatória
- [ ] Varreduras de vulnerabilidades atuais (nenhuma crítica/alta sem patch > SLA)
- [ ] Plano de resposta a incidentes testado nos últimos 12 meses
- [ ] Avaliações de risco de fornecedores atuais para todas as suborganizações de serviço
- [ ] DR/BCP testado e documentado nos últimos 12 meses
- [ ] Treinamento de segurança de funcionários concluído para todo o pessoal

### Pontuação de Prontidão

| Pontuação | Classificação | Significado |
|-------|--------|---------|
| 90-100% | Pronto para Auditoria | Prosseguir com confiança |
| 75-89% | Lacunas Menores | Tratar antes de agendar a auditoria |
| 50-74% | Lacunas Significativas | Remediação obrigatória |
| < 50% | Não Pronto | Construção maior do programa necessária |

### Achados Comuns de Auditoria

| Achado | Causa Raiz | Prevenção |
|---------|-----------|-----------|
| Revisões de acesso incompletas | Processo manual, sem lembretes | Automatizar gatilhos de revisão trimestral |
| Aprovações de mudanças ausentes | Mudanças emergenciais contornam o processo | Definir procedimento de mudança emergencial com aprovação posterior |
| Varreduras de vulnerabilidades desatualizadas | Scanner mal configurado | Varreduras semanais automatizadas com alertas |
| Política não reconhecida | Sem mecanismo de rastreamento | Fluxo de trabalho anual de assinatura eletrônica |
| Avaliações de fornecedores ausentes | Sem inventário de fornecedores | Manter registro de fornecedores com cronograma de revisão |

---

## Gestão de Fornecedores

### Avaliação de Riscos de Terceiros

Todo fornecedor que acessa, armazena ou processa dados de clientes deve ser avaliado:

1. **Inventário de fornecedores** — manter um registro de todos os provedores de serviços
2. **Classificação de risco** — categorizar fornecedores pelo nível de acesso a dados
3. **Due diligence** — coletar relatórios SOC 2, questionários de segurança, certificações
4. **Proteções contratuais** — garantir DPAs, requisitos de segurança, cláusulas de notificação de violação
5. **Monitoramento contínuo** — reavaliação anual, monitoramento contínuo de notícias

### Níveis de Risco de Fornecedores

| Nível | Acesso a Dados | Frequência de Avaliação | Requisitos |
|------|-------------|---------------------|-------------|
| Crítico | Processa/armazena dados de clientes | Anual + monitoramento contínuo | SOC 2 Tipo II, teste de penetração, revisão de segurança |
| Alto | Acessa ambiente do cliente | Anual | SOC 2 Tipo II ou equivalente, questionário |
| Médio | Acesso indireto, ferramentas de suporte | Questionário anual | Certificações de segurança, questionário |
| Baixo | Sem acesso a dados | Questionário bienal | Questionário básico de segurança |

### Suborganizações de Serviço

Quando o seu relatório SOC 2 depende de controles em uma suborganização de serviço (ex.: AWS, GCP, Azure):

- **Método inclusivo** — seu relatório cobre os controles da suborganização (requer cooperação deles)
- **Método de carve-out** — seu relatório exclui os controles deles, mas referencia o relatório SOC 2 deles
- A maioria das empresas usa **carve-out** e inclui controles complementares de entidade usuária (CUECs)

---

## Conformidade Contínua

### De Pontual para Contínua

| Aspecto | Pontual | Contínua |
|--------|---------------|-----------|
| Coleta de evidências | Manual, antes da auditoria | Automatizada, contínua |
| Monitoramento de controles | Revisão periódica | Painéis em tempo real |
| Detecção de desvio | Encontrado durante a auditoria | Baseado em alertas, imediato |
| Remediação | Reativa | Proativa |
| Preparação para auditoria | Corrida de 4-8 semanas | Sempre pronto |

### Etapas de Implementação

1. **Automatizar coleta de evidências** — cron jobs, integrações de API, snapshots de IaC
2. **Construir painéis de controles** — agregar status de controles em uma visão única
3. **Configurar alertas de desvio** — notificar quando controles saírem de conformidade
4. **Estabelecer cadência de revisão** — check-ins semanais de donos de controles, direcionamento mensal
5. **Manter repositório de evidências** — centralizado, com carimbo de data/hora, acessível ao auditor

### Ciclo de Reavaliação Anual

| Trimestre | Atividades |
|---------|-----------|
| T1 | Avaliação anual de riscos, atualização de políticas, lançamento de reavaliação de fornecedores |
| T2 | Teste interno de controles, remediação de achados |
| T3 | Revisão de prontidão pré-auditoria, verificação de completude de evidências |
| T4 | Auditoria externa, asserção de gestão, distribuição de relatório |

---

## Anti-Padrões

| Anti-Padrão | Por que Falha | Abordagem Melhor |
|--------------|-------------|----------------|
| Conformidade pontual | Controles se degradam entre auditorias; lacunas encontradas durante a auditoria | Implementar monitoramento contínuo e evidências automatizadas |
| Coleta manual de evidências | Demorada, inconsistente, propensa a erros | Automatizar com scripts, IaC e plataformas de compliance |
| Avaliações de fornecedores ausentes | Auditores sinalizam due diligence de fornecedores incompleta | Manter registro de fornecedores com cronograma de avaliação por risco |
| Políticas copiadas | Políticas genéricas não correspondem às operações reais | Adaptar políticas ao ambiente e stack tecnológico reais |
| Segurança de teatro | Controles existem no papel, mas não são seguidos | Verificar eficácia operacional; incorporar controles nos fluxos de trabalho |
| Pular Tipo I | Pular para Tipo II sem prontidão de base | Começar com Tipo I para validar o design dos controles antes da observação |
| Excesso de escopo TSC | Incluir todas as 5 categorias quando apenas Segurança é necessária | Selecionar categorias com base nos requisitos reais de clientes/negócio |
| Tratar auditoria como projeto | Conformidade se degrada após o relatório ser emitido | Incorporar conformidade nas operações diárias e na cultura de engenharia |

---

## Ferramentas

### Construtor de Matriz de Controles

Gera uma matriz de controles SOC 2 a partir das categorias TSC selecionadas.

```bash
# Gerar matriz de segurança completa em markdown
python scripts/control_matrix_builder.py --categories security --format md

# Gerar matriz para múltiplas categorias como JSON
python scripts/control_matrix_builder.py --categories security,availability,confidentiality --format json

# Todas as categorias, saída CSV
python scripts/control_matrix_builder.py --categories security,availability,confidentiality,processing-integrity,privacy --format csv
```

### Rastreador de Evidências

Rastreia o status de coleta de evidências por controle.

```bash
# Verificar status de evidências de uma matriz de controles
python scripts/evidence_tracker.py --matrix controls.json --status

# Saída JSON para integração
python scripts/evidence_tracker.py --matrix controls.json --status --json
```

### Analisador de Lacunas

Analisa os controles atuais em relação aos requisitos SOC 2 e identifica lacunas.

```bash
# Análise de lacunas Tipo I
python scripts/gap_analyzer.py --controls current_controls.json --type type1

# Análise de lacunas Tipo II (inclui eficácia operacional)
python scripts/gap_analyzer.py --controls current_controls.json --type type2 --json
```

---

## Referências

- [Referência de Critérios de Serviço de Confiança](references/trust_service_criteria.md) — Todas as 5 categorias TSC com sub-critérios, objetivos de controle e exemplos de evidências
- [Guia de Coleta de Evidências](references/evidence_collection_guide.md) — Tipos de evidências por controle, ferramentas de automação, requisitos de documentação
- [Comparação Tipo I vs Tipo II](references/type1_vs_type2.md) — Comparação detalhada, cronograma, análise de custos e caminho de atualização

---

## Referências Cruzadas

- **[gdpr-dsgvo-expert](../gdpr-dsgvo-expert/SKILL.md)** — Os critérios de Privacidade SOC 2 se sobrepõem significativamente com os requisitos LGPD/GDPR; usar juntos ao processar dados pessoais de residentes no Brasil ou na UE
- **[information-security-manager-iso27001](../information-security-manager-iso27001/SKILL.md)** — Os controles do Anexo A da ISO 27001 mapeiam diretamente para os critérios de Segurança SOC 2; organizações que buscam ambos podem compartilhar evidências
- **[isms-audit-expert](../isms-audit-expert/SKILL.md)** — A metodologia de auditoria e os padrões de gestão de achados transferem diretamente para a preparação de auditoria SOC 2
