---
name: "research-summarizer"
description: "Skill de agente de sumarização de pesquisa estruturada para usuários não-dev. Lida com artigos acadêmicos, artigos web, relatórios e documentação. Extrai descobertas principais, gera análises comparativas e produz citações formatadas corretamente. Use quando: o usuário quer resumir um artigo de pesquisa, comparar múltiplas fontes, extrair citações de documentos ou criar briefings de pesquisa estruturados. Plugin para Claude Code."
license: MIT
metadata:
  version: 1.0.0
  author: Ric Neves - Flowgrammers
  category: product
  updated: 2026-03-16
agents:
  - claude-code
---

# Resumidor de Pesquisa

> Leia menos. Entenda mais. Cite corretamente.

Fluxo de trabalho de sumarização de pesquisa estruturada que transforma material-fonte denso em briefings acionáveis. Construído para gerentes de produto, analistas, fundadores e qualquer pessoa que lê mais do que deveria precisar.

Não é um genérico "resuma isso" — é um framework repetível que extrai o que importa, compara entre fontes e formata citações corretamente.

---

## Slash Commands

| Comando | O que faz |
|---------|----------|
| `/research:summarize` | Resume uma única fonte em um briefing estruturado |
| `/research:compare` | Compara 2-5 fontes lado a lado com síntese |
| `/research:cite` | Extrai e formata todas as citações de um documento |

---

## Quando Esta Skill É Ativada

Reconheça estes padrões do usuário:

- "Resume este artigo / artigo / relatório"
- "Quais são as descobertas principais neste documento?"
- "Compare estas fontes"
- "Extraia citações deste PDF"
- "Me dê um briefing de pesquisa sobre [tópico]"
- "Desmembre este whitepaper"
- Qualquer solicitação envolvendo: resumir, briefing de pesquisa, revisão de literatura, citação, comparação de fontes

Se o usuário tiver um documento e quiser compreensão estruturada → esta skill se aplica.

---

## Fluxo de Trabalho

### `/research:summarize` — Resumo de Fonte Única

1. **Identificar tipo de fonte**
   - Artigo acadêmico → use estrutura IMRAD (Introdução, Métodos, Resultados, Análise, Discussão)
   - Artigo web → use estrutura afirmação-evidência-implicação
   - Relatório técnico → use estrutura de resumo executivo
   - Documentação → use estrutura de resumo de referência

2. **Extrair briefing estruturado**
   ```
   Title: [título exato]
   Author(s): [nomes]
   Date: [data de publicação]
   Source Type: [paper | article | report | documentation]

   ## Tese Principal
   [1-2 frases: o argumento ou descoberta central]

   ## Descobertas Principais
   1. [Descoberta com evidência de suporte]
   2. [Descoberta com evidência de suporte]
   3. [Descoberta com evidência de suporte]

   ## Metodologia
   [Como chegaram a estas descobertas — fontes de dados, tamanho da amostra, abordagem]

   ## Limitações
   - [O que a fonte não cobre ou erra]

   ## Takeaways Acionáveis
   - [O que fazer com esta informação]

   ## Citações Notáveis
   > "[Citação direta]" (p. X)
   ```

3. **Avaliar qualidade**
   - Credibilidade da fonte (revisada por pares, veículo respeitável, primária vs secundária)
   - Força das evidências (baseado em dados, anedótico, teórico)
   - Atualidade (quando publicado, ainda relevante?)
   - Indicadores de viés (fonte de financiamento, afiliação do autor, lacunas metodológicas)

### `/research:compare` — Comparação de Múltiplas Fontes

1. **Coletar fontes** (2-5 documentos)
2. **Resumir cada uma** usando o fluxo de trabalho de fonte única acima
3. **Construir matriz de comparação**

   ```
   | Dimensão         | Fonte A         | Fonte B         | Fonte C         |
   |------------------|-----------------|-----------------|-----------------|
   | Tese Central     | ...             | ...             | ...             |
   | Metodologia      | ...             | ...             | ...             |
   | Descoberta Princ.| ...             | ...             | ...             |
   | Amostra/Escopo   | ...             | ...             | ...             |
   | Credibilidade    | Alta/Méd/Baixa  | Alta/Méd/Baixa  | Alta/Méd/Baixa  |
   ```

4. **Sintetizar**
   - Onde as fontes concordam? (descobertas convergentes = sinal mais forte)
   - Onde discordam? (descobertas divergentes = precisa de investigação)
   - Que lacunas existem em todas as fontes?
   - Qual é o peso das evidências para cada posição?

5. **Produzir briefing de síntese**
   ```
   ## Descobertas de Consenso
   [Com o que a maioria das fontes concorda]

   ## Pontos Contestados
   [Onde as fontes discordam, com as evidências mais fortes para cada lado]

   ## Lacunas
   [O que nenhuma das fontes aborda]

   ## Recomendação
   [Com base no peso das evidências, o que o leitor deve acreditar/fazer?]
   ```

### `/research:cite` — Extração de Citações

1. **Varrer documento** para todas as referências, notas de rodapé, citações no texto
2. **Extrair e formatar** usando o estilo solicitado (APA 7 como padrão)
3. **Classificar citações** por tipo:
   - Fontes primárias (pesquisa original, dados)
   - Fontes secundárias (revisões, meta-análises, comentários)
   - Fontes terciárias (livros didáticos, enciclopédias)
4. **Saída** de bibliografia ordenada com tags de classificação

Formatos de citação suportados:
- **APA 7** (padrão) — ciências sociais, negócios
- **IEEE** — engenharia, ciência da computação
- **Chicago** — humanidades, história
- **Harvard** — acadêmico geral
- **MLA 9** — artes, humanidades

---

## Ferramentas

### `scripts/extract_citations.py`

Utilitário CLI para extrair e formatar citações de texto.

**Funcionalidades:**
- Detecção de citação baseada em regex (DOI, URL, autor-ano, referências numeradas)
- Múltiplos formatos de saída (APA, IEEE, Chicago, Harvard, MLA)
- Exportação JSON para integração com gerenciadores de referência
- Deduplicação de citações repetidas

**Uso:**
```bash
# Extrair citações de um arquivo (formato APA, padrão)
python3 scripts/extract_citations.py document.txt

# Especificar formato
python3 scripts/extract_citations.py document.txt --format ieee

# Saída JSON
python3 scripts/extract_citations.py document.txt --format apa --output json

# Da entrada padrão
cat paper.txt | python3 scripts/extract_citations.py --stdin
```

### `scripts/format_summary.py`

Utilitário CLI para gerar resumos de pesquisa estruturados.

**Funcionalidades:**
- Múltiplos templates de resumo (acadêmico, artigo, relatório, executivo)
- Comprimento de saída configurável (breve, padrão, detalhado)
- Saída em Markdown e texto simples
- Extração de descobertas principais com etiquetagem de evidências

**Uso:**
```bash
# Gerar template de resumo estruturado
python3 scripts/format_summary.py --template academic

# Formato de resumo executivo breve
python3 scripts/format_summary.py --template executive --length brief

# Listar todos os templates
python3 scripts/format_summary.py --list-templates

# Saída JSON
python3 scripts/format_summary.py --template article --output json
```

---

## Framework de Avaliação de Qualidade

Avalie cada fonte em quatro dimensões:

| Dimensão | Alta | Média | Baixa |
|----------|------|-------|-------|
| **Credibilidade** | Revisada por pares, autor estabelecido | Veículo respeitável, autor conhecido | Blog, autor desconhecido, sem revisão |
| **Evidência** | Grande amostra, método rigoroso | Dados moderados, abordagem sólida | Anedótico, sem dados, opinião |
| **Atualidade** | Publicado nos últimos 2 anos | 2-5 anos | 5+ anos, pode estar desatualizado |
| **Objetividade** | Sem conflitos, visão equilibrada | Afiliações menores divulgadas | Financiado por parte interessada, unilateral |

**Classificação Geral:**
- 4 Altas = Fonte forte — cite com confiança
- 2+ Médias = Fonte adequada — cite com ressalvas
- 2+ Baixas = Fonte fraca — verifique independentemente antes de citar

---

## Templates de Resumo

Veja `references/summary-templates.md` para:
- Template de resumo de artigo acadêmico (IMRAD)
- Template de resumo de artigo web (afirmação-evidência-implicação)
- Template de relatório técnico (resumo executivo)
- Template de análise comparativa (matriz + síntese)
- Template de revisão de literatura (organização temática)

Veja `references/citation-formats.md` para:
- Regras de formatação APA 7 e exemplos
- Regras de formatação IEEE e exemplos
- Referência rápida Chicago, Harvard, MLA

---

## Gatilhos Proativos

Sinalize estes sem ser solicitado:

- **Fonte sem data** → Anote. Fontes sem data perdem pontos de credibilidade.
- **Fonte contradiz outras fontes** → Destaque a contradição explicitamente. Não encubra discordâncias.
- **Fonte está atrás de paywall** → Anote acesso limitado. Sugira alternativas se conhecidas.
- **Usuário fornece apenas uma fonte para comparação** → Peça pelo menos mais uma. Comparação precisa de 2+.
- **Citações estão incompletas** → Sinalize campos ausentes (ano, autor, título). Não invente metadados.
- **Fonte tem 5+ anos em campo de rápida evolução** → Alerte sobre potencial obsolescência.

---

## Instalação

### One-liner (qualquer ferramenta)
```bash
git clone https://github.com/alirezarezvani/claude-skills.git
cp -r claude-skills/product-team/research-summarizer ~/.claude/skills/
```

---

## Skills Relacionadas

- **product-analytics** — Análise quantitativa. Complementar — use research-summarizer para fontes qualitativas, product-analytics para métricas.
- **competitive-teardown** — Pesquisa competitiva. Complementar — use research-summarizer para análise de fonte individual, competitive-teardown para o cenário de mercado.
- **content-production** — Escrita de conteúdo. Research-summarizer alimenta content-production — resuma as fontes primeiro, depois escreva.
- **product-discovery** — Frameworks de descoberta. Complementar — research-summarizer para pesquisa de desk, product-discovery para pesquisa com usuários.
