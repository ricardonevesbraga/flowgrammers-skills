---
name: "email-template-builder"
description: "Construtor de templates de e-mail transacional. Cria sistemas completos de e-mail com React Email, integração com provedores, servidor de preview, suporte a i18n, modo escuro, otimização anti-spam e rastreamento de analytics. Produz código pronto para produção para Resend, Postmark, SendGrid ou AWS SES."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Email Template Builder

**Tier:** POWERFUL  
**Categoria:** Engineering Team  
**Domínio:** E-mail Transacional / Infraestrutura de Comunicações

---

## Visão Geral

Construa sistemas completos de e-mail transacional: templates React Email, integração com provedores, servidor de preview, suporte a i18n, modo escuro, otimização de spam e rastreamento de analytics. Produz código pronto para produção para Resend, Postmark, SendGrid ou AWS SES.

---

## Capacidades Principais

- Templates React Email (boas-vindas, verificação, redefinição de senha, fatura, notificação, digest)
- Templates MJML para máxima compatibilidade com clientes de e-mail
- Suporte a múltiplos provedores com interface de envio unificada
- Servidor de preview local com hot reload
- i18n/localização com chaves de tradução tipadas
- Suporte a modo escuro usando media queries
- Lista de verificação de otimização de pontuação de spam
- Rastreamento de abertura/clique com parâmetros UTM

---

## Quando Usar

- Configurando e-mail transacional para um novo produto
- Migrando de um sistema de e-mail legado
- Adicionando novos tipos de e-mail (fatura, digest, notificação)
- Depurando problemas de entregabilidade de e-mail
- Implementando i18n para templates de e-mail

---

## Estrutura do Projeto

```
emails/
├── components/
│   ├── layout/
│   │   ├── email-layout.tsx       # Layout base com header/footer da marca
│   │   └── email-button.tsx       # Componente de botão CTA
│   ├── partials/
│   │   ├── header.tsx
│   │   └── footer.tsx
├── templates/
│   ├── welcome.tsx
│   ├── verify-email.tsx
│   ├── password-reset.tsx
│   ├── invoice.tsx
│   ├── notification.tsx
│   └── weekly-digest.tsx
├── lib/
│   ├── send.ts                    # Função de envio unificada
│   ├── providers/
│   │   ├── resend.ts
│   │   ├── postmark.ts
│   │   └── ses.ts
│   └── tracking.ts                # UTM + analytics
├── i18n/
│   ├── en.ts
│   └── de.ts
└── preview/                       # Servidor de preview para desenvolvimento
    └── server.ts
```

---

## Layout Base de E-mail

```tsx
// emails/components/layout/email-layout.tsx
import {
  Body, Container, Head, Html, Img, Preview, Section, Text, Hr, Font
} from "@react-email/components"

interface EmailLayoutProps {
  preview: string
  children: React.ReactNode
}

export function EmailLayout({ preview, children }: EmailLayoutProps) {
  return (
    <Html lang="en">
      <Head>
        <Font
          fontFamily="Inter"
          fallbackFontFamily="Arial"
          webFont={{ url: "https://fonts.gstatic.com/s/inter/v13/UcCO3FwrK3iLTeHuS_nVMrMxCp50SjIw2boKoduKmMEVuLyfAZ9hiJ-Ek-_EeA.woff2", format: "woff2" }}
          fontWeight={400}
          fontStyle="normal"
        />
        {/* Estilos para modo escuro */}
        <style>{`
          @media (prefers-color-scheme: dark) {
            .email-body { background-color: #0f0f0f !important; }
            .email-container { background-color: #1a1a1a !important; }
            .email-text { color: #e5e5e5 !important; }
            .email-heading { color: #ffffff !important; }
            .email-divider { border-color: #333333 !important; }
          }
        `}</style>
      </Head>
      <Preview>{preview}</Preview>
      <Body className="email-body" style={styles.body}>
        <Container className="email-container" style={styles.container}>
          {/* Header */}
          <Section style={styles.header}>
            <Img src="https://yourapp.com/logo.png" width={120} height={40} alt="MyApp" />
          </Section>
          
          {/* Conteúdo */}
          <Section style={styles.content}>
            {children}
          </Section>
          
          {/* Footer */}
          <Hr style={styles.divider} />
          <Section style={styles.footer}>
            <Text style={styles.footerText}>
              MyApp Inc. · 123 Main St · San Francisco, CA 94105
            </Text>
            <Text style={styles.footerText}>
              <a href="{{unsubscribe_url}}" style={styles.link}>Unsubscribe</a>
              {" · "}
              <a href="https://yourapp.com/privacy" style={styles.link}>Privacy Policy</a>
            </Text>
          </Section>
        </Container>
      </Body>
    </Html>
  )
}

const styles = {
  body: { backgroundColor: "#f5f5f5", fontFamily: "Inter, Arial, sans-serif" },
  container: { maxWidth: "600px", margin: "0 auto", backgroundColor: "#ffffff", borderRadius: "8px", overflow: "hidden" },
  header: { padding: "24px 32px", borderBottom: "1px solid #e5e5e5" },
  content: { padding: "32px" },
  divider: { borderColor: "#e5e5e5", margin: "0 32px" },
  footer: { padding: "24px 32px" },
  footerText: { fontSize: "12px", color: "#6b7280", textAlign: "center" as const, margin: "4px 0" },
  link: { color: "#6b7280", textDecoration: "underline" },
}
```

---

## E-mail de Boas-Vindas

```tsx
// emails/templates/welcome.tsx
import { Button, Heading, Text } from "@react-email/components"
import { EmailLayout } from "../components/layout/email-layout"

interface WelcomeEmailProps {
  name: "string"
  confirmUrl: string
  trialDays?: number
}

export function WelcomeEmail({ name, confirmUrl, trialDays = 14 }: WelcomeEmailProps) {
  return (
    <EmailLayout preview={`Welcome to MyApp, ${name}! Confirm your email to get started.`}>
      <Heading style={styles.h1}>Welcome to MyApp, {name}!</Heading>
      <Text style={styles.text}>
        We're excited to have you on board. You've got {trialDays} days to explore everything MyApp has to offer — no credit card required.
      </Text>
      <Text style={styles.text}>
        First, confirm your email address to activate your account:
      </Text>
      <Button href={confirmUrl} style={styles.button}>
        Confirm Email Address
      </Button>
      <Text style={styles.hint}>
        Button not working? Copy and paste this link into your browser:
        <br />
        <a href={confirmUrl} style={styles.link}>{confirmUrl}</a>
      </Text>
      <Text style={styles.text}>
        Once confirmed, you can:
      </Text>
      <ul style={styles.list}>
        <li>Connect your first project in 2 minutes</li>
        <li>Invite your team (free for up to 3 members)</li>
        <li>Set up Slack notifications</li>
      </ul>
    </EmailLayout>
  )
}

export default WelcomeEmail

const styles = {
  h1: { fontSize: "28px", fontWeight: "700", color: "#111827", margin: "0 0 16px" },
  text: { fontSize: "16px", lineHeight: "1.6", color: "#374151", margin: "0 0 16px" },
  button: { backgroundColor: "#4f46e5", color: "#ffffff", borderRadius: "6px", fontSize: "16px", fontWeight: "600", padding: "12px 24px", textDecoration: "none", display: "inline-block", margin: "8px 0 24px" },
  hint: { fontSize: "13px", color: "#6b7280" },
  link: { color: "#4f46e5" },
  list: { fontSize: "16px", lineHeight: "1.8", color: "#374151", paddingLeft: "20px" },
}
```

---

## E-mail de Fatura

```tsx
// emails/templates/invoice.tsx
import { Row, Column, Section, Heading, Text, Hr, Button } from "@react-email/components"
import { EmailLayout } from "../components/layout/email-layout"

interface InvoiceItem { description: string; amount: number }

interface InvoiceEmailProps {
  name: "string"
  invoiceNumber: string
  invoiceDate: string
  dueDate: string
  items: InvoiceItem[]
  total: number
  currency: string
  downloadUrl: string
}

export function InvoiceEmail({ name, invoiceNumber, invoiceDate, dueDate, items, total, currency = "USD", downloadUrl }: InvoiceEmailProps) {
  const formatter = new Intl.NumberFormat("en-US", { style: "currency", currency })

  return (
    <EmailLayout preview={`Invoice ${invoiceNumber} - ${formatter.format(total / 100)}`}>
      <Heading style={styles.h1}>Invoice #{invoiceNumber}</Heading>
      <Text style={styles.text}>Hi {name},</Text>
      <Text style={styles.text}>Here's your invoice from MyApp. Thank you for your continued support.</Text>

      {/* Metadados da fatura */}
      <Section style={styles.metaBox}>
        <Row>
          <Column><Text style={styles.metaLabel}>Invoice Date</Text><Text style={styles.metaValue}>{invoiceDate}</Text></Column>
          <Column><Text style={styles.metaLabel}>Due Date</Text><Text style={styles.metaValue}>{dueDate}</Text></Column>
          <Column><Text style={styles.metaLabel}>Amount Due</Text><Text style={styles.metaValueLarge}>{formatter.format(total / 100)}</Text></Column>
        </Row>
      </Section>

      {/* Itens de linha */}
      <Section style={styles.table}>
        <Row style={styles.tableHeader}>
          <Column><Text style={styles.tableHeaderText}>Description</Text></Column>
          <Column><Text style={{ ...styles.tableHeaderText, textAlign: "right" }}>Amount</Text></Column>
        </Row>
        {items.map((item, i) => (
          <Row key={i} style={i % 2 === 0 ? styles.tableRowEven : styles.tableRowOdd}>
            <Column><Text style={styles.tableCell}>{item.description}</Text></Column>
            <Column><Text style={{ ...styles.tableCell, textAlign: "right" }}>{formatter.format(item.amount / 100)}</Text></Column>
          </Row>
        ))}
        <Hr style={styles.divider} />
        <Row>
          <Column><Text style={styles.totalLabel}>Total</Text></Column>
          <Column><Text style={styles.totalValue}>{formatter.format(total / 100)}</Text></Column>
        </Row>
      </Section>

      <Button href={downloadUrl} style={styles.button}>Download PDF Invoice</Button>
    </EmailLayout>
  )
}

export default InvoiceEmail

const styles = {
  h1: { fontSize: "24px", fontWeight: "700", color: "#111827", margin: "0 0 16px" },
  text: { fontSize: "15px", lineHeight: "1.6", color: "#374151", margin: "0 0 12px" },
  metaBox: { backgroundColor: "#f9fafb", borderRadius: "8px", padding: "16px", margin: "16px 0" },
  metaLabel: { fontSize: "12px", color: "#6b7280", fontWeight: "600", textTransform: "uppercase" as const, margin: "0 0 4px" },
  metaValue: { fontSize: "14px", color: "#111827", margin: 0 },
  metaValueLarge: { fontSize: "20px", fontWeight: "700", color: "#4f46e5", margin: 0 },
  table: { width: "100%", margin: "16px 0" },
  tableHeader: { backgroundColor: "#f3f4f6", borderRadius: "4px" },
  tableHeaderText: { fontSize: "12px", fontWeight: "600", color: "#374151", padding: "8px 12px", textTransform: "uppercase" as const },
  tableRowEven: { backgroundColor: "#ffffff" },
  tableRowOdd: { backgroundColor: "#f9fafb" },
  tableCell: { fontSize: "14px", color: "#374151", padding: "10px 12px" },
  divider: { borderColor: "#e5e5e5", margin: "8px 0" },
  totalLabel: { fontSize: "16px", fontWeight: "700", color: "#111827", padding: "8px 12px" },
  totalValue: { fontSize: "16px", fontWeight: "700", color: "#111827", textAlign: "right" as const, padding: "8px 12px" },
  button: { backgroundColor: "#4f46e5", color: "#fff", borderRadius: "6px", padding: "12px 24px", fontSize: "15px", fontWeight: "600", textDecoration: "none" },
}
```

---

## Função de Envio Unificada

```typescript
// emails/lib/send.ts
import { Resend } from "resend"
import { render } from "@react-email/render"
import { WelcomeEmail } from "../templates/welcome"
import { InvoiceEmail } from "../templates/invoice"
import { addTrackingParams } from "./tracking"

const resend = new Resend(process.env.RESEND_API_KEY)

type EmailPayload =
  | { type: "welcome"; props: Parameters<typeof WelcomeEmail>[0] }
  | { type: "invoice"; props: Parameters<typeof InvoiceEmail>[0] }

export async function sendEmail(to: string, payload: EmailPayload) {
  const templates = {
    welcome: { component: WelcomeEmail, subject: "Welcome to MyApp — confirm your email" },
    invoice: { component: InvoiceEmail, subject: `Invoice from MyApp` },
  }

  const template = templates[payload.type]
  const html = render(template.component(payload.props as any))
  const trackedHtml = addTrackingParams(html, { campaign: payload.type })

  const result = await resend.emails.send({
    from: "MyApp <hello@yourapp.com>",
    to,
    subject: template.subject,
    html: trackedHtml,
    tags: [{ name: "email-type", value: payload.type }],
  })

  return result
}
```

---

## Configuração do Servidor de Preview

```typescript
// package.json scripts
{
  "scripts": {
    "email:dev": "email dev --dir emails/templates --port 3001",
    "email:build": "email export --dir emails/templates --outDir emails/out"
  }
}

// Execute: npm run email:dev
// Abre: http://localhost:3001
// Mostra todos os templates com preview ao vivo e hot reload
```

---

## Suporte a i18n

```typescript
// emails/i18n/en.ts
export const en = {
  welcome: {
    preview: (name: "string-welcome-to-myapp-name"
    heading: (name: "string-welcome-to-myapp-name"
    body: (days: number) => `You've got ${days} days to explore everything.`,
    cta: "Confirm Email Address",
  },
}

// emails/i18n/de.ts
export const de = {
  welcome: {
    preview: (name: "string-willkommen-bei-myapp-name"
    heading: (name: "string-willkommen-bei-myapp-name"
    body: (days: number) => `Du hast ${days} Tage Zeit, alles zu erkunden.`,
    cta: "E-Mail-Adresse bestätigen",
  },
}

// Uso no template
import { en, de } from "../i18n"
const t = locale === "de" ? de : en
```

---

## Lista de Verificação de Otimização de Pontuação de Spam

- [ ] Domínio do remetente tem registros SPF, DKIM e DMARC configurados
- [ ] Endereço De usa seu próprio domínio (não gmail.com/hotmail.com)
- [ ] Linha de assunto com menos de 50 caracteres, sem CAIXA ALTA, sem "GRÁTIS!!!"
- [ ] Proporção texto-imagem: pelo menos 60% texto
- [ ] Versão em texto simples incluída junto com HTML
- [ ] Link de cancelamento de inscrição em todo e-mail de marketing (CAN-SPAM, LGPD)
- [ ] Sem encurtadores de URL — use links completos com marca
- [ ] Sem palavras sinalizadoras: "garantia", "sem risco", "oferta por tempo limitado" no assunto
- [ ] Um único CTA por e-mail — não 5 botões diferentes
- [ ] Texto alternativo de imagem em cada imagem
- [ ] HTML valida — sem tags quebradas
- [ ] Testar com Mail-Tester.com antes do primeiro envio (alvo: 9+/10)

---

## Rastreamento de Analytics

```typescript
// emails/lib/tracking.ts
interface TrackingParams {
  campaign: string
  medium?: string
  source?: string
}

export function addTrackingParams(html: string, params: TrackingParams): string {
  const utmString = new URLSearchParams({
    utm_source: params.source ?? "email",
    utm_medium: params.medium ?? "transactional",
    utm_campaign: params.campaign,
  }).toString()

  // Adicionar parâmetros UTM a todos os links no e-mail
  return html.replace(/href="(https?:\/\/[^"]+)"/g, (match, url) => {
    const separator = url.includes("?") ? "&" : "?"
    return `href="${url}${separator}${utmString}"`
  })
}
```

---

## Armadilhas Comuns

- **Estilos inline são obrigatórios** — a maioria dos clientes de e-mail remove os estilos `<head>`; o React Email lida com isso
- **Largura máxima de 600px** — qualquer coisa mais larga quebra no Gmail mobile
- **Sem flexbox/grid** — use `<Row>` e `<Column>` do react-email, não CSS grid
- **Media queries para modo escuro** — deve usar `!important` para substituir estilos inline
- **Texto simples ausente** — todos os principais provedores têm um campo de texto simples; sempre preencha
- **E-mail transacional vs. marketing** — use domínios/IPs de envio separados para proteger a entregabilidade
