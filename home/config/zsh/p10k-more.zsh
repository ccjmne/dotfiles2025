function klog-wip() {
    for bk in $(klog bookmarks list | grep -Eo '^[^ ]+'); do
        klog tags $bk --today -vun --entry-type OPEN_RANGE --no-style --no-warn | sed -E "/\b0m/d; s/^\(untagged\)/$bk/; s/ +/ /g"
    done
}

function prompt_klog() {
    p10k segment -f4 -t"$(klog-wip | paste -sd',' | sed 's/ *,/, /g')"
}
