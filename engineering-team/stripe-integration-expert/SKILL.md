---
name: "stripe-integration-expert"
description: "Especialista em Integração Stripe para implementar integrações Stripe em nível de produção: assinaturas com trials e proration, pagamentos únicos, billing baseado em uso, checkout sessions, handlers de webhook idempotentes, portal do cliente e faturamento. Cobre padrões Next.js, Express e Django."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Especialista em Integração Stripe

**Nível:** AVANÇADO
**Categoria:** Equipe de Engenharia
**Domínio:** Pagamentos / Infraestrutura de Billing

---

## Visão Geral

Implemente integrações Stripe em nível de produção: assinaturas com trials e proration, pagamentos únicos, billing baseado em uso, checkout sessions, handlers de webhook idempotentes, portal do cliente e faturamento. Cobre padrões Next.js, Express e Django.

---

## Capacidades Principais

- Gerenciamento do ciclo de vida de assinatura (criar, fazer upgrade, downgrade, cancelar, pausar)
- Tratamento de trial e rastreamento de conversão
- Cálculo de proration e aplicação de crédito
- Billing baseado em uso com preços por medição
- Handlers de webhook idempotentes com verificação de assinatura
- Integração do portal do cliente
- Geração de fatura e acesso a PDF
- Configuração completa de testes locais com Stripe CLI

---

## Quando Usar

- Adicionar billing de assinatura a qualquer aplicação web
- Implementar upgrades/downgrades de plano com proration
- Construir billing baseado em uso ou por assento
- Depurar falhas de entrega de webhook
- Migrar de um modelo de billing para outro

---

## Máquina de Estado do Ciclo de Vida de Assinatura

```
FREE_TRIAL ──pago──► ACTIVE ──cancelar──► CANCEL_PENDING ──fim_período──► CANCELED
     │                  │                                                    │
     │               downgrade                                            reativar
     │                  ▼                                                    │
     │             DOWNGRADING ──fim_período──► ACTIVE (plano inferior)      │
     │                                                                        │
     └──fim_trial sem pagamento──► PAST_DUE ──pagamento_falhou 3x──► CANCELED
                                          │
                                     pagamento_sucesso
                                          │
                                          ▼
                                        ACTIVE
```

### Valores de status de assinatura no DB:
`trialing | active | past_due | canceled | cancel_pending | paused | unpaid`

---

## Configuração do Cliente Stripe

```typescript
// lib/stripe.ts
import Stripe from "stripe"

export const stripe = new Stripe(process.env.STRIPE_SECRET_KEY!, {
  apiVersion: "2024-04-10",
  typescript: true,
  appInfo: {
    name: "myapp",
    version: "1.0.0",
  },
})

// IDs de preço por plano (definidos em env)
export const PLANS = {
  starter: {
    monthly: process.env.STRIPE_STARTER_MONTHLY_PRICE_ID!,
    yearly: process.env.STRIPE_STARTER_YEARLY_PRICE_ID!,
    features: ["5 projetos", "10k eventos"],
  },
  pro: {
    monthly: process.env.STRIPE_PRO_MONTHLY_PRICE_ID!,
    yearly: process.env.STRIPE_PRO_YEARLY_PRICE_ID!,
    features: ["Projetos ilimitados", "1M eventos"],
  },
} as const
```

---

## Checkout Session (Next.js App Router)

```typescript
// app/api/billing/checkout/route.ts
import { NextResponse } from "next/server"
import { stripe } from "@/lib/stripe"
import { getAuthUser } from "@/lib/auth"
import { db } from "@/lib/db"

export async function POST(req: Request) {
  const user = await getAuthUser()
  if (!user) return NextResponse.json({ error: "Não autorizado" }, { status: 401 })

  const { priceId, interval = "monthly" } = await req.json()

  // Obter ou criar cliente Stripe
  let stripeCustomerId = user.stripeCustomerId
  if (!stripeCustomerId) {
    const customer = await stripe.customers.create({
      email: user.email,
      name: user.name,
      metadata: { userId: user.id },
    })
    stripeCustomerId = customer.id
    await db.user.update({ where: { id: user.id }, data: { stripeCustomerId } })
  }

  const session = await stripe.checkout.sessions.create({
    customer: stripeCustomerId,
    mode: "subscription",
    payment_method_types: ["card"],
    line_items: [{ price: priceId, quantity: 1 }],
    allow_promotion_codes: true,
    subscription_data: {
      trial_period_days: user.hasHadTrial ? undefined : 14,
      metadata: { userId: user.id },
    },
    success_url: `${process.env.NEXT_PUBLIC_APP_URL}/dashboard?session_id={CHECKOUT_SESSION_ID}`,
    cancel_url: `${process.env.NEXT_PUBLIC_APP_URL}/pricing`,
    metadata: { userId: user.id },
  })

  return NextResponse.json({ url: session.url })
}
```

---

## Upgrade/Downgrade de Assinatura

```typescript
// lib/billing.ts
export async function changeSubscriptionPlan(
  subscriptionId: string,
  newPriceId: string,
  immediate = false
) {
  const subscription = await stripe.subscriptions.retrieve(subscriptionId)
  const currentItem = subscription.items.data[0]

  if (immediate) {
    // Upgrade: aplicar imediatamente com proration
    return stripe.subscriptions.update(subscriptionId, {
      items: [{ id: currentItem.id, price: newPriceId }],
      proration_behavior: "always_invoice",
      billing_cycle_anchor: "unchanged",
    })
  } else {
    // Downgrade: aplicar no fim do período, sem proration
    return stripe.subscriptions.update(subscriptionId, {
      items: [{ id: currentItem.id, price: newPriceId }],
      proration_behavior: "none",
      billing_cycle_anchor: "unchanged",
    })
  }
}

// Pré-visualizar proration antes de confirmar upgrade
export async function previewProration(subscriptionId: string, newPriceId: string) {
  const subscription = await stripe.subscriptions.retrieve(subscriptionId)
  const prorationDate = Math.floor(Date.now() / 1000)

  const invoice = await stripe.invoices.retrieveUpcoming({
    customer: subscription.customer as string,
    subscription: subscriptionId,
    subscription_items: [{ id: subscription.items.data[0].id, price: newPriceId }],
    subscription_proration_date: prorationDate,
  })

  return {
    amountDue: invoice.amount_due,
    prorationDate,
    lineItems: invoice.lines.data,
  }
}
```

---

## Handler de Webhook Completo (Idempotente)

```typescript
// app/api/webhooks/stripe/route.ts
import { NextResponse } from "next/server"
import { headers } from "next/headers"
import { stripe } from "@/lib/stripe"
import { db } from "@/lib/db"
import Stripe from "stripe"

// Tabela de eventos processados para garantir idempotência
async function hasProcessedEvent(eventId: string): Promise<boolean> {
  const existing = await db.stripeEvent.findUnique({ where: { id: eventId } })
  return !!existing
}

async function markEventProcessed(eventId: string, type: string) {
  await db.stripeEvent.create({ data: { id: eventId, type, processedAt: new Date() } })
}

export async function POST(req: Request) {
  const body = await req.text()
  const signature = headers().get("stripe-signature")!

  let event: Stripe.Event
  try {
    event = stripe.webhooks.constructEvent(body, signature, process.env.STRIPE_WEBHOOK_SECRET!)
  } catch (err) {
    console.error("Falha na verificação de assinatura do webhook:", err)
    return NextResponse.json({ error: "Assinatura inválida" }, { status: 400 })
  }

  // Verificação de idempotência
  if (await hasProcessedEvent(event.id)) {
    return NextResponse.json({ received: true, skipped: true })
  }

  try {
    switch (event.type) {
      case "checkout.session.completed":
        await handleCheckoutCompleted(event.data.object as Stripe.Checkout.Session)
        break

      case "customer.subscription.created":
      case "customer.subscription.updated":
        await handleSubscriptionUpdated(event.data.object as Stripe.Subscription)
        break

      case "customer.subscription.deleted":
        await handleSubscriptionDeleted(event.data.object as Stripe.Subscription)
        break

      case "invoice.payment_succeeded":
        await handleInvoicePaymentSucceeded(event.data.object as Stripe.Invoice)
        break

      case "invoice.payment_failed":
        await handleInvoicePaymentFailed(event.data.object as Stripe.Invoice)
        break

      default:
        console.log(`Tipo de evento não tratado: ${event.type}`)
    }

    await markEventProcessed(event.id, event.type)
    return NextResponse.json({ received: true })
  } catch (err) {
    console.error(`Erro ao processar webhook ${event.type}:`, err)
    // Retornar 500 para que o Stripe tente novamente — não marcar como processado
    return NextResponse.json({ error: "Falha no processamento" }, { status: 500 })
  }
}

async function handleCheckoutCompleted(session: Stripe.Checkout.Session) {
  if (session.mode !== "subscription") return
  
  const userId = session.metadata?.userId
  if (!userId) throw new Error("userId ausente nos metadados da checkout session")

  const subscription = await stripe.subscriptions.retrieve(session.subscription as string)
  
  await db.user.update({
    where: { id: userId },
    data: {
      stripeCustomerId: session.customer as string,
      stripeSubscriptionId: subscription.id,
      stripePriceId: subscription.items.data[0].price.id,
      stripeCurrentPeriodEnd: new Date(subscription.current_period_end * 1000),
      subscriptionStatus: subscription.status,
      hasHadTrial: true,
    },
  })
}

async function handleSubscriptionUpdated(subscription: Stripe.Subscription) {
  const user = await db.user.findUnique({
    where: { stripeSubscriptionId: subscription.id },
  })
  if (!user) {
    // Buscar por ID do cliente como fallback
    const customer = await db.user.findUnique({
      where: { stripeCustomerId: subscription.customer as string },
    })
    if (!customer) throw new Error(`Nenhum usuário encontrado para assinatura ${subscription.id}`)
  }

  await db.user.update({
    where: { stripeSubscriptionId: subscription.id },
    data: {
      stripePriceId: subscription.items.data[0].price.id,
      stripeCurrentPeriodEnd: new Date(subscription.current_period_end * 1000),
      subscriptionStatus: subscription.status,
      cancelAtPeriodEnd: subscription.cancel_at_period_end,
    },
  })
}

async function handleSubscriptionDeleted(subscription: Stripe.Subscription) {
  await db.user.update({
    where: { stripeSubscriptionId: subscription.id },
    data: {
      stripeSubscriptionId: null,
      stripePriceId: null,
      stripeCurrentPeriodEnd: null,
      subscriptionStatus: "canceled",
    },
  })
}

async function handleInvoicePaymentFailed(invoice: Stripe.Invoice) {
  if (!invoice.subscription) return
  const attemptCount = invoice.attempt_count
  
  await db.user.update({
    where: { stripeSubscriptionId: invoice.subscription as string },
    data: { subscriptionStatus: "past_due" },
  })

  if (attemptCount >= 3) {
    // Enviar email de cobrança final
    await sendDunningEmail(invoice.customer_email!, "final")
  } else {
    await sendDunningEmail(invoice.customer_email!, "retry")
  }
}

async function handleInvoicePaymentSucceeded(invoice: Stripe.Invoice) {
  if (!invoice.subscription) return

  await db.user.update({
    where: { stripeSubscriptionId: invoice.subscription as string },
    data: {
      subscriptionStatus: "active",
      stripeCurrentPeriodEnd: new Date(invoice.period_end * 1000),
    },
  })
}
```

---

## Billing Baseado em Uso

```typescript
// Reportar uso para assinaturas medidas
export async function reportUsage(subscriptionItemId: string, quantity: number) {
  await stripe.subscriptionItems.createUsageRecord(subscriptionItemId, {
    quantity,
    timestamp: Math.floor(Date.now() / 1000),
    action: "increment",
  })
}

// Exemplo: reportar chamadas de API em middleware
export async function trackApiCall(userId: string) {
  const user = await db.user.findUnique({ where: { id: userId } })
  if (user?.stripeSubscriptionId) {
    const subscription = await stripe.subscriptions.retrieve(user.stripeSubscriptionId)
    const meteredItem = subscription.items.data.find(
      (item) => item.price.recurring?.usage_type === "metered"
    )
    if (meteredItem) {
      await reportUsage(meteredItem.id, 1)
    }
  }
}
```

---

## Portal do Cliente

```typescript
// app/api/billing/portal/route.ts
import { NextResponse } from "next/server"
import { stripe } from "@/lib/stripe"
import { getAuthUser } from "@/lib/auth"

export async function POST() {
  const user = await getAuthUser()
  if (!user?.stripeCustomerId) {
    return NextResponse.json({ error: "Sem conta de billing" }, { status: 400 })
  }

  const portalSession = await stripe.billingPortal.sessions.create({
    customer: user.stripeCustomerId,
    return_url: `${process.env.NEXT_PUBLIC_APP_URL}/settings/billing`,
  })

  return NextResponse.json({ url: portalSession.url })
}
```

---

## Testes com Stripe CLI

```bash
# Instalar Stripe CLI
brew install stripe/stripe-cli/stripe

# Login
stripe login

# Encaminhar webhooks para dev local
stripe listen --forward-to localhost:3000/api/webhooks/stripe

# Disparar eventos específicos para teste
stripe trigger checkout.session.completed
stripe trigger customer.subscription.updated
stripe trigger invoice.payment_failed

# Testar com cliente específico
stripe trigger customer.subscription.updated \
  --override subscription:customer=cus_xxx

# Ver eventos recentes
stripe events list --limit 10

# Cartões de teste
# Sucesso: 4242 4242 4242 4242
# Requer auth: 4000 0025 0000 3155
# Recusado: 4000 0000 0000 9995
# Saldo insuficiente: 4000 0000 0000 9995
```

---

## Helper de Controle de Acesso por Funcionalidade

```typescript
// lib/subscription.ts
export function isSubscriptionActive(user: { subscriptionStatus: string | null, stripeCurrentPeriodEnd: Date | null }) {
  if (!user.subscriptionStatus) return false
  if (user.subscriptionStatus === "active" || user.subscriptionStatus === "trialing") return true
  // Período de graça: past_due mas ainda não expirado
  if (user.subscriptionStatus === "past_due" && user.stripeCurrentPeriodEnd) {
    return user.stripeCurrentPeriodEnd > new Date()
  }
  return false
}

// Uso em middleware
export async function requireActiveSubscription() {
  const user = await getAuthUser()
  if (!isSubscriptionActive(user)) {
    redirect("/billing?reason=subscription_required")
  }
}
```

---

## Armadilhas Comuns

- **Ordem de entrega de webhooks não garantida** — sempre re-busque da API Stripe, nunca confie nos dados do evento isoladamente para atualizações de DB
- **Processamento duplo de webhooks** — Stripe tenta novamente em 500; sempre use tabela de idempotência
- **Rastreamento de conversão de trial** — armazene `hasHadTrial: true` no DB para prevenir abuso de trial
- **Surpresas de proration** — sempre pré-visualize proration antes do upgrade; mostre o valor ao usuário antes de confirmar
- **Portal do cliente não configurado** — deve habilitar funcionalidades no painel Stripe em Billing → Configurações do portal do cliente
- **Metadados ausentes no checkout** — sempre passe `userId` em metadados; não é possível vincular assinatura ao usuário sem isso
