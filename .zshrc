# --- Oh-My-Zsh Setup ---
export ZSH="$HOME/.config/oh-my-zsh"
ZSH_THEME="powerlevel10k/powerlevel10k"
HYPHEN_INSENSITIVE="true"
DISABLE_MAGIC_FUNCTIONS="true"
ENABLE_CORRECTION="true"
HIST_STAMPS="yyyy-mm-dd"

# --- Oh-My-Zsh Plugins ---
plugins=(
    git
    fzf-tab
    zsh-autosuggestions
    zsh-syntax-highlighting
)

# --- Oh-My-Zsh Auto Update ---
zstyle ':omz:update' mode auto
zstyle ':omz:update' frequency 14

# --- Initialization ---
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
    source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

autoload -Uz compinit && compinit -u
source $ZSH/oh-my-zsh.sh

# --- Custom Configs ---
for config_file in $ZSH_CUSTOM/configs/*.zsh; do
    source $config_file
done

# --- Powerlevel10k ---
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh
