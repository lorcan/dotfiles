ZSH=$HOME/.oh-my-zsh
ZSH_THEME="robbyrussell"

# Which plugins would you like to load? (plugins can be found in ~/.oh-my-zsh/plugins/*)
# Custom plugins may be added to ~/.oh-my-zsh/custom/plugins/
# Example format: plugins=(rails git textmate ruby lighthouse)
plugins=(git ruby macos rails)

source $ZSH/oh-my-zsh.sh
unsetopt correct
unsetopt correct_all

# User configuration
export PATH="/usr/local/bin:/usr/bin:/bin:/usr/sbin:/sbin:/usr/local/bin"

alias et='ember test --server'
alias es='ember s'
alias bs='bundle exec rspec'
alias be='bundle exec'
alias rly='bundle install; rake db:migrate; gco db/schema.rb; touch tmp/restart.txt'

ulimit -n 4096

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

export PATH=$HOME/bin:$PATH

export PATH="$HOME/.yarn/bin:$PATH"

export INTERCOM_USER=lorcan

if [ -f "$HOME/.pilot/bin/pilot" ]; then
	export PATH="$HOME/.pilot/bin:$PATH"
	eval $(pilot env)
fi

if [ -d "$HOME/.rbenv/shims" ]; then
	export PATH="$HOME/.rbenv/shims:$PATH"
	eval "$(rbenv init -)"
fi

