---
name: "saas-scaffolder"
description: "Gera boilerplate completo e pronto para produção de projeto SaaS incluindo autenticação, schemas de banco de dados, integração de billing, rotas de API e um dashboard funcional usando Next.js 14+ App Router, TypeScript, Tailwind CSS, shadcn/ui, Drizzle ORM e Stripe. Use quando o usuário quer criar um novo app SaaS, iniciar um projeto web baseado em assinaturas, scaffoldar uma aplicação Next.js, ou menciona termos como template starter, boilerplate, novo projeto ou configurar auth e pagamentos."
agents:
  - claude-code
---

# SaaS Scaffolder

**Tier:** PODEROSO  
**Categoria:** Time de Produto  
**Domínio:** Desenvolvimento Full-Stack / Bootstrapping de Projeto

---

## Formato de Entrada

```
Product: [nome]
Description: [1-3 frases]
Auth: nextauth | clerk | supabase
Database: neondb | supabase | planetscale
Payments: stripe | lemonsqueezy | none
Features: [lista separada por vírgula]
```

---

## Árvore de Arquivos de Saída

```
my-saas/
├── app/
│   ├── (auth)/
│   │   ├── login/page.tsx
│   │   ├── register/page.tsx
│   │   └── layout.tsx
│   ├── (dashboard)/
│   │   ├── dashboard/page.tsx
│   │   ├── settings/page.tsx
│   │   ├── billing/page.tsx
│   │   └── layout.tsx
│   ├── (marketing)/
│   │   ├── page.tsx
│   │   ├── pricing/page.tsx
│   │   └── layout.tsx
│   ├── api/
│   │   ├── auth/[...nextauth]/route.ts
│   │   ├── webhooks/stripe/route.ts
│   │   ├── billing/checkout/route.ts
│   │   └── billing/portal/route.ts
│   └── layout.tsx
├── components/
│   ├── ui/
│   ├── auth/
│   │   ├── login-form.tsx
│   │   └── register-form.tsx
│   ├── dashboard/
│   │   ├── sidebar.tsx
│   │   ├── header.tsx
│   │   └── stats-card.tsx
│   ├── marketing/
│   │   ├── hero.tsx
│   │   ├── features.tsx
│   │   ├── pricing.tsx
│   │   └── footer.tsx
│   └── billing/
│       ├── plan-card.tsx
│       └── usage-meter.tsx
├── lib/
│   ├── auth.ts
│   ├── db.ts
│   ├── stripe.ts
│   ├── validations.ts
│   └── utils.ts
├── db/
│   ├── schema.ts
│   └── migrations/
├── hooks/
│   ├── use-subscription.ts
│   └── use-user.ts
├── types/index.ts
├── middleware.ts
├── .env.example
├── drizzle.config.ts
└── next.config.ts
```

---

## Padrões de Componentes Principais

### Configuração de Auth (NextAuth)

```typescript
// lib/auth.ts
import { NextAuthOptions } from "next-auth"
import GoogleProvider from "next-auth/providers/google"
import { DrizzleAdapter } from "@auth/drizzle-adapter"
import { db } from "./db"

export const authOptions: NextAuthOptions = {
  adapter: DrizzleAdapter(db),
  providers: [
    GoogleProvider({
      clientId: process.env.GOOGLE_CLIENT_ID!,
      clientSecret: process.env.GOOGLE_CLIENT_SECRET!,
    }),
  ],
  callbacks: {
    session: async ({ session, user }) => ({
      ...session,
      user: {
        ...session.user,
        id: user.id,
        subscriptionStatus: user.subscriptionStatus,
      },
    }),
  },
  pages: { signIn: "/login" },
}
```

### Schema de Banco de Dados (Drizzle + NeonDB)

```typescript
// db/schema.ts
import { pgTable, text, timestamp, integer } from "drizzle-orm/pg-core"

export const users = pgTable("users", {
  id: text("id").primaryKey().$defaultFn(() => crypto.randomUUID()),
  name: text("name"),
  email: text("email").notNull().unique(),
  emailVerified: timestamp("emailVerified"),
  image: text("image"),
  stripeCustomerId: text("stripe_customer_id").unique(),
  stripeSubscriptionId: text("stripe_subscription_id"),
  stripePriceId: text("stripe_price_id"),
  stripeCurrentPeriodEnd: timestamp("stripe_current_period_end"),
  createdAt: timestamp("created_at").defaultNow().notNull(),
})

export const accounts = pgTable("accounts", {
  userId: text("user_id").notNull().references(() => users.id, { onDelete: "cascade" }),
  type: text("type").notNull(),
  provider: text("provider").notNull(),
  providerAccountId: text("provider_account_id").notNull(),
  refresh_token: text("refresh_token"),
  access_token: text("access_token"),
  expires_at: integer("expires_at"),
})
```

### Rota de Checkout Stripe

```typescript
// app/api/billing/checkout/route.ts
import { NextResponse } from "next/server"
import { getServerSession } from "next-auth"
import { authOptions } from "@/lib/auth"
import { stripe } from "@/lib/stripe"
import { db } from "@/lib/db"
import { users } from "@/db/schema"
import { eq } from "drizzle-orm"

export async function POST(req: Request) {
  const session = await getServerSession(authOptions)
  if (!session?.user) return NextResponse.json({ error: "Unauthorized" }, { status: 401 })

  const { priceId } = await req.json()
  const [user] = await db.select().from(users).where(eq(users.id, session.user.id))

  let customerId = user.stripeCustomerId
  if (!customerId) {
    const customer = await stripe.customers.create({ email: session.user.email! })
    customerId = customer.id
    await db.update(users).set({ stripeCustomerId: customerId }).where(eq(users.id, user.id))
  }

  const checkoutSession = await stripe.checkout.sessions.create({
    customer: customerId,
    mode: "subscription",
    payment_method_types: ["card"],
    line_items: [{ price: priceId, quantity: 1 }],
    success_url: `${process.env.NEXT_PUBLIC_APP_URL}/dashboard?upgraded=true`,
    cancel_url: `${process.env.NEXT_PUBLIC_APP_URL}/pricing`,
    subscription_data: { trial_period_days: 14 },
  })

  return NextResponse.json({ url: checkoutSession.url })
}
```

### Middleware

```typescript
// middleware.ts
import { withAuth } from "next-auth/middleware"
import { NextResponse } from "next/server"

export default withAuth(
  function middleware(req) {
    const token = req.nextauth.token
    if (req.nextUrl.pathname.startsWith("/dashboard") && !token) {
      return NextResponse.redirect(new URL("/login", req.url))
    }
  },
  { callbacks: { authorized: ({ token }) => !!token } }
)

export const config = {
  matcher: ["/dashboard/:path*", "/settings/:path*", "/billing/:path*"],
}
```

### Template de Variáveis de Ambiente

```bash
# .env.example
NEXT_PUBLIC_APP_URL=http://localhost:3000
DATABASE_URL=postgresql://user:pass@ep-xxx.us-east-1.aws.neon.tech/neondb?sslmode=require
NEXTAUTH_SECRET=generate-with-openssl-rand-base64-32
NEXTAUTH_URL=http://localhost:3000
GOOGLE_CLIENT_ID=
GOOGLE_CLIENT_SECRET=
STRIPE_SECRET_KEY=sk_test_...
STRIPE_WEBHOOK_SECRET=whsec_...
NEXT_PUBLIC_STRIPE_PUBLISHABLE_KEY=pk_test_...
STRIPE_PRO_PRICE_ID=price_...
```

---

## Lista de Verificação de Scaffold

As seguintes fases devem ser concluídas em ordem. **Valide ao final de cada fase antes de prosseguir.**

### Fase 1: — Fundação
- [ ] 1. Next.js inicializado com TypeScript e App Router
- [ ] 2. Tailwind CSS configurado com tokens de tema personalizados
- [ ] 3. shadcn/ui instalado e configurado
- [ ] 4. ESLint + Prettier configurados
- [ ] 5. `.env.example` criado com todas as variáveis necessárias

✅ **Validar:** Execute `npm run build` — sem erros TypeScript ou de lint devem aparecer.  
🔧 **Se o build falhar:** Verifique os caminhos de `tsconfig.json` e que todas as dependências peer do shadcn/ui estão instaladas.

### Fase 2: — Banco de Dados
- [ ] 6. Drizzle ORM instalado e configurado
- [ ] 7. Schema escrito (users, accounts, sessions, verification_tokens)
- [ ] 8. Migração inicial gerada e aplicada
- [ ] 9. Singleton do cliente DB exportado de `lib/db.ts`
- [ ] 10. Conexão com DB testada no ambiente local

✅ **Validar:** Execute um simples `db.select().from(users)` em um script de teste — deve retornar um array vazio sem lançar erros.  
🔧 **Se a conexão com DB falhar:** Verifique se o formato de `DATABASE_URL` inclui `?sslmode=require` para NeonDB/Supabase. Verifique se a migração foi aplicada com `drizzle-kit push` (dev) ou `drizzle-kit migrate` (prod).

### Fase 3: — Autenticação
- [ ] 11. Provedor de auth instalado (NextAuth / Clerk / Supabase)
- [ ] 12. Provedor OAuth configurado (Google / GitHub)
- [ ] 13. Rota de API de auth criada
- [ ] 14. Callback de sessão adiciona ID do usuário e status de assinatura
- [ ] 15. Middleware protege rotas do dashboard
- [ ] 16. Páginas de login e registro construídas com estados de erro

✅ **Validar:** Faça login via OAuth, confirme que o usuário da sessão tem `id` e `subscriptionStatus`. Tente acessar `/dashboard` sem sessão — você deve ser redirecionado para `/login`.  
🔧 **Se loops de logout ocorrerem em produção:** Garanta que `NEXTAUTH_SECRET` está definido e consistente entre implantações. Adicione `declare module "next-auth"` para estender tipos de sessão se erros TypeScript aparecerem.

### Fase 4: — Pagamentos
- [ ] 17. Cliente Stripe inicializado com tipos TypeScript
- [ ] 18. Rota de sessão de checkout criada
- [ ] 19. Rota do portal do cliente criada
- [ ] 20. Handler de webhook Stripe com verificação de assinatura
- [ ] 21. Webhook atualiza status de assinatura do usuário no DB de forma idempotente

✅ **Validar:** Conclua um checkout de teste Stripe usando um cartão `4242 4242 4242 4242`. Confirme que `stripeSubscriptionId` está escrito no DB. Replaye o evento de webhook `checkout.session.completed` e confirme idempotência (sem escritas duplicadas no DB).  
🔧 **Se a assinatura do webhook falhar:** Use `stripe listen --forward-to localhost:3000/api/webhooks/stripe` localmente — nunca hardcode o segredo do webhook bruto. Verifique se `STRIPE_WEBHOOK_SECRET` corresponde à saída do listener.

### Fase 5: — Interface
- [ ] 22. Landing page com seções hero, funcionalidades e preços
- [ ] 23. Layout do dashboard com sidebar e header responsivo
- [ ] 24. Página de billing mostrando plano atual e opções de upgrade
- [ ] 25. Página de configurações com formulário de atualização de perfil e estados de sucesso

✅ **Validar:** Execute `npm run build` para uma verificação de build de produção final. Navegue por todas as rotas manualmente e confirme que não há layouts quebrados, dados de sessão ausentes ou erros de hidratação.

---

## Arquivos de Referência

Para orientação adicional, gere os seguintes arquivos de referência complementares junto com o scaffold:

- **`CUSTOMIZATION.md`** — Provedores de auth, opções de banco de dados, alternativas de ORM, provedores de pagamento, temas de UI e modelos de billing (por assento, taxa fixa, baseado em uso).
- **`PITFALLS.md`** — Modos de falha comuns: `NEXTAUTH_SECRET` ausente, incompatibilidades de segredo de webhook, conflitos do Edge runtime com Drizzle, tipos de sessão não estendidos e diferenças de estratégia de migração entre dev e prod.
- **`BEST_PRACTICES.md`** — Padrão singleton do Stripe, server actions para mutações de formulário, handlers de webhook idempotentes, boundaries `Suspense` para dados assíncronos do dashboard, feature gating do lado do servidor via `stripeCurrentPeriodEnd` e limitação de taxa em rotas de auth com Upstash Redis + `@upstash/ratelimit`.
