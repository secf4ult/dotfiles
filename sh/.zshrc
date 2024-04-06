# set dotfiles env
export DOTFILES="$HOME/.dotfiles"
# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
# bun completions
[ -s "/Users/yuxiao/.bun/_bun" ] && source "/Users/yuxiao/.bun/_bun"
# volta
export VOLTA_HOME="$HOME/.volta"
export PATH="$VOLTA_HOME/bin:$PATH"
# homebrew completions
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:${FPATH}"

  autoload -Uz compinit
  compinit
fi

# Aliases
source "$DOTFILES/sh/.zsh_aliases"
