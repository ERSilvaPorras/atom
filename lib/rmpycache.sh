#!/usr/bin/env sh

set -eu

pycache() {
    export PYTHONDONTWRITEBYTECODE=1
}

rmpycache() {
    find . -type d -name "__pycache__" -exec rm -R {} +
    pycache()
}
