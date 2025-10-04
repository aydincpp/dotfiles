# Enable colored output for ls and grep
alias ls='ls -C --color=auto'
alias grep='grep --color=auto'

# Useful ls aliases
if command -v exa >/dev/null 2>&1; then
    alias ls='exa --icons --color=auto'
    alias ll='exa --icons --long --color=auto'
    alias la='exa --icons --long --all --color=auto'
else
    alias ls='ls --color=auto'
    alias ll='ls -lh --color=auto'
    alias la='ls -lha --auto=auto'
fi

# Make cd more efficient
alias ..="cd .."
alias ...="cd ../.."
alias ....="cd ../../.."

# CMake aliases
alias cmk="cmake -S . -B build"
alias cmb="cmake --build build"

# Run 'make' using all available CPU cores for faster compilation
alias make='make -j$(nproc)'

# Send files to trash instead of permanently deleting them
alias rm='trash-put'

# Base flags
CXXFLAGS="-Wall -Wextra"

# Aliases
alias g++="g++ $CXXFLAGS"
alias gcc="gcc $CXXFLAGS"

alias g98="g++ $CXXFLAGS -std=c++98 -o"
alias g11="g++ $CXXFLAGS -std=c++11 -o"
alias g14="g++ $CXXFLAGS -std=c++14 -o"
alias g17="g++ $CXXFLAGS -std=c++17 -o"
alias g20="g++ $CXXFLAGS -std=c++20 -o"

# Automatically reload .zshrc when it changes
alias reload="source ~/.zshrc"

