# Source: https://www.reddit.com/r/vim/comments/9bm3x0/ctrlz_binding/
# Allow Ctrl-Z to toggle between suspend and resume
function resume {
    fg
    zle push-input
    BUFFER=''
    zle accept-line
}
zle -N resume
bindkey '^Z' resume
