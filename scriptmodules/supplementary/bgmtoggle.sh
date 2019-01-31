#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="bgmtoggle"
rp_module_desc="Enable or disable the background music feature."
rp_module_section="config"

function gui_bgmtoggle() {
    local cmd=(dialog --backtitle "$__backtitle" --menu "BGM Toggle" 22 86 16)
    local options=(
        1 "Enable BGM"
        2 "Disable BGM"
    )
    local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
    if [[ -n "$choice" ]]; then
        case "$choice" in
            1)
                pkill -CONT mpg123
                touch "$home/.config/bgmtoggle"
                printMsgs "dialog" "Background music is now enabled."
                ;;
            2)
                pkill -STOP mpg123
                rm -rf "$home/.config/bgmtoggle"
                printMsgs "dialog" "Background music is now disabled."
                ;;
        esac
    fi
}
