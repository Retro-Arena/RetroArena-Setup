#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="fancontrol"
rp_module_desc="Change the fan settings to control cooling and fan noise."
rp_module_section="config"

function gui_fancontrol() {
    while true; do
        local cmd=(dialog --backtitle "$__backtitle" --menu "Fan Control" 22 86 16)
        local options=(
            1 "Fan Control 1 - Default"
            2 "Fan Control 2 - Medium"
            3 "Fan Control 3 - Aggressive"
        )
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        [[ -z "$choice" ]] && break
        if [[ -n "$choice" ]]; then
            case "$choice" in
                1)
                    sudo cp -r -f $scriptdir/scriptmodules/supplementary/fancontrol/fan1-default/* /sys/devices/odroid_fan.14
                    sudo cp -r -f $scriptdir/scriptmodules/supplementary/fancontrol/fan1-default/rc.local /etc
                    printMsgs "dialog" "Fan is now restored to the factory Odroid settings."
                    ;;
                2)
                    sudo cp -r -f $scriptdir/scriptmodules/supplementary/fancontrol/fan2-medium/* /sys/devices/odroid_fan.14
                    sudo cp -r -f $scriptdir/scriptmodules/supplementary/fancontrol/fan2-medium/rc.local /etc
                    printMsgs "dialog" "Fan is now set to the HIGHER COOLING RATE than the factory Odroid settings.\n\nNOTE: PERFORM AT YOUR OWN RISK. NO IMPLIED WARRANTIES."
                    ;;
                3)
                    sudo cp -r -f $scriptdir/scriptmodules/supplementary/fancontrol/fan3-aggressive/* /sys/devices/odroid_fan.14
                    sudo cp -r -f $scriptdir/scriptmodules/supplementary/fancontrol/fan3-aggressive/rc.local /etc
                    printMsgs "dialog" "Fan is now set to the most AGGRESSIVE COOLING RATE than the factory Odroid settings. The fan will become noticeably loud.\n\nNOTE: PERFORM AT YOUR OWN RISK. NO IMPLIED WARRANTIES."
                    ;;
            esac
        fi
    done
}
