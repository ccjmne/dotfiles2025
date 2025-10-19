#! /bin/sh

dconf read /org/gnome/desktop/interface/color-scheme \
    | sed '/-dark/ clight' \
    | sed '/-light/ cdark' \
    | xargs -II dconf write /org/gnome/desktop/interface/color-scheme '"prefer-I"'
