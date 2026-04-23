---
name: "qms-audit-expert"
description: Especialista em auditoria interna ISO 13485 para QMS de dispositivos médicos. Cobre planejamento de auditoria, execução, classificação de não conformidades e verificação de CAPA. Use para planejamento de auditoria interna, execução de auditoria, classificação de achados, preparação para auditoria externa ou gestão do programa de auditoria.
triggers:
  - ISO 13485 audit
  - internal audit
  - QMS audit
  - audit planning
  - nonconformity classification
  - CAPA verification
  - audit checklist
  - audit finding
  - external audit prep
  - audit schedule
---

# QMS Audit Expert

Metodologia de auditoria interna ISO 13485 para sistemas de gestão da qualidade de dispositivos médicos.

---

## Sumário

- [Fluxo de Trabalho de Planejamento de Auditoria](#fluxo-de-trabalho-de-planejamento-de-auditoria)
- [Execução da Auditoria](#execução-da-auditoria)
- [Gestão de Não Conformidades](#gestão-de-não-conformidades)
- [Preparação para Auditoria Externa](#preparação-para-auditoria-externa)
- [Documentação de Referência](#documentação-de-referência)
- [Ferramentas](#ferramentas)

---

## Fluxo de Trabalho de Planejamento de Auditoria

Planejar programa de auditoria interna baseado em risco:

1. Listar todos os processos do QMS que requerem auditoria
2. Atribuir nível de risco a cada processo (Alto/Médio/Baixo)
3. Revisar achados e tendências de auditorias anteriores
4. Determinar frequência de auditoria por nível de risco
5. Atribuir auditores qualificados (verificar independência)
6. Criar cronograma anual de auditorias
7. Comunicar cronograma aos donos de processos
8. **Validação:** Todas as cláusulas da ISO 13485 cobertas dentro do ciclo

### Frequência de Auditoria Baseada em Risco

| Nível de Risco | Frequência | Critério |
|------------|-----------|----------|
| Alto | Trimestral | Controle de projeto, CAPA, validação de produção |
| Médio | Semestral | Compras, treinamento, controle de documentos |
| Baixo | Anual | Infraestrutura, revisão gerencial (se estável) |

### Escopo de Auditoria por Cláusula

| Cláusula | Processo | Áreas de Foco |
|--------|---------|-------------|
| 4.2 | Controle de Documentos | Aprovação, distribuição, controle de documentos obsoletos |
| 5.6 | Revisão Gerencial | Entradas completas, decisões documentadas, ações rastreadas |
| 6.2 | Treinamento | Competência definida, registros completos, eficácia verificada |
| 7.3 | Controle de Projeto | Entradas, revisões, V&V, transferência, mudanças |
| 7.4 | Compras | Avaliação de fornecedores, inspeção de recebimento |
| 7.5 | Produção | Instruções de trabalho, validação de processo, DHR |
| 7.6 | Calibração | Lista de equipamentos, status de calibração, fora de tolerância |
| 8.2.2 | Auditoria Interna | Conformidade com cronograma, independência do auditor |
| 8.3 | Produto NC | Identificação, segregação, disposição |
| 8.5 | CAPA | Causa raiz, implementação, eficácia |

### Independência do Auditor

Verificar a independência do auditor antes da atribuição:

- [ ] Auditor não responsável pela área sendo auditada
- [ ] Sem relação hierárquica direta com o auditado
- [ ] Não envolvido em atividades recentes sob auditoria
- [ ] Qualificação documentada para o escopo de auditoria

---

## Execução da Auditoria

Conduzir auditoria interna sistemática:

1. Preparar plano de auditoria (escopo, critérios, cronograma)
2. Revisar documentação relevante antes da auditoria
3. Conduzir reunião de abertura com o auditado
4. Coletar evidências (registros, entrevistas, observação)
5. Classificar achados (Maior/Menor/Observação)
6. Conduzir reunião de encerramento com achados preliminares
7. Preparar relatório de auditoria em até 5 dias úteis
8. **Validação:** Todos os itens de escopo cobertos, achados suportados por evidências

### Coleta de Evidências

| Método | Usar Para | Documentação |
|--------|---------|---------------|
| Revisão documental | Procedimentos, registros | Número, versão e data do documento |
| Entrevista | Compreensão do processo | Nome do entrevistado, função, resumo |
| Observação | Prática real | O quê, onde, quando observado |
| Rastreamento de registro | Fluxo do processo | IDs de registro, datas, ligação |

### Perguntas de Auditoria por Cláusula

**Controle de Documentos (4.2):**
- Mostre-me a lista mestre de documentos
- Como vocês controlam documentos obsoletos?
- Mostre-me evidência de aprovação de mudança de documento

**Controle de Projeto (7.3):**
- Mostre-me o Arquivo de Histórico de Projeto para [produto]
- Quem participa das revisões de projeto?
- Mostre-me a rastreabilidade de entrada para saída de projeto

**CAPA (8.5):**
- Mostre-me o registro de CAPA com itens abertos
- Como vocês determinam a causa raiz?
- Mostre-me registros de verificação de eficácia

Veja `references/iso13485-audit-guide.md` para conjuntos completos de perguntas.

### Documentação de Achados

Documentar cada achado com:

```
Requisito: [Cláusula específica da ISO 13485 ou procedimento]
Evidência: [O que foi observado, revisado ou ouvido]
Lacuna: [Como a evidência não atende ao requisito]
```

**Exemplo:**
```
Requisito: ISO 13485:2016 Cláusula 7.6 requer calibração
em intervalos especificados.

Evidência: Registros de calibração do pH-metro (EQ-042) mostram
última calibração em 2024-01-15. Intervalo de calibração é
12 meses. Hoje é 2025-03-20.

Lacuna: O equipamento está com 2 meses de atraso na calibração,
representando uma lacuna na execução do programa de calibração.
```

---

## Gestão de Não Conformidades

Classificar e gerenciar achados de auditoria:

1. Avaliar o achado em relação aos critérios de classificação
2. Atribuir severidade (Maior/Menor/Observação)
3. Documentar o achado com evidência objetiva
4. Comunicar ao dono do processo
5. Iniciar CAPA para achados Maiores/Menores
6. Rastrear até o encerramento
7. Verificar eficácia no acompanhamento
8. **Validação:** Achado encerrado apenas após CAPA eficaz

### Critérios de Classificação

| Categoria | Definição | CAPA Obrigatório | Prazo |
|----------|------------|---------------|----------|
| Maior | Falha sistêmica ou ausência de elemento | Sim | 30 dias |
| Menor | Desvio isolado ou implementação parcial | Recomendado | 60 dias |
| Observação | Oportunidade de melhoria | Opcional | Conforme adequado |

### Decisão de Classificação

```
O elemento obrigatório está ausente ou falhou?
├── Sim → Sistêmico (múltiplas instâncias)? → MAIOR
│   └── Não → Poderia afetar a segurança do produto? → MAIOR
│       └── Não → MENOR
└── Não → Desvio do procedimento?
    ├── Sim → Recorrente? → MAIOR
    │   └── Não → MENOR
    └── Não → Oportunidade de melhoria? → OBSERVAÇÃO
```

### Integração com CAPA

| Severidade do Achado | Profundidade de CAPA | Verificação |
|------------------|------------|--------------|
| Maior | Análise completa de causa raiz (5 Porquês, Ishikawa) | Próxima auditoria ou em até 6 meses |
| Menor | Identificação de causa imediata | Próxima auditoria programada |
| Observação | Não obrigatório | Anotado na próxima auditoria |

Veja `references/nonconformity-classification.md` para orientação detalhada.

---

## Preparação para Auditoria Externa

Preparar para auditoria do organismo de certificação ou regulatória:

1. Concluir todas as auditorias internas programadas
2. Verificar todos os achados encerrados com CAPA eficaz
3. Revisar documentação quanto a atualidade e precisão
4. Conduzir revisão gerencial com auditoria como entrada
5. Preparar instalações e pessoal
6. Conduzir auditoria simulada (escopo completo)
7. Orientar pessoal sobre o protocolo de auditoria
8. **Validação:** Achados da auditoria simulada tratados antes da auditoria externa

### Lista de Verificação de Prontidão Pré-Auditoria

**Documentação:**
- [ ] Manual da Qualidade atualizado
- [ ] Procedimentos refletem a prática real
- [ ] Registros completos e recuperáveis
- [ ] Achados de auditorias anteriores encerrados

**Pessoal:**
- [ ] Pessoal-chave disponível durante a auditoria
- [ ] Especialistas no assunto identificados
- [ ] Pessoal orientado sobre o protocolo de auditoria
- [ ] Acompanhantes atribuídos

**Instalações:**
- [ ] Áreas de trabalho organizadas
- [ ] Documentos no ponto de uso atualizados
- [ ] Status de calibração de equipamentos visível
- [ ] Produto não conforme segregado

### Protocolo de Auditoria Simulada

1. Usar auditor externo ou auditor interno qualificado
2. Cobrir o escopo completo da auditoria externa próxima
3. Simular condições reais de auditoria (tempo, formalidade)
4. Documentar achados como para auditoria real
5. Tratar todos os achados Maiores e Menores antes da auditoria externa
6. Orientar a gestão sobre o status de prontidão

---

## Documentação de Referência

### Guia de Auditoria ISO 13485

`references/iso13485-audit-guide.md` contém:

- Metodologia de auditoria cláusula por cláusula
- Perguntas de auditoria de amostra para cada cláusula
- Requisitos de coleta de evidências
- Não conformidades comuns por cláusula
- Classificação de severidade de achados

### Classificação de Não Conformidades

`references/nonconformity-classification.md` contém:

- Critérios de classificação de severidade e árvore de decisão
- Matriz de impacto versus ocorrência
- Requisitos de integração com CAPA
- Templates de documentação de achados
- Requisitos de encerramento por severidade

---

## Ferramentas

### Otimizador de Cronograma de Auditoria

```bash
# Gerar cronograma de auditoria otimizado
python scripts/audit_schedule_optimizer.py --processes processes.json

# Modo interativo
python scripts/audit_schedule_optimizer.py --interactive

# Saída JSON para integração
python scripts/audit_schedule_optimizer.py --processes processes.json --output json
```

Gera cronograma de auditoria baseado em risco considerando:
- Nível de risco do processo
- Achados anteriores
- Dias desde a última auditoria
- Pontuações de criticidade

**A saída inclui:**
- Cronograma de auditoria priorizado
- Distribuição trimestral
- Alertas de auditoria em atraso
- Recomendações de recursos

### Entrada de Processo de Amostra

```json
{
  "processes": [
    {
      "name": "Design Control",
      "iso_clause": "7.3",
      "risk_level": "HIGH",
      "last_audit_date": "2024-06-15",
      "previous_findings": 2
    },
    {
      "name": "Document Control",
      "iso_clause": "4.2",
      "risk_level": "MEDIUM",
      "last_audit_date": "2024-09-01",
      "previous_findings": 0
    }
  ]
}
```

---

## Métricas do Programa de Auditoria

Rastrear a eficácia do programa de auditoria:

| Métrica | Meta | Medição |
|--------|--------|-------------|
| Conformidade com cronograma | >90% | Auditorias concluídas no prazo |
| Taxa de encerramento de achados | >95% | Achados encerrados até a data prevista |
| Achados repetidos | <10% | Mesmo achado em auditorias consecutivas |
| Eficácia de CAPA | >90% | Verificada como eficaz no acompanhamento |
| Utilização do auditor | 4 dias/mês | Dias de auditoria por auditor qualificado |
