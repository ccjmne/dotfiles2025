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
local anchor_files=(.bzr .citc .git .hg .node-version .python-version .go-version .ruby-version .lua-version .java-version .perl-version .php-version .tool-versions .mise.toml .shorten_folder_marker .svn .terraform CVS Cargo.toml composer.json go.mod package.json stack.yaml)
function anchor {
  local dir="$(dirname "$PWD")"
  while [[ "$dir" != "/" ]]; do
    for anchor in "${anchor_files[@]}"; do
      if [[ -e "$dir/$anchor" ]]; then
        echo "$dir"
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
