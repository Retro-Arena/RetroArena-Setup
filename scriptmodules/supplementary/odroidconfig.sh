#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="odroidconfig"
rp_module_desc="Expand filesystem, configure network, boot, localisation, SSH"
rp_module_section="config"
rp_module_flags="!rockpro64"

function set720p() {
    sed -i 's/setenv hdmimode "1080p60hz"/setenv hdmimode "720p60hz"/g' /media/boot/boot.ini
    printMsgs "dialog" "Resolution is now set at 720p. Restart the system to apply."
}

function set1080p() {
    sed -i 's/setenv hdmimode "720p60hz"/setenv hdmimode "1080p60hz"/g' /media/boot/boot.ini
    printMsgs "dialog" "Resolution is now set at 1080p. Restart the system to apply."
}

function gui_odroidconfig() {
    if grep -q "ODROID-N2" /sys/firmware/devicetree/base/model 2>/dev/null; then
        while true; do
            local options=(
                1 "Enable 1080p (allows Kodi to launch, average performance)"
                2 "Enable  720p (disallows Kodi to launch, best performance)"
            )
            local cmd=(dialog --backtitle "$__backtitle" --menu "Choose an option" 22 76 16)
            local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
            [[ -z "$choice" ]] && break
            case "$choice" in
                1)
                    set1080p
                    ;;
                2)
                    set720p
                    ;;
            esac
        done
    else
        source /usr/bin/odroid-config
    fi
}
