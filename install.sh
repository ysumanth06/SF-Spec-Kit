#!/bin/bash

# SF Spec-Kit Automated Installer (macOS/Linux)
# Usage: ./install.sh [--ide cursor|antigravity|claude|all] [--yes]

# Detect script directory for absolute path safety
SCRIPT_DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
PROJECT_ROOT="$(dirname "$SCRIPT_DIR")"

IDE="all"
AUTO_CONFIRM=false
while [[ "$#" -gt 0 ]]; do
    case $1 in
        --ide) IDE="$2"; shift ;;
        --yes) AUTO_CONFIRM=true ;;
        *) echo "Unknown parameter passed: $1"; exit 1 ;;
    esac
    shift
done

echo "🚀 Initializing SFSpeckit..."

# 1. Dependency Check & Auto-Install
HAS_SF=true
HAS_GH=true

prompt_user() {
    if [ "$AUTO_CONFIRM" = true ]; then
        return 0
    fi
    local msg=$1
    echo -n "$msg (y/n): "
    read -r response
    if [[ $response =~ ^[Yy]$ ]]; then
        return 0
    else
        return 1
    fi
}

check_and_install_sf() {
    if ! command -v sf &> /dev/null; then
        echo "❌ Salesforce CLI (sf) not found."
        echo "   Impact: /sfspeckit-implement, /sfspeckit-deploy, and /sfspeckit-verify will not function."
        
        if command -v npm &> /dev/null; then
            if prompt_user "❓ Would you like to install Salesforce CLI via npm?"; then
                echo "Installing @salesforce/cli globally..."
                if ! npm install --global @salesforce/cli; then
                    echo "🔒 Permission denied. Retrying with sudo..."
                    sudo npm install --global @salesforce/cli
                fi
                if command -v sf &> /dev/null; then HAS_SF=true; else HAS_SF=false; fi
            else
                HAS_SF=false
            fi
        elif command -v brew &> /dev/null; then
            if prompt_user "❓ Would you like to install Salesforce CLI via Homebrew?"; then
                brew install --cask salesforce-cli
                if command -v sf &> /dev/null; then HAS_SF=true; else HAS_SF=false; fi
            else
                HAS_SF=false
            fi
        else
            HAS_SF=false
        fi
    fi
}

check_and_install_gh() {
    if ! command -v gh &> /dev/null; then
        echo "❌ GitHub CLI (gh) not found."
        echo "   Impact: /sfspeckit-pr will not function."
        
        if command -v brew &> /dev/null; then
            if prompt_user "❓ Would you like to install GitHub CLI via Homebrew?"; then
                brew install gh
                if command -v gh &> /dev/null; then HAS_GH=true; else HAS_GH=false; fi
            else
                HAS_GH=false
            fi
        else
            echo "💡 Please install GitHub CLI manually from https://cli.github.com/"
            HAS_GH=false
        fi
    fi
}

check_and_install_sf
check_and_install_gh

if [ "$HAS_SF" = false ] || [ "$HAS_GH" = false ]; then
    echo ""
    if ! prompt_user "⚠️  Some dependencies are missing. Proceed with linking skills anyway?"; then
        echo "Installation aborted."
        exit 1
    fi
fi

# 2. Setup SFSpeckit Directory Structure in Project Root
SFSPEC_ROOT="$PROJECT_ROOT/sfspeckit-data"
mkdir -p "$SFSPEC_ROOT/memory"
mkdir -p "$SFSPEC_ROOT/specs"

# 2.5. Ensure CLI Wrapper is executable
chmod +x "$SCRIPT_DIR/bin/sfspeckit"

echo "📂 Created directory structure at $SFSPEC_ROOT"

# 3. Create Skill Links
# Auto-detect source skills directory (Toolkit might use .agents or .cursor)
if [ -d "$SCRIPT_DIR/.agents/skills" ]; then
    SOURCE_DIR="$SCRIPT_DIR/.agents/skills"
elif [ -d "$SCRIPT_DIR/.cursor/skills" ]; then
    SOURCE_DIR="$SCRIPT_DIR/.cursor/skills"
else
    echo "❌ Error: Could not find skills source directory (tried .agents/skills and .cursor/skills)"
    exit 1
fi

echo "🔍 Detected skills source at: $SOURCE_DIR"

setup_antigravity() {
    echo "🤖 Setting up Antigravity skills..."
    DEST_DIR="$PROJECT_ROOT/.agents/skills"
    mkdir -p "$DEST_DIR"
    for skill in "$SOURCE_DIR"/*; do
        if [ -d "$skill" ]; then
            ln -snf "$skill" "$DEST_DIR/"
        fi
    done
}

setup_cursor() {
    echo "🖱️  Setting up Cursor rules..."
    DEST_DIR="$PROJECT_ROOT/.cursor/rules"
    mkdir -p "$DEST_DIR"
    for skill in "$SOURCE_DIR"/*; do
        if [ -d "$skill" ]; then
            skill_name=$(basename "$skill")
            ln -snf "$skill/SKILL.md" "$DEST_DIR/$skill_name.md"
        fi
    done
}

case $IDE in
    antigravity) setup_antigravity ;;
    cursor) setup_cursor ;;
    all) 
        setup_antigravity
        setup_cursor
        ;;
    *) echo "Unknown IDE: $IDE. Skipping skill linking." ;;
esac

echo "✅ Installation complete!"
echo "👉 Next step: Run '/sfspeckit-constitution' in your AI agent to begin."
