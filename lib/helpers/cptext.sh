#!/usr/bin/env sh

set -eu

COPY_TEXT_VERSION="v0.1.0"

cpt() {
    case "${1:-}" in
        -v|--version)
            echo "copy version $COPY_TEXT_VERSION"
            return 0
            ;;
    esac

    if [ "$#" -eq 0 ]; then
        echo "usage: copy <text> | copy -v" >&2
        return 1
    fi

    # OSC 52 requires base64 payload (encoding, not encryption).
    printf '\033]52;c;%s\a' "$(printf '%s' "$1" | base64 | tr -d '\n')"
}
