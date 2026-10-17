# PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
# export GTK_IM_MODULE="cedilla gtk3-demo"
# export QT_IM_MODULE=cedilla
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
# export LANGUAGE=en_US
export TERM="xterm-256color"
export SSH_KEY_PATH="~/.ssh/id_ed25519"
export MICRO_TRUECOLOR=1
export LESSCHARSET="utf-8"

# Load NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Node
NPM_PACKAGES="$HOME/.npm-packages"
PATH="$NPM_PACKAGES/bin:$PATH"
MANPATH="$MANPATH:$NPM_PACKAGES/share/man"

# Go bin & GOPATH
GOPATH="$HOME/go"
[ -d "/usr/local/go/bin" ] && PATH="$PATH:/usr/local/go/bin"
[ -d "$GOPATH/bin" ] && PATH="$PATH:$GOPATH/bin"

# Python pip
PATH="$HOME/.local/bin:$PATH"

# Krew
PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# tfswitch
PATH="$PATH:$HOME/bin"

# opencode
PATH="$HOME/.opencode/bin:$PATH"

# Pulumi
[ -d "$HOME/.pulumi/bin" ] && PATH="$PATH:$HOME/.pulumi/bin"

# Java
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

export PATH
export MANPATH

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='micro'
else
  export EDITOR='micro'
fi
# Emacs alternate editor
export ALTERNATE_EDITOR=micro

[ -s "$HOME/.secretenv" ] && source "$HOME/.secretenv"
