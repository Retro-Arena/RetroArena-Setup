#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="lr-mame2003-plus"
rp_module_desc="Arcade emu - updated MAME 0.78 port for libretro with added game support"
rp_module_help="ROM Extension: .zip\n\nCopy your MAME roms to either $romdir/mame-libretro or\n$romdir/arcade"
rp_module_licence="NONCOM https://raw.githubusercontent.com/libretro/mame2003-plus-libretro/master/LICENSE.md"
rp_module_section="lr"

function _get_dir_name_lr-mame2003-plus() {
    echo "mame2003-plus"
}

function _get_so_name_lr-mame2003-plus() {
    echo "mame2003_plus"
}

function sources_lr-mame2003-plus() {
    gitPullOrClone "$md_build" https://github.com/libretro/mame2003-plus-libretro.git
}

function build_lr-mame2003-plus() {
    build_lr-mame2003
}

function install_lr-mame2003-plus() {
    install_lr-mame2003
}

function install_bin_lr-mame2003-plus() {
    downloadAndExtract "$__gitbins_url/lr-mame2003-plus.tar.gz" "$md_inst" 1
}

function configure_lr-mame2003-plus() {
    configure_lr-mame2003
}

function gui_lr-mame2003-plus() {
    while true; do
        local options=()
            [[ -e "$home/.config/au_lr-mame2003-plus" ]] && options+=(A "Disable lr-mame2003-plus AutoUpdate (Daily)") || options+=(A "Enable lr-mame2003-plus AutoUpdate")
        local cmd=(dialog --backtitle "$__backtitle" --menu "Choose an option" 22 76 16)
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        [[ -z "$choice" ]] && break
        case "$choice" in
            A)
                if [[ -e "$home/.config/au_service" ]]; then
                    if [[ -e "$home/.config/au_lr-mame2003-plus" ]]; then
                        rm -rf "$home/.config/au_lr-mame2003-plus"
                        printMsgs "dialog" "Disabled lr-mame2003-plus AutoUpdate"
                    else
                        touch "$home/.config/au_lr-mame2003-plus"
                        printMsgs "dialog" "Enabled lr-mame2003-plus AutoUpdate\n\nThe update will occur daily at 05:00 UTC."
                    fi
                else
                    printMsgs "dialog" "ERROR\n\nAutoUpdate Service must be enabled."
                fi
                ;;
        esac
    done
}
