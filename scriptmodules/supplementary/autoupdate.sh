#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="autoupdate"
rp_module_desc="Automatic updates of Setup Script and Retrohub"
rp_module_section="config"

function enable_autoupdate() {
    sudo systemctl start cron.service
    crontab -u pigaming "$scriptdir/scriptmodules/supplementary/autoupdate/autoupdate"
}

function disable_autoupdate() {
    sudo systemctl stop cron.service
    crontab -r
}

function gui_autoupdate() {
    local cmd=(dialog --backtitle "$__backtitle" --menu "---EXCLUSIVE--- RetroArena Auto Update ---EXCLUSIVE---" 22 86 16)
    local options=(
        1 "Enable Auto-update Service"
        2 "Disable Auto-update Service"
        3 "Enable RetroArena-Setup Auto-update (Weekly)"
        4 "Disable RetroArena-Setup Auto-update"
        5 "Enable Retrohub Auto-update (Weekly)"
        6 "Disable Retrohub Auto-update"
    )
    local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
    if [[ -n "$choice" ]]; then
        case "$choice" in
            1)
                enable_autoupdate
                touch "$home/.config/bgmtoggle"
                printMsgs "dialog" "Enabled Auto-update Service"
                ;;
            2)
                disable_autoupdate
                rm -rf "$home/.config/bgmtoggle"
                printMsgs "dialog" "Disabled Auto-update Service"
                ;;
            3)
                touch "$home/.config/setupscript"
                printMsgs "dialog" "Enabled RetroArena-Setup Auto-update.\n\nThe update will occur weekly on Sundays at 03:00 UTC."
                ;;
            4)
                rm -rf "$home/.config/setupscript"
                printMsgs "dialog" "Disabled RetroArena-Setup Auto-update"
                ;;
            5)
                touch "$home/.config/retrohub"
                printMsgs "dialog" "Enabled Retrohub Auto-update\n\nThe update will occur weekly on Sundays at 03:00 UTC."
                ;;
            6)
                rm -rf "$home/.config/retrohub"
                printMsgs "dialog" "Disabled Retrohub Auto-update"
                ;;
        esac
    fi
}
