```sh
# Install homebrew
xcode-select --install
ruby -e "$(curl -fsSL https://raw.githubusercontent.com/Homebrew/install/master/install)"

# Install CLI packages
brew install pure tree zsh-syntax-highlighting micro diff-so-fancy terraform awscli node corepack go sqlite xz helm htop pulumi

# Install casks
brew tap homebrew/cask-fonts
brew install --cask alt-tab linearmouse macs-fan-control alfred iterm2 istat-menus aerial docker google-cloud-sdk spotify gpg-suite font-fira-code microsoft-edge firefox 1password visual-studio-code dozer rectangle

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
Fix HiDPI for external displays with:
https://github.com/mlch911/one-key-hidpi

Fix BR ABNT2 keyboard layout using:
https://www.dropbox.com/s/1y637cjlfgawlbv/abnt2fixed.zip?dl=0
