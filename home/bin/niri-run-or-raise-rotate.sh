#! /bin/sh

# Adapted from /u/hypnomarten's script at:
# https://www.reddit.com/r/niri/comments/1mwnoil/niri_run_or_raise_focus_app_rotate_between/

APP_ID=$1
INSTANCES=( $(niri msg --json windows | jq ".[] | select(.app_id == \"${APP_ID}\")" | jq '.["id"]') )

# No instances found, spawn a new one
if [ ${#INSTANCES[@]} -eq 0 ]; then
    # strip ^.*\.
    # For example, we spawn "ghostty", whose app_id is "com.mitchellh.ghostty"
    niri msg action spawn -- ${APP_ID##*.} && exit
fi

# Only one instance found, focus it
if [ ${#INSTANCES[@]} -eq 1 ]; then
    niri msg action focus-window --id $INSTANCES && exit
fi

# Multiple instances found, rotate through them
ISORTED=( $( printf "%s\n" ${INSTANCES[@]} | sort -n ) )
FOCUSED=$(niri msg --json focused-window | jq '.id')
if [[ ! ${ISORTED[*]} =~ ${FOCUSED} ]]; then
    niri msg action focus-window --id ${ISORTED[0]} && exit
fi

for i in ${!ISORTED[@]}; do
    if [[ ${ISORTED[$i]} -eq $FOCUSED ]]; then
        niri msg action focus-window --id ${ISORTED[$(((i + 1) % ${#INSTANCES[@]}))]} && exit
    fi
done
