export ZSH=/home/octavio/.oh-my-zsh

ZSH_THEME=""
plugins=(git docker zsh-syntax-highlighting)

REPORTTIME=3 # http://zsh.sourceforge.net/Doc/Release/Parameters.html

source $ZSH/oh-my-zsh.sh
# Pure theme - https://github.com/sindresorhus/pure#oh-my-zsh
fpath+=('/home/octavio/.npm-packages/lib/node_modules/pure-prompt/functions')
autoload -U promptinit; promptinit
prompt pure

# Custom Aliases
alias ll="ls -l"
alias la="ls -A"
alias h=history
alias dus="du -sh * | sort -rh"
alias tarzip="tar -czvf"
alias tunzip="tar -xzvf"
alias pyserve="python -m SimpleHTTPServer"

alias update="sudo apt update && apt list --upgradable"
alias upgrade="sudo apt upgrade"

# alias pbcopy="xclip -selection clipboard"
# alias pbpaste="xclip -o"
alias pbcopy="clip.exe"

# WSL 2
alias explorer="explorer.exe"
alias term="wt.exe"

# Docker & Kubernetes
alias dps="docker ps --format \"{{.Names}}\t\t{{.Image}}  {{.Status}}\""
alias dpa="docker ps --format \"{{.Names}}\t\t{{.Image}}  {{.Status}}\" -a"
alias dcl="docker ps -a | grep Exit | cut -d ' ' -f 1 | xargs docker rm"
# alias dci="docker rmi -f $(docker images --filter 'dangling=true' -q | tr '\n' ' ')" → docker system prune
alias dcp=docker-compose
alias dm=docker-machine
alias kb=kubectl
alias kbctx="kubectl config current-context"
alias kbcat="cat <<EOF | kubectl create -f -"
# VirtualBox
# alias vbm=VBoxManage
# alias vbh=VBoxHeadless

# Project home links
alias github='cd ~/Code/github'

# Yarn query latest package release
function yarn-latest() { yarn info $1 dist-tags.latest }

function clean-ds-store() { find . -name '.DS_Store' -type f -delete }

function mkcdir() { mkdir -p -- "$1" && cd -P -- "$1" }

function kbp() { HTTPS_PROXY=127.0.0.1:8002 command kubectl "$@" }
unalias gke
function gke() {
  port="8002"
  cluster="gkeblack"
  if [[ $2 =~ ^(gkewhite|white)$ ]]; then cluster="gkewhite"; fi

  pid=$(lsof -ti :$port)
  if [[ -n $pid ]]; then kill $pid; fi

  if [[ $1 == "dev" ]]; then
    gcloud container clusters get-credentials "platform-appserver-$cluster-dev-cluster" \
      --internal-ip --project=platform-appserver-dev-4325 --region=us-east1
    gcloud compute ssh "platform-edge-bastion-dev-vm-1" --project=platform-edge-dev-9367 -- -fNL $port:127.0.0.1:8888
  fi
  if [[ $1 == "prd" ]]; then
    gcloud container clusters get-credentials "platform-appserver-$cluster-prd-cluster" \
      --internal-ip --project=platform-appserver-prd-6828 --region=us-east1
    gcloud compute ssh "platform-edge-bastion-prd-vm-1" --project=platform-edge-prd-7459 -- -fNL $port:127.0.0.1:8888
  fi
}

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
# K8s completions
#source <(kubectl completion zsh)
# Helm completion
#source <(helm completion zsh)
