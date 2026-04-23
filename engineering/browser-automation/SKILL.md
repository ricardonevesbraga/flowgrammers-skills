---
name: "browser-automation"
description: "Use quando o usuário pedir para automatizar tarefas no navegador, fazer scraping de sites, preencher formulários, capturar screenshots, extrair dados estruturados de páginas web ou construir workflows de automação web. NÃO para testes — use playwright-pro para isso."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Browser Automation - PODEROSO

## Visão Geral

A skill de Browser Automation fornece ferramentas abrangentes e conhecimento para construir workflows de automação web de nível produção usando Playwright. Esta skill cobre extração de dados, preenchimento de formulários, captura de screenshots, gerenciamento de sessão e padrões anti-detecção para automação de navegador confiável em escala.

**Quando usar esta skill:**
- Fazer scraping de dados estruturados de sites (tabelas, listagens, resultados de busca)
- Automatizar workflows de navegador com múltiplos passos (login, preencher formulários, baixar arquivos)
- Capturar screenshots ou PDFs de páginas web
- Extrair dados de SPAs e sites com muito JavaScript
- Construir pipelines de dados baseados em navegador repetíveis

**Quando NÃO usar esta skill:**
- Escrever testes de navegador ou suítes de testes E2E — use **playwright-pro** em vez disso
- Testar endpoints de API — use **api-test-suite-builder** em vez disso
- Testes de carga ou benchmarking de performance — use **performance-profiler** em vez disso

**Por que Playwright em vez de Selenium ou Puppeteer:**
- **Auto-wait integrado** — sem `sleep()` explícito ou `waitForElement()` necessário para a maioria das ações
- **Multi-navegador de uma API** — Chromium, Firefox, WebKit sem alterações de configuração
- **Interceptação de rede** — bloqueie anúncios, simule respostas, capture chamadas de API nativamente
- **Contextos de navegador** — sessões isoladas sem criar novas instâncias do navegador
- **Codegen** — `playwright codegen` registra suas ações e gera scripts
- **Async-first** — Python async/await para scraping de alta throughput

## Competências Principais

### 1. Padrões de Web Scraping

**Prioridade de seletor (do mais ao menos confiável):**
1. `data-testid`, `data-id`, ou atributos de dados personalizados — estáveis entre redesigns
2. Seletores `#id` — únicos, mas podem mudar entre deploys
3. Seletores semânticos: `article`, `nav`, `main`, `section` — resilientes a mudanças de CSS
4. Baseados em classe: `.product-card`, `.price` — frágeis se as classes são geradas (ex.: CSS modules)
5. Posicionais: `nth-child()`, `nth-of-type()` — último recurso, quebra com mudanças de layout

Use XPath apenas quando o CSS não puder expressar o relacionamento (ex.: travessia de ancestral, seleção baseada em texto).

**Estratégias de paginação:** botão próximo, baseada em URL (`?page=N`), scroll infinito, botão carregar mais. Veja [data_extraction_recipes.md](references/data_extraction_recipes.md) para handlers completos de paginação e padrões de scroll.

### 2. Preenchimento de Formulários e Workflows com Múltiplos Passos

Divida formulários com múltiplos passos em funções discretas por passo. Cada função preenche campos, clica em "Próximo"/"Continuar" e aguarda o próximo passo carregar (mudança de URL ou elemento DOM).

Padrões principais: fluxos de login, formulários de múltiplas páginas, upload de arquivos (incluindo zonas de drag-and-drop), manipulação de dropdowns nativos e personalizados. Veja [playwright_browser_api.md](references/playwright_browser_api.md) para referência completa da API sobre `fill()`, `select_option()`, `set_input_files()` e `expect_file_chooser()`.

### 3. Captura de Screenshot e PDF

- **Página inteira:** `await page.screenshot(path="full.png", full_page=True)`
- **Elemento:** `await page.locator("div.chart").screenshot(path="chart.png")`
- **PDF (somente Chromium):** `await page.pdf(path="out.pdf", format="A4", print_background=True)`
- **Regressão visual:** Tire screenshots em estados conhecidos, armazene baselines em controle de versão com nomenclatura: `{page}_{viewport}_{state}.png`

Veja [playwright_browser_api.md](references/playwright_browser_api.md) para opções completas de screenshot/PDF.

### 4. Extração de Dados Estruturados

Padrões principais de extração:
- **Tabelas para JSON** — Extraia cabeçalhos `<thead>` e linhas `<tbody>` em dicionários
- **Listagens para arrays** — Mapeie elementos de cartão repetitivos usando um mapa de seletor de campo (suporta `::attr()` para atributos)
- **Dados aninhados/encadeados** — Extração recursiva para comentários com respostas, árvores de categorias

Veja [data_extraction_recipes.md](references/data_extraction_recipes.md) para funções completas de extração, análise de preços, utilitários de limpeza de dados e helpers de formato de saída (JSON, CSV, JSONL).

### 5. Gerenciamento de Cookies e Sessão

- **Salvar/restaurar cookies:** `context.cookies()` e `context.add_cookies()`
- **Estado de armazenamento completo** (cookies + localStorage): `context.storage_state(path="state.json")` para salvar, `browser.new_context(storage_state="state.json")` para restaurar

**Melhor prática:** Salve o estado após o login, reutilize entre sessões de scraping. Verifique a validade da sessão antes de iniciar um trabalho longo — faça uma requisição leve para uma página protegida e verifique se você não é redirecionado para o login. Veja [playwright_browser_api.md](references/playwright_browser_api.md) para detalhes da API de cookie e estado de armazenamento.

### 6. Padrões Anti-Detecção

Sites modernos detectam automação por múltiplos vetores. Aplique estes em ordem de prioridade:

1. **Remoção da flag WebDriver** — Remova `navigator.webdriver = true` via script de inicialização (crítico)
2. **User agent personalizado** — Alterne entre UAs reais de navegador; nunca use o UA headless padrão
3. **Viewport realista** — Defina 1920x1080 ou dimensões similares do mundo real (padrão 800x600 é um sinal suspeito)
4. **Limitação de requisições** — Adicione delays `random.uniform()` entre ações
5. **Suporte a proxy** — Configuração de proxy por navegador ou por contexto

Veja [anti_detection_patterns.md](references/anti_detection_patterns.md) para a pilha de stealth completa: hardening de propriedades do navigator, evasão de fingerprint WebGL/canvas, simulação comportamental (movimento do mouse, velocidade de digitação, padrões de scroll), estratégias de rotação de proxy e URLs de auto-teste de detecção.

### 7. Manipulação de Conteúdo Dinâmico

- **Renderização de SPA:** Aguarde seletores de conteúdo (`wait_for_selector`), não o evento de carregamento da página
- **Aguardar AJAX/Fetch:** Use `page.expect_response("**/api/data*")` para interceptar e aguardar chamadas de API específicas
- **Shadow DOM:** O Playwright atravessa Shadow DOM aberto com o operador `>>`: `page.locator("custom-element >> .inner-class")`
- **Imagens com carregamento lazy:** Role elementos para dentro da visualização com `scroll_into_view_if_needed()` para acionar o carregamento

Veja [playwright_browser_api.md](references/playwright_browser_api.md) para estratégias de espera, interceptação de rede e detalhes de Shadow DOM.

### 8. Tratamento de Erros e Lógica de Retry

- **Retry com backoff:** Envolva interações de página em lógica de retry com backoff exponencial (ex.: 1s, 2s, 4s)
- **Seletores de fallback:** Em `TimeoutError`, tente seletores alternativos antes de falhar
- **Screenshots em estado de erro:** Capture `page.screenshot(path="error-state.png")` em falhas inesperadas para depuração
- **Detecção de limite de taxa:** Verifique respostas HTTP 429 e respeite cabeçalhos `Retry-After`

Veja [anti_detection_patterns.md](references/anti_detection_patterns.md) para a implementação completa de backoff exponencial e classe de limitador de taxa.

## Workflows

### Workflow 1: Extração de Dados de Página Única

**Cenário:** Extraia dados de produto de uma página única com conteúdo renderizado por JavaScript.

**Passos:**
1. Inicie o navegador em modo com interface durante desenvolvimento (`headless=False`), mude para headless em produção
2. Navegue para a URL e aguarde o seletor de conteúdo
3. Extraia dados usando `query_selector_all` com mapeamento de campo
4. Valide os dados extraídos (verifique nulos, tipos esperados)
5. Produza como JSON

```python
async def extract_single_page(url, selectors):
    async with async_playwright() as p:
        browser = await p.chromium.launch(headless=True)
        context = await browser.new_context(
            viewport={"width": 1920, "height": 1080},
            user_agent="Mozilla/5.0 ..."
        )
        page = await context.new_page()
        await page.goto(url, wait_until="networkidle")
        data = await extract_listings(page, selectors["container"], selectors["fields"])
        await browser.close()
    return data
```

### Workflow 2: Scraping de Múltiplas Páginas com Paginação

**Cenário:** Faça scraping de resultados de busca em 50+ páginas.

**Passos:**
1. Inicie o navegador com configurações anti-detecção
2. Navegue para a primeira página
3. Extraia dados da página atual
4. Verifique se o botão "Próximo" existe e está habilitado
5. Clique em próximo, aguarde o novo conteúdo carregar (não apenas a navegação)
6. Repita até não haver próxima página ou atingir o máximo de páginas
7. Remova duplicatas dos resultados por chave única
8. Escreva a saída incrementalmente (não mantenha tudo na memória)

```python
async def scrape_paginated(base_url, selectors, max_pages=100):
    all_data = []
    async with async_playwright() as p:
        browser = await p.chromium.launch(headless=True)
        page = await (await browser.new_context()).new_page()
        await page.goto(base_url)

        for page_num in range(max_pages):
            items = await extract_listings(page, selectors["container"], selectors["fields"])
            all_data.extend(items)

            next_btn = page.locator(selectors["next_button"])
            if await next_btn.count() == 0 or await next_btn.is_disabled():
                break

            await next_btn.click()
            await page.wait_for_selector(selectors["container"])
            await human_delay(800, 2000)

        await browser.close()
    return all_data
```

### Workflow 3: Automação de Workflow Autenticado

**Cenário:** Faça login em um portal, navegue por um formulário com múltiplos passos, baixe um relatório.

**Passos:**
1. Verifique se existe um arquivo de estado de sessão
2. Se não houver sessão, realize o login e salve o estado
3. Navegue para a página alvo usando a sessão salva
4. Preencha o formulário de múltiplos passos com os dados fornecidos
5. Aguarde o download ser acionado
6. Salve o arquivo baixado no diretório alvo

```python
async def authenticated_workflow(credentials, form_data, download_dir):
    async with async_playwright() as p:
        browser = await p.chromium.launch(headless=True)
        state_file = "session_state.json"

        # Restaurar ou criar sessão
        if os.path.exists(state_file):
            context = await browser.new_context(storage_state=state_file)
        else:
            context = await browser.new_context()
            page = await context.new_page()
            await login(page, credentials["url"], credentials["user"], credentials["pass"])
            await context.storage_state(path=state_file)

        page = await context.new_page()
        await page.goto(form_data["target_url"])

        # Preencher passos do formulário
        for step_fn in [fill_step_1, fill_step_2]:
            await step_fn(page, form_data)

        # Manipular download
        async with page.expect_download() as dl_info:
            await page.click("button:has-text('Download Report')")
        download = await dl_info.value
        await download.save_as(os.path.join(download_dir, download.suggested_filename))

        await browser.close()
```

## Referência de Ferramentas

| Script | Propósito | Flags Principais | Saída |
|--------|---------|-----------|--------|
| `scraping_toolkit.py` | Gera esqueleto de script Playwright para scraping | `--url`, `--selectors`, `--paginate`, `--output` | Script Python ou config JSON |
| `form_automation_builder.py` | Gera script de automação de preenchimento de formulário a partir de especificação de campo | `--fields`, `--url`, `--output` | Script de automação Python |
| `anti_detection_checker.py` | Audita um script Playwright para vetores de detecção | `--file`, `--verbose` | Relatório de risco com pontuação |

Todos os scripts são somente stdlib. Execute `python3 <script> --help` para uso completo.

## Anti-Padrões

### Esperas Hardcoded
**Ruim:** `await page.wait_for_timeout(5000)` antes de cada ação.
**Bom:** Use `wait_for_selector`, `wait_for_url`, `expect_response` ou `wait_for_load_state`. Esperas hardcoded são instáveis e lentas.

### Sem Recuperação de Erros
**Ruim:** Script linear que falha na primeira erro.
**Bom:** Envolva cada interação de página em try/except. Tire screenshots em estado de erro. Implemente retry com backoff exponencial.

### Ignorar robots.txt
**Ruim:** Fazer scraping sem verificar as diretivas do robots.txt.
**Bom:** Busque e analise o robots.txt antes de fazer scraping. Respeite o `Crawl-delay`. Pule caminhos não permitidos. Adicione o nome do seu bot ao User-Agent se executando em escala.

### Armazenar Credenciais em Scripts
**Ruim:** Hardcodear nomes de usuário e senhas em arquivos Python.
**Bom:** Use variáveis de ambiente, arquivos `.env` (no .gitignore), ou um gerenciador de secrets. Passe credenciais via argumentos CLI.

### Sem Limitação de Taxa
**Ruim:** Bombardear um site com 100 requisições/segundo.
**Bom:** Adicione delays aleatórios entre requisições (1-3s para scraping educado). Monitore respostas 429. Implemente backoff exponencial.

### Fragilidade de Seletor
**Ruim:** Depender de nomes de classes gerados automaticamente (`.css-1a2b3c`) ou aninhamento profundo (`div > div > div > span:nth-child(3)`).
**Bom:** Use atributos de dados, HTML semântico ou localizadores baseados em texto. Teste seletores no DevTools do navegador primeiro.

### Não Limpar Instâncias do Navegador
**Ruim:** Lançar navegadores sem fechá-los, levando a vazamentos de recursos.
**Bom:** Sempre use `try/finally` ou gerenciadores de contexto async para garantir que `browser.close()` seja chamado.

### Executar com Interface em Produção
**Ruim:** Usar `headless=False` em produção/CI.
**Bom:** Desenvolva com modo com interface para depuração, implante com `headless=True`. Use variável de ambiente para alternar: `headless = os.environ.get("HEADLESS", "true") == "true"`.

## Referências Cruzadas

- **playwright-pro** — Skill de testes de navegador. Use para testes E2E, asserções de teste, fixtures de teste. Browser Automation é para extração de dados e automação de workflow, não para testes.
- **api-test-suite-builder** — Quando o site tem uma API pública, acesse a API diretamente em vez de fazer scraping da página renderizada. Mais rápido, mais confiável, menos detectável.
- **performance-profiler** — Se seus scripts de automação são lentos, analise os gargalos antes de adicionar concorrência.
- **env-secrets-manager** — Para gerenciar credenciais de forma segura usadas em workflows de automação autenticados.
