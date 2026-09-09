# dotzsh/config/integrations.zsh

if [[ "${DOTZSH_NO_FZF:-0}" != 1 && -n "${commands[fzf]:-}" && "${TERM:-}" != dumb && -t 0 ]]; then
  : ${FZF_DEFAULT_COMMAND:='fd --type f --hidden --follow --exclude .git 2>/dev/null || rg --files --hidden --follow --glob "!.git" 2>/dev/null || git ls-files 2>/dev/null'}
  : ${FZF_CTRL_T_COMMAND:='$FZF_DEFAULT_COMMAND'}
  : ${FZF_ALT_C_COMMAND:='fd --type d --hidden --follow --exclude .git 2>/dev/null || find . -type d 2>/dev/null'}
  : ${FZF_DEFAULT_OPTS:='--height 40% --layout=reverse --border'}
  export FZF_DEFAULT_COMMAND FZF_CTRL_T_COMMAND FZF_ALT_C_COMMAND FZF_DEFAULT_OPTS
  [[ -r "$BREW_PREFIX/opt/fzf/shell/key-bindings.zsh" ]] && source "$BREW_PREFIX/opt/fzf/shell/key-bindings.zsh"
  export DOTZSH_FZF_ACTIVE=1
fi

if [[ "${DOTZSH_NO_ZOXIDE:-0}" != 1 && -n "${commands[zoxide]:-}" ]]; then
  eval "$(zoxide init zsh)"
  export DOTZSH_ZOXIDE_ACTIVE=1
fi

if [[ "${DOTZSH_NO_DIRENV:-0}" != 1 && -n "${commands[direnv]:-}" ]]; then
  eval "$(direnv hook zsh)"
  export DOTZSH_DIRENV_ACTIVE=1
fi

if [[ "${DOTZSH_NO_STARSHIP:-0}" != 1 && -n "${commands[starship]:-}" && "${TERM:-}" != dumb ]]; then
  : ${STARSHIP_CONFIG:="$DOTZSH_ROOT/starship.toml"}
  export STARSHIP_CONFIG
  eval "$(starship init zsh)"
  export DOTZSH_STARSHIP_ACTIVE=1
fi

if [[ "${DOTZSH_NO_AUTOSUGGESTIONS:-0}" != 1 && -n "$BREW_PREFIX" && -f "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh" && "${TERM:-}" != dumb ]]; then
  if (( ${+DOTZSH_ATUIN_ACTIVE} )) && (( ${+functions[_zsh_autosuggest_strategy_atuin]} )); then
    ZSH_AUTOSUGGEST_STRATEGY=(atuin history completion)
  else
    ZSH_AUTOSUGGEST_STRATEGY=(history completion)
  fi
  ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=8'
  source "$BREW_PREFIX/share/zsh-autosuggestions/zsh-autosuggestions.zsh"
  export DOTZSH_AUTOSUGGESTIONS_ACTIVE=1
fi

if [[ "${DOTZSH_NO_SYNTAX_HIGHLIGHTING:-0}" != 1 && -n "$BREW_PREFIX" && -f "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh" && "${TERM:-}" != dumb ]]; then
  (( ${+ZSH_HIGHLIGHT_HIGHLIGHTERS} )) || ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
  source "$BREW_PREFIX/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
  export DOTZSH_SYNTAX_HIGHLIGHTING_ACTIVE=1
fi
