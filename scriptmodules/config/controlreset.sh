#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="controlreset"
rp_module_desc="Reset controller configurations to factory default"
rp_module_section="config"

source ./$scriptdir/scriptmodules/supplementary/emulationstation.sh

function gui_controlreset() {
    local cmd=(dialog --backtitle "$__backtitle" --menu "Controller Reset" 22 86 16)
    local options=(
        1 "Reset controller to factory default then REBOOT."
    )
    local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
    if [[ -n "$choice" ]]; then
        case "$choice" in
            1)
                clear_input_emulationstation
                sleep 3
                sudo reboot
                ;;
        esac
    fi
}
