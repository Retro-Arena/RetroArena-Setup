#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="audioswitch"
rp_module_desc="Switch between HDMI or USB Audio"
rp_module_section="config"
rp_module_flags="!rockpro64 !odroid-n2"

function install_audioswitch() {
    cp "$md_build/audioswitch/audioswitch" "/bin/audioswitch"
    chmod a+x "/bin/audioswitch"
}

function remove_audioswitch() {
    rm -rf "/bin/audioswitch"
}

function enable_audioswitch() {
    sleep 1
	sudo su -l pigaming audioswitch
}

function gui_audioswitch() {
    while true; do
        local options=(
            1 "Toggle AudioSwitch"
            2 "Install AudioSwitch"
            3 "Remove AudioSwitch"
        )
        local cmd=(dialog --backtitle "$__backtitle" --menu "Choose an option" 22 76 16)
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        [[ -z "$choice" ]] && break
        case "$choice" in
            1)
                enable_audioswitch
                printMsgs "dialog" "Audio is now switched to either HDMI or USB."
                ;;
            2)
                install_audioswitch
                printMsgs "dialog" "AudioSwitch is now installed."
                ;;
            3)
                remove_audioswitch
                printMsgs "dialog" "AudioSwitch is now removed."
                ;;
        esac
    done
}
