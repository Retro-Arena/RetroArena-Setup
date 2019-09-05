#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="lr-quicknes"
rp_module_desc="NES emulator - QuickNES Port for libretro"
rp_module_help="ROM Extensions: .nes .zip\n\nCopy your NES roms to $romdir/nes"
rp_module_licence="GPL2"
rp_module_section="lr"

function sources_lr-quicknes() {
    gitPullOrClone "$md_build" https://github.com/libretro/QuickNES_Core.git
}

function build_lr-quicknes() {
    make clean
    make
    md_ret_require="$md_build/quicknes_libretro.so"
}

function install_lr-quicknes() {
    md_ret_files=(
        'quicknes_libretro.so'
    )
}

function install_bin_lr-quicknes() {
    downloadAndExtract "$__gitbins_url/lr-quicknes.tar.gz" "$md_inst" 1
}

function configure_lr-quicknes() {
    mkRomDir "nes"
    ensureSystemretroconfig "nes"

    local def=0
    isPlatform "armv6" && def=1

    addEmulator "$def" "$md_id" "nes" "$md_inst/quicknes_libretro.so"
    addSystem "nes"
}

function gui_lr-quicknes() {
    while true; do
        local options=()
            [[ -e "$home/.config/au_lr-quicknes" ]] && options+=(A "Disable lr-quicknes AutoUpdate") || options+=(A "Enable lr-quicknes AutoUpdate")
        local cmd=(dialog --backtitle "$__backtitle" --menu "Choose an option" 22 76 16)
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        [[ -z "$choice" ]] && break
        case "$choice" in
            A)
                if [[ -e "$home/.config/au_service" ]]; then
                    if [[ -e "$home/.config/au_lr-quicknes" ]]; then
                        rm -rf "$home/.config/au_lr-quicknes"
                        printMsgs "dialog" "Disabled lr-quicknes AutoUpdate"
                    else
                        touch "$home/.config/au_lr-quicknes"
                        printMsgs "dialog" "Enabled lr-quicknes AutoUpdate\n\nThe update will occur daily at 05:00 UTC."
                    fi
                else
                    printMsgs "dialog" "ERROR\n\nAutoUpdate Service must be enabled."
                fi
                ;;
        esac
    done
}
