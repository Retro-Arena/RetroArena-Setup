#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="caseconfig"
rp_module_desc="Case image selector for OGST - choose the type of image displayed upon game launch such as console system, boxart, cartart, snap, wheel, screenshot, or marquee."
rp_module_section="config"

function gui_caseconfig() {
    local cmd=(dialog --backtitle "$__backtitle" --menu "OGST Case Image Selector" 22 86 16)
    local options=(
        1 "Console System         default"
        2 "Motion Blue Boxart     roms/system/boxart/ROM.png"
        3 "Motion Blue Cartart    roms/system/cartart/ROM.png"
        4 "Motion Blue Snap       roms/system/snap/ROM.png"
        5 "Motion Blue Wheel      roms/system/wheel/ROM.png"
        6 "Skyscraper Marquee     roms/system/media/marquees/ROM.png"
        7 "Skyscraper Screenshot  roms/system/media/screenshots/ROM.png"
        8 "Skraper Marquee        roms/system/media/marquee/ROM.png"
        9 "Skraper Screenshot     roms/system/media/images/ROM.png"
        10 "Selph's Marquee        roms/system/images/ROM-marquee.png"
        11 "Selph's Screenshot     roms/system/images/ROM-image.jpg"
        12 "Disabled               disables the screen permanently"
    )
    local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
    if [[ -n "$choice" ]]; then
        case "$choice" in
            1)
                rm -rf $HOME/.config/ogst*
                touch $HOME/.config/ogst001
                touch /usr/local/share/ogst/ogst000
                printMsgs "dialog" "Activated"
                ;;
            2)
                rm -rf $HOME/.config/ogst*
                touch $HOME/.config/ogst002
                touch /usr/local/share/ogst/ogst000
                printMsgs "dialog" "Activated"
                ;;
            3)
                rm -rf $HOME/.config/ogst*
                touch $HOME/.config/ogst003
                touch /usr/local/share/ogst/ogst000
                printMsgs "dialog" "Activated"
                ;;
            4)
                rm -rf $HOME/.config/ogst*
                touch $HOME/.config/ogst004
                touch /usr/local/share/ogst/ogst000
                printMsgs "dialog" "Activated"
                ;;
            5)
                rm -rf $HOME/.config/ogst*
                touch $HOME/.config/ogst005
                touch /usr/local/share/ogst/ogst000
                printMsgs "dialog" "Activated"
                ;;
            6)
                rm -rf $HOME/.config/ogst*
                touch $HOME/.config/ogst006
                touch /usr/local/share/ogst/ogst000
                printMsgs "dialog" "Activated"
                ;;
            7)
                rm -rf $HOME/.config/ogst*
                touch $HOME/.config/ogst007
                printMsgs "dialog" "Activated"
                ;;
            8)
                rm -rf $HOME/.config/ogst*
                touch $HOME/.config/ogst008
                printMsgs "dialog" "Activated"
                ;;
            9)
                rm -rf $HOME/.config/ogst*
                touch $HOME/.config/ogst009
                touch /usr/local/share/ogst/ogst000
                printMsgs "dialog" "Activated"
                ;;
            10)
                rm -rf $HOME/.config/ogst*
                touch $HOME/.config/ogst010
                touch /usr/local/share/ogst/ogst000
                printMsgs "dialog" "Activated"
                ;;
            11)
                rm -rf $HOME/.config/ogst*
                touch $HOME/.config/ogst011
                touch /usr/local/share/ogst/ogst000
                printMsgs "dialog" "Activated"
                ;;
            12)
                rm -rf $HOME/.config/ogst*
                rm -rf /usr/local/share/ogst/ogst000
                printMsgs "dialog" "Disabled. Case image will no longer display."
                ;;
        esac
    fi
}
