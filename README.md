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
# add on las line:
octavio ALL=(ALL) NOPASSWD: ALL

sudo locale-gen "en_US.UTF-8"
sudo dpkg-reconfigure locales

sudo apt update && sudo apt upgrade

sudo apt install zsh zsh-syntax-highlighting \
  micro tree htop zip ca-certificates curl gnupg lsb-release

# Pure shell
mkdir -p "$HOME/.zsh"
git clone --depth 1 https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
chsh -s $(which zsh)

# Docker
sudo install -m 0755 -d /etc/apt/keyrings
curl -fsSL https://download.docker.com/linux/debian/gpg | sudo gpg --dearmor -o /etc/apt/keyrings/docker.gpg
sudo chmod a+r /etc/apt/keyrings/docker.gpg
echo "deb [arch=$(dpkg --print-architecture) signed-by=/etc/apt/keyrings/docker.gpg] https://download.docker.com/linux/debian \
  $(. /etc/os-release && echo "$VERSION_CODENAME") stable" | \
  sudo tee /etc/apt/sources.list.d/docker.list > /dev/null
sudo apt update && sudo apt install docker-ce docker-ce-cli containerd.io docker-buildx-plugin docker-compose-plugin -y
# Non root access
sudo usermod -aG docker octavio

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

# SDK man
curl -s "https://get.sdkman.io" | bash
sdk install java 11.0.27-tem
sdk install gradle 8.6

# Remove sourcing lines that nvm and sdkman added to zshrc
head -n -7 ~/.zshrc > ~/temp_zshrc && mv ~/temp_zshrc ~/.zshrc
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
