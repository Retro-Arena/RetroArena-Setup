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
rp_module_desc="AutoUpdate Setup Script and Core Packages"
rp_module_section="config"

function gui_autoupdate() {
    while true; do
        local options=()
            [[ -e "$home/.config/au_service" ]] && options+=(1 "Disable AutoUpdate Service") || options+=(1 "Enable AutoUpdate Service (Required)")
            [[ -e "$home/.config/au_setupscript" ]] && options+=(2 "Disable AutoUpdate of Setup Scripts") || options+=(2 "Enable AutoUpdate of Setup Scripts")
        
        local cmd=(dialog --backtitle "$__backtitle" --menu "AutoUpdate: a RetroArena Exclusive" 22 86 16)
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        [[ -z "$choice" ]] && break
        if [[ -n "$choice" ]]; then
            case "$choice" in
                1)
                    if [[ -e "$home/.config/au_service" ]]; then
                        sudo systemctl stop cron.service
                        crontab -u pigaming -r
                        rm -rf $home/.config/au_*
                        rm -rf $home/.config/auc_*
                        printMsgs "dialog" "Disabled AutoUpdate Service\n\nAutoUpdate is now also disabled for all cores."
                    else
                        sudo timedatectl set-timezone UTC
                        sudo systemctl start cron.service
                        crontab -u pigaming "$scriptdir/scriptmodules/supplementary/autoupdate/autoupdate"
                        touch "$home/.config/au_service"
                        printMsgs "dialog" "Enabled AutoUpdate Service\n\nAutoUpdate must be enabled per core and is available in Settings. Only certain cores can be auto updated.\n\nThe system timezone is now set to Coordinated Universal Time (UTC)."
                    fi
                    ;;
                2)
                    if [[ -e "$home/.config/au_service" ]]; then
                        if [[ -e "$home/.config/au_setupscript" ]]; then
                            rm -rf "$home/.config/au_setupscript"
                            printMsgs "dialog" "Disabled RetroArena-Setup AutoUpdate"
                        else
                            touch "$home/.config/au_setupscript"
                            printMsgs "dialog" "Enabled RetroArena-Setup AutoUpdate\n\nThe update will occur daily at 10:00 UTC / 03:00 PT."
                        fi
                    else
                        printMsgs "dialog" "ERROR\n\nAutoUpdate Service must be enabled."
                    fi
                    ;;
            esac
        fi
    done
}
