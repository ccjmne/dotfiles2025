alias -- -='cd -'
alias -10='fc -10 -1'
alias -100='fc -100 -1'

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

findpoms='fd pom.xml --exact-depth 2 | xargs dirname | sort | fzf'
prunegarbage='| sed -n "/--- dependency:/,/---/p" | sed "1d;\$d;s/.INFO. //"'
alias mdt="$findpoms --preview 'cd {} && mvn dependency:tree    $prunegarbage'"
alias mda="$findpoms --preview 'cd {} && mvn dependency:analyze $prunegarbage'"

function bak {
  for arg; do
    if [[ "$arg" == *.bak ]]; then
      mv "$arg" "${arg%.bak}"
    else
      mv "$arg" "$arg.bak"
    fi
  done
}

function btop() {
  read -q "answer?Don't you want to use top instead? [Y/n] "
  case "$answer" in
    [Nn]*) command btop ;;
    *)     command top  ;;
  esac
}

[[ $(command -v fzf git) ]] && function checkout {
  git branch --all | sed -E 's@^[*+ ] (remotes/[^/]+/)?@@' | awk '!M[$0]++' | fzf | xargs -r git checkout
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
  command stow --dotfiles --verbose "$@"
}

function tmpd {
  set -e
  cd $(mktemp --directory)
  set +e
  ( $SHELL )
  rm -r $(pwd)
  cd -
}
