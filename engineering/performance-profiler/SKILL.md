---
name: "performance-profiler"
description: "Profiler de Desempenho. Profiling sistemático de desempenho para aplicações Node.js, Python e Go. Identifica gargalos de CPU, memória e I/O, gera flamegraphs, analisa tamanhos de bundle, otimiza consultas de banco de dados, detecta vazamentos de memória e executa testes de carga."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Performance Profiler

**Nível:** PODEROSO
**Categoria:** Engenharia
**Domínio:** Engenharia de Desempenho

---

## Visão Geral

Profiling sistemático de desempenho para aplicações Node.js, Python e Go. Identifica gargalos de CPU, memória e I/O; gera flamegraphs; analisa tamanhos de bundle; otimiza consultas de banco de dados; detecta vazamentos de memória; e executa testes de carga com k6 e Artillery. Sempre mede antes e depois.

## Capacidades Principais

- **Profiling de CPU** — flamegraphs para Node.js, py-spy para Python, pprof para Go
- **Profiling de memória** — snapshots de heap, detecção de vazamentos, pressão de GC
- **Análise de bundle** — webpack-bundle-analyzer, analisador de bundle do Next.js
- **Otimização de banco de dados** — EXPLAIN ANALYZE, log de consultas lentas, detecção de N+1
- **Testes de carga** — scripts k6, cenários Artillery, padrões de ramp-up
- **Medição antes/depois** — estabeleça linha de base, profile, otimize, verifique

---

## Quando Usar

- O app está lento e você não sabe onde está o gargalo
- A latência P99 excede o SLA antes de um release
- O uso de memória cresce ao longo do tempo (suspeita de vazamento)
- O tamanho do bundle aumentou após adicionar dependências
- Preparando-se para um pico de tráfego (teste de carga antes do lançamento)
- Consultas de banco de dados levando mais de 100ms

---

## Início Rápido

```bash
# Analisar um projeto para indicadores de risco de desempenho
python3 scripts/performance_profiler.py /caminho/para/projeto

# Saída JSON para integração com CI
python3 scripts/performance_profiler.py /caminho/para/projeto --json

# Limite personalizado de arquivo grande
python3 scripts/performance_profiler.py /caminho/para/projeto --large-file-threshold-kb 256
```

---

## Regra de Ouro: Medir Primeiro

```bash
# Estabeleça a linha de base ANTES de qualquer otimização
# Registre: latência P50, P95, P99 | RPS | taxa de erro | uso de memória

# Errado: "Acho que a consulta N+1 está lenta, vou corrigi-la"
# Certo: Profile → confirme o gargalo → corrija → meça novamente → verifique a melhoria
```

---

## Profiling Node.js
→ Veja references/profiling-recipes.md para detalhes

## Template de Medição Antes/Depois

```markdown
## Otimização de Desempenho: [O que você corrigiu]

**Data:** 2026-03-01  
**Engenheiro:** @username  
**Ticket:** PROJ-123  

### Problema
[1-2 frases: o que estava lento, como foi observado]

### Causa Raiz
[O que o profiler revelou]

### Linha de Base (Antes)
| Métrica | Valor |
|--------|-------|
| Latência P50 | 480ms |
| Latência P95 | 1.240ms |
| Latência P99 | 3.100ms |
| RPS @ 50 VUs | 42 |
| Taxa de erro | 0,8% |
| Consultas DB/req | 23 (N+1) |

Evidência do profiler: [link para flamegraph ou screenshot]

### Correção Aplicada
[O que mudou — diff de código ou descrição]

### Depois
| Métrica | Antes | Depois | Delta |
|--------|--------|-------|-------|
| Latência P50 | 480ms | 48ms | -90% |
| Latência P95 | 1.240ms | 120ms | -90% |
| Latência P99 | 3.100ms | 280ms | -91% |
| RPS @ 50 VUs | 42 | 380 | +804% |
| Taxa de erro | 0,8% | 0% | -100% |
| Consultas DB/req | 23 | 1 | -96% |

### Verificação
Teste de carga executado: [link para saída do k6]
```

---

## Lista de Verificação de Otimização

### Ganhos rápidos (verifique estes primeiro)

```
Banco de Dados
□ Índices ausentes em colunas WHERE/ORDER BY
□ Consultas N+1 (verifique a contagem de consultas por requisição)
□ Carregando todas as colunas quando apenas 2-3 são necessárias (SELECT *)
□ Sem LIMIT em consultas ilimitadas
□ Sem pool de conexões (criando nova conexão por requisição)

Node.js
□ I/O síncrono (fs.readFileSync) em caminho crítico
□ JSON.parse/stringify de objetos grandes em loop crítico
□ Cache ausente para computações caras
□ Sem compressão (gzip/brotli) nas respostas
□ Dependências carregadas no handler de requisição (mova para o nível de módulo)

Bundle
□ Moment.js → dayjs/date-fns
□ Lodash (completo) → importações de função lodash
□ Importações estáticas de componentes pesados → importações dinâmicas
□ Imagens não otimizadas / não usando next/image
□ Sem divisão de código em rotas

API
□ Sem paginação em endpoints de lista
□ Sem cache de resposta (headers Cache-Control)
□ awaits em série que poderiam ser paralelos (Promise.all)
□ Buscar dados relacionados em loop em vez de JOIN
```

---

## Armadilhas Comuns

- **Otimizar sem medir** — você otimizará a coisa errada
- **Testar em desenvolvimento** — faça o profile com volumes de dados semelhantes aos de produção
- **Ignorar P99** — P50 pode parecer bom enquanto P99 é catastrófico
- **Otimização prematura** — corrija a corretude primeiro, depois o desempenho
- **Não medir novamente** — sempre verifique se a correção realmente melhorou as coisas
- **Teste de carga em produção** — use staging com dados do tamanho de produção

---

## Melhores Práticas

1. **Linha de base primeiro, sempre** — registre métricas antes de tocar em qualquer coisa
2. **Uma mudança por vez** — isole a variável para confirmar a causalidade
3. **Faça o profile com dados realistas** — 10 linhas em dev, milhões em prod — gargalos diferentes
4. **Defina orçamentos de desempenho** — `p(95) < 200ms` em limites de CI com k6
5. **Monitore continuamente** — adicione métricas do Datadog/Prometheus para caminhos críticos
6. **Estratégia de invalidação de cache** — faça cache agressivamente, invalide com precisão
7. **Documente a vitória** — antes/depois na descrição do PR motiva a equipe
