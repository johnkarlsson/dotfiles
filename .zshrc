# Path to your oh-my-zsh configuration.
ZSH=$HOME/.oh-my-zsh

# Set name of the theme to load.
# Look in ~/.oh-my-zsh/themes/
# Optionally, if you set this to "random", it'll load a random theme each
# time that oh-my-zsh is loaded.
ZSH_THEME="juanghurtado"

# Example aliases
# alias zshconfig="mate ~/.zshrc"
# alias ohmyzsh="mate ~/.oh-my-zsh"

# Set to this to use case-sensitive completion
CASE_SENSITIVE="true"

# Uncomment this to disable bi-weekly auto-update checks
# DISABLE_AUTO_UPDATE="true"

# Uncomment to change how often before auto-updates occur? (in days)
# export UPDATE_ZSH_DAYS=13

# Uncomment following line if you want to disable colors in ls
# DISABLE_LS_COLORS="true"

# Uncomment following line if you want to disable autosetting terminal title.
DISABLE_AUTO_TITLE="true"

# Uncomment following line if you want to disable command autocorrection
DISABLE_CORRECTION="true"

# Uncomment following line if you want red dots to be displayed while waiting for completion
COMPLETION_WAITING_DOTS="true"

# Uncomment following line if you want to disable marking untracked files under
# VCS as dirty. This makes repository status check for large repositories much,
# much faster.
# DISABLE_UNTRACKED_FILES_DIRTY="true"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
export EDITOR=nvim

export LC_ALL=sv_SE.utf8
# export LANG=sv_SE.utf8

export SSH_AUTH_SOCK="$GNOME_KEYRING_CONTROL/ssh"

plugins=(git zsh-syntax-highlighting history-substring-search)

source $ZSH/oh-my-zsh.sh

# ulimit -n 10240 # Max number of open file handles

bindkey -v
# source ~/.oh-my-zsh/custom/plugins/zle_vi_visual/zle_vi_visual.zsh

# bind k and j for VI mode
bindkey -M vicmd 'k' history-substring-search-up
bindkey -M vicmd 'j' history-substring-search-down
bindkey -M viins '^k' history-substring-search-up
bindkey -M viins '^j' history-substring-search-down
bindkey '^r' history-incremental-search-backward
# bind UP and DOWN arrow keys
zmodload zsh/terminfo
bindkey "$terminfo[kcuu1]" history-substring-search-up
bindkey "$terminfo[kcud1]" history-substring-search-down

alias redshift='redshift -l 57.708549:11.975098&'
alias nipython='ipython notebook --pylab inline'
alias qipython='ipython qtconsole --pylab=inline --colors=linux'
alias nipython3='ipython3 notebook --pylab inline'
alias qipython3='ipython3 qtconsole --pylab=inline --colors=linux'
alias ls='ls --color=tty --group-directories-first'
setopt nohup
alias g++='g++ -std=c++11'
# alias netris='netris -i 0.122 -k "hkl jspf^ln"'
export GREP_OPTIONS='-P --color=auto'
alias cls='for i in `seq 1 1000`; do echo ""; done'

alias ack='ack-grep'

dt() {
    if [ "$#" -eq 0 ]; then
        git difftool
    elif [ "$#" -eq 1 ]; then
        if git status | grep -q $1
        then
            git difftool $1
        else
            git difftool $(git whatchanged | grep "\t$1" | head -n 1 | awk '{print $3,$4}' | sed 's/\.//g')
        fi
    else
        for var; do dt $var; done;
    fi
}

alias g='_g'
_g() {
    if [ -d .git ]; then
        git status
    else
        foo=$PWD;
        for subdir in *; do
            if [ -d "$subdir/.git" ]; then
                echo " "
                echo $subdir
                cd $subdir
                git status -sb
                cd $foo
            fi
        done
    fi
}

source ~/.zshrc_extras
alias vi=nvim
alias vim=nvim
alias vimdiff='nvim -d -R'
alias gcal=gcalcli
alias trim="sed -r -e 's/^\s+//' -e 's/\s+/ /g'"
alias gg="git log --graph --oneline --format='%C(yellow)%h%Creset%C(auto)%d%Creset %s %C(cyan)(%an, %ar)%Creset' --all"
alias gm="git log --graph --merges --format='%C(yellow)%h%Creset%C(auto)%d%Creset %C(cyan)%ar%Creset %b' --first-parent origin/master"
alias gl='gg --stat'
# alias gg='git log --graph --decorate --oneline --all'

alias nowrap='cut -b 1-$COLUMNS'
alias scut='cut -d " "'
alias ccut='cut -d ","'
alias acut='cut -d ""'
alias mm='awk "{ if (!min || \$0 < min) { min = \$0; }; if (\$0 > max) { max = \$0; }; } END { print min; print max; }"'

# Kill all local unused sessions
tmux ls | grep -v '(attached)' | grep -o '^[^:]+' | xargs -I{} tmux kill-session -t {}

alias hoogle='hoogle --color'

function ssh { /usr/bin/ssh -t "$@" "tmux a -t foo || tmux new -s foo" }
function scp_tmux_conf {
    scp =(grep -vh 'tmux.reset.conf' ~/dotfiles/.tmux{.reset,}.conf) \
        $1:.tmux.conf
}
