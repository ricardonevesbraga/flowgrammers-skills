---
name: "caio-advisor"
description: "Assessor de Chief AI Officer (CAIO) para estratégia de IA corporativa, governança de IA, build vs. buy, plataforma de ML, AI safety, ROI e conformidade regulatória (LGPD, AI Act, PL 2338/23 Brasil). Use ao definir estratégia de IA, priorizar casos de uso, estruturar time de IA, governar modelos em produção, preparar apresentações para o conselho sobre IA ou quando o usuário mencionar CAIO, Chief AI Officer, estratégia de IA, IA generativa corporativa, AI governance, LLMOps, responsible AI ou AI Act."
license: MIT
metadata:
  version: 1.0.0
  author: Ric Neves - Flowgrammers
  category: c-level
  domain: ai-leadership
  updated: 2026-04-23
agents:
  - claude-code
---

# Assessor de CAIO (Chief AI Officer)

Frameworks para liderança de IA corporativa: estratégia, governança, plataforma, segurança, ROI e conformidade regulatória no contexto brasileiro.

## Palavras-chave
CAIO, Chief AI Officer, estratégia de IA, IA corporativa, IA generativa, LLM, LLMOps, MLOps, AI governance, responsible AI, AI safety, AI Act, PL 2338/23, Marco Legal da IA, LGPD, build vs buy, ROI de IA, copilots, agentes

## Responsabilidades Principais

### 1. Estratégia de IA Corporativa
IA sem estratégia vira pilha de POCs abandonadas. O CAIO conecta IA à estratégia de negócios.

**Framework 3 horizontes:**
- **H1 (0-6m)**: Produtividade interna — copilots, atendimento, busca interna
- **H2 (6-18m)**: Produtos existentes — features de IA, personalização, automação
- **H3 (18-36m)**: Modelos de negócio novos — IA como produto, agentes autônomos

**Princípios:**
- IA não é estratégia. Resultado de negócio é.
- Priorize por valor × viabilidade × risco
- Construa plataforma uma vez, use em N casos
- Meça ROI em todos os casos — mate o que não performa

### 2. Priorização de Casos de Uso
Nem todo problema merece IA. Use o framework VUR:

**V — Valor**
- Receita incremental ou custo reduzido
- Quantifique em R$/ano (não em "eficiência")
- Verifique com dono de P&L antes de investir

**U — Usabilidade (Viabilidade)**
- Dados disponíveis, limpos, com volume suficiente?
- Tolerância a erro (crítico = menos IA, mais humano no loop)
- Integração com sistemas legados

**R — Risco**
- Regulatório (LGPD, setorial — ANVISA, BACEN, CVM)
- Reputacional (alucinação, viés, privacidade)
- Operacional (degradação, concept drift, dependência de fornecedor)

**Scorecard:** cada dimensão de 1-5. Priorize os casos >= 12/15.

### 3. Build vs. Buy vs. Partner
Framework decisório:

| Critério | Build | Buy (SaaS) | Partner |
|----------|-------|------------|---------|
| Diferenciação competitiva | Alta | Baixa | Média |
| Dados sensíveis/proprietários | Sim | Não | Depende |
| Escala de uso | Alto volume | Início/baixo | Pilotos |
| Time interno | Sênior + estável | Qualquer | Híbrido |
| Time-to-value | 6-12m | 2-4 semanas | 1-3m |

**Regra:** compre comodities (tradução, transcrição), construa diferencial (modelos com seus dados proprietários).

### 4. Governança de IA
No Brasil, o PL 2338/23 (Marco Legal da IA) classifica sistemas por risco. Combine com LGPD e setoriais.

**Estrutura mínima:**
- **Comitê de IA**: CAIO (líder), CTO, CISO, DPO, Jurídico, Negócios (rotativo)
- **Registro de IA**: todo modelo em produção cadastrado (propósito, dados, dono, risco)
- **Política de uso responsável**: o que pode/não pode ser construído
- **Review process**: alto risco requer aprovação do comitê antes de produção

**Dimensões de AI Responsável:**
- Transparência (explicabilidade proporcional ao risco)
- Equidade (auditoria de viés demográfico)
- Privacidade (minimização, anonimização, base legal LGPD)
- Robustez (testes adversariais, monitoramento de drift)
- Responsabilidade (logs, auditabilidade, dono identificado)

### 5. Plataforma de IA e Time
Não deixe cada time reinventar a roda.

**Stack mínimo:**
- **Camada de modelos**: Gateway unificado (multi-provedor), fallbacks, caching
- **Camada de dados**: Feature store, vector DB, retrieval
- **Camada de aplicação**: SDK interno, prompts versionados, guardrails
- **Camada de observabilidade**: Tracing, avaliações, custos, alertas
- **Camada de segurança**: PII filtering, jailbreak detection, auditoria

**Estrutura de time (referência para empresa mid-market):**
- Platform Team (3-5 pessoas): infra e SDK
- Applied AI Team (por linha de negócio): casos de uso
- Governance (1-2 pessoas): políticas, auditoria, compliance
- Research (opcional): novos modelos, otimização

### 6. Medição de ROI
Se você não mede, não é estratégia — é hobby caro.

**Métricas por categoria:**
- **Copilot interno**: % adoção, minutos economizados/semana × custo hora
- **Atendimento IA**: % resolução sem humano × custo atendimento tradicional
- **IA em produto**: conversão, retenção, NPS
- **Redução de custo**: headcount evitado, FTE equivalente

**Alerta:** Custo total deve incluir API, infra, dados, engenharia, governança. LLMs parecem baratos até o scale.

## Perguntas-Chave que um CAIO Faz

- "Qual é o pior dano que nossa IA pode causar — e estamos protegidos?"
- "Estamos construindo capacidade ou acumulando fornecedores?"
- "Nossos dados proprietários estão trabalhando para nós ou dormindo?"
- "Se o provedor X sumir amanhã, o que acontece com nossos produtos?"
- "Qual caso de uso devemos matar para focar no que funciona?"

## Board Deck do CAIO (trimestral)

1. **Valor entregue**: R$ capturado por iniciativa
2. **Portfolio**: pipeline de casos (H1/H2/H3)
3. **Plataforma**: capacidades construídas, dívida técnica
4. **Governança**: incidentes, auditorias, regulatório
5. **Talento**: headcount, custo, retenção
6. **Riscos**: top 3 e planos de mitigação
7. **Decisões necessárias**: o que precisa do conselho

## Integração com Outros Papéis

| Papel | Interface |
|-------|-----------|
| CEO | Estratégia, narrativa de mercado |
| CTO | Infra, engenharia, reuso |
| CDO | Dados, qualidade, feature store |
| CISO | Segurança, auditoria, red team |
| CFO | ROI, CapEx vs. OpEx, unit economics |
| CPO | Roadmap de produto com IA |
| CLO | Conformidade regulatória, contratos |

## Veja Também

- `cto-advisor/` — arquitetura técnica
- `cdo-advisor/` — estratégia de dados
- `ciso-advisor/` — segurança (ISO 27001)
- `../engineering/rag-architect/` — RAG corporativo
- `../engineering/mcp-server-builder/` — integração de agentes
- `../engineering-team/ai-security/` — segurança de IA
- `../engineering-team/senior-ml-engineer/` — execução técnica
