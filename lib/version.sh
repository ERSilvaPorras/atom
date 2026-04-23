#!/usr/bin/env sh

set -eu

version() {
    VERSION=$(git -C "$INSTALL_DIR" describe --tags --abbrev=0 2>/dev/null || echo "v0.0.0")
    echo "atom version $VERSION"
}
