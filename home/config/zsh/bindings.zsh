export KEYTIMEOUT=1 # 1/100th of a second, essentially disabling binding timeout

# Insert mode bindings
# --------------------
bindkey  ^P history-search-backward
bindkey  ^N history-search-forward
bindkey  ^A beginning-of-line                              # some love for emacs
bindkey  ^E end-of-line                                    #
bindkey  ^_ undo                   # Ctrl-/ undoes changes, such as *expansions*
bindkey  ^Z zle-resume                         # Ctrl-Z to resume background job
bindkey a zle-anchor                    # Meta-A to jump to the nearest anchor
bindkey x zle-time-zsh                # Meta-X to time zsh interactive startup
bindkey m zle-mise-activate                          # Meta-M to activate mise
bindkey k zle-osc133-prev            #        enter tmux copy-mode and jump to
bindkey k zle-osc133-prev -M vicmd   # previous OSC 133 semantic prompt marker

# Incremental search bindings
# ---------------------------
bindkey -M isearch    ^X^J accept-search  # trampoline enabling isearch bindings
bindkey -M isearch -s   ^J ^X^J              # Ctrl-J, Ctrl-[ exit search mode
bindkey -M isearch -s    ^X^J              #                 and enter vicmd
bindkey -M vicmd        \? history-incremental-pattern-search-backward
bindkey -M vicmd         / history-incremental-pattern-search-forward
bindkey                 ^R history-incremental-pattern-search-backward
bindkey                 ^F history-incremental-pattern-search-forward

# Vi mode configuration
# ---------------------
autoload -U edit-command-line && zle -N edit-command-line
zstyle :zle:edit-command-line editor $EDITOR +'se ft=sh'
zle -A backward-delete-char vi-backward-delete-char  #    Ctrl-H, Ctrl-W, Ctrl-U
zle -A backward-kill-word   vi-backward-kill-word    #    may operate beyond the
zle -A kill-whole-line      vi-kill-line             # last viins entry boundary
bindkey -v
bindkey -M vicmd  v edit-command-line                  # never enter visual mode
bindkey -M vicmd  V edit-command-line                  #   but invoke fc instead
bindkey -M vicmd ^V edit-command-line
bindkey          ^V edit-command-line

# Surround bindings
# -----------------
autoload -U surround
zle     -N    add-surround  surround
zle     -N change-surround  surround
zle     -N delete-surround  surround
bindkey -M vicmd  cs change-surround
bindkey -M vicmd  ds delete-surround
bindkey -M vicmd  ys    add-surround
bindkey -M visual  S    add-surround

# Custom ZLE Widgets
# ------------------
function zle-resume { zle push-input; BUFFER='fg'; zle accept-line }
zle -N zle-resume

# exe "r!sed -n '/anchor_files=/,/)$/p' <(curl -sL https://github.com/romkatv/powerlevel10k/raw/refs/heads/master/config/p10k-classic.zsh)" | norm V%J==F(lx
local anchor_files=(.bzr .citc .git .hg .node-version .python-version .go-version .ruby-version .lua-version .java-version .perl-version .php-version .tool-versions .mise.toml .shorten_folder_marker .svn .terraform CVS Cargo.toml composer.json go.mod package.json stack.yaml)
function zle-anchor {
  local dir=${PWD:h}
  while [[ "$dir" != "/" ]]; do
    for anchor in "${anchor_files[@]}"; do
      if [[ -e "$dir/$anchor" ]]; then
        cd ${(q)dir}; zle push-input; BUFFER=''; zle accept-line; return 0
      fi
    done
    dir=${dir:h}
  done
}
zle -N zle-anchor

function zle-time-zsh { BUFFER='time zsh -ic exit'; zle accept-line }
zle -N zle-time-zsh

function zle-mise-activate { source <(mise activate) }
zle -N zle-mise-activate

function zle-osc133-prev { tmux copy-mode && tmux send-keys -X previous-prompt }
zle -N zle-osc133-prev
