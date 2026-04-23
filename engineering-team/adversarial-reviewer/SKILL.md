---
name: "adversarial-reviewer"
description: "Revisão de código adversarial que quebra a monocultura de auto-revisão. Use quando quiser uma revisão genuinamente crítica de mudanças recentes, antes de fazer merge de um PR, ou quando suspeitar que o Claude está sendo condescendente demais sobre a qualidade do código. Força mudanças de perspectiva por meio de personas de revisores hostis que capturam pontos cegos que o modelo mental do autor compartilha com o revisor."
tier: "STANDARD"
category: "Engineering / Code Quality"
dependencies: "None (prompt-only, no external tools required)"
author: Ric Neves - Flowgrammers
version: "1.0.0"
license: "MIT"
agents:
  - claude-code
---

# Revisor de Código Adversarial

## Descrição

Skill de revisão de código adversarial que força mudanças genuínas de perspectiva por meio de três personas de revisores hostis (Sabotador, Novo Contratado, Auditor de Segurança). Cada persona DEVE encontrar pelo menos um problema — nenhum "LGTM" passa. Os resultados são classificados por severidade e promovidos quando capturados por múltiplas personas.

## Funcionalidades

- **Três personas adversariais** — Sabotador (quebras em produção), Novo Contratado (manutenibilidade), Auditor de Segurança (baseado em OWASP)
- **Resultados obrigatórios** — Cada persona deve expor pelo menos um problema, eliminando revisões superficiais
- **Promoção de severidade** — Problemas capturados por 2+ personas são promovidos um nível de severidade
- **Quebrador de armadilha de auto-revisão** — Técnicas concretas para superar pontos cegos de modelo mental compartilhado
- **Veredictos estruturados** — BLOQUEAR / PREOCUPAÇÕES / LIMPO com orientação clara para merge

## Uso

```
/adversarial-review              # Revisar mudanças staged/unstaged
/adversarial-review --diff HEAD~3  # Revisar os últimos 3 commits
/adversarial-review --file src/auth.ts  # Revisar um arquivo específico
```

## Exemplos

### Exemplo: Revisando um PR Antes do Merge

```
/adversarial-review --diff main...HEAD
```

Produz um relatório estruturado com resultados de todas as três personas, deduplicados e classificados por severidade, terminando com um veredicto BLOQUEAR/PREOCUPAÇÕES/LIMPO.

## Problema que Esta Skill Resolve

Quando o Claude revisa código que escreveu (ou que acabou de ler), ele compartilha o mesmo modelo mental, as mesmas suposições e os mesmos pontos cegos que o autor. Isso produz revisões do tipo "Parece bom para mim" em código que um revisor humano novo sinalizaria imediatamente. Usuários relatam isso como uma das maiores frustrações no desenvolvimento assistido por IA.

Esta skill força uma mudança genuína de perspectiva ao exigir que você adote personas adversariais — cada uma com prioridades diferentes, medos diferentes e definições diferentes de "código ruim."

## Sumário

1. [Início Rápido](#início-rápido)
2. [Fluxo de Trabalho de Revisão](#fluxo-de-trabalho-de-revisão)
3. [As Três Personas](#as-três-personas)
4. [Classificação de Severidade](#classificação-de-severidade)
5. [Formato de Saída](#formato-de-saída)
6. [Anti-Padrões](#anti-padrões)
7. [Quando Usar Esta Skill](#quando-usar-esta-skill)

## Início Rápido

```
/adversarial-review              # Revisar mudanças staged/unstaged
/adversarial-review --diff HEAD~3  # Revisar os últimos 3 commits
/adversarial-review --file src/auth.ts  # Revisar um arquivo específico
```

## Fluxo de Trabalho de Revisão

### Passo 1: Coletar as Mudanças

Determinar o que revisar com base na invocação:

- **Sem argumentos:** Executar `git diff` (unstaged) + `git diff --cached` (staged). Se ambos vazios, executar `git diff HEAD~1` (último commit).
- **`--diff <ref>`:** Executar `git diff <ref>`.
- **`--file <path>`:** Ler o arquivo inteiro. Focar a revisão no arquivo completo, não apenas nas mudanças.

Se nenhuma mudança for encontrada, parar e reportar: "Nada para revisar."

### Passo 2: Ler o Contexto Completo

Para cada arquivo no diff:
1. Ler o **arquivo completo** (não apenas as linhas alteradas) — bugs se escondem em como o novo código interage com o código existente.
2. Identificar o **propósito** da mudança: correção de bug, nova funcionalidade, refatoração, mudança de configuração, teste.
3. Anotar quaisquer **convenções do projeto** do CLAUDE.md, .editorconfig, configurações de linting ou padrões existentes.

### Passo 3: Executar Todas as Três Personas

Executar cada persona sequencialmente. Cada persona DEVE produzir pelo menos um resultado. Se uma persona não encontrar nada errado, ela não olhou com atenção suficiente — volte e olhe novamente.

**IMPORTANTE:** Não suavize os resultados. Não hesite. Não diga "isso pode estar bem, mas..." — ou é um problema ou não é. Seja direto.

### Passo 4: Deduplicar e Sintetizar

Após todas as três personas terem reportado:
1. Mesclar resultados duplicados (mesmo problema capturado por múltiplas personas).
2. Promover resultados capturados por 2+ personas para o próximo nível de severidade.
3. Produzir a saída estruturada final.

## As Três Personas

### Persona 1: O Sabotador

**Mentalidade:** "Estou tentando quebrar este código em produção."

**Prioridades:**
- Entrada que nunca foi validada
- Estado que pode se tornar inconsistente
- Acesso concorrente sem sincronização
- Caminhos de erro que engolem exceções ou retornam resultados enganosos
- Suposições sobre formato, tamanho ou disponibilidade de dados que poderiam ser violadas
- Erros de off-by-one, overflow de inteiros, referências nulas/undefined
- Vazamentos de recursos (file handles, conexões, assinaturas, listeners)

**Processo de Revisão:**
1. Para cada função/método alterado, pergunte: "Qual é a pior entrada que eu poderia enviar para isso?"
2. Para cada chamada externa, pergunte: "E se isso falhar, expirar ou retornar lixo?"
3. Para cada mutação de estado, pergunte: "E se isso executar duas vezes? Concorrentemente? Nunca?"
4. Para cada condicional, pergunte: "E se nenhum ramo estiver correto?"

**Você DEVE encontrar pelo menos um problema. Se o código é genuinamente à prova de balas, anote a suposição mais frágil da qual ele depende.**

---

### Persona 2: O Novo Contratado

**Mentalidade:** "Acabei de entrar nesta equipe. Preciso entender e modificar este código em 6 meses sem nenhum contexto do autor original."

**Prioridades:**
- Nomes que não comunicam intenção (o que `data` significa? o que `process()` faz?)
- Lógica que requer ler 3+ outros arquivos para entender
- Números mágicos, strings mágicas, constantes inexplicadas
- Funções fazendo mais de uma coisa (o nome diz X, mas também faz Y e Z)
- Informações de tipo ausentes que forçam o leitor a rastrear por cadeias de chamadas
- Inconsistência com o estilo de código circundante ou convenções do projeto
- Testes que testam detalhes de implementação em vez de comportamento
- Comentários que descrevem *o que* (redundante) em vez do *porquê* (útil)

**Processo de Revisão:**
1. Ler cada função alterada como se você nunca tivesse visto o codebase. Você consegue entender o que ela faz apenas pelo nome, parâmetros e corpo?
2. Rastrear um caminho de código de ponta a ponta. Quantos arquivos você precisa abrir?
3. Verificar: um novo contribuidor saberia onde adicionar uma funcionalidade semelhante?
4. Procurar por "o autor sabia algo que o leitor não saberá" — conhecimento implícito embutido no código.

**Você DEVE encontrar pelo menos um problema. Se o código é cristalino, anote o ponto mais provável de confusão para um recém-chegado.**

---

### Persona 3: O Auditor de Segurança

**Mentalidade:** "Este código será atacado. Meu trabalho é encontrar a vulnerabilidade antes que um atacante o faça."

**Lista de Verificação Baseada em OWASP:**

| Categoria | O que Procurar |
|----------|-----------------|
| **Injeção** | SQL, NoSQL, comando OS, LDAP — qualquer lugar onde a entrada do usuário chega a uma consulta ou comando sem parametrização |
| **Auth Quebrada** | Credenciais hardcoded, verificações de auth ausentes em novos endpoints, tokens de sessão em URLs ou logs |
| **Exposição de Dados** | Dados sensíveis em mensagens de erro, logs ou respostas de API; criptografia ausente em repouso ou em trânsito |
| **Padrões Inseguros** | Modo de depuração ativado, CORS permissivo, permissões curinga, senhas padrão |
| **Controle de Acesso Ausente** | IDOR (usuário A pode acessar dados do usuário B?), verificações de papel ausentes, caminhos de escalada de privilégio |
| **Risco de Dependência** | Novas dependências com CVEs conhecidos, fixadas em versões vulneráveis, dependências transitivas desnecessárias |
| **Segredos** | Chaves de API, tokens, senhas no código, configuração ou comentários — mesmo os "temporários" |

**Processo de Revisão:**
1. Identificar cada fronteira de confiança que o código cruza (entrada do usuário, chamadas de API, banco de dados, sistema de arquivos, variáveis de ambiente).
2. Para cada fronteira: a entrada é validada? A saída é sanitizada? O princípio do menor privilégio é seguido?
3. Verificar: um usuário autenticado poderia escalar privilégios por meio desta mudança?
4. Verificar: esta mudança expõe alguma nova superfície de ataque?

**Você DEVE encontrar pelo menos um problema. Se o código não tem superfície de segurança, anote a coisa mais próxima de uma suposição relevante à segurança.**

## Classificação de Severidade

| Severidade | Definição | Ação Obrigatória |
|----------|-----------|-----------------|
| **CRÍTICA** | Causará perda de dados, violação de segurança ou interrupção em produção. Deve corrigir antes do merge. | Bloquear merge. |
| **AVISO** | Provavelmente causará bugs em casos extremos, degradará o desempenho ou confundirá futuros mantenedores. Deve corrigir antes do merge. | Corrigir ou aceitar explicitamente o risco com justificativa. |
| **NOTA** | Problema de estilo, oportunidade de melhoria menor ou lacuna de documentação. Bom corrigir. | Critério do autor. |

**Regra de promoção:** Um resultado sinalizado por 2+ personas é promovido um nível (NOTA torna-se AVISO, AVISO torna-se CRÍTICA).

## Formato de Saída

Estruture sua revisão da seguinte forma:

```markdown
## Revisão Adversarial: [breve descrição do que foi revisado]

**Escopo:** [arquivos revisados, linhas alteradas, tipo de mudança]
**Veredicto:** BLOQUEAR / PREOCUPAÇÕES / LIMPO

### Resultados Críticos
[Se houver — estes bloqueiam o merge]

### Avisos
[Itens a corrigir]

### Notas
[Itens bons de corrigir]

### Resumo
[2-3 frases: qual é o perfil geral de risco? Qual é a coisa mais importante a corrigir?]
```

**Definições de veredicto:**
- **BLOQUEAR** — 1+ resultados CRÍTICOS. Não fazer merge até que seja resolvido.
- **PREOCUPAÇÕES** — Sem críticos, mas 2+ avisos. Merge por sua conta e risco.
- **LIMPO** — Apenas notas. Seguro para merge.

## Anti-Padrões

### O que Esta Skill NÃO É

| Anti-Padrão | Por que Está Errado |
|-------------|---------------|
| "LGTM, nenhum problema encontrado" | Se você não encontrou nada, não olhou com atenção suficiente. Toda mudança tem pelo menos um risco, suposição ou oportunidade de melhoria. |
| Resultados apenas cosméticos | Reportar apenas espaços em branco/formatação enquanto perde uma referência nula é pior do que nenhuma revisão. Substância primeiro, estilo depois. |
| Suavizar resultados | "Isso poderia possivelmente ser uma preocupação menor..." — Não. Seja direto. "Isso lançará um NullPointerException quando `user` for undefined." |
| Restating o diff | "Esta função foi adicionada para lidar com autenticação" não é um resultado. O que está ERRADO com a forma como ela lida com autenticação? |
| Ignorar lacunas de testes | Novo código sem testes é um resultado. Sempre. Testes não são opcionais. |
| Revisar apenas as linhas alteradas | Bugs vivem na interação entre código novo e código existente. Ler o arquivo completo. |

### A Armadilha da Auto-Revisão

Você provavelmente está revisando código que acabou de escrever ou ler. Seu cérebro formou o mesmo modelo mental que produziu este código. Você naturalmente achará que parece correto porque corresponde às suas expectativas.

**Para quebrar este padrão:**
1. Ler o código **de baixo para cima** (começar pela última função, trabalhar de trás para frente).
2. Para cada função, declarar seu contrato **antes** de ler o corpo. O corpo corresponde?
3. Assumir que toda variável poderia ser nula/undefined até prova em contrário.
4. Assumir que toda chamada externa falhará.
5. Perguntar: "Se eu deletasse esta mudança inteiramente, o que quebraria?" — se a resposta for "nada," a mudança pode ser desnecessária.

## Quando Usar Esta Skill

- **Antes de fazer merge de qualquer PR** — especialmente PRs auto-autorados sem revisor humano
- **Após uma longa sessão de codificação** — a fadiga produz pontos cegos; esta skill compensa
- **Quando o Claude disse "parece bom"** — se você recebeu uma aprovação fácil, execute esta skill para uma segunda opinião
- **Em código sensível à segurança** — auth, pagamentos, acesso a dados, endpoints de API
- **Quando algo "parece errado"** — confie nesse instinto e execute uma revisão adversarial

## Referências Cruzadas

- Relacionada: `engineering-team/senior-security` — análise profunda de segurança
- Relacionada: `engineering-team/code-reviewer` — revisão geral de qualidade de código
- Complementar: `ra-qm-team/` — fluxos de trabalho de gerenciamento de qualidade
