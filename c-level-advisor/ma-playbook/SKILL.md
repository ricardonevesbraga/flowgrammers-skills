---
name: "ma-playbook"
description: "Estratégia de M&A para adquirir empresas ou ser adquirido. Due diligence, avaliação, integração e estrutura de negócio. Use ao avaliar aquisições, preparar-se para ser adquirido, due diligence de M&A, planejamento de integração ou negociação de transações."
license: MIT
metadata:
  version: 1.0.0
  author: Ric Neves - Flowgrammers
  category: c-level
  domain: ma-strategy
  updated: 2026-03-05
agents:
  - claude-code
---

# Playbook de M&A

Frameworks para ambos os lados de M&A: adquirir empresas e ser adquirido.

## Keywords
M&A, fusões e aquisições, due diligence, acquisition, acqui-hire, integration, deal structure, avaliação, LOI, term sheet, earnout

## Início Rápido

**Adquirindo:** Comece com a justificativa estratégica → triagem de alvos → due diligence → avaliação → negociação → integração.

**Sendo Adquirido:** Comece com avaliação de prontidão → preparação do data room → seleção de assessor → negociação → transição.

## Quando Você Está Adquirindo

### Justificativa Estratégica (responda antes de qualquer coisa)
- **Construir vs. Comprar:** Você consegue construir isso mais rápido/barato? Se sim, não adquira.
- **Acqui-hire vs. Produto vs. Mercado:** O que você está realmente comprando? Talento? Tecnologia? Clientes?
- **Complexidade de integração:** Quão difícil é incorporar isso à sua empresa?

### Checklist de Due Diligence
| Domínio | Perguntas-Chave | Sinais de Alerta |
|---------|----------------|-----------------|
| Financeiro | Qualidade da receita, concentração de clientes, taxa de burn | >30% de receita de 1 cliente |
| Técnico | Qualidade do código, dívida técnica, compatibilidade de arquitetura | Monolito sem testes |
| Jurídico | Propriedade de IP, litígios pendentes, contratos | IP chave pertencente a pessoas físicas |
| Pessoas | Risco de pessoas-chave, alinhamento cultural, risco de retenção | Fundadores sem lockup/earnout |
| Mercado | Posição de mercado, ameaças competitivas | Queda de participação de mercado |
| Clientes | Taxa de churn, NPS, termos de contrato | Alto churn, contratos curtos |

### Abordagens de Avaliação
- **Múltiplo de receita:** Dependente do setor (2–15x ARR para SaaS)
- **Transações comparáveis:** O que empresas similares foram vendidas
- **DCF:** Apenas para empresas lucrativas (a maioria das startups: use múltiplos)
- **Acqui-hire:** R$250K–R$750K por engenheiro em mercados aquecidos (referência — varia por perfil e mercado)

### Frameworks de Integração
Veja `references/integration-playbook.md` para o plano de integração de 100 dias.

## Quando Você Está Sendo Adquirido

### Sinais de Prontidão
- Interesse inbound de compradores estratégicos
- Consolidação de mercado acontecendo ao seu redor
- Captar recursos fica mais difícil do que operar
- Fundador pronto para uma transição

### Preparação (6–12 meses antes)
1. Limpe os financeiros (auditados se possível — padrão Receita Federal)
2. Documente todo o IP e contratos
3. Reduza a concentração de clientes
4. Fidelize funcionários-chave
5. Construa o data room
6. Contrate um assessor de M&A

### Pontos de Negociação
| Termo | O que Observar | Sua Alavancagem |
|-------|---------------|-----------------|
| Avaliação | Armadilhas de earnout (metas inatingíveis) | Múltiplas ofertas competindo |
| Earnout | Definições de marcos, período de medição | Divisão caixa vs. earnout |
| Lockup | Duração, condições | Sua substituibilidade |
| Rep & warranties | Escopo de responsabilidade | Escrow vs. teto de indenização |
| Retenção de funcionários | Quem recebe ofertas, em quais termos | Dependência de pessoas-chave |

## Sinais de Alerta (Ambos os Lados)

- Nenhuma justificativa estratégica clara além de "é um bom negócio"
- Choque cultural visível durante a due diligence e ignorado
- Pessoas-chave não fidelizadas antes do fechamento
- Plano de integração não existe ou é "vamos resolver"
- Avaliação baseada em projeções, não em resultados reais

## Integração com Funções C-Suite

| Função | Contribuição ao M&A |
|--------|-------------------|
| CEO | Justificativa estratégica, líder de negociação |
| CFO | Avaliação, estrutura do negócio, financiamento |
| CTO | Due diligence técnica, arquitetura de integração |
| CHRO | Due diligence de pessoas, planejamento de retenção |
| COO | Execução da integração, fusão de processos |
| CPO | Impacto no roadmap de produto, sobreposição de clientes |

## Recursos
- `references/integration-playbook.md` — plano de integração pós-aquisição de 100 dias
- `references/due-diligence-checklist.md` — checklist abrangente de DD por domínio
