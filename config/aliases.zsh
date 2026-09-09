# dotzsh — aliases.zsh
#
# Deliberately SHORT. We do NOT import hundreds of oh-my-zsh aliases. Each
# alias here is intentional, readable, and documented. Add your own below the
# "personal" marker.

# --- essential -------------------------------------------------------------
# `open` behaves like macOS open() on Linux (launch with the default app).
alias open='xdg-open'

# --- listing / navigation --------------------------------------------------
# Human-readable, classify, long, and (with lh) even more compact.
alias ls='ls --color=auto -F'
alias ll='ls -lAh'
alias lh='ls -lAh --group-directories-first'

# Always warn before clobbering with rm/cp/mv (use -f to force).
alias rm='rm -i'
alias cp='cp -i'
alias mv='mv -i'

# --- git (a few, the ones used constantly) ---------------------------------
# `g` is git itself; these are shortcuts to frequent subcommands.
alias g='git'
alias gs='git status --short --branch'
alias gl='git log --oneline --graph --decorate -20'
alias gd='git diff'
alias gco='git checkout'
# Why so few? oh-my-zsh ships ~140 git aliases; most are never used and they
# pollute `git <Tab>`. Add only what you reach for.

# --- kubectl (abbreviations for the long prefix) ---------------------------
alias k='kubectl'
alias kgp='kubectl get pods'
alias kgs='kubectl get svc'
alias kga='kubectl get all'
alias kdf='kubectl delete -f'
# Context/namespace switching is better done with the completion menu:
#   kubectl config use-context <Tab>

# --- dotzsh convenience ----------------------------------------------------
# Reload the config in the current shell.
alias dz-reload='exec zsh'
# Inspect the effective configuration.
alias dz-features='zsh-features'

# --- personal (add your own below this line) -------------------------------
