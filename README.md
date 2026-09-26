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

Copia el ejemplo a `~/.zshrc`:

```sh
cp ~/dotzsh/zshrc.local.example ~/.zshrc
```

El ejemplo define `DOTZSH_ROOT="$HOME/dotzsh"` y carga la configuración desde allí. Si clonas el repo en otra ubicación, edita `~/.zshrc` y cambia esa asignación por la ruta correcta. El archivo local debe conocer la ubicación para poder hacer el primer `source`; el `zshrc` del repo también puede descubrir su propio directorio cuando se carga directamente y `DOTZSH_ROOT` no está definido.

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

## Modo de edición

El shell activa el modo vi (`bindkey -v`): usa `Esc` para pasar al modo comando y `i` para volver al modo inserción. En modo comando, `v` abre la línea actual en Neovim (`edit-command-line`) con sintaxis Zsh. `KEYTIMEOUT=1` reduce la espera al pulsar `Esc`.

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
