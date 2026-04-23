# atom

Atom is a small shell-based CLI for installing and updating the local `atom` command from this repository.

## Requirements

- POSIX-compatible shell
- `git`
- Access to the private repository

## Installation

Run the installer from the repository root:

```sh
./install.sh
```

The script clones the project into `~/.atom` and creates a symlink in `~/.local/bin/atom`.

If `~/.local/bin` is not in your `PATH`, add it to your shell profile:

```sh
export PATH="$HOME/.local/bin:$PATH"
```

## Usage

Update the local installation with:

```sh
atom update
```

This pulls the latest changes into `~/.atom`.
