---
name: "skill-tester"
description: "Testador de Skills — meta-skill para validar, testar e pontuar a qualidade de skills dentro do ecossistema claude-skills. Use para garantir conformidade estrutural, testar scripts Python e realizar avaliação de qualidade multidimensional com notas e recomendações de melhoria."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Skill Tester

---

**Nome**: skill-tester
**Nível**: PODEROSO
**Categoria**: Garantia de Qualidade em Engenharia
**Dependências**: Nenhuma (Somente Biblioteca Padrão do Python)
**Versão**: 1.0.0

---

## Descrição

O Skill Tester é uma meta-skill abrangente projetada para validar, testar e pontuar a qualidade de skills dentro do ecossistema claude-skills. Esta poderosa ferramenta de garantia de qualidade garante que todas as skills atendam aos rigorosos padrões exigidos para classificações de nível BÁSICO, PADRÃO e PODEROSO por meio de validação automatizada, testes e mecanismos de pontuação.

Como sistema de controle de qualidade de skills, esta meta-skill fornece três capacidades principais:
1. **Validação de Estrutura** - Garante que as skills estejam em conformidade com as estruturas de diretório, formatos de arquivo e padrões de documentação necessários
2. **Teste de Scripts** - Valida scripts Python quanto a sintaxe, importações, funcionalidade e conformidade de formato de saída
3. **Pontuação de Qualidade** - Fornece avaliação de qualidade abrangente em múltiplas dimensões com notas por letra e recomendações de melhoria

Esta skill é essencial para manter a consistência do ecossistema, habilitar integração de CI/CD automatizada e suportar fluxos de trabalho de garantia de qualidade manuais e automatizados.

## Funcionalidades Principais

### Validação Abrangente de Skills
- **Conformidade de Estrutura**: Valida estrutura de diretório, arquivos obrigatórios (SKILL.md, README.md, scripts/, references/, assets/, expected_outputs/)
- **Padrões de Documentação**: Verifica frontmatter do SKILL.md, completude de seções, contagens mínimas de linhas por nível
- **Validação de Formato de Arquivo**: Garante formatação adequada de Markdown, sintaxe de frontmatter YAML e convenções de nomenclatura de arquivos

### Teste Avançado de Scripts
- **Validação de Sintaxe**: Compila scripts Python para detectar erros de sintaxe antes da execução
- **Análise de Importações**: Aplica política de uso exclusivo de biblioteca padrão, identifica dependências externas
- **Teste em Tempo de Execução**: Executa scripts com dados de amostra, valida implementação de argparse, testa funcionalidade --help
- **Conformidade de Formato de Saída**: Verifica suporte de saída dupla (JSON + legível por humanos), tratamento adequado de erros

### Pontuação de Qualidade Multidimensional
- **Qualidade da Documentação (25%)**: Profundidade e completude do SKILL.md, clareza do README, qualidade da documentação de referência
- **Qualidade do Código (25%)**: Complexidade do script, robustez do tratamento de erros, consistência do formato de saída, manutenibilidade
- **Completude (25%)**: Presença de diretórios obrigatórios, adequação dos dados de amostra, verificação de saída esperada
- **Usabilidade (25%)**: Clareza dos exemplos, qualidade do texto de ajuda do argparse, simplicidade de instalação, experiência do usuário

### Sistema de Classificação por Nível
Classifica automaticamente skills com base em complexidade e funcionalidade:

#### Requisitos do Nível BÁSICO
- Mínimo 100 linhas no SKILL.md
- Pelo menos 1 script Python (100-300 LOC)
- Implementação básica de argparse
- Tratamento simples de entrada/saída
- Cobertura essencial de documentação

#### Requisitos do Nível PADRÃO
- Mínimo 200 linhas no SKILL.md
- 1-2 scripts Python (300-500 LOC cada)
- Argparse avançado com subcomandos
- Formatos de saída JSON + texto
- Exemplos e referências abrangentes
- Tratamento de erros e gerenciamento de casos extremos

#### Requisitos do Nível PODEROSO
- Mínimo 300 linhas no SKILL.md
- 2-3 scripts Python (500-800 LOC cada)
- Argparse complexo com múltiplos modos
- Formatação e validação sofisticadas de saída
- Documentação e materiais de referência extensos
- Tratamento avançado de erros e mecanismos de recuperação
- Capacidades de integração com CI/CD

## Arquitetura e Design

### Filosofia de Design Modular
O skill-tester segue uma arquitetura modular onde cada componente serve a um propósito específico de validação:

- **skill_validator.py**: Motor central de validação estrutural e de documentação
- **script_tester.py**: Framework de testes em tempo de execução e validação de execução
- **quality_scorer.py**: Sistema de avaliação e pontuação de qualidade multidimensional

### Aplicação de Padrões
Toda validação é realizada contra padrões bem definidos documentados no diretório references/:
- **Especificação de Estrutura de Skill**: Define componentes obrigatórios e opcionais
- **Matriz de Requisitos por Nível**: Requisitos detalhados para cada nível de skill
- **Rubrica de Pontuação de Qualidade**: Metodologia abrangente de pontuação e pesos

### Capacidades de Integração
Projetado para integração perfeita em fluxos de trabalho de desenvolvimento existentes:
- **Hooks de Pré-commit**: Impede que skills abaixo do padrão sejam commitadas
- **Pipelines de CI/CD**: Portões de qualidade automatizados em fluxos de trabalho de pull request
- **Validação Manual**: Ferramentas de linha de comando interativas para validação em tempo de desenvolvimento
- **Processamento em Lote**: Validação e pontuação em massa de repositórios de skills existentes

## Detalhes de Implementação

### Funções Principais do skill_validator.py
```python
# Fluxo de trabalho de validação principal
validate_skill_structure() -> ValidationReport
check_skill_md_compliance() -> DocumentationReport  
validate_python_scripts() -> ScriptReport
generate_compliance_score() -> float
```

As principais verificações de validação incluem:
- Análise e validação de frontmatter do SKILL.md
- Presença de seções obrigatórias (Descrição, Funcionalidades, Uso, etc.)
- Aplicação de contagem mínima de linhas por nível
- Verificação de implementação de argparse em scripts Python
- Aplicação de importação apenas de biblioteca padrão
- Conformidade de estrutura de diretório
- Avaliação de qualidade do README.md

### Framework de Teste do script_tester.py
```python
# Funções principais de teste
syntax_validation() -> SyntaxReport
import_validation() -> ImportReport
runtime_testing() -> RuntimeReport
output_format_validation() -> OutputReport
```

As capacidades de teste abrangem:
- Validação de sintaxe baseada em Python AST
- Análise de instruções de importação e detecção de dependências externas
- Execução controlada de scripts com proteção de timeout
- Verificação de funcionalidade --help do argparse
- Processamento de dados de amostra e validação de saída
- Comparação de saída esperada e relatório de diferenças

### Sistema de Pontuação do quality_scorer.py
```python
# Pontuação multidimensional
score_documentation() -> float  # Peso de 25%
score_code_quality() -> float   # Peso de 25%
score_completeness() -> float   # Peso de 25%
score_usability() -> float      # Peso de 25%
calculate_overall_grade() -> str # Nota de A a F
```

As dimensões de pontuação incluem:
- **Documentação**: Completude, clareza, exemplos, qualidade de referência
- **Qualidade do Código**: Complexidade, manutenibilidade, tratamento de erros, consistência de saída
- **Completude**: Arquivos obrigatórios, dados de amostra, saídas esperadas, cobertura de testes
- **Usabilidade**: Qualidade do texto de ajuda, clareza dos exemplos, simplicidade de instalação

## Cenários de Uso

### Integração no Fluxo de Trabalho de Desenvolvimento
```bash
# Validação de hook de pré-commit
skill_validator.py path/to/skill --tier POWERFUL --json

# Teste abrangente de skill
script_tester.py path/to/skill --timeout 30 --sample-data

# Avaliação e pontuação de qualidade
quality_scorer.py path/to/skill --detailed --recommendations
```

### Integração com Pipeline de CI/CD
```yaml
# Exemplo de fluxo de trabalho do GitHub Actions
- name: "validate-skill-quality"
  run: |
    python skill_validator.py engineering/${{ matrix.skill }} --json | tee validation.json
    python script_tester.py engineering/${{ matrix.skill }} | tee testing.json
    python quality_scorer.py engineering/${{ matrix.skill }} --json | tee scoring.json
```

### Análise em Lote do Repositório
```bash
# Validar todas as skills no repositório
find engineering/ -type d -maxdepth 1 | xargs -I {} skill_validator.py {}

# Gerar relatório de qualidade do repositório
quality_scorer.py engineering/ --batch --output-format json > repo_quality.json
```

## Formatos de Saída e Relatórios

### Suporte de Saída Dupla
Todas as ferramentas fornecem saída legível por humanos e interpretável por máquinas:

#### Formato Legível por Humanos
```
=== RELATÓRIO DE VALIDAÇÃO DE SKILL ===
Skill: engineering/example-skill
Nível: PADRÃO
Pontuação Geral: 85/100 (B)

Validação de Estrutura: ✓ APROVADO
├─ SKILL.md: ✓ EXISTE (247 linhas)
├─ README.md: ✓ EXISTE  
├─ scripts/: ✓ EXISTE (2 arquivos)
└─ references/: ⚠ AUSENTE (recomendado)

Qualidade da Documentação: 22/25 (88%)
Qualidade do Código: 20/25 (80%)
Completude: 18/25 (72%)
Usabilidade: 21/25 (84%)

Recomendações:
• Adicionar diretório references/ com documentação
• Melhorar tratamento de erros em main.py
• Incluir exemplos mais abrangentes
```

#### Formato JSON
```json
{
  "skill_path": "engineering/example-skill",
  "timestamp": "2026-02-16T16:41:00Z",
  "validation_results": {
    "structure_compliance": {
      "score": 0.95,
      "checks": {
        "skill_md_exists": true,
        "readme_exists": true,
        "scripts_directory": true,
        "references_directory": false
      }
    },
    "overall_score": 85,
    "letter_grade": "B",
    "tier_recommendation": "STANDARD",
    "improvement_suggestions": [
      "Adicionar diretório references/",
      "Melhorar tratamento de erros",
      "Incluir exemplos abrangentes"
    ]
  }
}
```

## Padrões de Garantia de Qualidade

### Requisitos de Qualidade de Código
- **Somente Biblioteca Padrão**: Sem dependências externas (pacotes pip)
- **Tratamento de Erros**: Tratamento abrangente de exceções com mensagens de erro significativas
- **Consistência de Saída**: Esquema JSON padronizado e formatação legível por humanos
- **Desempenho**: Algoritmos de validação eficientes com tempo de execução razoável
- **Manutenibilidade**: Estrutura de código clara, docstrings abrangentes, type hints onde apropriado

### Padrões de Teste
- **Auto-Teste**: O skill-tester valida a si mesmo (meta-validação)
- **Cobertura de Dados de Amostra**: Casos de teste abrangentes cobrindo casos extremos e condições de erro
- **Verificação de Saída Esperada**: Todas as execuções de amostra produzem saídas verificáveis e reproduzíveis
- **Proteção de Timeout**: Execução segura de scripts potencialmente problemáticos com limites de timeout

### Padrões de Documentação
- **Cobertura Abrangente**: Todas as funções, classes e módulos documentados
- **Exemplos de Uso**: Exemplos claros e práticos para todos os casos de uso
- **Guias de Integração**: Instruções passo a passo de integração com CI/CD e fluxos de trabalho
- **Materiais de Referência**: Documentos de especificação completos para padrões e requisitos

## Exemplos de Integração

### Configuração de Hook de Pré-Commit
```bash
#!/bin/bash
# .git/hooks/pre-commit
echo "Executando validação de skill..."
python engineering/skill-tester/scripts/skill_validator.py engineering/new-skill --tier STANDARD
if [ $? -ne 0 ]; then
    echo "Validação de skill falhou. Commit bloqueado."
    exit 1
fi
echo "Validação aprovada. Prosseguindo com o commit."
```

### Fluxo de Trabalho do GitHub Actions
```yaml
name: "skill-quality-gate"
on:
  pull_request:
    paths: ['engineering/**']

jobs:
  validate-skills:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v3
      - name: "setup-python"
        uses: actions/setup-python@v4
        with:
          python-version: '3.11'
      - name: "validate-changed-skills"
        run: |
          changed_skills=$(git diff --name-only ${{ github.event.before }} | grep -E '^engineering/[^/]+/' | cut -d'/' -f1-2 | sort -u)
          for skill in $changed_skills; do
            echo "Validando $skill..."
            python engineering/skill-tester/scripts/skill_validator.py $skill --json
            python engineering/skill-tester/scripts/script_tester.py $skill
            python engineering/skill-tester/scripts/quality_scorer.py $skill --minimum-score 75
          done
```

### Monitoramento Contínuo de Qualidade
```bash
#!/bin/bash
# Geração de relatório de qualidade diário
echo "Gerando relatório diário de qualidade de skills..."
timestamp=$(date +"%Y-%m-%d")
python engineering/skill-tester/scripts/quality_scorer.py engineering/ \
  --batch --json > "reports/quality_report_${timestamp}.json"

echo "Análise de tendências de qualidade..."
python engineering/skill-tester/scripts/trend_analyzer.py reports/ \
  --days 30 > "reports/quality_trends_${timestamp}.md"
```

## Desempenho e Escalabilidade

### Desempenho de Execução
- **Validação Rápida**: Validação de estrutura conclui em <1 segundo por skill
- **Teste Eficiente**: Teste de scripts com proteção de timeout (configurável, padrão 30s)
- **Processamento em Lote**: Otimizado para análise de repositório inteiro com suporte a processamento paralelo
- **Eficiência de Memória**: Pegada mínima de memória para análise de repositório em larga escala

### Considerações de Escalabilidade
- **Tamanho do Repositório**: Projetado para lidar com repositórios com 100+ skills
- **Execução Concorrente**: Implementação thread-safe suporta validação paralela
- **Gerenciamento de Recursos**: Limpeza automática de arquivos temporários e recursos de subprocesso
- **Flexibilidade de Configuração**: Timeouts configuráveis, limites de memória e rigor de validação

## Segurança e Proteção

### Ambiente de Execução Seguro
- **Teste em Sandbox**: Scripts executam em ambiente controlado com proteção de timeout
- **Limites de Recursos**: Monitoramento de uso de memória e CPU para prevenir esgotamento de recursos
- **Validação de Entrada**: Todas as entradas sanitizadas e validadas antes do processamento
- **Sem Acesso à Rede**: Operação offline garante sem dependências externas ou chamadas de rede

### Melhores Práticas de Segurança
- **Sem Injeção de Código**: Somente análise estática, sem geração dinâmica de código
- **Proteção contra Path Traversal**: Acesso seguro ao sistema de arquivos com validação de caminho
- **Privilégios Mínimos**: Opera com permissões mínimas necessárias de sistema de arquivos
- **Registro de Auditoria**: Registro de logs abrangente para monitoramento de segurança e solução de problemas

## Solução de Problemas e Suporte

### Problemas Comuns e Soluções

#### Falhas de Validação
- **Arquivos Ausentes**: Verificar estrutura de diretório contra requisitos do nível
- **Erros de Importação**: Garantir que somente importações de biblioteca padrão sejam usadas
- **Problemas de Documentação**: Verificar frontmatter do SKILL.md e completude de seções

#### Problemas de Teste de Scripts
- **Erros de Timeout**: Aumentar limite de timeout ou otimizar desempenho do script
- **Falhas de Execução**: Verificar sintaxe do script e validade das instruções de importação
- **Problemas de Formato de Saída**: Garantir formatação JSON adequada e suporte de saída dupla

#### Discrepâncias de Pontuação de Qualidade
- **Pontuação Baixa**: Revisar rubrica de pontuação e recomendações de melhoria
- **Classificação de Nível Incorreta**: Verificar complexidade da skill contra requisitos do nível
- **Resultados Inconsistentes**: Verificar mudanças recentes em padrões de qualidade ou pesos de pontuação

### Suporte a Depuração
- **Modo Verbose**: Registro de logs detalhado e rastreamento de execução disponíveis
- **Modo Dry Run**: Validação sem execução para fins de depuração
- **Saída de Depuração**: Relatório abrangente de erros com localizações de arquivos e sugestões

## Conclusão

O Skill Tester representa um componente de infraestrutura crítico para manter os altos padrões de qualidade do ecossistema claude-skills. Ao fornecer capacidades abrangentes de validação, teste e pontuação, garante que todas as skills atendam ou superem os requisitos rigorosos para seus respectivos níveis.

Esta meta-skill não apenas serve como portão de qualidade, mas também como ferramenta de desenvolvimento que orienta autores de skills em direção às melhores práticas e ajuda a manter consistência em todo o repositório. Por meio de suas capacidades de integração e relatórios abrangentes, habilita fluxos de trabalho de garantia de qualidade manuais e automatizados que escalam com o crescente ecossistema claude-skills.
