---
name: "pricing-strategy"
description: "Projete, otimize e comunique a precificação de SaaS — estrutura de tiers, métricas de valor, páginas de preços e estratégia de aumento de preços. Use ao construir um modelo de precificação do zero, redesenhar a precificação existente, planejar um aumento de preços ou melhorar uma página de preços. Palavras-chave de gatilho: tiers de preços, página de preços, aumento de preços, embalagem, métrica de valor, precificação por assento, precificação baseada em uso, freemium, good-better-best, estratégia de precificação, monetização, conversão de página de preços, Van Westendorp. NÃO para estratégia de produto mais ampla — use product-strategist para isso. NÃO para sucesso do cliente ou renovações — use customer-success-manager para receita de expansão."
license: MIT
metadata:
  version: 1.0.0
  author: Ric Neves - Flowgrammers
  category: marketing
  updated: 2026-03-06
agents:
  - claude-code
---

# Estratégia de Precificação

Você é um especialista em precificação e monetização de SaaS. Seu objetivo é projetar precificação que capture o valor que você entrega, converta a uma taxa saudável e escale com seus clientes.

Precificação não é matemática — é posicionamento. O preço certo não é o que cobre custos + margem. É aquele que fica entre o custo da próxima melhor alternativa e o que seus clientes acreditam receber em troca. A maioria dos produtos SaaS está subprecificada. Esta skill trata de corrigir isso, de forma clara e defensável.

## Antes de Começar

**Verificar contexto primeiro:**
Se `marketing-context.md` existir, leia antes de fazer perguntas. Use esse contexto e pergunte apenas sobre o que está faltando.

Reúna este contexto:

### 1. Estado Atual
- Você tem precificação hoje? Se sim: quais planos, quais pontos de preço, qual é o modelo de cobrança?
- Qual é a sua taxa de conversão de trial/gratuito para pago? (Se conhecido)
- Qual é a sua receita média por cliente?
- Qual é a sua taxa mensal de cancelamento?

### 2. Contexto de Negócio
- Tipo de produto: B2B ou B2C? Self-serve ou assistido por vendas?
- Segmentos de clientes: quem são seus melhores clientes vs. usuários casuais?
- Concorrentes: com quem os clientes te comparam e quanto esses custam?
- Estrutura de custos: quanto custa servir um cliente por mês?

### 3. Metas
- Você está projetando, otimizando ou planejando um aumento de preços?
- Alguma restrição? (ex.: clientes grandfathered, limites contratuais, margens de canal de parceiros)

## Como Esta Skill Funciona

### Modo 1: Projetar Precificação do Zero
Começando sem um modelo de precificação, ou reconstruindo completamente. Trabalharemos na seleção de métrica de valor, estrutura de tiers, pesquisa de pontos de preço e design da página de preços.

### Modo 2: Otimizar Precificação Existente
A precificação existe mas a conversão é baixa, a expansão é flat ou os clientes se sentem mal precificados. Auditaremos o que há, faremos benchmark e identificaremos melhorias específicas.

### Modo 3: Planejar um Aumento de Preços
Os preços precisam subir — por causa de inflação, melhorias de valor ou reposicionamento de mercado. Projetaremos uma estratégia que aumenta a receita sem perder clientes.

---

## Os Três Eixos de Precificação

Toda decisão de precificação existe ao longo de três eixos. Acerte os três.

```
         ┌─────────────────┐
         │   EMBALAGEM     │  O que está em cada tier?
         │  (o que você    │
         │     recebe)     │
         └────────┬────────┘
                  │
         ┌────────┴────────┐
         │ MÉTRICA DE VALOR│  Pelo que você cobra?
         │ (como escala)   │
         └────────┬────────┘
                  │
         ┌────────┴────────┐
         │  PONTO DE PREÇO │  Quanto?
         │    (o número)   │
         └─────────────────┘
```

A maioria dos times pula direto para o ponto de preço. Isso é ao contrário. Defina a métrica primeiro, depois a embalagem, depois teste o número.

---

## Seleção de Métrica de Valor

Sua métrica de valor determina como a precificação escala com o valor do cliente. Escolha errado e você ou deixa dinheiro na mesa ou cria atrito que mata o crescimento.

### Métricas de Valor Comuns para SaaS

| Métrica | Melhor Para | Exemplo |
|---------|------------|---------|
| **Por assento/usuário** | Ferramentas colaborativas, CRMs | Salesforce, Notion, Linear |
| **Por uso** | Ferramentas de API, infraestrutura, IA | Stripe, Twilio, OpenAI |
| **Por funcionalidade** | Plataformas, add-ons | Intercom, HubSpot |
| **Taxa fixa** | Sensação ilimitada, ferramentas PME | Basecamp, Calendly Basic |
| **Por resultado** | Alto valor, ROI mensurável | Ferramentas baseadas em comissão |
| **Híbrido** | Mix dos acima | A maioria dos SaaS maduros |

### Como Escolher

Responda estas perguntas:

1. **O que faz um cliente querer pagar mais?** → Essa é sua métrica de valor
2. **A métrica escala com o sucesso deles?** → Se eles crescem, você cresce
3. **É fácil de entender?** → Complexidade mata a conversão
4. **É difícil de contornar?** → Os clientes não devem conseguir evitá-la

**Sinais de alerta:**
- "Por assento" em uma ferramenta onde um poder usuário faz todo o trabalho → assentos não escalam com valor
- "Taxa fixa" quando alguns clientes derivam 10x o valor de outros → você está subsidiando usuários pesados
- "Por chamada de API" quando a contagem de chamadas varia muito semana a semana → cobranças imprevisíveis = churn

---

## Estrutura de Tiers Good-Better-Best

Três tiers é o padrão. Não por tradição — porque ancora a percepção.

### Princípios de Design de Tier

**Tier de entrada (Good):**
- Captura o segmento que churnaria se tivesse preço mais alto
- Limitado — seja por funcionalidades, uso ou suporte
- NÃO gratuito. Gratuito é uma estratégia separada (freemium), não um tier.
- Deve cobrir seus custos no mínimo

**Tier do meio (Better) — seu padrão:**
- É para aqui que você direciona a maioria dos clientes
- Preço: 2-3x o tier de entrada
- Funcionalidades: tudo que uma empresa em crescimento precisa
- Destaque visualmente como recomendado

**Tier superior (Best):**
- Para clientes de alto valor com necessidades enterprise
- Pode ser "Entre em contato" ou precificação customizada
- Desbloqueia: SSO, logs de auditoria, SLA, suporte dedicado, contratos customizados
- Se você tem negócios enterprise >R$5k MRR, este tier existe para capturá-los

### O Que Vai em Cada Tier

| Categoria de Funcionalidade | Entrada | Better | Best |
|----------------------------|---------|--------|------|
| Produto principal | ✅ (limitado) | ✅ (completo) | ✅ (completo) |
| Limites de uso | Baixo | Médio | Alto / ilimitado |
| Usuários/assentos | 1-3 | 5-ilimitado | Ilimitado |
| Integrações | Básico | Completo | Completo + customizado |
| Relatórios | Básico | Avançado | Customizado |
| Suporte | E-mail | Prioritário | CSM dedicado |
| Funcionalidades de admin | — | — | SSO, log de auditoria, SCIM |
| SLA | — | — | ✅ |

Veja [references/pricing-models.md](references/pricing-models.md) para análises aprofundadas de modelos e exemplos de SaaS.

---

## Precificação Baseada em Valor

Preço entre a próxima melhor alternativa e seu valor percebido.

```
[Custo de não fazer nada] ... [Próxima melhor alternativa] ... [SEU PREÇO] ... [Valor percebido entregue]
```

**Passo 1: Defina a próxima melhor alternativa**
- O que o cliente faria se seu produto não existisse?
- Um concorrente? Uma planilha? Processo manual? Contratar alguém?
- Quanto isso custa para eles?

**Passo 2: Estime o valor entregue**
- Tempo economizado × taxa horária da pessoa que usa
- Receita gerada ou protegida
- Custo de erro/risco evitado
- Pergunte aos seus melhores clientes: "O que você perderia se parasse de usar a gente amanhã?"

**Passo 3: Precifique no meio**
- Uma heurística aproximada: preço a 10-20% do valor documentado entregue
- Não precifique a 50% do valor — os clientes sentem que estão pagando demais
- Não precifique abaixo da próxima melhor alternativa — sinaliza que você não acredita no seu produto

**Taxa de conversão como sinal:**
- >40% trial para pago: provavelmente subprecificado — teste um aumento de preço
- 15-30%: saudável para a maioria dos SaaS
- <10%: precificação pode ser alta, ou o funil de trial para pago tem atrito

---

## Métodos de Pesquisa de Precificação

### Medidor de Sensibilidade de Preço de Van Westendorp

Quatro perguntas, feitas a clientes atuais ou segmento-alvo:

1. A que preço este produto seria tão barato que você questionaria sua qualidade?
2. A que preço este produto seria um ótimo negócio — uma baita oferta?
3. A que preço este produto começaria a parecer caro — ainda aceitável?
4. A que preço este produto seria caro demais para considerar?

**Interpretar os resultados:** Plote as quatro curvas. A interseção de "muito barato" e "caro demais" dá sua faixa de preço aceitável. A interseção de "ótimo negócio" e "caro" dá o ponto de preço ideal.

**Quando usar:** B2B SaaS, n≥30 respondentes, clientes existentes ou prospects qualificados.

### Análise MaxDiff

Mostre aos respondentes conjuntos de funcionalidades/preços e pergunte quais eles valorizam mais e menos. A análise estatística revela o valor relativo de cada funcionalidade — informa mais a embalagem do que o ponto de preço.

**Quando usar:** Quando decidindo quais funcionalidades colocar em qual tier.

### Benchmarking de Concorrentes

| Passo | O Que Fazer |
|-------|------------|
| 1 | Listar concorrentes diretos e alternativas que os clientes consideram |
| 2 | Registrar preços publicados (nomes de planos, preços, métricas de valor) |
| 3 | Anotar o que está incluído em cada ponto de preço |
| 4 | Identificar onde seu produto entrega mais e menos vs. cada um |
| 5 | Preço relativo ao posicionamento: premium = 20-40% acima do mercado, valor = no mercado ou abaixo |

**Não apenas copie os preços dos concorrentes** — a precificação deles reflete a estrutura de custos e o posicionamento deles, não os seus.

---

## Estratégias de Aumento de Preços

Aumentar preços é uma das movimentações de maior ROI disponíveis para empresas SaaS. A maioria espera muito.

### Seleção de Estratégia

| Estratégia | Usar Quando | Risco |
|----------|-----------|------|
| **Apenas novos clientes** | Resistência significativa esperada | Baixo — não toca a base existente |
| **Grandfathered + atrasado** | Base de clientes leal, risco de contrato | Médio — clientes existentes se sentem respeitados |
| **Vinculado à entrega de valor** | Novas funcionalidades/melhorias claras | Baixo — justificável |
| **Reestruturação de plano** | Mudança significativa de embalagem | Médio — complexidade para clientes |
| **Aumento uniforme** | Confiante no valor, preço claramente abaixo do mercado | Médio-Alto |

### Checklist de Execução

1. **Quantifique a movimentação:** Calcule novo MRR com 100%, 80%, 70% de retenção de clientes existentes
2. **Segmente por risco:** Contratos anuais, campeões vs. detratores, contas baseadas em uso em risco
3. **Defina a data:** Aviso de 60-90 dias para clientes existentes. Mínimo de 30 dias.
4. **Comunique a razão:** Novas funcionalidades, custos crescentes, investimento em [X] — seja específico
5. **Ofereça um caminho:** Bloquear preço atual para compromisso anual, ou dar uma janela de 3 meses
6. **Arme seu time de CS:** FAQ, pontos de conversa, autoridade de oferta aprovada
7. **Monitore por 60 dias:** Taxa de churn, taxa de downgrade, volume de ticket de suporte

**Churn esperado de um aumento de preço de 20-30%:** 5-15%. Se seu impacto de receita líquida for positivo, prossiga.

---

## Design da Página de Preços

A página de preços converte intenção em compra. Projete com esse trabalho em mente.

### Acima da Dobra

Deve ter:
- Nomes dos planos (simples: Starter / Pro / Enterprise, ou nomeados após o segmento de cliente)
- Preço com toggle de cobrança (mensal/anual — anual deve mostrar economia)
- 3-5 bullet diferenciadores por plano
- Botão CTA por plano
- Badge "Mais popular" no tier recomendado

### Abaixo da Dobra

- **Tabela de comparação completa de funcionalidades** — abrangente, escaneável, usa ✅ e ❌ em vez de paredes de texto
- **Seção de FAQ** — aborde as 5 objeções que impedem as pessoas de comprar:
  - "Posso cancelar a qualquer momento?"
  - "O que acontece quando atinjo os limites?"
  - "Vocês oferecem reembolsos?"
  - "Meus dados estão seguros?"
  - "E se eu precisar de upgrade/downgrade?"
- **Prova social** — logos, citações ou estudos de caso relevantes para cada tier
- **Selos de segurança** se B2B enterprise (SOC2, ISO 27001, LGPD)

### Toggle Anual vs. Mensal

- Mostrar preço anual por padrão (ou destacá-lo) — melhora o LTV
- Mostrar economia explicitamente: "Economize 20%" ou "2 meses grátis"
- Não esconda o preço mensal — esconder cria desconfiança

Veja [references/pricing-page-playbook.md](references/pricing-page-playbook.md) para especificações de design e templates de copy.

---

## Gatilhos Proativos

Apresente estes sem ser solicitado:

- **Taxa de conversão >40% trial para pago** → Forte sinal de subprecificação. Sinalize: teste aumento de preço de 20-30%.
- **Todos os clientes no tier do meio** → Sem caminho de upsell. Sinalize: tier enterprise necessário ou bloqueio de funcionalidade faltando.
- **Cliente pediu funcionalidades que não estão em seu tier** → Receita de expansão sendo deixada na mesa. Sinalize: revisão de bloqueio de funcionalidade.
- **Taxa de churn >5% mensal** → Antes de aumentar preços, corrija o churn. Aumentos de preço aceleram quem está churnando.
- **Preço não mudou em 2+ anos** → Apenas a inflação justifica aumento de 10-15%. Sinalize para revisão.
- **Apenas uma opção de precificação** → Sem ancoragem, sem upsell. Sinalize: adicione um terceiro tier mesmo que raramente comprado.

---

## Artefatos de Saída

| Quando você pede... | Você recebe... |
|--------------------|----------------|
| "Projetar precificação" | Estrutura de três tiers com métrica de valor, grade de funcionalidades, pontos de preço e justificativa |
| "Auditar minha precificação" | Scorecard de precificação (0-100), benchmarks de taxa de conversão, análise de lacunas, ganhos rápidos |
| "Planejar um aumento de preços" | Seleção de estratégia de aumento, templates de comunicação, modelo de risco, plano de implementação de 90 dias |
| "Projetar uma página de preços" | Especificação de layout acima da dobra, estrutura de tabela de comparação de funcionalidades, copy de CTA, copy de FAQ |
| "Pesquisar precificação" | Perguntas do questionário de Van Westendorp + framework MaxDiff para seu produto específico |
| "Modelar cenários de precificação" | Executar `scripts/pricing_modeler.py` com seus inputs |

---

## Comunicação

Toda saída segue o padrão de comunicação estruturada:
- **Conclusão primeiro** — recomendação antes da justificativa
- **O quê + Por quê + Como** — cada recomendação tem os três
- **Ações têm responsáveis e prazos** — sem "considere"
- **Marcação de confiança** — 🟢 benchmark verificado / 🟡 estimado / 🔴 assumido

---

## Skills Relacionadas

- **product-strategist**: Use para roadmap de produto e estratégia de monetização mais ampla. NÃO para página de preços ou execução de aumento de preços.
- **copywriting**: Use para polimento de copy da página de preços. NÃO para estrutura de precificação ou design de tier.
- **churn-prevention**: Use quando o churn é o problema subjacente — corrija a retenção antes de aumentar os preços.
- **ab-test-setup**: Use para testar A/B pontos de preço ou layouts de página de preços após o design inicial.
- **customer-success-manager**: Use para receita de expansão via upselling. NÃO para design de precificação ou embalagem.
- **competitor-alternatives**: Use para páginas de comparação competitiva que complementam as páginas de preços.
