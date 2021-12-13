```sh
# Install homebrew
xcode-select --install
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install CLI packages
brew install pure zsh-syntax-highlighting micro diff-so-fancy terraform awscli node go sqlite xz helm htop

# Install casks
brew tap homebrew/cask-fonts
brew install --cask alt-tab macs-fan-control alfred iterm2 istat-menus aerial google-cloud-sdk spotify gpg-suite font-fira-code firefox 1password visutal-studio-code dozer

# Fix zsh-syntax-highlighting to be sourced by oh-my-zsh
cp -r /usr/local/share/zsh-syntax-highlighting $ZSH_CUSTOM/plugins/zsh-syntax-highlighting
curl https://raw.githubusercontent.com/zsh-users/zsh-syntax-highlighting/master/zsh-syntax-highlighting.plugin.zsh > $ZSH_CUSTOM/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.plugin.zsh

# Fetch Dracula iTerm colors
curl https://raw.githubusercontent.com/dracula/iterm/master/Dracula.itermcolors > Downloads/Dracula.itermcolors

# Install oh-my-zsh
sh -c "$(curl -fsSL https://raw.github.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# Remove macOS dock animation
defaults write com.apple.dock autohide-time-modifier -int 0;killall Dock
```
Install https://github.com/lujjjh/LinearMouse
-> replaces "sensiblesidebuttons" and mac "mouse-fix"
