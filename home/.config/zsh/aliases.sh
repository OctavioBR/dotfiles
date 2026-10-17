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

# View files or directories in a user-friendly way
v() {
  if [ -f "$1" ]; then
    LESS=" -R" LESSOPEN="| bat --color=always --plain --paging=never %s" less "$1"
  elif [ -d "$1" ]; then
    ls --almost-all --classify "$1"
  else
    echo "Error: '$1' is neither a file nor a directory." >&2
    return 1
  fi
}

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

devbox() {
  local instance_id="i-05809af7bd4c41881"

  case "$1" in
    start)
      echo "Starting instance $instance_id..."
      aws ec2 start-instances --instance-ids "$instance_id"
      ;;
    stop)
      echo "Stopping instance $instance_id..."
      aws ec2 stop-instances --instance-ids "$instance_id"
      ;;
    status)
      echo "Fetching status for instance $instance_id..."
      aws ec2 describe-instances --instance-ids "$instance_id" --query "Reservations[].Instances[].State.Name"
      ;;
    *)
      echo "Usage: devbox {start|stop|status}"
      ;;
  esac
}

format_json() {
  node -e '
    const input = require("fs").readFileSync(0, "utf8");
    const data = JSON.parse(input);

    function customFormat(obj, indent = 0) {
      const s = "  ".repeat(indent);
      const ns = "  ".repeat(indent + 1);

      if (Array.isArray(obj)) {
        if (obj.length === 0) return "[]";

        // Rule: Fit short string arrays or simple nested arrays on one line
        const isSimpleArray = obj.every(i => typeof i === "string" || (Array.isArray(i) && i.every(j => typeof j === "string")));
        if (isSimpleArray && JSON.stringify(obj).length < 100) {
          return JSON.stringify(obj);
        }

        // Rule: Single object in a list [{ data }]
        // FIXED: Removed the extra curly braces around the inner content
        if (obj.length === 1 && typeof obj[0] === "object" && obj[0] !== null) {
          const inner = customFormat(obj[0], indent + 1).trim();
          return "[{\n" + ns + inner + "\n" + s + "}]";
        }

        // Standard Array
        return "[\n" + obj.map(item => ns + customFormat(item, indent + 1)).join(",\n") + `\n${s}]`;
      }

      if (typeof obj === "object" && obj !== null) {
        const keys = Object.keys(obj);
        if (keys.length === 0) return "{}";
        return "{\n" + keys.map(k => `${ns}"${k}": ${customFormat(obj[k], indent + 1)}`).join(",\n") + `\n${s}}`;
      }

      return JSON.stringify(obj);
    }

    console.log(customFormat(data));
  '
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

alias pbcopy="xclip -selection clipboard"

# Project home links
alias github='cd ~/Code/github.com'
