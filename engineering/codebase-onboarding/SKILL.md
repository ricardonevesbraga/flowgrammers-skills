---
name: "codebase-onboarding"
description: "Onboarding de Base de Código — analisa um repositório e gera documentação de integração para engenheiros, tech leads e contratados, com descoberta de arquitetura e stack, inventário de arquivos-chave e orientação de configuração local."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Codebase Onboarding

**Nível:** PODEROSO  
**Categoria:** Engenharia  
**Domínio:** Documentação / Experiência do Desenvolvedor

---

## Visão Geral

Analise uma base de código e gere documentação de integração para engenheiros, tech leads e contratados. Esta skill é otimizada para coleta rápida de fatos e saídas de integração repetíveis.

## Capacidades Principais

- Descoberta de arquitetura e stack a partir de sinais do repositório
- Inventário de arquivos e configurações-chave para novos contribuidores
- Geração de orientação de configuração local e tarefas comuns
- Enquadramento de documentação com consciência do público
- Scaffolding de listas de verificação de depuração e contribuição

---

## Quando Usar

- Integrando um novo membro da equipe ou contratado
- Reconstruindo documentação desatualizada do projeto após grandes refatorações
- Preparando documentação de handoff interno
- Criando um pacote de integração padronizado para serviços

---

## Início Rápido

```bash
# 1) Coletar fatos da base de código
python3 scripts/codebase_analyzer.py /path/to/repo

# 2) Exportar saída legível por máquina
python3 scripts/codebase_analyzer.py /path/to/repo --json

# 3) Usar o template para rascunhar documentação de integração
# Veja references/onboarding-template.md
```

---

## Workflow Recomendado

1. Execute `scripts/codebase_analyzer.py` no repositório alvo.
2. Capture sinais-chave: contagem de arquivos, linguagens detectadas, configurações, estrutura de nível superior.
3. Preencha o template de integração em `references/onboarding-template.md`.
4. Adapte a profundidade da saída por público:
   - Júnior: configuração + salvaguardas
   - Sênior: arquitetura + preocupações operacionais
   - Contratado: propriedade com escopo + limites de integração

---

## Template de Documento de Integração

O template detalhado e exemplos de seção estão em:
- `references/onboarding-template.md`
- `references/output-format-templates.md`

---

## Armadilhas Comuns

- Escrever documentos sem validar comandos de configuração em um ambiente limpo
- Misturar deep-dives de arquitetura em documentos orientados a contratados
- Omitir passos de solução de problemas e verificação
- Deixar documentos de integração divergirem do estado atual do repo

## Melhores Práticas

1. Mantenha as instruções de configuração executáveis e com tempo limitado.
2. Documente o "porquê" para decisões arquiteturais-chave.
3. Atualize a documentação no mesmo PR que as mudanças de comportamento.
4. Trate documentos de integração como ativos operacionais vivos, não como entregáveis únicos.
