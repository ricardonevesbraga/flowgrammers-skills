---
name: "culture-architect"
description: "Construa, meça e evolua a cultura da empresa como comportamento operacional — não como cartazes na parede. Abrange workshops de missão/visão/valores, tradução de valores em comportamentos, criação de código de cultura, avaliação de saúde cultural e rituais culturais por estágio. Use ao construir valores da empresa, avaliar saúde cultural, desenhar rituais culturais, criar códigos de cultura, lidar com choques de cultura ou quando o usuário mencionar cultura, valores, dívida cultural, cultura do fundador ou código de cultura."
license: MIT
metadata:
  version: 1.0.0
  author: Ric Neves - Flowgrammers
  category: c-level
  domain: culture-leadership
  updated: 2026-03-05
  frameworks: culture-playbook, culture-code-template
agents:
  - claude-code
---

# Culture Architect

Cultura é o que você FAZ, não o que você DIZ. Esta skill constrói cultura como um sistema operacional — comportamentos observáveis, saúde mensurável e rituais que escalam.

## Keywords
culture, cultura da empresa, values, mission, vision, culture code, cultural rituals, culture health, values-to-behaviors, founder culture, culture debt, value-washing, culture assessment, culture survey, psychological safety, culture scaling

## Princípio Central

**Cultura = (O que você recompensa) + (O que você tolera) + (O que você celebra)**

Se seus valores dizem "transparência" mas você pune quem traz más notícias — seu valor real é "aparências". Cultura não é aspiracional. É descritiva. O trabalho é fechar a lacuna entre o declarado e o real.

## Frameworks

### 1. Workshop de Missão / Visão / Valores

Execute isso conversacionalmente, não como um evento corporativo. Três perguntas:

**Missão** — Por que existimos (além de ganhar dinheiro)?
- "O que seria perdido se desaparecêssemos amanhã?"
- Missão é no presente. "Reduzimos quedas evitáveis em cuidados de idosos." Não "ser o líder em..."

**Visão** — Como é vencer em 5–10 anos?
- Específica o suficiente para estar errada. "Todo lar de cuidados no Brasil usa nosso sistema" é melhor que "ser líder de mercado."

**Valores** — Quais comportamentos realmente modelamos?
- Comece com o que você observa, não com o que soa bem. "O que nossa última ótima contratação fez que ninguém pediu?"
- Mantenha de 3 a 5. Mais de 5 e nenhum significa nada.

### 2. Tradução Valores → Comportamentos

Este é o trabalho. Cada valor precisa de âncoras comportamentais ou é apenas decoração.

| Valor | Versão ruim | Âncora comportamental |
|-------|-------------|----------------------|
| Transparência | "Somos abertos e honestos" | "Compartilhamos más notícias em até 24 horas, inclusive para nosso gestor" |
| Responsabilidade | "Assumimos responsabilidade" | "Não repassamos problemas — nós os possuímos até serem resolvidos, mesmo cruzando fronteiras de times" |
| Velocidade | "Nos movemos rápido" | "Decisões abaixo de R$25K acontecem no nível do time, no mesmo dia, sem aprovação necessária" |
| Qualidade | "Não cortamos atalhos" | "Paramos antes de entregar algo do qual não nos orgulhamos" |
| Cliente em primeiro | "Clientes são nossa prioridade" | "Qualquer membro do time pode escalar um problema de cliente para a liderança, ignorando os canais normais" |

**Exercício de workshop:** Escreva seu valor. Então pergunte "Como um novo contratado saberia que realmente vivemos isso no dia 30?" Se você não consegue responder concretamente, não é um valor — é uma aspiração.

### 3. Criação do Código de Cultura

Um código de cultura é um documento público que descreve como você opera. Deve afastar as pessoas erradas e atrair as certas.

**Estrutura:**
1. Quem somos (missão + contexto)
2. Quem prospera aqui (comportamentos específicos, não adjetivos)
3. Quem não prospera aqui (honesto — esta é a parte útil)
4. Como tomamos decisões
5. Como nos comunicamos
6. Como desenvolvemos pessoas
7. O que esperamos dos líderes

Veja `templates/culture-code-template.md` para um template completo.

**Armadilhas a evitar:**
- "Somos uma família" — famílias não demitem umas às outras por desempenho
- Listar apenas traços positivos — a seção "quem não prospera aqui" é o que dá credibilidade
- Torná-lo aspiracional em vez de descritivo

### 4. Avaliação de Saúde Cultural

Execute trimestralmente. 8–12 perguntas. Anônimo. Veja `references/culture-playbook.md` para design de pesquisa.

**Áreas principais a medir:**
1. Segurança psicológica — "Posso levantar uma preocupação sem medo?"
2. Clareza — "Sei como meu trabalho conecta às metas da empresa?"
3. Justiça — "As decisões são tomadas de forma consistente e transparente?"
4. Crescimento — "Estou aprendendo e sendo desafiado aqui?"
5. Confiança na liderança — "Acredito no que a liderança me diz?"

**Interpretação da pontuação:**
| Pontuação | Sinal | Ação |
|-----------|-------|------|
| 80–100% | Saudável | Manter, celebrar, documentar |
| 65–79% | Alerta | Identificar fricção específica — não reagir exageradamente |
| 50–64% | Danificada | Atenção urgente da liderança + correções específicas |
| < 50% | Crise | Emergência cultural — intervenção em all-hands |

### 5. Rituais Culturais por Estágio

Rituais são o mecanismo de entrega da cultura. O que funciona para 10 pessoas quebra para 100.

**Estágio inicial (< 15 pessoas)**
- All-hands semanal (30 min): atualização da empresa + uma vitória + um aprendizado
- Retrospectiva mensal: o que está funcionando, o que não está — sem hierarquia
- "Padrão de transparência": compartilhe tudo a menos que haja uma razão específica para não

**Crescimento inicial (15–50 pessoas)**
- Pesquisa cultural trimestral: primeiro check-in formal
- Ritual de reconhecimento: explícito, público, vinculado a valores (não apenas a resultados)
- Programa de buddy de onboarding: a transmissão cultural agora requer esforço intencional
- Horário de escritório de líderes: fundadores permanecem acessíveis à medida que as camadas aparecem

**Escalando (50–200 pessoas)**
- Comitê de cultura (liderado por pares, não pelo RH): 4–6 pessoas com rotação trimestral
- Avaliação de desempenho baseada em valores: alinhamento cultural é medido, não assumido
- Treinamento de gerentes: a cultura agora vive ou morre nos líderes de time
- All-hands departamental + all-hands da empresa separados

**Grande porte (200+ pessoas)**
- Cultura como estratégia: plano cultural anual explícito com responsável e KPIs
- NPS interno para cultura ("Você recomendaria esta empresa a um amigo?")
- Gestão de subculturas: cultura de engenharia ≠ cultura de vendas — ambas devem se alinhar ao núcleo da empresa

### 6. Armadilhas Culturais

**Value-washing:** Listar valores que você não pratica. Sintoma: funcionários reviram os olhos durante discussões sobre valores.
- Correção: Execute uma auditoria de valores. Pergunte "O que a última pessoa promovida demonstrou?" Se não corresponder aos seus valores, seus valores reais são diferentes.

**Dívida cultural:** Acumular concessões culturais ao longo do tempo. "Vamos lidar com o star performer tóxico mais tarde." Mais tarde se acumula.
- Correção: Aja sobre violações culturais mais rápido do que você acha necessário. Um comportamento ruim tolerado destrói o que dez comportamentos bons constroem.

**Armadilha da cultura do fundador:** A cultura fica congelada na personalidade do time fundador. Novas contratações se assimilam ou saem.
- Correção: Evolua explicitamente os valores à medida que escala. O que funcionou para 10 pessoas (mova-se rápido, peça perdão) pode ser destrutivo para 100 (precisamos de processo).

**Cultura por osmose:** Assumir que a cultura se transmite naturalmente. Funcionava para 10 pessoas. Não funciona para 50.
- Correção: Torne a cultura intencional. Documente-a. Ensine-a. Meça-a. Recompense-a explicitamente.

## Integração da Cultura com o C-Suite

| Quando... | Culture Architect trabalha com... | Para... |
|-----------|----------------------------------|---------|
| Surto de contratações | CHRO | Garantir que o alinhamento cultural é medido, não adivinhado |
| Reorganização | COO + CEO | Gerenciar a disrupção cultural causada pela mudança de estrutura |
| M&A ou parceria | CEO + COO | Detectar e resolver choques culturais precocemente |
| Problemas de desempenho | CHRO | Separar alinhamento cultural de déficit de habilidades |
| Pivô estratégico | CEO | Atualizar valores/comportamentos que o pivô torna obsoletos |
| Crescimento rápido | Todos | Escalar rituais antes que a cultura se dilua |

## Perguntas-Chave que um Culture Architect Faz

- "Você pode citar a última pessoa que demitimos por razões culturais? O que ela fez?"
- "Qual comportamento levou à promoção do seu último promovido? Está nos seus valores?"
- "O que um novo contratado observaria no dia 1 que indica o que é realmente valorizado aqui?"
- "O que toleramos que não deveríamos? Quem sabe e não faz nada?"
- "Como um líder de time em Recife sabe qual é a cultura em São Paulo?"

## Sinais de Alerta

- Valores afixados na parede, nunca referenciados em avaliações ou decisões
- Star performers protegidos dos padrões culturais
- Líderes que "não têm tempo" para rituais culturais
- Novos contratados sentindo que a cultura é "diferente do anunciado"
- Nenhum mecanismo para levantar preocupações culturais com segurança
- Resultados de pesquisas culturais nunca compartilhados com o time

## Referências Detalhadas
- `references/culture-playbook.md` — análise de cultura, design de pesquisa, exemplos de rituais, playbook de M&A
- `templates/culture-code-template.md` — template do documento de código de cultura
