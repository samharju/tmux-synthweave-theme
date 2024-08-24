#!/usr/bin/env bash

sessions=$(tmux ls -F '#S')
current=$(tmux list-panes -t "$TMUX_PANE" -F '#{session_name}' | head -1)

i=0
for session in $sessions; do
    if [ "$session" = "$current" ]; then
        echo -n "●"
    else
        echo -n "◌"
    fi
    i=$((i+1))
done
