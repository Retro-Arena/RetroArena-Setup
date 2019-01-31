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
    
    # enable on install
    enable_retrohub
}

function configure_retrohub() {
    local rhdir="$datadir/retrohub"
    addSystem retrohub
    setESSystem "RetroHub" "retrohub" "$rhdir" ".png" "fbi --noverbose -t 15 -1 %ROM% >/dev/null 2>&1" "" "retrohub"
}

function enable_retrohub() {
    sudo cp -R "$scriptdir/scriptmodules/supplementary/retrohub/rhupdate" "/etc/cron.daily"
    sudo chmod +x "/etc/cron.daily/rhupdate"
}

function disable_retrohub() {
    sudo rm -rf "/etc/cron.daily/rhupdate"
}

function remove_retrohub() {
    rm -rf "$datadir/retrohub"
    delSystem retrohub
    disable_retrohub
}

function gui_retrohub() {
    while true; do
        local options=(
            1 "Enable RetroHub Daily Update (default)"
            2 "Disable RetroHub Daily Update"
        )
        local cmd=(dialog --backtitle "$__backtitle" --menu "Choose an option" 22 76 16)
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        [[ -z "$choice" ]] && break
        case "$choice" in
            1)
                enable_retrohub
                printMsgs "dialog" "Enabled RetroHub Daily Update"
                ;;
            2)
                disable_retrohub
                printMsgs "dialog" "Disabled RetroHub Daily Update"
                ;;
        esac
    done
}
