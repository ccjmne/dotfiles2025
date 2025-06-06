alias dirs='dirs -v'

alias -- -='cd -'
alias -1='cd -1'
alias -2='cd -2'
alias -3='cd -3'
alias -4='cd -4'
alias -5='cd -5'
alias -6='cd -6'
alias -7='cd -7'
alias -8='cd -8'
alias -9='cd -9'

alias -g ...='../..'
alias -g ....='../..'
alias -g .....='../../..'
alias -g ......='../../../..'
alias -g .......='../../../../..'
alias -g ........='../../../../../..'
alias -g .........='../../../../../../..'
alias -g ..........='../../../../../../../..'
alias -g ...........='../../../../../../../../..'

function btop() {
    read -q "answer?Don't you want to use top instead? [Y/n] "
    case "$answer" in
        [Nn]*) command btop ;;
        *)     command top ;;
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

function ssh { TERM=xterm-256color command ssh "$@" }
function ls { command ls --classify=if-tty --group-directories-first --color=auto "$@" }
alias ll='ls -l --almost-all --human-readable'

function less { command less --chop-long-lines "$@" }
function xclip { command xclip -selection clipboard "$@" }

alias sg='ast-grep'
alias find='noglob find'
alias git='noglob git'
alias gitt='noglob git -c diff.external=difft'
alias rg='noglob rg --no-heading --column'
alias fd='noglob fd'

alias watch='watch --color'

function checkout {
  command git branch --all | sed -E 's@^[*+ ] (remotes/[^/]+/)?@@' | awk '!M[$0]++' | fzf | xargs git checkout
}

function fzf {
  command fzf --style=minimal \
    --bind 'ctrl-h:deselect+down' \
    --bind 'ctrl-l:select+down' \
    "$@"
}

function tmpd() {
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
