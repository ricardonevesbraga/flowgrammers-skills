---
name: "internal-narrative"
description: "Construa e mantenha uma narrativa coerente da empresa para todos os públicos — funcionários, investidores, clientes, candidatos e parceiros. Detecta contradições narrativas e garante que a mesma verdade seja enquadrada para as necessidades de cada público. Use ao preparar atualizações para investidores, apresentações de all-hands, comunicações do conselho, narrativas de recrutamento, comunicações de crise ou quando o usuário mencionar narrativa da empresa, consistência de mensagens, storytelling, all-hands, atualização para investidores ou comunicação de crise."
license: MIT
metadata:
  version: 1.0.0
  author: Ric Neves - Flowgrammers
  category: c-level
  domain: narrative-strategy
  updated: 2026-03-05
  frameworks: narrative-frameworks, all-hands-template
agents:
  - claude-code
---

# Internal Narrative Builder

Uma empresa. Muitos públicos. A mesma verdade — lentes diferentes. Inconsistência narrativa é erosão de confiança. Esta skill constrói e mantém comunicação coerente em todos os grupos de partes interessadas.

## Keywords
narrative, company story, internal communication, investor update, all-hands, board communication, crisis communication, messaging, storytelling, narrative consistency, audience translation, founder narrative, employee communication, candidate narrative, partner communication

## Princípio Central

**O mesmo fato aterra de forma diferente dependendo de quem o ouve e do que precisa.**

"Estamos realocando recursos do Produto A para o Produto B" significa:
- Para funcionários: "Meu emprego está seguro? Por que estamos abandonando o que construí?"
- Para investidores: "Alocação inteligente de capital — eles estão dobrando a aposta no vencedor"
- Para clientes do Produto A: "Eles estão nos abandonando?"
- Para candidatos: "Foco novo empolgante — são decisivos?"

Mesmo fato. Quatro narrativas diferentes necessárias. A habilidade é manter a verdade enquanto serve à pergunta real de cada público.

---

## Framework

### Passo 1: Construa a Narrativa Central

Um parágrafo do qual toda outra comunicação deriva. Esta é a fonte da verdade.

**Template de narrativa central:**
> [Nome da empresa] existe para [missão — presente, específica]. Estamos construindo [o que você está construindo] porque [o problema que você está resolvendo]. Nossa abordagem é [sua forma única de fazer isso]. Estamos em [descrição honesta do estado atual] e rumando para [para onde você está indo em termos concretos].

**Narrativa central boa (exemplo):**
> A Acme Health existe para reduzir quedas evitáveis em cuidados de idosos usando análise de mobilidade por smartphone. Estamos construindo uma ferramenta de diagnóstico por IA para equipes de cuidado porque as avaliações de risco de quedas atuais são subjetivas, infrequentes e frequentemente erradas. Nossa abordagem — usar a câmera do celular durante um teste de caminhada de 10 segundos — significa nenhum hardware novo, nenhum especialista necessário. Temos 80 clínicas de idosos no Brasil nos pagando R$4M ARR, e estamos rumando para R$15M ARR demonstrando valor clínico em escala antes da Série B.

**Narrativa central ruim:**
> A Acme Health é uma empresa inovadora de IA revolucionando o cuidado de idosos por meio de tecnologia de ponta que empodera prestadores de cuidados e melhora os resultados dos pacientes ao longo do continuum de cuidados.

A versão boa é utilizável. A versão ruim não diz nada.

---

### Passo 2: Matriz de Tradução para o Público

Pegue a narrativa central e traduza-a para cada público. A mesma verdade, enquadramento diferente.

| Fato | Funcionários precisam ouvir | Investidores precisam ouvir | Clientes precisam ouvir | Candidatos precisam ouvir |
|------|----------------------------|----------------------------|------------------------|--------------------------|
| Temos 80 clientes | "Provamos o modelo — seu trabalho importa" | "Sinal de product-market fit, eficiência de capital" | "80 clínicas confiam em nós" | "Tração que você estaria ingressando" |
| Pivotamos do hardware | "Fomos honestos o suficiente para mudar o rumo" | "Pivô eficiente em capital para melhores unit economics" | "Encontramos um jeito mais rápido e simples de servi-los" | "Tomamos decisões baseadas em evidências, não em ego" |
| Perdemos a receita do T2 | "Aqui está o porquê, aqui está o plano, aqui está o que você pode fazer" | "Mix de receita mudou — indicador tardio melhorando" | [Geralmente não se conta a clientes sobre perdas de receita] | [Geralmente não compartilhado externamente] |
| Estamos contratando rápido | "O time está crescendo — sua rede importa" | "Plano de headcount alinhado ao crescimento" | [Não relevante a menos que afete o serviço] | "Este é um momento de foguete" |

**Regras:**
- Nunca se contradiga entre públicos. Enquadramento diferente ≠ fatos diferentes.
- "Dissemos aos investidores crescimento, dissemos aos funcionários eficiência" é uma contradição. Audite isso.
- Investidores e funcionários se veem. Membros do conselho falam com seu time. Candidatos pesquisam você no Google.

---

### Passo 3: Detecção de Contradições

Antes de qualquer comunicação importante, execute a verificação de contradições:

**Pergunta 1:** O que dissemos aos investidores no mês passado sobre [tema]?
**Pergunta 2:** O que dissemos aos funcionários sobre o mesmo tema?
**Pergunta 3:** Elas são consistentes? Se não — qual versão é verdadeira?

**Contradições comuns:**
- "Crescimento eficiente" para investidores + "estamos contratando agressivamente" para candidatos
- "Pipeline forte" para investidores + "vendas está lutando" no all-hands
- "Cliente em primeiro lugar" na cultura + decisões recentes que claramente priorizaram receita sobre necessidade do cliente

**Quando você detectar uma contradição:** Corrija a versão menos precisa, depois comunique a correção explicitamente. "No mês passado eu disse X. Após mais reflexão, X não está bem formulado. Aqui está a versão mais clara."

Corrigir-se antes que alguém mais o pegue constrói mais confiança do que ser pego.

---

### Passo 4: Cadência de Comunicação Específica por Público

| Público | Formato | Frequência | Responsável |
|---------|---------|------------|-------------|
| Funcionários | All-hands | Mensal | CEO |
| Funcionários | Atualizações do time | Semanal | Líderes de time |
| Investidores | Atualização escrita | Mensal | CEO + CFO |
| Conselho | Reunião do conselho + memo | Trimestral | CEO |
| Clientes | Atualizações de produto | Por release | CPO / CS |
| Candidatos | Página de carreiras + narrativa de entrevista | Contínuo | CHRO + Fundadores |
| Parceiros | Revisão trimestral de negócios | Trimestral | Líder de BD |

---

### Passo 5: Estrutura e Cadência do All-Hands

Veja `templates/all-hands-template.md` para o template completo.

**Princípios:**
- Lidere com o estado honesto da empresa. Sem spin.
- Conecte o desempenho da empresa ao trabalho individual: "Veja como o que você construiu contribuiu para este resultado."
- Dê às pessoas uma razão de se orgulhar pela escolha de trabalhar aqui.
- Deixe tempo para Q&A real — não perguntas curadas.

**Modos de falha do all-hands:**
- CEO fala por 55 dos 60 minutos; Q&A é "alguma pergunta rápida?"
- Apenas boas notícias, o tempo todo — funcionários sabem quando você não está sendo honesto
- Métricas sem contexto: "ARR cresceu 15%" sem explicar se isso é bom, ruim ou esperado
- Perguntas desviadas: "Ótimo ponto, devemos fazer acompanhamento" → nunca seguido

---

### Passo 6: Comunicação em Crise

Quando a narrativa quebra — alguém sai publicamente, um produto falha, uma violação de segurança, um artigo de imprensa.

**A regra das 4 horas:** Se algo é público ou está prestes a ser, comunique internamente em 4 horas. Funcionários nunca devem saber sobre notícias da empresa pelo Twitter ou redes sociais.

**Sequência de comunicação em crise:**

**Horas 0–4 (interno primeiro):**
1. CEO ou líder relevante envia uma mensagem interna
2. Reconheça o que aconteceu factualmente
3. Declare o que você sabe e o que ainda não sabe
4. Diga às pessoas o que está fazendo a respeito
5. Diga às pessoas o que devem fazer se forem perguntadas sobre isso

**Horas 4–24 (externo se necessário):**
1. Declaração externa (imprensa, redes sociais) apenas se o evento for público
2. Consistente com a mensagem interna — mesmos fatos, enquadramento apropriado para o público
3. Revisão jurídica se houver quaisquer afirmações ou responsabilidade envolvida

**O que não fazer em uma crise:**
- Silêncio: deixar rumores preencherem o vácuo
- Spin: as pessoas conseguem detectar e destrói a confiança
- "Sem comentários": diz "temos algo a esconder"
- Culpar: mesmo que outra pessoa causou o problema, seu público só se importa com o que você está fazendo a respeito

**Template para comunicação interna em crise:**
> "Aqui está o que aconteceu: [descrição factual]. Aqui está o que sabemos agora: [fatos conhecidos]. Aqui está o que ainda não sabemos: [incerteza honesta]. Aqui está o que estamos fazendo: [ações específicas]. Aqui está o que você deve fazer se for perguntado sobre isso: [orientação específica]. Vou atualizá-los até [horário específico] com mais informações."

---

## Checklist de Consistência Narrativa

Execute antes de qualquer comunicação externa importante:

- [ ] Isso é consistente com o que dissemos aos investidores no mês passado?
- [ ] Isso é consistente com o que dissemos aos funcionários no último all-hands?
- [ ] Isso contradiz algo em nosso site, página de carreiras ou comunicados à imprensa?
- [ ] Se um funcionário lesse esta comunicação externa, reconheceria a empresa sendo descrita?
- [ ] Se um investidor lesse nosso deck interno de all-hands, encontraria algo inconsistente?
- [ ] Fomos precisos sobre nosso estado atual, ou estamos projetando uma aspiração?

---

## Perguntas-Chave para Narrativa

- "Um novo funcionário conseguiria explicar a um amigo por que nossa empresa existe? O que ele diria?"
- "O que dizemos aos investidores sobre nossa estratégia? O que dizemos aos funcionários? São a mesma coisa?"
- "Se um jornalista pedisse aos membros da nossa equipe para descrever a empresa independentemente, o que eles diriam?"
- "Quando atualizamos pela última vez nossa história de 'por que existimos'? Ainda é verdade?"
- "Qual é a pergunta mais difícil que teríamos de cada público? Temos uma resposta honesta?"

## Sinais de Alerta

- Diferentes departamentos descrevem a missão da empresa de formas diferentes
- Narrativa para investidores enfatiza crescimento; narrativa para funcionários enfatiza estabilidade (ou vice-versa)
- Apresentações de all-hands são principalmente slides, principalmente unidirecionais
- Perguntas de Q&A são selecionadas ou desviadas
- Más notícias chegam aos funcionários via rumores do Slack antes da comunicação da liderança
- Página de carreiras descreve uma cultura que os funcionários não reconhecem

## Integração com Outras Funções C-Suite

| Quando... | Trabalhe com... | Para... |
|-----------|----------------|---------|
| Preparação de atualização para investidores | CFO | Alinhar narrativa financeira com narrativa da empresa |
| Reorganização ou mudança de liderança | CHRO + CEO | Sequência: funcionários primeiro, depois externo |
| Pivô de produto | CPO | Alinhar comunicação com clientes com a história para investidores |
| Mudança de cultura | Culture Architect | Garantir que a história interna seja consistente com a marca empregadora externa |
| M&A ou parceria | CEO + COO | Controlar o fluxo de informações, prevenir vazamentos narrativos |
| Crise | Todo o C-Suite | Voz única, história consistente, interno primeiro |

## Referências Detalhadas
- `references/narrative-frameworks.md` — Estruturas de storytelling, narrativa do fundador, entrega de más notícias, templates de all-hands
- `templates/all-hands-template.md` — Template de apresentação de all-hands
