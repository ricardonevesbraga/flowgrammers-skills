---
name: "quality-manager-qms-iso13485"
description: Implementação e manutenção de Sistema de Gestão da Qualidade ISO 13485 para organizações de dispositivos médicos. Fornece design do QMS, controle de documentação, auditoria interna, gestão de CAPA e suporte à certificação. Use ao trabalhar com sistemas de qualidade de dispositivos médicos, preparar para auditorias ISO 13485, gerenciar documentação de conformidade regulatória, configurar ações corretivas ou construir programas de preparação para auditoria — com foco no mercado brasileiro e ANVISA.
triggers:
  - ISO 13485
  - QMS implementation
  - quality management system
  - document control
  - internal audit
  - management review
  - quality manual
  - CAPA process
  - process validation
  - design control
  - supplier qualification
  - quality records
---

# Quality Manager - QMS ISO 13485 Specialist

Implementação, manutenção e suporte à certificação do Sistema de Gestão da Qualidade ISO 13485:2016 para organizações de dispositivos médicos.

---

## Sumário

- [Fluxo de Trabalho de Implementação do QMS](#fluxo-de-trabalho-de-implementação-do-qms)
- [Fluxo de Trabalho de Controle de Documentos](#fluxo-de-trabalho-de-controle-de-documentos)
- [Fluxo de Trabalho de Auditoria Interna](#fluxo-de-trabalho-de-auditoria-interna)
- [Fluxo de Trabalho de Validação de Processos](#fluxo-de-trabalho-de-validação-de-processos)
- [Fluxo de Trabalho de Qualificação de Fornecedores](#fluxo-de-trabalho-de-qualificação-de-fornecedores)
- [Referência de Processos do QMS](#referência-de-processos-do-qms)
- [Frameworks de Decisão](#frameworks-de-decisão)
- [Ferramentas e Referências](#ferramentas-e-referências)

---

## Fluxo de Trabalho de Implementação do QMS

Implementar sistema de gestão da qualidade conforme a ISO 13485:2016 desde a análise de lacunas até a certificação.

### Fluxo de Trabalho: Implementação Inicial do QMS

1. Conduzir análise de lacunas em relação aos requisitos da ISO 13485:2016
2. Documentar o estado atual versus o estado requerido para cada cláusula
3. Priorizar lacunas por:
   - Criticidade regulatória
   - Risco para a segurança do produto
   - Requisitos de recursos
4. Desenvolver roteiro de implementação com marcos
5. Estabelecer Manual da Qualidade conforme a Cláusula 4.2.2:
   - Escopo do QMS com exclusões justificadas
   - Interações entre processos
   - Referências a procedimentos
6. Criar procedimentos documentados obrigatórios — veja [Procedimentos Obrigatórios](#referência-rápida-procedimentos-documentados-obrigatórios) para a lista completa
7. Implantar processos com treinamento
8. **Validação:** Análise de lacunas completa; Manual da Qualidade aprovado; todos os procedimentos obrigatórios documentados e treinados

> Use o template de Matriz de Análise de Lacunas em [qms-process-templates.md](references/qms-process-templates.md) para documentar o estado atual, lacunas, prioridade e ações cláusula por cláusula.

### Estrutura do QMS

| Nível | Tipo de Documento | Exemplo |
|-------|---------------|---------|
| 1 | Manual da Qualidade | QM-001 |
| 2 | Procedimentos | SOP-02-001 |
| 3 | Instruções de Trabalho | WI-06-012 |
| 4 | Registros | Registros de treinamento |

---

## Fluxo de Trabalho de Controle de Documentos

Estabelecer e manter controle de documentos conforme a ISO 13485 Cláusula 4.2.3.

### Fluxo de Trabalho: Criação e Aprovação de Documentos

1. Identificar necessidade de novo documento ou revisão
2. Atribuir número de documento conforme a convenção de numeração:
   - Formato: `[TIPO]-[ÁREA]-[SEQUÊNCIA]-[REV]`
   - Exemplo: `SOP-02-001-01`
3. Rascunhar documento usando template aprovado
4. Encaminhar para revisão a especialistas no assunto
5. Coletar e tratar comentários de revisão
6. Obter aprovações obrigatórias com base no tipo de documento
7. Atualizar a Lista Mestre de Documentos
8. **Validação:** Documento numerado corretamente; todos os revisores assinaram; Lista Mestre atualizada

### Convenção de Numeração de Documentos

| Prefixo | Tipo de Documento | Autoridade de Aprovação |
|--------|---------------|-------------------|
| QM | Manual da Qualidade | Representante da Direção + CEO |
| POL | Política | Chefe de Departamento + QA |
| SOP | Procedimento | Dono do Processo + QA |
| WI | Instrução de Trabalho | Supervisor + QA |
| TF | Template/Formulário | Dono do Processo |
| SPEC | Especificação | Engenharia + QA |

### Códigos de Área

| Código | Área | Exemplos |
|------|------|----------|
| 01 | Gestão da Qualidade | Manual da Qualidade, política |
| 02 | Controle de Documentos | Este procedimento |
| 03 | Treinamento | Procedimentos de competência |
| 04 | Projeto | Controle de projeto |
| 05 | Compras | Gestão de fornecedores |
| 06 | Produção | Fabricação |
| 07 | Controle da Qualidade | Inspeção, teste |
| 08 | CAPA | Ações corretivas |

### Controle de Mudanças de Documentos

| Tipo de Mudança | Nível de Aprovação | Exemplos |
|-------------|----------------|----------|
| Administrativa | Controle de Documentos | Erros de digitação, formatação |
| Menor | Dono do Processo + QA | Esclarecimentos |
| Maior | Ciclo completo de revisão | Mudanças de processo |
| Emergencial | Expedido + retrospectivo | Questões de segurança |

### Cronograma de Revisão de Documentos

| Tipo de Documento | Período de Revisão | Gatilho para Revisão Não Programada |
|---------------|---------------|-------------------------------|
| Manual da Qualidade | Anual | Mudança organizacional |
| Procedimentos | Anual | Achado de auditoria, mudança regulatória |
| Instruções de Trabalho | 2 anos | Mudança de processo |
| Formulários | 2 anos | Feedback de usuários |

---

## Fluxo de Trabalho de Auditoria Interna

Planejar e executar auditorias internas conforme a ISO 13485 Cláusula 8.2.4.

### Fluxo de Trabalho: Programa Anual de Auditoria

1. Identificar processos e áreas que requerem cobertura de auditoria
2. Avaliar fatores de risco para frequência de auditoria:
   - Achados de auditorias anteriores
   - Mudanças regulatórias
   - Mudanças de processos
   - Tendências de reclamações
3. Atribuir auditores qualificados (independentes da área auditada)
4. Desenvolver cronograma anual de auditorias
5. Obter aprovação gerencial
6. Comunicar cronograma aos donos de processos
7. Rastrear conclusão e reagendar conforme necessário
8. **Validação:** Todos os processos cobertos; auditores qualificados e independentes; cronograma aprovado

> Use o Template de Programa de Auditoria em [qms-process-templates.md](references/qms-process-templates.md) para programar auditorias por cláusula e trimestre cobrindo processos como Controle de Documentos (4.2.3/4.2.4), Revisão Gerencial (5.6), Controle de Projeto (7.3), Produção (7.5) e CAPA (8.5.2/8.5.3).

### Fluxo de Trabalho: Execução de Auditoria Individual

1. Preparar plano de auditoria com escopo, critérios e cronograma
2. Notificar auditado com mínimo 1 semana de antecedência
3. Revisar procedimentos e resultados de auditorias anteriores
4. Preparar lista de verificação de auditoria
5. Conduzir reunião de abertura
6. Coletar evidências por meio de:
   - Revisão documental
   - Amostragem de registros
   - Observação de processos
   - Entrevistas com pessoal
7. Classificar achados:
   - NC Maior: Ausência ou colapso do sistema
   - NC Menor: Desvio ou desvio isolado único
   - Observação: Risco de futura NC
8. Conduzir reunião de encerramento
9. Emitir relatório de auditoria em até 5 dias úteis
10. **Validação:** Todos os itens da lista de verificação tratados; achados suportados por evidências; relatório distribuído

### Requisitos de Qualificação do Auditor

| Critério | Requisito |
|-----------|-------------|
| Treinamento | Conscientização ISO 13485 + treinamento de auditor |
| Experiência | Mínimo 1 auditoria como observador |
| Independência | Não auditando sua própria área de trabalho |
| Competência | Compreensão do processo auditado |

### Guia de Classificação de Achados

| Classificação | Critério | Tempo de Resposta |
|----------------|----------|---------------|
| NC Maior | Ausência do sistema, colapso total, violação regulatória | 30 dias para CAPA |
| NC Menor | Instância única, conformidade parcial | 60 dias para CAPA |
| Observação | Risco potencial, oportunidade de melhoria | Rastrear na próxima auditoria |

---

## Fluxo de Trabalho de Validação de Processos

Validar processos especiais conforme a ISO 13485 Cláusula 7.5.6.

### Fluxo de Trabalho: Protocolo de Validação de Processo

1. Identificar processos que requerem validação:
   - Saída não pode ser verificada por inspeção
   - Deficiências aparecem apenas em uso
   - Esterilização, soldagem, selagem, software
2. Formar equipe de validação com especialistas no assunto
3. Escrever protocolo de validação incluindo:
   - Descrição e parâmetros do processo
   - Equipamentos e materiais
   - Critérios de aceitação
   - Abordagem estatística
4. Executar IQ: verificar equipamento instalado corretamente e documentar especificações
5. Executar OQ: testar faixas de parâmetros e verificar o controle do processo
6. Executar PQ: executar condições de produção e verificar se a saída atende aos requisitos
7. Escrever relatório de validação com conclusões
8. **Validação:** IQ/OQ/PQ completo; critérios de aceitação atendidos; relatório de validação aprovado

### Requisitos de Documentação de Validação

| Fase | Conteúdo | Evidência |
|-------|---------|----------|
| Protocolo | Objetivos, métodos, critérios | Protocolo aprovado |
| IQ | Verificação de equipamento | Registros de instalação |
| OQ | Verificação de parâmetros | Resultados de teste |
| PQ | Verificação de desempenho | Dados de produção |
| Relatório | Resumo, conclusões | Assinaturas de aprovação |

### Gatilhos de Revalidação

| Gatilho | Ação Obrigatória |
|---------|-----------------|
| Mudança de equipamento | Avaliar impacto, revalidar fases afetadas |
| Mudança de parâmetro | OQ e PQ mínimo |
| Mudança de material | Avaliar impacto, PQ mínimo |
| Falha de processo | Revalidação completa |
| Periódico | Conforme cronograma de validação (tipicamente 3 anos) |

### Exemplos de Processos Especiais

| Processo | Norma de Validação | Parâmetros Críticos |
|---------|--------------------|--------------------|
| Esterilização EO | ISO 11135 | Temperatura, umidade, concentração de EO, tempo |
| Esterilização a Vapor | ISO 17665 | Temperatura, pressão, tempo |
| Esterilização por Radiação | ISO 11137 | Dose, uniformidade de dose |
| Selagem | Interna | Temperatura, pressão, tempo de permanência |
| Soldagem | ISO 11607 | Calor, pressão, velocidade |

---

## Fluxo de Trabalho de Qualificação de Fornecedores

Avaliar e aprovar fornecedores conforme a ISO 13485 Cláusula 7.4.

### Fluxo de Trabalho: Qualificação de Novo Fornecedor

1. Identificar categoria do fornecedor:
   - Categoria A: Crítico (afeta segurança/desempenho)
   - Categoria B: Maior (afeta qualidade)
   - Categoria C: Menor (impacto indireto)
2. Solicitar informações do fornecedor:
   - Certificações de qualidade
   - Especificações do produto
   - Histórico de qualidade
3. Avaliar o fornecedor com base em:
   - Sistema da qualidade (certificação ISO)
   - Capacidade técnica
   - Histórico de qualidade
   - Estabilidade financeira
4. Para fornecedores Categoria A:
   - Conduzir auditoria no local
   - Exigir acordo de qualidade
5. Calcular pontuação de qualificação
6. Tomar decisão de aprovação:
   - >80: Aprovado
   - 60-80: Aprovação condicional
   - <60: Não aprovado
7. Adicionar à Lista de Fornecedores Aprovados
8. **Validação:** Critérios de avaliação pontuados; registros de qualificação completos; fornecedor categorizado

### Critérios de Avaliação de Fornecedores

| Critério | Peso | Pontuação |
|-----------|--------|---------|
| Sistema da Qualidade | 30% | ISO 13485=30, ISO 9001=20, Documentado=10, Nenhum=0 |
| Histórico de Qualidade | 25% | Taxa de rejeição: <1%=25, 1-3%=15, >3%=0 |
| Entrega | 20% | No prazo: >95%=20, 90-95%=10, <90%=0 |
| Capacidade Técnica | 15% | Supera=15, Atende=10, Marginal=5 |
| Estabilidade Financeira | 10% | Forte=10, Adequada=5, Questionável=0 |

### Requisitos por Categoria de Fornecedor

| Categoria | Qualificação | Monitoramento | Acordo |
|----------|---------------|------------|-----------|
| A - Crítico | Auditoria no local | Revisão anual | Acordo de qualidade |
| B - Maior | Questionário | Revisão semestral | Requisitos de qualidade |
| C - Menor | Avaliação | Baseado em ocorrências | Termos padrão |

### Métricas de Desempenho de Fornecedores

| Métrica | Meta | Cálculo |
|--------|--------|-------------|
| Taxa de Aceitação | >98% | (Lotes aceitos / Total de lotes) × 100 |
| Entrega no Prazo | >95% | (No prazo / Total de pedidos) × 100 |
| Tempo de Resposta | <5 dias | Média de dias para resolver problemas |
| Documentação | 100% | (CoCs completos / CoCs obrigatórios) × 100 |

---

## Referência de Processos do QMS

Para requisitos detalhados e perguntas de auditoria para cada cláusula da ISO 13485:2016, veja [iso13485-clause-requirements.md](references/iso13485-clause-requirements.md).

### Entradas Obrigatórias para Revisão Gerencial (Cláusula 5.6.2)

| Entrada | Fonte | Preparado Por |
|-------|--------|-------------|
| Resultados de auditorias | Auditorias internas e externas | Gerente de QA |
| Feedback de clientes | Reclamações, pesquisas | Qualidade ao Cliente |
| Desempenho de processos | Métricas de processos | Donos de Processos |
| Conformidade do produto | Dados de inspeção, NCs | Gerente de QC |
| Status de CAPA | Sistema CAPA | CAPA Officer |
| Ações anteriores | Registros de revisão anterior | QMR |
| Mudanças que afetam o QMS | Regulatórias, organizacionais | Gerente de RA |
| Recomendações | Todas as fontes | Todos os Gerentes |

### Requisitos de Retenção de Registros

| Tipo de Registro | Retenção Mínima | Base Regulatória |
|-------------|-------------------|------------------|
| Registro Mestre do Dispositivo | Vida do dispositivo + 2 anos | 21 CFR 820.181 |
| Registro Histórico do Dispositivo | Vida do dispositivo + 2 anos | 21 CFR 820.184 |
| Arquivo de Histórico de Projeto | Vida do dispositivo + 2 anos | 21 CFR 820.30 |
| Registros de Reclamações | Vida do dispositivo + 2 anos | 21 CFR 820.198 |
| Registros de Treinamento | Emprego + 3 anos | Melhor prática |
| Registros de Auditoria | 7 anos | Melhor prática |
| Registros de CAPA | 7 anos | Melhor prática |
| Registros de Calibração | Vida do equipamento + 2 anos | Melhor prática |

---

## Frameworks de Decisão

### Justificativa de Exclusão (Cláusula 4.2.2)

| Cláusula | Exclusão Permitida | Justificativa Obrigatória |
|--------|----------------------|------------------------|
| 6.4.2 | Controle de contaminação | Produto não afetado por contaminação |
| 7.3 | Projeto e desenvolvimento | Organização não projeta produtos |
| 7.5.2 | Limpeza do produto | Sem requisitos de limpeza |
| 7.5.3 | Instalação | Sem atividades de instalação |
| 7.5.4 | Manutenção | Sem atividades de manutenção |
| 7.5.5 | Produtos estéreis | Sem produtos estéreis |

### Árvore de Decisão de Disposição de Não Conformidade

```
Produto Não Conforme Identificado
            │
            ▼
    Pode ser reprocessado?
            │
       Sim──┴──Não
        │       │
        ▼       ▼
    Procedimento de    Pode ser usado
    reprocessamento    como está?
    disponível?            │
        │             Sim──┴──Não
    Sim─┴─Não          │       │
     │    │            ▼       ▼
     ▼    ▼      Aprovação  Sucata ou
  Reproc. Criar    de con-   devolução
  conf. SOP proc.  cessão    ao fornecedor
          de re-   necessária?
          proc.        │
                   Sim─┴─Não
                    │    │
                    ▼    ▼
               Aprovação  Usar como
               do cliente  está com
                           aprovação
                           do MRB
```

### Critérios de Iniciação de CAPA

| Fonte | CAPA Automática | Avaliar para CAPA |
|--------|----------------|-------------------|
| Reclamação de cliente | Relacionada à segurança | Todas as outras |
| Auditoria externa | NC Maior | NC Menor |
| Auditoria interna | NC Maior | NC Menor repetida |
| NC de produto | Falha em campo | Tendência supera limiar |
| Desvio de processo | Impacto na segurança | Desvios repetidos |

---

## Ferramentas e Referências

### Scripts

| Ferramenta | Propósito | Uso |
|------|---------|-------|
| [qms_audit_checklist.py](scripts/qms_audit_checklist.py) | Gerar listas de verificação de auditoria por cláusula ou processo | `python qms_audit_checklist.py --help` |

**Funcionalidades do Gerador de Lista de Verificação de Auditoria:**
- Gerar listas de verificação específicas por cláusula (ex.: `--clause 7.3`)
- Gerar listas de verificação baseadas em processo (ex.: `--process design-control`)
- Lista de verificação de auditoria do sistema completo (`--audit-type system`)
- Saídas em formato texto ou JSON
- Modo interativo para seleção guiada

### Referências

| Documento | Conteúdo |
|----------|---------|
| [iso13485-clause-requirements.md](references/iso13485-clause-requirements.md) | Requisitos detalhados para cada cláusula da ISO 13485:2016 com perguntas de auditoria |
| [qms-process-templates.md](references/qms-process-templates.md) | Templates prontos para análise de lacunas, programa de auditoria, controle de documentos, CAPA, fornecedor, treinamento |

### Referência Rápida: Procedimentos Documentados Obrigatórios

| Procedimento | Cláusula | Elementos-Chave |
|-----------|--------|--------------|
| Controle de Documentos | 4.2.3 | Aprovação, distribuição, controle de obsoletos |
| Controle de Registros | 4.2.4 | Identificação, retenção, descarte |
| Auditoria Interna | 8.2.4 | Programa, qualificação do auditor, reporte |
| Controle de Produto NC | 8.3 | Identificação, segregação, disposição |
| Ação Corretiva | 8.5.2 | Causa raiz, implementação, verificação |
| Ação Preventiva | 8.5.3 | Identificação de risco, implementação |

---

## Skills Relacionadas

| Skill | Ponto de Integração |
|-------|-------------------|
| [quality-manager-qmr](../quality-manager-qmr/) | Revisão gerencial, política da qualidade |
| [capa-officer](../capa-officer/) | Gestão do sistema CAPA |
| [qms-audit-expert](../qms-audit-expert/) | Técnicas avançadas de auditoria |
| [quality-documentation-manager](../quality-documentation-manager/) | Gestão de DHF, DMR, DHR |
| [risk-management-specialist](../risk-management-specialist/) | Integração ISO 14971 |
