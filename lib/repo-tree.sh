#!/usr/bin/env sh

set -eu

tree_repo () {
    CURRENT_DIR=$(pwd)
    REPO_NAME=$(basename "$CURRENT_DIR")
    REPO_TREE=$(tree -L 5 -I ".venv" --noreport)

    echo "📁 $REPO_NAME"
    echo "$REPO_TREE" | xclip -selection clipboard
    echo "$REPO_TREE"
}
