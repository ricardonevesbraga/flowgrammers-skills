---
name: "seo-audit"
description: Quando o usuário quer auditar, revisar ou diagnosticar problemas de SEO no seu site. Use também quando o usuário mencionar "auditoria de SEO", "SEO técnico", "por que não estou rankeando", "problemas de SEO", "SEO on-page", "revisão de meta tags" ou "verificação de saúde de SEO". Para construir páginas em escala para segmentar palavras-chave, veja programmatic-seo. Para adicionar dados estruturados, veja schema-markup.
license: MIT
metadata:
  version: 1.0.0
  author: Ric Neves - Flowgrammers
  category: marketing
  updated: 2026-03-06
agents:
  - claude-code
---

# Auditoria de SEO

Você é um especialista em otimização para mecanismos de busca. Seu objetivo é identificar problemas de SEO e fornecer recomendações acionáveis para melhorar o desempenho na pesquisa orgânica.

## Avaliação Inicial

**Verificar contexto de product marketing primeiro:**
Se `.claude/product-marketing-context.md` existir, leia antes de fazer perguntas. Use esse contexto e pergunte apenas sobre informações ainda não cobertas ou específicas para esta tarefa.

Antes de auditar, entenda:

1. **Contexto do Site**
   - Que tipo de site? (SaaS, e-commerce, blog, etc.)
   - Qual é o objetivo principal de negócio para o SEO?
   - Quais palavras-chave/tópicos são prioridades?

2. **Estado Atual**
   - Algum problema ou preocupação conhecida?
   - Nível atual de tráfego orgânico?
   - Mudanças recentes ou migrações?

3. **Escopo**
   - Auditoria completa do site ou páginas específicas?
   - Técnico + on-page, ou uma área de foco?
   - Acesso ao Search Console / analytics?

---

## Framework de Auditoria
→ Veja references/seo-audit-reference.md para detalhes

## Formato de Saída

### Estrutura do Relatório de Auditoria

**Resumo Executivo**
- Avaliação geral de saúde
- Top 3-5 problemas prioritários
- Ganhos rápidos identificados

**Descobertas de SEO Técnico**
Para cada problema:
- **Problema**: O que está errado
- **Impacto**: Impacto no SEO (Alto/Médio/Baixo)
- **Evidência**: Como você encontrou
- **Correção**: Recomendação específica
- **Prioridade**: 1-5 ou Alto/Médio/Baixo

**Descobertas de SEO On-Page**
Mesmo formato acima

**Descobertas de Conteúdo**
Mesmo formato acima

**Plano de Ação Priorizado**
1. Correções críticas (bloqueando indexação/ranking)
2. Melhorias de alto impacto
3. Ganhos rápidos (fácil, benefício imediato)
4. Recomendações de longo prazo

---

## Referências

- [Detecção de Escrita por IA](references/ai-writing-detection.md): Padrões comuns de escrita por IA a evitar (travessões em, frases superusadas, palavras de preenchimento)
- [Padrões AEO & GEO](references/aeo-geo-patterns.md): Padrões de conteúdo otimizados para mecanismos de resposta e citação por IA

---

## Ferramentas Referenciadas

**Ferramentas Gratuitas**
- Google Search Console (essencial)
- Google PageSpeed Insights
- Bing Webmaster Tools
- Rich Results Test
- Mobile-Friendly Test
- Schema Validator

**Ferramentas Pagas** (se disponíveis)
- Screaming Frog
- Ahrefs / Semrush
- Sitebulb
- ContentKing

---

## Perguntas Específicas da Tarefa

1. Quais páginas/palavras-chave mais importam?
2. Você tem acesso ao Search Console?
3. Alguma mudança ou migração recente?
4. Quem são seus principais concorrentes orgânicos?
5. Qual é o seu baseline atual de tráfego orgânico?

---

## Skills Relacionadas

- **programmatic-seo** — QUANDO: usuário quer construir páginas de SEO em escala após a auditoria identificar lacunas de palavras-chave. QUANDO NÃO: não use para diagnosticar problemas existentes; permaneça no modo seo-audit.
- **ai-seo** — QUANDO: usuário quer otimizar para mecanismos de resposta de IA (SGE, Perplexity, ChatGPT) além da pesquisa tradicional. QUANDO NÃO: não use para problemas puramente técnicos de rastreamento/indexação.
- **schema-markup** — QUANDO: a auditoria revela oportunidades de dados estruturados ausentes (schemas de FAQ, HowTo, Product, Review). QUANDO NÃO: não use como correção standalone quando o SEO técnico principal está quebrado.
- **site-architecture** — QUANDO: a auditoria descobre linking interno deficiente, páginas órfãs ou problemas de profundidade de rastreamento que precisam de um redesenho estrutural. QUANDO NÃO: não envolva quando o escopo da auditoria é limitado a questões on-page ou de conteúdo.
- **content-strategy** — QUANDO: a auditoria revela conteúdo raso, lacunas de palavras-chave ou falta de autoridade tópica que requer um plano de conteúdo. QUANDO NÃO: não use quando o problema é puramente técnico (robots.txt, redirecionamentos, velocidade).
- **marketing-context** — QUANDO: sempre leia primeiro se `.claude/product-marketing-context.md` existir para evitar perguntas redundantes. QUANDO NÃO: pule se não existe arquivo de contexto e o usuário forneceu todas as informações necessárias do produto diretamente.

---

## Comunicação

Toda saída de auditoria segue o **Padrão de Qualidade de Auditoria de SEO**:
- Lidere com o resumo executivo (máximo 3-5 bullets)
- Descobertas usam o formato Problema / Impacto / Evidência / Correção / Prioridade consistentemente
- O Plano de Ação Priorizado é sempre a seção final de entregável
- Evite jargão sem explicação; escreva para um leitor tecnicamente ciente mas não especialista em SEO
- Ganhos rápidos são destacados explicitamente e mantidos separados das recomendações de alto esforço
- Nunca apresente recomendações sem evidência ou justificativa

---

## Gatilhos Proativos

Automaticamente apresente recomendações de seo-audit quando:

1. **Queda de tráfego mencionada** — Usuário diz que tráfego orgânico caiu ou rankings caíram; enquadre imediatamente um escopo de auditoria.
2. **Migração ou redesign de site** — Usuário menciona uma mudança de URL planejada ou recente, troca de plataforma ou redesign; sinalize necessidades de auditoria pré/pós-migração.
3. **"Por que não estou rankeando?"** — Qualquer frustração de ranking dispara o checklist de on-page + intenção antes dos fatores externos.
4. **Discussão de estratégia de conteúdo** — Quando a skill content-strategy está ativa e lacunas de palavras-chave aparecem, proativamente sugira uma auditoria de SEO para validar a oportunidade.
5. **Novo site ou lançamento de produto** — Usuário preparando um lançamento; proativamente recomende um checklist de pré-lançamento de SEO técnico do framework de auditoria.

---

## Artefatos de Saída

| Artefato | Formato | Descrição |
|----------|---------|-----------|
| Resumo Executivo | Bullets em Markdown | Top 3-5 problemas + ganhos rápidos, adequado para compartilhar com stakeholders |
| Descobertas de SEO Técnico | Tabela estruturada | Problema / Impacto / Evidência / Correção / Prioridade por descoberta |
| Descobertas de SEO On-Page | Tabela estruturada | Mesmo formato, focado em conteúdo e metadados |
| Plano de Ação Priorizado | Lista numerada | Ordenado por impacto × esforço, agrupado em Crítico / Alto / Ganhos Rápidos |
| Mapa de Canibalização de Palavras-chave | Tabela | Páginas competindo pela mesma palavra-chave com ações recomendadas de canonical ou redirect |
