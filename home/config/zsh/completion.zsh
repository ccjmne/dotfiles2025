zmodload zsh/complist
autoload -U compinit && compinit -C
autoload -U _generic
zle -C zle-expand-omni expand-or-complete _generic

zstyle ':completion:zle-expand-omni:*' completer _expand_alias _complete _approximate
zstyle ':completion:*' menu select                    # enter menu mode when Tab again after options were displayed
zstyle ':completion:*' matcher-list ''                    `# plain `            \
                                    'm:{a-zA-Z}={A-Za-z}' `# case-insensitive ` \
                                    '+r:|[-_./]=* r:|=*'  `# +partial-word `

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
