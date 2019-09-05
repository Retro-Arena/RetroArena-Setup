#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="lr-nestopia"
rp_module_desc="NES emu - Nestopia (enhanced) port for libretro"
rp_module_help="ROM Extensions: .nes .zip\n\nCopy your NES roms to $romdir/nes\n\nFor the Famicom Disk System copy your roms to $romdir/fds\n\nFor the Famicom Disk System copy the required BIOS file disksys.rom to $biosdir"
rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/nestopia/master/COPYING"
rp_module_section="lr"

function sources_lr-nestopia() {
    gitPullOrClone "$md_build" https://github.com/libretro/nestopia.git
}

function build_lr-nestopia() {
    cd libretro
    rpSwap on 512
    make clean
    make
    rpSwap off
    md_ret_require="$md_build/libretro/nestopia_libretro.so"
}

function install_lr-nestopia() {
    md_ret_files=(
        'libretro/nestopia_libretro.so'
        'NstDatabase.xml'
        'COPYING'
    )
}

function install_bin_lr-nestopia() {
    downloadAndExtract "$__gitbins_url/lr-nestopia.tar.gz" "$md_inst" 1
}

function configure_lr-nestopia() {
    mkRomDir "nes"
    mkRomDir "fds"
    mkRomDir "famicom"
    ensureSystemretroconfig "nes"
    ensureSystemretroconfig "fds"
    ensureSystemretroconfig "famicom"

    cp NstDatabase.xml "$biosdir/"
    chown $user:$user "$biosdir/NstDatabase.xml"

    addEmulator 0 "$md_id" "nes" "$md_inst/nestopia_libretro.so"
    addEmulator 1 "$md_id" "fds" "$md_inst/nestopia_libretro.so"
    addEmulator 1 "$md_id" "famicom" "$md_inst/nestopia_libretro.so"
    addSystem "nes"
    addSystem "fds"
    addSystem "famicom"
}

function gui_lr-nestopia() {
    while true; do
        local options=()
            [[ -e "$home/.config/au_lr-nestopia" ]] && options+=(A "Disable lr-nestopia AutoUpdate") || options+=(A "Enable lr-nestopia AutoUpdate")
        local cmd=(dialog --backtitle "$__backtitle" --menu "Choose an option" 22 76 16)
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        [[ -z "$choice" ]] && break
        case "$choice" in
            A)
                if [[ -e "$home/.config/au_service" ]]; then
                    if [[ -e "$home/.config/au_lr-nestopia" ]]; then
                        rm -rf "$home/.config/au_lr-nestopia"
                        printMsgs "dialog" "Disabled lr-nestopia AutoUpdate"
                    else
                        touch "$home/.config/au_lr-nestopia"
                        printMsgs "dialog" "Enabled lr-nestopia AutoUpdate\n\nThe update will occur daily at 05:00 UTC."
                    fi
                else
                    printMsgs "dialog" "ERROR\n\nAutoUpdate Service must be enabled."
                fi
                ;;
        esac
    done
}
