---
name: "strategic-alignment"
description: "Cascateia a estratégia da diretoria até o colaborador individual. Detecta e corrige desalinhamentos entre metas da empresa e execução dos times. Abrange articulação de estratégia, mapeamento de cascata, detecção de metas órfãs, identificação de silos, análise de gaps de comunicação e protocolos de realinhamento. Use quando times estão puxando em direções diferentes, OKRs não se conectam, departamentos otimizam localmente à custa da empresa, ou quando o usuário mencionar alinhamento, cascata de estratégia, silo, OKRs conflitantes ou comunicação de estratégia."
license: MIT
metadata:
  version: 1.0.0
  author: Ric Neves - Flowgrammers
  category: c-level
  domain: strategic-alignment
  updated: 2026-03-05
  frameworks: alignment-playbook
agents:
  - claude-code
---

# Motor de Alinhamento Estratégico

A estratégia falha na cascata, não na diretoria. Esta skill detecta desalinhamentos antes que se tornem disfunção e constrói sistemas que mantêm a estratégia conectada do CEO ao colaborador individual.

## Keywords
strategic alignment, strategy cascade, OKR alignment, orphan OKRs, conflicting goals, silos, communication gap, department alignment, alignment checker, strategy articulation, cross-functional, goal cascade, misalignment, alignment score

## Início Rápido

```bash
python scripts/alignment_checker.py    # Verifica alinhamento de OKRs: órfãos, conflitos, gaps de cobertura
```

## Framework Central

O problema de alinhamento: **Quanto mais distante uma meta fica da estratégia que a criou, menos provável é que reflita a intenção original.** Este é o jogo do telefone organizacional. Acontece em todo estágio. A questão é o quão ruim está e como corrigir.

### Passo 1: Teste de Articulação de Estratégia

Antes de verificar a cascata, verifique a fonte. Pergunte a cinco pessoas de cinco times diferentes:
**"Qual é a prioridade estratégica mais importante da empresa agora?"**

**Pontuação:**
- Todas as cinco dão a mesma resposta: ✅ Articulação é clara
- 3–4 dão respostas similares: 🟡 Alinhamento frouxo — esclareça e comunique
- < 3 concordam: 🔴 Estratégia não é clara o suficiente para cascatear. Corrija isso antes de corrigir a cascata.

**Teste de formato:** A estratégia deve ser declarável em uma frase. Se a liderança precisa de um parágrafo, os times não vão internalizá-la.
- ❌ "Focamos em crescimento liderado pelo produto enquanto mantemos relacionamentos enterprise, expandindo nossa presença internacional e investindo em capacidades de plataforma"
- ✅ "Ganhar o segmento mid-market de saúde no Brasil antes da Série B"

### Passo 2: Mapeamento de Cascata

Mapeie o fluxo da estratégia da empresa → cada nível da organização.

```
Nível da empresa:  OKR-1, OKR-2, OKR-3
    ↓
Nível de depto.:   OKRs de Vendas, OKRs de Eng., OKRs de Produto, OKRs de CS
    ↓
Nível de time:     OKRs do Time A, OKRs do Time B...
    ↓
Individual:        Metas pessoais / rocks
```

**Para cada meta em todo nível, pergunte:**
- Qual meta da empresa este apoia?
- Se essa meta for 100% alcançada, o quanto move a meta da empresa?
- A conexão é direta ou teórica?

### Passo 3: Detecção de Desalinhamento

Três padrões de falha:

**Metas órfãs:** Metas de time ou individuais que não se conectam a nenhuma meta da empresa.
- Sintoma: "Trabalhamos nisso por um trimestre e ninguém acima de nós parece se importar"
- Causa raiz: Metas definidas de baixo para cima ou das prioridades do trimestre passado sem reconciliar com os OKRs atuais da empresa
- Correção: Conecte ou corte. Toda meta precisa de uma meta-pai.

**Metas conflitantes:** As metas de dois times, quando ambos têm sucesso, criam um resultado pior.
- Exemplo clássico: Vendas se compromete com contratos de volume (receita), CS é medido por pontuações de satisfação. Vendas fecha clientes inadequados; pontuações de CS despencam.
- Correção: Revisão interfuncional de OKRs antes do início do trimestre. Métricas compartilhadas onde times interagem.

**Gaps de cobertura:** A empresa tem 3 OKRs. 5 times suportam o OKR-1, 2 suportam o OKR-2, 0 suportam o OKR-3.
- Sintoma: OKR-3 da empresa erra consistentemente; ninguém é responsável
- Correção: Atribuição explícita de responsabilidade. Se nenhum time é responsável por um OKR da empresa, ele não acontecerá.

Veja `scripts/alignment_checker.py` para detecção automatizada contra seus OKRs formatados em JSON.

### Passo 4: Identificação de Silos

Silos existem quando times otimizam por métricas locais à custa das métricas da empresa.

**Sinais de silos:**
- Um departamento consistentemente atinge suas metas enquanto a empresa perde as alvos
- Times não sabem em que outros times estão trabalhando
- "Esse não é nosso problema" é uma frase comum
- Escalações fluem apenas para cima; a coordenação nunca flui lateralmente
- Dados não são compartilhados entre times que dependem uns dos outros

**Causas raiz de silos:**
1. **Desalinhamento de incentivos:** Times recompensados por métricas locais não otimizam para métricas da empresa
2. **Sem metas compartilhadas:** Quando times compartilham uma meta, coordenam. Quando não, se afastam.
3. **Sem linguagem compartilhada:** Engenharia não entende métricas de vendas; vendas não entende dívida técnica
4. **Geografia ou fusos horários:** Silos se aceleram quando times não interagem organicamente

**Medição de silos:**
- Com que frequência os times pedem algo uns aos outros vs. procedem de forma independente?
- Quanto tempo leva para resolver um problema interfuncional?
- Um membro do time consegue descrever as prioridades atuais de um time adjacente?

### Passo 5: Análise de Gap de Comunicação

O que o CEO diz ≠ o que os times ouvem. O gap cresce com o tamanho da empresa.

**O modelo de decaimento de mensagem:**
- CEO comunica a estratégia no all-hands → gerentes filtram pela sua perspectiva → times recebem versão modificada → indivíduos interpretam ainda mais

**Fontes de gap:**
- **Ambiguidade:** Estratégia declarada em nível muito alto ("crescer o negócio") permite que cada time preencha sua própria interpretação
- **Frequência:** Um all-hands por trimestre não é repetição suficiente para mudar comportamento
- **Incompatibilidade de meio:** Documento de estratégia longo escrito para times que respondem à comunicação visual
- **Déficit de confiança:** Times não acreditam que a estratégia é real ("já ouvimos isso antes")

**Detecção de gap:**
- Execute o teste de articulação do Passo 1 em todos os níveis
- Compare o que a liderança acha que comunicou vs. o que os times dizem que ouviram
- Pesquisa: "O que mudou na forma como seu time trabalha desde a última atualização estratégica?"

### Passo 6: Protocolo de Realinhamento

Como corrigir o desalinhamento sem chamá-lo de "realinhamento" (o que cria medo).

**Passo 6a: Não comece com o que está errado**
Começar com "aqui está nosso desalinhamento" cria defensividade. Comece com "aqui está para onde estamos indo e quero garantir que estamos conectados."

**Passo 6b: Recascateie em um workshop, não em um memo**
Workshops de alinhamento são mais eficazes que documentos. Reúna os responsáveis pelos OKRs da empresa e os líderes de departamento. Mapeie conexões. Encontre gaps juntos.

**Passo 6c: Corrija os incentivos antes de corrigir as metas**
Se os líderes de departamento são recompensados por métricas locais que conflitam com as metas da empresa, nenhuma quantidade de definição de metas resolve o problema. A estrutura de incentivos deve mudar primeiro.

**Passo 6d: Instale uma verificação trimestral de alinhamento**
Após corrigir, previna a recorrência. Veja `references/alignment-playbook.md` para a cadência trimestral.

---

## Pontuação de Alinhamento

Uma verificação rápida de saúde. Pontue cada área de 0–10:

| Área | Pergunta | Pontuação |
|------|----------|-----------|
| Clareza da estratégia | 5 pessoas de times diferentes conseguem declarar a estratégia consistentemente? | /10 |
| Completude da cascata | Todas as metas do time se conectam a metas da empresa? | /10 |
| Detecção de conflitos | Conflitos de OKR entre times foram revisados e resolvidos? | /10 |
| Cobertura | Cada OKR da empresa tem responsabilidade explícita do time? | /10 |
| Comunicação | Os comportamentos dos times refletem a estratégia (não apenas o entendimento declarado)? | /10 |

**Total: __ / 50**

| Pontuação | Status |
|-----------|--------|
| 45–50 | Excelente. Mantenha o sistema. |
| 35–44 | Bom. Aborde áreas fracas específicas. |
| 20–34 | Desalinhamento está custando caro. Atenção imediata necessária. |
| < 20 | Desvio estratégico. Trate como crise. |

---

## Perguntas-Chave para Alinhamento

- "Pergunte ao seu membro de time mais recente: qual é a coisa mais importante que a empresa está tentando alcançar agora?"
- "Qual OKR da empresa a principal prioridade do seu time suporta? Você consegue traçar a conexão?"
- "Quando o Time A e o Time B atingem suas metas, a empresa sempre vence? Há cenários em que não vence?"
- "O que mudou na forma como seu time trabalha desde a última atualização estratégica?"
- "Cite uma decisão tomada na semana passada que foi influenciada pela estratégia da empresa."

## Sinais de Alerta

- Times consistentemente atingem metas enquanto a empresa perde alvos
- Projetos interfuncionais levam 3x mais do que o esperado (falha de coordenação)
- Estratégia atualizada trimestralmente, mas as prioridades dos times não mudam
- Atitude de "esse é um problema da liderança, não nosso" no nível do time
- Novas iniciativas anunciadas sem conectá-las aos OKRs existentes
- Líderes de departamento otimizam por headcount ou orçamento em vez de resultados da empresa

## Integração com Outras Funções C-Suite

| Quando... | Trabalhe com... | Para... |
|-----------|----------------|---------|
| Nova estratégia é definida | CEO + COO | Cascatear em rocks trimestrais antes de anunciar |
| Ciclo de OKRs começa | COO | Execute a verificação de conflito entre times antes de finalizar |
| Time consistentemente perde metas | CHRO | Diagnostique: gap de capacidade ou gap de alinhamento? |
| Silo identificado | COO | Projete métricas compartilhadas ou OKRs interfuncionais |
| Pós-M&A | CEO + Culture Architect | Detecte conflitos estratégicos entre entidades fundidas |

## Referências Detalhadas
- `scripts/alignment_checker.py` — Análise automatizada de alinhamento de OKRs (órfãos, conflitos, cobertura)
- `references/alignment-playbook.md` — Técnicas de cascata, verificação trimestral de alinhamento, padrões comuns
