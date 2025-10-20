#! /bin/sh -u

say() {     echo "[1m$@[0m"   ; }
ok()  {     echo "[1;32m$@[0m"; }
ko()  { >&2 echo "[1;31m$@[0m"; }

install() {
    say Compile $1...
    case $1 in
        twitch_alternate_player) out=$(pwd) ;;
        ublock)
            make clean chromium
            out=$(realpath ./dist/build/uBlock0.chromium) ;;
        *) exit 1 ;;
    esac
    ok Built $1 version: $(jq -r .version $out/manifest.json)
    ok Load from: $out
}

mkdir -p $XDG_DATA_HOME/chromium-ext && cd $XDG_DATA_HOME/chromium-ext
for repo in https://github.com/gorhill/ublock.git https://github.com/sevwren/twitch_alternate_player.git
do (
    set -e
    readonly dir=$(basename $repo .git)
    if [ ! -d $dir ]; then
        say Clone $dir...
        git clone --depth 1 $repo
        cd $dir && install $dir
    else
        say Update $dir...
        cd $dir
        if [ $(git fetch && git rev-list --count ..@{u}) -gt 0 ]; then
            git merge @{u} --ff-only
            install $dir
        else
            say Already up to date.
        fi
    fi
)
[ $? -eq 0 ] || ko Failed to process $repo
done
