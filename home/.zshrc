REPORTTIME=3 # http://zsh.sourceforge.net/Doc/Release/Parameters.html
# Persistent history
HISTFILE=~/.zsh_history
HISTSIZE=10000
SAVEHIST=10000
setopt appendhistory

# Pure theme - https://github.com/sindresorhus/pure#oh-my-zsh
if [ -d "$HOME/.zsh/pure" ]; then
  fpath+=($HOME/.zsh/pure)
  autoload -Uz promptinit; promptinit
  prompt pure
fi

zsh_syntax_highlighting="/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
[ -f $zsh_syntax_highlighting ] && source $zsh_syntax_highlighting

if [ -x "$(command -v rbenv)" ]; then
  eval "$(rbenv init - zsh)"
fi

customzsh="$HOME/.config/zsh"
[ -f "$customzsh/aliases.sh" ] && source "$customzsh/aliases.sh"
[ -f "$customzsh/ohmyzsh.sh" ] && source "$customzsh/ohmyzsh.sh"
[ -f "$customzsh/completions.sh" ] && source "$customzsh/completions.sh"

# https://code.visualstudio.com/docs/terminal/shell-integration
# code --locate-shell-integration-path zsh
[[ "$TERM_PROGRAM" == "vscode" ]] && . "/usr/share/code/resources/app/out/vs/workbench/contrib/terminal/common/scripts/shellIntegration-rc.zsh"

# bun
export BUN_INSTALL="$HOME/.bun"
export PATH="$BUN_INSTALL/bin:$PATH"
[ -s "$BUN_INSTALL/_bun" ] && source "$BUN_INSTALL/_bun"
