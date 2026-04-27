#!/usr/bin/env sh

set -eu

COPY_TEXT_VERSION="v0.1.0"

cpt() {
    case "${1:-}" in
        -v|--version)
            echo "cpt version $COPY_TEXT_VERSION"
            return 0
            ;;
    esac

    # OSC 52 requires base64 payload (encoding, not encryption).
    printf '\033]52;c;%s\a' "$(printf '%s' "$1" | base64 | tr -d '\n')"
}
