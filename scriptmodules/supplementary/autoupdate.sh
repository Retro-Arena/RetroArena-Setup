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

function toggle_autoupdate() {
    if [[ -e "$home/.config/autoupdate" ]]; then
        sudo systemctl stop cron.service
        crontab -u pigaming -r
        rm -rf "$home/.config/autoupdate"
        rm -rf "$home/.config/retrohub"
        rm -rf "$home/.config/setupscript"
        printMsgs "dialog" "Disabled AutoUpdate Service"
    else
        sudo systemctl start cron.service
        crontab -u pigaming "$scriptdir/scriptmodules/supplementary/autoupdate/autoupdate"
        touch "$home/.config/autoupdate"
        printMsgs "dialog" "Enabled AutoUpdate Service"
    fi
}

function toggle_setupscript() {
    if [[ -e "$home/.config/setupscript" ]]; then
        rm -rf "$home/.config/setupscript"
        printMsgs "dialog" "Disabled RetroArena-Setup AutoUpdate"
    else
        touch "$home/.config/setupscript"
        printMsgs "dialog" "Enabled RetroArena-Setup AutoUpdate\n\nThe update will occur weekly on Sundays at 03:00 UTC."
    fi
}

function toggle_retrohub() {
    if [[ -e "$home/.config/retrohub" ]]; then
        rm -rf "$home/.config/retrohub"
        printMsgs "dialog" "Disabled Retrohub AutoUpdate"
    else
        touch "$home/.config/retrohub"
        printMsgs "dialog" "Enabled Retrohub AutoUpdate\n\nThe update will occur weekly on Sundays at 03:00 UTC."
    fi
}

function gui_autoupdate() {
    while true; do
        local options=()        
        [[ -e "$home/.config/autoupdate" ]] && options+=(A "Disable AutoUpdate Service") || options+=(A "Enable AutoUpdate Service (Required)")
        [[ -e "$home/.config/setupscript" ]] && options+=(1 "Disable RetroArena-Setup AutoUpdate (Weekly)") || options+=(1 "Enable RetroArena-Setup AutoUpdate")     
        [[ -e "$home/.config/retrohub" ]] && options+=(2 "Disable Retrohub AutoUpdate (Weekly)") || options+=(2 "Enable Retrohub AutoUpdate")
        
        local cmd=(dialog --backtitle "$__backtitle" --menu "AutoUpdate: a RetroArena Exclusive" 22 86 16)
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        [[ -z "$choice" ]] && break
        if [[ -n "$choice" ]]; then
            case "$choice" in
                A)
                    toggle_autoupdate
                    ;;
                1)
                    toggle_setupscript
                    ;;
                2)
                    toggle_retrohub
                    ;;
            esac
        fi
    done
}
