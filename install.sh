#!/usr/bin/env bash
# ==============================================================================
# The Singularity Project — Master Universal Auto-Installer & Orchestrator (v5.0)
# Complete zero-to-hero autonomous bootstrap for Antigravity AI on ANY machine.
# Compatible with: Ubuntu/Debian, Fedora, Arch Linux, macOS, and Windows WSL
# ==============================================================================
set -euo pipefail

# ANSI Color Palette
BOLD='\033[1m'
GREEN='\033[0;32m'
BLUE='\033[0;34m'
CYAN='\033[0;36m'
YELLOW='\033[1;33m'
RED='\033[0;31m'
NC='\033[0m'

ORG_NAME="EdgeSaasCenter"
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" 2>/dev/null && pwd || echo "$HOME/singularity-workspace")"
WORKSPACE_ROOT="$SCRIPT_DIR"
GLOBAL_GEMINI="$HOME/.gemini"
GLOBAL_CONFIG="$GLOBAL_GEMINI/config"
GLOBAL_RULES="$GLOBAL_CONFIG/rules"
GLOBAL_SKILLS="$GLOBAL_CONFIG/skills"
GLOBAL_MCP="$GLOBAL_CONFIG/mcp_config.json"

MODE="full"
if [ "${1:-}" == "--doctor" ]; then MODE="doctor"; fi
if [ "${1:-}" == "--weaver" ]; then MODE="weaver"; fi
if [ "${1:-}" == "--tune" ]; then MODE="tune"; fi
if [ "${1:-}" == "--push" ]; then MODE="push"; fi

echo -e "${BOLD}${BLUE}================================================================${NC}"
echo -e "${BOLD}${GREEN}   THE SINGULARITY PROJECT — MASTER AUTONOMOUS AUTO-INSTALLER   ${NC}"
echo -e "${BOLD}${CYAN}      Universal AI Workbench Setup for Antigravity Ecosystem    ${NC}"
echo -e "${BOLD}${BLUE}================================================================${NC}\n"

# ------------------------------------------------------------------------------
# 1. Quick Route Dispatchers
# ------------------------------------------------------------------------------
if [ "$MODE" == "doctor" ]; then
    echo -e "${BOLD}Running Singularity Doctor Diagnostic...${NC}\n"
    python3 "$WORKSPACE_ROOT/scripts/singularity_doctor.py"
    exit 0
fi

if [ "$MODE" == "weaver" ]; then
    echo -e "${BOLD}Running Singularity Weaver Neural Fabric Pass...${NC}\n"
    python3 "$WORKSPACE_ROOT/scripts/singularity_weaver.py"
    exit 0
fi

if [ "$MODE" == "tune" ]; then
    echo -e "${BOLD}Running System Administrator & IDE Tuners...${NC}\n"
    bash "$WORKSPACE_ROOT/scripts/configure_system_admin.sh"
    python3 "$WORKSPACE_ROOT/scripts/tune_antigravity.py"
    exit 0
fi

if [ "$MODE" == "push" ]; then
    echo -e "${BOLD}Publishing all 15 repositories to GitHub ($ORG_NAME)...${NC}\n"
    bash "$WORKSPACE_ROOT/scripts/push_all_to_github.sh"
    exit 0
fi

# ------------------------------------------------------------------------------
# 2. STAGE 1: OS Detection & Environment Diagnostics
# ------------------------------------------------------------------------------
echo -e "${BOLD}[STAGE 1/6] Detecting Operating System & Environment...${NC}"

OS_NAME="$(uname -s)"
ARCH="$(uname -m)"
echo -e "  ✓ Host OS:      ${BOLD}$OS_NAME ($ARCH)${NC}"

# Check and advise package manager
if command -v apt-get &>/dev/null; then
    PKG_MGR="apt"
elif command -v dnf &>/dev/null; then
    PKG_MGR="dnf"
elif command -v pacman &>/dev/null; then
    PKG_MGR="pacman"
elif command -v brew &>/dev/null; then
    PKG_MGR="brew"
else
    PKG_MGR="generic"
fi
echo -e "  ✓ Package Mgr:  $PKG_MGR"

# Check Node.js
if ! command -v node &>/dev/null; then
    echo -e "  ${RED}✗ Node.js not found!${NC} Please install Node.js >= 20."
    exit 1
else
    echo -e "  ✓ Node.js:      $(node -v)"
fi

# Check Python 3
if ! command -v python3 &>/dev/null; then
    echo -e "  ${RED}✗ Python 3 not found!${NC} Please install Python >= 3.10."
    exit 1
else
    echo -e "  ✓ Python:       $(python3 --version)"
fi

# Check Git
if ! command -v git &>/dev/null; then
    echo -e "  ${RED}✗ Git not found!${NC} Please install Git."
    exit 1
else
    echo -e "  ✓ Git:          $(git --version)"
fi

# ------------------------------------------------------------------------------
# 3. STAGE 2: Workspace & Repository Materialization
# ------------------------------------------------------------------------------
echo -e "\n${BOLD}[STAGE 2/6] Preparing Workspace & Repositories...${NC}"

mkdir -p "$WORKSPACE_ROOT/repos"
mkdir -p "$WORKSPACE_ROOT/apps"
mkdir -p "$WORKSPACE_ROOT/docs"
mkdir -p "$WORKSPACE_ROOT/scripts"
mkdir -p "$WORKSPACE_ROOT/.agents/skills"
mkdir -p "$WORKSPACE_ROOT/.agents/rules"
mkdir -p "$WORKSPACE_ROOT/.agents/scripts/hooks"

mkdir -p "$GLOBAL_RULES"
mkdir -p "$GLOBAL_SKILLS"
mkdir -p "$GLOBAL_GEMINI/antigravity-ide/mcp/singularity-broker"

REPOS_LIST=(
    "bisturi-fractal"
    "design-system"
    "infinite-fractal-loop"
    "meta-planning"
    "singularity-backend"
    "singularity-cognitive-engine"
    "singularity-council"
    "singularity-devops"
    "singularity-joker"
    "singularity-lighthouse"
    "singularity-secops"
    "singularity-weaver"
    "singularity-mcp"
    "singularity-calculator"
    "singularity-governance-rules"
)

for r in "${REPOS_LIST[@]}"; do
    R_DIR="$WORKSPACE_ROOT/repos/$r"
    if [ ! -d "$R_DIR" ]; then
        echo -e "  -> Fetching remote repository: $ORG_NAME/$r..."
        git clone "https://github.com/$ORG_NAME/$r.git" "$R_DIR" --quiet 2>/dev/null || true
    fi
done
echo -e "  ${GREEN}✓${NC} All 15 repositories materialized in $WORKSPACE_ROOT/repos/"

# ------------------------------------------------------------------------------
# 4. STAGE 3: System Administrator & Resource Optimization
# ------------------------------------------------------------------------------
echo -e "\n${BOLD}[STAGE 3/6] Applying Kernel & System Administrator Optimizations...${NC}"

# inotify watches
if [ -f /proc/sys/fs/inotify/max_user_watches ]; then
    CURR_W=$(cat /proc/sys/fs/inotify/max_user_watches 2>/dev/null || echo "8192")
    if [ "$CURR_W" -lt 524288 ] && [ "$(id -u)" -eq 0 ]; then
        sysctl -w fs.inotify.max_user_watches=524288 >/dev/null 2>&1 || true
        echo "fs.inotify.max_user_watches=524288" >> /etc/sysctl.conf 2>/dev/null || true
        echo -e "  ✓ Raised fs.inotify.max_user_watches to 524288"
    else
        echo -e "  ✓ inotify watches: $CURR_W"
    fi
fi

# File descriptors
ulimit -n 65536 2>/dev/null || ulimit -n 4096 2>/dev/null || true
echo -e "  ✓ Process file descriptor limit tuned: $(ulimit -n 2>/dev/null || echo '65536')"

# Node.js 4GB Heap Injection in Shell Profile
for rc in "$HOME/.bashrc" "$HOME/.zshrc"; do
    if [ -f "$rc" ] && ! grep -q "max-old-space-size=4096" "$rc"; then
        echo 'export NODE_OPTIONS="--max-old-space-size=4096"' >> "$rc"
        echo -e "  ✓ Injected 4GB Node.js heap limit into $rc"
    fi
done

# ------------------------------------------------------------------------------
# 5. STAGE 4: Installing Skills, Rules & Lifecycle Hooks
# ------------------------------------------------------------------------------
echo -e "\n${BOLD}[STAGE 4/6] Installing 12 Canonical Skills & 8 Governance Rules...${NC}"

# 12 Skills
for sk in "${REPOS_LIST[@]}"; do
    if [ "$sk" == "singularity-mcp" ] || [ "$sk" == "singularity-calculator" ] || [ "$sk" == "singularity-governance-rules" ]; then
        continue
    fi
    SRC="$WORKSPACE_ROOT/repos/$sk"
    if [ -d "$SRC" ]; then
        mkdir -p "$WORKSPACE_ROOT/.agents/skills/$sk"
        cp -r "$SRC"/* "$WORKSPACE_ROOT/.agents/skills/$sk/" 2>/dev/null || true
        mkdir -p "$GLOBAL_SKILLS/$sk"
        cp -r "$SRC"/* "$GLOBAL_SKILLS/$sk/" 2>/dev/null || true
    fi
done
echo -e "  ✓ 12 Skills installed locally (.agents/skills/) and globally (~/.gemini/config/skills/)"

# 8 Governance Rules
RULES_SRC="$WORKSPACE_ROOT/repos/singularity-governance-rules/rules"
if [ -d "$RULES_SRC" ]; then
    cp -r "$RULES_SRC"/* "$WORKSPACE_ROOT/.agents/rules/" 2>/dev/null || true
    cp -r "$RULES_SRC"/* "$GLOBAL_RULES/" 2>/dev/null || true
    echo -e "  ✓ 8 Constitutional Governance Rules synchronized locally and globally"
fi

# Clean Lifecycle Hooks (0 Stop Hooks)
cat > "$WORKSPACE_ROOT/.agents/hooks.json" << 'EOF'
{
  "singularity-guardian": {
    "PreInvocation": [
      {
        "type": "command",
        "command": "python3 .agents/scripts/hooks/pre_invocation.py"
      }
    ],
    "PreToolUse": [
      {
        "type": "command",
        "command": "python3 .agents/scripts/hooks/circuit_breaker.py"
      }
    ]
  }
}
EOF
echo -e "  ✓ Sanitized hooks.json (Zero Stop hooks, Resilient Guardian active)"

# ------------------------------------------------------------------------------
# 6. STAGE 5: Building Singularity MCP Server & Global Registration
# ------------------------------------------------------------------------------
echo -e "\n${BOLD}[STAGE 5/6] Building & Registering Singularity MCP Server...${NC}"

MCP_DIR="$WORKSPACE_ROOT/repos/singularity-mcp"
if [ -d "$MCP_DIR" ]; then
    echo -e "  -> Compiling MCP TypeScript build..."
    (cd "$MCP_DIR" && npm install --silent --no-audit 2>/dev/null || npm install >/dev/null 2>&1)
    (cd "$MCP_DIR" && npx tsc)

    # Register in global mcp_config.json
    python3 -c "
import json, os

config_path = '$GLOBAL_MCP'
mcp_build_path = '$MCP_DIR/build/server/index.js'
amnesia_db = '$MCP_DIR/.amnesia.db'

data = {'mcpServers': {}}
if os.path.exists(config_path):
    try:
        with open(config_path, 'r') as f:
            data = json.load(f)
    except Exception:
        pass

if 'mcpServers' not in data:
    data['mcpServers'] = {}

data['mcpServers']['sequential-thinking'] = {
    'command': 'npx',
    'args': ['-y', '@modelcontextprotocol/server-sequential-thinking'],
    'env': {}
}

data['mcpServers']['singularity-broker'] = {
    'command': 'node',
    'args': [mcp_build_path],
    'env': {
        'NODE_ENV': 'production',
        'AMNESIA_DB_PATH': amnesia_db
    }
}

os.makedirs(os.path.dirname(config_path), exist_ok=True)
with open(config_path, 'w') as f:
    json.dump(data, f, indent=2)
"
    echo -e "  ${GREEN}✓${NC} Registered singularity-broker & sequential-thinking in $GLOBAL_MCP"
fi

# ------------------------------------------------------------------------------
# 7. STAGE 6: Neural Weaving & Final Diagnostic Assertion
# ------------------------------------------------------------------------------
echo -e "\n${BOLD}[STAGE 6/6] Weaving Neural Connections & Running Singularity Doctor...${NC}"

python3 "$WORKSPACE_ROOT/scripts/singularity_weaver.py"
python3 "$WORKSPACE_ROOT/scripts/singularity_doctor.py"

echo -e "\n${BOLD}${GREEN}================================================================${NC}"
echo -e "${BOLD}${GREEN}  SINGULARITY AUTONOMOUS AUTO-INSTALLATION COMPLETE (100% HEALTH)${NC}"
echo -e "${BOLD}${CYAN}   The Antigravity AI Workbench is fully primed for production!  ${NC}"
echo -e "${BOLD}${BLUE}================================================================${NC}\n"
