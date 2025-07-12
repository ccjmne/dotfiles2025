#! /bin/bash

WD=$HOME/bin
mkdir -p "$WD" && cd "$WD"
curl -Ls https://github.com/git/git/raw/refs/heads/master/contrib/git-jump/git-jump > "$WD/git-jump"
chmod u+x "$WD/git-jump"
