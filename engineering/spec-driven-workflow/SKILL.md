---
name: "spec-driven-workflow"
description: "Use quando o usuário pede para escrever specs antes do código, definir critérios de aceitação, planejar funcionalidades antes da implementação, gerar testes a partir de especificações, ou seguir práticas de desenvolvimento spec-first."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Spec-Driven Workflow — PODEROSO

## Visão Geral

O fluxo de trabalho orientado por spec impõe uma única regra inegociável: **escreva a especificação ANTES de escrever qualquer código.** Não junto. Não depois. Antes.

Isso não é documentação. Isso é um contrato. Uma spec define o que o sistema DEVE fazer, o que DEVERIA fazer e o que explicitamente NÃO FARÁ. Cada linha de código que você escreve remonta a um requisito na spec. Cada teste remonta a um critério de aceitação. Se não estiver na spec, não será construído.

### Por Que Spec-First Importa

1. **Elimina retrabalho.** 60-80% dos defeitos se originam dos requisitos, não da implementação. Detectar ambiguidade em uma spec custa minutos; detectá-la em produção custa dias.
2. **Força clareza.** Se você não consegue escrever o que o sistema deve fazer em linguagem simples, você não entende o problema bem o suficiente para escrever código.
3. **Habilita paralelismo.** Uma vez que a spec é aprovada, frontend, backend, QA e documentação podem todos começar simultaneamente.
4. **Cria responsabilidade.** A spec é a definição de pronto. Sem discussões sobre se um recurso está "completo" — ou satisfaz os critérios de aceitação ou não satisfaz.
5. **Alimenta o TDD diretamente.** Critérios de aceitação no formato Dado/Quando/Então se traduzem 1:1 em casos de teste. A spec É o plano de testes.

### A Lei de Ferro

```
SEM CÓDIGO SEM UMA SPEC APROVADA.
SEM EXCEÇÕES. SEM "PROTÓTIPOS RÁPIDOS". SEM "VOU DOCUMENTAR DEPOIS."
```

Se a spec não foi escrita, revisada e aprovada, a implementação não começa. Ponto final.

---

## O Formato da Spec

Toda spec segue esta estrutura. Nenhuma seção é opcional — se uma seção não se aplica, escreva "N/A — [motivo]" para que os revisores saibam que foi considerada, não esquecida.

### Seções Obrigatórias

| # | Seção | Regras Principais |
|---|---------|-----------|
| 1 | **Título e Metadados** | Autor, data, status (Rascunho/Em Revisão/Aprovado/Substituído), revisores |
| 2 | **Contexto** | Por que este recurso existe. 2-4 parágrafos com evidências (métricas, tickets). |
| 3 | **Requisitos Funcionais** | Palavras-chave RFC 2119 (DEVE/DEVERIA/PODE). Numerados como RF-N. Cada um é atômico e testável. |
| 4 | **Requisitos Não-Funcionais** | Desempenho, segurança, acessibilidade, escalabilidade, confiabilidade — todos com limites mensuráveis. |
| 5 | **Critérios de Aceitação** | Formato Dado/Quando/Então. Cada CA referencia pelo menos um RF-* ou RNF-*. |
| 6 | **Casos Extremos** | Numerados como CE-N. Cobrir modos de falha para cada dependência externa. |
| 7 | **Contratos de API** | Interfaces no estilo TypeScript. Cobrir respostas de sucesso e erro. |
| 8 | **Modelos de Dados** | Formato de tabela com campo, tipo, restrições. Toda entidade dos requisitos deve ter um modelo. |
| 9 | **Fora do Escopo** | Exclusões explícitas com motivos. Previne expansão de escopo durante a implementação. |

### Palavras-Chave RFC 2119

| Palavra-Chave | Significado |
|---------|---------|
| **DEVE** | Requisito absoluto. Não conformante sem ele. |
| **NÃO DEVE** | Proibição absoluta. |
| **DEVERIA** | Recomendado. Omitir apenas com justificativa documentada. |
| **PODE** | Opcional. Discrição do implementador. |

Consulte [spec_format_guide.md](references/spec_format_guide.md) para o template completo com exemplos seção a seção, padrões bons/ruins de requisitos e templates por tipo de recurso (CRUD, Integração, Migração).

Consulte [acceptance_criteria_patterns.md](references/acceptance_criteria_patterns.md) para uma biblioteca completa de padrões de critérios Dado/Quando/Então para autenticação, CRUD, busca, upload de arquivo, pagamento, notificação e cenários de acessibilidade.

---

## Regras de Autonomia Limitada

Estas regras definem quando um agente (humano ou IA) DEVE parar e pedir orientação versus quando pode prosseguir independentemente.

### PARAR e Perguntar Quando:

1. **Expansão de escopo detectada.** A implementação requer algo não presente na spec. Mesmo que pareça obviamente necessário, PARE. A spec pode ter excluído deliberadamente.

2. **Ambiguidade excede 30%.** Se você não consegue determinar o comportamento correto a partir da spec para mais de 30% de um dado requisito, a spec está incompleta. Não adivinhe.

3. **Mudanças disruptivas necessárias.** A implementação mudaria um contrato de API existente, esquema de banco de dados ou interface pública. Sempre escale.

4. **Implicações de segurança.** Qualquer mudança que toque autenticação, autorização, criptografia ou tratamento de PII requer aprovação explícita.

5. **Características de desempenho desconhecidas.** Se um requisito diz "DEVE concluir em < 500ms" mas você não tem como medir ou garantir isso, escale antes de implementar um palpite.

6. **Dependências entre equipes.** Se a spec requer coordenação com outra equipe ou serviço, confirme a dependência antes de construir contra ela.

### Continuar Autonomamente Quando:

1. **Spec é clara e inequívoca** para a tarefa atual.
2. **Todos os critérios de aceitação têm testes passando** e você está refatorando internos.
3. **Mudanças são não-disruptivas** — sem mudanças de API pública, esquema ou comportamento.
4. **Implementação é uma tradução direta** de um critério de aceitação bem definido.
5. **Tratamento de erros segue padrões estabelecidos** já documentados na base de código.

### Protocolo de Escalonamento

Quando você deve parar, forneça:

```markdown
## Escalonamento: [Título Breve]

**Bloqueado em:** [ID do requisito, ex.: RF-3]
**Questão:** [Pergunta específica e respondível — não "o que devo fazer?"]
**Opções consideradas:**
  A. [Opção] — Prós: [...] Contras: [...]
  B. [Opção] — Prós: [...] Contras: [...]
**Minha recomendação:** [A ou B, com raciocínio]
**Impacto de esperar:** [O que está bloqueado até isso ser resolvido?]
```

Nunca escale sem uma recomendação. Nunca apresente uma pergunta aberta. Sempre dê opções.

Consulte `references/bounded_autonomy_rules.md` para a matriz completa de decisão.

---

## Fluxo de Trabalho — 6 Fases

### Fase 1: Coletar Requisitos

**Objetivo:** Entender o que precisa ser construído e por quê.

1. **Entrevistar o usuário.** Perguntar:
   - Que problema isso resolve?
   - Quem são os usuários?
   - Como é o sucesso?
   - O que explicitamente NÃO deve ser construído?
2. **Ler o código existente.** Entender o sistema atual antes de propor mudanças.
3. **Identificar restrições.** Orçamentos de desempenho, requisitos de segurança, compatibilidade retroativa.
4. **Listar desconhecidos.** Cada desconhecido é um risco. Exponha-os agora, não durante a implementação.

**Critério de saída:** Você pode explicar o recurso para alguém não familiarizado com o projeto em 2 minutos.

### Fase 2: Escrever Spec

**Objetivo:** Produzir um documento de spec completo seguindo O Formato da Spec acima.

1. Preencher cada seção do template. Nenhuma seção em branco.
2. Numerar todos os requisitos (RF-*, RNF-*, CA-*, CE-*, FE-*).
3. Usar palavras-chave RFC 2119 com precisão.
4. Escrever critérios de aceitação no formato Dado/Quando/Então.
5. Definir contratos de API com tipos no estilo TypeScript.
6. Listar exclusões explícitas em Fora do Escopo.

**Critério de saída:** A spec pode ser entregue a um desenvolvedor que não estava na reunião de requisitos, e ele pode implementar o recurso sem fazer perguntas de esclarecimento.

### Fase 3: Validar Spec

**Objetivo:** Verificar se a spec está completa, consistente e implementável.

Executar `spec_validator.py` contra o arquivo de spec:

```bash
python spec_validator.py --file spec.md --strict
```

Lista de verificação de validação manual:
- [ ] Todo requisito funcional tem pelo menos um critério de aceitação
- [ ] Todo critério de aceitação é testável (sem linguagem subjetiva)
- [ ] Contratos de API cobrem todos os endpoints mencionados nos requisitos
- [ ] Modelos de dados cobrem todas as entidades mencionadas nos requisitos
- [ ] Casos extremos cobrem modos de falha para cada dependência externa
- [ ] Fora do escopo é explícito sobre o que foi considerado e rejeitado
- [ ] Requisitos não-funcionais têm limites mensuráveis

**Critério de saída:** Spec pontua 80+ no validador, e todos os itens da lista de verificação manual passam.

### Fase 4: Gerar Testes

**Objetivo:** Extrair casos de teste dos critérios de aceitação antes de escrever o código de implementação.

Executar `test_extractor.py` contra a spec aprovada:

```bash
python test_extractor.py --file spec.md --framework pytest --output tests/
```

1. Cada critério de aceitação se torna um ou mais casos de teste.
2. Cada caso extremo se torna um caso de teste.
3. Os testes são stubs — definem a asserção mas não a implementação.
4. Todos os testes DEVEM falhar inicialmente (fase vermelha do TDD).

**Critério de saída:** Você tem um arquivo de teste onde todo teste falha com "não implementado" ou equivalente.

### Fase 5: Implementar

**Objetivo:** Escrever código que faça os testes com falha passarem, um critério de aceitação por vez.

1. Escolher um critério de aceitação (começar pelo mais simples).
2. Fazer seus teste(s) passarem com código mínimo.
3. Executar o conjunto completo de testes — sem regressões.
4. Fazer commit.
5. Escolher o próximo critério de aceitação. Repetir.

**Regras:**
- NÃO implementar nada que não esteja na spec.
- NÃO otimizar antes de todos os critérios de aceitação passarem.
- NÃO refatorar antes de todos os critérios de aceitação passarem.
- Se você descobrir um requisito ausente, PARE e atualize a spec primeiro.

**Critério de saída:** Todos os testes passam. Todos os critérios de aceitação satisfeitos.

### Fase 6: Auto-Revisão

**Objetivo:** Verificar se a implementação corresponde à spec antes de marcar como pronto.

Percorrer a Lista de Verificação de Auto-Revisão abaixo. Se algum item falhar, corrija antes de declarar a tarefa concluída.

---

## Lista de Verificação de Auto-Revisão

Antes de marcar qualquer implementação como pronta, verificar TODOS os seguintes:

- [ ] **Todo critério de aceitação tem um teste passando.** Sem exceções. Se CA-3 existe, um teste para CA-3 existe e passa.
- [ ] **Todo caso extremo tem um teste.** CE-1 a CE-N todos têm casos de teste correspondentes.
- [ ] **Sem expansão de escopo.** A implementação não inclui recursos não presentes na spec. Se você adicionou algo, atualize a spec ou remova-o.
- [ ] **Contratos de API correspondem à implementação.** Formatos de requisição/resposta no código correspondem à spec exatamente. Nomes de campos, tipos, códigos de status — tudo isso.
- [ ] **Cenários de erro testados.** Toda resposta de erro definida na spec tem um teste que a aciona.
- [ ] **Requisitos não-funcionais verificados.** Se a spec diz < 500ms, você tem evidências (benchmark, teste de carga, profiling) de que atende ao limite.
- [ ] **Modelo de dados corresponde.** Esquema de banco de dados corresponde à spec. Sem colunas extras, sem restrições ausentes.
- [ ] **Itens fora do escopo não construídos.** Verificar novamente que nada da seção Fora do Escopo vazou para a implementação.

---

## Integração com Guia de TDD

O fluxo de trabalho orientado por spec e o TDD são complementares, não concorrentes:

```
Spec-Driven Workflow          TDD (Red-Green-Refactor)
─────────────────────         ──────────────────────────
Fase 1: Coletar Requisitos
Fase 2: Escrever Spec
Fase 3: Validar Spec
Fase 4: Gerar Testes     ──→  VERMELHO: Testes existem e falham
Fase 5: Implementar      ──→  VERDE: Código mínimo para passar
Fase 6: Auto-Revisão     ──→  REFATORAR: Limpar internos
```

**A transferência:** O fluxo de trabalho orientado por spec produz os stubs de teste (Fase 4). O TDD assume a partir daí. A spec diz O QUE testar. O TDD diz COMO implementar.

Use `engineering-team/tdd-guide` para:
- Disciplina do ciclo red-green-refactor
- Análise de cobertura e detecção de lacunas
- Padrões de teste específicos por framework (Jest, Pytest, JUnit)

Use `engineering/spec-driven-workflow` para:
- Definir o que construir antes de construir
- Autoria de critérios de aceitação
- Validação de completude
- Controle de escopo

---

## Exemplos

Um exemplo completo trabalhado (spec de Redefinição de Senha com casos de teste extraídos) está disponível em [spec_format_guide.md](references/spec_format_guide.md#full-example-password-reset). Demonstra todas as 9 seções, numeração de requisitos, critérios de aceitação, casos extremos e os stubs de pytest correspondentes gerados por `test_extractor.py`.

---

## Anti-Padrões

### 1. Codificar Antes da Aprovação da Spec

**Sintoma:** "Vou começar a codificar enquanto a spec está sendo revisada."
**Problema:** A revisão levantará mudanças. Agora você tem código que implementa um design rejeitado.
**Regra:** A implementação não começa até que o status da spec seja "Aprovado."

### 2. Critérios de Aceitação Vagos

**Sintoma:** "O sistema deve funcionar bem" ou "A UI deve ser responsiva."
**Problema:** Não testável. O que "bem" significa? O que "responsiva" significa?
**Regra:** Todo critério de aceitação deve ser verificável por uma máquina. Se você não consegue escrever um teste para ele, reescreva o critério.

### 3. Casos Extremos Ausentes

**Sintoma:** O caminho feliz é especificado, os caminhos de erro não são.
**Problema:** Os desenvolvedores inventam tratamento de erros on-the-fly, levando a comportamento inconsistente.
**Regra:** Para cada dependência externa (API, banco de dados, sistema de arquivos, entrada do usuário), especifique pelo menos um cenário de falha.

### 4. Spec como Documentação Post-Hoc

**Sintoma:** "Deixa eu escrever a spec agora que o recurso está pronto."
**Problema:** Isso é documentação, não especificação. Descreve o que foi construído, não o que deveria ter sido construído. Não pode detectar erros de design porque o design já está congelado.
**Regra:** Se a spec foi escrita após o código, não é uma spec. Rotule como documentação.

### 5. Gold-Plating Além da Spec

**Sintoma:** "Enquanto estava lá, também adicionei..."
**Problema:** Código não testado. Design não revisado. Potencial para bugs sutis no recurso "bônus".
**Regra:** Se não está na spec, não é construído. Crie uma nova spec para recursos adicionais.

### 6. Critérios de Aceitação Sem Rastreabilidade de Requisito

**Sintoma:** CA-7 existe mas não referencia nenhum RF-* ou RNF-*.
**Problema:** Critérios órfãos significam que um requisito está ausente ou o critério é desnecessário.
**Regra:** Todo CA-* DEVE referenciar pelo menos um RF-* ou RNF-*.

### 7. Pular a Validação

**Sintoma:** "A spec parece boa, vamos começar."
**Problema:** Seções ausentes descobertas durante a implementação causam atrasos bloqueantes.
**Regra:** Sempre execute `spec_validator.py --strict` antes de iniciar a implementação. Corrija todos os avisos.

---

## Referências Cruzadas

- **`engineering-team/tdd-guide`** — Ciclo red-green-refactor, geração de testes, análise de cobertura. Use após a Fase 4 deste fluxo de trabalho.
- **`engineering/focused-fix`** — Reparo profundo de recurso. Quando uma implementação orientada por spec tem problemas sistêmicos, use focused-fix para diagnóstico.
- **`engineering/rag-architect`** — Se o recurso envolve recuperação ou sistemas de conhecimento, use rag-architect para o design técnico dentro da spec.
- **`references/spec_format_guide.md`** — Template completo com explicações seção a seção.
- **`references/bounded_autonomy_rules.md`** — Matriz completa de decisão para quando parar versus continuar.
- **`references/acceptance_criteria_patterns.md`** — Biblioteca de padrões para escrever critérios Dado/Quando/Então.

---

## Ferramentas

| Script | Propósito | Flags Principais |
|--------|---------|-----------|
| `spec_generator.py` | Gerar template de spec a partir do nome/descrição do recurso | `--name`, `--description`, `--format`, `--json` |
| `spec_validator.py` | Validar completude da spec (pontuação 0-100) | `--file`, `--strict`, `--json` |
| `test_extractor.py` | Extrair stubs de teste dos critérios de aceitação | `--file`, `--framework`, `--output`, `--json` |

```bash
# Gerar um template de spec
python spec_generator.py --name "User Authentication" --description "OAuth 2.0 login flow"

# Validar uma spec
python spec_validator.py --file specs/auth.md --strict

# Extrair casos de teste
python test_extractor.py --file specs/auth.md --framework pytest --output tests/test_auth.py
```
