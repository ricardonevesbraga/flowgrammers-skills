---
name: "controller-contador"
description: "Controller / Contador sênior para contabilidade empresarial brasileira, rotinas fiscais (NF-e, NFS-e, SPED ICMS/Fiscal/Contribuições), fechamento mensal, conciliações, demonstrações financeiras (BP, DRE, DFC), regimes tributários (Simples, Presumido, Real) e controle interno. Use ao estruturar área contábil, preparar fechamento, conciliar contas, apurar impostos, responder auditoria ou quando o usuário mencionar controller, contador, contabilidade, NF-e, SPED, DRE, balanço patrimonial, Simples Nacional, Lucro Presumido ou Lucro Real."
license: MIT
metadata:
  version: 1.0.0
  author: Ric Neves - Flowgrammers
  category: finance
  domain: accounting-controllership
  updated: 2026-04-23
agents:
  - claude-code
---

# Controller / Contador Sênior (Brasil)

Frameworks para controladoria e contabilidade empresarial brasileira: fechamento, conciliações, rotinas fiscais, regimes tributários, SPED e demonstrações financeiras.

## Palavras-chave
Controller, Contador, contabilidade, NF-e, NFS-e, CT-e, MDF-e, SPED Fiscal, SPED Contribuições, EFD, ECD, ECF, Bloco K, DRE, Balanço, DFC, DMPL, Simples Nacional, Lucro Presumido, Lucro Real, ICMS, PIS, COFINS, IRPJ, CSLL, ISS, IRRF, CFOP, CST, NCM

## Responsabilidades Principais

### 1. Regime Tributário — Escolha Estratégica

| Regime | Faturamento | Quando usar |
|--------|-------------|-------------|
| **Simples Nacional** | Até R$ 4,8MM/ano | Serviços simples, margem alta, folha baixa |
| **Lucro Presumido** | Até R$ 78MM/ano | Serviços, comércio com margem previsível |
| **Lucro Real** | Sem limite | Indústria, margem baixa, créditos de PIS/COFINS, prejuízo fiscal acumulado |

**Teste de escolha:**
- Simples é caro para empresa de tecnologia com folha alta (fator R)
- Presumido é bom quando margem real > presunção (8% comércio, 32% serviços)
- Real é obrigatório para faturamento > R$ 78MM, bancos, factoring, imobiliárias

**Fator R (Simples Nacional, Anexos III × V):**
```
Fator R = (folha 12m + pró-labore 12m) / faturamento 12m

Se Fator R >= 28%: Anexo III (alíquota inicial 6%)
Se Fator R < 28%:  Anexo V (alíquota inicial 15,5%)
```

### 2. Rotinas Fiscais (Ciclo Mensal)

**Emissão de documentos fiscais:**
- **NF-e** (Nota Fiscal Eletrônica) — mercadorias, XML no SEFAZ
- **NFS-e** (Nota Fiscal de Serviços) — municipal
- **NFC-e** (consumidor final) — varejo
- **CT-e** (Conhecimento de Transporte) — frete
- **MDF-e** (Manifesto) — carga em trânsito

**Tributos apurados mensalmente:**
| Tributo | Base | Regime |
|---------|------|--------|
| ICMS | Saída - Entrada (não cumulativo) | Todos |
| PIS/COFINS | Faturamento (cum. ou não-cum.) | Todos |
| ISS | Serviços prestados | Todos |
| IRPJ/CSLL | Presumido (trimestral) ou Real (mensal est. / trim. ou anual) | Presumido/Real |
| Simples (DAS) | Faturamento acumulado 12m | Simples |

**Retenções na fonte:**
- IRRF (serviços PJ, pró-labore, aluguel) — código de retenção correto
- INSS (11% sobre serviços com cessão de MO, se aplicável)
- ISS retido (LC 116/03, lista de serviços)
- PIS/COFINS/CSLL retidos (Lei 10.833/03 + IN RFB)

### 3. SPED (Sistema Público de Escrituração Digital)

**Principais obrigações:**

| SPED | Prazo | Quem envia |
|------|-------|------------|
| **EFD ICMS/IPI** (Fiscal) | Mensal (até dia 20 seguinte) | Lucro Real/Presumido |
| **EFD Contribuições** (PIS/COFINS) | Mensal | Lucro Real |
| **ECD** (Contábil) | Anual (até último dia útil de maio) | Lucro Real/Presumido obrigados |
| **ECF** (Contábil Fiscal) | Anual (último dia útil de julho) | Todas PJ exceto Simples |
| **Bloco K** | Mensal | Indústrias (inventário + produção) |
| **eSocial** | Diversos prazos | Todos com folha |
| **EFD-REINF** | Mensal (dia 15) | Retenções/Receitas |
| **DCTFWeb** | Mensal (dia 15) | Compor FGTS/Contribuições |

**Validadores:**
- PVA (Programa Validador e Assinador) da RFB
- EFD Contribuições: bloco 1 obrigatório para créditos

### 4. Fechamento Mensal (Close)

**Cronograma recomendado (fechamento em D+5):**

| Dia útil | Atividade |
|----------|-----------|
| D+1 | Cutoff de NF-e entrada/saída, conferência dos volumes |
| D+2 | Conciliação bancária, cartões, caixa |
| D+3 | Depreciação, amortização, provisões |
| D+4 | Folha de pagamento integrada, encargos |
| D+5 | Revisão de razões críticos, DRE e BP preliminares |
| D+6 | Review do CFO, travamento de competência |
| D+7 | Envio de pacote gerencial (MOM) |
| D+20 | Obrigações acessórias (EFD, DCTFWeb, etc.) |

**Conciliações obrigatórias:**
- Bancos (extrato × razão)
- Clientes / Fornecedores (analítico × sintético)
- Impostos a recolher (memória de cálculo × DARF/DAE/DAS)
- Estoque (físico × contábil) — inventário trimestral
- Ativo imobilizado (bem × razão × depreciação acumulada)
- Folha (provisão × pago × GFIP/eSocial)

### 5. Plano de Contas

**Estrutura padrão (adaptado ao ECD):**

```
1 - Ativo
  1.1 - Circulante
    1.1.1 - Caixa e equivalentes
    1.1.2 - Clientes
    1.1.3 - Estoques
    1.1.4 - Impostos a recuperar
  1.2 - Não Circulante
    1.2.1 - Realizável a LP
    1.2.2 - Investimentos
    1.2.3 - Imobilizado
    1.2.4 - Intangível
2 - Passivo
  2.1 - Circulante
    2.1.1 - Fornecedores
    2.1.2 - Empréstimos e financiamentos CP
    2.1.3 - Obrigações trabalhistas
    2.1.4 - Obrigações tributárias
  2.2 - Não Circulante
    2.2.1 - Empréstimos LP
    2.2.2 - Provisões
  2.3 - Patrimônio Líquido
3 - Receitas
4 - Custos
5 - Despesas
```

### 6. Demonstrações Financeiras

**DRE (Demonstração do Resultado):**
```
(+) Receita Bruta
(-) Deduções (devoluções, abatimentos, impostos s/ vendas)
(=) Receita Líquida
(-) CPV/CMV/CSP (Custo dos produtos/mercadorias/serviços)
(=) Lucro Bruto
(-) Despesas operacionais (vendas, administrativas, gerais)
(+/-) Outras receitas/despesas operacionais
(=) EBITDA
(-) Depreciação e Amortização
(=) EBIT / Lucro Operacional
(+/-) Resultado financeiro
(=) LAIR (Lucro Antes do IR)
(-) IRPJ e CSLL
(=) Lucro Líquido do Exercício
```

**Balanço Patrimonial:** equação contábil sempre verdadeira: Ativo = Passivo + PL

**DFC (Fluxo de Caixa):** Método direto ou indireto. Método indireto parte do lucro líquido e ajusta não-caixa.

### 7. Controles Internos (CI)

**Segregação de funções:**
- Quem autoriza não paga
- Quem paga não concilia
- Quem concilia não autoriza

**Políticas mínimas:**
- Limite de alçada para pagamento
- Dupla assinatura acima de X
- Contas a pagar/receber conciliadas semanalmente
- Auditoria de cashflow semanal
- Review mensal de despesas por centro de custo

**Trilha de auditoria:**
- Documentos suportes digitalizados e ligados ao lançamento
- Aprovação eletrônica (Pipefy, SAP, Omie, ContaAzul, Totvs)
- SPED exportado e guardado por 5 anos mínimo

### 8. Principais Obrigações Acessórias Brasileiras

| Obrigação | Frequência | Finalidade |
|-----------|-----------|-----------|
| DCTFWeb | Mensal | Débitos IR, CSLL, Cofins, PIS, CPRB |
| EFD-Reinf | Mensal | Retenções |
| DIRF (extinta para competência 2023+) | — | Substituída por EFD-Reinf/DCTFWeb |
| RAIS (extinta 2023+) | — | Substituída pelo eSocial |
| DEFIS (Simples) | Anual | Declaração do Simples |
| DASN-SIMEI (MEI) | Anual | Declaração MEI |

## Kit Essencial do Controller

- **Sistema contábil**: Domínio, Alterdata, Totvs, SAP Business One, NetSuite
- **Emissão fiscal**: Omie, Conta Azul, Tiny, NFe.io, Bling
- **ERP**: Totvs Protheus/Fluig, SAP, Oracle NetSuite (para mid-market)
- **BI financeiro**: Power BI, Metabase, Tableau conectados ao ERP
- **Legislação**: IOB, Valor Econômico, Portal Fiscal

## Métricas do Controller

- **Close time (D+X)**: meta D+5 para BP e DRE; elite D+3
- **% ajustes pós-close**: meta < 2%
- **Obrigações no prazo**: 100% (zero multas)
- **Cycle time de conciliações**: semanal
- **% de conta gerencial com dono identificado**: 100%
- **Provisões × realizado** (acuracidade): > 95%

## Perguntas-Chave

- "Se a Receita nos auditar hoje, temos todos os documentos por 5 anos?"
- "Nosso regime tributário ainda é o ótimo dado o mix atual?"
- "Nossas provisões batem com a realidade histórica?"
- "Temos segregação de funções ou uma pessoa faz tudo?"
- "Nosso fechamento mensal chega a tempo de decisões ou é histórico?"

## Veja Também

- `financial-analyst/` — análise de índices e valuation
- `saas-metrics-coach/` — ARR, MRR, CAC, LTV
- `business-investment-advisor/` — decisões de CapEx
- `../c-level-advisor/cfo-advisor/` — estratégia financeira
- `fpa-analyst/` — planejamento e análise
