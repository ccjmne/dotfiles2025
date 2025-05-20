(( ${+ZSH_HIGHLIGHT_STYLES} )) || typeset -A ZSH_HIGHLIGHT_STYLES
export ZSH_HIGHLIGHT_STYLES[autodirectory]='fg=yellow,bold'
export ZSH_HIGHLIGHT_STYLES[path]='fg=yellow,bold'
export ZSH_HIGHLIGHT_STYLES[path_prefix]='fg=yellow'
export ZSH_HIGHLIGHT_STYLES[comment]='fg=248' # 8-colours alternative: fg=8,bold

ZSH_PLUGINS="/usr/share/zsh/plugins"
OMZ_PLUGINS="/usr/share/oh-my-zsh/lib"

fpath=("$ZSH_PLUGINS/zsh-completions/src" $fpath)
source "$ZSH_PLUGINS/zsh-autosuggestions/zsh-autosuggestions.zsh"
source "$ZSH_PLUGINS/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# TODO: Make these two my own, or at least understand precisely *all* that they do
source "$OMZ_PLUGINS/completion.zsh"
source "$OMZ_PLUGINS/key-bindings.zsh"
# TODO: Better configure
ZVM_CURSOR_STYLE_ENABLED=false
source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh

autoload -U compinit; compinit

[[ -d /usr/share/fzf ]] && source /usr/share/fzf/completion.zsh
[[ -d /usr/share/fzf ]] && source /usr/share/fzf/key-bindings.zsh
[[ $(command -v fzf rg) ]] && export FZF_DEFAULT_COMMAND='rg --files --hidden'    # Search hidden files w/ fzf
[[ $(command -v fzf rg) ]] && export FZF_CTRL_T_COMMAND='rg --files 2> /dev/null' # ctrl-t searches only visible files

[[ $(command -v mise) ]] && eval "$(mise activate zsh)"
