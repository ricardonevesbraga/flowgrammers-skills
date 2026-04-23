---
name: experiment-designer
description: Use ao planejar experimentos de produto, escrever hipóteses testáveis, estimar tamanho de amostra, priorizar testes ou interpretar resultados de A/B com rigor estatístico prático.
agents:
  - claude-code
---

# Designer de Experimentos

Projete, priorize e avalie experimentos de produto com hipóteses claras e decisões defensáveis.

## Quando Usar

Use esta skill para:
- Planejamento de experimentos A/B e multivariados
- Escrita de hipóteses e definição de critérios de sucesso
- Planejamento de tamanho de amostra e efeito mínimo detectável
- Priorização de experimentos com pontuação ICE
- Leitura de saídas estatísticas para decisões de produto

## Fluxo de Trabalho Principal

1. Escrever hipótese no formato Se/Então/Porque
- Se alterarmos `[intervenção]`
- Então `[métrica]` mudará por `[direção/magnitude esperada]`
- Porque `[mecanismo comportamental]`

2. Definir métricas antes de executar o teste
- Métrica primária: métrica única de decisão
- Métricas de guarda: proteção de qualidade/risco
- Métricas secundárias: somente diagnósticas

3. Estimar tamanho de amostra
- Taxa de conversão base ou média base
- Efeito mínimo detectável (MDE)
- Nível de significância (alpha) e poder

Use:
```bash
python3 scripts/sample_size_calculator.py --baseline-rate 0.12 --mde 0.02 --mde-type absolute
```

4. Priorizar experimentos com ICE
- Impacto: potencial de ganho
- Confiança: qualidade das evidências
- Facilidade: custo/velocidade/complexidade

Pontuação ICE = (Impacto * Confiança * Facilidade) / 10

5. Lançar com regras de parada
- Decidir tamanho de amostra fixo ou duração fixa antecipadamente
- Evitar verificações repetidas sem método adequado
- Monitorar guarda-corpos continuamente

6. Interpretar resultados
- Significância estatística não é significância de negócio
- Comparar estimativa pontual + intervalo de confiança com o limiar de decisão
- Investigar efeitos de novidade e heterogeneidade de segmento

## Lista de Verificação de Qualidade de Hipótese

- [ ] Contém intervenção explícita e audiência
- [ ] Especifica mudança de métrica mensurável
- [ ] Declara razão causal plausível
- [ ] Inclui efeito mínimo esperado
- [ ] Define condição de falha

## Armadilhas Comuns em Experimentos

- Testes subpotencializados levando a falsos negativos
- Executar muitas mudanças simultâneas sem isolamento
- Alterar segmentação ou implementação durante o teste
- Parar cedo em picos aleatórios
- Ignorar desajuste de proporção de amostra e desvio de instrumentação
- Declarar sucesso com p-value sem contexto de tamanho de efeito

## Guarda-Corpos de Interpretação Estatística

- p-value < alpha indica evidência contra a hipótese nula, não verdade garantida.
- Intervalo de confiança cruzando zero/sem efeito significa afirmação direcional incerta.
- Intervalos amplos implicam baixa precisão mesmo quando significativo.
- Use limiares de significância prática ligados ao impacto de negócio.

Veja:
- `references/experiment-playbook.md`
- `references/statistics-reference.md`

## Ferramentas

### `scripts/sample_size_calculator.py`

Calcula o tamanho de amostra necessário (por variante e total) a partir de:
- taxa base
- MDE (absoluto ou relativo)
- nível de significância (alpha)
- poder estatístico

Exemplo:
```bash
python3 scripts/sample_size_calculator.py \
  --baseline-rate 0.10 \
  --mde 0.015 \
  --mde-type absolute \
  --alpha 0.05 \
  --power 0.8
```
