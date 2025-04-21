# Yarn query latest package release
function yarn-latest() { yarn info $1 dist-tags.latest }

# Remove all .DS_Store from folder and sub-folders
function clean-ds-store() { find . -name '.DS_Store' -type f -delete }

# Create dir and cd into it
function mkcdir() { mkdir -p -- "$1" && cd -P -- "$1" }

# If file is sybolic link, print relative destination path
function whichl() { readlink $(which $1) }

# Download the file and extract its contents in the current directory
function wgettz() { wget -qO- "$1" | tar -xzv }

# Swich aws-cli profiles
function awsp() { [ -z "$1" ] && echo $AWS_PROFILE || export AWS_PROFILE=$1 }

# Kubernetes
function kbp() { HTTPS_PROXY=127.0.0.1:8002 command kubectl "$@" }
function kbx() { [ "$1" ] && kubectl config use-context $1 || echo "$(kubectl config current-context)/$(kubectl config view --minify -o jsonpath='{..namespace}')"; }
function kbn() { [ "$1" ] && kubectl config set-context --current --namespace $1 || kubectl config view --minify | grep namespace | cut -d" " -f6; }
function kbnodes() {
  kubectl get nodes -o json | jq -r '
  def since($time):
    (now - ($time | fromdate)) as $diff |
    if $diff > 86400 then "\(( $diff / 86400 ) | floor)d"
    elif $diff > 3600 then "\(( $diff / 3600 ) | floor)h"
    else "\(( $diff / 60 ) | floor)m"
    end;

  ["NAME", "NODE-TYPE", "AGE", "STATUS", "INSTANCE_TYPE", "CPUs", "MEMORY"],
  (
    .items
    | sort_by(.metadata.creationTimestamp | fromdate)
    | .[]
    | [
        .metadata.name,
        (.metadata.labels["node-type"] // "N/A"),
        since(.metadata.creationTimestamp),
        (.status.conditions[] | select(.type=="Ready") | .type),
        (.metadata.labels["beta.kubernetes.io/instance-type"] // .metadata.labels["node.kubernetes.io/instance-type"] // "N/A"),
        .status.capacity.cpu,
        (.status.capacity.memory | sub("Ki"; "") | tonumber / 1024 / 1024 | floor | tostring + "Gi")
      ]
  )
  | @tsv' | column -t
}

# Fix corrupt .zsh_history
function fix-zsh-history() {
  mv ~/.zsh_history ~/.zsh_history_corrupt
  strings ~/.zsh_history_corrupt > ~/.zsh_history
  fc -R ~/.zsh_history
  rm ~/.zsh_history_corrupt
}

# Custom Aliases
alias ll="ls -l"
alias la="ls -A"
alias h=history
alias dus="du -sh * | sort -rh"
alias tarzip="tar -czvf"
alias tunzip="tar -xzvf"
alias matrix="cmatrix -b"
alias awsme="aws sts get-caller-identity --no-cli-pager"
alias yqp="yq eval -P"

# Python
alias pyserve="python3.13 -m http.server"
alias pip="python3.13 -m pip"
alias py="python3.13"

# Docker & Kubernetes
alias dps="docker ps --format \"{{.Names}}\t\t{{.Image}}  {{.Status}}\""
alias dpa="docker ps --format \"{{.Names}}\t\t{{.Image}}  {{.Status}}\" -a"
alias dcl="docker ps -a | grep Exit | cut -d ' ' -f 1 | xargs docker rm"
alias dcp=docker-compose
alias kb=kubectl
alias kbcat="cat <<EOF | kubectl create -f -"
alias neat="kubectl neat | yq eval -P"

# alias dci="docker rmi -f $(docker images --filter 'dangling=true' -q | tr '\n' ' ')" # → docker system prune

# Fix terraform aws-cli output requirement
alias terraform="AWS_DEFAULT_OUTPUT=json terraform $1"
alias tfgrapth="terraform plan -out=plan && terraform show -json plan > plan.ignored.tfgraph && rm plan"
alias tf=terraform
alias pl=pulumi

# WSL2 ports
alias pbcopy="clip.exe"

# Project home links
alias github='cd ~/Code/github.com'
