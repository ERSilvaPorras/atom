#!/usr/bin/env sh

set -eu

NAME_REPO=${1:-}
REPO_DIR="$HOME/Documents/git/$NAME_REPO"

scr() {
    if [ -z "$NAME_REPO" ]; then
        REPO_DIR="."
    fi

    git -C "$REPO_DIR" config --local user.name "ERSilvaPorras"
    git -C "$REPO_DIR" config --local user.email "eduasilvaporras@frba.utn.edu.ar"
}
