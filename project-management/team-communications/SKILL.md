---
name: team-communications
description: Escreve comunicações internas da empresa — atualizações 3P (Progresso/Planos/Problemas), newsletters corporativas, resumos de FAQ, relatórios de incidentes, atualizações de liderança, relatórios de status, atualizações de projeto e comunicações internas em geral. Use esta skill sempre que o usuário solicitar redigir, editar ou formatar algo destinado a audiências internas. Acione com palavras-chave como "3P", "atualização semanal", "newsletter", "FAQ", "comunicação interna", "relatório de status", "atualização da empresa", "atualização da equipe", "relatório de incidente" ou qualquer solicitação de resumir trabalho para liderança, colegas ou a empresa em geral. Mesmo solicitações casuais como "escreva minha atualização" ou "resuma o que minha equipe fez essa semana" devem acionar esta skill.
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Comunicações Internas

> Contribuído originalmente por [maximcoding](https://github.com/maximcoding) — aprimorado e integrado pela equipe claude-skills.

Escrever comunicações internas polidas carregando o arquivo de referência correto, coletando contexto e produzindo saída no formato exato da empresa.

## Roteamento

Identificar o tipo de comunicação a partir da solicitação do usuário, então ler o arquivo de referência correspondente antes de escrever qualquer coisa:

| Tipo | Frases gatilho | Arquivo de referência |
|---|---|---|
| **Atualização 3P** | "3P", "progresso planos problemas", "atualização semanal da equipe", "o que entregamos" | `references/3p-updates.md` |
| **Newsletter** | "newsletter", "atualização da empresa", "resumo semanal/mensal", "resumo de all-hands" | `references/company-newsletter.md` |
| **FAQ** | "FAQ", "perguntas comuns", "o que as pessoas estão perguntando", "confusão em torno de" | `references/faq-answers.md` |
| **Geral** | qualquer comunicação interna que não se encaixe acima | `references/general-comms.md` |

Se o tipo for ambíguo, fazer uma pergunta de esclarecimento — não adivinhar.

## Fluxo de Trabalho

1. **Ler o arquivo de referência** para o tipo identificado. Seguir sua formatação exatamente.
2. **Coletar entradas.** Usar ferramentas MCP disponíveis (Slack, Gmail, Google Drive, Calendar) para extrair dados reais. Se nenhuma ferramenta estiver conectada, pedir ao usuário que forneça bullet points ou contexto bruto.
3. **Esclarecer escopo.** Confirmar: nome da equipe (para 3Ps), período de tempo, audiência e quaisquer itens específicos que o usuário queira incluir ou excluir.
4. **Redigir.** Seguir o formato, tom e restrições de comprimento do arquivo de referência com precisão. Não inventar um novo formato.
5. **Apresentar o rascunho** e perguntar se algo precisa ser adicionado, removido ou reformulado.

## Tom e Estilo (aplica-se a todos os tipos)

- Use "nós" — você faz parte da empresa.
- Voz ativa, tempo presente para progresso, tempo futuro para planos.
- Conciso. Cada frase deve carregar informação. Cortar relleno.
- Incluir métricas e links sempre que possível.
- Profissional mas acessível — não linguagem corporativa.
- Colocar a informação mais importante primeiro.

## Quando as ferramentas estão indisponíveis

Se o usuário não conectou Slack, Gmail, Drive ou Calendar, não travar. Pedir que colem ou descrevam o que querem cobrir. Você está formatando e aprimorando — isso ainda tem valor. Mencionar que as ferramentas melhorariam rascunhos futuros para que possam conectá-las mais tarde.

---

## Antipadrões

| Antipadrão | Por que Falha | Melhor Abordagem |
|---|---|---|
| Escrever atualizações sem ler o template de referência primeiro | A saída não vai corresponder ao formato da empresa — o usuário terá que reformatar | Sempre carregar o arquivo de referência correspondente antes de redigir |
| Inventar métricas ou realizações | Comunicações internas devem ser factuais — fabricação destrói confiança | Incluir apenas dados que o usuário forneceu ou que as ferramentas MCP recuperaram |
| Usar voz passiva para realizações | "A funcionalidade foi entregue" esconde quem fez o trabalho | "A equipe X entregou a funcionalidade" — voz ativa credita a equipe |
| Escrever paredes de texto para atualizações de status | A liderança escaneia, não lê — informações principais ficam enterradas | Liderar com o título, seguir com 3-5 bullet points |
| Enviar sem confirmar a audiência | Uma atualização de equipe é diferente de uma newsletter para toda a empresa | Sempre confirmar: quem vai ler isso? |

---

## Skills Relacionadas

| Skill | Relacionamento |
|-------|-------------|
| `project-management/senior-pm` | Escopo mais amplo de PM — relatórios de status alimentam os relatórios de PM |
| `project-management/meeting-analyzer` | Insights de reunião podem alimentar atualizações 3P e relatórios de status |
| `project-management/confluence-expert` | Publicar comunicações como páginas Confluence para registro permanente |
| `marketing-skill/content-production` | Comunicações externas — usar para conteúdo público, não interno |
