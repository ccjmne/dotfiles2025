alias -- -='cd -'
alias -10='fc -10 -1'
alias -100='fc -100 -1'

alias -g L='| less'
alias -g N='| nvim -'
alias -g S='| tee >(tail -1 | awk '"'"'{ printf "%s [%+d]\n", $0, $4 - $6 }'"'"') | head -n-1'

alias fd='noglob fd --hidden --exclude .git'
alias find='noglob find'
alias git='noglob git'
alias gitt='git -c diff.external=difft'
alias less='less --quit-if-one-screen --chop-long-lines --ignore-case'
alias ll='ls -l --almost-all --human-readable'
alias ls='ls --group-directories-first --classify=if-tty --color=if-tty'
alias rg='noglob rg --hidden --glob="!.git" --smart-case'
alias sg='ast-grep'
alias ssh='TERM=xterm-256color ssh'
alias tokenise='zsh-patina tokenize'
alias watch='watch --color'
alias xclip='xclip -selection clipboard'

findpoms='fd pom.xml --exact-depth 2 | xargs dirname | sort | fzf'
prunegarbage='| sed "/--- dependency:/,/---/!d" | sed "1d;\$d;s/.INFO. //"'
mvncache='/tmp/mvncache'
alias mdt="$findpoms --preview 'cd {} && mvn dependency:tree    $prunegarbage | tee $mvncache' --bind 'enter:become(cat $mvncache)+abort'"
alias mda="$findpoms --preview 'cd {} && mvn dependency:analyze $prunegarbage | tee $mvncache' --bind 'enter:become(cat $mvncache)+abort'"
alias owner='sed "/^\[/{h;d};/^\//!d;G;s/\n/:/;s/\s\s*/:/" ~/git.unite/mercateo/CODEOWNERS | column -ts: -H3 | fzf'

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
