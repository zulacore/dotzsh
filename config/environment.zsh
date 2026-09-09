# dotzsh/config/environment.zsh

if [[ -z "${HOMEBREW_PREFIX:-}" ]]; then
  for brew_bin in /home/linuxbrew/.linuxbrew/bin/brew /opt/homebrew/bin/brew /usr/local/bin/brew ${(v)commands[brew]}; do
    [[ -x "$brew_bin" ]] || continue
    eval "$("$brew_bin" shellenv)"
    break
  done
fi
export BREW_PREFIX="${HOMEBREW_PREFIX:-}"

typeset -U path fpath

# Do not let the old zgen/Oh-My-Zsh fpath leak into this setup.
clean_fpath=()
for d in "${fpath[@]}"; do
  case "$d" in *zgen*|*oh-my-zsh*) ;; *) clean_fpath+=("$d") ;; esac
done
fpath=("${clean_fpath[@]}")
unset clean_fpath d

[[ -d /usr/local/bin ]] && path=(/usr/local/bin "$path[@]")
[[ -d /usr/local/sbin ]] && path=(/usr/local/sbin "$path[@]")
[[ -d "$HOME/.lmstudio/bin" ]] && path=("$HOME/.lmstudio/bin" "$path[@]")

if [[ -n "$BREW_PREFIX" ]]; then
  [[ -d "$BREW_PREFIX/share/zsh/site-functions" ]] && fpath=("$BREW_PREFIX/share/zsh/site-functions" "$fpath[@]")
  path=("$BREW_PREFIX/bin" "$BREW_PREFIX/sbin" "$path[@]")
fi

for d in \
  "/usr/share/zsh/$ZSH_VERSION/functions" \
  "/usr/share/zsh/$ZSH_VERSION/functions/Completion" \
  /usr/share/zsh/functions \
  /usr/share/zsh/functions/Completion \
  /usr/share/zsh/vendor-functions \
  /usr/share/zsh/vendor-completions; do
  [[ -d "$d" ]] && fpath=("$d" "$fpath[@]")
done
unset d

: ${XDG_CONFIG_HOME:="$HOME/.config"}
: ${XDG_CACHE_HOME:="$HOME/.cache"}
: ${XDG_DATA_HOME:="$HOME/.local/share"}
: ${EDITOR:=vim}
: ${PAGER:=less}
export XDG_CONFIG_HOME XDG_CACHE_HOME XDG_DATA_HOME EDITOR PAGER

if [[ -r "$HOME/.machinerc" && "${DOTZSH_NO_MACHINERC:-0}" != 1 ]]; then
  compinit() { : }
  bashcompinit() { : }
  complete() { : }
  source "$HOME/.machinerc"
  unfunction compinit bashcompinit complete 2>/dev/null
fi

if [[ ! -e "$HOME/tmp" && ! -L "$HOME/tmp" ]]; then
  command install -d -m 700 "/tmp/personal-${UID}"
  command ln -s "/tmp/personal-${UID}" "$HOME/tmp"
fi

[[ -z "${SSH_KEY_PATH:-}" && -f "$HOME/.ssh/id_ed25519" ]] && export SSH_KEY_PATH="$HOME/.ssh/id_ed25519"
