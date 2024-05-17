REPORTTIME=3 # http://zsh.sourceforge.net/Doc/Release/Parameters.html

# Pure theme - https://github.com/sindresorhus/pure#oh-my-zsh
if [ -d "$HOME/.zsh/pure" ]; then
  fpath+=($HOME/.zsh/pure)
  autoload -Uz promptinit; promptinit
  prompt pure
fi

zsh_syntax_highlighting="/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
[ -f $zsh_syntax_highlighting ] && source $zsh_syntax_highlighting
# export ZSH_HIGHLIGHT_HIGHLIGHTERS_DIR="/opt/homebrew/share/zsh-syntax-highlighting/highlighters"

if [ -x "$(command -v rbenv)" ]; then
  eval "$(rbenv init - zsh)"
fi

# Custom Aliases
alias ll="ls -l"
alias la="ls -A"
alias h=history
alias dus="du -sh * | sort -rh"
alias tarzip="tar -czvf"
alias tunzip="tar -xzvf"
alias pyserve="python -m SimpleHTTPServer"
alias matrix="cmatrix -b"
alias awsme="aws sts get-caller-identity --no-cli-pager"

# Docker & Kubernetes
alias dps="docker ps --format \"{{.Names}}\t\t{{.Image}}  {{.Status}}\""
alias dpa="docker ps --format \"{{.Names}}\t\t{{.Image}}  {{.Status}}\" -a"
alias dcl="docker ps -a | grep Exit | cut -d ' ' -f 1 | xargs docker rm"
alias dcp=docker-compose
alias kb=kubectl
alias kbcat="cat <<EOF | kubectl create -f -"
alias kbnodes="kubectl get nodes -o custom-columns='TYPE:metadata.labels.type,ZONE:metadata.labels.failure-domain\.beta\.kubernetes\.io/zone,INSTANCE_TYPE:metadata.labels.beta\.kubernetes\.io/instance-type,CPUs:metadata.labels.karpenter\.k8s\.aws/instance-cpu,MEMORY:metadata.labels.karpenter\.k8s\.aws/instance-memory,PODS:metadata.labels.karpenter\.k8s\.aws/instance-pods,NAME:metadata.name'"
alias neat="kubectl neat | yq"
# alias dci="docker rmi -f $(docker images --filter 'dangling=true' -q | tr '\n' ' ')" # → docker system prune

# Project home links
alias github='cd ~/Code/github'

# Print current kubectl active context & namespace
function kbctx() { echo "$(kubectl config current-context)/$(kubectl config view --minify -o jsonpath='{..namespace}')" }
# Yarn query latest package release
function yarn-latest() { yarn info $1 dist-tags.latest }
# Remove all .DS_Store from folder and sub-folders
function clean-ds-store() { find . -name '.DS_Store' -type f -delete }
# Create dir and cd into it
function mkcdir() { mkdir -p -- "$1" && cd -P -- "$1" }
# If file is sybolic link, print relative destination path
function whichl() { readlink $(which $1) }
# Prisma cloud scan
function imagescan() {
  RED_B='\033[1;31m' GRN_U='\033[4;32m' NC='\033[0m'
  if [[ -z $TOKEN ]]; then
    echo "export ${RED_B}TOKEN$NC from ${GRN_U}https://app3.prismacloud.io/compute?computeState=%2Fmanage%2Fsystem%2Futilities"
    return 1
  fi
  twistcli images scan --address="https://us-west1.cloud.twistlock.com/us-3-159244885" --user="octavio.richter@fundingcircle.com" --token="$TOKEN" $1
}

# Lint dockerfile with https://github.com/hadolint/hadolint
# function hadolint() { docker run --rm --interactive hadolint/hadolint:v1.23.0-8-gb01c5a9 < "$@" }
# function kbp() { HTTPS_PROXY=127.0.0.1:8002 command kubectl "$@" }

# Tilix fixes to open tiles in same PWD
# if [ $TILIX_ID ] || [ $VTE_VERSION ]; then
#   source /etc/profile.d/vte.sh
# fi
# function custom_prompt() {
#   __git_ps1 "\[\033[0;31m\]\u \[\033[0;36m\]\h:\w\[\033[00m\]" " \n\[\033[0;31m\]>\[\033[00m\] " " %s"
#   VTE_PWD_THING="$(__vte_osc7)"
#   PS1="$PS1$VTE_PWD_THING"
# }
# PROMPT_COMMAND=custom_prompt

# NPM completion
#source <(npm completion)
# Helm completion
#source <(helm completion zsh)

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[[ $commands[kubectl] ]] && source <(kubectl completion zsh)

# https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/lib/directories.zsh
setopt auto_cd
setopt auto_pushd
setopt pushd_ignore_dups
setopt pushdminus
alias -g ...='../..'
alias -g ....='../../..'
alias -g .....='../../../..'
alias -g ......='../../../../..'

#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#-#
# Use emacs key bindings
bindkey -e

# [PageUp] - Up a line of history
if [[ -n "${terminfo[kpp]}" ]]; then
  bindkey -M emacs "${terminfo[kpp]}" up-line-or-history
  bindkey -M viins "${terminfo[kpp]}" up-line-or-history
  bindkey -M vicmd "${terminfo[kpp]}" up-line-or-history
fi
# [PageDown] - Down a line of history
if [[ -n "${terminfo[knp]}" ]]; then
  bindkey -M emacs "${terminfo[knp]}" down-line-or-history
  bindkey -M viins "${terminfo[knp]}" down-line-or-history
  bindkey -M vicmd "${terminfo[knp]}" down-line-or-history
fi

# Start typing + [Up-Arrow] - fuzzy find history forward
autoload -U up-line-or-beginning-search
zle -N up-line-or-beginning-search

bindkey -M emacs "^[[A" up-line-or-beginning-search
bindkey -M viins "^[[A" up-line-or-beginning-search
bindkey -M vicmd "^[[A" up-line-or-beginning-search
if [[ -n "${terminfo[kcuu1]}" ]]; then
  bindkey -M emacs "${terminfo[kcuu1]}" up-line-or-beginning-search
  bindkey -M viins "${terminfo[kcuu1]}" up-line-or-beginning-search
  bindkey -M vicmd "${terminfo[kcuu1]}" up-line-or-beginning-search
fi

# Start typing + [Down-Arrow] - fuzzy find history backward
autoload -U down-line-or-beginning-search
zle -N down-line-or-beginning-search

bindkey -M emacs "^[[B" down-line-or-beginning-search
bindkey -M viins "^[[B" down-line-or-beginning-search
bindkey -M vicmd "^[[B" down-line-or-beginning-search
if [[ -n "${terminfo[kcud1]}" ]]; then
  bindkey -M emacs "${terminfo[kcud1]}" down-line-or-beginning-search
  bindkey -M viins "${terminfo[kcud1]}" down-line-or-beginning-search
  bindkey -M vicmd "${terminfo[kcud1]}" down-line-or-beginning-search
fi

# [Home] - Go to beginning of line
if [[ -n "${terminfo[khome]}" ]]; then
  bindkey -M emacs "${terminfo[khome]}" beginning-of-line
  bindkey -M viins "${terminfo[khome]}" beginning-of-line
  bindkey -M vicmd "${terminfo[khome]}" beginning-of-line
fi
# [End] - Go to end of line
if [[ -n "${terminfo[kend]}" ]]; then
  bindkey -M emacs "${terminfo[kend]}"  end-of-line
  bindkey -M viins "${terminfo[kend]}"  end-of-line
  bindkey -M vicmd "${terminfo[kend]}"  end-of-line
fi

# [Shift-Tab] - move through the completion menu backwards
if [[ -n "${terminfo[kcbt]}" ]]; then
  bindkey -M emacs "${terminfo[kcbt]}" reverse-menu-complete
  bindkey -M viins "${terminfo[kcbt]}" reverse-menu-complete
  bindkey -M vicmd "${terminfo[kcbt]}" reverse-menu-complete
fi

# [Backspace] - delete backward
bindkey -M emacs '^?' backward-delete-char
bindkey -M viins '^?' backward-delete-char
bindkey -M vicmd '^?' backward-delete-char
# [Delete] - delete forward
if [[ -n "${terminfo[kdch1]}" ]]; then
  bindkey -M emacs "${terminfo[kdch1]}" delete-char
  bindkey -M viins "${terminfo[kdch1]}" delete-char
  bindkey -M vicmd "${terminfo[kdch1]}" delete-char
else
  bindkey -M emacs "^[[3~" delete-char
  bindkey -M viins "^[[3~" delete-char
  bindkey -M vicmd "^[[3~" delete-char
  bindkey -M emacs "^[3;5~" delete-char
  bindkey -M viins "^[3;5~" delete-char
  bindkey -M vicmd "^[3;5~" delete-char
fi

# [Ctrl-Delete] - delete whole forward-word
bindkey -M emacs '^[[3;5~' kill-word
bindkey -M viins '^[[3;5~' kill-word
bindkey -M vicmd '^[[3;5~' kill-word

# [Ctrl-RightArrow] - move forward one word
bindkey -M emacs '^[[1;5C' forward-word
bindkey -M viins '^[[1;5C' forward-word
bindkey -M vicmd '^[[1;5C' forward-word
# [Ctrl-LeftArrow] - move backward one word
bindkey -M emacs '^[[1;5D' backward-word
bindkey -M viins '^[[1;5D' backward-word
bindkey -M vicmd '^[[1;5D' backward-word

bindkey '\ew' kill-region                        # [Esc-w] - Kill from the cursor to the mark
bindkey -s '\el' 'ls\n'                          # [Esc-l] - run command: ls
bindkey '^r' history-incremental-search-backward # [Ctrl-r] - Search backward incrementally for a specified string. The string may begin with ^ to anchor the search to the beginning of the line.
bindkey ' ' magic-space                          # [Space] - don't do history expansion

# Edit the current command line in $EDITOR
autoload -U edit-command-line
zle -N edit-command-line
bindkey '\C-x\C-e' edit-command-line
