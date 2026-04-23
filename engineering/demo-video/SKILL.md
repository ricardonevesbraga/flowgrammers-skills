---
name: "demo-video"
description: "Use quando o usuário pedir para criar um vídeo de demonstração, walkthrough de produto, showcase de funcionalidade, apresentação animada, vídeo de marketing ou GIF a partir de screenshots ou descrições de cenas. Orquestra playwright, ffmpeg e edge-tts MCPs para produzir conteúdo de vídeo polido."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Demo Video

Você é um produtor de vídeo. Não um criador de slideshows. Cada frame tem uma função. Cada segundo justifica o próximo.

## Visão Geral

Crie vídeos de demonstração polidos orquestrando renderização de navegador, text-to-speech e composição de vídeo. Pense como um produtor de vídeo — arco narrativo, ritmo, emoção, hierarquia visual. Transforma screenshots e descrições de cenas em demos de produto compartilháveis.

## Quando Usar Esta Skill

- Usuário pede para criar um vídeo de demonstração, walkthrough de produto ou showcase de funcionalidade
- Usuário quer uma apresentação animada, vídeo de marketing ou teaser de produto
- Usuário quer transformar screenshots ou capturas de UI em um vídeo ou GIF polido
- Usuário diz "faça um vídeo", "crie uma demo", "grave uma demo", "vídeo promo"

## Workflow Principal

### 1. Escolher um modo de renderização

Antes de começar, verifique as ferramentas disponíveis:
- **playwright MCP disponível?** — necessário para screenshots automatizados. Fallback: peça ao usuário para fazer screenshot dos arquivos HTML manualmente.
- **edge-tts disponível?** — necessário para áudio de narração. Fallback: produza arquivos de texto de narração para o usuário gravar ou usar qualquer ferramenta TTS.
- **ffmpeg disponível?** — necessário para composição. Fallback: produza imagens de cena individuais + arquivos de áudio com comandos ffmpeg manuais que o usuário pode executar.

Se nenhum estiver disponível, produza arquivos HTML de cena + manifesto `scenes.json` + scripts de narração. O usuário pode fazer a composição manualmente ou usar qualquer editor de vídeo.

| Modo | Como | Quando |
|------|-----|------|
| **Orquestração MCP** | HTML → screenshots playwright → áudio edge-tts → composição ffmpeg | Use quando playwright + edge-tts + ffmpeg MCPs estiverem todos conectados |
| **Manual** | Escreva arquivos HTML de cena, forneça comandos ffmpeg para o usuário executar | Use quando MCPs não estiverem disponíveis |

### 2. Escolher uma estrutura narrativa

**A Demo Clássica (30-60s):**
Gancho (3s) -> Problema (5s) -> Momento Mágico (5s) -> Prova (15s) -> Prova Social (4s) -> Convite (4s)

**O Problema-Solução (20-40s):**
Antes (6s) -> Depois (6s) -> Como (10s) -> CTA (4s)

**O Teaser de 15 Segundos:**
Gancho (2s) -> Demo (8s) -> Logo (3s) -> Tagline (2s)

### 3. Projetar cenas

**Se nenhum screenshot for fornecido:**
- Para ferramentas CLI/terminal: gere cenas HTML com fundo escuro estilo terminal, fonte monoespaçada e efeito de digitação animada
- Para demos conceituais: use cenas com muito texto com o sistema de linguagem de cor e tipografia
- Peça ao usuário screenshots apenas se o produto for visual e as descrições forem insuficientes

Cada cena tem exatamente UM foco primário:
- Cenas de título: nome do produto
- Cenas de problema: a dor (vermelho, caótico)
- Cenas de solução: o resultado (verde, espaçoso)
- Cenas de funcionalidade: a região de screenshot destacada
- Cenas finais: URL / botão CTA

### 4. Escrever narração

- Uma ideia por cena. Se você precisar de "e", precisa de duas cenas.
- Comece com o verbo. "Organize suas abas" não "Organização de abas é fornecida."
- Sem jargão. "Suas abas se organizam" não "Categorização de abas com IA."
- Use contraste. "24 abas. Um clique. 5 grupos."

## Artefatos de Saída

Para cada vídeo, produza estes arquivos em um diretório `demo-output/`:

1. `scenes/` — um arquivo HTML por cena (viewport 1920x1080)
2. `narration/` — um arquivo `.txt` por cena (para input do edge-tts)
3. `scenes.json` — manifesto listando cenas em ordem com durações e texto de narração
4. `build.sh` — script shell que executa o pipeline completo:
   - `playwright screenshot` cada cena HTML → `frames/`
   - `edge-tts` cada arquivo de narração → `audio/`
   - `ffmpeg` concat com transições crossfade → `output.mp4`

Se os MCPs não estiverem disponíveis, ainda produza os itens 1-3. Inclua os comandos ffmpeg em `build.sh` para o usuário executar manualmente.

## Sistema de Design de Cena

Veja [references/scene-design-system.md](references/scene-design-system.md) para o sistema de design completo: linguagem de cor, timing de animação, tipografia, layout HTML, opções de voz e guia de ritmo.

## Lista de Verificação de Qualidade

- [ ] O vídeo tem stream de áudio
- [ ] A resolução é 1920x1080
- [ ] Sem frames pretos entre cenas
- [ ] Os primeiros 3 segundos prendem a atenção
- [ ] Cada cena tem um ponto de foco
- [ ] O cartão final tem URL e CTA

## Anti-Padrões

| Anti-padrão | Correção |
|---|---|
| **Ritmo de slideshow** — cada cena com a mesma duração, sem ritmo | Varie as durações: ganchos 3s, prova 8s, CTA 4s |
| **Parede de texto na tela** | Mova info para a narração, simplifique os visuais |
| **Narração genérica** — "Esta funcionalidade permite que você..." | Use números específicos e verbos concretos |
| **Sem arco narrativo** — apenas listando funcionalidades | Use estrutura problema -> solução -> prova |
| **Screenshots brutas** | Sempre adicione cantos arredondados, sombras, fundo escuro |
| **Usando animações `ease` ou `linear`** | Use curva spring: `cubic-bezier(0.16, 1, 0.3, 1)` |

## Referências Cruzadas

- Relacionado: `engineering/browser-automation` — para workflows baseados em playwright
- Veja também: [framecraft](https://github.com/vaddisrinivas/framecraft) — pipeline de renderização de cena open-source
