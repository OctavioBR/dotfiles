export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME=""
plugins=(git docker)
REPORTTIME=3 # http://zsh.sourceforge.net/Doc/Release/Parameters.html

# https://docs.brew.sh/Shell-Completion#configuring-completions-in-zsh
if type brew &>/dev/null
then
  FPATH="$(brew --prefix)/share/zsh/site-functions:$FPATH"
fi
if [ -x "$(command -v rbenv)" ]; then
  eval "$(rbenv init - zsh)"
fi

source $ZSH/oh-my-zsh.sh
# Pure theme - https://github.com/sindresorhus/pure#oh-my-zsh
autoload -Uz promptinit; promptinit
prompt pure


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
alias dm=docker-machine
alias kb=kubectl
alias kbcat="cat <<EOF | kubectl create -f -"
alias kbnodes="kubectl get nodes -o custom-columns='TYPE:metadata.labels.type,ZONE:metadata.labels.failure-domain\.beta\.kubernetes\.io/zone,INSTANCE_TYPE:metadata.labels.beta\.kubernetes\.io/instance-type,CPUs:metadata.labels.karpenter\.k8s\.aws/instance-cpu,MEMORY:metadata.labels.karpenter\.k8s\.aws/instance-memory,PODS:metadata.labels.karpenter\.k8s\.aws/instance-pods,NAME:metadata.name'"
alias neat="kubectl neat | yq"
alias dci="docker rmi -f $(docker images --filter 'dangling=true' -q | tr '\n' ' ')" # → docker system prune

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
source /opt/homebrew/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
[[ $commands[kubectl] ]] && source <(kubectl completion zsh)
