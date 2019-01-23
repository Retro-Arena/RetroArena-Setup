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

function gui_controlreset() {
    local cmd=(dialog --backtitle "$__backtitle" --menu "Controller Reset" 22 86 16)
    local options=(
        1 "Reset controller to factory default then REBOOT"
    )
    local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
    if [[ -n "$choice" ]]; then
        case "$choice" in
            1)
                rm -rf /opt/retroarena/configs/all/retroarch-joypads/*
                rm -rf $home/.emulationstation/es_input.cfg
                cp $scriptdir/scriptmodules/supplementary/emulationstation/es_input_reset.cfg $home/.emulationstation/es_input.cfg
                dos2unix $home/.emulationstation/es_input.cfg
                chmod a+x $home/.emulationstation/es_input.cfg
                chown pigaming:pigaming $home/.emulationstation/es_input.cfg
                reboot
                ;;
        esac
    fi
}