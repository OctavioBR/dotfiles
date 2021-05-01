#PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export GTK_IM_MODULE=cedilla
export TERM="xterm-256color"

export MICRO_TRUECOLOR=1

# Node
NPM_PACKAGES="$HOME/.npm-packages"
PATH="$NPM_PACKAGES/bin:$PATH"
MANPATH="$MANPATH:$NPM_PACKAGES/share/man"

# Go workspace
# export GOPATH="$HOME/Code/go"
# PATH="$GOPATH/bin:$PATH"

# Python pip
# PATH="$HOME/.local/bin:$PATH"

export PATH
export MANPATH
export TERM="xterm-256color" #Term theming

# Preferred editor for local and remote sessions
if [[ -n $SSH_CONNECTION ]]; then
  export EDITOR='micro'
else
  export EDITOR='micro'
fi
# Emacs alternate editor
export ALTERNATE_EDITOR=micro

export SSH_KEY_PATH="~/.ssh/id_ed25519"
