Set me up ======================================================================

    git clone --separate-git-dir=~/.dots git@github.com:ccjmne/dotfiles2025 ~
    alias dots='/usr/bin/git --git-dir=~/.dots --work-tree=~'
    dots config status.showUntrackedFiles no

Use me =========================================================================

    dots status
    dots add --update
    dots commit
    dots push

vim: textwidth=80 expandtab shiftwidth=4 smarttab
