#!/usr/bin/env bash

current="$1"

while IFS= read -r session; do
    if [ "$session" = "$current" ]; then
        printf "●"
    else
        printf "◌"
    fi
done < <(tmux list-sessions -F '#{session_id}')
