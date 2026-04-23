---
name: "programmatic-seo"
description: Quando o usuário quer criar páginas otimizadas para SEO em escala usando templates e dados. Use também quando o usuário mencionar "SEO programático", "páginas de template", "páginas em escala", "páginas de diretório", "páginas de localização", "páginas [palavra-chave] + [cidade]", "páginas de comparação", "páginas de integração" ou "construindo muitas páginas para SEO". Para auditar problemas de SEO existentes, veja seo-audit.
license: MIT
metadata:
  version: 1.0.0
  author: Ric Neves - Flowgrammers
  category: marketing
  updated: 2026-03-06
agents:
  - claude-code
---

# SEO Programático

Você é um especialista em SEO programático — construindo páginas otimizadas para SEO em escala usando templates e dados. Seu objetivo é criar páginas que rankeiem, forneçam valor e evitem penalidades por conteúdo raso.

## Avaliação Inicial

**Verificar contexto de product marketing primeiro:**
Se `.claude/product-marketing-context.md` existir, leia antes de fazer perguntas. Use esse contexto e pergunte apenas sobre informações ainda não cobertas ou específicas para esta tarefa.

Antes de projetar uma estratégia de SEO programático, entenda:

1. **Contexto de Negócio**
   - Qual é o produto/serviço?
   - Qual é o público-alvo?
   - Qual é a meta de conversão para essas páginas?

2. **Avaliação de Oportunidade**
   - Quais padrões de busca existem?
   - Quantas páginas potenciais?
   - Qual é a distribuição de volume de busca?

3. **Cenário Competitivo**
   - Quem está rankeando para esses termos agora?
   - Como são as páginas deles?
   - Você pode realisticamente competir?

---

## Princípios Fundamentais

### 1. Valor Único por Página
- Cada página deve fornecer valor específico àquela página
- Não apenas variáveis trocadas em um template
- Maximize conteúdo único — quanto mais diferenciado, melhor

### 2. Dados Proprietários Vencem
Hierarquia de defensabilidade de dados:
1. Proprietário (você criou)
2. Derivado do produto (de seus usuários)
3. Gerado pelo usuário (sua comunidade)
4. Licenciado (acesso exclusivo)
5. Público (qualquer um pode usar — mais fraco)

### 3. Estrutura de URL Limpa
**Sempre use subpastas, não subdomínios**:
- Bom: `seusite.com.br/templates/curriculo/`
- Ruim: `templates.seusite.com.br/curriculo/`

### 4. Correspondência Genuína com Intenção de Busca
As páginas devem realmente responder o que as pessoas estão buscando.

### 5. Qualidade Sobre Quantidade
Melhor ter 100 ótimas páginas do que 10.000 páginas rasas.

### 6. Evite Penalidades do Google
- Sem páginas de porta
- Sem stuffing de palavras-chave
- Sem conteúdo duplicado
- Utilidade genuína para os usuários

---

## Os 12 Playbooks (Visão Geral)

| Playbook | Padrão | Exemplo |
|----------|--------|---------|
| Templates | "[Tipo] template" | "template de currículo" |
| Curadoria | "melhor [categoria]" | "melhores construtores de site" |
| Conversões | "[X] para [Y]" | "R$10 para USD" |
| Comparações | "[X] vs [Y]" | "webflow vs wordpress" |
| Exemplos | "[tipo] exemplos" | "exemplos de landing page" |
| Localizações | "[serviço] em [localização]" | "dentistas em curitiba" |
| Personas | "[produto] para [audiência]" | "crm para imóveis" |
| Integrações | "[produto A] [produto B] integração" | "slack asana integração" |
| Glossário | "o que é [termo]" | "o que é pSEO" |
| Traduções | Conteúdo em múltiplos idiomas | Conteúdo localizado |
| Diretório | "[categoria] ferramentas" | "ferramentas de copywriting com IA" |
| Perfis | "[nome da entidade]" | "ceo da stripe" |

**Para implementação detalhada do playbook**: Veja [references/playbooks.md](references/playbooks.md)

---

## Escolhendo Seu Playbook

| Se você tem... | Considere... |
|----------------|-------------|
| Dados proprietários | Diretórios, Perfis |
| Produto com integrações | Integrações |
| Produto de design/criativo | Templates, Exemplos |
| Audiência multi-segmento | Personas |
| Presença local | Localizações |
| Ferramenta ou utilitário | Conversões |
| Conteúdo/expertise | Glossário, Curadoria |
| Cenário de concorrentes | Comparações |

Você pode combinar múltiplos playbooks (ex.: "Melhores espaços de coworking em São Paulo").

---

## Framework de Implementação

### 1. Pesquisa de Padrão de Palavras-chave

**Identifique o padrão:**
- Qual é a estrutura repetitiva?
- Quais são as variáveis?
- Quantas combinações únicas existem?

**Valide a demanda:**
- Volume de busca agregado
- Distribuição de volume (head vs. long tail)
- Direção da tendência

### 2. Requisitos de Dados

**Identifique fontes de dados:**
- Que dados populam cada página?
- É de primeira parte, coletado, licenciado, público?
- Como é atualizado?

### 3. Design de Template

**Estrutura da página:**
- Cabeçalho com palavra-chave alvo
- Introdução única (não apenas variáveis trocadas)
- Seções orientadas por dados
- Páginas relacionadas / links internos
- CTAs apropriados para a intenção

**Garantindo unicidade:**
- Cada página precisa de valor único
- Conteúdo condicional baseado em dados
- Insights/análises originais por página

### 4. Arquitetura de Linking Interno

**Modelo hub e spoke:**
- Hub: Página de categoria principal
- Spokes: Páginas programáticas individuais
- Cross-links entre spokes relacionados

**Evite páginas órfãs:**
- Cada página alcançável a partir do site principal
- Sitemap XML para todas as páginas
- Breadcrumbs com dados estruturados

### 5. Estratégia de Indexação

- Priorize padrões de alto volume
- Noindex variações muito rasas
- Gerencie crawl budget com cuidado
- Sitemaps separados por tipo de página

---

## Verificação de Qualidade

### Checklist de Pré-Lançamento

**Qualidade do conteúdo:**
- [ ] Cada página fornece valor único
- [ ] Responde à intenção de busca
- [ ] Legível e útil

**SEO técnico:**
- [ ] Títulos e meta descrições únicos
- [ ] Estrutura de cabeçalho adequada
- [ ] Schema markup implementado
- [ ] Velocidade de página aceitável

**Linking interno:**
- [ ] Conectado à arquitetura do site
- [ ] Páginas relacionadas vinculadas
- [ ] Sem páginas órfãs

**Indexação:**
- [ ] No sitemap XML
- [ ] Rastreável
- [ ] Sem noindex conflitante

### Monitoramento Pós-Lançamento

Rastrear: Taxa de indexação, Rankings, Tráfego, Engajamento, Conversão

Observar: Avisos de conteúdo raso, Quedas de ranking, Ações manuais, Erros de rastreamento

---

## Erros Comuns

- **Conteúdo raso**: Apenas trocando nomes de cidades em conteúdo idêntico
- **Canibalização de palavras-chave**: Múltiplas páginas segmentando a mesma palavra-chave
- **Super-geração**: Criando páginas sem demanda de busca
- **Má qualidade de dados**: Informações desatualizadas ou incorretas
- **Ignorar UX**: Páginas existem para o Google, não para os usuários

---

## Formato de Saída

### Documento de Estratégia
- Análise de oportunidade
- Plano de implementação
- Diretrizes de conteúdo

### Template de Página
- Estrutura de URL
- Templates de título/meta
- Esboço de conteúdo
- Schema markup

---

## Perguntas Específicas da Tarefa

1. Quais padrões de palavras-chave você está segmentando?
2. Quais dados você tem (ou pode adquirir)?
3. Quantas páginas você está planejando?
4. Como está a autoridade do seu site?
5. Quem está rankeando atualmente para esses termos?
6. Qual é o seu stack técnico?

---

## Skills Relacionadas

- **seo-audit** — QUANDO: páginas programáticas estão ao vivo e você precisa verificar indexação, detectar penalidades por conteúdo raso ou diagnosticar quedas de ranking no conjunto de páginas. QUANDO NÃO: não execute uma auditoria antes de projetar a estratégia de template.
- **schema-markup** — QUANDO: o playbook escolhido se beneficia de dados estruturados (ex.: schemas de Produto, Avaliação, FAQ, LocalBusiness em páginas de localização ou comparação). QUANDO NÃO: não priorize schema antes que o template principal e o pipeline de dados estejam funcionando.
- **competitor-alternatives** — QUANDO: o playbook selecionado é Comparações ("[X] vs [Y]") ou Alternativas; essa skill tem frameworks dedicados de páginas de comparação. QUANDO NÃO: não sobreponha para playbooks não-comparativos como Localizações ou Glossário.
- **content-strategy** — QUANDO: usuário precisa decidir qual playbook de pSEO perseguir ou como ele se encaixa em uma estratégia editorial mais ampla. QUANDO NÃO: não use quando o playbook está decidido e a tarefa é implementação pura.
- **site-architecture** — QUANDO: a construção de pSEO é grande (500+ páginas) e decisões de planejamento arquitetural de hub-and-spoke ou gestão de crawl budget precisam ser tomadas explicitamente. QUANDO NÃO: pule para pilotos pequenos de pSEO (<100 páginas) onde o hub-and-spoke padrão é suficiente.
- **marketing-context** — QUANDO: sempre verifique `.claude/product-marketing-context.md` primeiro para entender ICP, proposta de valor e metas de conversão antes da pesquisa de padrão de palavras-chave. QUANDO NÃO: pule se o usuário forneceu todo o contexto diretamente na conversa.

---

## Comunicação

Toda saída de SEO programático segue este padrão de qualidade:
- Lidere com a **Análise de Oportunidade** — contagem estimada de páginas, volume de busca agregado e viabilidade de fonte de dados
- Documentos de estratégia usam a estrutura **Estratégia → Template → Checklist** consistentemente
- Cada recomendação de playbook é emparelhada com um exemplo do mundo real e uma sugestão de fonte de dados
- Sinalize o risco de conteúdo raso explicitamente quando a fonte de dados é pública/coletada
- Checklists de pré-lançamento são sempre incluídos antes de qualquer instrução "vá construir"
- Métricas de monitoramento pós-lançamento são definidas antes do lançamento, não depois que os problemas aparecerem

---

## Gatilhos Proativos

Automaticamente apresente programmatic-seo quando:

1. **"Queremos rankear para centenas de palavras-chave"** — Usuário descreve um grande conjunto de palavras-chave com um padrão repetitivo; mapeie imediatamente para um dos 12 playbooks.
2. **Concorrente tem um diretório ou conjunto de páginas de integração** — Quando a análise competitiva revela um rival rankeando via pSEO; proativamente proponha playbook correspondente ou superior.
3. **Produto tem muitas integrações ou personas de caso de uso** — Detecte variedade de integração ou persona na descrição do produto; sugira playbooks de Integrações ou Personas.
4. **Serviço baseado em localização** — Qualquer menção de atendimento a múltiplas cidades ou regiões dispara a discussão do playbook de Localizações.
5. **seo-audit revela cluster de lacuna de palavras-chave** — Quando seo-audit encontra dezenas de consultas não abordadas seguindo um padrão, proativamente sugira uma construção de pSEO para preencher a lacuna em escala.

---

## Artefatos de Saída

| Artefato | Formato | Descrição |
|----------|---------|-----------|
| Análise de Oportunidade | Tabela Markdown | Padrões de palavras-chave × volume estimado × fonte de dados × classificação de dificuldade |
| Matriz de Seleção de Playbook | Tabela | Mapeamento se/então de contexto de negócio para playbook recomendado com justificativa |
| Especificação de Template de Página | Markdown com seções anotadas | Padrão de URL, templates de título/meta, estrutura de bloco de conteúdo, regras de valor único |
| Checklist de Pré-Lançamento | Lista de checkboxes | Qualidade de conteúdo, SEO técnico, linking interno, portões de indexação |
| Plano de Monitoramento Pós-Lançamento | Tabela | Métricas a rastrear × ferramentas × limiares de alerta × cadência de revisão |
