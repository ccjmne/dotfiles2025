#! /bin/sh -u

say() { echo "[1m$@[0m"   ; }
ok()  { echo "[1;32m$@[0m"; }
ko()  { echo "[1;31m$@[0m"; }

install() {
    say Compile $1...
    local out=
    if [ $(pwd | xargs basename) != $1 ]; then cd $1; fi
    case $1 in
        ublock)
            make clean chromium
            out=$(realpath ./dist/build/uBlock0.chromium)
            ;;
        twitch_alternate_player) out=$(pwd) ;;
        *)                       exit 1     ;;
    esac
    ok Built $1 version: $(jq -r .version $out/manifest.json)
    ok Load from: $out
}

WD=$XDG_DATA_HOME/chromium-ext
mkdir -p $WD && cd $WD
for repo in https://github.com/gorhill/ublock.git https://github.com/sevwren/twitch_alternate_player.git
do (
    set -e
    DIR=$(basename $repo .git)
    if [ ! -d $DIR ]; then
        say Clone $DIR...
        git clone --depth 1 $repo
        install $DIR
    else
        say Update $repo...
        cd $DIR
        if [ $(git fetch && git rev-list --count ..@{u}) -gt 0 ]; then
            git merge @{u} --ff-only
            install $DIR
        else
            say Already up to date.
        fi
    fi
)
[ $? -ne 0 ] && ko Failed to process $repo
done
