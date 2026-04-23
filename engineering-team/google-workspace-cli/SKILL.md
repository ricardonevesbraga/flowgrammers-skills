---
name: "google-workspace-cli"
description: "Administração do Google Workspace via CLI gws. Instale, autentique e automatize Gmail, Drive, Sheets, Calendar, Docs, Chat e Tasks. Execute auditorias de segurança, use 43 receitas integradas e 10 pacotes de persona. Use para administração do Google Workspace, configuração da CLI gws, automação do Gmail, gerenciamento do Drive ou agendamento de Calendar."
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Google Workspace CLI

Orientação especializada e automação para administração do Google Workspace usando a CLI `gws` de código aberto. Cobre instalação, autenticação, 18+ APIs de serviço, 43 receitas integradas e 10 pacotes de persona para fluxos de trabalho baseados em papel.

---

## Início Rápido

### Verificar Instalação

```bash
# Verificar se gws está instalado e autenticado
python3 scripts/gws_doctor.py
```

### Enviar um E-mail

```bash
gws gmail users.messages send me --to "team@company.com" \
  --subject "Weekly Update" --body "Here's this week's summary..."
```

### Listar Arquivos do Drive

```bash
gws drive files list --json --limit 20 | python3 scripts/output_analyzer.py --select "name,mimeType,modifiedTime" --format table
```

---

## Instalação

### npm (recomendado)

```bash
npm install -g @anthropic/gws
gws --version
```

### Cargo (do código-fonte)

```bash
cargo install gws-cli
gws --version
```

### Binários Pré-construídos

Baixe de [github.com/googleworkspace/cli/releases](https://github.com/googleworkspace/cli/releases) para macOS, Linux ou Windows.

### Verificar Instalação

```bash
python3 scripts/gws_doctor.py
# Verifica: PATH, versão, status de auth, conectividade de serviço
```

---

## Autenticação

### Configuração OAuth (Interativa)

```bash
# Passo 1: Criar projeto Google Cloud e credenciais OAuth
python3 scripts/auth_setup_guide.py --guide oauth

# Passo 2: Executar configuração de auth
gws auth setup

# Passo 3: Validar
gws auth status --json
```

### Conta de Serviço (Headless/CI)

```bash
# Gerar instruções de configuração
python3 scripts/auth_setup_guide.py --guide service-account

# Configurar com arquivo de chave
export GWS_SERVICE_ACCOUNT_KEY=/path/to/key.json
export GWS_DELEGATED_USER=admin@company.com
gws auth status
```

### Variáveis de Ambiente

```bash
# Gerar template .env
python3 scripts/auth_setup_guide.py --generate-env
```

| Variável | Propósito |
|----------|---------|
| `GWS_CLIENT_ID` | ID de cliente OAuth |
| `GWS_CLIENT_SECRET` | Segredo de cliente OAuth |
| `GWS_TOKEN_PATH` | Caminho personalizado de armazenamento de token |
| `GWS_SERVICE_ACCOUNT_KEY` | Caminho da chave JSON da conta de serviço |
| `GWS_DELEGATED_USER` | Usuário a ser representado (contas de serviço) |
| `GWS_DEFAULT_FORMAT` | Formato de saída padrão (json/ndjson/table) |

### Validar Autenticação

```bash
python3 scripts/auth_setup_guide.py --validate --json
# Testa cada endpoint de serviço
```

---

## Fluxo de Trabalho 1: Automação do Gmail

**Objetivo:** Automatizar operações de e-mail — enviar, pesquisar, rotular e gerenciar filtros.

### Enviar e Responder

```bash
# Enviar um novo e-mail
gws gmail users.messages send me --to "client@example.com" \
  --subject "Proposal" --body "Please find attached..." \
  --attachment proposal.pdf

# Responder a uma thread
gws gmail users.messages reply me --thread-id <THREAD_ID> \
  --body "Thanks for your feedback..."

# Encaminhar uma mensagem
gws gmail users.messages forward me --message-id <MSG_ID> \
  --to "manager@company.com"
```

### Pesquisar e Filtrar

```bash
# Pesquisar e-mails
gws gmail users.messages list me --query "from:client@example.com after:2025/01/01" --json \
  | python3 scripts/output_analyzer.py --count

# Listar rótulos
gws gmail users.labels list me --json

# Criar um filtro
gws gmail users.settings.filters create me \
  --criteria '{"from":"notifications@service.com"}' \
  --action '{"addLabelIds":["Label_123"],"removeLabelIds":["INBOX"]}'
```

### Operações em Massa

```bash
# Arquivar todos os e-mails lidos com mais de 30 dias
gws gmail users.messages list me --query "is:read older_than:30d" --json \
  | python3 scripts/output_analyzer.py --select "id" --format json \
  | xargs -I {} gws gmail users.messages modify me {} --removeLabelIds INBOX
```

---

## Fluxo de Trabalho 2: Drive e Sheets

**Objetivo:** Gerenciar arquivos, criar planilhas, configurar compartilhamento e exportar dados.

### Operações de Arquivo

```bash
# Listar arquivos
gws drive files list --json --limit 50 \
  | python3 scripts/output_analyzer.py --select "name,mimeType,size" --format table

# Fazer upload de um arquivo
gws drive files create --name "Q1 Report" --upload report.pdf \
  --parents <FOLDER_ID>

# Criar uma Planilha Google
gws sheets spreadsheets create --title "Budget 2026" --json

# Baixar/exportar
gws drive files export <FILE_ID> --mime "application/pdf" --output report.pdf
```

### Compartilhamento

```bash
# Compartilhar com usuário
gws drive permissions create <FILE_ID> \
  --type user --role writer --emailAddress "colleague@company.com"

# Compartilhar com domínio (somente visualização)
gws drive permissions create <FILE_ID> \
  --type domain --role reader --domain "company.com"

# Listar quem tem acesso
gws drive permissions list <FILE_ID> --json
```

### Dados do Sheets

```bash
# Ler um intervalo
gws sheets spreadsheets.values get <SHEET_ID> --range "Sheet1!A1:D10" --json

# Escrever dados
gws sheets spreadsheets.values update <SHEET_ID> --range "Sheet1!A1" \
  --values '[["Name","Score"],["Alice",95],["Bob",87]]'

# Adicionar linhas
gws sheets spreadsheets.values append <SHEET_ID> --range "Sheet1!A1" \
  --values '[["Charlie",92]]'
```

---

## Fluxo de Trabalho 3: Calendar e Reuniões

**Objetivo:** Agendar eventos, encontrar horários disponíveis e gerar relatórios de standup.

### Gerenciamento de Eventos

```bash
# Criar um evento
gws calendar events insert primary \
  --summary "Sprint Planning" \
  --start "2026-03-15T10:00:00" --end "2026-03-15T11:00:00" \
  --attendees "team@company.com" \
  --location "Conference Room A"

# Listar próximos eventos
gws calendar events list primary --timeMin "$(date -u +%Y-%m-%dT%H:%M:%SZ)" \
  --maxResults 10 --json

# Evento rápido (linguagem natural)
gws helpers quick-event "Lunch with Sarah tomorrow at noon"
```

### Encontrar Horário Disponível

```bash
# Verificar livre/ocupado para múltiplas pessoas
gws helpers find-time \
  --attendees "alice@co.com,bob@co.com,charlie@co.com" \
  --duration 60 --within "2026-03-15,2026-03-19" --json
```

### Relatório de Standup

```bash
# Gerar standup diário a partir do calendar + tasks
gws recipes standup-report --json \
  | python3 scripts/output_analyzer.py --format table

# Preparação para reunião (agenda + informações de participantes)
gws recipes meeting-prep --event-id <EVENT_ID>
```

---

## Fluxo de Trabalho 4: Auditoria de Segurança

**Objetivo:** Auditar configuração de segurança do Google Workspace e gerar comandos de remediação.

### Executar Auditoria Completa

```bash
# Auditoria completa em todos os serviços
python3 scripts/workspace_audit.py --json

# Auditar serviços específicos
python3 scripts/workspace_audit.py --services gmail,drive,calendar

# Modo demo (sem necessidade de gws)
python3 scripts/workspace_audit.py --demo
```

### Verificações de Auditoria

| Área | Verificação | Risco |
|------|-------|------|
| Drive | Compartilhamento externo habilitado | Exfiltração de dados |
| Gmail | Regras de encaminhamento automático | Exfiltração de dados |
| Gmail | Registros DMARC/SPF/DKIM | Spoofing de e-mail |
| Calendar | Visibilidade de compartilhamento padrão | Vazamento de informações |
| OAuth | Concessões de apps de terceiros | Acesso não autorizado |
| Admin | Contagem de super administradores | Escalada de privilégio |
| Admin | Aplicação de verificação em 2 etapas | Tomada de conta |

### Revisar e Remediar

```bash
# Revisar resultados
python3 scripts/workspace_audit.py --json | python3 scripts/output_analyzer.py \
  --filter "status=FAIL" --select "area,check,remediation"

# Executar remediação (exemplo: restringir compartilhamento externo)
gws drive about get --json  # Verificar configurações atuais
# Seguir comandos de remediação da saída da auditoria
```

---

## Ferramentas Python

| Script | Propósito | Uso |
|--------|---------|-------|
| `gws_doctor.py` | Diagnósticos pré-voo | `python3 scripts/gws_doctor.py [--json] [--services gmail,drive]` |
| `auth_setup_guide.py` | Configuração guiada de auth | `python3 scripts/auth_setup_guide.py --guide oauth` |
| `gws_recipe_runner.py` | Catálogo e executor de receitas | `python3 scripts/gws_recipe_runner.py --list [--persona pm]` |
| `workspace_audit.py` | Auditoria de segurança/config | `python3 scripts/workspace_audit.py [--json] [--demo]` |
| `output_analyzer.py` | Análise JSON/NDJSON | `gws ... --json \| python3 scripts/output_analyzer.py --count` |

Todos os scripts são somente stdlib, suportam saída `--json` e incluem modo demo com dados de amostra embutidos.

---

## Melhores Práticas

### Segurança

1. Use OAuth com escopos mínimos — solicite apenas o que cada fluxo de trabalho precisa
2. Armazene tokens no chaveiro do sistema, nunca em arquivos de texto simples
3. Rotacione chaves de conta de serviço a cada 90 dias
4. Audite concessões de apps OAuth de terceiros trimestralmente
5. Use `--dry-run` antes de operações destrutivas em massa

### Automação

1. Canalize a saída `--json` por `output_analyzer.py` para filtragem e agregação
2. Use receitas para operações em múltiplas etapas em vez de encadear comandos brutos
3. Selecione um pacote de persona para escopo de receitas ao seu papel
4. Use NDformato JSON (`--format ndjson`) para streaming de grandes conjuntos de resultados
5. Defina `GWS_DEFAULT_FORMAT=json` no perfil do shell para scripts

### Desempenho

1. Use `--fields` para solicitar apenas os campos necessários (reduz o tamanho do payload)
2. Use `--limit` para limitar resultados ao navegar
3. Use `--page-all` apenas quando precisar de datasets completos
4. Agrupe operações com receitas em vez de chamadas de API individuais
5. Armazene em cache dados frequentemente acessados (ex.: IDs de rótulo, IDs de pasta) em variáveis

---

## Limitações

| Restrição | Impacto |
|------------|--------|
| Tokens OAuth expiram após 1 hora | Re-auth necessária para scripts de longa duração |
| Limites de taxa de API (por usuário, por serviço) | Operações em massa podem atingir erros 429 |
| Requisitos de escopo variam por serviço | Deve solicitar escopos corretos durante auth |
| Status de CLI pré-v1.0 | Mudanças incompatíveis possíveis entre lançamentos |
| Projeto Google Cloud necessário | Gratuito, mas requer configuração no Cloud Console |
| Admin API precisa de privilégios de administrador | Algumas verificações de auditoria requerem papel de Admin do Workspace |

### Escopos Obrigatórios por Serviço

```bash
# Listar escopos para serviços específicos
python3 scripts/auth_setup_guide.py --scopes gmail,drive,calendar,sheets
```

| Serviço | Escopos Principais |
|---------|-----------|
| Gmail | `gmail.modify`, `gmail.send`, `gmail.labels` |
| Drive | `drive.file`, `drive.metadata.readonly` |
| Sheets | `spreadsheets` |
| Calendar | `calendar`, `calendar.events` |
| Admin | `admin.directory.user.readonly`, `admin.directory.group` |
| Tasks | `tasks` |
