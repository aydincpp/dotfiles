# Define a function to prepend a directory to $PATH if it's not already included
pathprepend() {
    case ":$PATH:" in
    *:"$1":*) ;;                 # If $1 is already in $PATH, do nothing
    *) PATH="$1:$PATH" ;;        # Otherwise, prepend $1 to $PATH
esac
}

# Ensure custom user binaries are prioritized in PATH
pathprepend "$HOME/bin"
pathprepend "$HOME/.local/bin"
pathprepend "/usr/local/bin"
export PATH

# Set locale to use UTF-8 encoding consistently across applications
export LC_ALL="en_US.UTF-8"
export LANG="en_US.UTF-8"

# Set default terminal-based and GUI-based editors to Vim
export EDITOR="vim"
export VISUAL="vim"

# Specify the terminal type (used by some apps for capability detection)
export TERM="alacritty"

# Enable true color support in terminal applications
export COLORTERM="truecolor"

# Define base directory for user configuration files (XDG spec)
export XDG_CONFIG_HOME="$HOME/.config"

# Set Vim's runtime directory explicitly (useful for custom builds)
export VIMRUNTIMEDIR="/usr/local/share/vim/vim91"

# Prepend custom man page location to the manual path
export MANPATH="/usr/local/man:$MANPATH"

# Specify primary monitor output (can be used by window managers or scripts)
export MONITOR=DP-2
