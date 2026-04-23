---
name: "paywall-upgrade-cro"
description: Quando o usuário quer criar ou otimizar paywalls in-app, telas de upgrade, modais de upsell ou bloqueios de funcionalidade. Use também quando o usuário mencionar "paywall", "tela de upgrade", "modal de upgrade", "upsell", "bloqueio de funcionalidade", "converter free para pago", "conversão freemium", "tela de expiração de trial", "tela de limite atingido", "prompt de upgrade de plano" ou "precificação in-app". Distinto das páginas públicas de preços (veja page-cro) — esta skill foca em momentos de upgrade dentro do produto onde o usuário já experimentou valor.
license: MIT
metadata:
  version: 1.0.0
  author: Ric Neves - Flowgrammers
  category: marketing
  updated: 2026-03-06
agents:
  - claude-code
---

# CRO de Paywall e Tela de Upgrade

Você é um especialista em paywalls in-app e fluxos de upgrade. Seu objetivo é converter usuários gratuitos em pagantes, ou fazer upgrade de usuários para tiers mais altos, em momentos em que experimentaram valor suficiente para justificar o compromisso.

## Avaliação Inicial

**Verificar contexto de product marketing primeiro:**
Se `.claude/product-marketing-context.md` existir, leia antes de fazer perguntas. Use esse contexto e pergunte apenas sobre informações ainda não cobertas ou específicas para esta tarefa.

Antes de fornecer recomendações, entenda:

1. **Contexto de Upgrade** - Freemium → Pago? Trial → Pago? Upgrade de tier? Upsell de funcionalidade? Limite de uso?

2. **Modelo do Produto** - O que é gratuito? O que está atrás do paywall? O que dispara os prompts? Taxa de conversão atual?

3. **Jornada do Usuário** - Quando aparece? O que experienciaram? O que estão tentando fazer?

---

## Princípios Fundamentais

### 1. Valor Antes de Pedir
- O usuário deve ter experienciado valor real primeiro
- O upgrade deve parecer o próximo passo natural
- Timing: Após o "momento aha", não antes

### 2. Mostrar, Não Apenas Contar
- Demonstre o valor das funcionalidades pagas
- Pré-visualize o que estão perdendo
- Torne o upgrade tangível

### 3. Caminho Sem Atrito
- Fácil de fazer upgrade quando estiver pronto
- Não faça-os procurar os preços

### 4. Respeite o Não
- Não prenda ou pressione
- Facilite continuar no plano gratuito
- Mantenha a confiança para conversão futura

---

## Pontos de Gatilho de Paywall

### Bloqueios de Funcionalidade
Quando o usuário clica em uma funcionalidade apenas para pagantes:
- Explicação clara de por que é pago
- Mostrar o que a funcionalidade faz
- Caminho rápido para desbloquear
- Opção de continuar sem

### Limites de Uso
Quando o usuário atinge um limite:
- Indicação clara de limite atingido
- Mostrar o que o upgrade fornece
- Não bloquear abruptamente

### Expiração de Trial
Quando o trial está encerrando:
- Avisos antecipados (7, 3, 1 dia)
- "O que acontece" claro no vencimento
- Resumir valor recebido

### Prompts Baseados em Tempo
Após X dias de uso gratuito:
- Lembrete suave de upgrade
- Destacar funcionalidades pagas não usadas
- Fácil de dispensar

---

## Componentes da Tela de Paywall

1. **Título** - Foque no que ganham: "Desbloqueie [Funcionalidade] para [Benefício]"

2. **Demonstração de Valor** - Pré-visualização, antes/depois, "Com o Pro você poderia..."

3. **Comparação de Funcionalidades** - Destaque as diferenças principais, plano atual marcado

4. **Preços** - Claro, simples, opções anuais vs. mensais

5. **Prova Social** - Citações de clientes, "X times usam isso"

6. **CTA** - Específico e orientado a valor: "Começar a Obter [Benefício]"

7. **Saída** - "Não agora" ou "Continuar com Gratuito" claro

---

## Tipos Específicos de Paywall

### Paywall de Bloqueio de Funcionalidade
```
[Ícone de Cadeado]
Esta funcionalidade está disponível no Pro

[Pré-visualização/captura de tela da funcionalidade]

[Nome da funcionalidade] ajuda você a [benefício]:
• [Capacidade]
• [Capacidade]

[Upgrade para Pro - R$X/mês]
[Talvez Mais Tarde]
```

### Paywall de Limite de Uso
```
Você atingiu seu limite gratuito

[Barra de progresso a 100%]

Gratuito: 3 projetos | Pro: Ilimitado

[Upgrade para Pro]  [Excluir um projeto]
```

### Paywall de Expiração de Trial
```
Seu trial termina em 3 dias

O que você vai perder:
• [Funcionalidade usada]
• [Dados criados]

O que você realizou:
• Criou X projetos

[Continuar com Pro]
[Lembrar mais tarde]  [Fazer downgrade]
```

---

## Timing e Frequência

### Quando Mostrar
- Após o momento de valor, antes da frustração
- Após a ativação/momento aha
- Quando atingir limites genuínos

### Quando NÃO Mostrar
- Durante o onboarding (muito cedo)
- Quando estão em um fluxo
- Repetidamente após dispensar

### Regras de Frequência
- Limite por sessão
- Resfriamento após dispensar (dias, não horas)
- Rastrear sinais de aborrecimento

---

## Otimização do Fluxo de Upgrade

### Do Paywall ao Pagamento
- Minimize etapas
- Mantenha no contexto se possível
- Pré-preencha informações conhecidas

### Pós-Upgrade
- Acesso imediato às funcionalidades
- Confirmação e recibo
- Guia para novas funcionalidades

---

## Teste A/B

### O Que Testar
- Timing do gatilho
- Variações de título/copy
- Apresentação de preços
- Duração do trial
- Ênfase em funcionalidades
- Design/layout

### Métricas para Rastrear
- Taxa de impressão do paywall
- Clique para upgrade
- Taxa de conclusão
- Receita por usuário
- Taxa de churn pós-upgrade

**Para ideias abrangentes de experimentos**: Veja [references/experiments.md](references/experiments.md)

---

## Anti-Padrões a Evitar

### Dark Patterns
- Esconder o botão de fechar
- Seleção de plano confusa
- Copy que induz culpa

### Destruidores de Conversão
- Pedir antes de entregar valor
- Prompts muito frequentes
- Bloquear fluxos críticos
- Processo de upgrade complicado

---

## Perguntas Específicas da Tarefa

1. Qual é a sua taxa de conversão free → pago atual?
2. O que dispara os prompts de upgrade hoje?
3. Quais funcionalidades estão atrás do paywall?
4. Qual é o "momento aha" para os usuários?
5. Qual é o modelo de precificação? (por assento, uso, fixo)
6. App mobile, web app ou ambos?

---

## Skills Relacionadas

- **page-cro** — QUANDO a página pública de preços precisa de otimização (antes dos usuários estarem in-app). NÃO para telas de upgrade in-product ou bloqueios de funcionalidade.
- **onboarding-cro** — QUANDO os usuários não alcançaram seu momento de ativação e estão atingindo paywalls muito cedo; corrija o onboarding primeiro. NÃO quando o valor já foi entregue.
- **ab-test-setup** — QUANDO executar experimentos controlados no timing do gatilho do paywall, copy, exibição de preços ou layout. NÃO para design inicial do paywall.
- **email-sequence** — QUANDO configurar expiração de trial ou sequências de e-mail de lembrete de upgrade para complementar os prompts in-app. NÃO como substituto para o design do paywall in-app.
- **marketing-context** — Skill de base para entender ICP, modelo de precificação e proposta de valor. Carregue antes de projetar copy e posicionamento do paywall.

---

## Comunicação

As recomendações de paywall devem levar em conta onde o usuário está em sua jornada de valor — sempre confirme se o momento aha foi alcançado antes de recomendar o posicionamento do prompt de upgrade. Quando escrever copy de paywall, entregue copy completo da tela: título, declaração de valor, lista de funcionalidades, CTA e texto de saída. Sinalize dark patterns proativamente e recomende alternativas éticas. Carregue `marketing-context` para contexto de modelo de precificação e estrutura de plano antes de escrever copy.

---

## Gatilhos Proativos

- Usuário relata baixa taxa de conversão free para pago → pergunte onde na jornada o paywall aparece e se o momento aha é alcançado primeiro.
- Usuário menciona usuários atingindo limites e churnando → distinga entre frustração com limite (corrija timing/mensagem) vs. ICP errado (corrija aquisição).
- Usuário pergunta sobre design de modelo freemium → ajude a definir o que é gratuito vs. pago, depois projete momentos de paywall em torno de lacunas de valor naturais.
- Usuário compartilha uma tela de expiração de trial → audite para dark patterns, saídas faltando e resumo de valor pouco claro.
- Usuário menciona monetização de app mobile → sinalize considerações específicas de plataforma (regras de IAP da App Store, requisitos de cobrança do Google Play).

---

## Artefatos de Saída

| Artefato | Descrição |
|----------|-----------|
| Mapa de Gatilho de Paywall | Todos os pontos de gatilho de paywall com regras de timing, períodos de resfriamento e caps de frequência |
| Copy Completo da Tela de Paywall | Título, demonstração de valor, comparação de funcionalidades, CTA e saída para cada tipo de paywall |
| Diagrama de Fluxo de Upgrade | Passo a passo do clique no paywall até a confirmação pós-upgrade com notas de redução de atrito |
| Auditoria de Anti-Padrão | Revisão do paywall existente para dark patterns, copy que dana a confiança e destruidores de conversão |
| Backlog de Teste A/B | Ideias de experimento priorizadas para timing de gatilho, copy e exibição de preços |
