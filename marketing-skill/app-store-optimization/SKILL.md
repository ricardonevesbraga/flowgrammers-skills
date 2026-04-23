---
name: "app-store-optimization"
description: Kit de ASO (App Store Optimization) para pesquisar palavras-chave, analisar rankings de concorrentes, gerar sugestões de metadados e melhorar a visibilidade do app na Apple App Store e Google Play Store. Use quando o usuário perguntar sobre ASO, rankings na app store, metadados do app, títulos e descrições de apps, listagens na app store, visibilidade do app, ou marketing de apps mobile no iOS ou Android. Suporta pesquisa e pontuação de palavras-chave, análise de palavras-chave de concorrentes, otimização de metadados, planejamento de testes A/B, checklists de lançamento e rastreamento de mudanças de ranking.
triggers:
  - ASO
  - app store optimization
  - app store ranking
  - app keywords
  - app metadata
  - play store optimization
  - app store listing
  - improve app rankings
  - app visibility
  - app store SEO
  - mobile app marketing
  - app conversion rate
agents:
  - claude-code
---

# App Store Optimization (ASO)

---

## Fluxo de Pesquisa de Palavras-Chave

Descubra e avalie palavras-chave que impulsionam a visibilidade na app store.

### Fluxo de Trabalho: Conduzir Pesquisa de Palavras-Chave

1. Defina o público-alvo e as funções principais do app:
   - Caso de uso principal (que problema o app resolve)
   - Dados demográficos do usuário meta
   - Categoria competitiva
2. Gere palavras-chave semente a partir de:
   - Funcionalidades e benefícios do app
   - Linguagem do usuário (não terminologia do desenvolvedor)
   - Sugestões de autocompletar da app store
3. Expanda a lista de palavras-chave usando:
   - Modificadores (gratuito, melhor, simples)
   - Ações (criar, rastrear, organizar)
   - Públicos (para estudantes, para times, para negócios)
4. Avalie cada palavra-chave:
   - Volume de pesquisa (pesquisas mensais estimadas)
   - Concorrência (número e qualidade dos apps ranqueados)
   - Relevância (alinhamento com a função do app)
5. Pontue e priorize palavras-chave:
   - Primárias: Campo de título e palavras-chave (iOS)
   - Secundárias: Subtítulo e descrição curta
   - Terciárias: Apenas descrição completa
6. Mapeie palavras-chave para locais de metadados
7. Documente a estratégia de palavras-chave para rastreamento
8. **Validação:** Palavras-chave pontuadas; posicionamento mapeado; sem nomes de marcas de concorrentes; sem plurais no campo de palavras-chave iOS

### Critérios de Avaliação de Palavras-Chave

| Fator | Peso | Indicadores de Alta Pontuação |
|-------|------|-------------------------------|
| Relevância | 35% | Descreve a função principal do app |
| Volume | 25% | 10.000+ pesquisas mensais |
| Concorrência | 25% | Top 10 apps têm média de avaliação <4,5 |
| Conversão | 15% | Intenção transacional ("melhor app X") |

### Prioridade de Posicionamento de Palavras-Chave

| Local | Peso de Pesquisa |
|-------|-----------------|
| Título do App | Mais alto |
| Subtítulo (iOS) | Alto |
| Campo de Palavras-Chave (iOS) | Alto |
| Descrição Curta (Android) | Alto |
| Descrição Completa | Médio |

Veja: [references/palavra-chave-research-guide.md](references/palavra-chave-research-guide.md)

---

## Fluxo de Otimização de Metadados

Otimize os elementos da listagem na app store para ranqueamento de busca e conversão.

### Fluxo de Trabalho: Otimizar Metadados do App

1. Audite os metadados atuais contra os limites da plataforma:
   - Contagem de caracteres do título e presença de palavras-chave
   - Uso de subtítulo/descrição curta
   - Eficiência do campo de palavras-chave (iOS)
   - Densidade de palavras-chave na descrição
2. Otimize o título seguindo a fórmula:
   ```
   [Nome da Marca] - [Palavra-Chave Principal] [Palavra-Chave Secundária]
   ```
3. Escreva o subtítulo (iOS) ou descrição curta (Android):
   - Foque no benefício principal
   - Inclua palavra-chave secundária
   - Use verbos de ação
4. Otimize o campo de palavras-chave (somente iOS):
   - Remova duplicatas do título
   - Remova plurais (Apple indexa ambas as formas)
   - Sem espaços após vírgulas
   - Priorize por pontuação
5. Reescreva a descrição completa:
   - Parágrafo de abertura com proposta de valor
   - Bullets de funcionalidades com palavras-chave
   - Seção de prova social
   - Chamada para ação
6. Valide contagens de caracteres para cada campo
7. Calcule a densidade de palavras-chave (alvo: 2-3% para a principal)
8. **Validação:** Todos os campos dentro dos limites de caracteres; palavra-chave principal no título; sem keyword stuffing (>5%); linguagem natural preservada

### Limites de Caracteres por Plataforma

| Campo | Apple App Store | Google Play Store |
|-------|----------------|-------------------|
| Título | 30 caracteres | 50 caracteres |
| Subtítulo | 30 caracteres | N/A |
| Descrição Curta | N/A | 80 caracteres |
| Palavras-Chave | 100 caracteres | N/A |
| Texto Promocional | 170 caracteres | N/A |
| Descrição Completa | 4.000 caracteres | 4.000 caracteres |
| O que há de novo | 4.000 caracteres | 500 caracteres |

### Estrutura da Descrição

```
PARÁGRAFO 1: Abertura (50-100 palavras)
├── Aborde o ponto de dor do usuário
├── Declare a principal proposta de valor
└── Inclua a palavra-chave principal

PARÁGRAFOS 2-3: Funcionalidades (100-150 palavras)
├── Top 5 funcionalidades com benefícios
├── Bullets para escaneabilidade
└── Palavras-chave secundárias integradas naturalmente

PARÁGRAFO 4: Prova Social (50-75 palavras)
├── Contagem de downloads ou avaliação
├── Menções na imprensa ou prêmios
└── Resumo de depoimentos de usuários

PARÁGRAFO 5: Chamada para Ação (25-50 palavras)
├── Próximo passo claro
└── Tranquilização (teste gratuito, sem cadastro)
```

Veja: [references/platform-requirements.md](references/platform-requirements.md)

---

## Fluxo de Análise de Concorrentes

Analise os principais concorrentes para identificar lacunas de palavras-chave e oportunidades de posicionamento.

### Fluxo de Trabalho: Analisar Estratégia ASO de Concorrentes

1. Identifique os 10 principais concorrentes:
   - Concorrentes diretos (mesma função principal)
   - Concorrentes indiretos (audiência sobreposta)
   - Líderes da categoria (top downloads)
2. Extraia palavras-chave de concorrentes de:
   - Títulos e subtítulos de apps
   - Primeiras 100 palavras de descrições
   - Padrões de metadados visíveis
3. Construa matriz de palavras-chave de concorrentes:
   - Mapeie quais palavras-chave cada concorrente mira
   - Calcule porcentagem de cobertura por palavra-chave
4. Identifique lacunas de palavras-chave:
   - Palavras-chave com <40% de cobertura de concorrentes
   - Termos de alto volume que concorrentes perdem
   - Oportunidades de cauda longa
5. Analise ativos visuais de concorrentes:
   - Padrões de design de ícone
   - Mensagens e estilo de screenshots
   - Presença e qualidade de vídeo
6. Compare avaliações e padrões de reviews:
   - Avaliação média por concorrente
   - Temas comuns de elogios
   - Temas comuns de reclamações
7. Documente oportunidades de posicionamento
8. **Validação:** 10+ concorrentes analisados; matriz de palavras-chave completa; lacunas identificadas com estimativas de volume; auditoria visual documentada

### Matriz de Análise de Concorrentes

| Área de Análise | Pontos de Dados |
|----------------|----------------|
| Palavras-Chave | Palavras-chave do título, frequência na descrição |
| Metadados | Utilização de caracteres, densidade de palavras-chave |
| Visuais | Estilo do ícone, contagem/estilo de screenshots |
| Avaliações | Avaliação média, contagem total, velocidade |
| Reviews | Principais elogios, principais reclamações |

### Template de Análise de Lacunas

| Tipo de Oportunidade | Exemplo | Ação |
|---------------------|---------|------|
| Lacuna de palavra-chave | "rastreador de hábitos" (40% cobertura) | Adicionar ao campo de palavras-chave |
| Lacuna de funcionalidade | Concorrente não tem widget | Destacar em screenshots |
| Lacuna visual | Sem vídeos no top 5 | Criar prévia do app |
| Lacuna de mensagem | Nenhum menciona "gratuito" | Testar posicionamento gratuito |

---

## Fluxo de Lançamento do App

Execute um lançamento estruturado para máxima visibilidade inicial.

### Fluxo de Trabalho: Lançar App nas Lojas

1. Conclua a preparação pré-lançamento (4 semanas antes):
   - Finalize palavras-chave e metadados
   - Prepare todos os ativos visuais
   - Configure analytics (Firebase, Mixpanel)
   - Construa kit de imprensa e lista de mídia
2. Envie para revisão (2 semanas antes):
   - Conclua todos os requisitos da loja
   - Verifique conformidade com diretrizes
   - Prepare comunicações de lançamento
3. Configure sistemas pós-lançamento:
   - Configure monitoramento de reviews
   - Prepare templates de resposta
   - Configure o timing do prompt de avaliação
4. Execute o dia de lançamento:
   - Verifique se o app está ao vivo em ambas as lojas
   - Anuncie em todos os canais
   - Inicie o ciclo de resposta a reviews
5. Monitore a performance inicial (dias 1-7):
   - Rastreie a velocidade de downloads por hora
   - Monitore reviews e responda em 24 horas
   - Documente quaisquer problemas para correções rápidas
6. Conduza uma retrospectiva de 7 dias:
   - Compare a performance com as projeções
   - Identifique vitórias rápidas de otimização
   - Planeje a primeira atualização de metadados
7. Agende a primeira atualização (2 semanas pós-lançamento)
8. **Validação:** App ao vivo nas lojas; rastreamento de analytics; respostas a reviews em 24h; velocidade de downloads documentada; primeira atualização agendada

### Lista de Verificação Pré-Lançamento

| Categoria | Itens |
|-----------|-------|
| Metadados | Título, subtítulo, descrição, palavras-chave |
| Ativos Visuais | Ícone, screenshots (todos os tamanhos), vídeo |
| Conformidade | Classificação etária, política de privacidade, direitos de conteúdo |
| Técnico | Binário do app, certificados de assinatura |
| Analytics | Integração SDK, rastreamento de eventos |
| Marketing | Kit de imprensa, conteúdo social, email pronto |

### Considerações de Timing de Lançamento

| Fator | Recomendação |
|-------|-------------|
| Dia da semana | Terça-quarta (evite finais de semana) |
| Hora do dia | Manhã no fuso horário do mercado-alvo |
| Sazonal | Alinhe com as estações relevantes da categoria |
| Concorrência | Evite datas de lançamento de grandes concorrentes |

Veja: [references/aso-best-practices.md](references/aso-best-practices.md)

---

## Fluxo de Teste A/B

Teste elementos de metadados e visuais para melhorar as taxas de conversão.

### Fluxo de Trabalho: Executar Teste A/B

1. Selecione o elemento a testar (priorize por impacto):
   - Ícone (maior impacto)
   - Screenshot 1 (alto impacto)
   - Título (alto impacto)
   - Descrição curta (impacto médio)
2. Formule hipótese:
   ```
   Se nós [mudarmos], então [métrica] irá [melhorar/aumentar] em [quantidade]
   porque [justificativa].
   ```
3. Crie variantes:
   - Controle: Versão atual
   - Tratamento: Mudança de variável única
4. Calcule o tamanho de amostra necessário:
   - Taxa de conversão de baseline
   - Efeito mínimo detectável (geralmente 5%)
   - Significância estatística (95%)
5. Inicie o teste:
   - Apple: Use Product Page Optimization
   - Android: Use Store Listing Experiments
6. Execute o teste por duração mínima:
   - Pelo menos 7 dias
   - Até atingir significância estatística
7. Analise os resultados:
   - Compare taxas de conversão
   - Verifique significância estatística
   - Documente os aprendizados
8. **Validação:** Variável única testada; tamanho da amostra suficiente; significância atingida (95%); resultados documentados; vencedor implementado

### Priorização de Testes A/B

| Elemento | Impacto na Conversão | Complexidade do Teste |
|----------|---------------------|----------------------|
| Ícone do App | Lift possível de 10-25% | Médio (design necessário) |
| Screenshot 1 | Lift possível de 15-35% | Médio |
| Título | Lift possível de 5-15% | Baixo |
| Descrição Curta | Lift possível de 5-10% | Baixo |
| Vídeo | Lift possível de 10-20% | Alto |

### Referência Rápida de Tamanho de Amostra

| CVR de Baseline | Impressões Necessárias (por variante) |
|----------------|---------------------------------------|
| 1% | 31.000 |
| 2% | 15.500 |
| 5% | 6.200 |
| 10% | 3.100 |

### Template de Documentação de Teste

```
ID DO TESTE: ASO-2025-001
ELEMENTO: Ícone do App
HIPÓTESE: Um ícone com cor mais ousada aumentará a conversão em 10%
DATA DE INÍCIO: [Data]
DATA DE FIM: [Data]

RESULTADOS:
├── CVR do Controle: 4,2%
├── CVR do Tratamento: 4,8%
├── Lift: +14,3%
├── Significância: 97%
└── Decisão: Implementar tratamento

APRENDIZADOS:
- Cores ousadas superam tons neutros nesta categoria
- Aplicar a fundos de screenshots para o próximo teste
```

---

## Exemplos Antes/Depois

### Otimização de Título

**App de Produtividade:**

| Versão | Título | Análise |
|--------|--------|---------|
| Antes | "MyTasks" | Sem palavras-chave, apenas marca (8 chars) |
| Depois | "MyTasks - Lista de Tarefas & Planner" | Palavras-chave primária + secundária (29 chars) |

**App de Fitness:**

| Versão | Título | Análise |
|--------|--------|---------|
| Antes | "FitTrack Pro" | Modificador genérico (12 chars) |
| Depois | "FitTrack: Diário de Treino & Academia" | Palavras-chave da categoria (27 chars) |

### Otimização de Subtítulo (iOS)

| Versão | Subtítulo | Análise |
|--------|-----------|---------|
| Antes | "Realize as Coisas" | Vago, sem palavras-chave |
| Depois | "Gerenciador de Tarefas Diárias & Planner" | Duas palavras-chave, benefício claro |

### Otimização do Campo de Palavras-Chave (iOS)

**Antes (Ineficiente - 89 chars, 8 palavras-chave):**
```
gerenciador de tarefas, lista de afazeres, app de produtividade, planner diário, app de lembrete
```

**Depois (Otimizado - 97 chars, 14 palavras-chave):**
```
tarefa,afazer,checklist,lembrete,organizar,diário,planner,agenda,prazo,metas,hábito,widget,sync,time
```

**Melhorias:**
- Removidos espaços após vírgulas (+8 chars)
- Removidas duplicatas (gerenciador de tarefas → tarefa)
- Removidos plurais (lembretes → lembrete)
- Removidas palavras do título
- Adicionadas mais palavras-chave relevantes

### Abertura da Descrição

**Antes:**
```
MyTasks é uma solução abrangente de gerenciamento de tarefas projetada
para ajudar profissionais ocupados a organizar suas atividades diárias
e aumentar a produtividade.
```

**Depois:**
```
Esqueça prazos perdidos. MyTasks mantém cada tarefa, lembrete
e projeto em um só lugar—para você focar no fazer, não no lembrar.
Confiado por mais de 500.000 profissionais.
```

**Melhorias:**
- Abre com o ponto de dor do usuário
- Benefício específico (não genérico "aumentar produtividade")
- Prova social incluída
- Palavras-chave naturais, sem keyword stuffing

### Evolução das Legendas de Screenshots

| Versão | Legenda | Problema |
|--------|---------|---------|
| Antes | "Funcionalidade de Lista de Tarefas" | Focado na funcionalidade, passivo |
| Melhor | "Crie Listas de Tarefas" | Verbo de ação, mas ainda sobre funcionalidade |
| Melhor ainda | "Nunca Perca um Prazo" | Focado no benefício, emocional |

---

## Ferramentas e Referências

### Scripts

| Script | Propósito | Uso |
|--------|-----------|-----|
| [palavra-chave_analyzer.py](scripts/palavra-chave_analyzer.py) | Analisar palavras-chave por volume e concorrência | `python palavra-chave_analyzer.py --palavras-chave "afazer,tarefa,planner"` |
| [metadata_optimizer.py](scripts/metadata_optimizer.py) | Validar limites de caracteres e densidade de metadados | `python metadata_optimizer.py --platform ios --title "Título do App"` |
| [competitor_analyzer.py](scripts/competitor_analyzer.py) | Extrair e comparar palavras-chave de concorrentes | `python competitor_analyzer.py --competitors "App1,App2,App3"` |
| [aso_scorer.py](scripts/aso_scorer.py) | Calcular pontuação geral de saúde ASO | `python aso_scorer.py --app-id com.example.app` |
| [ab_test_planner.py](scripts/ab_test_planner.py) | Planejar testes e calcular tamanhos de amostra | `python ab_test_planner.py --cvr 0.05 --lift 0.10` |
| [review_analyzer.py](scripts/review_analyzer.py) | Analisar sentimento e temas de reviews | `python review_analyzer.py --app-id com.example.app` |
| [launch_checklist.py](scripts/launch_checklist.py) | Gerar listas de verificação de lançamento por plataforma | `python launch_checklist.py --platform ios` |
| [localization_helper.py](scripts/localization_helper.py) | Gerenciar metadados em múltiplos idiomas | `python localization_helper.py --locales "pt,en,es"` |

### Referências

| Documento | Conteúdo |
|----------|---------|
| [platform-requirements.md](references/platform-requirements.md) | Especificações de metadados iOS e Android, requisitos de ativos visuais |
| [aso-best-practices.md](references/aso-best-practices.md) | Estratégias de otimização, gerenciamento de avaliações, táticas de lançamento |
| [palavra-chave-research-guide.md](references/palavra-chave-research-guide.md) | Metodologia de pesquisa, framework de avaliação, rastreamento |

### Ativos

| Template | Propósito |
|----------|-----------|
| [aso-audit-template.md](assets/aso-audit-template.md) | Lista de verificação de auditoria estruturada para listagens na app store |

---

## Notas da Plataforma

| Plataforma / Restrição | Comportamento / Impacto |
|------------------------|------------------------|
| Mudanças de palavras-chave iOS | Exigem envio do app |
| Texto promocional iOS | Editável sem atualização do app |
| Mudanças de metadados Android | Indexadas em 1-2 horas |
| Campo de palavras-chave Android | Nenhum — use a descrição em vez disso |
| Dados de volume de palavras-chave | Apenas estimativas; sem fonte oficial |
| Dados de concorrentes | Apenas listagens públicas |

**Quando não usar esta skill:** apps web (use SEO web), apps empresariais/internos, apenas betas no TestFlight, ou estratégia de publicidade paga.

---

## Skills Relacionadas

| Skill | Ponto de Integração |
|-------|---------------------|
| [content-creator](../content-creator/) | Copywriting de descrição do app |
| [marketing-demand-acquisition](../marketing-demand-acquisition/) | Campanhas de promoção de lançamento |
| [marketing-strategy-pmm](../marketing-strategy-pmm/) | Planejamento go-to-market |

## Gatilhos Proativos

- **Sem otimização de palavras-chave no título** → O título do app é o fator de ranqueamento #1. Inclua a palavra-chave principal.
- **Screenshots não mostram valor** → Screenshots devem contar uma história, não mostrar a UI.
- **Sem estratégia de avaliações** → Abaixo de 4,0 estrelas prejudica a conversão. Implemente prompts de avaliação no app.
- **Descrição com keyword stuffing** → Linguagem natural com palavras-chave supera keyword stuffing.

## Artefatos de Saída

| Quando você pedir... | Você recebe... |
|---------------------|----------------|
| "Auditoria ASO" | Auditoria completa da listagem na app store com correções priorizadas |
| "Pesquisa de palavras-chave" | Lista de palavras-chave com scores de volume de busca e dificuldade |
| "Otimizar minha listagem" | Título, subtítulo, descrição e campo de palavras-chave reescritos |

## Comunicação

Toda saída passa pela verificação de qualidade:
- Auto-verificação: atribuição de fonte, auditoria de suposições, pontuação de confiança
- Formato de resultado: Conclusão → O Quê (com confiança) → Por Quê → Como Agir
- Apenas resultados. Cada descoberta marcada: 🟢 verificado, 🟡 médio, 🔴 assumido.
