# dotzsh

Configuración Zsh pequeña y predecible. No usa framework, `fzf-tab`, Oh My Zsh ni scripts de instalación.

## Dependencias

Instala las herramientas con Homebrew:

```sh
brew install zsh starship atuin fzf zoxide direnv carapace zsh-autosuggestions zsh-syntax-highlighting zsh-completions
```

## Activación

Clona este repo y enlaza los archivos principales:

```sh
git clone <repo> ~/.dotzsh
ln -s ~/.dotzsh/zshrc ~/.zshrc
ln -s ~/.dotzsh/starship.toml ~/.config/starship.toml
```

Si ya tienes `~/.zshrc` o `~/.config/starship.toml`, haz copia antes y adapta los enlaces a tu caso.

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
