---
name: "senior-frontend"
description: "Skill de desenvolvimento frontend para aplicações React, Next.js, TypeScript e Tailwind CSS. Use quando construir componentes React, otimizar performance no Next.js, analisar tamanhos de bundle, criar scaffolding de projetos frontend, implementar acessibilidade ou revisar qualidade de código frontend."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Desenvolvedor Frontend Sênior

Padrões de desenvolvimento frontend, otimização de performance e ferramentas de automação para aplicações React/Next.js.

## Sumário

- [Scaffolding de Projeto](#project-scaffolding)
- [Geração de Componentes](#component-generation)
- [Análise de Bundle](#bundle-analysis)
- [Padrões React](#react-patterns)
- [Otimização Next.js](#nextjs-optimization)
- [Acessibilidade e Testes](#accessibility-e-testing)

---

## Scaffolding de Projeto

Gere um novo projeto Next.js ou React com TypeScript, Tailwind CSS e configurações de melhores práticas.

### Workflow: Criar Novo Projeto Frontend

1. Execute o scaffolder com o nome e template do projeto:
   ```bash
   python scripts/frontend_scaffolder.py my-app --template nextjs
   ```

2. Adicione funcionalidades opcionais (auth, api, forms, testing, storybook):
   ```bash
   python scripts/frontend_scaffolder.py dashboard --template nextjs --features auth,api
   ```

3. Navegue até o projeto e instale as dependências:
   ```bash
   cd my-app && npm install
   ```

4. Inicie o servidor de desenvolvimento:
   ```bash
   npm run dev
   ```

### Opções do Scaffolder

| Opção | Descrição |
|--------|-------------|
| `--template nextjs` | Next.js 14+ com App Router e Server Components |
| `--template react` | React + Vite com TypeScript |
| `--features auth` | Adicionar autenticação NextAuth.js |
| `--features api` | Adicionar React Query + cliente de API |
| `--features forms` | Adicionar React Hook Form + validação Zod |
| `--features testing` | Adicionar Vitest + Testing Library |
| `--dry-run` | Pré-visualizar arquivos sem criá-los |

### Estrutura Gerada (Next.js)

```
my-app/
├── app/
│   ├── layout.tsx        # Layout raiz com fontes
│   ├── page.tsx          # Página inicial
│   ├── globals.css       # Tailwind + variáveis CSS
│   └── api/health/route.ts
├── components/
│   ├── ui/               # Button, Input, Card
│   └── layout/           # Header, Footer, Sidebar
├── hooks/                # useDebounce, useLocalStorage
├── lib/                  # utils (cn), constants
├── types/                # interfaces TypeScript
├── tailwind.config.ts
├── next.config.js
└── package.json
```

---

## Geração de Componentes

Gere componentes React com TypeScript, testes e stories Storybook.

### Workflow: Criar um Novo Componente

1. Gere um componente client:
   ```bash
   python scripts/component_generator.py Button --dir src/components/ui
   ```

2. Gere um componente server:
   ```bash
   python scripts/component_generator.py ProductCard --type server
   ```

3. Gere com arquivos de teste e story:
   ```bash
   python scripts/component_generator.py UserProfile --with-test --with-story
   ```

4. Gere um hook customizado:
   ```bash
   python scripts/component_generator.py FormValidation --type hook
   ```

### Opções do Generator

| Opção | Descrição |
|--------|-------------|
| `--type client` | Componente client com 'use client' (padrão) |
| `--type server` | Componente server assíncrono |
| `--type hook` | Hook React customizado |
| `--with-test` | Incluir arquivo de teste |
| `--with-story` | Incluir story do Storybook |
| `--flat` | Criar no diretório de saída sem subdiretório |
| `--dry-run` | Pré-visualizar sem criar arquivos |

### Exemplo de Componente Gerado

```tsx
'use client';

import { useState } from 'react';
import { cn } from '@/lib/utils';

interface ButtonProps {
  className?: string;
  children?: React.ReactNode;
}

export function Button({ className, children }: ButtonProps) {
  return (
    <div className={cn('', className)}>
      {children}
    </div>
  );
}
```

---

## Análise de Bundle

Analise package.json e a estrutura do projeto para encontrar oportunidades de otimização de bundle.

### Workflow: Otimizar Tamanho do Bundle

1. Execute o analyzer no seu projeto:
   ```bash
   python scripts/bundle_analyzer.py /path/to/project
   ```

2. Revise o score de saúde e os problemas:
   ```
   Bundle Health Score: 75/100 (C)

   DEPENDÊNCIAS PESADAS:
     moment (290KB)
       Alternativa: date-fns (12KB) ou dayjs (2KB)

     lodash (71KB)
       Alternativa: lodash-es com tree-shaking
   ```

3. Aplique as correções recomendadas substituindo dependências pesadas.

4. Re-execute com modo verbose para verificar padrões de importação:
   ```bash
   python scripts/bundle_analyzer.py . --verbose
   ```

### Interpretação do Score do Bundle

| Score | Nota | Ação |
|-------|-------|--------|
| 90-100 | A | Bundle bem otimizado |
| 80-89 | B | Pequenas otimizações disponíveis |
| 70-79 | C | Substituir dependências pesadas |
| 60-69 | D | Múltiplos problemas precisam de atenção |
| 0-59 | F | Problemas críticos de tamanho de bundle |

### Dependências Pesadas Detectadas

O analyzer identifica estes pacotes comuns pesados:

| Pacote | Tamanho | Alternativa |
|---------|------|-------------|
| moment | 290KB | date-fns (12KB) ou dayjs (2KB) |
| lodash | 71KB | lodash-es com tree-shaking |
| axios | 14KB | fetch nativo ou ky (3KB) |
| jquery | 87KB | APIs DOM nativas |
| @mui/material | Grande | shadcn/ui ou Radix UI |

---

## Padrões React

Referência: `references/react_patterns.md`

### Compound Components

Compartilhar estado entre componentes relacionados:

```tsx
const Tabs = ({ children }) => {
  const [active, setActive] = useState(0);
  return (
    <TabsContext.Provider value={{ active, setActive }}>
      {children}
    </TabsContext.Provider>
  );
};

Tabs.List = TabList;
Tabs.Panel = TabPanel;

// Uso
<Tabs>
  <Tabs.List>
    <Tabs.Tab>Um</Tabs.Tab>
    <Tabs.Tab>Dois</Tabs.Tab>
  </Tabs.List>
  <Tabs.Panel>Conteúdo 1</Tabs.Panel>
  <Tabs.Panel>Conteúdo 2</Tabs.Panel>
</Tabs>
```

### Custom Hooks

Extrair lógica reutilizável:

```tsx
function useDebounce<T>(value: T, delay = 500): T {
  const [debouncedValue, setDebouncedValue] = useState(value);

  useEffect(() => {
    const timer = setTimeout(() => setDebouncedValue(value), delay);
    return () => clearTimeout(timer);
  }, [value, delay]);

  return debouncedValue;
}

// Uso
const debouncedSearch = useDebounce(searchTerm, 300);
```

### Render Props

Compartilhar lógica de renderização:

```tsx
function DataFetcher({ url, render }) {
  const [data, setData] = useState(null);
  const [loading, setLoading] = useState(true);

  useEffect(() => {
    fetch(url).then(r => r.json()).then(setData).finally(() => setLoading(false));
  }, [url]);

  return render({ data, loading });
}

// Uso
<DataFetcher
  url="/api/users"
  render={({ data, loading }) =>
    loading ? <Spinner /> : <UserList users={data} />
  }
/>
```

---

## Otimização Next.js

Referência: `references/nextjs_optimization_guide.md`

### Server vs Client Components

Use Server Components por padrão. Adicione 'use client' somente quando precisar de:
- Handlers de eventos (onClick, onChange)
- Estado (useState, useReducer)
- Effects (useEffect)
- APIs do browser

```tsx
// Server Component (padrão) - sem 'use client'
async function ProductPage({ params }) {
  const product = await getProduct(params.id);  // fetch server-side

  return (
    <div>
      <h1>{product.name}</h1>
      <AddToCartButton productId={product.id} />  {/* componente client */}
    </div>
  );
}

// Client Component
'use client';
function AddToCartButton({ productId }) {
  const [adding, setAdding] = useState(false);
  return <button onClick={() => addToCart(productId)}>Adicionar</button>;
}
```

### Otimização de Imagens

```tsx
import Image from 'next/image';

// Acima da dobra - carregamento imediato
<Image
  src="/hero.jpg"
  alt="Hero"
  width={1200}
  height={600}
  priority
/>

// Imagem responsiva com fill
<div className="relative aspect-video">
  <Image
    src="/product.jpg"
    alt="Produto"
    fill
    sizes="(max-width: 768px) 100vw, 50vw"
    className="object-cover"
  />
</div>
```

### Padrões de Busca de Dados

```tsx
// Busca em paralelo
async function Dashboard() {
  const [user, stats] = await Promise.all([
    getUser(),
    getStats()
  ]);
  return <div>...</div>;
}

// Streaming com Suspense
async function ProductPage({ params }) {
  return (
    <div>
      <ProductDetails id={params.id} />
      <Suspense fallback={<ReviewsSkeleton />}>
        <Reviews productId={params.id} />
      </Suspense>
    </div>
  );
}
```

---

## Acessibilidade e Testes

Referência: `references/frontend_best_practices.md`

### Checklist de Acessibilidade

1. **HTML Semântico**: Use elementos adequados (`<button>`, `<nav>`, `<main>`)
2. **Navegação por Teclado**: Todos os elementos interativos devem ser focusáveis
3. **Labels ARIA**: Forneça labels para ícones e widgets complexos
4. **Contraste de Cores**: Mínimo 4.5:1 para texto normal
5. **Indicadores de Foco**: Estados de foco visíveis

```tsx
// Botão acessível
<button
  type="button"
  aria-label="Fechar diálogo"
  onClick={onClose}
  className="focus-visible:ring-2 focus-visible:ring-blue-500"
>
  <XIcon aria-hidden="true" />
</button>

// Skip link para usuários de teclado
<a href="#main-content" className="sr-only focus:not-sr-only">
  Pular para o conteúdo principal
</a>
```

### Estratégia de Testes

```tsx
// Teste de componente com React Testing Library
import { render, screen } from '@testing-library/react';
import userEvent from '@testing-library/user-event';

test('botão dispara ação ao clicar', async () => {
  const onClick = vi.fn();
  render(<Button onClick={onClick}>Clique aqui</Button>);

  await userEvent.click(screen.getByRole('button'));
  expect(onClick).toHaveBeenCalledTimes(1);
});

// Testar acessibilidade
test('diálogo é acessível', async () => {
  render(<Dialog open={true} title="Confirmar" />);

  expect(screen.getByRole('dialog')).toBeInTheDocument();
  expect(screen.getByRole('dialog')).toHaveAttribute('aria-labelledby');
});
```

---

## Referência Rápida

### Configuração Comum do Next.js

```js
// next.config.js
const nextConfig = {
  images: {
    remotePatterns: [{ hostname: "cdnexamplecom" }],
    formats: ['image/avif', 'image/webp'],
  },
  experimental: {
    optimizePackageImports: ['lucide-react', '@heroicons/react'],
  },
};
```

### Utilitários Tailwind CSS

```tsx
// Classes condicionais com cn()
import { cn } from '@/lib/utils';

<button className={cn(
  'px-4 py-2 rounded',
  variant === 'primary' && 'bg-blue-500 text-white',
  disabled && 'opacity-50 cursor-not-allowed'
)} />
```

### Padrões TypeScript

```tsx
// Props com children
interface CardProps {
  className?: string;
  children: React.ReactNode;
}

// Componente genérico
interface ListProps<T> {
  items: T[];
  renderItem: (item: T) => React.ReactNode;
}

function List<T>({ items, renderItem }: ListProps<T>) {
  return <ul>{items.map(renderItem)}</ul>;
}
```

---

## Recursos

- Padrões React: `references/react_patterns.md`
- Otimização Next.js: `references/nextjs_optimization_guide.md`
- Melhores Práticas: `references/frontend_best_practices.md`
