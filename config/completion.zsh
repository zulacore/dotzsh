# dotzsh/config/completion.zsh

typeset -U fpath

if [[ -n "${BREW_PREFIX:-}" && -d "$BREW_PREFIX/share/zsh-completions" ]]; then
  fpath=("$BREW_PREFIX/share/zsh-completions" "$fpath[@]")
fi

autoload -Uz compinit
cache_root="${XDG_CACHE_HOME:-$HOME/.cache}/zsh"
[[ -d "$cache_root" ]] || command install -d -m 700 "$cache_root"
dump="$cache_root/.zcompdump-${ZSH_VERSION}"
if [[ -n "$dump"(#qNmh-24) ]]; then
  compinit -C -d "$dump"
else
  compinit -d "$dump"
fi
unset cache_root dump

zstyle ':completion:*' use-cache on
zstyle ':completion:*' group-name ''
zstyle ':completion:*:descriptions' format $'%F{cyan}-- %d --%f'
zstyle ':completion:*:messages' format $'%F{purple}-- %d --%f'
zstyle ':completion:*:warnings' format $'%F{red}-- no matches --%f'
zstyle ':completion:*' verbose yes
zstyle ':completion:*' menu select
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}' 'r:|[._-]=* r:|=*'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS:-di=1;34:ln=35:ex=31}"
zstyle ':completion:*:sudo:*' command-path /usr/local/sbin /usr/local/bin /usr/sbin /usr/bin /sbin /bin

if [[ "${DOTZSH_NO_CARAPACE:-0}" != 1 && -n "${commands[carapace]:-}" && "${TERM:-}" != dumb ]]; then
  : ${CARAPACE_BRIDGES:='zsh,fish,bash,inshellisense'}
  export CARAPACE_BRIDGES
  source <(carapace _carapace)
  export DOTZSH_CARAPACE_ACTIVE=1
fi

compsrc() {
  emulate -L zsh
  local cmd="$1" fn="_$1"
  if (( ${+_comps[$cmd]} )); then
    print "$cmd -> $_comps[$cmd]"
  elif (( ${+functions[$fn]} )); then
    whence -v "$fn"
  else
    print "no completer found for '$cmd'"
  fi
}
