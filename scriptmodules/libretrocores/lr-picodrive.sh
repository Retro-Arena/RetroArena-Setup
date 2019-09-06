#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="lr-picodrive"
rp_module_desc="Sega 8/16 bit emu - picodrive arm optimised libretro core"
rp_module_help="ROM Extensions: .32x .iso .cue .sms .smd .bin .gen .md .sg .zip\n\nCopy your Megadrive / Genesis roms to $romdir/megadrive\nMasterSystem roms to $romdir/mastersystem\nSega 32X roms to $romdir/sega32x and\nSegaCD roms to $romdir/segacd\nThe Sega CD requires the BIOS files us_scd1_9210.bin, eu_mcd1_9210.bin, jp_mcd1_9112.bin copied to $biosdir"
rp_module_licence="NONCOM https://raw.githubusercontent.com/libretro/picodrive/master/COPYING"
rp_module_section="lr"

function sources_lr-picodrive() {
    gitPullOrClone "$md_build" https://github.com/libretro/picodrive.git
}

function build_lr-picodrive() {
    local params=()
    isPlatform "arm" && params+=(platform=armv ARM_ASM=1 use_fame=0 use_cyclone=1 use_sh2drc=1 use_svpdrc=1)
    isPlatform "odroid-n2" && params+=(platform=arm64)
    make clean
    make -f Makefile.libretro "${params[@]}"
    md_ret_require="$md_build/picodrive_libretro.so"
}

function install_lr-picodrive() {
    md_ret_files=(
        'AUTHORS'
        'COPYING'
        'picodrive_libretro.so'
        'README'
    )
}

function install_bin_lr-picodrive() {
    downloadAndExtract "$__gitbins_url/lr-picodrive.tar.gz" "$md_inst" 1
}

function configure_lr-picodrive() {
    local system
    for system in genesis megadrive megadrive-japan mastersystem segacd sc-3000 markiii sega32x; do
        mkRomDir "$system"
        ensureSystemretroconfig "$system"
        addEmulator 1 "$md_id" "$system" "$md_inst/picodrive_libretro.so"
        addSystem "$system"
    done
}

function gui_lr-picodrive() {
    while true; do
        local options=()
            [[ -e "$home/.config/auc_lr-picodrive" ]] && options+=(A "Disable lr-picodrive AutoUpdate") || options+=(A "Enable lr-picodrive AutoUpdate")
        local cmd=(dialog --backtitle "$__backtitle" --menu "Choose an option" 22 76 16)
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        [[ -z "$choice" ]] && break
        case "$choice" in
            A)
                if [[ -e "$home/.config/au_service" ]]; then
                    if [[ -e "$home/.config/auc_lr-picodrive" ]]; then
                        rm -rf "$home/.config/auc_lr-picodrive"
                        printMsgs "dialog" "Disabled lr-picodrive AutoUpdate"
                    else
                        touch "$home/.config/auc_lr-picodrive"
                        printMsgs "dialog" "Enabled lr-picodrive AutoUpdate\n\nThe update will occur daily at 10:00 UTC / 03:00 PT."
                    fi
                else
                    printMsgs "dialog" "ERROR\n\nAutoUpdate Service must be enabled."
                fi
                ;;
        esac
    done
}
