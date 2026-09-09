# dotzsh — options.zsh
#
# This file contains ONLY setopt / unsetopt and native zsh behaviour.
# History-related options live in history.zsh next to HISTFILE/HISTSIZE.
# Prompt, completion styles, integrations: their own files.

# --- globbing / expansion --------------------------------------------------
setopt EXTENDED_GLOB        # `**/`, `~`, `^`, `()` patterns
setopt GLOB_DOTS            # `*` matches dotfiles (careful; deliberate)
setopt NUMERIC_GLOB_SORT    # sort `*.log` numerically (2 before 10)
setopt RC_EXPAND_PARAM      # a{b,c} -> expand params like braces
setopt NO_NOMATCH           # do not error on a failed glob; pass it literally
setopt NO_BANG_HIST         # disable `!` history expansion (avoids surprises)

# --- directory navigation --------------------------------------------------
setopt AUTO_CD              # bare dir name -> cd into it
setopt AUTO_PUSHD           # cd pushes old dir onto the dir stack
setopt PUSHD_IGNORE_DUPS    # do not push duplicates
setopt PUSHD_SILENT         # do not print the stack on pushd/popd
setopt CDABLE_VARS          # `cd foo` works if `foo` is a var holding a path

# --- jobs / i/o ------------------------------------------------------------
setopt LONG_LIST_JOBS       # long format for `jobs`
setopt AUTO_RESUME          # bare command name can resume a stopped job
setopt NO_FLOW_CONTROL      # disable Ctrl-S / Ctrl-Q (frees the keys)
setopt INTERACTIVE_COMMENTS # `#` starts a comment on an interactive line

# --- corrections / safety --------------------------------------------------
setopt NO_CLOBBER           # `>` refuses to overwrite; use `>|` to force
setopt NO_RM_STAR_WAIT      # do not wait 10s before `rm *`
# NOTE: CORRECT/CORRECT_ALL left off — too noisy for a lab; enable if you like.
