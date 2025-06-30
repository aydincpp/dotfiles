# History Tweaks
export HISTSIZE=5000
export SAVEHIST=10000
export HISTFILE=~/.zsh_history
setopt APPEND_HISTORY       # Append history instead of overwriting
setopt HIST_IGNORE_DUPS     # Ignore duplicate commands
setopt HIST_EXPIRE_DUPS_FIRST  # Remove older duplicate entries
setopt HIST_VERIFY          # Allow history expansion before execution

