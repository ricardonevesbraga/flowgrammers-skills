---
name: "quality-documentation-manager"
description: Gestão do sistema de controle de documentos para QMS de dispositivos médicos. Cobre numeração de documentos, controle de versão, gestão de mudanças e conformidade com 21 CFR Part 11. Use para procedimentos de controle de documentos, fluxo de trabalho de controle de mudanças, numeração de documentos, gestão de versões, conformidade de assinatura eletrônica ou revisão de documentação regulatória.
triggers:
  - document control
  - document numbering
  - version control
  - change control
  - document approval
  - electronic signature
  - 21 CFR Part 11
  - audit trail
  - document lifecycle
  - controlled document
  - document master list
  - record retention
---

# Quality Documentation Manager

Design e gestão do sistema de controle de documentos para sistemas de gestão da qualidade conformes à ISO 13485, incluindo convenções de numeração, fluxos de trabalho de aprovação, controle de mudanças e conformidade de registros eletrônicos.

---

## Sumário

- [Fluxo de Trabalho de Controle de Documentos](#fluxo-de-trabalho-de-controle-de-documentos)
- [Sistema de Numeração de Documentos](#sistema-de-numeração-de-documentos)
- [Processo de Aprovação e Revisão](#processo-de-aprovação-e-revisão)
- [Processo de Controle de Mudanças](#processo-de-controle-de-mudanças)
- [Conformidade com 21 CFR Part 11](#conformidade-com-21-cfr-part-11)
- [Documentação de Referência](#documentação-de-referência)
- [Ferramentas](#ferramentas)

---

## Fluxo de Trabalho de Controle de Documentos

Implementar controle de documentos desde a criação até a obsolescência:

1. Atribuir número de documento conforme o procedimento de numeração
2. Criar documento usando template controlado
3. Encaminhar para revisão aos revisores obrigatórios
4. Tratar comentários de revisão e documentar respostas
5. Obter assinaturas de aprovação obrigatórias
6. Atribuir data de vigência e distribuir
7. Atualizar a Lista Mestre de Documentos
8. **Validação:** Documento acessível no ponto de uso; versões obsoletas removidas

### Estágios do Ciclo de Vida do Documento

| Estágio | Definição | Ações Obrigatórias |
|-------|------------|------------------|
| Rascunho | Em criação ou revisão | Autor editando, não para uso |
| Revisão | Circulado para revisão | Revisores fornecem feedback |
| Aprovado | Todas as assinaturas obtidas | Pronto para treinamento/distribuição |
| Vigente | Treinamento completo, liberado | Disponível para uso |
| Substituído | Substituído por revisão mais recente | Remover do uso ativo |
| Obsoleto | Não mais aplicável | Arquivar conforme cronograma de retenção |

### Tipos de Documentos e Prefixos

| Prefixo | Tipo de Documento | Conteúdo Típico |
|--------|---------------|-----------------|
| QM | Manual da Qualidade | Visão geral do QMS, escopo, política |
| SOP | Procedimento Operacional Padrão | Procedimentos em nível de processo |
| WI | Instrução de Trabalho | Instruções passo a passo em nível de tarefa |
| TF | Template/Formulário | Formulários controlados |
| SPEC | Especificação | Especificações de produto/processo |
| PLN | Plano | Planos de qualidade/projeto |

### Revisores e Aprovadores Obrigatórios por Tipo de Documento

| Tipo de Documento | Revisores Obrigatórios | Aprovadores Obrigatórios |
|---------------|-------------------|-------------------|
| SOP | Dono do Processo, QA | Gerente de QA, Dono do Processo |
| WI | Supervisor da Área, QA | Gerente da Área |
| SPEC | Engenharia, QA | Gerente de Engenharia, QA |
| TF | Dono do Processo | QA |
| Documentos de Projeto | Equipe de Projeto, QA | Autoridade de Controle de Projeto |

---

## Sistema de Numeração de Documentos

Atribuir números de documento consistentes para identificação e recuperação.

### Formato de Numeração

Formato padrão: `PREFIXO-CATEGORIA-SEQUÊNCIA[-REVISÃO]`

```
Exemplo: SOP-02-001-A

SOP = Tipo de documento (Procedimento Operacional Padrão)
02  = Código de categoria (Controle de Documentos)
001 = Número sequencial
A   = Indicador de revisão
```

### Códigos de Categoria

| Código | Área Funcional | Descrição |
|------|-----------------|-------------|
| 01 | Gestão da Qualidade | Procedimentos do QMS, revisão gerencial |
| 02 | Controle de Documentos | Esta área |
| 03 | Recursos Humanos | Treinamento, competência |
| 04 | Projeto e Desenvolvimento | Processos de controle de projeto |
| 05 | Compras | Gestão de fornecedores |
| 06 | Produção | Procedimentos de fabricação |
| 07 | Controle da Qualidade | Inspeção, teste |
| 08 | CAPA | Ações corretivas/preventivas |
| 09 | Gestão de Riscos | Processos ISO 14971 |
| 10 | Assuntos Regulatórios | Submissões, conformidade |

### Fluxo de Trabalho de Numeração

1. Autor solicita número de documento ao Controle de Documentos
2. Controle de Documentos verifica a atribuição de categoria
3. Controle de Documentos atribui o próximo número sequencial disponível
4. Número registrado na Lista Mestre de Documentos
5. Autor cria documento usando o número atribuído
6. **Validação:** Formato do número corresponde ao padrão; sem duplicatas na Lista Mestre

### Designação de Revisão

| Tipo de Mudança | Incremento de Revisão | Exemplo |
|-------------|-------------------|---------|
| Revisão maior | Incrementar número | Rev 01 → Rev 02 |
| Revisão menor | Incrementar sub-revisão | Rev 01 → Rev 01.1 |
| Administrativa | Sem mudança ou sufixo de letra | Rev 01 → Rev 01a |

Veja `references/document-control-procedures.md` para orientação completa de numeração.

---

## Processo de Aprovação e Revisão

Obter revisões e aprovações obrigatórias antes da liberação do documento.

### Fluxo de Trabalho de Revisão

1. Autor completa o rascunho do documento
2. Autor submete para revisão via formulário de roteamento ou DMS
3. Revisores atribuídos com base no tipo de documento
4. Revisores fornecem comentários dentro do período de revisão (5-10 dias úteis)
5. Autor trata comentários e documenta respostas
6. Autor resubmete o documento revisado
7. Aprovadores assinam e datam
8. **Validação:** Todos os revisores obrigatórios completaram; todos os comentários tratados com disposição documentada

### Disposição de Comentários

| Disposição | Ação Obrigatória |
|-------------|-----------------|
| Aceitar | Incorporar comentário como escrito |
| Aceitar com modificação | Incorporar com mudanças, documentar justificativa |
| Rejeitar | Não incorporar, documentar justificativa |
| Adiar | Tratar em revisão futura, documentar motivo |

### Matriz de Aprovação

```
Nível 1 do Documento (Política/QM): CEO ou delegado + Gerente de QA
Nível 2 do Documento (SOP): Gerente de Departamento + Gerente de QA
Nível 3 do Documento (WI/TF): Supervisor da Área + Representante de QA
```

### Requisitos de Assinatura

| Elemento | Requisito |
|---------|-------------|
| Nome | Nome impresso do signatário |
| Assinatura | Assinatura manuscrita ou eletrônica |
| Data | Data de aplicação da assinatura |
| Função | Função/papel do signatário |

---

## Processo de Controle de Mudanças

Gerenciar mudanças de documento sistematicamente por meio de revisão e aprovação.

### Fluxo de Trabalho de Controle de Mudanças

1. Identificar necessidade de mudança no documento
2. Completar Formulário de Solicitação de Mudança com justificativa
3. Controle de Documentos atribui número de mudança e registra a solicitação
4. Encaminhar aos revisores para avaliação de impacto
5. Obter aprovações com base na classificação da mudança
6. Autor implementa as mudanças aprovadas
7. Atualizar número de revisão e histórico de mudanças
8. **Validação:** Mudanças correspondem ao escopo aprovado; histórico de mudanças completo

### Classificação de Mudanças

| Classe | Definição | Nível de Aprovação | Exemplos |
|-------|------------|----------------|----------|
| Administrativa | Sem impacto no conteúdo | Controle de Documentos | Erros de digitação, formatação |
| Menor | Mudança limitada de conteúdo | Dono do Processo + QA | Esclarecimentos |
| Maior | Mudança significativa de conteúdo | Ciclo completo de revisão | Novos requisitos |
| Emergencial | Urgente segurança/conformidade | Expedido + retrospectivo | Questões de segurança |

### Lista de Verificação de Avaliação de Impacto

| Área de Impacto | Perguntas de Avaliação |
|-------------|---------------------|
| Treinamento | A mudança requer retreinamento? |
| Equipamento | A mudança afeta equipamentos ou sistemas? |
| Validação | A mudança requer revalidação? |
| Regulatório | A mudança afeta registros regulatórios? |
| Outros Documentos | Quais documentos relacionados precisam de atualização? |
| Registros | Quais registros são afetados? |

### Documentação do Histórico de Mudanças

Cada documento deve incluir histórico de mudanças:

```
| Revisão | Data | Descrição | Autor | Aprovador |
|----------|------|-------------|--------|----------|
| 01 | 2023-01-15 | Emissão inicial | J. Smith | M. Jones |
| 02 | 2024-03-01 | Fluxo de trabalho atualizado | J. Smith | M. Jones |
```

---

## Conformidade com 21 CFR Part 11

Implementar controles de registros eletrônicos e assinaturas para conformidade FDA.

### Escopo da Part 11

| Aplica-se a | Não se aplica a |
|------------|-------------------|
| Registros exigidos por regulamentos FDA | Registros em papel |
| Registros submetidos à FDA | Documentos internos não regulados |
| Assinaturas eletrônicas em registros obrigatórios | Comunicação geral por e-mail |

### Controles de Registros Eletrônicos

1. Validar o sistema quanto a precisão e confiabilidade
2. Implementar trilha de auditoria segura para todas as mudanças
3. Restringir acesso ao sistema a pessoas autorizadas
4. Gerar cópias precisas em formato legível por humanos
5. Proteger registros durante todo o período de retenção
6. **Validação:** Trilha de auditoria captura quem, o quê e quando para todas as mudanças

### Requisitos de Trilha de Auditoria

| Requisito | Implementação |
|-------------|----------------|
| Segura | Não pode ser modificada por usuários |
| Gerada por computador | Sistema cria automaticamente |
| Com carimbo de data/hora | Data e hora de cada ação |
| Valores originais | Valores anteriores retidos |
| Identidade do usuário | Quem fez cada mudança |

### Requisitos de Assinatura Eletrônica

| Requisito | Implementação |
|-------------|----------------|
| Única para o indivíduo | Não compartilhada entre pessoas |
| Pelo menos 2 componentes | ID de usuário + senha, no mínimo |
| Manifestação da assinatura | Nome, data/hora, significado exibidos |
| Vinculada ao registro | Não pode ser excisada ou copiada |

### Manifestação da Assinatura

Cada assinatura eletrônica deve exibir:

| Elemento | Exemplo |
|---------|---------|
| Nome impresso | João da Silva |
| Data e hora | 2024-03-15 14:32:05 BRT |
| Significado | Aprovado para Liberação |

### Lista de Verificação de Controles do Sistema

**Controles de Acesso:**
- [ ] ID de usuário único para cada pessoa
- [ ] Complexidade de senha aplicada
- [ ] Bloqueio de conta após tentativas falhas
- [ ] Timeout de sessão após inatividade

**Trilha de Auditoria:**
- [ ] Toda criação de registro registrada em log
- [ ] Todas as modificações registradas com valores antigos/novos
- [ ] Identidade do usuário capturada
- [ ] Carimbo de data/hora em todas as entradas

**Segurança:**
- [ ] Controle de acesso baseado em função
- [ ] Criptografia de dados em repouso e em trânsito
- [ ] Backup regular e recuperação testada

Veja `references/21cfr11-compliance-guide.md` para requisitos detalhados de conformidade.

---

## Documentação de Referência

### Procedimentos de Controle de Documentos

`references/document-control-procedures.md` contém:

- Sistema e formato de numeração de documentos
- Estágios e transições do ciclo de vida do documento
- Detalhes do fluxo de trabalho de revisão e aprovação
- Processo de controle de mudanças com critérios de classificação
- Métodos de distribuição e controle de acesso
- Períodos de retenção de registros e procedimentos de descarte
- Requisitos da Lista Mestre de Documentos

### Guia de Conformidade com 21 CFR Part 11

`references/21cfr11-compliance-guide.md` contém:

- Escopo e aplicabilidade da Part 11
- Requisitos de registros eletrônicos (§11.10)
- Requisitos de assinatura eletrônica (§11.50, 11.100, 11.200)
- Especificações de controles do sistema
- Abordagem e documentação de validação
- Lista de verificação de conformidade e template de avaliação de lacunas
- Deficiências comuns FDA e prevenção

---

## Ferramentas

### Validador de Documentos

```bash
# Validar metadados do documento
python scripts/document_validator.py --doc document.json

# Modo de validação interativo
python scripts/document_validator.py --interactive

# Saída JSON para integração
python scripts/document_validator.py --doc document.json --output json

# Gerar JSON de documento de amostra
python scripts/document_validator.py --sample > sample_doc.json
```

Valida:
- Conformidade com a convenção de numeração do documento
- Requisitos de título e status
- Validação de datas (vigência, data de revisão)
- Requisitos de aprovação por tipo de documento
- Completude do histórico de mudanças
- Controles 21 CFR Part 11 (trilha de auditoria, assinaturas)

### Entrada de Documento de Amostra

```json
{
  "number": "SOP-02-001",
  "title": "Document Control Procedure",
  "doc_type": "SOP",
  "revision": "03",
  "status": "Effective",
  "effective_date": "2024-01-15",
  "review_date": "2025-01-15",
  "author": "J. Smith",
  "approver": "M. Jones",
  "change_history": [
    {"revision": "01", "date": "2022-01-01", "description": "Initial release"},
    {"revision": "02", "date": "2023-01-15", "description": "Updated workflow"},
    {"revision": "03", "date": "2024-01-15", "description": "Added e-signature requirements"}
  ],
  "has_audit_trail": true,
  "has_electronic_signature": true,
  "signature_components": 2
}
```

---

## Métricas de Controle de Documentos

Rastrear o desempenho do sistema de controle de documentos.

### Indicadores-Chave de Desempenho

| Métrica | Meta | Cálculo |
|--------|--------|-------------|
| Tempo de ciclo do documento | <30 dias | Média de dias do rascunho até vigência |
| Taxa de conclusão de revisão | >95% | Revisões concluídas no prazo / Total de revisões |
| Backlog de solicitações de mudança | <10 | Solicitações de mudança abertas ao final do mês |
| Taxa de revisão em atraso | <5% | Documentos além da data de revisão / Total vigentes |
| Taxa de achados de auditoria | <2 por auditoria | Achados de controle de documentos por auditoria interna |

### Cronograma de Revisão Periódica

| Tipo de Documento | Frequência de Revisão |
|---------------|------------------|
| Política | A cada 3 anos |
| SOP | A cada 2 anos |
| WI | A cada 2 anos |
| Especificações | Conforme necessário ou com mudanças no produto |
| Formulários/Templates | A cada 3 anos |

---

## Requisitos Regulatórios

### ISO 13485:2016 Cláusula 4.2

| Subcláusula | Requisito |
|------------|-------------|
| 4.2.1 | Documentação do sistema de gestão da qualidade |
| 4.2.2 | Manual da qualidade |
| 4.2.3 | Arquivo de dispositivo médico (documentação técnica) |
| 4.2.4 | Controle de documentos |
| 4.2.5 | Controle de registros |

### FDA 21 CFR 820

| Seção | Requisito |
|---------|-------------|
| 820.40 | Controles de documentos |
| 820.180 | Requisitos gerais de registros |
| 820.181 | Registro mestre do dispositivo |
| 820.184 | Registro histórico do dispositivo |
| 820.186 | Registro do sistema de qualidade |

### Achados Comuns de Auditoria

| Achado | Prevenção |
|---------|------------|
| Documentos obsoletos em uso | Implementar controle de distribuição |
| Assinaturas de aprovação ausentes | Enforçar fluxo de trabalho antes da liberação |
| Histórico de mudanças incompleto | Exigir atualização do histórico a cada revisão |
| Sem cronograma de revisão periódica | Estabelecer e enforçar calendário de revisão |
| Trilha de auditoria inadequada | Validar DMS para conformidade com Part 11 |
