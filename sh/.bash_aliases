# navigation
# inspired by @pauliris
alias ..='cd ..'
alias ...='cd ../..'
alias ....='cd ../../..'
alias .....='cd ../../../..'

# file manipulation
alias mv='mv -v'
alias rmf='rm -f'
alias rmrf='rm -rf'
alias cp='cp -v'

# list
alias l='ls -lGCFh'
alias la='ls -lGaFh'
alias ld='ls -lGhd'
alias ll='ls -lGhF'
alias lls='ls -lGhs'

# directory
alias p='pwd'

# tar
alias tarz='tar -xvzf'
alias tarj='tar -xvjf'

function cd {
  builtin cd "$@" && l;
}
alias cd=cd

# vim
alias v='vim'

# alias info='info --vi-keys'

# enable color support of ls and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    alias ls='ls --color=auto'
    alias dir='dir --color=auto'
    alias vdir='vdir --color=auto'

    alias grep='grep --color=auto'
    alias fgrep='fgrep --color=auto'
    alias egrep='egrep --color=auto'
fi

# edit rc file
alias bashrc='$EDITOR ~/.bashrc'
alias zshrc='$EDITOR ~/.zshrc'
alias vimrc='$EDITOR ~/.vimrc'

# tmux
alias tmux='nocorrect tmux'
alias tn='tmux new'
alias tas='ta -A -s'

# xargs
alias xt='xargs -t'
alias xp='xargs -p'

# sed
alias sede='sed -r'

# git
alias g='git'
alias gs='git status'
alias gpu='git push'
alias gpl='git pull --rebase --autostash'

# docker
# maven
alias dmvn='docker run --rm -v "$(pwd)":/usr/src/mymaven -v mvn-repo:/root/.m2 -w /usr/src/mymaven maven mvn'
