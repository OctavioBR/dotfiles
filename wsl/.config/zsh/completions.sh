# FZF
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
# Kubectl
# (( $+commands[kubectl] )) && source <(kubectl completion zsh) # FIXME: command not found: kubectl
# NPM completion
(( $+commands[npm] )) && source <(npm completion)
# Helm completion
# (( $+commands[helm] )) && source <(helm completion zsh) # FIXME: Kubernetes configuration file is group-readable. This is insecure. Location: /home/octavio/.kube/config
# Pack CLI
# (( $+commands[pack] )) && source <(pack completion --shell zsh)
