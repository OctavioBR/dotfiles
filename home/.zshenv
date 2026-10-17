# PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
# export LANGUAGE=en_US
# export GTK_IM_MODULE=cedilla
# export GPG_TTY=$(tty) # For WSL2
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export TERM="xterm-256color"
export SSH_KEY_PATH="~/.ssh/id_ed25519"
export MICRO_TRUECOLOR=1

# Load NVM
export NVM_DIR="$HOME/.nvm"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"
[ -s "$NVM_DIR/bash_completion" ] && \. "$NVM_DIR/bash_completion"

# Node
NPM_PACKAGES="$HOME/.npm-packages"
PATH="$NPM_PACKAGES/bin:$PATH"
MANPATH="$MANPATH:$NPM_PACKAGES/share/man"

# Go bin & GOPATH
[ -d "/usr/local/go/bin" ] && PATH="$PATH:/usr/local/go/bin"
[ -d "$HOME/Code/go" ] && export GOPATH="$HOME/Code/go"
[ -d "$GOPATH/bin" ] && PATH="$PATH:$GOPATH/bin"

# Python pip
PATH="$HOME/.local/bin:$PATH"

# Krew
PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# Pulumi
[ -d "$HOME/.pulumi/bin" ] && PATH="$PATH:$HOME/.pulumi/bin"

# Java
export SDKMAN_DIR="$HOME/.sdkman"
[[ -s "$HOME/.sdkman/bin/sdkman-init.sh" ]] && source "$HOME/.sdkman/bin/sdkman-init.sh"

# Open terminal links in win browser (depends on wslu)
export BROWSER=wslview

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
