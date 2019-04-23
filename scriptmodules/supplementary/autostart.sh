#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="autostart"
rp_module_desc="Auto-start EmulationStation"
rp_module_section="config"

function _update_hook_autostart() {
    if [[ -f /etc/profile.d/10-emulationstation.sh ]]; then
        enable_autostart
    fi
}

function _autostart_script_autostart() {
    local mode="$1"
    # delete old startup script
    rm -f /etc/profile.d/10-emulationstation.sh

    local script="$configdir/all/autostart.sh"

    cat >/etc/profile.d/10-retroarena.sh <<_EOF_
# launch our autostart apps (if we are on the correct tty)
if [ "\`tty\`" = "/dev/tty1" ] && [ "\$USER" = "$user" ]; then
    bash "$script"
fi
_EOF_

    touch "$script"
    # delete any previous entries for emulationstation
    sed -i '/#auto/d' "$script"
    # make sure there is a newline
    sed -i '$a\' "$script"
    case "$mode" in
        es|*)
            echo "emulationstation #auto" >>"$script"
            ;;
    esac
    chown $user:$user "$script"
}

function enable_autostart() {
    local mode="$1"

    if [[ "$(cat /proc/1/comm)" == "systemd" ]]; then
        mkdir -p /etc/systemd/system/getty@tty1.service.d/
        cat >/etc/systemd/system/getty@tty1.service.d/autologin.conf <<_EOF_
[Service]
ExecStart=
ExecStart=-/sbin/agetty --skip-login --noclear --noissue --login-options "-f pigaming" %I \$TERM
Type=idle
_EOF_
    fi

    _autostart_script_autostart "$mode"
}

function disable_autostart() {
    local login_type="$1"
    [[ -z "$login_type" ]] && login_type="B2"
    if [[ "$(cat /proc/1/comm)" == "systemd" ]]; then
        rm -f /etc/systemd/system/getty@tty1.service.d/autologin.conf
        systemctl set-default graphical.target
        systemctl enable lightdm.service
    fi
    rm -f /etc/profile.d/10-emulationstation.sh
    rm -f /etc/profile.d/10-retroarena.sh
}

function remove_autostart() {
    disable_autostart
}

function config_autostart() {
    cp "$scriptdir/configs/all/autostart.sh" "$md_conf_root/all"
}

function gui_autostart() {
    cmd=(dialog --backtitle "$__backtitle" --menu "Choose the desired boot behaviour." 22 76 16)
    while true; do
        options=(
            1 "Start EmulationStation at boot"
            2 "Reset autostart script"
            E "Manually edit $configdir/autostart.sh"
        )
        choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        if [[ -n "$choice" ]]; then
            case "$choice" in
                1)
                    enable_autostart
                    printMsgs "dialog" "EmulationStation is set to launch at boot."
                    ;;
                2)
                    config_autostart
                    printMsgs "dialog" "Completed the reset of autostart script."
                    ;;
                E)
                    editFile "$configdir/all/autostart.sh"
                    ;;
            esac
        else
            break
        fi
    done
}
