---
name: "cs-onboard"
description: "Entrevista de integração do fundador que captura o contexto da empresa em 7 dimensões. Invoque com /cs:setup para a entrevista inicial ou /cs:update para a atualização trimestral. Gera ~/.claude/company-context.md utilizado por todas as skills de assessoria C-suite."
license: MIT
metadata:
  version: 1.0.0
  author: Ric Neves - Flowgrammers
  category: c-level
  domain: orchestration
  updated: 2026-03-05
  frameworks: founder-interview, context-capture, quarterly-refresh
agents:
  - claude-code
---

# C-Suite Onboarding

Entrevista estruturada com o fundador que constrói o arquivo de contexto da empresa, alimentando todos os assessores C-suite. Uma conversa de 45 minutos. Contexto persistente entre todas as funções.

## Comandos

- `/cs:setup` — Entrevista completa de integração (~45 min, 7 dimensões)
- `/cs:update` — Atualização trimestral (~15 min, "o que mudou?")

## Keywords
cs:setup, cs:update, company context, founder interview, integração, company profile, c-suite setup, advisor setup

---

## Princípios da Conversa

Seja uma conversa, não um interrogatório. Faça uma pergunta por vez. Siga os fios da conversa. Reflita de volta: "Então o problema real parece ser X — é isso?" Fique atento ao que eles pulam — é aí que a história real está. Nunca leia uma lista de perguntas.

Comece com: *"Fale sobre a empresa com suas próprias palavras — o que você está construindo e por que isso importa?"*

---

## 7 Dimensões da Entrevista

### 1. Identidade da Empresa
Capturar: o que fazem, para quem é, o verdadeiro "porquê" da fundação, pitch de uma frase, valores inegociáveis.
Pergunta-chave: *"Qual é um valor pelo qual você demitiria alguém por violar?"*
Sinal de alerta: Valores que soam como texto de marketing.

### 2. Estágio e Escala
Capturar: número de funcionários (CLT vs. contratados), faixa de receita, runway, estágio (pré-PMF / escalando / otimizando), o que quebrou nos últimos 90 dias.
Pergunta-chave: *"Se você tivesse que rotular seu estágio — ainda buscando PMF, escalando o que funciona, ou otimizando?"*

### 3. Perfil do Fundador
Capturar: superpoder autodeclarado, pontos cegos reconhecidos, arquétipo (produto/vendas/técnico/operador), o que realmente os mantém acordados à noite.
Pergunta-chave: *"O que seu co-fundador diria que você deveria parar de fazer?"*
Sinal de alerta: Nenhum ponto cego, ou fraqueza apresentada como força.

### 4. Time e Cultura
Capturar: time em 3 palavras, último conflito real e resolução, quais valores são reais vs. aspiracionais, líder mais forte e mais fraco.
Pergunta-chave: *"Qual dos seus valores declarados é mais real? Qual é um cartaz na parede?"*
Sinal de alerta: "Não temos conflitos."

### 5. Mercado e Concorrência
Capturar: quem está ganhando e por quê (versão honesta), vantagem competitiva real, o movimento competitivo que poderia prejudicá-los.
Pergunta-chave: *"Qual é sua real vantagem competitiva — não a versão para investidores?"*
Sinal de alerta: "Não temos concorrência real."

### 6. Desafios Atuais
Capturar: ranking de prioridades entre produto/crescimento/pessoas/dinheiro/operações, a decisão que têm evitado, a resposta do "um dia extra".
Pergunta-chave: *"Qual é a decisão que você vem adiando há semanas?"*
Nota: A resposta do "dia extra" revela as verdadeiras prioridades.

### 7. Metas e Ambição
Capturar: meta de 12 meses (específica), meta de 36 meses (direcional), orientação para saída vs. construir para sempre, definição pessoal de sucesso.
Pergunta-chave: *"Como é o sucesso para você pessoalmente — separado da empresa?"*

---

## Saída: company-context.md

Após a entrevista, gere `~/.claude/company-context.md` usando `templates/company-context-template.md`.

Preencha cada seção. Escreva `[não capturado]` para informações desconhecidas — nunca deixe em branco. Adicione timestamp, marque como `fresh`.

Diga ao fundador: *"Capturei tudo no contexto da sua empresa. Cada assessor usará isso para dar conselhos específicos e relevantes. Execute /cs:update em 90 dias para mantê-lo atualizado."*

---

## /cs:update — Atualização Trimestral

**Gatilho:** A cada 90 dias ou após uma mudança importante. Duração: ~15 minutos.

Comece com: *"Faz [X tempo] desde que fizemos o contexto da sua empresa. O que mudou?"*

Percorra cada dimensão com uma pergunta de "o que mudou?":
1. Identidade: mesma missão ou mudou?
2. Escala: time, receita, runway agora?
3. Fundador: papel ou o que está te desafiando?
4. Time: alguma mudança de liderança?
5. Mercado: alguma surpresa competitiva?
6. Desafios: problema #1 agora vs. 90 dias atrás?
7. Metas: ainda no caminho para a meta de 12 meses?

Atualize o arquivo de contexto, renove o timestamp, redefina para `fresh`.

---

## Localização do Arquivo de Contexto

`~/.claude/company-context.md` — fonte única da verdade para todas as skills C-suite. Não mova. Não crie duplicatas.

## Referências
- `templates/company-context-template.md` — template em branco para saída
- `references/interview-guide.md` — aprofundamento em técnicas de entrevista: sondagens, sinais de alerta, como lidar com fundadores relutantes
