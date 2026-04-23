---
name: meeting-analyzer
description: Analisa transcrições e gravações de reuniões para identificar padrões comportamentais, antipadrões de comunicação e feedback de coaching acionável. Use esta skill sempre que o usuário fizer upload ou apontar para transcrições de reuniões (.txt, .md, .vtt, .srt, .docx), perguntar sobre seus hábitos de comunicação, quiser feedback sobre como conduz reuniões, solicitar análise de proporção de fala, mencionar palavras de preenchimento ou evitação de conflitos, ou quiser comparar sua comunicação ao longo do tempo. Acione também quando os usuários mencionarem ferramentas como Granola, Otter, Fireflies ou transcrições do Zoom. Mesmo que o usuário apenas diga "olhe minhas reuniões" ou "como me apresento nas reuniões" — use esta skill.
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Analisador de Insights de Reunião

> Contribuído originalmente por [maximcoding](https://github.com/maximcoding) — aprimorado e integrado pela equipe claude-skills.

Transformar transcrições de reuniões em feedback concreto e baseado em evidências sobre padrões de comunicação, comportamentos de liderança e dinâmicas interpessoais.

## Fluxo de Trabalho Principal

### 1. Ingestão e Inventário

Escanear o diretório alvo em busca de arquivos de transcrição (`.txt`, `.md`, `.vtt`, `.srt`, `.docx`, `.json`).

Para cada arquivo:
- Extrair a data da reunião do nome do arquivo ou do conteúdo (esperar prefixo `YYYY-MM-DD` ou timestamps incorporados)
- Identificar rótulos de falante — procurar padrões como `Speaker 1:`, `[João]:`, `João Silva  00:14:32`, formatação de cue VTT/SRT
- Detectar a identidade do usuário: perguntar se ambíguo, caso contrário inferir pelo falante mais frequente ou dicas do nome do arquivo
- Registrar: nome do arquivo, data, duração (a partir de timestamps), contagem de participantes, contagem de palavras

Imprimir uma breve tabela de inventário para que o usuário confirme o escopo antes do início da análise pesada.

### 2. Normalizar Transcrições

Diferentes ferramentas produzem formatos muito diferentes. Normalizar tudo em uma estrutura interna comum antes da análise:

```
{ speaker: string, timestamp_sec: number | null, text: string }[]
```

Tratamento por formato:
- **VTT/SRT**: Analisar timestamps de cue + texto. Rótulos de falante podem ser inline (`<v Speaker>`) ou prefixados.
- **Texto simples**: Procurar prefixos `Nome:` ou `[Nome]` por linha. Se não houver rótulos de falante, avisar o usuário de que a análise por falante é limitada.
- **Markdown**: Remover formatação, depois tratar como texto simples.
- **DOCX**: Extrair conteúdo de texto, depois tratar como texto simples.
- **JSON**: Esperar um array de objetos com campos `speaker`/`text` (exportação comum do Otter/Fireflies).

Se os timestamps estiverem ausentes, degradar graciosamente — pular métricas dependentes de tempo (ritmo de fala, análise de pausa) mas ainda executar análise baseada em texto.

### 3. Analisar

Executar todos os módulos de análise aplicáveis abaixo. Cada módulo é independente — pular os que não se aplicam (ex.: pular proporções de fala se não houver rótulos de falante).

---

#### Módulo: Dinâmica de Fala

Calcular por falante:
- **Contagem de palavras e percentual** do total de palavras da reunião
- **Contagem de turnos** — quantas vezes cada pessoa falou
- **Duração média do turno** — palavras por turno de fala ininterrupto
- **Monólogo mais longo** — sinalizar turnos que excedam 60 segundos ou 200 palavras
- **Detecção de interrupção** — um turno que começa dentro de 2 segundos após o último timestamp do falante anterior, ou quebras no meio da frase

Produzir um resumo por reunião e uma média entre reuniões se houver múltiplas transcrições.

Sinais de alerta a destacar:
- Usuário fala > 60% em uma reunião de 1:muitos (dominando)
- Usuário fala < 15% em uma reunião que está facilitando (desengajado ou delegando excessivamente)
- Um participante nunca fala (voz excluída)
- Proporção de interrupção > 2:1 (usuário interrompe os outros duas vezes mais do que é interrompido)

---

#### Módulo: Conflito e Diretividade

Escanear a fala do usuário em busca de marcadores de hedging e evitação:

**Linguagem de hedging** (pontuar por instância, agregar por reunião):
- Qualificadores: "talvez", "tipo", "mais ou menos", "acho que", "potencialmente", "possivelmente"
- Busca de permissão: "se estiver tudo bem", "seria ok se", "não sei se estou certo mas"
- Deflexão: "o que você achar", "fica à seu critério", "sou flexível"
- Suavizadores antes de discordância: "não quero criar problema mas", "pode ser uma pergunta idiota"

**Padrões de evitação de conflito** (requer mais contexto, sinalizar com nível de confiança):
- Mudanças de tópico após tensão (falante A levanta problema → usuário pivota para logística)
- Concordância sem comprometimento: "sim claro" seguido de nenhuma ação ou acompanhamento
- Reencadramento das preocupações dos outros como menores do que declaradas: "provavelmente não é tão grande coisa"
- Feedback ausente em 1:1s onde tópicos de desempenho seriam esperados

Para cada instância sinalizada, extrair:
- A citação completa (com contexto circundante — 2 turnos antes e depois)
- Uma tag de severidade: `baixa` (palavra de hedge única), `média` (padrão de hedging em uma troca), `alta` (claramente evitou uma conversa necessária)
- Uma sugestão de reescrita: como uma versão mais direta soaria

---

#### Módulo: Palavras de Preenchimento e Hábitos Verbais

Contar ocorrências de: "hmm", "ahn", "tipo", "sabe", "na verdade", "basicamente", "literalmente", "né?" (pergunta tag), "então é isso", "quero dizer"

Reportar:
- Contagem total por reunião
- Taxa por 100 palavras faladas (normaliza entre durações de reunião)
- Breakdown por tipo de preenchimento
- Picos contextuais — as palavras de preenchimento aumentam em situações específicas? (ex.: ao responder a uma parte interessada sênior, ao dar feedback negativo, quando perguntado algo de improviso)

Sinalizar como problema apenas se a taxa exceder ~3 por 100 palavras. Abaixo disso, é fala normal.

---

#### Módulo: Qualidade das Perguntas e Escuta

Classificar as perguntas do usuário:
- **Fechada** (sim/não): "Você terminou o relatório?"
- **Indutora** (resposta embutida): "Você não acha que deveríamos lançar mais cedo?"
- **Aberta genuína**: "O que está te bloqueando nisso?"
- **Esclarecedora** (referencia falante anterior): "Quando você disse X, quis dizer Y?"
- **Construtora** (estende a ideia de outro): "Interessante — e se também fizermos Z?"

Indicadores de boa escuta:
- Perguntas esclarecedoras e construtoras (mostra processamento ativo)
- Paráfrase: "Então o que estou entendendo é..."
- Referenciando um ponto que alguém fez anteriormente na reunião
- Pedindo contribuição a participantes mais quietos

Indicadores de escuta ruim:
- Fazer uma pergunta que já foi respondida
- Reafirmar o próprio ponto sem reconhecer a resposta
- Responder a uma pergunta com um tópico não relacionado

Reportar a proporção de perguntas abertas/esclarecedoras/construtoras vs. fechadas/indutoras.

---

#### Módulo: Facilitação e Tomada de Decisão

Aplicar apenas quando o usuário é o organizador ou facilitador da reunião.

Avaliar:
- **Aderência à pauta**: A reunião seguiu uma estrutura ou derivou?
- **Gestão do tempo**: Quanto tempo cada tópico levou vs. o esperado?
- **Inclusão**: O facilitador ativou participantes quietos?
- **Clareza de decisão**: As decisões foram explicitamente declaradas? ("Então vamos com a opção B — Sarah fica responsável pelo acompanhamento até sexta.")
- **Itens de ação**: Foram atribuídos com responsáveis e prazos, ou deixados vagos?
- **Disciplina de parking lot**: Itens fora do tópico foram reconhecidos e adiados, ou desviaram a reunião?

---

#### Módulo: Sentimento e Energia

Rastrear o arco emocional da linguagem do usuário ao longo da reunião:
- **Marcadores positivos**: concordância entusiasmada, encorajamento, humor, elogios
- **Marcadores negativos**: frustração, descarte, sarcasmo, respostas curtas
- **Neutro/plano**: respostas de baixa energia, respostas monossilábicas

Sinalizar quedas de energia — momentos em que o engajamento do usuário visualmente diminui (turnos mais curtos, respostas menos substanciais). Frequentemente correlacionam com desconforto, tédio ou evitação.

---

### 4. Produzir o Relatório

Estruturar a saída final como um único relatório coeso. Usar este esqueleto — omitir qualquer seção onde os dados foram insuficientes:

```markdown
# Relatório de Insights de Reunião

**Período**: [data mais antiga] – [data mais recente]
**Reuniões analisadas**: [contagem]
**Total de palavras de transcrição**: [contagem]
**Sua proporção de fala (média)**: [X%]

---

## Top 3 Descobertas

[Classificar por impacto. Cada descoberta recebe 2-3 frases + um exemplo concreto com citação direta e timestamp.]

## Análise Detalhada

### Dinâmica de Fala
[Tabela de estatísticas + interpretação narrativa + sinais de alerta sinalizados]

### Padrões de Diretividade e Conflito
[Instâncias sinalizadas agrupadas por tipo de padrão, com citações e reescritas]

### Hábitos Verbais
[Estatísticas de palavras de preenchimento, picos contextuais, apenas se taxa > 3/100 palavras]

### Escuta e Perguntas
[Breakdown de tipos de perguntas, indicadores de escuta, exemplos específicos]

### Facilitação
[Apenas se aplicável — pauta, decisões, itens de ação]

### Energia e Sentimento
[Resumo do arco, quedas sinalizadas]

## Pontos Fortes
[3 coisas específicas que o usuário faz bem, com evidências]

## Oportunidades de Crescimento
[3 classificadas por impacto, cada uma com: o que mudar, por que importa, uma ação concreta "tente isso da próxima vez"]

## Comparação com Período Anterior
[Apenas se análise anterior existir — delta nas métricas principais]
```

### 5. Opções de Acompanhamento

Após entregar o relatório, oferecer:
- Aprofundamento em qualquer reunião ou padrão específico
- Um "guia de comunicação" de 1 página com os 3 principais hábitos do usuário a mudar
- Configuração de rastreamento — salvar métricas atuais como linha de base para comparação futura
- Exportar como markdown ou JSON estruturado para uso em avaliações de desempenho

---

## Casos Extremos

- **Sem rótulos de falante**: Avisar o usuário antecipadamente. Executar análise em nível de texto (palavras de preenchimento, tipos de perguntas na transcrição completa) mas pular métricas por falante. Sugerir reexportar com diarização de falante habilitada.
- **Reuniões muito curtas** (< 5 minutos ou < 500 palavras): Analisar mas ressalvar que padrões de reuniões curtas podem não ser representativos.
- **Transcrições em outros idiomas**: Os dicionários de palavras de preenchimento e hedging são centrados em português. Para outros idiomas, observar a limitação e focar na análise estrutural (proporções de fala, tomada de turno, contagens de perguntas).
- **Reunião única vs. corpus**: Se houver apenas uma transcrição, pular linguagem de tendência/comparação. Focar as descobertas apenas nessa reunião.
- **Usuário não identificado**: Se não conseguir determinar qual falante é o usuário após escanear, perguntar antes de prosseguir. Não adivinhar.

## Dicas de Fonte de Transcrição

Incluir esta seção na saída apenas se o usuário parecer incerto sobre como obter transcrições:

- **Zoom**: Configurações → Gravação → habilitar "Transcrição de áudio". Baixar `.vtt` das gravações na nuvem.
- **Google Meet**: A transcrição automática salva no Google Docs na pasta Drive do evento do calendário.
- **Granola**: Exporta para markdown. Melhor qualidade de rótulo de falante entre ferramentas de consumo.
- **Otter.ai**: Exportar como `.txt` ou `.json` do painel web.
- **Fireflies.ai**: Exportar como `.docx` ou `.json` — ambos funcionam.
- **Microsoft Teams**: Transcrições aparecem no chat da reunião. Baixar como `.vtt`.

Recomendar a convenção de nomenclatura `AAAA-MM-DD - Nome da Reunião.ext` para análise cronológica fácil.

---

## Antipadrões

| Antipadrão | Por que Falha | Melhor Abordagem |
|---|---|---|
| Analisar sem rótulos de falante | Métricas por pessoa são impossíveis — resultados são nuvens de palavras genéricas | Pedir ao usuário para reexportar com identificação de falante habilitada |
| Executar todos os módulos em um standup de 5 minutos | Exagero — análise de palavras de preenchimento e conflito precisam de reuniões de 20+ min | Auto-detectar duração da reunião e pular módulos irrelevantes |
| Apresentar métricas brutas sem contexto | "Você disse 'hmm' 47 vezes" é desanimador sem benchmarks | Sempre comparar com normas e mostrar trajetória ao longo do tempo |
| Analisar uma única reunião em isolamento | Uma reunião é um instantâneo, não um padrão — conclusões são não confiáveis | Exigir mínimo de 3+ reuniões para coaching baseado em tendências |
| Tratar igualdade de tempo de fala como o objetivo | Um facilitador DEVE falar menos; um apresentador DEVE falar mais | Ponderar proporções de fala por tipo de reunião e função |
| Sinalizar cada palavra de hedge como negativa | "Acho que" e "talvez" são apropriados em brainstorming | Distinguir entre reuniões de decisão (hedges são ruins) e ideação (hedges são aceitáveis) |

---

## Skills Relacionadas

| Skill | Relacionamento |
|-------|-------------|
| `project-management/senior-pm` | Escopo mais amplo de PM — usar para planejamento de projeto, risco, partes interessadas |
| `project-management/scrum-master` | Cerimônias ágeis — emparelha com meeting-analyzer para qualidade de retro |
| `project-management/confluence-expert` | Armazenar saídas de análise de reuniões como páginas Confluence |
| `c-level-advisor/executive-mentor` | Coaching de comunicação executiva — perspectiva complementar |
