#! /bin/sh

# TODO: Install "weeks start on monday again"
# TODO: Install "clipboard indicator"
# TODO: Bring GNOME extensions configs. to this repository,
#       Routinely dump them here with systemd

while IFS=: read extension extension_dconf; do
    if [ -e "$XDG_CONFIG_HOME/gnome-ext/$extension_dconf.ini" ]; then
        dconf load "/org/gnome/shell/extensions/$extension_dconf/" < "$XDG_CONFIG_HOME/gnome-ext/$extension_dconf.ini"
    fi

    status=$(gdbus call                \
        --session                      \
        --object-path /org/gnome/Shell \
        --dest        org.gnome.Shell  \
        --method      org.gnome.Shell.Extensions.InstallRemoteExtension "$extension")

    if ! echo "$status" | grep -q "cancelled"; then
        gdbus call --session --dest org.gnome.Shell --object-path /org/gnome/Shell --method org.gnome.Shell.Extensions.EnableExtension "$extension" > /dev/null
    fi
done <<EOF
just-perfection-desktop@just-perfection:just-perfection
sound-output-device-chooser@kgshank.net:
burn-my-windows@schneegans.github.com:burn-my-windows
awesome-tiles@velitasali.com:awesome-tiles
Vitals@CoreCoding.com:vitals
EOF
