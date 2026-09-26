# dotzsh

Configuración Zsh pequeña y predecible. No usa framework, `fzf-tab`, Oh My Zsh ni scripts de instalación.

## Dependencias

Instala las herramientas con Homebrew:

```sh
brew install zsh starship atuin fzf zoxide direnv carapace zsh-autosuggestions zsh-syntax-highlighting zsh-completions
```

## Activación

Clona este repo donde prefieras. Mantén `~/.zshrc` como archivo local normal (no como enlace al repositorio): así los instaladores pueden añadir configuración sin modificar el repo.

```sh
git clone <repo> ~/dotzsh
```

En `~/.zshrc`, define la ruta del repo y carga su configuración:

```zsh
export DOTZSH_ROOT="$HOME/dotzsh"
source "$DOTZSH_ROOT/zshrc"
```

Cambia `DOTZSH_ROOT` si clonas el repo en otra ubicación. `zshrc` también puede descubrir su propio directorio cuando se carga directamente y `DOTZSH_ROOT` no está definido, pero el archivo local debe conocer la ruta para poder hacer el primer `source`.

Si quieres que Starship use la configuración del repo, crea el enlace por separado:

```sh
mkdir -p ~/.config
ln -s "$HOME/dotzsh/starship.toml" ~/.config/starship.toml
```

No enlaces `~/.zshrc` al repo. Si ya existe, conserva una copia antes de sustituirlo.

## Configuración por máquina

Sí conviene tener un archivo local no versionado para ajustes de un equipo concreto: rutas privadas, tokens, alias locales, configuración del trabajo, etc.

Este repo carga automáticamente este archivo si existe:

```sh
~/.machine.zsh
```

Ejemplo:

```sh
# ~/.machine.zsh
export EDITOR=nvim
export PATH="$HOME/.local/bin:$PATH"
alias work='cd ~/work'
```

No lo añadas al repo.

## Qué carga

- Completion nativo de Zsh con `compinit`
- `zsh-completions`
- Carapace para completar comandos, subcomandos y flags
- Starship prompt
- Atuin en `Ctrl-R`
- fzf en `Ctrl-T` y `Alt-C`
- zoxide y direnv
- zsh-autosuggestions
- zsh-syntax-highlighting

`Tab` usa completion nativo de Zsh.

## Archivos principales

```text
zshrc
starship.toml
config/environment.zsh
config/options.zsh
config/completion.zsh
config/history.zsh
config/integrations.zsh
config/aliases.zsh
```

## Desactivar algo temporalmente

```sh
DOTZSH_NO_CARAPACE=1 zsh
DOTZSH_NO_ATUIN=1 zsh
DOTZSH_NO_FZF=1 zsh
DOTZSH_NO_STARSHIP=1 zsh
DOTZSH_NO_AUTOSUGGESTIONS=1 zsh
DOTZSH_NO_SYNTAX_HIGHLIGHTING=1 zsh
```

## Diagnóstico rápido

```sh
zsh-features
compsrc git
```

## Notas

- Carapace se mantiene intencionadamente.
- `fzf-tab` no se usa para mantener completion simple y predecible.
- Entradas antiguas de `zgen`/Oh My Zsh en `fpath` se filtran al iniciar.
