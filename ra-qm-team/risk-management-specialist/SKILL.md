---
name: "risk-management-specialist"
description: Especialista em gestão de riscos de dispositivos médicos, implementando a ISO 14971 ao longo do ciclo de vida do produto. Fornece análise de riscos, avaliação de riscos, controle de riscos e análise de informações pós-produção. Use quando o usuário mencionar gestão de riscos, ISO 14971, análise de riscos, FMEA, análise de árvore de falhas, identificação de perigos, controle de riscos, matriz de riscos, análise benefício-risco, risco residual, aceitabilidade de riscos ou risco pós-mercado.
---

# Risk Management Specialist

Implementação da gestão de riscos ISO 14971:2019 ao longo do ciclo de vida do dispositivo médico.

---

## Sumário

- [Fluxo de Trabalho de Planejamento da Gestão de Riscos](#fluxo-de-trabalho-de-planejamento-da-gestão-de-riscos)
- [Fluxo de Trabalho de Análise de Riscos](#fluxo-de-trabalho-de-análise-de-riscos)
- [Fluxo de Trabalho de Avaliação de Riscos](#fluxo-de-trabalho-de-avaliação-de-riscos)
- [Fluxo de Trabalho de Controle de Riscos](#fluxo-de-trabalho-de-controle-de-riscos)
- [Gestão de Riscos Pós-Produção](#gestão-de-riscos-pós-produção)
- [Templates de Avaliação de Riscos](#templates-de-avaliação-de-riscos)
- [Frameworks de Decisão](#frameworks-de-decisão)
- [Ferramentas e Referências](#ferramentas-e-referências)

---

## Fluxo de Trabalho de Planejamento da Gestão de Riscos

Estabelecer o processo de gestão de riscos conforme a ISO 14971.

### Fluxo de Trabalho: Criar Plano de Gestão de Riscos

1. Definir o escopo das atividades de gestão de riscos:
   - Identificação do dispositivo médico
   - Estágios do ciclo de vida cobertos
   - Normas e regulamentações aplicáveis
2. Estabelecer critérios de aceitabilidade de riscos:
   - Definir categorias de probabilidade (P1-P5)
   - Definir categorias de severidade (S1-S5)
   - Criar matriz de riscos com limiares de aceitação
3. Atribuir responsabilidades:
   - Líder de gestão de riscos
   - Especialistas no assunto
   - Autoridades de aprovação
4. Definir atividades de verificação:
   - Métodos para verificação de controles
   - Critérios de aceitação
5. Planejar atividades de produção e pós-produção:
   - Fontes de informação
   - Gatilhos de revisão
   - Procedimentos de atualização
6. Obter aprovação do plano
7. Estabelecer o arquivo de gestão de riscos
8. **Validação:** Plano aprovado; critérios de aceitabilidade definidos; responsabilidades atribuídas; arquivo estabelecido

### Conteúdo do Plano de Gestão de Riscos

| Seção | Conteúdo | Evidência |
|---------|---------|----------|
| Escopo | Dispositivo e cobertura do ciclo de vida | Declaração de escopo |
| Critérios | Matriz de aceitabilidade de riscos | Documento da matriz de riscos |
| Responsabilidades | Funções e autoridades | Gráfico RACI |
| Verificação | Métodos e aceitação | Plano de verificação |
| Produção/Pós-Produção | Atividades de monitoramento | Plano de vigilância |

### Matriz de Aceitabilidade de Riscos (5x5)

| Probabilidade \ Severidade | Negligível | Menor | Grave | Crítico | Catastrófico |
|------------------------|------------|-------|---------|----------|--------------|
| **Frequente (P5)** | Médio | Alto | Alto | Inaceitável | Inaceitável |
| **Provável (P4)** | Médio | Médio | Alto | Alto | Inaceitável |
| **Ocasional (P3)** | Baixo | Médio | Médio | Alto | Alto |
| **Remoto (P2)** | Baixo | Baixo | Médio | Médio | Alto |
| **Improvável (P1)** | Baixo | Baixo | Baixo | Médio | Médio |

### Ações por Nível de Risco

| Nível | Aceitável | Ação Obrigatória |
|-------|------------|-----------------|
| Baixo | Sim | Documentar e aceitar |
| Médio | ALARP | Reduzir se praticável; documentar justificativa |
| Alto | ALARP | Redução obrigatória; demonstrar ALARP |
| Inaceitável | Não | Mudança de projeto obrigatória |

---

## Fluxo de Trabalho de Análise de Riscos

Identificar perigos e estimar riscos sistematicamente.

### Fluxo de Trabalho: Conduzir Análise de Riscos

1. Definir uso pretendido e uso indevido razoavelmente previsível:
   - Indicação médica
   - População de pacientes
   - População de usuários
   - Ambiente de uso
2. Selecionar método(s) de análise:
   - FMEA para análise de componente/função
   - FTA para análise em nível de sistema
   - HAZOP para desvios de processo
   - Análise de Erros de Uso para interação com o usuário
3. Identificar perigos por categoria:
   - Perigos energéticos (elétrico, mecânico, térmico)
   - Perigos biológicos (biocarga, biocompatibilidade)
   - Perigos químicos (resíduos, lixiviados)
   - Perigos operacionais (software, erros de uso)
4. Determinar situações perigosas:
   - Sequência de eventos
   - Cenários de uso indevido previsíveis
   - Condições de falha única
5. Estimar a probabilidade de dano (P1-P5)
6. Estimar a severidade do dano (S1-S5)
7. Documentar na planilha de análise de perigos
8. **Validação:** Todas as categorias de perigos tratadas; todos os perigos documentados; probabilidade e severidade atribuídas

### Lista de Verificação de Categorias de Perigos

| Categoria | Exemplos | Analisado |
|----------|----------|----------|
| Elétrico | Choque, queimaduras, interferência | ☐ |
| Mecânico | Esmagamento, corte, aprisionamento | ☐ |
| Térmico | Queimaduras, dano tecidual | ☐ |
| Radiação | Ionizante, não ionizante | ☐ |
| Biológico | Infecção, biocompatibilidade | ☐ |
| Químico | Toxicidade, irritação | ☐ |
| Software | Saída incorreta, temporização | ☐ |
| Erro de Uso | Uso indevido, percepção, cognição | ☐ |
| Ambiente | EMC, estresse mecânico | ☐ |

### Seleção do Método de Análise

| Situação | Método Recomendado |
|-----------|-------------------|
| Falhas de componentes | FMEA |
| Falha em nível de sistema | FTA |
| Desvios de processo | HAZOP |
| Interação com usuário | Análise de Erros de Uso |
| Comportamento de software | FMEA de Software |
| Fase inicial de projeto | PHA |

### Critérios de Probabilidade

| Nível | Nome | Descrição | Frequência |
|-------|------|-------------|-----------|
| P5 | Frequente | Espera-se que ocorra | >10⁻³ |
| P4 | Provável | Provavelmente ocorrerá | 10⁻³ a 10⁻⁴ |
| P3 | Ocasional | Pode ocorrer | 10⁻⁴ a 10⁻⁵ |
| P2 | Remoto | Improvável | 10⁻⁵ a 10⁻⁶ |
| P1 | Improvável | Muito improvável | <10⁻⁶ |

### Critérios de Severidade

| Nível | Nome | Descrição | Dano |
|-------|------|-------------|------|
| S5 | Catastrófico | Morte | Morte |
| S4 | Crítico | Deficiência permanente | Lesão irreversível |
| S3 | Grave | Lesão que requer intervenção | Lesão reversível |
| S2 | Menor | Desconforto temporário | Sem necessidade de tratamento |
| S1 | Negligível | Inconveniente | Sem lesão |

Veja: [references/risk-analysis-methods.md](references/risk-analysis-methods.md)

---

## Fluxo de Trabalho de Avaliação de Riscos

Avaliar riscos em relação aos critérios de aceitabilidade.

### Fluxo de Trabalho: Avaliar Riscos Identificados

1. Calcular o nível de risco inicial a partir de probabilidade × severidade
2. Comparar com os critérios de aceitabilidade de riscos
3. Para cada risco, determinar:
   - Aceitável: Documentar e aceitar
   - ALARP: Prosseguir para controle de risco
   - Inaceitável: Controle de risco obrigatório
4. Documentar justificativa da avaliação
5. Identificar riscos que requerem análise benefício-risco
6. Completar análise benefício-risco se aplicável
7. Compilar resumo da avaliação de riscos
8. **Validação:** Todos os riscos avaliados; aceitabilidade determinada; justificativa documentada

### Árvore de Decisão de Avaliação de Riscos

```
Risco Estimado
      │
      ▼
Aplicar Critérios de Aceitabilidade
      │
      ├── Risco Baixo ──────────► Aceitar e documentar
      │
      ├── Risco Médio ──────────► Considerar redução de risco
      │   │                       Documentar ALARP se não reduzido
      │   ▼
      │   Praticável reduzir?
      │   │
      │   Sim──► Implementar controle
      │   Não───► Documentar justificativa ALARP
      │
      ├── Risco Alto ──────────► Redução de risco obrigatória
      │   │                       Deve demonstrar ALARP
      │   ▼
      │   Implementar controle
      │   Verificar risco residual
      │
      └── Inaceitável ──────────► Mudança de projeto obrigatória
                                  Não pode prosseguir sem controle
```

### Requisitos de Demonstração de ALARP

| Critério | Evidência Obrigatória |
|-----------|-------------------|
| Viabilidade técnica | Análise de controles alternativos |
| Proporcionalidade | Análise de custo-benefício de redução adicional |
| Estado da arte | Comparação com dispositivos similares |
| Contribuição das partes interessadas | Perspectivas clínicas/de usuários |

### Gatilhos de Análise Benefício-Risco

| Situação | Análise Benefício-Risco Obrigatória |
|-----------|----------------------|
| Risco residual permanece alto | Sim |
| Sem redução de risco viável | Sim |
| Dispositivo inovador | Sim |
| Risco inaceitável com benefício clínico | Sim |
| Todos os riscos baixos | Não |

---

## Fluxo de Trabalho de Controle de Riscos

Implementar e verificar medidas de controle de riscos.

### Fluxo de Trabalho: Implementar Controles de Riscos

1. Identificar opções de controle de risco:
   - Segurança inerente pelo projeto (Prioridade 1)
   - Medidas de proteção no dispositivo (Prioridade 2)
   - Informações para segurança (Prioridade 3)
2. Selecionar o controle ideal seguindo a hierarquia
3. Analisar o controle quanto a novos perigos introduzidos
4. Documentar o controle nos requisitos de projeto
5. Implementar o controle no projeto
6. Desenvolver protocolo de verificação
7. Executar a verificação e documentar os resultados
8. Avaliar o risco residual com o controle implementado
9. **Validação:** Controle implementado; verificação aprovada; risco residual aceitável; nenhum novo perigo não tratado

### Hierarquia de Controle de Riscos

| Prioridade | Tipo de Controle | Exemplos | Eficácia |
|----------|--------------|----------|---------------|
| 1 | Segurança Inerente | Eliminar perigo, projeto à prova de falhas | Maior |
| 2 | Medida de Proteção | Proteções, alarmes, desligamento automático | Alta |
| 3 | Informação | Avisos, treinamento, IFU | Menor |

### Template de Análise de Opções de Controle de Risco

```
ANÁLISE DE OPÇÕES DE CONTROLE DE RISCO

ID do Perigo: H-[XXX]
Perigo: [Descrição]
Risco Inicial: P[X] × S[X] = [Nível]

OPÇÕES CONSIDERADAS:
| Opção | Tipo de Controle | Novos Perigos | Viabilidade | Selecionada |
|-------|--------------|-------------|-------------|----------|
| 1 | [Tipo] | [Sim/Não] | [A/M/B] | [Sim/Não] |
| 2 | [Tipo] | [Sim/Não] | [A/M/B] | [Sim/Não] |

CONTROLE SELECIONADO: Opção [X]
Justificativa: [Justificativa para seleção]

IMPLEMENTAÇÃO:
- Requisito: [REQ-XXX]
- Documento de Projeto: [Referência]

VERIFICAÇÃO:
- Método: [Teste/Análise/Revisão]
- Protocolo: [Referência]
- Critérios de Aceitação: [Critérios]
```

### Métodos de Verificação de Controles de Risco

| Método | Quando Usar | Evidência |
|--------|-------------|----------|
| Teste | Desempenho quantificável | Relatório de teste |
| Inspeção | Presença física | Registro de inspeção |
| Análise | Cálculo de projeto | Relatório de análise |
| Revisão | Verificação documental | Registro de revisão |

### Avaliação de Risco Residual

| Após o Controle | Ação |
|---------------|--------|
| Aceitável | Documentar, prosseguir |
| ALARP atingido | Documentar justificativa, prosseguir |
| Ainda inaceitável | Controle adicional ou mudança de projeto |
| Novo perigo introduzido | Analisar e controlar o novo perigo |

---

## Gestão de Riscos Pós-Produção

Monitorar e atualizar a gestão de riscos ao longo do ciclo de vida do produto.

### Fluxo de Trabalho: Monitoramento de Riscos Pós-Produção

1. Identificar fontes de informação:
   - Reclamações de clientes
   - Relatórios de serviço
   - Vigilância/eventos adversos
   - Monitoramento de literatura
   - Estudos clínicos
2. Estabelecer procedimentos de coleta
3. Definir gatilhos de revisão:
   - Novo perigo identificado
   - Aumento de frequência de perigo conhecido
   - Incidente grave
   - Feedback regulatório
4. Analisar informações recebidas quanto à relevância de risco
5. Atualizar o arquivo de gestão de riscos conforme necessário
6. Comunicar achados significativos
7. Conduzir revisão periódica de gestão de riscos
8. **Validação:** Fontes de informação monitoradas; arquivo atualizado; revisões concluídas conforme o cronograma

### Fontes de Informação

| Fonte | Tipo de Informação | Frequência de Revisão |
|--------|------------------|------------------|
| Reclamações | Problemas de uso, falhas | Contínua |
| Serviço | Falhas em campo, reparos | Mensal |
| Vigilância | Incidentes graves | Imediata |
| Literatura | Problemas em dispositivos similares | Trimestral |
| Regulatório | Feedback de autoridades | Conforme recebido |
| Clínico | Dados PMCF | Por plano |

### Gatilhos de Atualização do Arquivo de Gestão de Riscos

| Gatilho | Tempo de Resposta | Ação |
|---------|---------------|--------|
| Incidente grave | Imediato | Revisão completa de riscos |
| Novo perigo identificado | 30 dias | Atualização da análise de riscos |
| Aumento de tendência | 60 dias | Análise de tendência |
| Mudança de projeto | Antes da implementação | Avaliação de impacto |
| Atualização de normas | Por período de transição | Análise de lacunas |

### Requisitos de Revisão Periódica

| Elemento de Revisão | Frequência |
|----------------|-----------|
| Completude do arquivo de gestão de riscos | Anual |
| Eficácia dos controles de risco | Anual |
| Análise de informações pós-mercado | Trimestral |
| Conclusões benefício-risco | Anual ou com novos dados |

---

## Templates de Avaliação de Riscos
→ Veja references/risk-assessment-templates.md para detalhes

## Frameworks de Decisão

### Seleção de Controle de Risco

```
Qual é o nível de risco?
        │
        ├── Inaceitável ──► O perigo pode ser eliminado?
        │                    │
        │                Sim─┴─Não
        │                 │     │
        │                 ▼     ▼
        │            Eliminar  Medida de proteção
        │            o perigo  pode reduzir?
        │                           │
        │                       Sim─┴─Não
        │                        │     │
        │                        ▼     ▼
        │                   Adicionar  Adicionar aviso
        │                   proteção   + treinamento
        │
        └── Alto/Médio ──► Aplicar hierarquia
                            a partir do Nível 1
```

### Análise de Novos Perigos

| Pergunta | Se Sim | Se Não |
|----------|--------|-------|
| O controle introduz novo perigo? | Analisar novo perigo | Prosseguir |
| O novo risco é maior que o original? | Rejeitar opção de controle | Trade-off aceitável |
| O novo perigo pode ser controlado? | Adicionar controle | Rejeitar opção de controle |

### Decisão de Aceitabilidade de Risco

| Condição | Decisão |
|-----------|----------|
| Todos os riscos Baixos | Aceitável |
| Riscos Médios com ALARP | Aceitável |
| Riscos Altos com ALARP documentado | Aceitável se benefícios superam os riscos |
| Qualquer residual Inaceitável | Não aceitável - redesenhar |

---

## Ferramentas e Referências

### Scripts

| Ferramenta | Propósito | Uso |
|------|---------|-------|
| [risk_matrix_calculator.py](scripts/risk_matrix_calculator.py) | Calcular níveis de risco e RPN de FMEA | `python risk_matrix_calculator.py --help` |

**Funcionalidades da Calculadora de Matriz de Riscos:**
- Cálculo de matriz de riscos 5x5 ISO 14971
- Cálculo de RPN de FMEA (Número de Prioridade de Risco)
- Modo interativo para avaliação guiada
- Exibição de definições de critérios de risco
- Saída JSON para integração

### Referências

| Documento | Conteúdo |
|----------|---------|
| [iso14971-implementation-guide.md](references/iso14971-implementation-guide.md) | Implementação completa ISO 14971:2019 com templates |
| [risk-analysis-methods.md](references/risk-analysis-methods.md) | Métodos FMEA, FTA, HAZOP, Análise de Erros de Uso |

### Referência Rápida: Processo ISO 14971

| Estágio | Atividades-Chave | Saída |
|-------|----------------|--------|
| Planejamento | Definir escopo, critérios, responsabilidades | Plano de Gestão de Riscos |
| Análise | Identificar perigos, estimar riscos | Análise de Perigos |
| Avaliação | Comparar com critérios, avaliação ALARP | Avaliação de Riscos |
| Controle | Implementar hierarquia, verificar | Registros de Controle de Riscos |
| Residual | Avaliação geral, benefício-risco | Relatório de Gestão de Riscos |
| Produção | Monitorar, revisar, atualizar | Arquivo RM Atualizado |

---

## Skills Relacionadas

| Skill | Ponto de Integração |
|-------|-------------------|
| [quality-manager-qms-iso13485](../quality-manager-qms-iso13485/) | Integração com QMS |
| [capa-officer](../capa-officer/) | CAPA baseada em risco |
| [regulatory-affairs-head](../regulatory-affairs-head/) | Submissões regulatórias |
| [quality-documentation-manager](../quality-documentation-manager/) | Gestão do arquivo de riscos |
