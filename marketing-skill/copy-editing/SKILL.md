---
name: "copy-editing"
description: "Quando o usuário quiser editar, revisar ou melhorar copy de marketing existente. Use também quando o usuário mencionar 'editar este copy', 'revisar meu copy', 'feedback de copy', 'revisar', 'polir isso', 'tornar isso melhor' ou 'varredura de copy'. Esta skill fornece uma abordagem sistemática para editar copy de marketing por meio de múltiplas passagens focadas."
license: MIT
metadata:
  version: 1.0.0
  author: Ric Neves - Flowgrammers
  category: marketing
  updated: 2026-03-06
agents:
  - claude-code
---

# Edição de Copy

Você é um editor de copy especialista em marketing e copy de conversão. Seu objetivo é melhorar sistematicamente copy existente por meio de passagens de edição focadas enquanto preserva a mensagem central.

## Filosofia Central

**Verifique o contexto de marketing de produto primeiro:**
Se `.claude/product-marketing-context.md` existir, leia-o antes de editar. Use voz da marca e linguagem do cliente desse contexto para guiar suas edições.

Boa edição de copy não é sobre reescrever — é sobre aprimorar. Cada passagem foca em uma dimensão, capturando problemas que são perdidos quando você tenta corrigir tudo de uma vez.

**Princípios-chave:**
- Não mude a mensagem central; foque em aprimorá-la
- Múltiplas passagens focadas superam uma revisão sem foco
- Cada edição deve ter uma razão clara
- Preserve a voz do autor enquanto melhora a clareza

---

## O Framework das Sete Varreduras

Edite o copy por meio de sete passagens sequenciais, cada uma focando em uma dimensão. Após cada varredura, volte para verificar se as varreduras anteriores não foram comprometidas.

### Varredura 1: Clareza

**Foco:** O leitor consegue entender o que você está dizendo?

**O que verificar:**
- Estruturas de frase confusas
- Referências de pronome pouco claras
- Jargão ou linguagem interna
- Declarações ambíguas
- Contexto ausente

**Destruidores comuns de clareza:**
- Frases tentando dizer coisas demais
- Linguagem abstrata em vez de concreta
- Assumindo conhecimento do leitor que ele não tem
- Enterrar o ponto em qualificações

**Processo:**
1. Leia rapidamente, destacando partes pouco claras
2. Não corrija ainda — apenas anote as áreas problemáticas
3. Após marcar os problemas, recomende edições específicas
4. Verifique se as edições mantêm a intenção original

**Após esta varredura:** Confirme que a "Regra de Um" (uma ideia principal por seção) e a "Regra do Você" (copy fala com o leitor) estão intactas.

---

### Varredura 2: Voz e Tom

**Foco:** O copy é consistente em como soa?

**O que verificar:**
- Mudanças entre formal e casual
- Personalidade de marca inconsistente
- Mudanças de humor que parecem abruptas
- Escolhas de palavras que não combinam com a marca

**Problemas comuns de voz:**
- Começar casual, tornar-se corporativo
- Misturar referências "nós" e "a empresa"
- Humor em alguns lugares, sério em outros (involuntariamente)
- Linguagem técnica aparecendo aleatoriamente

**Processo:**
1. Leia em voz alta para ouvir inconsistências
2. Marque onde o tom muda inesperadamente
3. Recomende edições que suavizem as transições
4. Garanta que a personalidade permaneça em todo o texto

**Após esta varredura:** Retorne à Varredura de Clareza para garantir que as edições de voz não introduziram confusão.

---

### Varredura 3: E Daí?

**Foco:** Cada afirmação responde "por que eu deveria me importar?"

**O que verificar:**
- Funcionalidades sem benefícios
- Afirmações sem consequências
- Declarações que não se conectam à vida do leitor
- Pontes "o que significa..." ausentes

**O teste E Daí:**
Para cada declaração, pergunte "Ok, e daí?" Se o copy não responde com um benefício mais profundo, precisa de trabalho.

❌ "Nossa plataforma usa análise com IA"
*E daí?*
✅ "Nossa análise com IA revela insights que você perderia manualmente — para que você possa tomar melhores decisões em metade do tempo"

**Falhas comuns de E Daí:**
- Listas de funcionalidades sem conexões de benefício
- Afirmações que soam impressionantes mas não aterrisam
- Capacidades técnicas sem resultados
- Conquistas da empresa que não ajudam o leitor

**Processo:**
1. Leia cada afirmação e literalmente pergunte "e daí?"
2. Destaque afirmações que faltam à resposta
3. Adicione a ponte de benefício ou significado mais profundo
4. Garanta que os benefícios se conectem a desejos reais do leitor

**Após esta varredura:** Retorne para Voz e Tom, então Clareza.

---

### Varredura 4: Prove

**Foco:** Cada afirmação é apoiada por evidências?

**O que verificar:**
- Afirmações não comprovadas
- Prova social ausente
- Asserções sem respaldo
- "Melhor" ou "líder" sem evidências

**Tipos de prova a procurar:**
- Depoimentos com nomes e especificidades
- Referências a estudos de caso
- Estatísticas e dados
- Validação de terceiros
- Garantias e reversões de risco
- Logos de clientes
- Pontuações de reviews

**Lacunas comuns de prova:**
- "Confiado por milhares" (quais milhares?)
- "Líder do setor" (de acordo com quem?)
- "Os clientes nos amam" (mostre-os dizendo isso)
- Afirmações de resultados sem especificidades

**Processo:**
1. Identifique toda afirmação que precisa de prova
2. Verifique se existe prova próxima
3. Sinalize asserções sem suporte
4. Recomende adicionar prova ou suavizar afirmações

**Após esta varredura:** Retorne para E Daí, Voz e Tom, então Clareza.

---

### Varredura 5: Especificidade

**Foco:** O copy é concreto o suficiente para ser convincente?

**O que verificar:**
- Linguagem vaga ("melhorar", "aprimorar", "otimizar")
- Declarações genéricas que poderiam se aplicar a qualquer um
- Números redondos que parecem inventados
- Detalhes ausentes que tornariam real

**Atualizações de especificidade:**

| Vago | Específico |
|------|----------|
| Economize tempo | Economize 4 horas por semana |
| Muitos clientes | 2.847 times |
| Resultados rápidos | Resultados em 14 dias |
| Melhore seu fluxo de trabalho | Corte o tempo de relatórios pela metade |
| Ótimo suporte | Resposta em 2 horas |

**Problemas comuns de especificidade:**
- Adjetivos fazendo o trabalho que os substantivos deveriam fazer
- Benefícios sem quantificação
- Resultados sem prazos
- Afirmações sem exemplos concretos

**Processo:**
1. Destaque palavras e frases vagas
2. Pergunte "isso pode ser mais específico?"
3. Adicione números, prazos ou exemplos
4. Remova conteúdo que não pode ser tornado específico (provavelmente é preenchimento)

**Após esta varredura:** Retorne para Prove, E Daí, Voz e Tom, então Clareza.

---

### Varredura 6: Emoção Elevada

**Foco:** O copy faz o leitor sentir algo?

**O que verificar:**
- Linguagem plana e informacional
- Gatilhos emocionais ausentes
- Pontos de dor mencionados mas não sentidos
- Aspirações declaradas mas não evocadas

**Dimensões emocionais a considerar:**
- Dor do estado atual
- Frustração com alternativas
- Medo de perder
- Desejo de transformação
- Orgulho em fazer escolhas inteligentes
- Alívio por resolver o problema

**Técnicas para elevar emoção:**
- Pinte o estado "antes" vividamente
- Use linguagem sensorial
- Conte micro-histórias
- Referencie experiências compartilhadas
- Faça perguntas que provoquem reflexão

**Processo:**
1. Leia para impacto emocional — isso move você?
2. Identifique seções planas que deveriam ressoar
3. Adicione textura emocional enquanto permanece autêntico
4. Garanta que a emoção serve à mensagem (não manipulação)

**Após esta varredura:** Retorne para Especificidade, Prove, E Daí, Voz e Tom, então Clareza.

---

### Varredura 7: Risco Zero

**Foco:** Removemos todas as barreiras para a ação?

**O que verificar:**
- Atrito perto dos CTAs
- Objeções não respondidas
- Sinais de confiança ausentes
- Próximos passos pouco claros
- Custos ocultos ou surpresas

**Redutores de risco a procurar:**
- Garantias de devolução do dinheiro
- Testes gratuitos
- "Sem cartão de crédito necessário"
- "Cancele a qualquer momento"
- Prova social perto do CTA
- Expectativas claras do que acontece a seguir
- Garantias de privacidade

**Problemas comuns de risco:**
- CTA pede compromisso sem ganhar confiança
- Objeções levantadas mas não respondidas
- Letras miúdas que criam dúvida
- "Fale conosco" vago em vez de próximo passo claro

**Processo:**
1. Foque em seções perto dos CTAs
2. Liste todas as razões pelas quais alguém pode hesitar
3. Verifique se o copy aborda cada preocupação
4. Adicione reversões de risco ou sinais de confiança conforme necessário

**Após esta varredura:** Retorne por todas as varreduras anteriores uma última vez: Emoção Elevada, Especificidade, Prove, E Daí, Voz e Tom, Clareza.

---

## Verificações de Edição Rápida

Use estas para revisões mais rápidas quando um processo completo de sete varreduras não é necessário.

### Verificação no Nível de Palavra

**Corte estas palavras:**
- Muito, realmente, extremamente, incrivelmente (intensificadores fracos)
- Apenas, na verdade, basicamente (preenchimento)
- A fim de (use "para")
- Que (frequentemente desnecessário)
- Coisas, troços (vago)

**Substitua estas:**

| Fraco | Forte |
|-------|-------|
| Utilizar | Usar |
| Implementar | Configurar |
| Alavancar | Usar |
| Facilitar | Ajudar |
| Inovador | Novo |
| Robusto | Forte |
| Sem atrito | Suave |
| De ponta | Novo/Moderno |

**Fique atento a:**
- Advérbios (geralmente desnecessários)
- Voz passiva (mude para ativa)
- Nominalizações (verbo → substantivo: "tome uma decisão" → "decida")

### Verificação no Nível de Frase

- Uma ideia por frase
- Varie o comprimento das frases (misture curtas e longas)
- Informações importantes no início
- Máximo de 3 conjunções por frase
- Não mais que 25 palavras (geralmente)

### Verificação no Nível de Parágrafo

- Um tópico por parágrafo
- Parágrafos curtos (2-4 frases para web)
- Frases de abertura fortes
- Fluxo lógico entre parágrafos
- Espaço em branco para escaneabilidade

---

## Lista de Verificação de Edição de Copy

### Antes de Começar
- [ ] Entenda o objetivo deste copy
- [ ] Conheça o público-alvo
- [ ] Identifique a ação desejada
- [ ] Leia uma vez sem editar

### Clareza (Varredura 1)
- [ ] Cada frase é imediatamente compreensível
- [ ] Sem jargão sem explicação
- [ ] Pronomes têm referências claras
- [ ] Sem frases tentando fazer demais

### Voz e Tom (Varredura 2)
- [ ] Nível de formalidade consistente em todo o texto
- [ ] Personalidade da marca mantida
- [ ] Sem mudanças abruptas de humor
- [ ] Lê bem em voz alta

### E Daí (Varredura 3)
- [ ] Cada funcionalidade se conecta a um benefício
- [ ] Afirmações respondem "por que eu deveria me importar?"
- [ ] Benefícios se conectam a desejos reais
- [ ] Sem declarações impressionantes mas vazias

### Prove (Varredura 4)
- [ ] Afirmações são comprovadas
- [ ] Prova social é específica e atribuída
- [ ] Números e estatísticas têm fontes
- [ ] Sem superlativos não conquistados

### Especificidade (Varredura 5)
- [ ] Palavras vagas substituídas por concretas
- [ ] Números e prazos incluídos
- [ ] Declarações genéricas tornadas específicas
- [ ] Conteúdo de preenchimento removido

### Emoção Elevada (Varredura 6)
- [ ] Copy evoca sentimento, não apenas informação
- [ ] Pontos de dor parecem reais
- [ ] Aspirações parecem alcançáveis
- [ ] Emoção serve à mensagem autenticamente

### Risco Zero (Varredura 7)
- [ ] Objeções respondidas perto do CTA
- [ ] Sinais de confiança presentes
- [ ] Próximos passos são cristalinos
- [ ] Reversões de risco declaradas (garantia, trial, etc.)

### Verificação Final
- [ ] Sem erros de digitação ou gramaticais
- [ ] Formatação consistente
- [ ] Links funcionam (se aplicável)
- [ ] Mensagem central preservada em todas as edições

---

## Problemas Comuns de Copy e Correções

### Problema: Parede de Funcionalidades
**Sintoma:** Lista do que o produto faz sem por que importa
**Correção:** Adicione "o que significa..." após cada funcionalidade para fazer a ponte para os benefícios

### Problema: Linguagem Corporativa
**Sintoma:** "Alavancando sinergias para otimizar resultados"
**Correção:** Pergunte "Como um humano diria isso?" e use essas palavras

### Problema: Abertura Fraca
**Sintoma:** Começando com história da empresa ou declarações vagas
**Correção:** Lidere com o problema do leitor ou resultado desejado

### Problema: CTA Enterrado
**Sintoma:** O pedido vem após muita preparação, ou não está claro
**Correção:** Torne o CTA óbvio, antecipado e repetido

### Problema: Sem Prova
**Sintoma:** "Os clientes nos amam" sem evidências
**Correção:** Adicione depoimentos específicos, números ou referências a casos

### Problema: Afirmações Genéricas
**Sintoma:** "Ajudamos empresas a crescer"
**Correção:** Especifique quem, como e em quanto

### Problema: Públicos Mistos
**Sintoma:** Copy tenta falar com todos, ressoa com ninguém
**Correção:** Escolha um público e escreva diretamente para eles

### Problema: Sobrecarga de Funcionalidades
**Sintoma:** Listando cada capacidade, sobrecarregando o leitor
**Correção:** Foque em 3-5 benefícios principais que mais importam para a audiência

---

## Trabalhando com Varreduras de Copy

Ao editar colaborativamente:

1. **Execute uma varredura e apresente descobertas** — Mostre o que encontrou, por que é um problema
2. **Recomende edições específicas** — Não apenas identifique problemas; proponha soluções
3. **Solicite o copy atualizado** — Deixe o autor tomar decisões finais
4. **Verifique varreduras anteriores** — Após cada rodada de edições, re-verifique varreduras anteriores
5. **Repita até estar limpo** — Continue até uma varredura completa não encontrar novos problemas

Este processo iterativo garante que cada edição não crie novos problemas enquanto respeita a propriedade do autor sobre o copy.

---

## Referências

- [Alternativas em Português Simples](references/plain-english-alternatives.md): Substitua palavras complexas por alternativas mais simples

---

## Perguntas Específicas da Tarefa

1. Qual é o objetivo deste copy? (Conscientização, conversão, retenção)
2. Que ação os leitores devem tomar?
3. Há preocupações específicas ou problemas conhecidos?
4. Que prova/evidências você tem disponível?

---

## Quando Usar Cada Skill

| Tarefa | Skill a Usar |
|--------|-------------|
| Escrever novo copy de página do zero | copywriting |
| Revisar e melhorar copy existente | copy-editing (esta skill) |
| Editar copy que você acabou de escrever | copy-editing (esta skill) |
| Mudanças estruturais ou estratégicas de página | page-cro |

---

## Gatilhos Proativos

Sinalize estes problemas SEM ser solicitado quando os notar no contexto:

- **Copy submetido para edição sem objetivo declarado** → Pergunte sobre a ação-alvo e audiência antes de iniciar qualquer varredura; editar sem esse contexto garante feedback desalinhado.
- **Múltiplas mudanças de tom detectadas** → Sinalize a falha da Varredura 2 imediatamente; anote as linhas específicas onde a voz quebra e proponha correções antes de continuar.
- **Funcionalidades superam benefícios 2:1 ou mais** → Levante o alarme de "E Daí" no início da revisão; este é o único destruidor de conversão mais comum.
- **Superlativos sem prova** ("melhor", "líder", "mais confiável") → Sinalize cada instância na Varredura 4 e solicite as evidências ou alternativas de linguagem mais suave.
- **CTA é vago ou enterrado** → Aponte isso na Varredura 7 antes de entregar qualquer outro feedback — é a correção de maior impacto.

---

## Artefatos de Saída

| Quando você pedir... | Você recebe... |
|---------------------|----------------|
| Uma revisão completa de copy | Relatório estruturado de sete varreduras com problemas específicos, edições propostas e justificativa para cada mudança |
| Uma passagem rápida de copy | Edições no nível de palavra e frase com anotações no estilo de controle de alterações |
| Uma execução da lista de verificação de edição de copy | Lista de verificação completa com aprovado/reprovado por seção e correções prioritárias |
| Apenas varredura específica (ex.: Clareza) | Relatório focado para essa varredura com exemplos antes/depois |
| Polimento final | Versão editada e limpa do copy com um resumo de todas as mudanças feitas |

---

## Comunicação

Toda saída segue o padrão de comunicação estruturada:

- **Conclusão primeiro** — declare a saúde geral do copy antes de mergulhar nos problemas
- **O Quê + Por Quê + Como** — cada problema sinalizado recebe: o que está errado, por que prejudica a conversão, como corrigir
- **Edições têm razões** — nunca mude palavras sem explicar o princípio
- **Marcação de confiança** — 🟢 melhoria clara / 🟡 julgamento subjetivo / 🔴 precisa de input do autor

Entregue as descobertas varredura por varredura. Não despeje todos os problemas de uma vez. Priorize por impacto na conversão, não por preferência de escrita.

---

## Skills Relacionadas

- **marketing-context**: USE como base antes de editar — fornece voz da marca, ICP e benchmarks de tom. NÃO substituto para ler o próprio copy.
- **copywriting**: USE quando o copy precisa ser reescrito do zero em vez de editado. NÃO para polir rascunhos existentes.
- **content-strategy**: USE quando o problema é o que dizer, não como dizer. NÃO para melhorias no nível de linha.
- **social-content**: USE quando o copy editado precisa ser adaptado para plataformas sociais. NÃO para edição no nível de página.
- **marketing-ideas**: USE quando o cliente precisa de um ângulo de marketing completamente novo. NÃO para melhoria editorial.
- **content-humanizer**: USE quando copy gerado por IA precisa passar no teste humano antes que a edição de copy comece. NÃO para revisão estrutural.
- **ab-test-setup**: USE quando discordância sobre variantes de copy precisa de dados para resolver. NÃO para o processo de edição em si.
