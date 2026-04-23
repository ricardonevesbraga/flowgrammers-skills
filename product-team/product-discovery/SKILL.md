---
name: product-discovery
description: Use ao validar oportunidades de produto, mapear suposições, planejar sprints de descoberta ou testar o fit problema-solução antes de comprometer recursos de entrega.
agents:
  - claude-code
---

# Descoberta de Produto

Executar descoberta estruturada para identificar oportunidades de alto valor e reduzir o risco de apostas de produto.

## Quando Usar

Use esta skill para:
- Facilitação da Árvore de Oportunidades e Soluções (OST)
- Mapeamento de suposições e planejamento de testes
- Entrevistas de validação de problema e síntese de evidências
- Validação de solução com protótipos/experimentos
- Planejamento de sprint de descoberta e saídas

## Fluxo de Trabalho Principal de Descoberta

1. Definir resultado desejado
- Definir um resultado mensurável para melhorar.
- Estabelecer baseline e horizonte de meta.

2. Construir Árvore de Oportunidades e Soluções (OST)
- Resultado -> oportunidades -> ideias de solução -> experimentos
- Mantenha as oportunidades baseadas em evidências do usuário, não em opiniões internas.

3. Mapear suposições
- Identificar suposições de desejabilidade, viabilidade, viabilidade técnica e usabilidade.
- Pontuar suposições por risco e certeza.

Use:
```bash
python3 scripts/assumption_mapper.py assumptions.csv
```

4. Validar o problema
- Conduzir entrevistas e análise de comportamento.
- Confirmar frequência, severidade e disposição para resolver.
- Rejeitar oportunidades fracas cedo.

5. Validar a solução
- Prototipe antes de construir.
- Executar testes de conceito, usabilidade e valor.
- Medir comportamento, não apenas preferência declarada.

6. Planejar sprint de descoberta
- Ciclo de 1-2 semanas com hipóteses explícitas
- Revisões diárias de evidências
- Terminar com decisão: prosseguir, pivotar ou parar

## Árvore de Oportunidades e Soluções (Teresa Torres)

Estrutura:
- Resultado: métrica que você quer mover
- Oportunidades: necessidades/dores não atendidas dos clientes
- Soluções: intervenções candidatas
- Experimentos: ações de aprendizado mais rápidas

Verificações de qualidade:
- Pelo menos 3 oportunidades distintas antes de convergir.
- Pelo menos 2 experimentos por oportunidade principal.
- Vincule cada ramo a uma fonte de evidência.

## Mapeamento de Suposições

Categorias de suposição:
- Desejabilidade: os usuários querem isso
- Viabilidade: valor de negócio existe
- Viabilidade técnica: a equipe pode construir/operar
- Usabilidade: os usuários conseguem usar com sucesso

Regra de priorização:
- Suposições de alto risco + baixa certeza são testadas primeiro.

## Técnicas de Validação de Problema

- Entrevistas de problema focadas no comportamento atual
- Mapeamento de fricção na jornada
- Síntese de tickets de suporte e chamadas de vendas
- Triangulação de analytics comportamental

Exemplos de limiar de evidência:
- Mesma dor repetida entre múltiplos usuários-alvo
- Comportamento de contorno observável
- Custo mensurável da dor atual

## Técnicas de Validação de Solução

- Testes de conceito (compreensão da proposta de valor)
- Testes de usabilidade com protótipo (sucesso de tarefa/tempo para completar)
- Testes de fake door ou concierge (sinal de demanda)
- Coortes beta limitadas (sinais de retenção/ativação)

## Planejamento de Sprint de Descoberta

Estrutura sugerida de 10 dias:
- Dias 1-2: Enquadramento de resultado + oportunidade
- Dias 3-4: Mapeamento de suposições + design de teste
- Dias 5-7: Testes de problema e solução
- Dias 8-9: Síntese de evidências + opções de decisão
- Dia 10: Revisão de decisão com partes interessadas

## Ferramentas

### `scripts/assumption_mapper.py`

Utilitário CLI que:
- lê suposições de CSV ou entrada inline
- pontua prioridade de risco/certeza
- emite plano de teste priorizado com tipos de teste sugeridos

Veja `references/discovery-frameworks.md` para detalhes de framework.
