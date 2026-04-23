#!/usr/bin/env sh

set -eu

INSTALL_DIR="$HOME/.atom"

version() {
    VERSION=$(git -C "$INSTALL_DIR" describe --tags --abbrev=0 2>/dev/null || echo "v0.0.0")
    echo "atom version $VERSION"
}
