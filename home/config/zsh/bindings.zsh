export KEYTIMEOUT=1 # 1/100th of a second, essentially disabling binding timeout

# Insert mode bindings
# --------------------
bindkey  ^P history-search-backward
bindkey  ^N history-search-forward
bindkey  ^A beginning-of-line                              # some love for emacs
bindkey  ^E end-of-line                                    #
bindkey  ^R history-incremental-search-backward
bindkey  ^F history-incremental-search-forward
bindkey  ^_ undo                   # Ctrl-/ undoes changes, such as *expansions*
bindkey  ^Z zle-resume                         # Ctrl-Z to resume background job
bindkey a zle-anchor                    # Meta-A to jump to the nearest anchor
bindkey  ^X zle-time-zsh                          # time zsh interactive startup

# Vi mode configuration
# ---------------------
autoload -U edit-command-line && zle -N edit-command-line
zstyle :zle:edit-command-line editor $EDITOR +'set ft=sh'
bindkey -v
bindkey -M vicmd  v edit-command-line                  # never enter visual mode
bindkey -M vicmd  V edit-command-line                  #   but invoke fc instead
bindkey -M vicmd ^V edit-command-line
bindkey          ^V edit-command-line
bindkey -M vicmd \? history-incremental-pattern-search-backward
bindkey -M vicmd  / history-incremental-pattern-search-forward

# Custom ZLE Widgets
# ------------------
function zle-resume { fg; zle push-input; BUFFER=''; zle accept-line }
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
