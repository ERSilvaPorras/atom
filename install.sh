#!/usr/bin/env sh

set -eu

REPO_URL="https://github.com/ersilvaporras/atom.git"
INSTALL_DIR="$HOME/.atom"
BIN_PATH="$HOME/.local/bin/atom"

echo "[INFO] Installing Atom CLI ..."

# Clone (solo deseo clonar, lo de actualizar lo quiero hacer manualmente)
if [ ! -d "$INSTALL_DIR" ]; then 
    echo "[INFO] Cloning Atom repository to $INSTALL_DIR ..."
    git clone "$REPO_URL" "$INSTALL_DIR"
fi

# permissions
chmod +x "$INSTALL_DIR/bin/atom"

# Symlink global
echo "[INFO] Creating symlink ..."
if [ ! -d "$BIN_PATH" ]; then
    mkdir -p "$(dirname "$BIN_PATH")"
fi
ln -sf "$INSTALL_DIR/bin/atom" "$BIN_PATH"

# Add to PATH
if ! echo "$PATH" | grep -q "$HOME/.local/bin"; then
    # Identificar la shell actual
    CURRENT_SHELL=$(basename "$SHELL")
    case "$CURRENT_SHELL" in
        bash)
            echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.bashrc"
            source "$HOME/.bashrc"
            ;;
        zsh)
            echo 'export PATH="$HOME/.local/bin:$PATH"' >> "$HOME/.zshrc"
            . "$HOME/.zshrc"
            ;;
        *)
            echo "[ERROR] Unsupported shell: $CURRENT_SHELL. Please add $HOME/.local/bin to your PATH manually."
            exit 1
            ;;
    esac
fi

echo "[OK] Successfully installed 🚀"
