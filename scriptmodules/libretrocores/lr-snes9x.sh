#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="lr-snes9x"
rp_module_desc="Super Nintendo emu - Snes9x (current) port for libretro"
rp_module_help="ROM Extensions: .bin .smc .sfc .fig .swc .mgd .zip\n\nCopy your SNES roms to $romdir/snes"
rp_module_licence="NONCOM https://raw.githubusercontent.com/libretro/snes9x/master/docs/snes9x-license.txt"
rp_module_section="lr"

function sources_lr-snes9x() {
    gitPullOrClone "$md_build" https://github.com/libretro/snes9x.git
}

function build_lr-snes9x() {
    cd libretro
    make clean
    local platform=""
    isPlatform "arm" && platform+="armv"
    isPlatform "neon" && platform+="neon"
    if [[ -n "$platform" ]]; then
        CXXFLAGS+=" -DARM" make platform="$platform"
    else
        make
    fi
    md_ret_require="$md_build/libretro/snes9x_libretro.so"
}

function install_lr-snes9x() {
    md_ret_files=(
        'libretro/snes9x_libretro.so'
        'docs'
    )
}

function install_bin_lr-snes9x() {
    downloadAndExtract "$__gitbins_url/lr-snes9x.tar.gz" "$md_inst" 1
}

function configure_lr-snes9x() {
    local system
    for system in snes sfc sufami snesmsu1 satellaview; do
        mkRomDir "$system"
        ensureSystemretroconfig "$system"
        addEmulator 1 "$md_id" "$system" "$md_inst/snes9x_libretro.so"
        addSystem "$system"
    done
}

function gui_lr-snes9x() {
    while true; do
        local options=()
            [[ -e "$home/.config/au_lr-snes9x" ]] && options+=(A "Disable lr-snes9x AutoUpdate (Daily)") || options+=(A "Enable lr-snes9x AutoUpdate")
        local cmd=(dialog --backtitle "$__backtitle" --menu "Choose an option" 22 76 16)
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        [[ -z "$choice" ]] && break
        case "$choice" in
            A)
                if [[ -e "$home/.config/au_service" ]]; then
                    if [[ -e "$home/.config/au_lr-snes9x" ]]; then
                        rm -rf "$home/.config/au_lr-snes9x"
                        printMsgs "dialog" "Disabled lr-snes9x AutoUpdate"
                    else
                        touch "$home/.config/au_lr-snes9x"
                        printMsgs "dialog" "Enabled lr-snes9x AutoUpdate\n\nThe update will occur daily at 05:00 UTC."
                    fi
                else
                    printMsgs "dialog" "ERROR\n\nAutoUpdate Service must be enabled."
                fi
                ;;
        esac
    done
}
