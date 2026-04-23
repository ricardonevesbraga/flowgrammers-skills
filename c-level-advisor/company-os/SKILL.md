---
name: "company-os"
description: "O meta-framework de como uma empresa funciona — o tecido conjuntivo entre todos os papéis do C-suite. Cobre seleção do sistema operacional (EOS, Scaling Up, OKR-nativo, híbrido), gráficos de accountability, scorecards, ritmo de reuniões, resolução de problemas e rocks de 90 dias. Use ao configurar operações da empresa, selecionar um framework de gestão, projetar ritmos de reuniões, construir sistemas de accountability, implementar OKRs ou quando o usuário mencionar EOS, Scaling Up, sistema operacional, reuniões L10, rocks, scorecard, gráfico de accountability ou planejamento trimestral."
license: MIT
metadata:
  version: 1.0.0
  author: Ric Neves - Flowgrammers
  category: c-level
  domain: company-operations
  updated: 2026-03-05
  frameworks: os-comparison, implementation-guide
agents:
  - claude-code
---

# Sistema Operacional da Empresa

O sistema operacional é a coleção de ferramentas, ritmos e acordos que determinam como a empresa funciona. Toda empresa tem um — a maioria simplesmente não sabe qual é. Torná-lo explícito o torna melhorável.

## Palavras-chave
sistema operacional, EOS, Entrepreneurial Operating System, Scaling Up, Rockefeller Habits, OKR, Holacracy, reunião L10, rocks, scorecard, gráfico de accountability, lista de problemas, IDS, ritmo de reuniões, planejamento trimestral, scorecard semanal, framework de gestão, ritmo da empresa, traction, Gino Wickman, Verne Harnish

## Por Que Isso Importa

A maioria das disfunções operacionais não é um problema de pessoas — é um problema de sistema. Quando:
- Os mesmos problemas recorrem toda semana: sem sistema de resolução de problemas
- Reuniões parecem inúteis: sem ritmo estruturado de reuniões
- Ninguém sabe quem é responsável por quê: sem gráfico de accountability
- Metas trimestrais escorregam: os rocks não são compromissos reais

Corrija o sistema. As pessoas vão operar melhor dentro dele.

## Os Seis Componentes Centrais

Todo sistema operacional eficaz tem estes seis, independentemente do framework que você escolher:

### 1. Gráfico de Accountability

Não é um organograma. Um gráfico de accountability responde: "Quem é responsável por este resultado?"

**Distinção-chave:** Uma pessoa é responsável por cada função. Múltiplas pessoas podem trabalhar nela. Responsabilidade significa que o dinheiro para com uma pessoa.

**Estrutura:**
```
CEO
├── Vendas (CRO/VP de Vendas)
│   ├── Pipeline inbound
│   └── Pipeline outbound
├── Produto e Engenharia (CTO/CPO)
│   ├── Roadmap de produto
│   └── Entrega de engenharia
├── Operações (COO)
│   ├── Sucesso do cliente
│   └── Financeiro e Jurídico
└── Pessoas (CHRO/VP de Pessoas)
    ├── Recrutamento
    └── Operações de pessoas
```

**Regras:**
- Sem responsabilidade compartilhada. "Alice e Bob são ambos responsáveis" significa que ninguém é.
- Uma pessoa pode ser responsável por múltiplas cadeiras nos estágios iniciais. Tudo bem. Apenas seja explícito.
- Revise trimestralmente à medida que você escala. A responsabilidade muda conforme a empresa cresce.

**Construa em um workshop:**
1. Liste todas as funções que a empresa executa
2. Atribua um responsável por função — sem exceções
3. Identifique lacunas (funções sem responsável) e sobreposições (funções que duas pessoas acreditam ser responsáveis)
4. Publique. Atualize quando algo mudar.

### 2. Scorecard

Métricas semanais que dizem se a empresa está no caminho certo. Não mensalmente. Não trimestralmente. Semanalmente.

**Regras:**
- Máximo de 5–15 métricas. Mais de 15 e nada recebe atenção.
- Cada métrica tem um responsável e uma meta semanal (não uma faixa — um número).
- Status vermelho/amarelo/verde. Não parágrafos.
- O scorecard é discutido na reunião semanal da equipe de liderança. Apenas métricas vermelhas recebem tempo de discussão.

**Exemplo de estrutura de scorecard:**

| Métrica | Responsável | Meta | Esta Semana | Status |
|--------|-------|--------|-----------|--------|
| Novo MRR | CRO | R$50K | R$43K | 🔴 |
| Churn | Líder de CS | < 1% | 0,8% | 🟢 |
| Usuários ativos | CPO | 2.000 | 2.150 | 🟢 |
| Deployments | CTO | 3/semana | 3 | 🟢 |
| Bugs críticos abertos | CTO | 0 | 2 | 🔴 |
| Runway | CFO | > 18 meses | 16 meses | 🟡 |

**Anti-padrão:** Medir tudo. Se você rastreia 40 KPIs, está observando, não gerenciando.

### 3. Ritmo de Reuniões

O ritmo de reuniões que conduz a empresa. Não é opcional — o ritmo é o que mantém a empresa viva.

**O ritmo completo:**

| Reunião | Frequência | Duração | Quem | Propósito |
|---------|-----------|----------|-----|---------|
| Standup diário | Diária | 15 min | Cada time | Apenas bloqueios |
| L10 / Sync de liderança | Semanal | 90 min | Time de liderança | Scorecard + problemas |
| Revisão de departamento | Mensal | 60 min | Dept + liderança | Progresso de OKR |
| Planejamento trimestral | Trimestral | 1–2 dias | Liderança | Definir rocks, revisar estratégia |
| Planejamento anual | Anual | 2–3 dias | Liderança | Visão de 1 ano + 3 anos |

**A reunião L10 (Sync Semanal de Liderança):**
Nomeada pelo objetivo de cada reunião ser um 10/10. Pauta fixa:
1. Boas notícias (5 min) — pessoais + negócios
2. Revisão de scorecard (5 min) — sinalize apenas itens vermelhos
3. Revisão de rocks (5 min) — no caminho/fora do caminho para cada rock
4. Manchetes de clientes/funcionários (5 min)
5. Lista de problemas (60 min) — IDS (veja abaixo)
6. Revisão de tarefas (5 min) — compromissos da semana passada
7. Encerramento (5 min) — avalie a reunião 1–10, o que a tornaria 10 na próxima vez

### 4. Resolução de Problemas (IDS)

O loop central de solução de problemas. Máximo de 15 minutos por problema.

**IDS: Identificar, Discutir, Solucionar**

- **Identificar:** Qual é o problema real? (Não o sintoma — a causa raiz) Declare em uma frase.
- **Discutir:** Fatos relevantes + perspectivas. Com prazo definido. Quando a discussão começa a se repetir, pare.
- **Solucionar:** Um responsável. Uma ação. Um prazo. Escrito na lista de tarefas.

**Anti-padrões:**
- "Vamos resolver isso fora" — a maioria das coisas resolvidas fora nunca são resolvidas
- Discutir sem decidir — uma ótima discussão sem item de ação é tempo desperdiçado
- Revisitar problemas decididos — uma vez resolvido, sai da lista. Reabra apenas com novas informações.

**A Lista de Problemas:** Uma lista contínua e priorizada de todos os problemas não resolvidos. Pertencente à equipe de liderança. Revisada e podada semanalmente. Se um problema está na lista por 3+ reuniões e não foi discutido, ou não é um problema real ou é assustador demais para abordar — ambos merecem atenção.

### 5. Rocks (Prioridades de 90 Dias)

Rocks são as 3–7 coisas mais importantes que cada pessoa deve realizar nos próximos 90 dias. Não são a descrição do cargo — são as coisas que fazem a empresa avançar.

**Por que 90 dias?** Longo o suficiente para progresso significativo. Curto o suficiente para permanecer real.

**Regras dos rocks:**
- Cada pessoa: máximo de 3–7 rocks. Mais de 7 e nenhum é concluído.
- Rocks em nível de empresa (prioridades compartilhadas): 3–7 para a equipe de liderança
- Cada rock é binário: concluído ou não concluído. Sem "60% completo."
- Defina na sessão de planejamento trimestral. Revisado semanalmente (no caminho/fora do caminho).

**Rock ruim:** "Melhorar nosso processo de vendas"
**Rock bom:** "Implementar CRM Salesforce com estágios completos de pipeline e relatórios semanais até 31 de março"

**Rock vs. tarefa:** Uma tarefa leva uma ação. Um rock leva 90 dias de trabalho consistente.

### 6. Cadência de Comunicação

Quem recebe qual informação, quando e como.

| Público | O quê | Quando | Formato |
|----------|------|------|--------|
| Todos os funcionários | Atualização da empresa | Mensal | Escrito + Q&A |
| Todos os funcionários | Resultados trimestrais + próximas prioridades | Trimestral | All-hands |
| Time de liderança | Scorecard | Semanal | Dashboard |
| Conselho | Desempenho da empresa | Mensal | Memo do conselho |
| Investidores | Métricas principais + narrativa | Mensal ou trimestral | Atualização para investidores |
| Clientes | Atualizações de produto | Por lançamento | Release notes |

**Regra padrão:** Se você está decidindo se deve compartilhar algo internamente, compartilhe. O custo da comunicação insuficiente sempre supera o custo da comunicação excessiva dentro de uma empresa.

---

## Seleção do Sistema Operacional

Veja `references/os-comparison.md` para comparação completa. Guia rápido:

| Se você é... | Considere... |
|---------------|-------------|
| Empresa de 10–250 pessoas, liderada por fundador, caos operacional | EOS / Traction |
| Empresa de crescimento ambicioso, precisa de cascata estratégica rigorosa | Scaling Up |
| Empresa de tecnologia, cultura de engenharia, orientada por hipótese | OKR-nativo |
| Descentralizado, plano, alta autonomia | Holacracy (apenas se você tiver paciência) |
| Nenhuma das anteriores se encaixa bem | Híbrido personalizado |

---

## Roadmap de Implementação

Não implemente tudo de uma vez. Veja `references/implementation-guide.md` para o plano completo de 90 dias.

**Início rápido (primeiros 30 dias):**
1. Construa o gráfico de accountability (1 workshop, 2 horas)
2. Defina 5–10 métricas semanais de scorecard (alinhamento da equipe de liderança, 1 hora)
3. Comece a reunião semanal L10 (sem preparação — apenas comece)

Estes três sozinhos vão melhorar a coordenação mais do que a maioria das empresas alcança em um ano.

---

## Modos de Falha Comuns

**Implementação parcial:** "Fazemos OKRs, mas pulamos o check-in semanal." Metade de um sistema operacional é pior do que nenhum — cria teatro sem accountability.

**Fadiga de reuniões:** Adicionar o ritmo completo sobre reuniões existentes. Comece substituindo reuniões, não adicionando.

**Sobrecarga de métricas:** Começar com 30 KPIs porque "todos importam." Comece com 5. Adicione quando a cadência estiver estabelecida.

**Inflação de rocks:** Definir 12 rocks por pessoa porque "tudo é prioridade." Quando tudo é prioridade, nada é. Limite rígido: 7.

**Não-compliance dos líderes:** A equipe de liderança pula o L10 ou não segue o IDS. O sistema operacional espelha o respeito que a liderança dá a ele. Se os líderes não levam a sério, ninguém vai.

**Planejamento anual sem revisão trimestral:** Definir metas anuais e verificar no final do ano. Trimestral é o ciclo mínimo de revisão para qualquer meta significativa.

---

## Integração com o C-Suite

O OS da empresa é o tecido conjuntivo. Todo outro papel depende dele:

| Papel do C-Suite | Dependência do OS |
|-------------|---------------|
| CEO | Define visão que alimenta o plano de 1 ano e os rocks |
| COO | Possui o ritmo de reuniões e a cadência de resolução de problemas |
| CFO | Possui as métricas financeiras no scorecard |
| CTO | Possui os rocks de engenharia e métricas técnicas do scorecard |
| CHRO | Possui métricas de pessoas (attrition, velocidade de contratação) no scorecard |
| Arquiteto de Cultura | Rituais de cultura se conectam ao ritmo de reuniões |
| Motor de Alinhamento Estratégico | Valida que os rocks do time cascateiam dos rocks da empresa |

---

## Perguntas-Chave para o Sistema Operacional

- "Se eu perguntasse a cinco líderes de time diferentes quais são as 3 prioridades principais da empresa neste trimestre, eles dariam as mesmas respostas?"
- "Qual foi o problema mais importante levantado na reunião de liderança da semana passada? Foi resolvido ou ainda está aberto?"
- "Nomeie uma métrica que nos diria até sexta-feira se esta semana foi uma boa semana. Nós a rastreamos?"
- "Quem é responsável pelo churn de clientes? Você consegue nomear essa pessoa sem hesitar?"
- "Quando foi a última vez que atualizamos o gráfico de accountability?"

## Referências Detalhadas
- `references/os-comparison.md` — EOS vs. Scaling Up vs. OKRs vs. Holacracy vs. híbrido
- `references/implementation-guide.md` — Plano de implementação de 90 dias
