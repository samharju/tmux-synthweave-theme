#!/usr/bin/env bash

CURRENT_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

pink="#ff7edb"
cyan="#36f9f6"
blue_bright="#2ee2fa"
yellow="#fede5d"
green_bright="#72f1b8"
powder_blue="#a2c7e5"
raisin="#262335"

sep_left=""
sep_right=""
session_bar() {
    echo "#($CURRENT_DIR/scripts/session-bar.sh)"
}

set() {
    local option=$1
    local value=$2
    tmux set-option -g "$option" "$value"
}


setw() {
    local option=$1
    local value=$2
    tmux set-window-option -g "$option" "$value"
}

get() {
    local option=$1
    local default=$2
    local -r user=$(tmux show-option -qgv "$option")
    if [ -z "$user" ]; then
        echo "$default"
    else
        echo "$user"
    fi
}

get_prefix() {
    local -r custom="$(get @synthweave_prefix_text)"
    if [ -z "$custom" ]; then
        local -r pr=$(tmux show-option -qgv prefix)
        echo "${pr^^}"
    else
        echo "$custom"
    fi
}

l_cheek() {
    echo "#[fg=$1 bg=$2 none]"
}

r_cheek() {
    echo "#[fg=$1 bg=$2 none]"
}

bubble() {
    echo "$(l_cheek "$1" "$2")#[fg=$2 bg=$1 none]$3$(r_cheek "$1" "$2")"
}

prefix_() {
    local -r prefix_text="$(get_prefix)"
    local -r prefix_mode="$(bubble $yellow $raisin "$prefix_text")"
    local -r copy_text="$(get @synthweave_copy_text COPY)"
    local -r prefix_copy="$(bubble $blue_bright $raisin "$copy_text")"
    local -r copy_mode_active="#{?pane_in_mode,$prefix_copy ,}"
    local -r prefix_mode_active="#{?client_prefix,$prefix_mode ,}"
    local -r prefix="$prefix_mode_active$copy_mode_active"
    echo "$prefix"
}

# clock mode
set "clock-mode-colour" "$green_bright"
set "clock-mode-style" 24

set "status-style" "fg=$powder_blue,bg=$raisin,none"
set "status-justify" "left"

# message and cmd promt style
set "message-style" "fg=$blue_bright,bg=$raisin,none"
set "message-command-style" "fg=$blue_bright$,bg=$raisin,none"

set "mode-style" "fg=$cyan,bg=$raisin,italics"

# session listing
set "display-panes-active-colour" "$yellow"
set "display-panes-colour" "$powder_blue"


# window options
setw "pane-border-style" "fg=$raisin"
setw "pane-active-border-style" "fg=$pink"
setw "window-status-style" ""
setw "window-status-activity-style" ""
setw "window-status-separator" ""
set "pane-border-status" "off"

# no fiddling with panel styles
set "window-style" "default"
set "window-active-style" "default"

# window bar
window_status="$(get @synthweave_window_status '#I#{sep} #W' )"
window_status="${window_status//\#\{sep\}/$sep_left}"
set "window-status-format" "#[fg=$powder_blue bg=$raisin none] $window_status "

window_status_current="$(get @synthweave_window_status_current "#I#{sep} #W" )"
window_status_current="${window_status_current//\#\{sep\}/$sep_left}"
set "window-status-current-format" "$(bubble $pink $raisin "$window_status_current")"

# left status
set "status-left-length" "100"
set "status-left-style" ""

status_left="$(get @synthweave_status_left " #{session_bar}#{sep} #S")"
status_left="${status_left//\#\{sep\}/$sep_left}"
status_left="${status_left//\#\{session_bar\}/$(session_bar)}"
set "status-left" "#[fg=$raisin bg=$green_bright bold]${status_left}$(r_cheek $green_bright $raisin) $(prefix_)"

# right status
time_format="$(get @synthweave_time_format %T)"
date_format="$(get @synthweave_date_format %d-%m-%Y)"
widgets="$(get @synthweave_widgets)"

if [ -n "$widgets" ]; then
    widgets="${widgets//\#\{sep\}/$sep_right}"
    widgets="${widgets//\#\{session_bar\}/$(session_bar)}"
fi

set "status-right-length" "100"
set "status-right-style" ""
status_right="$(get @synthweave_status_right '@#h ')"
status_right="${status_right//\#\{sep\}/$sep_right}"
status_right="${status_right//\#\{session_bar\}/$(session_bar)}"
set "status-right" "${widgets}#[fg=$powder_blue bg=$raisin none] ${time_format} $sep_right ${date_format} $(l_cheek $green_bright $raisin)#[fg=$raisin bg=$green_bright]$status_right"

