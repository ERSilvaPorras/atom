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

LOCAL_PATH="$INSTALL_DIR/bin/atom"
if [ ! -d $LOCAL_PATH ]; then
    mkdir -p "$(dirname "$LOCAL_PATH")"
    ln -sf "$LOCAL_PATH" "$BIN_PATH"
fi

# Add to PATH
if ! echo "$PATH" | grep -q "$HOME/.local/bin"; then
    export PATH="$HOME/.local/bin:$PATH"
fi

echo "[OK] Successfully installed 🚀"
