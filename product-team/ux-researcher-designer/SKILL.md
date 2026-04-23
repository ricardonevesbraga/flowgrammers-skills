---
name: "ux-researcher-designer"
description: Kit de ferramentas de pesquisa UX e design para Designer/Pesquisador UX Sênior incluindo geração de personas orientada por dados, mapeamento de jornada, frameworks de testes de usabilidade e síntese de pesquisa. Use para pesquisa com usuários, criação de personas, mapeamento de jornada e validação de design.
agents:
  - claude-code
---

# Pesquisador e Designer UX

Gerar personas de usuário a partir de dados de pesquisa, criar mapas de jornada, planejar testes de usabilidade e sintetizar descobertas de pesquisa em recomendações de design acionáveis.

---

## Sumário

- [Termos de Gatilho](#termos-de-gatilho)
- [Fluxos de Trabalho](#fluxos-de-trabalho)
  - [Fluxo de Trabalho 1: Gerar Persona de Usuário](#fluxo-de-trabalho-1-gerar-persona-de-usuário)
  - [Fluxo de Trabalho 2: Criar Mapa de Jornada](#fluxo-de-trabalho-2-criar-mapa-de-jornada)
  - [Fluxo de Trabalho 3: Planejar Teste de Usabilidade](#fluxo-de-trabalho-3-planejar-teste-de-usabilidade)
  - [Fluxo de Trabalho 4: Sintetizar Pesquisa](#fluxo-de-trabalho-4-sintetizar-pesquisa)
- [Referência de Ferramentas](#referência-de-ferramentas)
- [Tabelas de Referência Rápida](#tabelas-de-referência-rápida)
- [Base de Conhecimento](#base-de-conhecimento)

---

## Termos de Gatilho

Use esta skill quando precisar:

- "criar persona de usuário"
- "gerar persona a partir de dados"
- "construir mapa de jornada do cliente"
- "mapear jornada do usuário"
- "planejar teste de usabilidade"
- "projetar estudo de usabilidade"
- "analisar pesquisa com usuários"
- "sintetizar descobertas de entrevistas"
- "identificar pontos de dor do usuário"
- "definir arquétipos de usuário"
- "calcular tamanho de amostra de pesquisa"
- "criar mapa de empatia"
- "identificar necessidades do usuário"

---

## Fluxos de Trabalho

### Fluxo de Trabalho 1: Gerar Persona de Usuário

**Situação:** Você tem dados de usuário (analytics, pesquisas, entrevistas) e precisa criar uma persona baseada em pesquisa.

**Etapas:**

1. **Preparar dados de usuário**

   Formato necessário (JSON):
   ```json
   [
     {
       "user_id": "user_1",
       "age": 32,
       "usage_frequency": "daily",
       "features_used": ["dashboard", "reports", "export"],
       "primary_device": "desktop",
       "usage_context": "work",
       "tech_proficiency": 7,
       "pain_points": ["slow loading", "confusing UI"]
     }
   ]
   ```

2. **Executar gerador de personas**
   ```bash
   # Saída legível por humanos
   python scripts/persona_generator.py

   # Saída JSON para integração
   python scripts/persona_generator.py json
   ```

3. **Revisar componentes gerados**

   | Componente | O que Verificar |
   |------------|----------------|
   | Arquétipo | Corresponde aos padrões de dados? |
   | Dados demográficos | São derivados de dados reais? |
   | Objetivos | São específicos e acionáveis? |
   | Frustrações | Incluem contagens de frequência? |
   | Implicações de design | Os designers podem agir com base nisso? |

4. **Validar persona**

   - Mostrar a 3-5 usuários reais: "Isso soa como você?"
   - Verificar com tickets de suporte
   - Verificar contra dados de analytics

5. **Referência:** Veja `references/persona-methodology.md` para critérios de validade

---

### Fluxo de Trabalho 2: Criar Mapa de Jornada

**Situação:** Você precisa visualizar a experiência do usuário de ponta a ponta para um objetivo específico.

**Etapas:**

1. **Definir escopo**

   | Elemento | Descrição |
   |----------|-----------|
   | Persona | Qual tipo de usuário |
   | Objetivo | O que estão tentando alcançar |
   | Início | Gatilho que inicia a jornada |
   | Fim | Critérios de sucesso |
   | Prazo | Horas/dias/semanas |

2. **Coletar dados da jornada**

   Fontes:
   - Entrevistas com usuários (peça "me guie por...")
   - Gravações de sessão
   - Analytics (funil, pontos de abandono)
   - Tickets de suporte

3. **Mapear as etapas**

   Etapas típicas de SaaS B2B:
   ```
   Conscientização → Avaliação → Onboarding → Adoção → Defesa
   ```

4. **Preencher camadas para cada etapa**

   ```
   Etapa: [Nome]
   ├── Ações: O que o usuário faz?
   ├── Pontos de contato: Onde eles interagem?
   ├── Emoções: Como se sentem? (1-5)
   ├── Pontos de dor: O que os frustra?
   └── Oportunidades: Onde podemos melhorar?
   ```

5. **Identificar oportunidades**

   Pontuação de Prioridade = Frequência × Severidade × Resolubilidade

6. **Referência:** Veja `references/journey-mapping-guide.md` para templates

---

### Fluxo de Trabalho 3: Planejar Teste de Usabilidade

**Situação:** Você precisa validar um design com usuários reais.

**Etapas:**

1. **Definir questões de pesquisa**

   Transformar objetivos vagos em questões testáveis:

   | Vago | Testável |
   |------|----------|
   | "É fácil de usar?" | "Os usuários completam o checkout em <3 min?" |
   | "Os usuários gostam?" | "Os usuários escolherão o Design A ou B?" |
   | "Faz sentido?" | "Os usuários encontram configurações sem dicas?" |

2. **Selecionar método**

   | Método | Participantes | Duração | Melhor Para |
   |--------|---------------|---------|-------------|
   | Remoto moderado | 5-8 | 45-60 min | Insights profundos |
   | Remoto não moderado | 10-20 | 15-20 min | Validação rápida |
   | Guerrilha | 3-5 | 5-10 min | Feedback rápido |

3. **Projetar tarefas**

   Formato de boa tarefa:
   ```
   CENÁRIO: "Imagine que você está planejando uma viagem a Paris..."
   OBJETIVO: "Reserve um hotel por 3 noites dentro do seu orçamento."
   SUCESSO: "Você vê a página de confirmação."
   ```

   Progressão de tarefas: Aquecimento → Principal → Secundária → Caso extremo → Exploração livre

4. **Definir métricas de sucesso**

   | Métrica | Meta |
   |---------|------|
   | Taxa de conclusão | >80% |
   | Tempo na tarefa | <2× esperado |
   | Taxa de erro | <15% |
   | Satisfação | >4/5 |

5. **Preparar guia do moderador**

   - Instruções de pensar em voz alta
   - Prompts não tendenciosos
   - Perguntas pós-tarefa

6. **Referência:** Veja `references/usability-testing-frameworks.md` para guia completo

---

### Fluxo de Trabalho 4: Sintetizar Pesquisa

**Situação:** Você tem dados brutos de pesquisa (entrevistas, pesquisas, observações) e precisa de insights acionáveis.

**Etapas:**

1. **Codificar os dados**

   Etiquetar cada ponto de dados:
   - `[OBJETIVO]` - O que querem alcançar
   - `[DOR]` - O que os frustra
   - `[COMPORTAMENTO]` - O que realmente fazem
   - `[CONTEXTO]` - Quando/onde usam o produto
   - `[CITAÇÃO]` - Palavras diretas do usuário

2. **Agrupar padrões similares**

   ```
   Usuário A: Usa diariamente, funcionalidades avançadas, atalhos
   Usuário B: Usa diariamente, fluxos complexos, automação
   Usuário C: Usa semanalmente, necessidades básicas, ocasional

   Cluster 1: A, B (Power Users)
   Cluster 2: C (Usuário Casual)
   ```

3. **Calcular tamanhos de segmento**

   | Cluster | Usuários | % | Viabilidade |
   |---------|---------|---|-------------|
   | Power Users | 18 | 36% | Persona primária |
   | Usuários de Negócio | 15 | 30% | Persona primária |
   | Usuários Casuais | 12 | 24% | Persona secundária |

4. **Extrair descobertas principais**

   Para cada tema:
   - Declaração da descoberta
   - Evidências de suporte (citações, dados)
   - Frequência (X/Y participantes)
   - Impacto de negócio
   - Recomendação

5. **Priorizar oportunidades**

   | Fator | Pontuação 1-5 |
   |-------|---------------|
   | Frequência | Com que frequência isso ocorre? |
   | Severidade | Quanto isso prejudica? |
   | Abrangência | Quantos usuários são afetados? |
   | Resolubilidade | Podemos corrigir isso? |

6. **Referência:** Veja `references/persona-methodology.md` para framework de análise

---

## Referência de Ferramentas

### persona_generator.py

Gera personas orientadas por dados a partir de dados de pesquisa com usuários.

| Argumento | Valores | Padrão | Descrição |
|-----------|---------|--------|-----------|
| format | (nenhum), json | (nenhum) | Formato de saída |

**Exemplo de Saída:**

```
============================================================
PERSONA: Alex the Power User
============================================================

📝 A daily user who primarily uses the product for work purposes

Archetype: Power User
Quote: "I need tools that can keep up with my workflow"

👤 Demographics:
  • Age Range: 25-34
  • Location Type: Urban
  • Tech Proficiency: Advanced

🎯 Goals & Needs:
  • Complete tasks efficiently
  • Automate workflows
  • Access advanced features

😤 Frustrations:
  • Slow loading times (14/20 users)
  • No keyboard shortcuts
  • Limited API access

💡 Design Implications:
  → Optimize for speed and efficiency
  → Provide keyboard shortcuts and power features
  → Expose API and automation capabilities

📈 Data: Based on 45 users
    Confidence: High
```

**Arquétipos Gerados:**

| Arquétipo | Sinais | Foco de Design |
|-----------|--------|----------------|
| power_user | Uso diário, 10+ funcionalidades | Eficiência, customização |
| casual_user | Uso semanal, 3-5 funcionalidades | Simplicidade, orientação |
| business_user | Contexto de trabalho, uso em equipe | Colaboração, relatórios |
| mobile_first | Mobile primário | Toque, offline, velocidade |

**Componentes de Saída:**

| Componente | Descrição |
|------------|-----------|
| demographics | Faixa etária, localização, ocupação, nível técnico |
| psychographics | Motivações, valores, atitudes, estilo de vida |
| behaviors | Padrões de uso, preferências de funcionalidades |
| needs_and_goals | Primárias, secundárias, funcionais, emocionais |
| frustrations | Pontos de dor com evidências |
| scenarios | Histórias de uso contextual |
| design_implications | Recomendações acionáveis |
| data_points | Tamanho da amostra, nível de confiança |

---

## Tabelas de Referência Rápida

### Seleção de Método de Pesquisa

| Tipo de Pergunta | Melhor Método | Tamanho de Amostra |
|------------------|---------------|-------------------|
| "O que os usuários fazem?" | Analytics, observação | 100+ eventos |
| "Por que fazem?" | Entrevistas | 8-15 usuários |
| "Quão bem conseguem fazer?" | Teste de usabilidade | 5-8 usuários |
| "O que preferem?" | Pesquisa, teste A/B | 50+ usuários |
| "Como se sentem?" | Estudo de diário, entrevistas | 10-15 usuários |

### Níveis de Confiança de Persona

| Tamanho da Amostra | Confiança | Caso de Uso |
|--------------------|-----------|-------------|
| 5-10 usuários | Baixa | Exploratório |
| 11-30 usuários | Média | Direcional |
| 31+ usuários | Alta | Produção |

### Severidade de Problema de Usabilidade

| Severidade | Definição | Ação |
|------------|-----------|------|
| 4 - Crítico | Impede a conclusão da tarefa | Corrigir imediatamente |
| 3 - Maior | Dificuldade significativa | Corrigir antes do lançamento |
| 2 - Menor | Causa hesitação | Corrigir quando possível |
| 1 - Cosmético | Notado mas não problemático | Baixa prioridade |

### Tipos de Pergunta de Entrevista

| Tipo | Exemplo | Para Usar |
|------|---------|-----------|
| Contexto | "Me guie pelo seu dia típico" | Entender o ambiente |
| Comportamento | "Me mostre como você faz X" | Observar ações reais |
| Objetivos | "O que você está tentando alcançar?" | Descobrir motivações |
| Dor | "Qual é a parte mais difícil?" | Identificar frustrações |
| Reflexão | "O que você mudaria?" | Gerar ideias |

---

## Base de Conhecimento

Guias de referência detalhados em `references/`:

| Arquivo | Conteúdo |
|---------|----------|
| `persona-methodology.md` | Critérios de validade, coleta de dados, framework de análise |
| `journey-mapping-guide.md` | Processo de mapeamento, templates, identificação de oportunidades |
| `example-personas.md` | 3 exemplos completos de personas com dados |
| `usability-testing-frameworks.md` | Planejamento de teste, design de tarefas, análise |

---

## Lista de Verificação de Validação

### Qualidade de Persona
- [ ] Baseada em 20+ usuários (mínimo)
- [ ] Pelo menos 2 fontes de dados (quantitativo + qualitativo)
- [ ] Objetivos específicos e acionáveis
- [ ] Frustrações incluem contagens de frequência
- [ ] Implicações de design são específicas
- [ ] Nível de confiança declarado

### Qualidade do Mapa de Jornada
- [ ] Escopo claramente definido (persona, objetivo, prazo)
- [ ] Baseado em dados reais de usuário, não suposições
- [ ] Todas as camadas preenchidas (ações, pontos de contato, emoções)
- [ ] Pontos de dor identificados por etapa
- [ ] Oportunidades priorizadas

### Qualidade do Teste de Usabilidade
- [ ] As questões de pesquisa são testáveis
- [ ] As tarefas são cenários realistas, não instruções
- [ ] 5+ participantes por design
- [ ] Métricas de sucesso definidas
- [ ] Descobertas incluem avaliações de severidade

### Qualidade da Síntese de Pesquisa
- [ ] Dados codificados consistentemente
- [ ] Padrões baseados em 3+ pontos de dados
- [ ] Descobertas incluem evidências
- [ ] Recomendações são acionáveis
- [ ] Prioridades justificadas

## Skills Relacionadas

- **Sistema de UI Design** (`product-team/ui-design-system/`) — Descobertas de pesquisa informam decisões do sistema de design
- **Kit de Ferramentas para Gerente de Produto** (`product-team/product-manager-toolkit/`) — A análise de entrevistas com clientes complementa a pesquisa de personas
