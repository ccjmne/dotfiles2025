# set to list of bookmarks to read from, leave empty to parse all
bks=()

function prompt_klog() {
    tasks=()
    now=$(date +%H:%M | sed 's/:/*60+/' | bc)
    for bk in ${bks:-$(klog bookmarks list | grep -Eo '^[^ ]+')}; do
        { read start; read tags; } <<< $(klog json "$bk" --today \
            | jq '.records[].entries[] | select(.type == "open_range") | .start_mins, (.tags? | join(" "))' -r)
        if [ -n "$start" ]; then
            d=$(($now - $start))
            dh="$((d / 60))h$((d % 60))m"
            tasks+=("${tags:-$bk} ${dh#0h}")
        fi
    done
    out=$(printf ", %s" "${tasks[@]}")
    p10k segment -f4 -t"${out:2}"
}
