# Processador de Texto de Amostra

---

**Nome**: sample-text-processor
**Nível**: BÁSICO
**Categoria**: Processamento de Texto
**Dependências**: Nenhuma (Somente Biblioteca Padrão do Python)
**Autor**: Ric Neves - Flowgrammers
**Versão**: 1.0.0

---

## Descrição

O Processador de Texto de Amostra é uma skill simples projetada para demonstrar a estrutura básica e funcionalidade esperada no ecossistema claude-skills. Esta skill fornece capacidades fundamentais de processamento de texto, incluindo contagem de palavras, análise de caracteres e transformações básicas de texto.

Esta skill serve como implementação de referência para os requisitos do nível BÁSICO e pode ser usada como modelo para criar novas skills. Demonstra estrutura adequada de arquivos, padrões de documentação e padrões de implementação que se alinham com as melhores práticas do ecossistema.

A skill processa arquivos de texto e fornece estatísticas e transformações em formatos legíveis por humanos e JSON, demonstrando o requisito de saída dupla para skills no repositório claude-skills.

## Funcionalidades

### Funcionalidade Principal
- **Análise de Contagem de Palavras**: Conta total de palavras, palavras únicas e frequência de palavras
- **Estatísticas de Caracteres**: Analisa contagem de caracteres, contagem de linhas e caracteres especiais
- **Transformações de Texto**: Converte texto para maiúsculas, minúsculas ou formato título
- **Processamento de Arquivos**: Processa arquivos de texto únicos ou processa diretórios em lote
- **Formatos de Saída Dupla**: Gera resultados em formatos JSON e legível por humanos

### Funcionalidades Técnicas
- Interface de linha de comando com análise abrangente de argumentos
- Tratamento de erros para problemas comuns de arquivo e processamento
- Relatório de progresso para operações em lote
- Formatação de saída configurável e níveis de verbosidade
- Compatibilidade entre plataformas com dependências apenas da biblioteca padrão

## Uso

### Análise Básica de Texto
```bash
python text_processor.py analyze document.txt
python text_processor.py analyze document.txt --output results.json
```

### Transformação de Texto
```bash
python text_processor.py transform document.txt --mode uppercase
python text_processor.py transform document.txt --mode title --output transformed.txt
```

### Processamento em Lote
```bash
python text_processor.py batch text_files/ --output results/
python text_processor.py batch text_files/ --format json --output batch_results.json
```

## Exemplos

### Exemplo 1: Contagem Básica de Palavras
```bash
$ python text_processor.py analyze sample.txt
=== RESULTADOS DA ANÁLISE DE TEXTO ===
Arquivo: sample.txt
Total de palavras: 150
Palavras únicas: 85
Total de caracteres: 750
Linhas: 12
Palavra mais frequente: "the" (8 ocorrências)
```

### Exemplo 2: Saída em JSON
```bash
$ python text_processor.py analyze sample.txt --format json
{
  "file": "sample.txt",
  "statistics": {
    "total_words": 150,
    "unique_words": 85,
    "total_characters": 750,
    "lines": 12,
    "most_frequent": {
      "word": "the",
      "count": 8
    }
  }
}
```

### Exemplo 3: Transformação de Texto
```bash
$ python text_processor.py transform sample.txt --mode title
Original: "hello world from the text processor"
Transformado: "Hello World From The Text Processor"
```

## Instalação

Esta skill requer apenas Python 3.7 ou posterior com a biblioteca padrão. Nenhuma dependência externa é necessária.

1. Clonar ou baixar o diretório da skill
2. Navegar até o diretório scripts
3. Executar o processador de texto diretamente com Python

```bash
cd scripts/
python text_processor.py --help
```

## Configuração

O processador de texto suporta várias opções de configuração por meio de argumentos de linha de comando:

- `--format`: Formato de saída (json, text)
- `--verbose`: Habilitar saída detalhada e relatório de progresso
- `--output`: Especificar arquivo ou diretório de saída
- `--encoding`: Especificar codificação do arquivo de texto (padrão: utf-8)

## Arquitetura

A skill segue uma arquitetura modular simples:

- **Classe TextProcessor**: Lógica de processamento principal e cálculo de estatísticas
- **Classe OutputFormatter**: Lida com geração de formato de saída dupla
- **Classe FileManager**: Gerencia operações de E/S de arquivo e processamento em lote
- **Interface CLI**: Análise de argumentos de linha de comando e interação com o usuário

## Tratamento de Erros

A skill inclui tratamento abrangente de erros para:
- Arquivo não encontrado ou erros de permissão
- Codificação inválida ou arquivos de texto corrompidos
- Limitações de memória para arquivos muito grandes
- Criação de diretório de saída e permissões de gravação
- Argumentos e parâmetros de linha de comando inválidos

## Considerações de Desempenho

- Uso eficiente de memória para arquivos de texto grandes via streaming
- Contagem de palavras otimizada usando pesquisas de dicionário
- Processamento em lote com relatório de progresso para grandes conjuntos de dados
- Detecção de codificação configurável para texto internacional

## Limitações

Como uma skill de nível BÁSICO, alguns recursos avançados são intencionalmente omitidos:
- Análise de texto complexa (sentimento, detecção de idioma)
- Suporte avançado de formato de arquivo (PDF, documentos Word)
- Integração de banco de dados ou chamadas de API externas
- Processamento paralelo para conjuntos de dados muito grandes

Esta skill demonstra a estrutura essencial e os padrões de qualidade exigidos para skills de nível BÁSICO no ecossistema claude-skills, permanecendo simples e focada na funcionalidade principal.
