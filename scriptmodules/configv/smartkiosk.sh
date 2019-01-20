#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="smartkiosk"
rp_module_desc="Enable Kiosk for RetroArch, ES, and disable the Launch Menu."
rp_module_section="config"

function gui_smartkiosk() {
    local cmd=(dialog --backtitle "$__backtitle" --menu "Smart Kiosk" 22 86 16)
    local options=(
        1 "Enable Smart Kiosk then REBOOT"
        2 "Disable Smart Kiosk then REBOOT"
    )
    local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
    
    esconfig="$HOME/.emulationstation/es_settings.cfg"
    raconfig="/opt/retroarena/configs/all/retroarch.cfg"
    lmconfig="/opt/retroarena/configs/all/runcommand.cfg"
    launching="/opt/retroarena/configs/all/launching"
    
    if [[ -n "$choice" ]]; then
        case "$choice" in
            1)
                if grep -Fq 'name="UIMode" value="Full"' "$esconfig"; then
                    sed -i -e 's:name="UIMode" value="Full":name="UIMode" value="Kiosk":g' "$esconfig"
                elif grep -Fq 'name="UIMode" value="Kid"' "$esconfig"; then
                    sed -i -e 's:name="UIMode" value="Kid":name="UIMode" value="Kiosk":g' "$esconfig"
                fi
                
                if grep -Fq 'kiosk_mode_enable = "false"' "$raconfig"; then
                    sed -i -e 's:kiosk_mode_enable = "false":kiosk_mode_enable = "true":g' "$raconfig"
                fi
                
                if grep -Fq 'disable_menu = "0"' "$lmconfig"; then
                    sed -i -e 's:disable_menu = "0":disable_menu = "1":g' "$lmconfig"
                fi
                
                if grep -Fq 'disable_joystick = "0"' "$lmconfig"; then
                    sed -i -e 's:disable_joystick = "0":disable_joystick = "1":g' "$lmconfig"
                fi
                
                if [[ -e "$launching.png" ]]; then
                    mv "$launching.png" "$launching.bak"
                fi
                
                printMsgs "dialog" "Enabled Kiosk mode for RetroArch, EmulationStation, and also disabled the Launch Menu.\n\nPress OK to REBOOT."
                reboot
                ;;
            2)
                if grep -Fq 'name="UIMode" value="Kiosk"' "$esconfig"; then
                    sed -i -e 's:name="UIMode" value="Kiosk":name="UIMode" value="Full":g' "$esconfig"
                elif grep -Fq 'name="UIMode" value="Kid"' "$esconfig"; then
                    sed -i -e 's:name="UIMode" value="Kid":name="UIMode" value="Full":g' "$esconfig"
                fi
                
                if grep -Fq 'kiosk_mode_enable = "true"' "$raconfig"; then
                    sed -i -e 's:kiosk_mode_enable = "true":kiosk_mode_enable = "false":g' "$raconfig"
                fi
                
                if grep -Fq 'disable_menu = "1"' "$lmconfig"; then
                    sed -i -e 's:disable_menu = "1":disable_menu = "0":g' "$lmconfig"
                fi
                
                if grep -Fq 'disable_joystick = "1"' "$lmconfig"; then
                    sed -i -e 's:disable_joystick = "1":disable_joystick = "0":g' "$lmconfig"
                fi
                
                if [[ -e "$launching.bak" ]]; then
                    mv "$launching.bak" "$launching.png"
                fi
                
                printMsgs "dialog" "Disabled Kiosk mode for RetroArch, EmulationStation, and also enabled the Launch Menu.\n\nPress OK to REBOOT."
                reboot
                ;;
        esac
    fi
}
