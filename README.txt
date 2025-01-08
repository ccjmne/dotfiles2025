
                                Bare Repo Set-up

    git clone --separate-git-dir=$HOME/.d git@github.com:ccjmne/dotfiles2025 ~
    alias dots='/usr/bin/git --git-dir=$HOME/.d --work-tree=$HOME'
    dots config status.showUntrackedFiles no
    dots update-index --assume-unchanged LICENSE README.txt
    rm $HOME/LICENSE $HOME/README.txt

    dots status
    dots add --update
    dots commit
    dots push


vim: textwidth=80 expandtab shiftwidth=4 smarttab
