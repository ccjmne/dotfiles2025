#! /bin/sh

# TODO: Install "weeks start on monday again"
# TODO: Install "clipboard indicator"
# TODO: Bring GNOME extensions configs. to this repository,
#       Routinely dump them here with systemd

while IFS=: read id name; do
    if [ -e "$XDG_CONFIG_HOME/gnome-ext/$name.ini" ]; then
        dconf load "/org/gnome/shell/extensions/$name/" < "$XDG_CONFIG_HOME/gnome-ext/$name.ini"
    fi

    status=$(gdbus call                \
        --session                      \
        --object-path /org/gnome/Shell \
        --dest        org.gnome.Shell  \
        --method      org.gnome.Shell.Extensions.InstallRemoteExtension "$id")

    if ! echo "$status" | grep -q "cancelled"; then
        gdbus call --session --dest org.gnome.Shell --object-path /org/gnome/Shell --method org.gnome.Shell.Extensions.EnableExtension "$id" > /dev/null
    fi
done <<EOF
just-perfection-desktop@just-perfection:just-perfection
awesome-tiles@velitasali.com:awesome-tiles
Vitals@CoreCoding.com:vitals
EOF
