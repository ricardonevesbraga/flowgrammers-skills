---
name: "c-level-advisor"
description: "10 skills de assessoria C-level e plugins para Claude Code. CEO, CTO, COO, CPO, CMO, CFO, CRO, CISO, CHRO, Mentor Executivo. Reuniões de conselho com múltiplos papéis, roteamento estratégico e recomendações estruturadas. Para fundadores que precisam de suporte executivo para tomada de decisões."
license: MIT
metadata:
  version: 2.0.0
  author: Ric Neves - Flowgrammers
  category: c-level
  domain: executive-advisory
  updated: 2026-03-05
  skills_count: 28
  scripts_count: 25
  references_count: 52
agents:
  - claude-code
---

# Ecossistema de Assessoria C-Level

Um conselho de administração virtual completo para fundadores e executivos.

## Início Rápido

```
1. Execute /cs:setup → cria company-context.md (todos os agentes leem este arquivo)
   ✓ Verifique se company-context.md foi criado e contém o nome da empresa,
     estágio e métricas principais antes de prosseguir.
2. Faça qualquer pergunta estratégica → O Chief of Staff roteia para o papel certo
3. Para grandes decisões → /cs:board aciona uma reunião de conselho com múltiplos papéis
   ✓ Confirme que pelo menos 3 papéis se manifestaram antes de aceitar uma conclusão.
```

### Comandos

#### `/cs:setup` — Questionário de Onboarding

Conduz o fundador por meio das perguntas abaixo e escreve `company-context.md` na raiz do projeto. Execute uma vez por empresa ou quando o contexto mudar significativamente.

```
Q1. Qual é o nome da sua empresa e uma descrição em uma linha?
Q2. Em que estágio você está? (Ideia / Pré-seed / Seed / Série A / Série B+)
Q3. Qual é seu ARR (ou MRR) atual e o runway em meses?
Q4. Qual é o tamanho e a estrutura do seu time?
Q5. Qual setor e segmento de clientes você atende?
Q6. Quais são suas 3 prioridades principais para os próximos 90 dias?
Q7. Qual é seu maior risco ou bloqueador atual?
```

Após coletar as respostas, o agente escreve a saída estruturada:

```markdown
# Contexto da Empresa
- Nome: <resposta>
- Estágio: <resposta>
- Setor: <resposta>
- Tamanho do time: <resposta>
- Métricas principais: <ARR/MRR, taxa de crescimento, runway>
- Prioridades principais: <resposta>
- Riscos principais: <resposta>
```

#### `/cs:board` — Reunião de Conselho Completa

Reúne todos os papéis executivos relevantes em três fases:

```
Fase 1 — Enquadramento:   O Chief of Staff apresenta a decisão e os critérios de sucesso.
Fase 2 — Isolamento:      Cada papel produz análise independente (sem contaminação cruzada).
Fase 3 — Debate:          Os papéis expõem conflitos, testam premissas e alinham em uma
                           recomendação. Visões divergentes são preservadas no registro.
```

Use para decisões de alto impacto ou multifuncionais. Confirme que pelo menos 3 papéis se manifestaram antes de aceitar uma conclusão.

### Matriz de Roteamento do Chief of Staff

Quando uma pergunta chega sem prefixo de papel, o Chief of Staff a mapeia para o executivo adequado usando estes sinais principais:

| Sinal do Tópico | Papel Principal | Papéis de Apoio |
|---|---|---|
| Captação de recursos, valuation, burn | CFO | CEO, CRO |
| Arquitetura, build vs. buy, dívida técnica | CTO | CPO, CISO |
| Contratação, cultura, desempenho | CHRO | CEO, Mentor Executivo |
| GTM, geração de demanda, posicionamento | CMO | CRO, CPO |
| Receita, pipeline, motion de vendas | CRO | CMO, CFO |
| Segurança, compliance, risco | CISO | CTO, CFO |
| Roadmap de produto, priorização | CPO | CTO, CMO |
| Operações, processos, escala | COO | CFO, CHRO |
| Visão, estratégia, relações com investidores | CEO | Mentor Executivo |
| Carreira, psicologia do fundador, liderança | Mentor Executivo | CEO, CHRO |
| Multidomain / indefinido | Chief of Staff convoca o conselho | Todos os papéis relevantes |

### Invocando um Papel Específico Diretamente

Para ignorar o roteamento do Chief of Staff e falar diretamente com um executivo, prefixe sua pergunta com o nome do papel:

```
CFO: Qual é nossa taxa de burn ideal antes de uma Série A?
CTO: Devemos reconstruir nossa camada de autenticação internamente ou comprar uma solução?
CHRO: Como desenhamos um processo de avaliação de desempenho para um time de 15 pessoas?
```

O Chief of Staff ainda registra a troca; apenas o roteamento é ignorado.

### Exemplo: Pergunta Estratégica

**Input:** "Devemos captar uma Série A agora ou estender o runway e crescer o ARR primeiro?"

**Formato de saída:**
- **Conclusão:** Estenda o runway por 6 meses; capte com ARR de R$2M para melhores termos.
- **O quê:** O ARR atual de R$800K está abaixo do limiar que a maioria dos investidores de Série A usa como referência.
- **Por quê:** Captar agora aumenta o risco de diluição; a extensão de 6 meses é alcançável com o burn atual.
- **Como agir:** Corte 2 canais de baixo ROI, atinja R$2M de ARR e então execute um sprint de captação de 6 semanas.
- **Sua decisão:** Prosseguir com a extensão / Captar agora mesmo (escolha uma).

### Exemplo: company-context.md (após /cs:setup)

```markdown
# Contexto da Empresa
- Nome: Acme Inc.
- Estágio: Seed (ARR R$800K)
- Setor: B2B SaaS
- Tamanho do time: 12
- Métricas principais: 15% de crescimento MoM, runway de 18 meses
- Prioridades principais: prontidão para Série A, GTM enterprise
```

## O Que Está Incluído

### 10 Papéis do C-Suite
CEO, CTO, COO, CPO, CMO, CFO, CRO, CISO, CHRO, Mentor Executivo

### 6 Skills de Orquestração
Onboarding do Fundador, Chief of Staff (roteador), Reunião de Conselho, Registrador de Decisões, Protocolo de Agentes, Motor de Contexto

### 6 Capacidades Transversais
Construtor de Deck para o Conselho, Sala de Guerra de Cenários, Inteligência Competitiva, Diagnóstico de Saúde Organizacional, Playbook de M&A, Expansão Internacional

### 6 Cultura e Colaboração
Arquiteto de Cultura, OS da Empresa, Coach do Fundador, Alinhamento Estratégico, Gestão de Mudanças, Narrativa Interna

## Funcionalidades Principais

- **Loop de Qualidade Interno:** Auto-verificação → verificação por pares → pré-triagem crítica → apresentação
- **Memória em Duas Camadas:** Transcrições brutas + apenas decisões aprovadas (evita consenso alucinado)
- **Isolamento na Reunião de Conselho:** Análise independente na Fase 2 antes do debate cruzado
- **Gatilhos Proativos:** Alertas antecipados orientados por contexto sem precisar perguntar
- **Saída Estruturada:** Conclusão → O Quê → Por Quê → Como Agir → Sua Decisão
- **25 Ferramentas Python:** Todas somente stdlib, CLI-first, saída em JSON, zero dependências

## Veja Também

- `CLAUDE.md` — diagrama completo de arquitetura e guia de integração
- `agent-protocol/SKILL.md` — padrão de comunicação e detalhes do loop de qualidade
- `chief-of-staff/SKILL.md` — matriz de roteamento para todos os 28 skills
