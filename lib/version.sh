#!/usr/bin/env sh

set -eu

INSTALL_DIR="$HOME/.atom"

version() {
    git -C "$INSTALL_DIR" describe --tags --abbrev=0 || echo "v0.0.0"
}
