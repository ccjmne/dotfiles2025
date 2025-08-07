#! /bin/sh

dconf load /org/gnome/shell/extensions/ < "$XDG_CONFIG_HOME/gnome-ext/gnome-ext.ini"
while read id; do
    status=$(gdbus call                \
        --session                      \
        --object-path /org/gnome/Shell \
        --dest        org.gnome.Shell  \
        --method      org.gnome.Shell.Extensions.InstallRemoteExtension "$id")
    if ! echo "$status" | grep -q cancelled; then
        gdbus call                                                    \
            --session                                                 \
            --dest org.gnome.Shell                                    \
            --object-path /org/gnome/Shell                            \
            --method org.gnome.Shell.Extensions.EnableExtension "$id" \
            > /dev/null
    fi
done <<EOF
awesome-tiles@velitasali.com
clipboard-indicator@tudmotu.com
just-perfection-desktop@just-perfection
middleclickclose@paolo.tranquilli.gmail.com
Vitals@CoreCoding.com
weeks-start-on-monday@extensions.gnome-shell.fifi.org
EOF
