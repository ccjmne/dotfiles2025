#! /usr/bin/env bash

# TODO: Install "weeks start on monday again"
# TODO: Install "clipboard indicator"
# TODO: Bring GNOME extensions configs. to this repository,
#       Routinely dump them here with systemd

declare -A extensions=(
    ["just-perfection-desktop@just-perfection"]="just-perfection"
    ["sound-output-device-chooser@kgshank.net"]=""
    ["burn-my-windows@schneegans.github.com"]="burn-my-windows"
    ["awesome-tiles@velitasali.com"]="awesome-tiles"
    ["Vitals@CoreCoding.com"]="vitals"
)

for extension in "${!extensions[@]}"; do
    extension_dconf="${extensions[$extension]}"

    gdbus call --session --dest org.gnome.Shell --object-path /org/gnome/Shell --method org.gnome.Shell.Extensions.DisableExtension "$extension" > /dev/null

    if [[ -e "home/.config/$extension_dconf.ini" ]]; then
        dconf load "/org/gnome/shell/extensions/$extension_dconf/" < "home/.config/$extension_dconf.ini"
    fi

    status=$(gdbus call \
        --session \
        --dest org.gnome.Shell \
        --object-path /org/gnome/Shell \
        --method org.gnome.Shell.Extensions.InstallRemoteExtension "$extension")

    if [[ "$extension" = "Vitals@CoreCoding.com" ]] && [[ $status =~ "successful" ]]; then
        sudo apt-get install gir1.2-gtop-2.0 lm-sensors -y # See https://github.com/corecoding/Vitals/wiki/Storage-reporting-%22No-Data%22
    fi

    if [[ ! $status =~ "cancelled" ]]; then
        gdbus call --session --dest org.gnome.Shell --object-path /org/gnome/Shell --method org.gnome.Shell.Extensions.EnableExtension "$extension" > /dev/null
    fi
done
