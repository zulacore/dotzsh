# dotzsh/config/history.zsh

HISTFILE="${ZDOTDIR:-$HOME}/.zsh_history"
HISTSIZE=32768
SAVEHIST=32768
export HISTFILE HISTSIZE SAVEHIST

setopt APPEND_HISTORY INC_APPEND_HISTORY SHARE_HISTORY EXTENDED_HISTORY
setopt HIST_IGNORE_DUPS HIST_IGNORE_ALL_DUPS HIST_IGNORE_SPACE HIST_REDUCE_BLANKS
setopt HIST_VERIFY HIST_NO_STORE

hist_dir="${HISTFILE:h}"
[[ -d "$hist_dir" ]] || command mkdir -p "$hist_dir"
[[ -e "$HISTFILE" ]] || command touch "$HISTFILE"
unset hist_dir

if [[ "${DOTZSH_NO_ATUIN:-0}" != 1 && -n "${commands[atuin]:-}" && "${TERM:-}" != dumb ]]; then
  eval "$(atuin init zsh)"
  export DOTZSH_ATUIN_ACTIVE=1
fi
