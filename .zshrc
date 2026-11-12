# ============================================================================
#  PATH
# ============================================================================
export PATH="$HOME/.local/bin:$PATH"
export PATH="$HOME/.yarn/bin:$HOME/.config/yarn/global/node_modules/.bin:$PATH"  # Yarn
export PATH="$PATH:/opt/nvim-linux64/bin"                                        # NeoVim

# ============================================================================
#  Oh My Zsh
# ============================================================================
export ZSH="$HOME/.oh-my-zsh"
ZSH_THEME="fino"
plugins=(git kube-ps1)

PROMPT='$(kube_ps1)'$PROMPT   # or RPROMPT='$(kube_ps1)'
fpath=(~/.zsh/completions $fpath)
source $ZSH/oh-my-zsh.sh

# ============================================================================
#  Shell options & environment
# ============================================================================
unsetopt BEEP          # Turn off all beeps
export EDITOR=nvim

autoload -Uz compinit && compinit

# ============================================================================
#  Aliases
# ============================================================================
alias nvim="$HOME/nvim-dist/nvim-macos-arm64/bin/nvim"
alias nv="nvim"
alias k="kubecolor"
alias ss='eval "$(starship init zsh)"'

# Gardener / Kubernetes helpers
alias set_kube='eval "$(gardenctl kubectl-env $(basename $SHELL))"; export KUBECONFIG=$KUBECONFIG:/Users/I776256/.kube/config'
alias ks='. /Users/I776256/projects/hotliner-tools/gardener-selector/gardener-selector.sh fullfzf'
alias kubedebug='kubectl get pods -A -o wide | awk '\''NR>1 && ($4 !~ /^(Running|Completed|ContainerCreating|Terminating)$/ || ($4 == "Running" && $5+0 > 20))'\''; echo ""; pvc_output=$(kubectl get pvc -A | awk '\''NR>1 && $3 != "Bound"'\''); [ -n "$pvc_output" ] && echo -e "Unbound PVCs:\n$pvc_output"'

# ============================================================================
#  Functions
# ============================================================================
# gardener-selector wrapper + completion
gs() { . /Users/I776256/projects/hotliner-tools/gardener-selector/gardener-selector.sh "$@"; }
_garden_zsh() {
    local commands=(setup refresh shoots versions help)
    compadd -a commands
}
compdef _garden_zsh gs

# kcfg — Gardener K8s cluster switcher
kcfg() {
  case "$1" in
    refresh|update|install|list-projects|list-shoots|fetch-active|fetch-btp|version|--version|-v|help|--help|-h)
      kcfg-bin "$@"
      ;;
    *)
      eval "$(kcfg-bin "$@")"
      ;;
  esac
}

# ============================================================================
#  NVM
# ============================================================================
export NVM_DIR="$([ -z "${XDG_CONFIG_HOME-}" ] && printf %s "${HOME}/.nvm" || printf %s "${XDG_CONFIG_HOME}/nvm")"
[ -s "$NVM_DIR/nvm.sh" ] && \. "$NVM_DIR/nvm.sh"   # This loads nvm

# ============================================================================
#  fzf
# ============================================================================
# Use fd for fzf so .gitignore is respected by default
export FZF_DEFAULT_COMMAND='fdfind --type f'
export FZF_CTRL_T_COMMAND="$FZF_DEFAULT_COMMAND"

_fzf_compgen_path() { fd --hidden --exclude .git . "$1"; }         # path completion
_fzf_compgen_dir()  { fd --type d --hidden --exclude .git . "$1"; } # directory completion

[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh

# ============================================================================
#  Tool integrations
# ============================================================================
eval "$(zoxide init zsh)"                                                        # Zoxide

[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"   # envman (generated — do not edit)

test -e /Users/I776256/.iterm2_shell_integration.zsh && source /Users/I776256/.iterm2_shell_integration.zsh || true  # iTerm2

source <(gardenctl rc zsh)                                                       # SAP / Gardener
