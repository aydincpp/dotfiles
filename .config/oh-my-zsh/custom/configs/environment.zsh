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

# Set Vim's runtime directory explicitly
export VIMRUNTIMEDIR=/usr/local/share/vim/vim91

# Specify the terminal type
export TERM="xterm-256color"

# Enable true color support in terminal applications
export COLORTERM="truecolor"

# Define base directory for user configuration files (XDG spec)
export XDG_CONFIG_HOME="$HOME/.config"

# Prepend custom man page location to the manual path
export MANPATH="/usr/local/man:$MANPATH"

# Specify primary monitor output (can be used by window managers or scripts)
export MONITOR=$(xrandr | grep " connected" | head -n 1 | cut -d " " -f1)
