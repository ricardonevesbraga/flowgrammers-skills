---
name: "capa-officer"
description: Gestão do sistema CAPA para QMS de dispositivos médicos. Cobre análise de causa raiz, planejamento de ações corretivas, verificação de eficácia e métricas de CAPA. Use para investigações CAPA, análise dos 5 Porquês, diagramas de Ishikawa, determinação de causa raiz, rastreamento de ações corretivas, verificação de eficácia ou otimização do programa de CAPA.
triggers:
  - CAPA investigation
  - root cause analysis
  - 5 Why analysis
  - fishbone diagram
  - corrective action
  - preventive action
  - effectiveness verification
  - CAPA metrics
  - nonconformance investigation
  - quality issue investigation
  - CAPA tracking
  - audit finding CAPA
---

# CAPA Officer

Gestão de Ações Corretivas e Preventivas (CAPA) dentro dos Sistemas de Gestão da Qualidade, com foco em análise sistemática de causa raiz, implementação de ações e verificação de eficácia.

---

## Sumário

- [Fluxo de Trabalho da Investigação CAPA](#fluxo-de-trabalho-da-investigação-capa)
- [Análise de Causa Raiz](#análise-de-causa-raiz)
- [Planejamento de Ações Corretivas](#planejamento-de-ações-corretivas)
- [Verificação de Eficácia](#verificação-de-eficácia)
- [Métricas e Relatórios CAPA](#métricas-e-relatórios-capa)
- [Documentação de Referência](#documentação-de-referência)
- [Ferramentas](#ferramentas)

---

## Fluxo de Trabalho da Investigação CAPA

Conduzir investigação CAPA sistemática desde a abertura até o encerramento:

1. Documentar o evento gatilho com evidência objetiva
2. Avaliar a significância e determinar a necessidade de CAPA
3. Formar equipe de investigação com expertise relevante
4. Coletar dados e evidências sistematicamente
5. Selecionar e aplicar a metodologia de ARC adequada
6. Identificar causa(s) raiz com evidência de suporte
7. Desenvolver ações corretivas e preventivas
8. **Validação:** A causa raiz explica todos os sintomas; se eliminada, o problema não recorreria

### Determinação da Necessidade de CAPA

| Tipo de Gatilho | CAPA Obrigatório | Critério |
|--------------|---------------|----------|
| Reclamação de cliente (segurança) | Sim | Qualquer reclamação envolvendo segurança do paciente/usuário |
| Reclamação de cliente (qualidade) | Avaliar | Com base em severidade e frequência |
| Achado de auditoria interna (Maior) | Sim | Falha sistêmica ou ausência de elemento |
| Achado de auditoria interna (Menor) | Recomendado | Desvio isolado ou implementação parcial |
| Não conformidade (recorrente) | Sim | Mesmo tipo de NC ocorrendo 3+ vezes |
| Não conformidade (isolada) | Avaliar | Com base em severidade e risco |
| Achado de auditoria externa | Sim | Todos os achados Maiores e Menores |
| Análise de tendência | Avaliar | Com base na significância da tendência |

### Composição da Equipe de Investigação

| Severidade da CAPA | Membros Obrigatórios da Equipe |
|---------------|----------------------|
| Crítica | CAPA Officer, Dono do Processo, Gerente de QA, Especialista no Assunto, Representante da Gestão |
| Maior | CAPA Officer, Dono do Processo, Especialista no Assunto |
| Menor | CAPA Officer, Dono do Processo |

### Lista de Verificação de Coleta de Evidências

- [ ] Descrição do problema com detalhes específicos (o quê, onde, quando, quem, quanto)
- [ ] Linha do tempo dos eventos que levaram ao problema
- [ ] Registros e documentação relevantes
- [ ] Notas de entrevistas com o pessoal envolvido
- [ ] Fotos ou evidências físicas (se aplicável)
- [ ] Reclamações, NCs ou CAPAs anteriores relacionados
- [ ] Parâmetros e especificações do processo

---

## Análise de Causa Raiz

Selecionar e aplicar a metodologia de ARC adequada com base nas características do problema.

### Árvore de Decisão para Seleção do Método de ARC

```
O problema é crítico para a segurança ou envolve confiabilidade do sistema?
├── Sim → Use ANÁLISE DA ÁRVORE DE FALHAS
└── Não → O erro humano é a causa primária suspeita?
    ├── Sim → Use ANÁLISE DE FATORES HUMANOS
    └── Não → Quantos fatores contribuintes potenciais existem?
        ├── 1-2 fatores (causalidade linear) → Use ANÁLISE DOS 5 PORQUÊS
        ├── 3-6 fatores (complexo, sistêmico) → Use DIAGRAMA DE ISHIKAWA
        └── Desconhecido/avaliação proativa → Use FMEA
```

### Análise dos 5 Porquês

Use quando: Problemas de causa única com causalidade linear, desvios de processo com ponto de falha claro.

**Template:**

```
PROBLEMA: [Declaração clara e específica]

POR QUÊ 1: Por que [problema] ocorreu?
PORQUE: [Causa de primeiro nível]
EVIDÊNCIA: [Dados de suporte]

POR QUÊ 2: Por que [causa de primeiro nível] ocorreu?
PORQUE: [Causa de segundo nível]
EVIDÊNCIA: [Dados de suporte]

POR QUÊ 3: Por que [causa de segundo nível] ocorreu?
PORQUE: [Causa de terceiro nível]
EVIDÊNCIA: [Dados de suporte]

POR QUÊ 4: Por que [causa de terceiro nível] ocorreu?
PORQUE: [Causa de quarto nível]
EVIDÊNCIA: [Dados de suporte]

POR QUÊ 5: Por que [causa de quarto nível] ocorreu?
PORQUE: [Causa raiz]
EVIDÊNCIA: [Dados de suporte]
```

**Exemplo — Calibração em Atraso:**

```
PROBLEMA: pH-metro (EQ-042) encontrado com 2 meses de atraso na calibração

POR QUÊ 1: Por que a calibração estava em atraso?
PORQUE: O equipamento não estava no cronograma de calibração
EVIDÊNCIA: Cronograma revisado, EQ-042 não listado

POR QUÊ 2: Por que não estava no cronograma?
PORQUE: O cronograma não foi atualizado quando o equipamento foi adquirido
EVIDÊNCIA: Data de compra 2023-06-15, cronograma datado de 2023-01-01

POR QUÊ 3: Por que o cronograma não foi atualizado?
PORQUE: Nenhum processo exige atualização do cronograma na compra de equipamento
EVIDÊNCIA: SOP-EQ-001 revisado, sem tal requisito

POR QUÊ 4: Por que não existe tal requisito?
PORQUE: Procedimento escrito antes da centralização do rastreamento de equipamentos
EVIDÊNCIA: SOP com última revisão em 2019, sistema de equipamentos implantado em 2021

POR QUÊ 5: Por que o procedimento não foi atualizado?
PORQUE: A revisão periódica não avaliou a compatibilidade com os novos sistemas
EVIDÊNCIA: Nenhuma revisão em relação ao novo sistema de equipamentos documentada

CAUSA RAIZ: O processo de revisão de procedimentos não avalia a compatibilidade
com sistemas organizacionais implementados após a criação do procedimento original.
```

### Categorias do Diagrama de Ishikawa (6M)

| Categoria | Áreas de Foco | Causas Típicas |
|----------|-------------|----------------|
| Mão de Obra (Pessoas) | Treinamento, competência, carga de trabalho | Lacunas de habilidades, fadiga, comunicação |
| Máquina (Equipamento) | Calibração, manutenção, idade | Desgaste, mau funcionamento, capacidade inadequada |
| Método (Processo) | Procedimentos, instruções de trabalho | Etapas pouco claras, controles ausentes |
| Material | Especificações, fornecedores, armazenamento | Fora de especificação, degradação, contaminação |
| Medição | Calibração, métodos, interpretação | Erro de instrumento, método errado |
| Meio Ambiente | Temperatura, umidade, limpeza | Excursões ambientais |

Veja `references/rca-methodologies.md` para detalhes completos dos métodos e templates.

### Validação da Causa Raiz

Antes de prosseguir para o planejamento de ações, valide a causa raiz:

- [ ] A causa raiz pode ser verificada com evidência objetiva
- [ ] Se a causa raiz for eliminada, o problema não recorreria
- [ ] A causa raiz está dentro do controle organizacional
- [ ] A causa raiz explica todos os sintomas observados
- [ ] Nenhuma outra causa significativa permanece sem ser tratada

---

## Planejamento de Ações Corretivas

Desenvolver ações eficazes que tratam as causas raiz identificadas:

1. Definir ações de contenção imediata
2. Desenvolver ações corretivas visando a causa raiz
3. Identificar ações preventivas para processos similares
4. Atribuir responsabilidades e recursos
5. Estabelecer cronograma com marcos
6. Definir critérios de sucesso e método de verificação
7. Documentar no plano de ação CAPA
8. **Validação:** As ações tratam diretamente a causa raiz; os critérios de sucesso são mensuráveis

### Tipos de Ação

| Tipo | Propósito | Prazo | Exemplo |
|------|---------|----------|---------|
| Contenção | Interromper o impacto imediato | 24-72 horas | Quarentenar produto afetado |
| Correção | Corrigir a ocorrência específica | 1-2 semanas | Reprocessar ou substituir itens afetados |
| Corretiva | Eliminar a causa raiz | 30-90 dias | Revisar procedimento, adicionar controles |
| Preventiva | Prevenir em outras áreas | 60-120 dias | Estender a solução para processos similares |

### Componentes do Plano de Ação

```
TEMPLATE DO PLANO DE AÇÃO

Número da CAPA: [CAPA-XXXX]
Causa Raiz: [Causa raiz identificada]

AÇÃO 1: [Descrição específica da ação]
- Tipo: [ ] Contenção [ ] Correção [ ] Corretiva [ ] Preventiva
- Responsável: [Nome, Cargo]
- Data Alvo: [AAAA-MM-DD]
- Recursos: [Recursos necessários]
- Critério de Sucesso: [Resultado mensurável]
- Método de Verificação: [Como o sucesso será verificado]

AÇÃO 2: [Descrição específica da ação]
...

CRONOGRAMA DE IMPLEMENTAÇÃO:
Semana 1: [Marco]
Semana 2: [Marco]
Semana 4: [Marco]
Semana 8: [Marco]

APROVAÇÃO:
Dono da CAPA: _____________ Data: _______
Dono do Processo: _____________ Data: _______
Gerente de QA: _____________ Data: _______
```

### Indicadores de Eficácia das Ações

| Indicador | Meta | Sinal de Alerta |
|-----------|--------|----------|
| Escopo da ação | Trata completamente a causa raiz | Trata apenas os sintomas |
| Especificidade | Entregáveis mensuráveis | Compromissos vagos |
| Prazo | Agressivo mas atingível | Sem datas ou irrealista |
| Recursos | Identificados e alocados | Não especificados |
| Sustentabilidade | Solução permanente | Correção temporária |

---

## Verificação de Eficácia

Verificar se as ações corretivas alcançaram os resultados pretendidos:

1. Permitir período adequado de implementação (mínimo 30-90 dias)
2. Coletar dados pós-implementação
3. Comparar com a linha de base pré-implementação
4. Avaliar em relação aos critérios de sucesso
5. Verificar ausência de recorrência durante o período de verificação
6. Documentar evidência de verificação
7. Determinar a eficácia da CAPA
8. **Validação:** Todos os critérios atendidos com evidência objetiva; nenhuma recorrência observada

### Diretrizes de Prazo para Verificação

| Severidade da CAPA | Período de Espera | Janela de Verificação |
|---------------|-------------|---------------------|
| Crítica | 30 dias | 30-90 dias pós-implementação |
| Maior | 60 dias | 60-180 dias pós-implementação |
| Menor | 90 dias | 90-365 dias pós-implementação |

### Métodos de Verificação

| Método | Usar Quando | Evidência Obrigatória |
|--------|----------|-------------------|
| Análise de tendência de dados | Problemas quantificáveis | Comparação pré/pós, gráficos de tendência |
| Auditoria de processo | Problemas de conformidade com procedimentos | Lista de verificação, notas de entrevista |
| Revisão de registros | Problemas de documentação | Registros de amostra, taxa de conformidade |
| Teste/inspeção | Problemas de qualidade do produto | Resultados de teste, dados de aprovado/reprovado |
| Entrevista/observação | Problemas de treinamento | Notas de entrevista, registros de observação |

### Determinação de Eficácia

```
Houve recorrência durante o período de verificação?
├── Sim → CAPA INEFICAZ (reinvestigar causa raiz)
└── Não → Todos os critérios de eficácia foram atendidos?
    ├── Sim → CAPA EFICAZ (prosseguir para encerramento)
    └── Não → Extensão da lacuna?
        ├── Lacuna menor → Estender verificação ou aceitar com justificativa
        └── Lacuna significativa → CAPA INEFICAZ (revisar ações)
```

Veja `references/effectiveness-verification-guide.md` para procedimentos detalhados.

---

## Métricas e Relatórios CAPA

Monitorar o desempenho do programa CAPA por meio de indicadores-chave.

### Indicadores-Chave de Desempenho

| Métrica | Meta | Cálculo |
|--------|--------|-------------|
| Tempo de ciclo da CAPA | <60 dias em média | (Data de encerramento - Data de abertura) / Número de CAPAs |
| Taxa de atraso | <10% | CAPAs em atraso / Total de CAPAs abertas |
| Eficácia na primeira verificação | >90% | Eficaz na primeira verificação / Total verificadas |
| Taxa de recorrência | <5% | Problemas recorrentes / Total de CAPAs encerradas |
| Qualidade da investigação | 100% de causas raiz validadas | Causas raiz validadas / Total de CAPAs |

### Categorias de Análise de Envelhecimento

| Faixa de Idade | Status | Ação Obrigatória |
|------------|--------|-----------------|
| 0-30 dias | No prazo | Monitorar progresso |
| 31-60 dias | Monitorar | Revisar atrasos |
| 61-90 dias | Atenção | Escalar para gestão |
| >90 dias | Crítico | Intervenção da gestão obrigatória |

### Entradas para Revisão Gerencial

O relatório mensal de status da CAPA inclui:
- Contagem de CAPAs abertas por severidade e status
- Lista de CAPAs em atraso com respectivos responsáveis
- Tendências de tempo de ciclo
- Tendências de taxa de eficácia
- Análise de fonte (reclamações, auditorias, NCs)
- Recomendações de melhoria

---

## Documentação de Referência

### Metodologias de Análise de Causa Raiz

`references/rca-methodologies.md` contém:

- Árvore de decisão para seleção de método
- Template e exemplo de análise dos 5 Porquês
- Categorias e template do diagrama de Ishikawa
- Análise da Árvore de Falhas para problemas críticos de segurança
- Análise de Fatores Humanos para causas relacionadas a pessoas
- FMEA para avaliação proativa de riscos
- Orientações para abordagem híbrida

### Guia de Verificação de Eficácia

`references/effectiveness-verification-guide.md` contém:

- Requisitos de planejamento da verificação
- Seleção de método de verificação
- Definição de critérios de eficácia (SMART)
- Requisitos de encerramento por severidade
- Processo de CAPA ineficaz
- Templates de documentação

---

## Ferramentas

### Rastreador de CAPA

```bash
# Gerar relatório de status da CAPA
python scripts/capa_tracker.py --capas capas.json

# Modo interativo para entrada manual
python scripts/capa_tracker.py --interactive

# Saída JSON para integração
python scripts/capa_tracker.py --capas capas.json --output json

# Gerar arquivo de dados de amostra
python scripts/capa_tracker.py --sample > sample_capas.json
```

Calcula e reporta:
- Métricas resumidas (abertas, encerradas, em atraso, tempo de ciclo, eficácia)
- Distribuição de status
- Análise por severidade e fonte
- Relatório de envelhecimento por faixa de tempo
- Lista de CAPAs em atraso
- Recomendações acionáveis

### Entrada de Amostra CAPA

```json
{
  "capas": [
    {
      "capa_number": "CAPA-2024-001",
      "title": "Calibration overdue for pH meter",
      "description": "pH meter EQ-042 found 2 months overdue",
      "source": "AUDIT",
      "severity": "MAJOR",
      "status": "VERIFICATION",
      "open_date": "2024-06-15",
      "target_date": "2024-08-15",
      "owner": "J. Smith",
      "root_cause": "Procedure review gap",
      "corrective_action": "Updated SOP-EQ-001"
    }
  ]
}
```

---

## Requisitos Regulatórios

### ISO 13485:2016 Cláusula 8.5

| Subcláusula | Requisito | Atividades-Chave |
|------------|-------------|----------------|
| 8.5.2 Ação Corretiva | Eliminar a causa de não conformidade | Revisão de NC, determinação de causa, avaliação de ação, implementação, revisão de eficácia |
| 8.5.3 Ação Preventiva | Eliminar a potencial não conformidade | Análise de tendência, determinação de causa, avaliação de ação, implementação, revisão de eficácia |

### FDA 21 CFR 820.100

Elementos CAPA obrigatórios:
- Procedimentos para implementar ações corretivas e preventivas
- Análise de fontes de dados de qualidade (reclamações, NCs, auditorias, registros de serviço)
- Investigação de causa de não conformidades
- Identificação de ações necessárias para corrigir e prevenir recorrência
- Verificação de que as ações são eficazes e não afetam adversamente o dispositivo
- Submissão de informações relevantes para revisão gerencial

### Observações Comuns do FDA 483

| Observação | Padrão de Causa Raiz |
|-------------|-------------------|
| CAPA não iniciada para problema recorrente | Análise de tendência não realizada |
| Análise de causa raiz superficial | Treinamento de investigação inadequado |
| Eficácia não verificada | Sem procedimento de verificação |
| Ações não tratam a causa raiz | Tratamento de sintoma versus eliminação de causa |
