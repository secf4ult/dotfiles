# homebrew
export PATH=/opt/homebrew/bin:$PATH

# Enable Powerlevel10k instant prompt. Should stay close to the top of ~/.zshrc.
# Initialization code that may require console input (password prompts, [y/n]
# confirmations, etc.) must go above this block; everything else may go below.
if [[ -r "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh" ]]; then
  source "${XDG_CACHE_HOME:-$HOME/.cache}/p10k-instant-prompt-${(%):-%n}.zsh"
fi

# antidote
if brew list antidote &> /dev/null;then
  export HOMEBREW_PREFIX="$(brew --prefix)"
  source $HOMEBREW_PREFIX/opt/antidote/share/antidote/antidote.zsh
  antidote load ${ZDOTDIR:-$HOME}/.zsh_plugins.txt
fi

# set dotfiles env
export DOTFILES="$HOME/.dotfiles"

# volta
if command -v volta &> /dev/null;then
  export VOLTA_HOME="$HOME/.volta"
  export PATH="$VOLTA_HOME/bin:$PATH"
fi

# java
if command -v java &> /dev/null;then
  export JAVA_HOME="/opt/homebrew/opt/openjdk"
  export PATH="$JAVA_HOME/bin:$PATH"
fi

# homebrew completions
if command -v brew &> /dev/null;then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

# rust
if command -v rustc &> /dev/null;then
  export PATH="$HOME/.cargo/bin:$PATH"
fi

# Aliases
source "$DOTFILES/sh/.zsh_aliases"

# To customize prompt, run `p10k configure` or edit ~/.p10k.zsh.
[[ ! -f ~/.p10k.zsh ]] || source ~/.p10k.zsh

# run tmux on start-up
if command -v tmux &> /dev/null && # if tmux existed
    [ -n "$PS1" ] &&               # if interactive shell
    [[ ! "$TERM" =~ screen ]] &&
    [[ ! "$TERM" =~ tmux ]] &&
    [ -z "$TMUX" ];then            # if tmux already runed
  exec tmux
fi