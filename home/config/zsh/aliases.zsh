alias -- -='cd -'

function btop() {
  read -q "answer?Don't you want to use top instead? [Y/n] "
  case "$answer" in
    [Nn]*) command btop ;;
    *)     command top  ;;
  esac
}

function bak {
  for arg; do
    if [[ "$arg" == *.bak ]]; then
      mv "$arg" "${arg%.bak}"
    else
      mv "$arg" "$arg.bak"
    fi
  done
}

alias fd='noglob fd'
alias find='noglob find'
alias git='noglob git'
alias gitt='git -c diff.external=difft'
alias less='less --chop-long-lines'
alias ll='ls -l --almost-all --human-readable'
alias ls='ls --classify=if-tty --group-directories-first --color=auto'
alias rg='noglob rg --no-heading --column'
alias sg='ast-grep'
alias ssh='TERM=xterm-256color ssh'
alias watch='watch --color'
alias xclip='xclip -selection clipboard'

[[ $(command -v fzf git) ]] && function checkout {
  git branch --all | sed -E 's@^[*+ ] (remotes/[^/]+/)?@@' | awk '!M[$0]++' | fzf | xargs git checkout
}

function tmpd {
  set -e
  cd $(mktemp --directory)
  set +e
  ( $SHELL )
  rm -rf $(pwd)
  cd -
}

[[ $(command -v stow) ]] && function stow {
  local has_target=false
  for arg in "$@"; do
    if [[ "$arg" == "--target" ]]; then
      has_target=true
      break
    fi
  done
  if [[ "$has_target" == "false" ]]; then
    echo "Error: '--target' option is required"
    return 1
  fi
  command stow --verbose "$@"
}
