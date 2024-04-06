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
alias l='ls -lCFh'
alias la='ls -laFh'
alias ld='ls -lhd'
alias ll='ls -lhF'
alias lls='ls -lhs'

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

# lazy load rbenv
rbenv() {
    if [[ -z $RBENV_ROOT ]] ; then
        unset -f rbenv
        export RBENV_ROOT=${RBENV_ROOT:=${HOME}/.rbenv}
        export PATH=${RBENV_ROOT}/bin:$PATH
        source $RBENV_ROOT/completions/rbenv.zsh
        eval "$(command rbenv init -)"
        rbenv $@
    fi
}

# lazy load pyenv
pyenv() {
    if [[ -z $PYENV_ROOT ]]; then
        unset -f pyenv
        export PYENV_ROOT=${PYENV_ROOT:=${HOME}/.pyenv}
        export PATH=${PYENV_ROOT}/bin:$PATH
        eval "$(command pyenv init -)"
        pyenv $@

        # >>> conda initialize >>>
        # !! Contents within this block are managed by 'conda init' !!
        __conda_setup="$('/Users/yuxiao/.pyenv/versions/miniconda3-latest/bin/conda' 'shell.zsh' 'hook' 2> /dev/null)"
        if [ $? -eq 0 ]; then
            eval "$__conda_setup"
        else
            if [ -f "/Users/yuxiao/.pyenv/versions/miniconda3-latest/etc/profile.d/conda.sh" ]; then
                . "/Users/yuxiao/.pyenv/versions/miniconda3-latest/etc/profile.d/conda.sh"
            else
                export PATH="/Users/yuxiao/.pyenv/versions/miniconda3-latest/bin:$PATH"
            fi
        fi
        unset __conda_setup
        # <<< conda initialize <<<

    fi
}

# lazy load node
nodeinit() {
    if [[ -z $NODENV_ROOT ]]; then
        unset -f nodeinit node npm yarn
        export NODENV_ROOT=${NODENV_ROOT:=${HOME}/.nodenv}
        export PATH=${NODENV_ROOT}/bin:$PATH
        eval "$(command nodenv init -)"
    fi
}

node() {
    if [[ -z $NODENV_ROOT ]]; then
        nodeinit
        node $@
    fi
}

npm() {
    if [[ -z $NODENV_ROOT ]]; then
        nodeinit
        npm $@
    fi
}

yarn() {
    if [[ -z $NODENV_ROOT ]]; then
        nodeinit
        yarn $@
    fi
}

# taobao npm mirror
alias cnpm="npm --registry=https://registry.npm.taobao.org \
                --cache=$HOME/.npm/.cache/cnpm \
                --disturl=https://npm.taobao.org/dist \
                --userconfig=$HOME/.cnpmrc"

