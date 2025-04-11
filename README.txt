                               Personal Dotfiles                    Éric NICOLAS
                               -----------------
Revisions: 2
Latest: 2025-01-08

TODO ---------------------------------------------------------------------------

    Consider using alternatives to Git submodules.  Git subtree was considered.
    Git subrepo may be it.


------------------------------ Usage w/ GNU Stow -------------------------------

Using a symlinks farm.  Cool kids use chezmoi or whatever; sysadmins already use
Stow and would rather master the few tools hanging at their belt.

    git clone git@github.com:ccjmne/dotfiles2025 dots
    STOW_DIR=dots stow --target ~ home


----------------------------- Deprecated Procedure -----------------------------

Using a bare Git repo instead of symlinks.  It's rather neat, but your tools may
not be too excellent at recognising that you're editing files that are tracked
by Git, if you like to keep an eye on these changes right in your editor, for
example.

If you're using Vim and Fugitive, you can:

    :call FugitiveDetect('~/.d')

If you aren't, you can: Use Vim and Fugitive.

Set up -------------------------------------------------------------------------

    git clone --separate-git-dir=~/.d git@github.com:ccjmne/dotfiles2025 ~
    alias dots='/usr/bin/git --git-dir=~/.d --work-tree=~'
    dots config status.showUntrackedFiles no
    dots update-index --assume-unchanged LICENSE README.txt
    rm ~/LICENSE ~/README.txt

Usage --------------------------------------------------------------------------

    dots status
    dots add --update
    dots commit
    dots push


vim: textwidth=80 expandtab shiftwidth=4 smarttab
