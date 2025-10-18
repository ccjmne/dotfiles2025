#! /bin/sh -u

cd "$(dirname "$(readlink -f "$0")")" || exit 1
fd '[^@][.](timer|service|path)$' . --exact-depth 1 --format {/} | xargs systemctl --user ${@:-status}
