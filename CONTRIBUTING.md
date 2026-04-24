# Contribuindo para Flowgrammers Skills

Obrigado pelo interesse! Este projeto é 100% em **português do Brasil** e foca no mercado brasileiro (LGPD, CLT, PIX, NF-e, ANVISA, regimes tributários, etc.).

## Como contribuir

### 1. Sugerir uma nova skill

Abra uma [issue](https://github.com/ricardonevesbraga/flowgrammers-skills/issues/new) com:
- **Papel/especialidade** (ex: "Chief Sustainability Officer")
- **Domínio** onde ela se encaixa (c-level-advisor, engineering-team, etc.)
- **Por que é útil** para o mercado brasileiro
- **3-5 responsabilidades principais** que a skill cobriria

### 2. Submeter uma skill nova via PR

Crie uma pasta em `<domínio>/<nome-da-skill>/` com um `SKILL.md` seguindo o padrão:

```markdown
---
name: "nome-da-skill"
description: "Descrição concisa em PT-BR. Use ao [casos de uso]. Quando o usuário mencionar [palavras-chave]..."
license: MIT
metadata:
  version: 1.0.0
  author: Seu Nome - Flowgrammers
  category: <domínio>
  domain: <subdomínio>
  updated: YYYY-MM-DD
agents:
  - claude-code
---

# Título da Skill

Descrição detalhada do que a skill faz.

## Palavras-chave
Lista de termos que ativam a skill

## Responsabilidades Principais

### 1. Primeira responsabilidade
Conteúdo...

### 2. Segunda responsabilidade
Conteúdo...

## Perguntas-Chave
Lista de perguntas que essa persona faria

## Veja Também
- Links para skills relacionadas
```

### 3. Regras de qualidade

- **Idioma**: Português do Brasil (PT-BR), sem mistura com inglês no corpo
- **Contexto**: Priorize exemplos brasileiros (empresas, leis, valores em R$)
- **Frameworks**: Use frameworks reconhecidos quando aplicável
- **Código**: Se houver trechos de código, comentários em PT-BR
- **Tamanho**: 100-400 linhas é o ideal — não inche artificialmente

### 4. Revisão

Toda PR passa por revisão manual antes do merge. Usamos o padrão de commit:

```
feat(domínio): adicionar skill <nome>
fix(domínio/skill): corrigir <problema>
docs: atualizar <documento>
```

### 5. Reportar bugs ou sugerir melhorias

- **Bug**: abra issue com "bug:" no título
- **Melhoria**: abra issue com "enhancement:" no título
- **Dúvida**: use Discussions

## Código de conduta

Seja respeitoso. Críticas ao código são bem-vindas; ataques pessoais não.

## Dúvidas

- Autor: Ric Neves — Flowgrammers
- Email: r.nevesbraga@gmail.com
- Site: [flowgrammers.com.br](https://flowgrammers.com.br)

---

MIT License — use livremente, inclusive comercialmente, com atribuição.
