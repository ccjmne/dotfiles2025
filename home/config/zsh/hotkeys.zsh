# TODO: rename to "bindings" or something in that vein

export KEYTIMEOUT=1 # 1/100th of a second, essentially disabling keymaps timeout

# Insert mode bindings
# --------------------
bindkey   ^P history-search-backward
bindkey   ^N history-search-forward
bindkey   ^A beginning-of-line                             # some love for emacs
bindkey   ^E end-of-line                                   # some love for emacs
bindkey   ^R history-incremental-search-backward
bindkey   ^F history-incremental-search-forward
bindkey   ^Z zle-resume                        # Ctrl-Z to resume background job
bindkey \\ea zle-anchor                   # Meta-A to jump to the nearest anchor
bindkey   ^I zle-expand-any                           # Tab also expands aliases
bindkey   ^_ undo                  # Ctrl-/ undoes changes, such as *expansions*

# Vi mode Configuration
# ---------------------
zstyle :zle:edit-command-line editor $EDITOR +'set ft=sh'
bindkey -v
bindkey -M vicmd  v edit-command-line   # disable visual mode, invoke fc instead
bindkey -M vicmd ^V edit-command-line
bindkey          ^V edit-command-line
bindkey -M vicmd \? history-incremental-pattern-search-backward
bindkey -M vicmd  / history-incremental-pattern-search-forward

# Custom functions for ZLE
# ------------------------
function zle-expand-any() { zle _expand_alias || zle expand-or-complete }
zle -N zle-expand-any

function zle-resume { fg; zle push-input; BUFFER=''; zle accept-line }
zle -N zle-resume

# exe "r!sed -n '/anchor_files=/,/)$/p' <(curl -sL https://github.com/romkatv/powerlevel10k/raw/refs/heads/master/config/p10k-classic.zsh)" | normal! V%J==F(lx
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
