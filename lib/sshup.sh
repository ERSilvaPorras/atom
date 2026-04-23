#!/usr/bin/env sh

set -eu

NAME_SSH_KEY=$1

sshup() {
    eval "$(ssh-agent -s)"
    ssh-add "~/.ssh/id_ed25519_$NAME_SSH_KEY"
}
