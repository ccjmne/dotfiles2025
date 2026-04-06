zmodload zsh/complist
autoload -U compinit && compinit
autoload -U _generic
zle -C zle-expand-omni expand-or-complete _generic

zstyle ':completion:zle-expand-omni:*' completer _expand_alias _complete _ignored
zstyle ':completion:*' menu select                                # enter menu mode when Tab again after options were displayed
zstyle ':completion:*' matcher-list '' 'm:{a-zA-Z-_}={A-Za-z_-}' `# Make the completion case- and [-_]- insensitive` \
                                       '+l:|=* r:|=*'             # match sub-strings
                                                                  # See https://zsh.sourceforge.io/Doc/Release/Completion-Widgets.html#Completion-Matching-Control
                                                                  # See https://stackoverflow.com/questions/7906078/how-does-the-matcher-list-arguments-work-in-zsh-zstyle-completion

bindkey               '^I'   zle-expand-omni          # Tab also expands aliases
bindkey -M menuselect '^?'   backward-delete-char     # let Backspace behave in isearch
bindkey -M menuselect '^H'   backward-delete-char     # let ^H        behave in isearch
bindkey -M menuselect  '/'   history-incremental-search-forward
bindkey -M menuselect  '?'   history-incremental-search-backward

bindkey -M menuselect '^[h'  vi-backward-char         # navigate options grid with Meta-[hjkl]
bindkey -M menuselect '^[k'  vi-up-line-or-history    #
bindkey -M menuselect '^[l'  vi-forward-char          #
bindkey -M menuselect '^[j'  vi-down-line-or-history  #
bindkey -M menuselect '^N'   vi-down-line-or-history  # navigate otpions grid with ^N, ^P
bindkey -M menuselect '^P'   vi-up-line-or-history    #
bindkey -M menuselect '^I'   vi-down-line-or-history  # navigate otpions grid with Tab, S-Tab
bindkey -M menuselect '^[[Z' vi-up-line-or-history    #
