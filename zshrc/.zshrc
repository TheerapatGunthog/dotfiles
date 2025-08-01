# Set up zinit
ZINIT_HOME="${XDG_DATA_HOME:-${HOME}/.local/share}/zinit/zinit.git"
[ ! -d $ZINIT_HOME ] && mkdir -p "$(dirname $ZINIT_HOME)"
[ ! -d $ZINIT_HOME/.git ] && git clone https://github.com/zdharma-continuum/zinit.git "$ZINIT_HOME"
source "${ZINIT_HOME}/zinit.zsh"

# Set up the prompt
autoload -Uz promptinit
promptinit

setopt histignorealldups sharehistory

# Use emacs keybindings even if our EDITOR is set to vi
bindkey -e

HISTSIZE=5000
SAVEHIST=5000
HISTFILE=~/.zsh_history
setopt sharehistory
setopt hist_ignore_space
setopt hist_ignore_all_dups
setopt hist_save_no_dups
setopt hist_ignore_dups
setopt hist_find_no_dups

# Set the cuda path
export PATH=/usr/local/cuda/bin${PATH:+:${PATH}}
export LD_LIBRARY_PATH=/usr/local/cuda/lib64${LD_LIBRARY_PATH:+:${LD_LIBRARY_PATH}}

# Added Homebrew
eval "$(/home/linuxbrew/.linuxbrew/bin/brew shellenv)"

# Add ohmyposh
eval "$(oh-my-posh init zsh --config /home/whilebell/.config/ohmyposh/whilebell.omp.json)"

# Aliases
alias l='eza -la --icons' 
alias vim='nvim'
alias cls='clear'
alias tree="find . -type d -not -path '*/\.*' | sort | sed -e 's;[^/]*/;│   ;g;s;│ *$;└───;'"
alias update="sudo apt update && sudo apt upgrade -y"
alias lg="lazygit"
alias ca="conda activate"
alias tm="tmux"
alias winf="explorer.exe"

# Add in zsh plugin
zinit light zsh-users/zsh-syntax-highlighting
zinit light zsh-users/zsh-completions
zinit light zsh-users/zsh-autosuggestions
zinit light Aloxaf/fzf-tab


# Completion styling
zstyle ':completion:*' matcher-list 'm:{a-z}={A-Za-z}'
zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'ls --color $realpath'
zstyle ':fzf-tab:complete:__zoxide_z:*' fzf-preview 'ls --color $realpath'

# Shell integrations
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
eval "$(zoxide init --cmd cd zsh)"

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/home/whilebell/miniconda3/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/home/whilebell/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/home/whilebell/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/home/whilebell/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

clear
