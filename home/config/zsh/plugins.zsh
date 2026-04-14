(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
ZSH_HIGHLIGHT_STYLES[autodirectory]='fg=yellow,bold'
ZSH_HIGHLIGHT_STYLES[path]='fg=yellow,bold'
ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=yellow'
ZSH_HIGHLIGHT_STYLES[comment]='fg=8'

ZSH_PLUGINS="/usr/share/zsh/plugins"

# source "$ZSH_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh"
# source "$ZSH_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"
[[ $(command -v zsh-patina) ]] && source <(zsh-patina activate)

# [[ -d /usr/share/fzf ]]    && source /usr/share/fzf/completion.zsh
[[ -d /usr/share/fzf ]]    && source /usr/share/fzf/key-bindings.zsh
[[ $(command -v fzf rg) ]] && export FZF_DEFAULT_COMMAND='rg --files --hidden'    # Search hidden files w/ fzf
[[ $(command -v fzf rg) ]] && export FZF_CTRL_T_COMMAND='rg --files 2> /dev/null' # Ctrl-T searches only visible files
[[ $(command -v klog) ]]   && source <(klog completion -c zsh)
[[ $(command -v niri) ]]   && source <(niri completions zsh)
