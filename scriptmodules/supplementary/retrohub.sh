#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="retrohub"
rp_module_desc="Scan QR code retro gaming links using your mobile device"
rp_module_section="opt"

function install_bin_retrohub() {
    local rhdir="$datadir/retrohub"
    gitPullOrClone "$rhdir" https://github.com/Retro-Arena/retrohub.git
    chown -R $user:$user "$rhdir"
    touch "$home/.config/retrohub"
}

function configure_retrohub() {
    local rhdir="$datadir/retrohub"
    addSystem retrohub
    setESSystem "RetroHub" "retrohub" "$rhdir" ".png" "fbi --noverbose -t 15 -1 %ROM% >/dev/null 2>&1" "" "retrohub"
}

function remove_retrohub() {
    rm -rf "$datadir/retrohub"
    delSystem retrohub
    rm -rf "$home/.config/retrohub"
}

function gui_retrohub() {
    while true; do
        local options=()
            [[ -e "$home/.config/au_retrohub" ]] && options+=(A "Disable retrohub AutoUpdate (Daily)") || options+=(A "Enable retrohub AutoUpdate")
        local cmd=(dialog --backtitle "$__backtitle" --menu "Choose an option" 22 76 16)
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        [[ -z "$choice" ]] && break
        case "$choice" in
            A)
                if [[ -e "$home/.config/au_service" ]]; then
                    if [[ -e "$home/.config/au_retrohub" ]]; then
                        rm -rf "$home/.config/au_retrohub"
                        printMsgs "dialog" "Disabled retrohub AutoUpdate"
                    else
                        touch "$home/.config/au_retrohub"
                        printMsgs "dialog" "Enabled retrohub AutoUpdate\n\nThe update will occur daily at 05:00 UTC."
                    fi
                fi
                ;;
        esac
    done
}
