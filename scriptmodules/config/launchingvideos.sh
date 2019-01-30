#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="launchingvideos"
rp_module_desc="Enable Launching Videos prior to game start"
rp_module_section="config"

function update_launchingvideos() {
    rm -rf "$datadir/launchingvideos"
    gitPullOrClone "$datadir/launchingvideos" "https://github.com/Retro-Arena/RetroArena-launchingvideos.git"
    rm -rf "$datadir/launchingvideos/.git"
    rm -rf "$datadir/launchingvideos/.gitattributes"
    chown -R $user:$user "$datadir/launchingvideos"
}

function gui_launchingvideos() {
    while true; do
        local cmd=(dialog --backtitle "$__backtitle" --menu "Choose an option" 22 86 16)
        local options=(
            1 "Enable Launching Videos (default)"
            2 "Disable Launching Videos"
            3 "Update Launching Videos"
        )
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        [[ -z "$choice" ]] && break
        if [[ -n "$choice" ]]; then
            case "$choice" in
                1)
                    touch $home/.config/launchingvideos001
                    printMsgs "dialog" "Enabled Launching Videos\n\nThis also disabled Launching Images."
                    ;;
                2)
                    rm -rf $home/.config/launchingvideos001
                    printMsgs "dialog" "Disabled Launching Videos\n\nThis also enabled Launching Images."
                    ;;
                3)
                    update_launchingvideos
                    printMsgs "dialog" "Launching Videos Updated from Retro-Arean/RetroArena-launchingvideos repository."
                    ;;
            esac
        fi
    done
}
