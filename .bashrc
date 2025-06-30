# ~/.bashrc

# --- Env ---
export LANG=en_US.UTF-8
export LC_ALL=en_US.UTF-8
export EDITOR=vim
export VISUAL=vim
export XDG_CONFIG_HOME="$HOME/.config"

# --- History setup ---
HISTCONTROL=ignoredups:erasedups
HISTSIZE=5000
HISTFILESIZE=10000
HISTIGNORE="ls:bg:fg:history:clear"
PROMPT_COMMAND="history -a; history -c; history -r; $PROMPT_COMMAND"

# --- Terminal prompt (PS1) ---
parse_git_branch() {
  git branch 2>/dev/null | grep \* | cut -d ' ' -f2
}

PS1='\[\e[38;5;75m\]\u@\h\[\e[0m\]:\[\e[38;5;247m\]\w\[\e[0m\]\
\[\e[38;5;208m\] $(parse_git_branch) \[\e[0m\]\n\$ '

# --- Color support ---
if [ -x /usr/bin/dircolors ]; then
  eval "$(dircolors -b)"
  alias ls='ls --color=auto'
  alias grep='grep --color=auto'
  alias diff='diff --color=auto'
fi

# --- Aliases ---
alias l='ls -lah'
alias ..='cd ..'
alias ...='cd ../..'
alias make='make -j$(nproc)'
alias rm='trash-put'

# --- Git-aware prompt ---
export GIT_PS1_SHOWDIRTYSTATE=1
export GIT_PS1_SHOWUNTRACKEDFILES=1

# --- Load user .bash_aliases if exists ---
if [ -f ~/.bash_aliases ]; then
  . ~/.bash_aliases
fi

# --- Source .bashrc_local for host-specific overrides ---
if [ -f ~/.bashrc_local ]; then
  . ~/.bashrc_local
fi

# --- fzf support ---
[ -f ~/.fzf.bash ] && source ~/.fzf.bash
