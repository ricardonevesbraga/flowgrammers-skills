---
name: "product-manager-toolkit"
description: Kit de ferramentas abrangente para gerentes de produto incluindo priorização RICE, análise de entrevistas com clientes, templates de PRD, frameworks de descoberta e estratégias de go-to-market. Use para priorização de funcionalidades, síntese de pesquisa com usuários, documentação de requisitos e desenvolvimento de estratégia de produto.
agents:
  - claude-code
---

# Kit de Ferramentas para Gerente de Produto

Ferramentas e frameworks essenciais para gestão de produto moderna, da descoberta à entrega.

---

## Sumário

- [Início Rápido](#início-rápido)
- [Fluxos de Trabalho Principais](#fluxos-de-trabalho-principais)
  - [Priorização de Funcionalidades](#processo-de-priorização-de-funcionalidades)
  - [Descoberta de Clientes](#processo-de-descoberta-de-clientes)
  - [Desenvolvimento de PRD](#processo-de-desenvolvimento-de-prd)
- [Referência de Ferramentas](#referência-de-ferramentas)
  - [RICE Prioritizer](#rice-prioritizer)
  - [Analisador de Entrevistas com Clientes](#analisador-de-entrevistas-com-clientes)
- [Exemplos de Entrada/Saída](#exemplos-de-entradasaída)
- [Pontos de Integração](#pontos-de-integração)
- [Armadilhas Comuns](#armadilhas-comuns-a-evitar)

---

## Início Rápido

### Para Priorização de Funcionalidades
```bash
# Criar arquivo de dados de exemplo
python scripts/rice_prioritizer.py sample

# Executar priorização com capacidade da equipe
python scripts/rice_prioritizer.py sample_features.csv --capacity 15
```

### Para Análise de Entrevistas
```bash
python scripts/customer_interview_analyzer.py interview_transcript.txt
```

### Para Criação de PRD
1. Escolha o template em `references/prd_templates.md`
2. Preencha as seções com base no trabalho de descoberta
3. Revise com engenharia para verificar viabilidade
4. Controle de versão na ferramenta de gestão de projetos

---

## Fluxos de Trabalho Principais

### Processo de Priorização de Funcionalidades

```
Coletar → Pontuar → Analisar → Planejar → Validar → Executar
```

#### Passo 1: Coletar Solicitações de Funcionalidades
- Feedback de clientes (tickets de suporte, entrevistas)
- Solicitações de vendas (bloqueadores no pipeline de CRM)
- Dívida técnica (input de engenharia)
- Iniciativas estratégicas (metas da liderança)

#### Passo 2: Pontuar com RICE
```bash
# Entrada: CSV com funcionalidades
python scripts/rice_prioritizer.py features.csv --capacity 20
```

Veja `references/frameworks.md` para a fórmula RICE e diretrizes de pontuação.

#### Passo 3: Analisar Portfólio
Revise a saída da ferramenta em busca de:
- Distribuição de vitórias rápidas vs grandes apostas
- Concentração de esforço (evite todos os projetos XL)
- Lacunas de alinhamento estratégico

#### Passo 4: Gerar Roadmap
- Alocação de capacidade trimestral
- Identificação de dependências
- Plano de comunicação com partes interessadas

#### Passo 5: Validar Resultados
**Antes de finalizar o roadmap:**
- [ ] Comparar prioridades principais com metas estratégicas
- [ ] Executar análise de sensibilidade (e se as estimativas estiverem erradas por 2x?)
- [ ] Revisar com as principais partes interessadas em busca de pontos cegos
- [ ] Verificar dependências ausentes entre funcionalidades
- [ ] Validar estimativas de esforço com engenharia

#### Passo 6: Executar e Iterar
- Compartilhe o roadmap com a equipe
- Rastreie esforço real vs estimado
- Revisite prioridades trimestralmente
- Atualize inputs RICE com base em aprendizados

---

### Processo de Descoberta de Clientes

```
Planejar → Recrutar → Entrevistar → Analisar → Sintetizar → Validar
```

#### Passo 1: Planejar Pesquisa
- Definir questões de pesquisa
- Identificar segmentos-alvo
- Criar roteiro de entrevista (veja `references/frameworks.md`)

#### Passo 2: Recrutar Participantes
- 5-8 entrevistas por segmento
- Mix de power users e usuários que saíram (churn)
- Incentive adequadamente

#### Passo 3: Conduzir Entrevistas
- Use formato semi-estruturado
- Foque nos problemas, não nas soluções
- Grave com permissão
- Tome notas mínimas durante a entrevista

#### Passo 4: Analisar Insights
```bash
python scripts/customer_interview_analyzer.py transcript.txt
```

Extrai:
- Pontos de dor com severidade
- Solicitações de funcionalidades com prioridade
- Padrões de jobs-to-be-done
- Sentimento e temas principais
- Citações notáveis

#### Passo 5: Sintetizar Descobertas
- Agrupar pontos de dor similares entre entrevistas
- Identificar padrões (3+ menções = padrão)
- Mapear para áreas de oportunidade usando a Árvore de Oportunidades e Soluções
- Priorizar oportunidades por frequência e severidade

#### Passo 6: Validar Soluções
**Antes de construir:**
- [ ] Criar hipóteses de solução (veja `references/frameworks.md`)
- [ ] Testar com protótipos de baixa fidelidade
- [ ] Medir comportamento real vs preferência declarada
- [ ] Iterar com base no feedback
- [ ] Documentar aprendizados para pesquisas futuras

---

### Processo de Desenvolvimento de PRD

```
Escopo → Rascunho → Revisão → Refinar → Aprovar → Rastrear
```

#### Passo 1: Escolher Template
Selecione em `references/prd_templates.md`:

| Template | Caso de Uso | Prazo |
|----------|-------------|-------|
| PRD Padrão | Funcionalidades complexas, cross-team | 6-8 semanas |
| PRD de Uma Página | Funcionalidades simples, equipe única | 2-4 semanas |
| Briefing de Funcionalidade | Fase de exploração | 1 semana |
| Épico Ágil | Entrega baseada em sprint | Contínuo |

#### Passo 2: Rascunhar Conteúdo
- Lidere com a declaração do problema
- Defina métricas de sucesso antecipadamente
- Declare explicitamente os itens fora do escopo
- Inclua wireframes ou mockups

#### Passo 3: Ciclo de Revisão
- Engenharia: viabilidade e esforço
- Design: lacunas na experiência do usuário
- Vendas: validação de mercado
- Suporte: impacto operacional

#### Passo 4: Refinar com Base no Feedback
- Resolva restrições técnicas
- Ajuste o escopo para caber no prazo
- Documente decisões de trade-off

#### Passo 5: Aprovação e Kickoff
- Sign-off das partes interessadas
- Integração com planejamento de sprint
- Comunicação para a equipe ampliada

#### Passo 6: Rastrear Execução
**Após o lançamento:**
- [ ] Comparar métricas reais vs metas
- [ ] Conduzir sessões de feedback com usuários
- [ ] Documentar o que funcionou e o que não funcionou
- [ ] Atualizar dados de precisão de estimativa
- [ ] Compartilhar aprendizados com a equipe

---

## Referência de Ferramentas

### RICE Prioritizer

Implementação avançada do framework RICE com análise de portfólio.

**Funcionalidades:**
- Cálculo de pontuação RICE com pesos configuráveis
- Análise de equilíbrio de portfólio (vitórias rápidas vs grandes apostas)
- Geração de roadmap trimestral com base na capacidade
- Múltiplos formatos de saída (texto, JSON, CSV)

**Formato de Entrada CSV:**
```csv
name,reach,impact,confidence,effort,description
User Dashboard Redesign,5000,high,high,l,Complete redesign
Mobile Push Notifications,10000,massive,medium,m,Add push support
Dark Mode,8000,medium,high,s,Dark theme option
```

**Comandos:**
```bash
# Criar dados de exemplo
python scripts/rice_prioritizer.py sample

# Executar com capacidade padrão (10 person-months)
python scripts/rice_prioritizer.py features.csv

# Capacidade personalizada
python scripts/rice_prioritizer.py features.csv --capacity 20

# Saída JSON para integração
python scripts/rice_prioritizer.py features.csv --output json

# Saída CSV para planilhas
python scripts/rice_prioritizer.py features.csv --output csv
```

---

### Analisador de Entrevistas com Clientes

Análise de entrevistas baseada em NLP para extrair insights acionáveis.

**Capacidades:**
- Extração de pontos de dor com avaliação de severidade
- Identificação e classificação de solicitações de funcionalidades
- Reconhecimento de padrões jobs-to-be-done
- Análise de sentimento por seção
- Extração de temas e citações
- Detecção de menções de concorrentes

**Comandos:**
```bash
# Analisar transcrição de entrevista
python scripts/customer_interview_analyzer.py interview.txt

# Saída JSON para agregação
python scripts/customer_interview_analyzer.py interview.txt json
```

---

## Exemplos de Entrada/Saída
→ Veja references/input-output-examples.md para detalhes

## Pontos de Integração

Ferramentas e plataformas compatíveis:

| Categoria | Plataformas |
|-----------|-------------|
| **Analytics** | Amplitude, Mixpanel, Google Analytics |
| **Roadmapping** | ProductBoard, Aha!, Roadmunk, Productplan |
| **Design** | Figma, Sketch, Miro |
| **Desenvolvimento** | Jira, Linear, GitHub, Asana |
| **Pesquisa** | Dovetail, UserVoice, Pendo, Maze |
| **Comunicação** | Slack, Notion, Confluence |

**Exportação JSON habilita integração com a maioria das ferramentas:**
```bash
# Exportar para importação no Jira
python scripts/rice_prioritizer.py features.csv --output json > priorities.json

# Exportar para dashboard
python scripts/customer_interview_analyzer.py interview.txt json > insights.json
```

---

## Armadilhas Comuns a Evitar

| Armadilha | Descrição | Prevenção |
|-----------|-----------|-----------|
| **Solução Primeiro** | Pular para funcionalidades antes de entender os problemas | Comece todo PRD com declaração do problema |
| **Paralisia de Análise** | Pesquisar demais sem lançar | Defina time-boxes para fases de pesquisa |
| **Fábrica de Funcionalidades** | Lançar funcionalidades sem medir impacto | Defina métricas de sucesso antes de construir |
| **Ignorar Dívida Técnica** | Não alocar tempo para saúde da plataforma | Reserve 20% da capacidade para manutenção |
| **Surpresa para Partes Interessadas** | Não comunicar cedo e frequentemente | Atualizações assíncronas semanais, demos mensais |
| **Teatro de Métricas** | Otimizar métricas de vaidade em vez de valor real | Vincule métricas ao valor entregue ao usuário |

---

## Melhores Práticas

**Escrevendo Ótimos PRDs:**
- Comece com o problema, não a solução
- Inclua métricas de sucesso claras antecipadamente
- Declare explicitamente o que está fora do escopo
- Use elementos visuais (wireframes, fluxos, diagramas)
- Mantenha detalhes técnicos no apêndice
- Controle de versão de todas as mudanças

**Priorização Eficaz:**
- Misture vitórias rápidas com apostas estratégicas
- Considere o custo de oportunidade dos atrasos
- Considere dependências entre funcionalidades
- Reserve 20% para trabalho inesperado
- Revisite prioridades trimestralmente
- Comunique decisões com contexto

**Descoberta de Clientes:**
- Pergunte "por quê" cinco vezes para encontrar a causa raiz
- Foque no comportamento passado, não em intenções futuras
- Evite perguntas tendenciosas ("Você não adoraria...")
- Entreviste no ambiente natural do usuário
- Observe reações emocionais (dor = oportunidade)
- Valide dados qualitativos com quantitativos

---

## Referência Rápida

```bash
# Priorização
python scripts/rice_prioritizer.py features.csv --capacity 15

# Análise de Entrevistas
python scripts/customer_interview_analyzer.py interview.txt

# Gerar dados de exemplo
python scripts/rice_prioritizer.py sample

# Saídas JSON
python scripts/rice_prioritizer.py features.csv --output json
python scripts/customer_interview_analyzer.py interview.txt json
```

---

## Documentos de Referência

- `references/prd_templates.md` - Templates de PRD para diferentes contextos
- `references/frameworks.md` - Documentação detalhada de frameworks (RICE, MoSCoW, Kano, JTBD, etc.)
