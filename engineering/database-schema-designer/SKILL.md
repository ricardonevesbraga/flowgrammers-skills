---
name: "database-schema-designer"
description: "Use quando o usuário pedir para criar diagramas ERD, normalizar schemas de banco de dados, projetar relacionamentos de tabelas ou planejar migrações de schema."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Database Schema Designer

**Nível:** PODEROSO  
**Categoria:** Engenharia  
**Domínio:** Arquitetura de Dados / Backend  

---

## Visão Geral

Projete schemas de banco de dados relacional a partir de requisitos e gere migrações, tipos TypeScript/Python, dados de seed, políticas RLS e índices. Lida com multi-tenancy, soft deletes, trilhas de auditoria, versionamento e associações polimórficas.

## Capacidades Principais

- **Design de schema** — normalize requisitos em tabelas, relacionamentos, restrições
- **Geração de migração** — Drizzle, Prisma, TypeORM, Alembic
- **Geração de tipos** — interfaces TypeScript, dataclasses/modelos Pydantic Python
- **Políticas RLS** — Row-Level Security para apps multi-tenant
- **Estratégia de índice** — índices compostos, parciais, covering
- **Dados de seed** — geração de dados de teste realistas
- **Geração de ERD** — diagrama Mermaid a partir do schema

---

## Quando Usar

- Projetando uma nova funcionalidade que precisa de tabelas de banco de dados
- Revisando um schema para problemas de performance ou normalização
- Adicionando multi-tenancy a um schema existente
- Gerando tipos TypeScript a partir de um schema Prisma
- Planejando uma migração de schema para uma mudança que quebra compatibilidade

---

## Processo de Design de Schema

### Passo 1: Requisitos → Entidades

Dados os requisitos:
> "Usuários podem criar projetos. Cada projeto tem tarefas. Tarefas podem ter labels. Tarefas podem ser atribuídas a usuários. Precisamos de uma trilha de auditoria completa."

Extraia as entidades:
```
User, Project, Task, Label, TaskLabel (junção), TaskAssignment, AuditLog
```

### Passo 2: Identificar Relacionamentos

```
User 1──* Project         (proprietário)
Project 1──* Task
Task *──* Label            (via TaskLabel)
Task *──* User            (via TaskAssignment)
User 1──* AuditLog
```

### Passo 3: Adicionar Preocupações Transversais

- Multi-tenancy: adicione `organization_id` a todas as tabelas com escopo de tenant
- Soft deletes: adicione `deleted_at TIMESTAMPTZ` em vez de hard deletes
- Trilha de auditoria: adicione `created_by`, `updated_by`, `created_at`, `updated_at`
- Versionamento: adicione `version INTEGER` para bloqueio otimista

---

## Exemplo Completo de Schema (SaaS de Gerenciamento de Tarefas)
→ Veja references/full-schema-examples.md para detalhes

## Políticas Row-Level Security (RLS)

```sql
-- Habilitar RLS
ALTER TABLE tasks ENABLE ROW LEVEL SECURITY;
ALTER TABLE projects ENABLE ROW LEVEL SECURITY;

-- Criar role da aplicação
CREATE ROLE app_user;

-- Usuários só podem ver tarefas nos projetos de sua organização
CREATE POLICY tasks_org_isolation ON tasks
  FOR ALL TO app_user
  USING (
    project_id IN (
      SELECT p.id FROM projects p
      JOIN organization_members om ON om.organization_id = p.organization_id
      WHERE om.user_id = current_setting('app.current_user_id')::text
    )
  );

-- Soft delete: nunca mostrar registros deletados
CREATE POLICY tasks_no_deleted ON tasks
  FOR SELECT TO app_user
  USING (deleted_at IS NULL);

-- Apenas o criador da tarefa ou admin pode deletar
CREATE POLICY tasks_delete_policy ON tasks
  FOR DELETE TO app_user
  USING (
    created_by_id = current_setting('app.current_user_id')::text
    OR EXISTS (
      SELECT 1 FROM organization_members om
      JOIN projects p ON p.organization_id = om.organization_id
      WHERE p.id = tasks.project_id
        AND om.user_id = current_setting('app.current_user_id')::text
        AND om.role IN ('owner', 'admin')
    )
  );

-- Definir contexto do usuário (chamar no início de cada requisição)
SELECT set_config('app.current_user_id', $1, true);
```

---

## Geração de Dados de Seed

```typescript
// db/seed.ts
import { faker } from '@faker-js/faker'
import { db } from './client'
import { organizations, users, projects, tasks } from './schema'
import { createId } from '@paralleldrive/cuid2'
import { hashPassword } from '../src/lib/auth'

async function seed() {
  console.log('Seeding database...')

  // Criar org
  const [org] = await db.insert(organizations).values({
    id: createId(),
    name: "acme-corp",
    slug: 'acme',
    plan: 'growth',
  }).returning()

  // Criar usuários
  const adminUser = await db.insert(users).values({
    id: createId(),
    email: 'admin@acme.com',
    name: "alice-admin",
    passwordHash: await hashPassword('password123'),
  }).returning().then(r => r[0])

  // Criar projetos
  const projectsData = Array.from({ length: 3 }, () => ({
    id: createId(),
    organizationId: org.id,
    ownerId: adminUser.id,
    name: "fakercompanycatchphrase"
    description: faker.lorem.paragraph(),
    status: 'active' as const,
  }))

  const createdProjects = await db.insert(projects).values(projectsData).returning()

  // Criar tarefas para cada projeto
  for (const project of createdProjects) {
    const tasksData = Array.from({ length: faker.number.int({ min: 5, max: 20 }) }, (_, i) => ({
      id: createId(),
      projectId: project.id,
      title: faker.hacker.phrase(),
      description: faker.lorem.sentences(2),
      status: faker.helpers.arrayElement(['todo', 'in_progress', 'done'] as const),
      priority: faker.helpers.arrayElement(['low', 'medium', 'high'] as const),
      position: i * 1000,
      createdById: adminUser.id,
      updatedById: adminUser.id,
    }))

    await db.insert(tasks).values(tasksData)
  }

  console.log(`✅ Seeded: 1 org, ${projectsData.length} projects, tasks`)
}

seed().catch(console.error).finally(() => process.exit(0))
```

---

## Geração de ERD (Mermaid)

```
erDiagram
    Organization ||--o{ OrganizationMember : has
    Organization ||--o{ Project : owns
    User ||--o{ OrganizationMember : joins
    User ||--o{ Task : "created by"
    Project ||--o{ Task : contains
    Task ||--o{ TaskAssignment : has
    Task ||--o{ TaskLabel : has
    Task ||--o{ Comment : has
    Task ||--o{ Attachment : has
    Label ||--o{ TaskLabel : "applied to"
    User ||--o{ TaskAssignment : assigned

    Organization {
        string id PK
        string name
        string slug
        string plan
    }

    Task {
        string id PK
        string project_id FK
        string title
        string status
        string priority
        timestamp due_date
        timestamp deleted_at
        int version
    }
```

Gerar a partir do Prisma:
```bash
npx prisma-erd-generator
# ou: npx @dbml/cli prisma2dbml -i schema.prisma | npx dbml-to-mermaid
```

---

## Armadilhas Comuns

- **Soft delete sem índice** — `WHERE deleted_at IS NULL` sem índice = varredura completa
- **Índices compostos ausentes** — `WHERE org_id = ? AND status = ?` precisa de um índice composto
- **Chaves substitutas mutáveis** — nunca use e-mail ou slug como PK; use UUID/CUID
- **Coluna NOT NULL sem padrão** — adicionar uma coluna NOT NULL a uma tabela existente exige padrão ou plano de migração
- **Sem bloqueio otimista** — atualizações concorrentes se sobrescrevem; adicione coluna `version`
- **RLS não testado** — sempre teste RLS com uma role que não seja superuser

---

## Melhores Práticas

1. **Timestamps em todo lugar** — `created_at`, `updated_at` em todas as tabelas
2. **Soft deletes para dados auditáveis** — `deleted_at` em vez de DELETE
3. **Log de auditoria para conformidade** — registre JSON antes/depois para domínios regulados
4. **UUIDs ou CUIDs como PKs** — evite vazamento de inteiros sequenciais
5. **Indexe foreign keys** — toda coluna FK deve ter um índice
6. **Índices parciais** — use `WHERE deleted_at IS NULL` para queries somente de ativos
7. **RLS sobre filtragem em nível de aplicação** — o banco de dados aplica a tenancy, não apenas o código da aplicação
