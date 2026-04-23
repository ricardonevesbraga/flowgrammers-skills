#!/usr/bin/env bash
# =============================================================================
# Flowgrammers Claude Skills — Instalador Automático
# Versão: 2.0.0
# Autor: Ric Neves - Flowgrammers
# =============================================================================

set -e

# Cores
RED='\033[0;31m'
GREEN='\033[0;32m'
YELLOW='\033[1;33m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
BOLD='\033[1m'
NC='\033[0m'

SKILLS_DIR="$HOME/.claude/skills"
COMMANDS_DIR="$HOME/.claude/commands"
CLAUDE_MD="$HOME/.claude/CLAUDE.md"

# Banner
echo ""
echo -e "${CYAN}${BOLD}"
echo "  ███████╗██╗      ██████╗ ██╗    ██╗"
echo "  ██╔════╝██║     ██╔═══██╗██║    ██║"
echo "  █████╗  ██║     ██║   ██║██║ █╗ ██║"
echo "  ██╔══╝  ██║     ██║   ██║██║███╗██║"
echo "  ██║     ███████╗╚██████╔╝╚███╔███╔╝"
echo "  ╚═╝     ╚══════╝ ╚═════╝  ╚══╝╚══╝"
echo -e "${NC}"
echo -e "${BOLD}  Flowgrammers Claude Skills  v2.0.0${NC}"
echo -e "  Instalador Automático"
echo ""
echo "────────────────────────────────────────────────────"
echo ""

# Detectar OS
OS="$(uname -s)"
case "$OS" in
  Darwin) OS_NAME="macOS" ;;
  Linux)  OS_NAME="Linux" ;;
  *)      OS_NAME="$OS" ;;
esac

echo -e "${BLUE}▶ Sistema detectado:${NC} $OS_NAME"

# Verificar Claude Code
echo -e "${BLUE}▶ Verificando Claude Code...${NC}"
if command -v claude &> /dev/null; then
  CLAUDE_VERSION=$(claude --version 2>/dev/null || echo "instalado")
  echo -e "  ${GREEN}✓${NC} Claude Code encontrado: $CLAUDE_VERSION"
else
  echo -e "  ${YELLOW}⚠${NC}  Claude Code não encontrado no PATH"
  echo -e "     Para instalar: ${CYAN}npm install -g @anthropic-ai/claude-code${NC}"
  echo ""
  read -p "  Continuar mesmo assim? (s/N): " CONTINUE
  if [[ ! "$CONTINUE" =~ ^[Ss]$ ]]; then
    echo -e "  ${RED}Instalação cancelada.${NC}"
    exit 1
  fi
fi

# Verificar diretório de origem
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
echo -e "${BLUE}▶ Origem das skills:${NC} $SCRIPT_DIR"

# Verificar se há SKILL.md files
SKILL_COUNT=$(find "$SCRIPT_DIR" -name "SKILL.md" | wc -l | tr -d ' ')
if [ "$SKILL_COUNT" -eq 0 ]; then
  echo -e "  ${RED}✗ Nenhum arquivo SKILL.md encontrado em $SCRIPT_DIR${NC}"
  echo -e "    Certifique-se de executar este script na pasta raiz do projeto."
  exit 1
fi
echo -e "  ${GREEN}✓${NC} $SKILL_COUNT skills encontradas"

echo ""
echo "────────────────────────────────────────────────────"
echo -e "${BOLD}  O instalador vai:${NC}"
echo ""
echo -e "  📁 Copiar skills para:   ${CYAN}~/.claude/skills/${NC}"
echo -e "  ⚡ Instalar comandos em: ${CYAN}~/.claude/commands/${NC}"
echo -e "  📄 Configurar:          ${CYAN}~/.claude/CLAUDE.md${NC}"
echo ""
echo "────────────────────────────────────────────────────"
echo ""
read -p "  Confirmar instalação? (S/n): " CONFIRM
if [[ "$CONFIRM" =~ ^[Nn]$ ]]; then
  echo -e "  ${YELLOW}Instalação cancelada.${NC}"
  exit 0
fi

echo ""

# ─── INSTALAR SKILLS ───────────────────────────────────
echo -e "${BLUE}▶ Instalando skills...${NC}"

# Backup se já existir
if [ -d "$SKILLS_DIR" ]; then
  BACKUP_DIR="${SKILLS_DIR}.backup.$(date +%Y%m%d_%H%M%S)"
  echo -e "  ${YELLOW}⚠${NC}  Instalação anterior encontrada — fazendo backup em:"
  echo -e "     $BACKUP_DIR"
  mv "$SKILLS_DIR" "$BACKUP_DIR"
fi

mkdir -p "$SKILLS_DIR"

# Copiar skills (excluindo arquivos desnecessários)
rsync -a \
  --exclude='.git/' \
  --exclude='*.zip' \
  --exclude='install.sh' \
  --exclude='README.md' \
  --exclude='CLAUDE.md' \
  --exclude='*.pyc' \
  --exclude='__pycache__/' \
  "$SCRIPT_DIR/" "$SKILLS_DIR/" 2>/dev/null || \
cp -r "$SCRIPT_DIR/." "$SKILLS_DIR/"

INSTALLED_COUNT=$(find "$SKILLS_DIR" -name "SKILL.md" | wc -l | tr -d ' ')
echo -e "  ${GREEN}✓${NC} $INSTALLED_COUNT skills instaladas em $SKILLS_DIR"

# ─── INSTALAR COMANDOS ─────────────────────────────────
echo -e "${BLUE}▶ Instalando comandos slash...${NC}"

mkdir -p "$COMMANDS_DIR"

if [ -d "$SCRIPT_DIR/commands" ]; then
  cp -f "$SCRIPT_DIR/commands/"* "$COMMANDS_DIR/" 2>/dev/null || true
  CMD_COUNT=$(ls "$SCRIPT_DIR/commands/" | wc -l | tr -d ' ')
  echo -e "  ${GREEN}✓${NC} $CMD_COUNT comandos instalados em $COMMANDS_DIR"
else
  echo -e "  ${YELLOW}⚠${NC}  Pasta commands/ não encontrada — pulando"
fi

# ─── CONFIGURAR CLAUDE.MD ──────────────────────────────
echo -e "${BLUE}▶ Configurando CLAUDE.md global...${NC}"

mkdir -p "$HOME/.claude"

# Verificar se já tem bloco Flowgrammers
if [ -f "$CLAUDE_MD" ] && grep -q "Flowgrammers Skills" "$CLAUDE_MD" 2>/dev/null; then
  echo -e "  ${YELLOW}⚠${NC}  CLAUDE.md já contém configuração Flowgrammers — mantendo"
else
  cat >> "$CLAUDE_MD" << 'EOF'

## Flowgrammers Skills

Skills de IA especializadas disponíveis em ~/.claude/skills/.
Para usar qualquer skill, peça ao Claude em linguagem natural:

  "Use a skill de CEO Advisor em ~/.claude/skills/c-level-advisor/ceo-advisor/SKILL.md"
  "Leia a skill de RAG Architect em ~/.claude/skills/engineering/rag-architect/SKILL.md"
  "Ative a skill de Paid Ads em ~/.claude/skills/marketing-skill/paid-ads/SKILL.md"

**Domínios disponíveis:**
- c-level-advisor/     → CEO, CTO, CFO, CMO, COO, CPO, CRO, CISO, CHRO
- engineering/         → RAG, MCP, CI/CD, Database, Docker, Terraform, Performance
- engineering-team/    → Frontend, Backend, DevOps, QA, Security, ML, Data
- marketing-skill/     → SEO, Paid Ads, CRO, Content, Email, Social
- product-team/        → PM, PO, UX, UI, Analytics, Strategy
- business-growth/     → Customer Success, Sales, Revenue Ops, Contratos BR
- project-management/  → PM Sênior, Scrum, Jira, Confluence
- finance/             → Análise Financeira, SaaS Metrics, Investimentos
- ra-qm-team/          → LGPD, ISO 13485, ISO 27001, ANVISA, SOC2, CAPA
- skills-brasileiras/  → Copy, Marketing exclusivo para o Brasil
EOF
  echo -e "  ${GREEN}✓${NC} CLAUDE.md configurado"
fi

# ─── CRIAR ATALHO DE SKILLS ────────────────────────────
echo -e "${BLUE}▶ Criando guia de skills...${NC}"

cat > "$SKILLS_DIR/SKILLS.md" << 'EOF'
# Guia de Skills — Flowgrammers

Para usar qualquer skill no Claude Code, peça em linguagem natural:

  "Use a skill em ~/.claude/skills/[domínio]/[skill]/SKILL.md"

Ou simplesmente descreva o que precisa e o Claude irá sugerir a skill adequada.

---

## C-Level Advisor
- CEO Advisor:     ~/.claude/skills/c-level-advisor/ceo-advisor/SKILL.md
- CTO Advisor:     ~/.claude/skills/c-level-advisor/cto-advisor/SKILL.md
- CFO Advisor:     ~/.claude/skills/c-level-advisor/cfo-advisor/SKILL.md
- CMO Advisor:     ~/.claude/skills/c-level-advisor/cmo-advisor/SKILL.md
- Chief of Staff:  ~/.claude/skills/c-level-advisor/chief-of-staff/SKILL.md

## Engineering
- RAG Architect:      ~/.claude/skills/engineering/rag-architect/SKILL.md
- MCP Server Builder: ~/.claude/skills/engineering/mcp-server-builder/SKILL.md
- Database Designer:  ~/.claude/skills/engineering/database-designer/SKILL.md
- CI/CD Pipeline:     ~/.claude/skills/engineering/ci-cd-pipeline-builder/SKILL.md
- Terraform Patterns: ~/.claude/skills/engineering/terraform-patterns/SKILL.md

## Engineering Team
- Senior Frontend:  ~/.claude/skills/engineering-team/senior-frontend/SKILL.md
- Senior Backend:   ~/.claude/skills/engineering-team/senior-backend/SKILL.md
- Senior DevOps:    ~/.claude/skills/engineering-team/senior-devops/SKILL.md
- Code Reviewer:    ~/.claude/skills/engineering-team/code-reviewer/SKILL.md

## Marketing
- Paid Ads:       ~/.claude/skills/marketing-skill/paid-ads/SKILL.md
- SEO Audit:      ~/.claude/skills/marketing-skill/seo-audit/SKILL.md
- Copywriting:    ~/.claude/skills/marketing-skill/copywriting/SKILL.md
- Email Sequence: ~/.claude/skills/marketing-skill/email-sequence/SKILL.md

## Skills Brasileiras
- Copy e Conteúdo: ~/.claude/skills/skills-brasileiras/copy-e-conteudo/SKILL.md
- Marketing BR:    ~/.claude/skills/skills-brasileiras/marketing/SKILL.md

## Product Team
- Product Manager: ~/.claude/skills/product-team/product-manager-toolkit/SKILL.md
- UX Researcher:   ~/.claude/skills/product-team/ux-researcher-designer/SKILL.md

## Business Growth
- Contract Writer:     ~/.claude/skills/business-growth/contract-and-proposal-writer/SKILL.md
- Customer Success:    ~/.claude/skills/business-growth/customer-success-manager/SKILL.md

## Finance
- SaaS Metrics: ~/.claude/skills/finance/saas-metrics-coach/SKILL.md
- Financial Analyst: ~/.claude/skills/finance/financial-analyst/SKILL.md

## RA/QM Team
- LGPD Expert:    ~/.claude/skills/ra-qm-team/lgpd-expert/SKILL.md
- Quality Manager: ~/.claude/skills/ra-qm-team/quality-manager-qms-iso13485/SKILL.md
EOF

echo -e "  ${GREEN}✓${NC} Guia criado em $SKILLS_DIR/SKILLS.md"

# ─── RESUMO FINAL ──────────────────────────────────────
echo ""
echo "────────────────────────────────────────────────────"
echo -e "${GREEN}${BOLD}  ✓ Instalação concluída com sucesso!${NC}"
echo "────────────────────────────────────────────────────"
echo ""
echo -e "${BOLD}  O que foi instalado:${NC}"
echo -e "  • ${INSTALLED_COUNT} skills em ${CYAN}$SKILLS_DIR${NC}"
echo -e "  • Comandos slash em ${CYAN}$COMMANDS_DIR${NC}"
echo -e "  • CLAUDE.md configurado em ${CYAN}$HOME/.claude/${NC}"
echo ""
echo -e "${BOLD}  Como usar no Claude Code:${NC}"
echo ""
echo -e "  ${CYAN}# Ative uma skill pedindo ao Claude:${NC}"
echo -e "  \"Use a skill de CEO Advisor em ~/.claude/skills/c-level-advisor/ceo-advisor/SKILL.md\""
echo ""
echo -e "  ${CYAN}# Veja todas as skills disponíveis:${NC}"
echo -e "  \"Leia o guia de skills em ~/.claude/skills/SKILLS.md\""
echo ""
echo -e "  ${CYAN}# Use os comandos slash:${NC}"
echo -e "  /prd  /tdd  /sprint-plan  /saas-health  /tech-debt"
echo ""
echo "────────────────────────────────────────────────────"
echo -e "  ${BOLD}Flowgrammers${NC} — flowgrammers.com.br"
echo "────────────────────────────────────────────────────"
echo ""
