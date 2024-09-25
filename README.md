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
on WSL:
```sh
# sudores withouth password
sudo visudo
# add on las line:
octavio ALL=(ALL) NOPASSWD: ALL
sudo apt update
sudo apt upgrade
sudo apt install zsh
mkdir -p "$HOME/.zsh"
git clone --depth 1 https://github.com/sindresorhus/pure.git "$HOME/.zsh/pure"
chsh -s $(which zsh)

# Install NVM
curl -o- https://raw.githubusercontent.com/nvm-sh/nvm/v0.39.7/install.sh | bash
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
