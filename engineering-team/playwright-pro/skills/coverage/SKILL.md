---
name: "coverage"
description: >-
  Analise lacunas de cobertura de testes. Use quando o usuário disser "cobertura de testes",
  "o que não está testado", "lacunas de cobertura", "testes ausentes", "relatório de cobertura"
  ou "o que precisa de testes".
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Analisar Lacunas de Cobertura de Testes

Mapear todas as superfícies testáveis na aplicação e identificar o que está testado vs. o que está faltando.

## Passos

### 1. Mapear Superfície da Aplicação

Use o subagente `Explore` para catalogar:

**Rotas/Páginas:**
- Escanear definições de rota (diretório `app/` do Next.js, config do React Router, Vue Router, etc.)
- Listar todas as páginas voltadas ao usuário com seus caminhos

**Componentes:**
- Identificar componentes interativos (formulários, modais, dropdowns, tabelas)
- Anotar componentes com lógica de estado complexa

**Endpoints de API:**
- Escanear arquivos de rota de API ou controllers do backend
- Listar todos os endpoints com seus métodos

**Fluxos de Usuário:**
- Identificar caminhos críticos: auth, checkout, integração, funcionalidades principais
- Mapear fluxos de trabalho em múltiplas etapas

### 2. Mapear Testes Existentes

Escanear todos os arquivos `*.spec.ts` / `*.spec.js`:

- Extrair quais páginas/rotas estão cobertas (por chamadas `page.goto()`)
- Extrair quais componentes estão testados (por uso de localizador)
- Extrair quais endpoints de API são simulados ou acessados
- Contar testes por área

### 3. Gerar Matriz de Cobertura

```
## Matriz de Cobertura

| Área | Rota | Testes | Status |
|---|---|---|---|
| Auth | /login | 5 | ✅ Coberto |
| Auth | /register | 0 | ❌ Faltando |
| Auth | /forgot-password | 0 | ❌ Faltando |
| Dashboard | /dashboard | 3 | ⚠️ Parcial (sem estados de erro) |
| Configurações | /settings | 0 | ❌ Faltando |
| Checkout | /checkout | 8 | ✅ Coberto |
```

### 4. Priorizar Lacunas

Classificar áreas não cobertas por impacto nos negócios:

1. **Crítico** — auth, pagamento, funcionalidades principais → testar primeiro
2. **Alto** — CRUD voltado ao usuário, pesquisa, navegação
3. **Médio** — configurações, preferências, casos extremos
4. **Baixo** — páginas estáticas, sobre, termos

### 5. Sugerir Plano de Testes

Para cada lacuna, recomendar:
- Número de testes necessários
- Qual template de `templates/` usar
- Esforço estimado (rápido/médio/complexo)

```
## Plano de Testes Recomendado

### Prioridade 1: Crítico
1. /register (4 testes) — usar template auth/registration — rápido
2. /forgot-password (3 testes) — usar template auth/password-reset — rápido

### Prioridade 2: Alto
3. /settings (4 testes) — usar templates settings/ — médio
4. Estados de erro do Dashboard (2 testes) — usar template dashboard/data-loading — rápido
```

### 6. Auto-Gerar (Opcional)

Perguntar ao usuário: "Gerar testes para as N principais lacunas? [Sim/Não/Escolher específicos]"

Se sim, invocar `/pw:generate` para cada lacuna com o template recomendado.

## Saída

- Matriz de cobertura (formato de tabela)
- Estimativa percentual de cobertura
- Lista de lacunas priorizadas com estimativas de esforço
- Opção de auto-gerar testes ausentes
