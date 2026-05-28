#!/usr/bin/env bash
#
# init.sh — inicializa um projecto novo a partir do claude-product-harness-template.
#
# Uso (após criar repo a partir do template no GitHub):
#   ./scripts/init.sh
#
# O script:
#   1. Pergunta nome do projecto, descrição, owner GH, repo de engenharia (opcional)
#   2. Substitui placeholders em CLAUDE.md, docs/scope.md, .github/CODEOWNERS, engineering.yml
#   3. Adiciona termos de domínio (opcional, repete até ENTER vazio)
#   4. Cria .harness/ e faz o commit inicial (opcional)
#
# É idempotente: se já correu, detecta e pergunta se quer correr de novo.

set -euo pipefail

# ─── Cores ───────────────────────────────────────────
if [ -t 1 ]; then
    BOLD='\033[1m'
    DIM='\033[2m'
    GREEN='\033[32m'
    YELLOW='\033[33m'
    RESET='\033[0m'
else
    BOLD='' DIM='' GREEN='' YELLOW='' RESET=''
fi

info() { echo -e "${BOLD}▶${RESET} $1"; }
ok()   { echo -e "${GREEN}✓${RESET} $1"; }
warn() { echo -e "${YELLOW}⚠${RESET} $1"; }
ask()  {
    local prompt="$1"
    local default="${2:-}"
    local var
    if [ -n "$default" ]; then
        read -r -p "$prompt [$default]: " var
        var="${var:-$default}"
    else
        read -r -p "$prompt: " var
    fi
    echo "$var"
}

# ─── Verificação de pré-requisitos ────────────────────
if ! [ -f "CLAUDE.md" ] || ! [ -d "docs/prds" ] || ! [ -d ".claude/agents" ]; then
    warn "This does not look like the root of a product-harness-based project."
    warn "Run this script from the repo root: ./scripts/init.sh"
    exit 1
fi

# Idempotência: se já não há placeholders, presumivelmente já correu
if ! grep -q '{{PROJECT_NAME}}' CLAUDE.md 2>/dev/null; then
    warn "init.sh seems to have run already (placeholders are gone)."
    read -r -p "Continue anyway? [y/N] " ans
    [ "${ans,,}" = "y" ] || { echo "Cancelled."; exit 0; }
fi

# ─── Banner ──────────────────────────────────────────
cat <<EOF

${BOLD}┌──────────────────────────────────────────────────┐
│  Product harness — initialization                │
└──────────────────────────────────────────────────┘${RESET}

I'll ask you a few short questions and prepare the repo. Everything else
follows the template conventions — edit by hand later.

EOF

# ─── Perguntas ───────────────────────────────────────
PROJECT_NAME=$(ask "Project name" "$(basename "$PWD")")
PROJECT_DESC=$(ask "Short description (1 sentence)")
GITHUB_OWNER=$(ask "Your GitHub username/org (for CODEOWNERS)")
ENG_REPO=$(ask "Engineering repo (OWNER/REPO; empty leaves ticket-writer in draft mode)" "")

echo ""
info "Domain vocabulary (optional)"
echo "  Terms enter CLAUDE.md → 'Domínio: vocabulário do projecto'."
echo "  Format: <term>: <definition>   (e.g. 'project: a group of tasks owned by a user')"
echo "  Empty line to finish."
DOMAIN_TERMS=()
while true; do
    read -r -p "  → " term
    [ -z "$term" ] && break
    DOMAIN_TERMS+=("$term")
done

TODAY=$(date +%Y-%m-%d)

echo ""
info "Summary:"
echo "  Name:         $PROJECT_NAME"
echo "  Description:  $PROJECT_DESC"
echo "  GH owner:     @$GITHUB_OWNER"
echo "  Eng repo:     ${ENG_REPO:-(empty — ticket-writer falls back to draft mode)}"
echo "  Domain terms: ${#DOMAIN_TERMS[@]}"
echo "  Date:         $TODAY"
echo ""
read -r -p "Proceed? [Y/n] " confirm
[ "${confirm,,}" = "n" ] && { echo "Cancelled."; exit 0; }

# ─── Substituições ───────────────────────────────────
info "Replacing placeholders..."

# Cross-platform sed in-place (Linux usa -i, macOS pede -i '')
sed_inplace() {
    if [[ "$OSTYPE" == "darwin"* ]]; then
        sed -i '' "$@"
    else
        sed -i "$@"
    fi
}

# Lista explícita dos ficheiros com placeholders simples
TARGETS=(
    "CLAUDE.md"
    "docs/scope.md"
)

for f in "${TARGETS[@]}"; do
    [ -f "$f" ] || continue
    sed_inplace "s|{{PROJECT_NAME}}|$PROJECT_NAME|g" "$f"
    sed_inplace "s|{{PROJECT_DESCRIPTION}}|$PROJECT_DESC|g" "$f"
done

# CODEOWNERS — troca o owner do template pelo do utilizador
if [ -f ".github/CODEOWNERS" ]; then
    sed_inplace "s|@araodomingosjoao|@$GITHUB_OWNER|g" .github/CODEOWNERS
    ok "CODEOWNERS pointed at @$GITHUB_OWNER"
fi

# engineering.yml — só se foi dado um repo
if [ -n "$ENG_REPO" ] && [ -f "config/harness/engineering.yml" ]; then
    sed_inplace "s|\"OWNER/REPO\"|\"$ENG_REPO\"|g" config/harness/engineering.yml
    ok "engineering.yml pointed at $ENG_REPO"
else
    warn "engineering.yml left as placeholder — ticket-writer will run in draft mode"
fi

# Domain terms — substitui o bloco placeholder por entradas reais
if [ ${#DOMAIN_TERMS[@]} -gt 0 ]; then
    # Build the markdown block in Python (safer than sed for multi-line)
    python3 - "$@" <<PYEOF
import sys
terms_input = """
${DOMAIN_TERMS[@]@Q}
""".strip()
# Re-parse: bash @Q quotes them; split on whitespace+quoting is brittle.
# Read via environment instead.
PYEOF
    # Simpler: build the block in bash and replace with a sentinel Python call.
    TERMS_BLOCK=""
    for t in "${DOMAIN_TERMS[@]}"; do
        name="${t%%:*}"
        def="${t#*:}"
        def="${def# }"  # trim leading space
        TERMS_BLOCK+="- **${name}**: ${def}"$'\n'
    done
    python3 - <<PYEOF
import sys
path = 'CLAUDE.md'
new_block = """${TERMS_BLOCK}""".rstrip()
old_block = "- **{{TERM}}**: definição\n- ..."
with open(path) as f:
    content = f.read()
content = content.replace(old_block, new_block)
with open(path, 'w') as f:
    f.write(content)
PYEOF
    ok "${#DOMAIN_TERMS[@]} domain term(s) added to CLAUDE.md"
else
    # Sem termos: substitui o placeholder por uma nota neutra
    sed_inplace 's|{{TERM}}|example|g' CLAUDE.md
fi

ok "Placeholders replaced"

# ─── Diretório .harness ──────────────────────────────
mkdir -p .harness/state .harness/traces
[ -f ".harness/.gitignore" ] || cat > .harness/.gitignore <<'EOF'
*
!.gitignore
EOF
ok ".harness/ created (gitignored)"

# ─── init.sh auto-destrói? ───────────────────────────
read -r -p "Delete this script (scripts/init.sh) now that it has run? [N/y] " del_init
DELETE_SELF=0
[ "${del_init,,}" = "y" ] && DELETE_SELF=1

# ─── Commit inicial ──────────────────────────────────
if [ -d ".git" ]; then
    read -r -p "Create the initial commit with these changes? [Y/n] " do_commit
    if [ "${do_commit,,}" != "n" ]; then
        git add -A
        if git -c commit.gpgsign=false commit -m "chore: initialize $PROJECT_NAME from product harness template

- Replaced placeholders ({{PROJECT_NAME}}, {{PROJECT_DESCRIPTION}})
- Pointed CODEOWNERS at @$GITHUB_OWNER
$([ -n "$ENG_REPO" ] && echo "- Set engineering repo to $ENG_REPO")
$([ ${#DOMAIN_TERMS[@]} -gt 0 ] && echo "- Seeded ${#DOMAIN_TERMS[@]} domain term(s) in CLAUDE.md")
- Created .harness/ for runtime state
" >/dev/null 2>&1; then
            ok "Initial commit created"
        else
            warn "Commit failed — do it by hand"
        fi
    fi
fi

# ─── Self-delete se pedido ───────────────────────────
if [ "$DELETE_SELF" = "1" ]; then
    trap "rm -f scripts/init.sh; echo -e '${GREEN}✓${RESET} scripts/init.sh removed'" EXIT
fi

# ─── Próximos passos ─────────────────────────────────
cat <<EOF

${GREEN}${BOLD}✓ Product harness initialized for "$PROJECT_NAME"${RESET}

${BOLD}Next steps:${RESET}

  1. ${DIM}Fill in${RESET} docs/scope.md (the north star) and docs/roadmap.md (now/next/later).
  2. ${DIM}Configure the CI secret${RESET}: CLAUDE_CODE_OAUTH_TOKEN (see README §3).
  3. ${DIM}Install the Claude GitHub App${RESET} on this repo (so @claude can act).
  4. ${DIM}Activate branch protection${RESET} (see README §3 — gh api command).
EOF

[ -z "$ENG_REPO" ] && cat <<EOF
  5. ${DIM}When the engineering repo exists${RESET}: edit
     config/harness/engineering.yml (set engineering_repo).
EOF

cat <<EOF

${BOLD}Day-to-day:${RESET}

  - Open a [PRD] issue and mention @claude → the pipeline starts (spec-writer →
    discovery-researcher → prd-author → product-reviewer).
  - When a PRD is accepted, open a [SPRINT] issue → sprint-planner writes the
    plan in sprints/YYYY-Wnn.md.
  - The ticket-writer turns sprint stories into issues in the engineering repo
    (when configured), so the @claude there implements.

${BOLD}Docs:${RESET}

  - README.md   ← overview
  - CLAUDE.md   ← conventions (your edit hub)

EOF
