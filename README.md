# atom

CLI en shell para automatizar tareas locales de desarrollo:

- actualizacion del CLI
- configuracion local de Git
- gestion de claves SSH para GitHub
- limpieza de __pycache__
- snapshot de estructura de repositorio
- backup/import de configuracion de VS Code

## Requisitos

Base:

- sh (POSIX)
- git

Segun comando:

- ssh-agent y ssh-add: atom sshup, atom update, atom vscode export
- code (VS Code CLI): atom vscode export, atom vscode import
- tree y xclip: atom repo-tree
- xclip o pbcopy + xdg-open: atom sshc

## Instalacion

Desde la raiz del proyecto:

```sh
./install.sh
```

Cuando el repositorio sea publico:

```sh
curl -fsSL https://raw.githubusercontent.com/ersilvaporras/atom/main/install.sh | zsh
```

El instalador:

- clona el proyecto en ~/.atom
- crea el symlink ~/.local/bin/atom

Si ~/.local/bin no esta en PATH:

```sh
export PATH="$HOME/.local/bin:$PATH"
```

## Uso

```sh
atom <comando> [subcomando] [args]
```

## Referencia de comandos

### Core

| Comando | Argumentos | Que hace |
| --- | --- | --- |
| atom update <key_suffix> | key_suffix obligatorio | Carga ~/.ssh/id_ed25519_<key_suffix> y ejecuta git -C ~/.atom pull. |
| atom version | - | Muestra el ultimo tag en ~/.atom. Si no hay tags, devuelve v0.0.0. |
| atom src [repo_name] | repo_name opcional | Configura user.name y user.email locales. Si no recibe repo_name, aplica al repo actual. |
| atom rmpycache | - | Elimina carpetas __pycache__ de forma recursiva en el directorio actual. |
| atom repo-tree | - | Imprime arbol del repo actual (profundidad 5, excluye .venv) y lo copia al portapapeles. |

### SSH

| Comando | Argumentos | Que hace |
| --- | --- | --- |
| atom sshup <key_suffix> | key_suffix obligatorio | Inicia ssh-agent (si hace falta) y agrega ~/.ssh/id_ed25519_<key_suffix>. |
| atom sshc | interactivo | Crea una clave SSH, agrega entrada en ~/.ssh/config, copia la publica al portapapeles y abre GitHub SSH settings. |

### VS Code

Los comandos vscode trabajan sobre el repo de backup:

- URL: git@github.com:ERSilvaPorras/learn-vscode.git
- path local: ~/Documents/git/learn-vscode

| Comando | Argumentos | Que hace |
| --- | --- | --- |
| atom vscode export <key_suffix> | key_suffix requerido para push | Exporta extensiones instaladas a config/extensions.txt y, si hay cambios, hace commit + push. |
| atom vscode import | - | Instala extensiones desde config/extensions.txt. |
| atom vscode settings | - | Importa config/settings.json a ~/.config/Code/User/settings.json. |

## Ejemplos

```sh
# actualizar el CLI
atom update work

# cargar clave para sesion actual
atom sshup work

# setear identidad git en repo actual
atom src

# setear identidad git en repo especifico
atom src learn-vscode

# exportar extensiones y sincronizar backup
atom vscode export work

# restaurar extensiones y settings
atom vscode import
atom vscode settings
```

## Troubleshooting

- Command not found: verifica que ~/.local/bin este en PATH y que exista el symlink atom.
- SSH key not found: valida que exista ~/.ssh/id_ed25519_<key_suffix>.
- VSCode CLI not found: instala VS Code y habilita el comando code en PATH.
- Backup repository is not a git repository: elimina ~/Documents/git/learn-vscode y vuelve a ejecutar el comando vscode para clonar limpio.

## Notas operativas

- El proyecto asume instalacion en ~/.atom.
- Subcomandos invalidos responden Command not found.
- atom src usa identidad fija definida en script (ERSilvaPorras / eduasilvaporras@frba.utn.edu.ar).
