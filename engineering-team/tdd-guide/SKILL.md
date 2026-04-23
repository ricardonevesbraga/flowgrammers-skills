---
name: "tdd-guide"
description: "Skill de desenvolvimento orientado a testes para escrever testes unitários, gerar fixtures e mocks de teste, analisar lacunas de cobertura e guiar workflows red-green-refactor em Jest, Pytest, JUnit, Vitest e Mocha. Use quando o usuário pedir para escrever testes, melhorar cobertura de testes, praticar TDD, gerar mocks ou stubs, ou mencionar frameworks de teste como Jest, pytest ou JUnit."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Guia de TDD

Skill de desenvolvimento orientado a testes para gerar testes, analisar cobertura e guiar workflows red-green-refactor em Jest, Pytest, JUnit e Vitest.

---

## Workflows

### Gerar Testes a partir do Código

1. Forneça o código-fonte (TypeScript, JavaScript, Python, Java)
2. Especifique o framework alvo (Jest, Pytest, JUnit, Vitest)
3. Execute `test_generator.py` com os requisitos
4. Revise os stubs de teste gerados
5. **Validação:** Testes compilam e cobrem caminho feliz, casos de erro, casos extremos

### Analisar Lacunas de Cobertura

1. Gere relatório de cobertura a partir do test runner (`npm test -- --coverage`)
2. Execute `coverage_analyzer.py` no relatório LCOV/JSON/XML
3. Revise lacunas priorizadas (P0/P1/P2)
4. Gere testes ausentes para caminhos não cobertos
5. **Validação:** Cobertura atinge threshold alvo (tipicamente 80%+)

### TDD de Nova Funcionalidade

1. Escreva o teste que falha primeiro (RED)
2. Execute `tdd_workflow.py --phase red` para validar
3. Implemente código mínimo para passar (GREEN)
4. Execute `tdd_workflow.py --phase green` para validar
5. Refatore mantendo os testes verdes (REFACTOR)
6. **Validação:** Todos os testes passam após cada ciclo

---

## Exemplos

### Geração de Teste — Entrada → Saída (Pytest)

**Função-fonte de entrada (`math_utils.py`):**
```python
def divide(a: float, b: float) -> float:
    if b == 0:
        raise ValueError("Cannot divide by zero")
    return a / b
```

**Comando:**
```bash
python scripts/test_generator.py --input math_utils.py --framework pytest
```

**Saída de teste gerada (`test_math_utils.py`):**
```python
import pytest
from math_utils import divide

class TestDivide:
    def test_divide_positive_numbers(self):
        assert divide(10, 2) == 5.0

    def test_divide_negative_numerator(self):
        assert divide(-10, 2) == -5.0

    def test_divide_float_result(self):
        assert divide(1, 3) == pytest.approx(0.333, rel=1e-3)

    def test_divide_by_zero_raises_value_error(self):
        with pytest.raises(ValueError, match="Cannot divide by zero"):
            divide(10, 0)

    def test_divide_zero_numerator(self):
        assert divide(0, 5) == 0.0
```

---

### Análise de Cobertura — Exemplo de Saída P0/P1/P2

**Comando:**
```bash
python scripts/coverage_analyzer.py --report lcov.info --threshold 80
```

**Exemplo de saída:**
```
Relatório de Cobertura — Geral: 63% (threshold: 80%)

P0 — Lacunas críticas (caminhos de erro não cobertos):
  auth/login.py:42-58   handle_expired_token()       0% coberto
  payments/process.py:91-110  handle_payment_failure()   0% coberto

P1 — Lacunas de alto valor (branches de lógica central):
  users/service.py:77   update_profile() — branch else  0% coberto
  orders/cart.py:134    apply_discount() — guarda de qtd zero  0% coberto

P2 — Lacunas de baixo risco (funções utilitárias / auxiliares):
  utils/formatting.py:12  format_currency()            0% coberto

Recomendado: Gere testes para itens P0 primeiro para atingir threshold de 80%.
```

---

## Ferramentas Principais

| Ferramenta | Propósito | Uso |
|------|---------|-------|
| `test_generator.py` | Gerar casos de teste a partir de código/requisitos | `python scripts/test_generator.py --input source.py --framework pytest` |
| `coverage_analyzer.py` | Analisar e processar relatórios de cobertura | `python scripts/coverage_analyzer.py --report lcov.info --threshold 80` |
| `tdd_workflow.py` | Guiar ciclos red-green-refactor | `python scripts/tdd_workflow.py --phase red --test test_auth.py` |
| `fixture_generator.py` | Gerar dados de teste e mocks | `python scripts/fixture_generator.py --entity User --count 5` |

Scripts adicionais: `framework_adapter.py` (converter entre frameworks), `metrics_calculator.py` (métricas de qualidade), `format_detector.py` (detectar linguagem/framework), `output_formatter.py` (saída CLI/desktop/CI).

---

## Requisitos de Entrada

**Para Geração de Teste:**
- Código-fonte (caminho de arquivo ou conteúdo colado)
- Framework alvo (Jest, Pytest, JUnit, Vitest)
- Escopo de cobertura (unit, integration, edge cases)

**Para Análise de Cobertura:**
- Arquivo de relatório de cobertura (formato LCOV, JSON ou XML)
- Opcional: Código-fonte para contexto
- Opcional: Percentual threshold alvo

**Para Workflow TDD:**
- Requisitos de funcionalidade ou história de usuário
- Fase atual (RED, GREEN, REFACTOR)
- Código de teste e status de implementação

---

## Workflow Spec-Primeiro

TDD é mais eficaz quando orientado por uma spec escrita. O fluxo:

1. **Escrever ou receber uma spec** — armazenada em `specs/<feature>.md`
2. **Extrair critérios de aceitação** — cada critério vira um ou mais casos de teste
3. **Escrever testes que falham (RED)** — um teste por critério de aceitação
4. **Implementar código mínimo (GREEN)** — satisfazer cada teste em ordem
5. **Refatorar** — limpar enquanto todos os testes permanecem verdes

### Convenção de Diretório de Spec

```
project/
├── specs/
│   ├── user-auth.md          # Spec da funcionalidade com critérios de aceitação
│   ├── payment-processing.md
│   └── notification-system.md
├── tests/
│   ├── test_user_auth.py     # Testes derivados de specs/user-auth.md
│   ├── test_payments.py
│   └── test_notifications.py
└── src/
```

### Extraindo Testes de Specs

Cada critério de aceitação em uma spec mapeia para pelo menos um teste:

| Critério da Spec | Caso de Teste |
|---------------|-----------|
| "Usuário pode fazer login com credenciais válidas" | `test_login_valid_credentials_returns_token` |
| "Senha inválida retorna 401" | `test_login_invalid_password_returns_401` |
| "Conta bloqueia após 5 tentativas falhas" | `test_login_locks_after_five_failures` |

**Dica:** Numere seus critérios de aceitação na spec. Referencie o número na docstring do teste para rastreabilidade (`# AC-3: Conta bloqueia após 5 tentativas falhas`).

> **Cross-reference:** Veja `engineering/spec-driven-workflow` para a metodologia completa de spec, incluindo templates de spec e checklists de revisão.

---

## Exemplos Red-Green-Refactor por Linguagem

### TypeScript / Jest

```typescript
// test/cart.test.ts
describe("Cart", () => {
  describe("addItem", () => {
    it("deve adicionar um novo item a um carrinho vazio", () => {
      const cart = new Cart();
      cart.addItem({ id: "sku-1", name: "Widget", price: 9.99, qty: 1 });

      expect(cart.items).toHaveLength(1);
      expect(cart.items[0].id).toBe("sku-1");
    });

    it("deve incrementar quantidade ao adicionar item existente", () => {
      const cart = new Cart();
      cart.addItem({ id: "sku-1", name: "Widget", price: 9.99, qty: 1 });
      cart.addItem({ id: "sku-1", name: "Widget", price: 9.99, qty: 2 });

      expect(cart.items).toHaveLength(1);
      expect(cart.items[0].qty).toBe(3);
    });

    it("deve lançar quando quantidade é zero ou negativa", () => {
      const cart = new Cart();
      expect(() =>
        cart.addItem({ id: "sku-1", name: "Widget", price: 9.99, qty: 0 })
      ).toThrow("Quantity must be positive");
    });
  });
});
```

### Python / Pytest (Padrões Avançados)

```python
# tests/conftest.py — fixtures compartilhadas
import pytest
from app.db import create_engine, Session

@pytest.fixture(scope="session")
def db_engine():
    engine = create_engine("sqlite:///:memory:")
    yield engine
    engine.dispose()

@pytest.fixture
def db_session(db_engine):
    session = Session(bind=db_engine)
    yield session
    session.rollback()
    session.close()

# tests/test_pricing.py — parametrize para múltiplos casos
import pytest
from app.pricing import calculate_discount

@pytest.mark.parametrize("subtotal, expected_discount", [
    (50.0, 0.0),       # Abaixo do threshold — sem desconto
    (100.0, 5.0),      # Tier de 5%
    (250.0, 25.0),     # Tier de 10%
    (500.0, 75.0),     # Tier de 15%
])
def test_calculate_discount(subtotal, expected_discount):
    assert calculate_discount(subtotal) == pytest.approx(expected_discount)
```

### Go — Testes Orientados a Tabela

```go
// cart_test.go
package cart

import "testing"

func TestApplyDiscount(t *testing.T) {
    tests := []struct {
        name     string
        subtotal float64
        want     float64
    }{
        {"sem desconto abaixo do threshold", 50.0, 0.0},
        {"tier de 5 porcento", 100.0, 5.0},
        {"tier de 10 porcento", 250.0, 25.0},
        {"tier de 15 porcento", 500.0, 75.0},
        {"subtotal zero", 0.0, 0.0},
    }

    for _, tt := range tests {
        t.Run(tt.name, func(t *testing.T) {
            got := ApplyDiscount(tt.subtotal)
            if got != tt.want {
                t.Errorf("ApplyDiscount(%v) = %v, want %v", tt.subtotal, got, tt.want)
            }
        })
    }
}
```

---

## Regras de Autonomia Delimitada

Ao gerar testes autonomamente, siga estas regras para decidir quando parar e perguntar ao usuário:

### Pare e Pergunte Quando

- **Requisitos ambíguos** — a spec ou história de usuário tem critérios de aceitação conflitantes ou unclear
- **Edge cases ausentes** — não é possível determinar valores limite sem conhecimento de domínio (ex.: valor máximo de transação permitido)
- **Contagem de testes excede 50** — grandes suites de teste precisam de revisão humana antes de commitar; apresente um resumo e pergunte quais áreas priorizar
- **Dependências externas unclear** — a funcionalidade depende de APIs ou serviços de terceiros com comportamento não documentado
- **Lógica sensível à segurança** — autenticação, autorização, criptografia ou fluxos de pagamento requerem aprovação humana nos cenários de teste

### Continue Autonomamente Quando

- **Spec clara com critérios de aceitação numerados** — cada critério mapeia diretamente para testes
- **Operações CRUD diretas** — criar, ler, atualizar, deletar com modelos bem definidos
- **Contratos de API bem definidos** — spec OpenAPI ou interfaces tipadas disponíveis
- **Funções puras** — entrada/saída determinística sem efeitos colaterais
- **Padrões de teste existentes** — a base de código já possui testes similares para seguir

---

## Testes Baseados em Propriedades

Testes baseados em propriedades geram entradas aleatórias para verificar invariantes em vez de depender de exemplos escolhidos manualmente. Use quando o espaço de entrada é grande e o comportamento esperado pode ser descrito como uma propriedade.

### Python — Hypothesis

```python
from hypothesis import given, strategies as st
from app.serializers import serialize, deserialize

@given(st.text())
def test_roundtrip_serialization(data):
    """Serialização seguida de desserialização retorna o original."""
    assert deserialize(serialize(data)) == data

@given(st.integers(), st.integers())
def test_addition_is_commutative(a, b):
    assert a + b == b + a
```

### TypeScript — fast-check

```typescript
import fc from "fast-check";
import { encode, decode } from "./codec";

test("roundtrip encode/decode", () => {
  fc.assert(
    fc.property(fc.string(), (input) => {
      expect(decode(encode(input))).toBe(input);
    })
  );
});
```

### Quando Usar Baseado em Propriedades vs Baseado em Exemplo

| Use Baseado em Propriedades | Exemplo |
|-------------------|---------|
| Transformações de dados | Roundtrips de serialização/desserialização |
| Propriedades matemáticas | Comutatividade, associatividade, idempotência |
| Codificação/decodificação | Base64, codificação URL, compressão |
| Ordenação e filtragem | Saída está ordenada, comprimento preservado |
| Correção de parser | Entrada válida sempre parseia sem erro |

---

## Testes de Mutação

Testes de mutação modificam seu código de produção (criam "mutantes") e verificam se seus testes detectam as mudanças. Se um mutante sobreviver (testes ainda passam), seus testes têm uma lacuna que a cobertura sozinha não consegue revelar.

### Ferramentas

| Linguagem | Ferramenta | Comando |
|----------|------|---------|
| TypeScript/JavaScript | **Stryker** | `npx stryker run` |
| Python | **mutmut** | `mutmut run --paths-to-mutate=src/` |
| Java | **PIT** | `mvn org.pitest:pitest-maven:mutationCoverage` |

### Por que Testes de Mutação Importam

- **100% de cobertura de linha != bons testes** — cobertura diz que o código foi executado, não que foi verificado
- **Captura assertions fracas** — testes que executam o código mas não assertam nada significativo
- **Encontra testes de boundary ausentes** — mutantes que mudam `<` para `<=` expõem lacunas de off-by-one
- **Métrica de qualidade quantificável** — score de mutação (% mutantes eliminados) é um sinal mais forte que %  de cobertura

**Recomendação:** Execute testes de mutação em caminhos críticos (auth, pagamentos, processamento de dados) mesmo que a cobertura geral seja alta. Mire 85%+ de score de mutação em módulos P0.

---

## Cross-Referências

| Skill | Relação |
|-------|-------------|
| `engineering/spec-driven-workflow` | Pipeline spec → critérios de aceitação → extração de testes |
| `engineering-team/focused-fix` | Fase 5 (Verificar) usa TDD para confirmar a correção com um teste de regressão |
| `engineering-team/senior-qa` | Estratégia de QA mais ampla; TDD é uma camada na pirâmide de testes |
| `engineering-team/code-reviewer` | Revisar testes gerados para qualidade de assertion e completude de cobertura |
| `engineering-team/senior-fullstack` | Scaffolders de projeto incluem infraestrutura de teste compatível com workflows TDD |

---

## Limitações

| Escopo | Detalhes |
|-------|---------|
| Foco em testes unitários | Testes de integração e E2E requerem padrões diferentes |
| Análise estática | Não pode executar testes ou medir comportamento em runtime |
| Suporte a linguagens | Melhor para TypeScript, JavaScript, Python, Java |
| Formatos de relatório | Apenas LCOV, JSON, XML; outros formatos precisam de conversão |
| Testes gerados | Fornecem scaffolding; requerem revisão humana para lógica complexa |

**Quando usar outras ferramentas:**
- Testes E2E: Playwright, Cypress, Selenium
- Testes de performance: k6, JMeter, Locust
- Testes de segurança: OWASP ZAP, Burp Suite
