#!/usr/bin/env sh

set -eu

docker() {
    COMMAND="${1:-}"
    shift

    case "$COMMAND" in
        nets)
            . "$SCRIPT_DIR/../lib/commands/docker/infonet.sh"
            overview_networks "$@"
            ;;
        tnets)
            . "$SCRIPT_DIR/../lib/commands/docker/treenet.sh"
            tree_networks "$@"
            ;;
        *)
            echo "Command not found"
            ;;
    esac
}
