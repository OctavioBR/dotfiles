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
[ -f "$customzsh/completions.sh" ] && source "$customzsh/completions.sh"
[ -f "$customzsh/aliases.sh" ] && source "$customzsh/aliases.sh"
[ -f "$customzsh/keys.sh" ] && source "$customzsh/keys.sh"
