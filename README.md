# My workstation config 👨‍💻 (Windows)
```powershell
winget install Microsoft.PowerToys --source winget
winget install --id Microsoft.PowerShell --source winget

# Install scoop with utility apps
Set-ExecutionPolicy -ExecutionPolicy RemoteSigned -Scope CurrentUser
Invoke-RestMethod -Uri https://get.scoop.sh | Invoke-Expression
scoop install git
scoop bucket add nerd-fonts
scoop install firacode
scoop bucket add extras
scoop install vscode
reg import "C:\Users\octav\scoop\apps\vscode\current\install-context.reg"
reg import "C:\Users\octav\scoop\apps\vscode\current\install-associations.reg"
scoop install winrar
scoop install hwmonitor

# WSL
wsl --install
wsl --install -d Ubuntu-24.04
wsl --set-default Ubuntu-24.04
```

- [Tweak WSL automount](https://superuser.com/a/1295442)

on WSL:
```sh
# sudores withouth password
sudo visudo
# add on last line:
octavio ALL=(ALL) NOPASSWD: ALL

sudo locale-gen "en_US.UTF-8"
sudo dpkg-reconfigure locales

sudo apt update && sudo apt upgrade
sudo apt install zsh zsh-syntax-highlighting \
  micro tree htop zip python3-virtualenv python3.12-venv \
  ca-certificates curl gnupg lsb-release software-properties-common

# Pure shell
mkdir -p "$HOME/.zsh"
git clone --depth 1 https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
chsh -s $(which zsh)

# Docker for Ubuntu (for debian use https://docs.docker.com/engine/install/debian/#install-using-the-repository)
sudo install -m 0755 -d /etc/apt/keyrings
sudo curl -fsSL https://download.docker.com/linux/ubuntu/gpg -o /etc/apt/keyrings/docker.asc
sudo chmod a+r /etc/apt/keyrings/docker.asc
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.asc] https://download.docker.com/linux/ubuntu \
  $(. /etc/os-release && echo "${UBUNTU_CODENAME:-$VERSION_CODENAME}") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt-get update && sudo apt-get install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin

# Non root access
sudo usermod -aG docker octavio
newgrp docker # activate the changes to groups

# NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
# Source/re-login
nvm install 18
nvm alias default 18
corepack enable

# AWS CLI
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install

sudo apt install wslu # to use BROWSER=wslview

# SDK man
curl -s "https://get.sdkman.io" | bash
sdk install java 11.0.27-tem
sdk install gradle 8.6

# Remove sourcing lines that nvm and sdkman added to zshrc
head -n -7 ~/.zshrc > ~/temp_zshrc && mv ~/temp_zshrc ~/.zshrc

# Git pager
npm install -g diff-so-fancy

cd ~/Downloads

# k9s 
wgettz https://github.com/derailed/k9s/releases/download/v0.50.6/k9s_Linux_amd64.tar.gz
sudo mv k9s /opt/k9s-v0.50.6
sudo ln -s /opt/k9s-v0.50.6 /usr/local/bin/k9s

# Helm
wgettz https://get.helm.sh/helm-v3.18.3-linux-amd64.tar.gz
sudo mv linux-amd64/helm /opt/helm-v3.18.3
sudo ln -s /opt/helm-v3.18.3 /usr/local/bin/helm

# Kubectl
curl -LO "https://dl.k8s.io/release/$(curl -L -s https://dl.k8s.io/release/stable.txt)/bin/linux/amd64/kubectl"
chmod +x kubectl
sudo install -o root -g root -m 0755 kubectl /usr/local/bin/kubectl

# k3d
sudo wget -q -O - https://raw.githubusercontent.com/k3d-io/k3d/main/install.sh | bash

# yq
wgettz https://github.com/mikefarah/yq/releases/download/v4.45.4/yq_linux_amd64.tar.gz
sudo mv yq_linux_amd64 /opt/yq-v4.45.4
sudo ln -s /opt/yq-v4.45.4 /usr/local/bin/yq

# Krew & neat
(
  set -x; cd "$(mktemp -d)" &&
  OS="$(uname | tr '[:upper:]' '[:lower:]')" &&
  ARCH="$(uname -m | sed -e 's/x86_64/amd64/' -e 's/\(arm\)\(64\)\?.*/\1\2/' -e 's/aarch64$/arm64/')" &&
  KREW="krew-${OS}_${ARCH}" &&
  curl -fsSLO "https://github.com/kubernetes-sigs/krew/releases/latest/download/${KREW}.tar.gz" &&
  tar zxvf "${KREW}.tar.gz" &&
  ./"${KREW}" install krew
)
kubectl krew install neat

# Terraform
wget -O- https://apt.releases.hashicorp.com/gpg | gpg --dearmor | sudo tee /usr/share/keyrings/hashicorp-archive-keyring.gpg > /dev/null
echo "deb [arch=$(dpkg --print-architecture) signed-by=/usr/share/keyrings/hashicorp-archive-keyring.gpg] https://apt.releases.hashicorp.com $(grep -oP '(?<=UBUNTU_CODENAME=).*' /etc/os-release || lsb_release -cs) main" | sudo tee /etc/apt/sources.list.d/hashicorp.list
sudo apt update && sudo apt-get install terraform

# gw
git clone https://github.com/dougborg/gdub.git
sudo gdub/install && rm -rf gdub
```

Set [more memory](https://learn.microsoft.com/en-us/windows/wsl/wsl-config#wslconfig) for WSL2
```ps
@"
[wsl2]
memory=50GB
"@ | Set-Content -Encoding UTF8 "$env:UserProfile\.wslconfig"

wsl --terminate Ubuntu-24.04
```

- **zsh**
  - [pure](https://github.com/sindresorhus/pure)
  - [zsh-syntax-highlighting](https://github.com/zsh-users/zsh-syntax-highlighting)
- **git**
  - [diff-so-fancy](https://github.com/so-fancy/diff-so-fancy)
- **ssh**
- **gpg**
  - key `A605E8F79D6E06D199643C81567A2A0BBAD826A2` ([how-to](https://access.redhat.com/solutions/2115511))
- **docker**
- **nodejs** with **npm**
- **golang**
- **aws**
- **terraform**
- [**micro**](https://micro-editor.github.io/)
- [**vs-code**](https://code.visualstudio.com/download)
- **fira-code** font
- [**nala**](https://gitlab.com/volian/nala/-/wikis/Installation)
