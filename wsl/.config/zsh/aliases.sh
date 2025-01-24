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

# Execute kubectl proxyed by port 8002
function kbp() { HTTPS_PROXY=127.0.0.1:8002 command kubectl "$@" }

# Download the file and extract its contents in the current directory
function wgettz() { wget -qO- "$1" | tar -xzv }

# Swich aws-cli profiles
function awsp() { [ -z "$1" ] && echo $AWS_PROFILE || export AWS_PROFILE=$1 }

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
alias neat="kubectl neat | yq eval -P"
alias dci="docker rmi -f $(docker images --filter 'dangling=true' -q | tr '\n' ' ')" # → docker system prune

# Fix terraform aws-cli output requirement
alias terraform="AWS_DEFAULT_OUTPUT=json terraform $1"
alias tfgrapth="terraform plan -out=plan && terraform show -json plan > plan.ignored.tfgraph && rm plan"

# WSL2 ports
alias pbcopy="clip.exe"

# Project home links
alias github='cd ~/Code/github.com'
