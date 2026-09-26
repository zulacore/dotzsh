# dotzsh/zshrc

[[ -o interactive ]] || return 0 2>/dev/null || exit 0

if [[ -z "${DOTZSH_ROOT:-}" ]]; then
  DOTZSH_ROOT="${${(%):-%x}:A:h}"
fi
export DOTZSH_ROOT DOTZSH_ACTIVE=1

for file in environment options completion history integrations functions aliases; do
  source "$DOTZSH_ROOT/config/$file.zsh"
done
unset file

# Final key ownership. Tab stays native; fzf is only for Ctrl-T/Alt-C and Ctrl-R
# when Atuin is not available.
if [[ "${TERM:-}" != dumb ]]; then
  bindkey '^I' expand-or-complete
  if (( ${+widgets[atuin-search]} )); then
    bindkey '^R' atuin-search
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

# Enable vi mode and reduce the delay for recognizing Escape.
bindkey -v
export KEYTIMEOUT=1

# Load the edit-command-line function and define its widget.
autoload -Uz edit-command-line
zle -N edit-command-line

# Open the buffer in Neovim with Zsh syntax highlighting.
zstyle :zle:edit-command-line editor nvim '+:set ft=zsh'

# Map 'v' in command mode (vicmd) to edit the command line.
bindkey -M vicmd 'v' edit-command-line

# Control how the cursor appears in the various vi modes. This only applies
# if $VI_MODE_SET_CURSOR=true.
#
# See https://vt100.net/docs/vt510-rm/DECSCUSR for cursor styles.
typeset -g VI_MODE_CURSOR_NORMAL=${VI_MODE_CURSOR_NORMAL:=2}
typeset -g VI_MODE_CURSOR_VISUAL=${VI_MODE_CURSOR_VISUAL:=6}
typeset -g VI_MODE_CURSOR_INSERT=${VI_MODE_CURSOR_INSERT:=6}
typeset -g VI_MODE_CURSOR_OPPEND=${VI_MODE_CURSOR_OPPEND:=0}
typeset -g VI_KEYMAP=${VI_KEYMAP:=main}

function _vi-mode-set-cursor-shape-for-keymap() {
  [[ "$VI_MODE_SET_CURSOR" = true ]] || return 0

  # https://vt100.net/docs/vt510-rm/DECSCUSR
  local _shape=0
  case "${1:-${VI_KEYMAP:-main}}" in
    main)    _shape=$VI_MODE_CURSOR_INSERT ;; # vi insert: line
    viins)   _shape=$VI_MODE_CURSOR_INSERT ;; # vi insert: line
    isearch) _shape=$VI_MODE_CURSOR_INSERT ;; # inc search: line
    command) _shape=$VI_MODE_CURSOR_INSERT ;; # read a command name
    vicmd)   _shape=$VI_MODE_CURSOR_NORMAL ;; # vi cmd: block
    visual)  _shape=$VI_MODE_CURSOR_VISUAL ;; # vi visual mode: block
    viopp)   _shape=$VI_MODE_CURSOR_OPPEND ;; # vi operation pending: blinking block
    *)       _shape=0 ;;
  esac
  printf $'\e[%d q' "${_shape}"
}

# Track keymap changes so the cursor reflects the active vi mode.
function zle-keymap-select() {
  typeset -g VI_KEYMAP=$KEYMAP
  _vi-mode-set-cursor-shape-for-keymap "$VI_KEYMAP"
}
zle -N zle-keymap-select

function zle-line-init() {
  typeset -g VI_KEYMAP=main
  (( ! ${+terminfo[smkx]} )) || echoti smkx
  _vi-mode-set-cursor-shape-for-keymap "$VI_KEYMAP"
}
zle -N zle-line-init

function zle-line-finish() {
  typeset -g VI_KEYMAP=main
  (( ! ${+terminfo[rmkx]} )) || echoti rmkx
  _vi-mode-set-cursor-shape-for-keymap default
}
zle -N zle-line-finish

# Allow Ctrl-P and Ctrl-N to navigate history in vi mode.
bindkey '^P' up-history
bindkey '^N' down-history

# Allow Ctrl-H, Ctrl-W, and Ctrl-? to delete characters and words.
bindkey '^?' backward-delete-char
bindkey '^h' backward-delete-char
bindkey '^w' backward-kill-word

# Allow Ctrl-A and Ctrl-E to move to the start and end of the line.
bindkey '^a' beginning-of-line
bindkey '^e' end-of-line


