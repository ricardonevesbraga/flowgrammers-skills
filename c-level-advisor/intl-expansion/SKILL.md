---
name: "intl-expansion"
description: "Estratégia de expansão para mercados internacionais. Seleção de mercado, modos de entrada, localização, conformidade regulatória e go-to-market por região. Use ao expandir para novos países, avaliar mercados internacionais, planejar localização ou construir times regionais."
license: MIT
metadata:
  version: 1.0.0
  author: Ric Neves - Flowgrammers
  category: c-level
  domain: international-strategy
  updated: 2026-03-05
agents:
  - claude-code
---

# Expansão Internacional

Frameworks para expansão a novos mercados: seleção, entrada, localização e execução.

## Keywords
international expansion, market entry, localization, go-to-market, GTM, regional strategy, international markets, market selection, cross-border, global expansion

## Início Rápido

**Sequência de decisão:** Seleção de mercado → Modo de entrada → Avaliação regulatória → Plano de localização → Estratégia GTM → Estrutura de time → Lançamento.

## Framework de Seleção de Mercado

### Matriz de Pontuação
| Fator | Peso | Como Avaliar |
|-------|------|--------------|
| Tamanho de mercado (endereçável) | 25% | TAM no segmento-alvo, disposição para pagar |
| Intensidade competitiva | 20% | Força dos incumbentes, lacunas de mercado |
| Complexidade regulatória | 20% | Barreiras de entrada, custo de conformidade, prazo |
| Distância cultural | 15% | Idioma, práticas de negócios, comportamento de compra |
| Tração existente | 10% | Demanda inbound, clientes existentes, parcerias |
| Complexidade operacional | 10% | Fusos horários, infraestrutura, sistemas de pagamento |

### Modos de Entrada
| Modo | Investimento | Controle | Risco | Melhor Para |
|------|------------|---------|-------|------------|
| **Exportação** (vender remotamente) | Baixo | Baixo | Baixo | Testar demanda |
| **Parceria** (revendedor/distribuidor) | Médio | Médio | Médio | Mercados com fortes requisitos locais |
| **Time local** (contratar no mercado) | Alto | Alto | Alto | Mercados estratégicos com demanda comprovada |
| **Entidade** (subsidiária integral) | Muito alto | Total | Alto | Grandes mercados, requisito regulatório |
| **Aquisição** | Mais alto | Total | Mais alto | Entrada rápida com base existente |

**Caminho padrão:** Exportação → Parceria → Time local → Entidade (avance conforme a receita justifica).

## Checklist de Localização

### Produto
- [ ] Idioma (UI, documentação, conteúdo de suporte)
- [ ] Moeda e precificação (preços locais, não apenas conversão)
- [ ] Métodos de pagamento (varia muito por mercado)
- [ ] Formatos de data/hora/número
- [ ] Requisitos legais (residência de dados, privacidade — incluindo LGPD no Brasil, Lei 13.709/18)
- [ ] Adaptação cultural (não apenas tradução)

### Go-to-Market
- [ ] Adaptação de mensagens (o que ressoa localmente)
- [ ] Estratégia de canal (canais diferem por mercado)
- [ ] Cases de sucesso locais e prova social
- [ ] Parcerias e integrações locais
- [ ] Presença em eventos/conferências
- [ ] SEO e conteúdo local

### Operações
- [ ] Entidade jurídica (se necessário)
- [ ] Conformidade tributária (Receita Federal se operar no Brasil)
- [ ] Direito trabalhista — no Brasil, consulte a CLT e acordos coletivos aplicáveis
- [ ] Suporte ao cliente (horários, idioma)
- [ ] Bancos e pagamentos

## Perguntas-Chave

- "Há atração do mercado, ou estamos empurrando?"
- "Qual é o custo de entrada vs. a oportunidade de receita de 3 anos?"
- "Podemos atender este mercado a partir do HQ, ou precisamos de presença local?"
- "Qual é o prazo regulatório? Podemos lançar antes de concluir a documentação?"
- "Quem está ganhando neste mercado e o que levaria para deslocá-los?"

## Erros Comuns

| Erro | Por que Acontece | Prevenção |
|------|-----------------|-----------|
| Entrar em muitos mercados de uma vez | FOMO, pressão do conselho | Máximo 1–2 novos mercados por ano |
| Copiar o GTM do mercado doméstico | Assumir que compradores são iguais | Pesquise o comportamento de compra local |
| Subestimar o custo regulatório | "A gente resolve" | Avaliação regulatória ANTES de comprometer |
| Contratar muito cedo | Otimismo | Prove a demanda antes de contratar time local |
| Precificação errada (apenas converter) | Preguiça | Pesquise a disposição para pagar localmente |

## Integração com Funções C-Suite

| Função | Contribuição |
|--------|-------------|
| CEO | Seleção de mercado, compromisso estratégico |
| CFO | Dimensionamento do investimento, modelagem de ROI, estrutura de entidade |
| CRO | Metas de receita, adaptação do modelo de vendas |
| CMO | Posicionamento, estratégia de canal, marca local |
| CPO | Roadmap de localização, prioridades de funcionalidades |
| CTO | Infraestrutura, residência de dados, escalabilidade |
| CHRO | Contratação local, direito trabalhista, remuneração |
| COO | Configuração de operações, adaptação de processos |

## Recursos
- `references/market-entry-playbook.md` — playbook detalhado de entrada por tipo de mercado
- `references/regional-guide.md` — considerações específicas para regiões-chave (LATAM, EUA, Europa, APAC)
