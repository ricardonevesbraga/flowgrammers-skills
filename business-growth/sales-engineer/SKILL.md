---
name: "sales-engineer"
description: Analisa respostas de RFP/RFI para lacunas de cobertura, constrói matrizes de comparação de funcionalidades competitivas e planeja engajamentos de prova de conceito (POC) para engenharia de pré-vendas. Use ao responder a RFPs, licitações ou solicitações de proposta; comparar funcionalidades do produto contra concorrentes; planejar ou pontuar um POC ou demonstração de vendas para o cliente; preparar uma proposta técnica; ou realizar análise competitiva de vitórias/perdas. Lida com tarefas descritas como 'resposta a RFP', 'resposta a licitação', 'resposta a proposta', 'comparação de concorrente', 'matriz de funcionalidades', 'planejamento de POC', 'preparação de demo de vendas' ou 'engenharia de pré-vendas'.
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Skill de Sales Engineer

## Fluxo de Trabalho em 5 Fases

### Fase 1: Descoberta e Pesquisa

**Objetivo:** Entender os requisitos do cliente, ambiente técnico e drivers de negócio.

**Lista de Verificação:**
- [ ] Conduzir chamadas de descoberta técnica com partes interessadas
- [ ] Mapear a arquitetura atual do cliente e pontos de dor
- [ ] Identificar requisitos de integração e restrições
- [ ] Documentar requisitos de segurança e conformidade
- [ ] Avaliar o cenário competitivo para esta oportunidade

**Ferramentas:** Executar `rfp_response_analyzer.py` para pontuar o alinhamento inicial de requisitos.

```bash
python scripts/rfp_response_analyzer.py assets/sample_rfp_data.json --format json > phase1_rfp_results.json
```

**Saída:** Documento de descoberta técnica, mapa de requisitos, avaliação inicial de cobertura.

**Ponto de verificação de validação:** A pontuação de cobertura deve ser >50% e lacunas obrigatórias ≤3 antes de prosseguir para a Fase 2. Verificar com:
```bash
python scripts/rfp_response_analyzer.py assets/sample_rfp_data.json --format json | python -c "import sys,json; r=json.load(sys.stdin); print('PROSSEGUIR' if r['coverage_score']>50 and r['must_have_gaps']<=3 else 'REVISAR')"
```

---

### Fase 2: Design da Solução

**Objetivo:** Projetar uma arquitetura de solução que atenda aos requisitos do cliente.

**Lista de Verificação:**
- [ ] Mapear capacidades do produto para os requisitos do cliente
- [ ] Projetar arquitetura de integração
- [ ] Identificar necessidades de customização e esforço de desenvolvimento
- [ ] Construir estratégia de diferenciação competitiva
- [ ] Criar diagramas de arquitetura da solução

**Ferramentas:** Executar `competitive_matrix_builder.py` usando dados da Fase 1 para identificar diferenciadores e vulnerabilidades.

```bash
python scripts/competitive_matrix_builder.py competitive_data.json --format json > phase2_competitive.json

python -c "import json; d=json.load(open('phase2_competitive.json')); print('Diferenciadores:', d['differentiators']); print('Vulnerabilidades:', d['vulnerabilities'])"
```

**Saída:** Arquitetura da solução, posicionamento competitivo, estratégia de diferenciação técnica.

**Ponto de verificação de validação:** Confirmar que existe pelo menos um diferenciador forte por prioridade do cliente antes de prosseguir para a Fase 3. Se nenhum diferenciador for encontrado, escalar para o Time de Produto (veja Pontos de Integração).

---

### Fase 3: Preparação e Entrega da Demo

**Objetivo:** Entregar demonstrações técnicas convincentes adaptadas às prioridades das partes interessadas.

**Lista de Verificação:**
- [ ] Construir ambiente de demo correspondendo ao caso de uso do cliente
- [ ] Criar script de demo com pontos de fala por função de parte interessada
- [ ] Preparar respostas para tratamento de objeções
- [ ] Ensaiar cenários de falha e caminhos de recuperação
- [ ] Coletar feedback e ajustar a abordagem

**Templates:** Usar `assets/demo_script_template.md` para preparação estruturada da demo.

**Saída:** Demo personalizada, pontos de fala específicos por parte interessada, captura de feedback.

**Ponto de verificação de validação:** O script de demo deve cobrir cada requisito obrigatório sinalizado em `phase1_rfp_results.json` antes da entrega. Verificar com:
```bash
python -c "import json; rfp=json.load(open('phase1_rfp_results.json')); [print('NÃO COBERTO:', r) for r in rfp['must_have_requirements'] if r['coverage']=='Gap']"
```

---

### Fase 4: POC e Avaliação

**Objetivo:** Executar uma prova de conceito estruturada que valide a solução.

**Lista de Verificação:**
- [ ] Definir escopo do POC, critérios de sucesso e cronograma
- [ ] Alocar recursos e configurar ambiente
- [ ] Executar testes em fases (núcleo, avançado, casos extremos)
- [ ] Rastrear progresso em relação aos critérios de sucesso
- [ ] Gerar scorecard de avaliação

**Ferramentas:** Executar `poc_planner.py` para gerar o plano completo do POC.

```bash
python scripts/poc_planner.py poc_data.json --format json > phase4_poc_plan.json

python -c "import json; p=json.load(open('phase4_poc_plan.json')); print('Go/No-Go:', p['recommendation'])"
```

**Templates:** Usar `assets/poc_scorecard_template.md` para rastreamento da avaliação.

**Saída:** Plano do POC, scorecard de avaliação, recomendação de go/no-go.

**Ponto de verificação de validação:** A conversão do POC requer pontuação do scorecard >60% em todas as dimensões de avaliação (funcionalidade, desempenho, integração, usabilidade, suporte). Se pontuação <60%, documentar lacunas e voltar à Fase 2 para redesign da solução.

---

### Fase 5: Proposta e Fechamento

**Objetivo:** Entregar uma proposta técnica que suporte o fechamento comercial.

**Lista de Verificação:**
- [ ] Compilar resultados do POC e métricas de sucesso
- [ ] Criar proposta técnica com plano de implementação
- [ ] Abordar objeções pendentes com evidências
- [ ] Suportar discussões de precificação e pacotes
- [ ] Conduzir análise de vitória/perda pós-decisão

**Templates:** Usar `assets/technical_proposal_template.md` para o documento de proposta.

**Saída:** Proposta técnica, cronograma de implementação, plano de mitigação de riscos.

---

## Ferramentas de Automação Python

### 1. Analisador de Resposta a RFP

**Script:** `scripts/rfp_response_analyzer.py`

**Propósito:** Analisar requisitos de RFP/RFI, pontuar cobertura, identificar lacunas e gerar recomendações de licitação/não-licitação.

**Categorias de Cobertura:** Completa (100%), Parcial (50%), Planejada (25%), Lacuna (0%).
**Ponderação por Prioridade:** Obrigatório 3×, Deveria ter 2×, Agradável ter 1×.

**Lógica de Licitação/Não-Licitação:**
- **Licitação:** Cobertura >70% E lacunas obrigatórias ≤3
- **Licitação Condicional:** Cobertura 50–70% OU lacunas obrigatórias 2–3
- **Não Licitação:** Cobertura <50% OU lacunas obrigatórias >3

**Uso:**
```bash
python scripts/rfp_response_analyzer.py assets/sample_rfp_data.json            # legível por humanos
python scripts/rfp_response_analyzer.py assets/sample_rfp_data.json --format json  # saída JSON
python scripts/rfp_response_analyzer.py --help
```

**Formato de Entrada:** Veja `assets/sample_rfp_data.json` para o schema completo.

---

### 2. Construtor de Matriz Competitiva

**Script:** `scripts/competitive_matrix_builder.py`

**Propósito:** Gerar matrizes de comparação de funcionalidades, calcular pontuações competitivas, identificar diferenciadores e vulnerabilidades.

**Pontuação de Funcionalidades:** Completa (3), Parcial (2), Limitada (1), Nenhuma (0).

**Uso:**
```bash
python scripts/competitive_matrix_builder.py competitive_data.json              # legível por humanos
python scripts/competitive_matrix_builder.py competitive_data.json --format json  # saída JSON
```

**Saída Inclui:** Matriz de comparação de funcionalidades, pontuações competitivas ponderadas, diferenciadores, vulnerabilidades e temas de vitória.

---

### 3. Planejador de POC

**Script:** `scripts/poc_planner.py`

**Propósito:** Gerar planos de POC estruturados com cronograma, alocação de recursos, critérios de sucesso e scorecards de avaliação.

**Breakdown Padrão de Fases:**
- **Semana 1:** Configuração — provisionamento de ambiente, migração de dados, configuração
- **Semanas 2–3:** Teste Principal — casos de uso primários, teste de integração
- **Semana 4:** Teste Avançado — casos extremos, desempenho, segurança
- **Semana 5:** Avaliação — preenchimento do scorecard, revisão das partes interessadas, go/no-go

**Uso:**
```bash
python scripts/poc_planner.py poc_data.json              # legível por humanos
python scripts/poc_planner.py poc_data.json --format json  # saída JSON
```

**Saída Inclui:** Plano de POC em fases, alocação de recursos, critérios de sucesso, scorecard de avaliação, registro de riscos e framework de recomendação go/no-go.

---

## Base de Conhecimento de Referência

| Referência | Descrição |
|-----------|-------------|
| `references/rfp-response-guide.md` | Melhores práticas de resposta a RFP/RFI, matriz de conformidade, framework de licitação/não-licitação |
| `references/competitive-positioning-framework.md` | Metodologia de análise competitiva, criação de battlecard, tratamento de objeções |
| `references/poc-best-practices.md` | Metodologia de planejamento de POC, critérios de sucesso, frameworks de avaliação |

## Templates de Ativos

| Template | Propósito |
|----------|---------|
| `assets/technical_proposal_template.md` | Proposta técnica com resumo executivo, arquitetura da solução, plano de implementação |
| `assets/demo_script_template.md` | Script de demo com pauta, pontos de fala, tratamento de objeções |
| `assets/poc_scorecard_template.md` | Scorecard de avaliação do POC com pontuação ponderada |
| `assets/sample_rfp_data.json` | Dados de RFP de amostra para testar o analisador |
| `assets/expected_output.json` | Saída esperada de rfp_response_analyzer.py |

## Pontos de Integração

- **Marketing Skills** - Aproveitar inteligência competitiva e frameworks de mensagem de `../../marketing-skill/`
- **Product Team** - Coordenar em itens de roadmap sinalizados como "Planejado" na análise de RFP de `../../product-team/`
- **C-Level Advisory** - Escalar negócios estratégicos que requerem engajamento executivo de `../../c-level-advisor/`
- **Customer Success** - Transferir resultados do POC e critérios de sucesso para o CSM de `../customer-success-manager/`

---

**Última Atualização:** Fevereiro 2026
**Status:** Pronto para produção
**Ferramentas:** 3 scripts de automação Python
**Referências:** 3 documentos de base de conhecimento
**Templates:** 5 arquivos de ativos
