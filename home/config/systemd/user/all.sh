#! /bin/sh -u

fd '[^@][.](timer|service|path)$' . --exact-depth 1 --format {/} | xargs systemctl --user ${@:-status}
