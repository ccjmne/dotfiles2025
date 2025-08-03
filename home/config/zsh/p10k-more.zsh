bks=() # set to list of bookmarks to read from, leave empty to parse all
function prompt_klog() {
    now=$(date +%H:%M | sed 's/:/*60+/' | bc)
    for bk in ${bks:-$(klog bookmarks list | grep -Eo '^[^ ]+')}; do
        { read start; read tags; } <<< $(klog json "$bk" --today \
            | jq '.records[].entries[] | select(.type == "open_range") | .start_mins, (.tags? | join(" "))' -r)
        if [ -n "$start" ]; then
            d=$(($now - $start))
            dh="$((d / 60))h$((d % 60))m"
            p10k segment -f4 -t"${dh#0h} ${tags:-$bk}"
        fi
    done
}
