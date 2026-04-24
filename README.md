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
| `atom update` | Ejecuta `git pull` en `~/.atom`. |
| `atom rmpycache` | Elimina carpetas `__pycache__` en el directorio actual y exporta `PYTHONDONTWRITEBYTECODE=1`. |
| `atom src` | Configura `user.name` y `user.email` de Git a nivel local del repo actual. |
| `atom sshup <key_suffix>` | Inicia `ssh-agent` y agrega `~/.ssh/id_ed25519_<key_suffix>`. |
| `atom version` | Muestra el ultimo tag de `~/.atom` (fallback: `v0.0.0`). |

## Uso rapido

```sh
atom update
atom version
atom sshup work
```

## Notas operativas

- El proyecto asume instalacion en `~/.atom`.
- `atom src` aplica datos de identidad fijos definidos en el script.
- El comando `atom` actualmente responde `Command not found` para subcomandos no soportados.
