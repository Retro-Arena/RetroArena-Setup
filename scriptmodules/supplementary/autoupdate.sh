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
rp_module_desc="Automatically update scripts and Github repositories"
rp_module_section="config"

function gui_autoupdate() {
    while true; do
        local options=()
        [[ -e "$home/.config/autoupdate" ]] && options+=(1 "Disable AutoUpdate Service") || options+=(1 "Enable AutoUpdate Service (Required)")
        [[ -e "$home/.config/setupscript" ]] && options+=(2 "Disable RetroArena-Setup AutoUpdate (Weekly)") || options+=(2 "Enable RetroArena-Setup AutoUpdate")
        options+=(3 "Enable Core Packages AutoUpdate")
        
        local cmd=(dialog --backtitle "$__backtitle" --menu "AutoUpdate: a RetroArena Exclusive" 22 86 16)
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        [[ -z "$choice" ]] && break
        if [[ -n "$choice" ]]; then
            case "$choice" in
                1)
                    if [[ -e "$home/.config/au_service" ]]; then
                        sudo systemctl stop cron.service
                        crontab -u pigaming -r
                        rm -rf "$home/.config/au_*"
                        printMsgs "dialog" "Disabled AutoUpdate Service.\n\nPer core AutoUpdates is now automatically disabled."
                    else
                        sudo systemctl start cron.service
                        crontab -u pigaming "$scriptdir/scriptmodules/supplementary/autoupdate/autoupdate"
                        touch "$home/.config/au_service"
                        printMsgs "dialog" "Enabled AutoUpdate Service.\n\nPer core AutoUpdates is now available in Settings."
                    fi
                    ;;
                2)
                    if [[ -e "$home/.config/au_service" ]]; then
                        if [[ -e "$home/.config/au_setupscript" ]]; then
                            rm -rf "$home/.config/au_setupscript"
                            printMsgs "dialog" "Disabled RetroArena-Setup AutoUpdate"
                        else
                            touch "$home/.config/au_setupscript"
                            printMsgs "dialog" "Enabled RetroArena-Setup AutoUpdate\n\nThe update will occur weekly on Sundays at 03:00 UTC."
                        fi
                    else
                        printMsgs "dialog" "ERROR\n\nYou must enable the required AutoUpdate Service."
                    ;;
                3)
                    printMsgs "dialog" "Enabled Core Packages AutoUpdate\n\nPer core package is available in Settings. Only certain cores are available for auto updates at this time."
                    ;;
            esac
        fi
    done
}
