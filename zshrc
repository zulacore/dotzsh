# dotzsh/zshrc

[[ -o interactive ]] || return 0 2>/dev/null || exit 0

if [[ -z "${DOTZSH_ROOT:-}" ]]; then
  DOTZSH_ROOT="${${(%):-%x}:A:h}"
fi
export DOTZSH_ROOT DOTZSH_ACTIVE=1

for file in environment options completion history integrations aliases; do
  source "$DOTZSH_ROOT/config/$file.zsh"
done
unset file

DOTZSH_MACHINE_FILE="${DOTZSH_MACHINE_FILE:-$HOME/.machine.zsh}"
[[ -r "$DOTZSH_MACHINE_FILE" ]] && source "$DOTZSH_MACHINE_FILE"

# Final key ownership. Tab stays native; fzf is only for Ctrl-T/Alt-C and Ctrl-R
# when Atuin is not available.
if [[ "${TERM:-}" != dumb ]]; then
  bindkey '^I' expand-or-complete
  if (( ${+functions[_atuin_search]} )); then
    bindkey '^R' _atuin_search
    DOTZSH_CTRL_R_OWNER=atuin
  elif (( ${+functions[fzf-history-widget]} )); then
    bindkey '^R' fzf-history-widget
    DOTZSH_CTRL_R_OWNER=fzf
  else
    bindkey '^R' history-incremental-search-backward 2>/dev/null
    DOTZSH_CTRL_R_OWNER=zsh
  fi
fi
export DOTZSH_CTRL_R_OWNER=${DOTZSH_CTRL_R_OWNER:-zsh}
export DOTZSH_TAB_OWNER=zsh

zsh-features() {
  emulate -L zsh
  _dz_state() { [[ -n "${(P)1:-}" ]] && print active || print inactive; }
  print -P "%F{cyan}dotzsh%f"
  printf "  %-18s %s\n" "brew" "${BREW_PREFIX:-<none>}"
  printf "  %-18s %s\n" "completion" "native zsh"
  printf "  %-18s %s\n" "carapace" "$(_dz_state DOTZSH_CARAPACE_ACTIVE)"
  printf "  %-18s %s\n" "atuin" "$(_dz_state DOTZSH_ATUIN_ACTIVE)"
  printf "  %-18s %s\n" "fzf" "$(_dz_state DOTZSH_FZF_ACTIVE)"
  printf "  %-18s %s\n" "zoxide" "$(_dz_state DOTZSH_ZOXIDE_ACTIVE)"
  printf "  %-18s %s\n" "direnv" "$(_dz_state DOTZSH_DIRENV_ACTIVE)"
  printf "  %-18s %s\n" "autosuggestions" "$(_dz_state DOTZSH_AUTOSUGGESTIONS_ACTIVE)"
  printf "  %-18s %s\n" "syntax highlight" "$(_dz_state DOTZSH_SYNTAX_HIGHLIGHTING_ACTIVE)"
  printf "  %-18s %s\n" "Ctrl-R" "${DOTZSH_CTRL_R_OWNER:-zsh}"
  printf "  %-18s %s\n" "Tab" "$(bindkey '^I' 2>/dev/null)"
}

if [[ -z "${DOTZSH_QUIET:-}" && -z "${DOTZSH_LOADED_ONCE:-}" ]]; then
  print -P "%F{cyan}dotzsh%f loaded  (Tab: native, Ctrl-R: ${DOTZSH_CTRL_R_OWNER})"
  export DOTZSH_LOADED_ONCE=1
fi
