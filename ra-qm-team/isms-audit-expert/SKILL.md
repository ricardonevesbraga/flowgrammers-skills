---
name: "isms-audit-expert"
description: Especialista em auditoria de Sistema de Gestão de Segurança da Informação (ISMS) para verificação de conformidade ISO 27001, avaliação de controles de segurança e suporte à certificação. Use quando o usuário mencionar ISO 27001, auditoria ISMS, controles do Anexo A, Declaração de Aplicabilidade (SoA), análise de lacunas, gestão de não conformidades, auditoria interna, auditoria de vigilância ou preparação para certificação de segurança.
triggers:
  - ISMS audit
  - ISO 27001 audit
  - security audit
  - internal audit ISO 27001
  - security control assessment
  - certification audit
  - surveillance audit
  - audit finding
  - nonconformity
---

# ISMS Audit Expert

Gestão de auditorias internas e externas do ISMS para verificação de conformidade ISO 27001, avaliação de controles de segurança e suporte à certificação.

## Sumário

- [Gestão do Programa de Auditoria](#gestão-do-programa-de-auditoria)
- [Execução da Auditoria](#execução-da-auditoria)
- [Avaliação de Controles](#avaliação-de-controles)
- [Gestão de Achados](#gestão-de-achados)
- [Suporte à Certificação](#suporte-à-certificação)
- [Ferramentas](#ferramentas)
- [Referências](#referências)

---

## Gestão do Programa de Auditoria

### Cronograma de Auditoria Baseado em Risco

| Nível de Risco | Frequência de Auditoria | Exemplos |
|------------|-----------------|----------|
| Crítico | Trimestral | Acesso privilegiado, gestão de vulnerabilidades, registro de logs |
| Alto | Semestral | Controle de acesso, resposta a incidentes, criptografia |
| Médio | Anual | Políticas, treinamento de conscientização, segurança física |
| Baixo | Anual | Documentação, inventário de ativos |

### Fluxo de Trabalho de Planejamento Anual de Auditoria

1. Revisar achados anteriores e resultados de avaliação de riscos
2. Identificar controles de alto risco e incidentes de segurança recentes
3. Determinar escopo da auditoria com base nos limites do ISMS
4. Atribuir auditores garantindo independência das áreas auditadas
5. Criar cronograma de auditoria com alocação de recursos
6. Obter aprovação gerencial para o plano de auditoria
7. **Validação:** Plano de auditoria cobre todos os controles do Anexo A dentro do ciclo de certificação

### Requisitos de Competência do Auditor

- Certificação de Auditor Líder ISO 27001 (preferencial)
- Sem responsabilidade operacional pelos processos auditados
- Compreensão dos controles técnicos de segurança
- Conhecimento das regulamentações aplicáveis (LGPD, HIPAA)

---

## Execução da Auditoria

### Preparação Pré-Auditoria

1. Revisar a documentação do ISMS (políticas, SoA, avaliação de riscos)
2. Analisar relatórios de auditoria anteriores e achados abertos
3. Preparar plano de auditoria com cronograma de entrevistas
4. Notificar auditados sobre escopo e datas da auditoria
5. Preparar listas de verificação para os controles em escopo
6. **Validação:** Toda a documentação recebida e revisada antes da reunião de abertura

### Etapas de Condução da Auditoria

1. **Reunião de Abertura**
   - Confirmar escopo e objetivos da auditoria
   - Apresentar a equipe de auditoria e a metodologia
   - Acordar canais de comunicação e logística

2. **Coleta de Evidências**
   - Entrevistar donos e operadores de controles
   - Revisar documentação e registros
   - Observar processos em operação
   - Inspecionar configurações técnicas

3. **Verificação de Controles**
   - Testar o design do controle (ele trata o risco?)
   - Testar a operação do controle (está funcionando como pretendido?)
   - Amostrar transações e registros
   - Documentar todas as evidências coletadas

4. **Reunião de Encerramento**
   - Apresentar achados preliminares
   - Esclarecer quaisquer imprecisões factuais
   - Acordar classificação dos achados
   - Confirmar prazos de ação corretiva

5. **Validação:** Todos os controles em escopo avaliados com evidência documentada

---

## Avaliação de Controles

### Abordagem de Teste de Controles

1. Identificar o objetivo do controle na ISO 27002
2. Determinar o método de teste (consulta, observação, inspeção, re-execução)
3. Definir tamanho da amostra com base na população e no risco
4. Executar o teste e documentar os resultados
5. Avaliar a eficácia do controle
6. **Validação:** Evidência suporta a conclusão sobre o status do controle

Para procedimentos detalhados de verificação técnica por controle do Anexo A, veja [security-control-testing.md](references/security-control-testing.md).

---

## Gestão de Achados

### Classificação de Achados

| Severidade | Definição | Tempo de Resposta |
|----------|------------|---------------|
| Não Conformidade Maior | Falha de controle criando risco significativo | 30 dias |
| Não Conformidade Menor | Desvio isolado com impacto limitado | 90 dias |
| Observação | Oportunidade de melhoria | Próximo ciclo de auditoria |

### Template de Documentação de Achado

```
ID do Achado: ISMS-[ANO]-[NÚMERO]
Referência do Controle: A.X.X - [Nome do Controle]
Severidade: [Maior/Menor/Observação]

Evidência:
- [Evidência específica observada]
- [Registros revisados]
- [Declarações de entrevistas]

Impacto do Risco:
- [Consequências potenciais se não tratado]

Causa Raiz:
- [Por que a não conformidade ocorreu]

Recomendação:
- [Etapas específicas de ação corretiva]
```

### Fluxo de Trabalho de Ação Corretiva

1. Auditado reconhece o achado e a severidade
2. Análise de causa raiz concluída em até 10 dias
3. Plano de ação corretiva submetido com datas-alvo
4. Ações implementadas pelas partes responsáveis
5. Auditor verifica a eficácia das correções
6. Achado encerrado com evidência de resolução
7. **Validação:** Causa raiz tratada, recorrência prevenida

---

## Suporte à Certificação

### Preparação para Auditoria Estágio 1

Garantir que a documentação esteja completa:
- [ ] Declaração de escopo do ISMS
- [ ] Política de segurança da informação (assinada pela gestão)
- [ ] Declaração de Aplicabilidade
- [ ] Metodologia e resultados de avaliação de riscos
- [ ] Plano de tratamento de riscos
- [ ] Resultados de auditoria interna (últimos 12 meses)
- [ ] Atas de revisão gerencial

### Preparação para Auditoria Estágio 2

Verificar prontidão operacional:
- [ ] Todos os achados do Estágio 1 tratados
- [ ] ISMS operacional por no mínimo 3 meses
- [ ] Evidência de implementação de controles
- [ ] Registros de treinamento de conscientização de segurança
- [ ] Evidência de resposta a incidentes (se aplicável)
- [ ] Documentação de revisão de acesso

### Ciclo de Auditoria de Vigilância

| Período | Foco |
|--------|-------|
| Ano 1, T2 | Controles de alto risco, acompanhamento de achados do Estágio 2 |
| Ano 1, T4 | Melhoria contínua, amostra de controles |
| Ano 2, T2 | Vigilância completa |
| Ano 2, T4 | Preparação para recertificação |

**Validação:** Sem não conformidades maiores nas auditorias de vigilância.

---

## Ferramentas

### scripts/

| Script | Propósito | Uso |
|--------|---------|-------|
| `isms_audit_scheduler.py` | Gerar planos de auditoria baseados em risco | `python scripts/isms_audit_scheduler.py --year 2025 --format markdown` |

### Exemplo de Planejamento de Auditoria

```bash
# Gerar plano anual de auditoria
python scripts/isms_audit_scheduler.py --year 2025 --output audit_plan.json

# Com avaliações de risco de controles personalizadas
python scripts/isms_audit_scheduler.py --controls controls.csv --format markdown
```

---

## Referências

| Arquivo | Conteúdo |
|------|---------|
| [iso27001-audit-methodology.md](references/iso27001-audit-methodology.md) | Estrutura do programa de auditoria, fase pré-auditoria, suporte à certificação |
| [security-control-testing.md](references/security-control-testing.md) | Procedimentos de verificação técnica para controles ISO 27002 |
| [cloud-security-audit.md](references/cloud-security-audit.md) | Avaliação de provedor de nuvem, segurança de configuração, revisão de IAM |

---

## Métricas de Desempenho de Auditoria

| KPI | Meta | Medição |
|-----|--------|-------------|
| Conclusão do plano de auditoria | 100% | Auditorias concluídas vs. planejadas |
| Taxa de encerramento de achados | >90% dentro do SLA | Encerrados no prazo vs. total |
| Não conformidades maiores | 0 na certificação | Contagem por ciclo de certificação |
| Eficácia da auditoria | Incidentes prevenidos | Melhorias de segurança implementadas |
