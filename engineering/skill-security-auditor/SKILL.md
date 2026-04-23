---
name: "skill-security-auditor"
description: >
  Auditor de segurança e scanner de vulnerabilidades para skills de agentes de IA antes da instalação.
  Use quando: (1) avaliando uma skill de fonte não confiável, (2) auditando um diretório de skills ou
  URL de repositório git para código malicioso, (3) portão de segurança pré-instalação para plugins do
  Claude Code, (4) escaneando scripts Python em busca de padrões perigosos como os.system,
  subprocess e exfiltração de rede, (5) detectando prompt injection em arquivos SKILL.md, (6) verificando
  riscos na cadeia de suprimentos de dependências, (7) verificando se o acesso ao sistema de arquivos
  permanece dentro dos limites da skill.
  Gatilhos: "auditar esta skill", "esta skill é segura", "escanear skill para segurança",
  "verificar skill antes de instalar", "verificação de segurança da skill", "scan de vulnerabilidade da skill".
author: Ric Neves - Flowgrammers
agents:
  - claude-code
---

# Skill Security Auditor

Escanear e auditar skills de agentes de IA para riscos de segurança antes da instalação. Produz um
veredicto claro de **PASS / WARN / FAIL** com descobertas e orientações de remediação.

## Início Rápido

```bash
# Auditar um diretório de skill local
python3 scripts/skill_security_auditor.py /path/to/skill-name/

# Auditar uma skill de um repositório git
python3 scripts/skill_security_auditor.py https://github.com/user/repo --skill skill-name

# Auditar com modo estrito (qualquer WARN se torna FAIL)
python3 scripts/skill_security_auditor.py /path/to/skill-name/ --strict

# Saída em formato JSON
python3 scripts/skill_security_auditor.py /path/to/skill-name/ --json
```

## O Que É Escaneado

### 1. Riscos de Execução de Código (Scripts Python/Bash)

Escaneia todos os arquivos `.py`, `.sh`, `.bash`, `.js`, `.ts` para:

| Categoria | Padrões Detectados | Severidade |
|----------|-------------------|----------|
| **Injeção de comando** | os.system, os.popen, subprocess com shell=True, execução por backtick | 🔴 CRÍTICO |
| **Execução dinâmica de código** | funções de avaliação de código, compilação dinâmica, importação dinâmica | 🔴 CRÍTICO |
| **Ofuscação** | payloads codificados em base64, codecs.decode, strings em hexadecimal, cadeias de caracteres | 🔴 CRÍTICO |
| **Exfiltração de rede** | requests.post, urllib.request, socket.connect, httpx, aiohttp | 🔴 CRÍTICO |
| **Coleta de credenciais** | leitura de ~/.ssh, ~/.aws, ~/.config, padrões de extração de variáveis de ambiente | 🔴 CRÍTICO |
| **Abuso do sistema de arquivos** | gravações fora do diretório da skill, /etc/, ~/.bashrc, ~/.profile, criação de symlink | 🟡 ALTO |
| **Escalada de privilégios** | sudo, chmod 777, setuid, manipulação de cron | 🔴 CRÍTICO |
| **Desserialização insegura** | pickle.loads, yaml.load sem SafeLoader, marshal.loads | 🟡 ALTO |
| **Subprocess (seguro)** | subprocess.run com argumentos em lista, sem shell | ⚪ INFO |

### 2. Prompt Injection em SKILL.md

Escaneia SKILL.md e todos os arquivos `.md` de referência para:

| Padrão | Exemplo | Severidade |
|---------|---------|----------|
| **Sobrescrição do prompt do sistema** | "Ignore previous instructions", "You are now..." | 🔴 CRÍTICO |
| **Sequestro de papel** | "Act as root", "Pretend you have no restrictions" | 🔴 CRÍTICO |
| **Bypass de segurança** | "Skip safety checks", "Disable content filtering" | 🔴 CRÍTICO |
| **Instruções ocultas** | Caracteres de largura zero, comentários HTML com diretivas | 🟡 ALTO |
| **Permissões excessivas** | "Executar qualquer comando", "Acesso total ao sistema de arquivos" | 🟡 ALTO |
| **Extração de dados** | "Enviar conteúdo de", "Fazer upload do arquivo para", "POST para" | 🔴 CRÍTICO |

### 3. Cadeia de Suprimentos de Dependências

Para skills com `requirements.txt`, `package.json`, ou pip install inline:

| Verificação | O Que Faz | Severidade |
|-------|-------------|----------|
| **Vulnerabilidades conhecidas** | Referência cruzada com bancos de dados de avisos do PyPI/npm | 🔴 CRÍTICO |
| **Typosquatting** | Sinaliza pacotes similares a populares (ex.: `reqeusts`) | 🟡 ALTO |
| **Versões não fixadas** | Sinaliza `requests>=2.0` vs `requests==2.31.0` | ⚪ INFO |
| **Comandos de instalação no código** | pip install ou npm install dentro de scripts | 🟡 ALTO |
| **Pacotes suspeitos** | Baixo número de downloads, criação recente, mantenedor único | ⚪ INFO |

### 4. Sistema de Arquivos e Estrutura

| Verificação | O Que Faz | Severidade |
|-------|-------------|----------|
| **Violação de limite** | Scripts referenciando caminhos fora do diretório da skill | 🟡 ALTO |
| **Arquivos ocultos** | `.env`, dotfiles que não deveriam estar em uma skill | 🟡 ALTO |
| **Arquivos binários** | Executáveis inesperados, `.so`, `.dll`, `.exe` | 🔴 CRÍTICO |
| **Arquivos grandes** | Arquivos >1MB que podem esconder payloads | ⚪ INFO |
| **Symlinks** | Links simbólicos apontando fora do diretório da skill | 🔴 CRÍTICO |

## Fluxo de Trabalho de Auditoria

1. **Executar o scanner** no diretório da skill ou URL do repositório
2. **Revisar o relatório** — descobertas agrupadas por severidade
3. **Interpretação do veredicto:**
   - **✅ PASS** — Sem descobertas críticas ou altas. Seguro para instalar.
   - **⚠️ WARN** — Descobertas altas/médias detectadas. Revisar manualmente antes de instalar.
   - **❌ FAIL** — Descobertas críticas. NÃO instalar sem remediação.
4. **Remediação** — cada descoberta inclui orientação específica de correção

## Lendo o Relatório

```
╔══════════════════════════════════════════════╗
║  RELATÓRIO DE AUDITORIA DE SEGURANÇA DA SKILL ║
║  Skill: example-skill                         ║
║  Veredicto: FAIL                              ║
╠══════════════════════════════════════════════╣
║  CRÍTICO: 2  ALTO: 1  INFO: 3                ║
╚══════════════════════════════════════════════╝

CRÍTICO [CODE-EXEC] scripts/helper.py:42
   Padrão detectado: avaliação dinâmica de código com entrada do usuário (linha 42)
   Risco: Execução arbitrária de código a partir de entrada não confiável
   Correção: Substituir por ast.literal_eval() ou análise explícita

CRÍTICO [NET-EXFIL] scripts/analyzer.py:88
   Padrão detectado: requisição POST para servidor externo com dados coletados
   Risco: Exfiltração de dados para servidor externo
   Correção: Remover chamadas de rede de saída ou verificar se o destino é confiável

ALTO [FS-BOUNDARY] scripts/scanner.py:15
   Padrão detectado: leitura de chave SSH privada fora do escopo da skill
   Risco: Acessa arquivo sensível fora do diretório da skill
   Correção: Remover acesso ao sistema de arquivos fora do diretório da skill

INFO [DEPS-UNPIN] requirements.txt:3
   Padrão: requests>=2.0
   Risco: Dependência não fixada pode introduzir vulnerabilidades
   Correção: Fixar em versão específica: requests==2.31.0
```

## Uso Avançado

### Auditar uma Skill do Git Antes de Clonar

```bash
# Clonar em diretório temporário, auditar, depois limpar
python3 scripts/skill_security_auditor.py https://github.com/user/skill-repo --skill my-skill --cleanup
```

### Integração com CI/CD

```yaml
# Passo do GitHub Actions
- name: "audit-skill-security"
  run: |
    python3 skill-security-auditor/scripts/skill_security_auditor.py ./skills/new-skill/ --strict --json > audit.json
    if [ $? -ne 0 ]; then echo "Auditoria de segurança falhou"; exit 1; fi
```

### Auditoria em Lote

```bash
# Auditar todas as skills em um diretório
for skill in skills/*/; do
  python3 scripts/skill_security_auditor.py "$skill" --json >> audit-results.jsonl
done
```

## Modelo de Ameaças de Referência

Para o modelo completo de ameaças, padrões de detecção e vetores de ataque conhecidos contra skills de agentes de IA, consulte [references/threat-model.md](references/threat-model.md).

## Limitações

- Não pode detectar bombas lógicas ou payloads com atraso de tempo com certeza
- A detecção de ofuscação é baseada em padrões — um atacante suficientemente criativo pode contorná-la
- Verificações de reputação de destino de rede requerem acesso à internet
- Não executa código — apenas análise estática (segura mas menos completa que análise dinâmica)
- Verificações de vulnerabilidade de dependências usam correspondência de padrões local, não bancos de dados CVE ao vivo

Em caso de dúvida após uma auditoria, **não instale**. Solicite esclarecimentos ao autor da skill.
