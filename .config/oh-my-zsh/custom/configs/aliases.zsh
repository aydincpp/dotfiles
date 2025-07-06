# Enable colored output for ls and grep
alias ls='ls -C --color=auto'
alias grep='grep --color=auto'

# Useful ls aliases
alias ll='ls -lah'
alias la='ls -a'

# Make cd more efficient
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# Run 'make' using all available CPU cores for faster compilation
alias make='make -j$(nproc)'

# Send files to trash instead of permanently deleting them
# alias rm='trash-put'

# Automatically reload .zshrc when it changes
alias reload="source ~/.zshrc"

