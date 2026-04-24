# atom

CLI en shell para automatizar tareas locales de desarrollo (actualizacion del repo, limpieza de `__pycache__`, configuracion de Git, carga de SSH keys y versionado).

## Requisitos

- Shell compatible con POSIX (`sh`)
- `git`
- Acceso al repositorio privado

## Instalacion
Cuando el proyecto este publico usar:
```sh
curl -fsSL https://raw.githubusercontent.com/ersilvaporras/atom/main/install.sh | zsh
```

Desde la raiz del proyecto:

```sh
./install.sh
```

El instalador:

- clona el proyecto en `~/.atom`
- crea el symlink `~/.local/bin/atom`

Si `~/.local/bin` no esta en `PATH`, agrega esto en tu perfil de shell:

```sh
export PATH="$HOME/.local/bin:$PATH"
```

## Comandos disponibles

| Comando | Descripcion |
| --- | --- |
| `atom update <key_suffix>` | Actualiza `~/.atom` con `git pull` y previamente carga la clave SSH `~/.ssh/id_ed25519_<key_suffix>`. |
| `atom rmpycache` | Elimina carpetas `__pycache__` en el directorio actual y exporta `PYTHONDONTWRITEBYTECODE=1`. |
| `atom src [repo_name]` | Configura `user.name` y `user.email` de Git a nivel local. Sin argumento aplica al repo actual; con `repo_name` usa `~/Documents/git/<repo_name>`. |
| `atom sshup <key_suffix>` | Inicia `ssh-agent` (si no existe) y agrega `~/.ssh/id_ed25519_<key_suffix>`. |
| `atom sshc` | Crea una clave SSH (ed25519/rsa), agrega la entrada en `~/.ssh/config`, copia la clave publica al portapapeles y abre GitHub SSH settings. |
| `atom repo-tree` | Muestra el arbol del repo actual (profundidad 5, ignora `.venv`) y lo copia al portapapeles. |
| `atom vscode backup <key_suffix>` | Guarda extensiones instaladas de VS Code en `~/Documents/git/learn-vscode/config/extensions.txt` y, si hay cambios, hace commit y push. |
| `atom version` | Muestra el ultimo tag de `~/.atom` (fallback: `v0.0.0`). |

## Uso rapido

```sh
atom update work
atom version
atom sshup work
atom repo-tree
atom vscode backup work
```

## Notas operativas

- El proyecto asume instalacion en `~/.atom`.
- `atom src` aplica datos de identidad fijos definidos en el script.
- `atom update` y `atom vscode backup` requieren `key_suffix` para cargar la clave SSH.
- `atom repo-tree` requiere `tree` y `xclip`.
- `atom sshc` usa `xclip` o `pbcopy` para portapapeles, y `xdg-open` para abrir GitHub.
- El comando `atom` actualmente responde `Command not found` para subcomandos no soportados.
