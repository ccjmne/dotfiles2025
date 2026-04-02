# Ctrl-Z to resume background job without polluting the history
# Source: https://www.reddit.com/r/vim/comments/9bm3x0/ctrlz_binding/
function resume {
    fg
    zle push-input
    BUFFER=''
    zle accept-line
}
zle -N resume
bindkey '^Z' resume

# Ctrl-A to jump to the nearest anchor directory
# exe "r!sed -n '/anchor_files=/,/)$/p' <(curl -sL https://github.com/romkatv/powerlevel10k/raw/refs/heads/master/config/p10k-classic.zsh)" | normal! V%J==F(lx
local anchor_files=(.bzr .citc .git .hg .node-version .python-version .go-version .ruby-version .lua-version .java-version .perl-version .php-version .tool-versions .mise.toml .shorten_folder_marker .svn .terraform CVS Cargo.toml composer.json go.mod package.json stack.yaml)
function anchor {
  local dir="$(dirname "$PWD")"
  while [[ "$dir" != "/" ]]; do
    for anchor in "${anchor_files[@]}"; do
      if [[ -e "$dir/$anchor" ]]; then
        cd ${(q)dir}
        zle push-input
        BUFFER=''
        zle accept-line
        return 0
      fi
    done
    dir="$(dirname "$dir")"
  done
}
zle -N anchor
bindkey '^A' anchor

# Vi Mode Configuration --------------------------------------------------------
bindkey -v
bindkey -M vicmd  'v' edit-command-line  # disable visual mode, deferring to edit-command-line instead
bindkey -M vicmd '^V' edit-command-line
bindkey -M viins '^V' edit-command-line
export KEYTIMEOUT=1 # 1/100th of a second, faster transition between Vi modes
bindkey -M vicmd  '?' history-incremental-pattern-search-backward
bindkey -M vicmd  '/' history-incremental-pattern-search-forward
bindkey          '^R' history-incremental-search-backward
bindkey          '^F' history-incremental-search-forward
bindkey          '^P' history-search-backward
bindkey          '^N' history-search-forward
bindkey          '^A' beginning-of-line
bindkey          '^E' end-of-line
