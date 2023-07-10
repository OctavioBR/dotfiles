# PATH="/usr/local/sbin:/usr/local/bin:/usr/sbin:/usr/bin:/sbin:/bin"
export LC_ALL=en_US.UTF-8
export LANG=en_US.UTF-8
export GTK_IM_MODULE=cedilla
export TERM="xterm-256color"
export SSH_KEY_PATH="~/.ssh/id_ed25519"
export MICRO_TRUECOLOR=1

# Node
NPM_PACKAGES="$HOME/.npm-packages"
PATH="$NPM_PACKAGES/bin:$PATH"
MANPATH="$MANPATH:$NPM_PACKAGES/share/man"
# Load NVM
export NVM_DIR="$HOME/.nvm"
[ -s "/opt/homebrew/opt/nvm/nvm.sh" ] && \. "/opt/homebrew/opt/nvm/nvm.sh"

# Go workspace
export GOPATH="$HOME/Code/go"
PATH="$GOPATH/bin:$PATH"

# Python pip
PATH="$HOME/.local/bin:$PATH"

# Krew
PATH="${KREW_ROOT:-$HOME/.krew}/bin:$PATH"

# Rancher desktop
[ -d $HOME/.rd/bin ] && PATH="$PATH:$HOME/.rd/bin"
export LIMA_HOME="$HOME/Library/Application Support/rancher-desktop/lima"

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

# Load zsh-syntax-highlighting from brew
export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR="/opt/homebrew/share/zsh-syntax-highlighting/highlighters"
