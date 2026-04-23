---
name: "x-twitter-growth"
description: "Motor de crescimento no X/Twitter para construir audiência, criar conteúdo viral e analisar engajamento. Use quando o usuário quer crescer no X/Twitter, escrever tweets ou threads, analisar o perfil no X, pesquisar concorrentes no X, planejar estratégia de postagem ou otimizar engajamento. Complementa social-content (múltiplas plataformas) com profundidade específica para o X: mecânica do algoritmo, engenharia de threads, estratégia de replies, otimização de perfil e inteligência competitiva via busca na web."
license: MIT
metadata:
  version: 1.0.0
  author: Ric Neves - Flowgrammers
  category: marketing
  updated: 2026-03-10
agents:
  - claude-code
---

# Motor de Crescimento no X/Twitter

Skill específica para crescimento no X. Para conteúdo social geral entre plataformas, veja `social-content`. Para estratégia social e planejamento de calendário, veja `social-media-manager`. Esta skill vai fundo no X.

## Quando Usar Esta vs Outras Skills

| Necessidade | Use |
|------|-----|
| Escrever um tweet ou thread | **Esta skill** |
| Planejar conteúdo entre LinkedIn + X + Instagram | social-content |
| Analisar métricas de engajamento entre plataformas | social-media-analyzer |
| Construir estratégia social geral | social-media-manager |
| Crescimento específico no X, algoritmo, inteligência competitiva | **Esta skill** |

---

## Passo 1: Auditoria de Perfil

Antes de qualquer trabalho de crescimento, audite a presença atual no X. Execute `scripts/profile_auditor.py` com o handle, ou avalie manualmente:

### Checklist de Bio
- [ ] Proposta de valor clara na primeira linha (quem você ajuda + como)
- [ ] Nicho específico — não "empreendedor | pensador | construtor"
- [ ] Elemento de prova social (seguidores, cargo, métrica, marca)
- [ ] CTA ou link (newsletter, produto, site)
- [ ] Sem hashtags na bio (sinaliza amador)

### Tweet Fixado
- [ ] Existe e tem menos de 30 dias
- [ ] Exibe o melhor trabalho ou hook mais forte
- [ ] Tem CTA claro (seguir, assinar, ler)

### Atividade Recente (últimos 30 posts)
- [ ] Frequência de postagem: mínimo 1x/dia, ideal 3-5x/dia
- [ ] Mix de formatos: tweets, threads, replies, citações
- [ ] Taxa de reply: >30% da atividade deve ser replies
- [ ] Tendência de engajamento: melhorando, estável ou em queda

Execute: `python3 scripts/profile_auditor.py --handle @username`

---

## Passo 2: Inteligência Competitiva

Pesquise concorrentes e contas de sucesso no seu nicho usando busca na web.

### Processo
1. Pesquise `site:x.com "tópico" min_faves:100` via buscador para encontrar conteúdo de alto desempenho
2. Identifique 5-10 contas no seu nicho com forte engajamento
3. Para cada uma, analise: frequência de postagem, tipos de conteúdo, padrões de hook, taxas de engajamento
4. Execute: `python3 scripts/competitor_analyzer.py --handles @conta1 @conta2 @conta3`

### O que Extrair
- **Padrões de hook** — Como os posts de maior desempenho começam? Pergunta? Afirmação ousada? Estatística?
- **Temas de conteúdo** — Quais 3-5 tópicos geram mais engajamento?
- **Mix de formato** — Proporção de tweets vs threads vs replies vs citações
- **Horários de postagem** — Quando os melhores posts são publicados?
- **Gatilhos de engajamento** — O que faz as pessoas responderem vs curtir vs retweetar?

---

## Passo 3: Criação de Conteúdo

### Tipos de Tweet (ordenados por impacto no crescimento)

#### 1. Threads (maior alcance, maior conversão em seguidores)
```
Estrutura:
- Tweet 1: Hook — deve parar a rolagem em <7 palavras
- Tweet 2: Contexto ou promessa ("Veja o que aprendi:")
- Tweets 3-N: Uma ideia por tweet, cada um com valor independente
- Tweet final: Resumo + CTA explícito ("Siga @handle para mais")
- Reply ao tweet 1: Restabeleça o hook + "Siga para mais [tópico]"

Regras:
- 5-12 tweets é o ideal (menos de 5 parece raso, mais de 12 perde as pessoas)
- Cada tweet deve fazer sentido se lido isoladamente
- Use quebras de linha para legibilidade
- Nenhum tweet deve ser uma parede de texto (máximo 3-4 linhas)
- Numere os tweets ou use "↓" no tweet 1
```

#### 2. Tweets Atômicos (amplitude, geração de impressões)
```
Formatos que funcionam:
- Observação: "[Coisa] é subestimado. Veja o porquê:"
- Lista: "10 ferramentas que uso diariamente:\n\n1. X — para Y"
- Contrário: "Opinião impopular: [declaração]"
- Lição: "Eu [fiz X] por [tempo]. Maior lição:"
- Framework: "[Conceito] explicado em 30 segundos:"

Regras:
- Menos de 200 caracteres gera mais engajamento
- Uma ideia por tweet
- Sem links no corpo do tweet (prejudica o alcance — coloque o link no reply)
- Tweets com pergunta geram replies (o algoritmo ama replies)
```

#### 3. Tweets com Citação (construção de autoridade)
```
Fórmula: Tweet original + sua perspectiva única
- Adicione dados que o original deixou de fora
- Forneça contraponto ou nuance
- Compartilhe experiência pessoal que valida/contradiz
- Nunca apenas "Isso" ou "Que verdade"
```

#### 4. Replies (crescimento de rede, caminho mais rápido para visibilidade)
```
Estratégia:
- Responda a contas 2-10x maiores que a sua
- Adicione valor genuíno, não "ótimo post!"
- Seja o primeiro a responder em contas com grande audiência
- Seu reply É seu conteúdo — faça valer um tweet
- Replies controversos/perspicazes são citados (alcance gratuito)
```

Execute: `python3 scripts/tweet_composer.py --type thread --topic "seu tópico" --audience "sua audiência"`

---

## Passo 4: Mecânica do Algoritmo

### O que o X recompensa (2025-2026)
| Sinal | Peso | Ação |
|--------|--------|--------|
| Replies recebidos | Muito alto | Escreva conteúdo que gera reply (perguntas, debates) |
| Tempo gasto lendo | Alto | Threads, tweets mais longos com quebras de linha |
| Visitas ao perfil a partir do tweet | Alto | Lacunas de curiosidade, sinalize expertise |
| Bookmarks | Alto | Conteúdo tático e que vale salvar (listas, frameworks) |
| Retweets/Citações | Médio | Insights compartilháveis, posições ousadas |
| Curtidas | Baixo-médio | Concordância fácil, conteúdo relacionável |
| Cliques em links | Baixo (penalizado) | Nunca coloque links no corpo do tweet — use o reply |

### O que prejudica o alcance
- Links no corpo do tweet (coloque no primeiro reply)
- Editar tweets nos primeiros 30 min após publicar
- Postar e ficar offline imediatamente (sem engajamento inicial)
- Mais de 2 hashtags
- Marcar pessoas que não engajam de volta
- Threads com qualidade inconsistente (um tweet fraco prejudica a thread toda)

### Cadência Ideal de Postagem
| Tamanho da conta | Tweets/dia | Threads/semana | Replies/dia |
|-------------|------------|--------------|-------------|
| < 1K seguidores | 2-3 | 1-2 | 10-20 |
| 1K-10K | 3-5 | 2-3 | 5-15 |
| 10K-50K | 3-7 | 2-4 | 5-10 |
| 50K+ | 2-5 | 1-3 | 5-10 |

---

## Passo 5: Playbook de Crescimento

### Semana 1-2: Fundação
1. Otimize bio e tweet fixado (Passo 1)
2. Identifique 20 contas no seu nicho para engajar diariamente
3. Responda 10-20 vezes por dia para contas maiores (apenas valor genuíno)
4. Publique 2-3 tweets atômicos por dia testando diferentes formatos
5. Publique 1 thread

### Semana 3-4: Reconhecimento de Padrões
1. Revise quais formatos tiveram mais engajamento
2. Dobre nos 2 formatos de conteúdo principais
3. Aumente para 3-5 posts por dia
4. Publique 2-3 threads por semana
5. Comece a citar conteúdo relevante diariamente

### Mês 2+: Escalar
1. Desenvolva 3-5 séries de conteúdo recorrentes (ex.: "Sexta-feira de Framework")
2. Polinização cruzada: reaproveite threads como posts no LinkedIn, conteúdo de newsletter
3. Construa relacionamentos de reply com 5-10 contas do seu tamanho (engajamento mútuo)
4. Experimente spaces/áudio se relevante para o nicho
5. Execute: `python3 scripts/growth_tracker.py --handle @username --period 30d`

---

## Passo 6: Geração de Calendário Editorial

Execute: `python3 scripts/content_planner.py --niche "seu nicho" --frequency 5 --weeks 2`

Gera um plano de postagem de 2 semanas com:
- Tópicos de tweet diários com sugestões de hook
- Esboços de thread (2-3 por semana)
- Alvos de reply (contas para engajar)
- Horários ideais de postagem com base no nicho

---

## Scripts

| Script | Propósito |
|--------|---------|
| `scripts/profile_auditor.py` | Auditar perfil no X: bio, post fixado, padrões de atividade |
| `scripts/tweet_composer.py` | Gerar tweets/threads com padrões de hook |
| `scripts/competitor_analyzer.py` | Analisar contas concorrentes via busca na web |
| `scripts/content_planner.py` | Gerar calendários editoriais semanais/mensais |
| `scripts/growth_tracker.py` | Rastrear crescimento de seguidores e tendências de engajamento |

## Armadilhas Comuns

1. **Postar links diretamente** — Sempre coloque links no primeiro reply, nunca no corpo do tweet
2. **Tweet 1 da thread é fraco** — Se o hook não para a rolagem, o restante não importa
3. **Postagem inconsistente** — O algoritmo recompensa consistência diária sobre bangers ocasionais
4. **Apenas transmitindo** — Replies e engajamento são 50%+ do crescimento, não apenas postar
5. **Bio genérica** — "Ajudando pessoas a fazer coisas" não diz nada a ninguém
6. **Copiar formatos sem adaptar** — O que funciona no Twitter de tech não funciona no Twitter de marketing

## Skills Relacionadas

- `social-content` — Criação de conteúdo multiplataforma
- `social-media-manager` — Estratégia social geral
- `social-media-analyzer` — Analytics entre plataformas
- `content-production` — Conteúdo longo que alimenta threads no X
- `copywriting` — Técnicas de escrita de título e hook
