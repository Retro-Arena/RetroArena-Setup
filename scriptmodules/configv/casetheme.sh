#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="casetheme"
rp_module_desc="Case theme selector for OGST - choose different theme packs when Console System is selected in Case Config."
rp_module_section="config"

function gui_casetheme() {
    local cmd=(dialog --backtitle "$__backtitle" --menu "OGST Case Theme Selector" 22 86 16)
    local options=(
        1 "Retro-Arena/ogst-retroarena (manning)"
        2 "Retro-Arena/greatest-hits (waweedman)"
        3 "Retro-Arena/wiitro-arena (waweedman)"
    )
    local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
    if [[ -n "$choice" ]]; then
        case "$choice" in
            1)
                cd "$HOME/.emulationstation/ogst_themes"
                rm -rf ogst-retroarena
                sudo git clone https://github.com/Retro-Arena/ogst-retroarena ogst-retroarena &> /dev/null
                sudo chown -R pigaming:pigaming "$HOME/.emulationstation/ogst_themes/ogst-retroarena"
                printMsgs "dialog" "Installed"
                ;;
            2)
                cd "$HOME/.emulationstation/ogst_themes"
                rm -rf ogst-retroarena
                sudo git clone https://github.com/Retro-Arena/ogst-greatest-hits ogst-retroarena &> /dev/null
                sudo chown -R pigaming:pigaming "$HOME/.emulationstation/ogst_themes/ogst-retroarena"
                printMsgs "dialog" "Installed"
                ;;
            3)
                cd "$HOME/.emulationstation/ogst_themes"
                rm -rf ogst-retroarena
                sudo git clone https://github.com/Retro-Arena/ogst-wiitro-arena ogst-retroarena &> /dev/null
                sudo chown -R pigaming:pigaming "$HOME/.emulationstation/ogst_themes/ogst-retroarena"
                printMsgs "dialog" "Installed"
                ;;
        esac
    fi
}
