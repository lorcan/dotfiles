ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"
plugins=(git ruby macos rails)
source $ZSH/oh-my-zsh.sh

unsetopt correct
unsetopt correct_all
ulimit -n 4096

export PATH="/opt/homebrew/bin:/opt/homebrew/sbin:$HOME/bin:$HOME/.yarn/bin:/usr/local/bin:/usr/local/sbin:/usr/bin:/bin:/usr/sbin:/sbin:$PATH"

if [ -f "$HOME/.pilot/bin/pilot" ]; then
	export PATH="$HOME/.pilot/bin:$PATH"
	eval $(pilot env)
fi

if [ -d "$HOME/.rbenv/shims" ]; then
	export PATH="$HOME/.rbenv/shims:$PATH"
	eval "$(rbenv init -)"
fi

export PNPM_HOME="$HOME/Library/pnpm"
case ":$PATH:" in
  *":$PNPM_HOME:"*) ;;
  *) export PATH="$PNPM_HOME:$PATH" ;;
esac

export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

export NVM_DIR="$HOME/.nvm" && [ -s "$NVM_DIR/nvm.sh" ] && . "$NVM_DIR/nvm.sh"

autoload -U add-zsh-hook
load-nvmrc() {
  local node_version="$(nvm version)"
  local nvmrc_path="$(nvm_find_nvmrc)"
  if [ -n "$nvmrc_path" ]; then
    local nvmrc_node_version=$(nvm version "$(cat "${nvmrc_path}")")
    if [ "$nvmrc_node_version" != "N/A" ] && [ "$nvmrc_node_version" != "$node_version" ]; then
      nvm use
    fi
  elif [ "$node_version" != "$(nvm version default)" ]; then
    echo "Reverting to nvm default version"
    nvm use default
  fi
}
add-zsh-hook chpwd load-nvmrc
load-nvmrc
