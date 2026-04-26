#!/usr/bin/env sh

set -eu

pem() {
    COMMAND="${1:-}"
    shift

    case "$COMMAND" in
        handler)
            . "$SCRIPT_DIR/../lib/commands/pem/handler.sh"
            handler_pem "$@"
            ;;
        *)
            echo "Command not found"
            ;;
    esac
}
