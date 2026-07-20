#!/usr/bin/env bash

# tmux2k segment: Claude usage (today's cost + tokens) via ccusage.
#
# Because tmux refreshes the status line frequently (status-interval 5s) and
# `bunx ccusage` takes several seconds, this segment never runs ccusage
# synchronously. It prints the cached value immediately and, when the cache is
# stale, spawns a detached background refresh. The number therefore lags by at
# most @tmux2k-ccusage-interval seconds, which is fine for a cost meter.

export LC_ALL=en_US.UTF-8

current_dir="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
source "$current_dir/../lib/utils.sh"

# Nerd Font glyphs are built from hex UTF-8 escapes so they survive editing as
# plain ASCII in this file (raw private-use glyphs get stripped by some editors).
default_icon="$(printf '\xef\x85\x95')"        # U+F155 nf-fa-usd (cost)
default_token_icon="$(printf '\xee\xaa\xa8')"  # U+EAA8 nf-cod-debug_breakpoint_data_unverified (tokens)

ccusage_icon="$(get_tmux_option '@tmux2k-ccusage-icon' "$default_icon")"
ccusage_token_icon="$(get_tmux_option '@tmux2k-ccusage-token-icon' "$default_token_icon")"
ccusage_command="$(get_tmux_option '@tmux2k-ccusage-command' "$HOME/.local/share/mise/installs/bun/latest/bin/bunx ccusage")"
ccusage_interval="$(get_tmux_option '@tmux2k-ccusage-interval' '60')"

cache_file="${TMPDIR:-/tmp}/tmux2k-ccusage.cache"
lock_file="${TMPDIR:-/tmp}/tmux2k-ccusage.lock"

# Humanize a raw token count: 1234567 -> 1.2M
humanize() {
    awk -v n="$1" 'BEGIN {
        if (n >= 1e9)      printf "%.1fB", n / 1e9;
        else if (n >= 1e6) printf "%.1fM", n / 1e6;
        else if (n >= 1e3) printf "%.1fK", n / 1e3;
        else               printf "%d", n;
    }'
}

# Query ccusage and rewrite the cache atomically. Keeps the previous cache on
# any failure (empty output, non-numeric, network error).
refresh() {
    # Serialize refreshes across panes; bail if another one holds the lock.
    if ! ( set -o noclobber; : >"$lock_file" ) 2>/dev/null; then
        return
    fi
    trap 'rm -f "$lock_file"' EXIT

    local json cost tokens value
    json=$($ccusage_command daily --json 2>/dev/null)
    [ -z "$json" ] && return

    read -r cost tokens < <(printf '%s' "$json" \
        | jq -r '.daily[-1] | "\(.totalCost) \(.totalTokens)"' 2>/dev/null)

    # Guard against missing/non-numeric fields.
    case "$cost" in ''|null) return ;; esac
    case "$tokens" in ''|null) return ;; esac

    value="$(printf '%.2f' "$cost") $ccusage_token_icon $(humanize "$tokens")"
    printf '%s' "$value" >"$cache_file.tmp" && mv -f "$cache_file.tmp" "$cache_file"
}

# Age of the cache file in seconds, or a large number if it does not exist.
cache_age() {
    if [ ! -f "$cache_file" ]; then
        echo 999999
        return
    fi
    local now mtime
    now=$(date +%s)
    mtime=$(stat -f %m "$cache_file" 2>/dev/null || stat -c %Y "$cache_file" 2>/dev/null)
    echo $(( now - mtime ))
}

main() {
    local cached=''
    [ -f "$cache_file" ] && cached="$(cat "$cache_file")"

    # Refresh in the background if the cache is missing or stale.
    if [ "$(cache_age)" -ge "$ccusage_interval" ]; then
        ( refresh ) >/dev/null 2>&1 &
    fi

    if [ -n "$cached" ]; then
        printf '%s %s' "$ccusage_icon" "$cached"
    else
        printf '%s …' "$ccusage_icon"
    fi
}

main
