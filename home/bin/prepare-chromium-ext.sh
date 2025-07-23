#! /usr/bin/env bash

set -e
say() { echo "[1m$@[0m"   ; }
ok()  { echo "[1;32m$@[0m"; }
ko()  { echo "[1;31m$@[0m"; }

install() {
    say Compile $1...
    if [ $(pwd | xargs basename) != $1 ]; then cd $1; fi
    case $1 in
        uBlock)
            make clean chromium
            ok Load unpacked from: $(pwd)/dist/build/uBlock0.chromium
            ;;
        twitch_alternate_player)
            ok Load unpacked from: $(pwd)
            ;;
        *)
            ko Missing compilation procedure for $1.
            ;;
    esac
}

WD=$XDG_DATA_HOME/chromium-ext
mkdir -p $WD && cd $WD
for repo in https://github.com/gorhill/uBlock.git https://github.com/sevwren/twitch_alternate_player.git
do (
    set +e
    DIR=$(basename $repo .git)
    if [ ! -d $DIR ]; then
        say Clone $DIR...
        git clone --depth 1 $repo
        install $DIR
    else
        say Update $repo...
        cd $DIR
        if [ $(git fetch && git rev-list --count ...@{u}) -gt 0 ]; then
            git merge @{u} --ff-only
            install $DIR
        else
            say Already up to date.
        fi
    fi
)
done
