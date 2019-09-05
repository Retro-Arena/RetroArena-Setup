#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="lr-yabasanshiro"
rp_module_desc="Sega Saturn Emulator"
rp_module_help="ROM Extensions: .iso .bin .zip\n\nCopy your Sega Saturn roms to $romdir/saturn\n\nCopy the required BIOS file saturn_bios_us.bin and saturn_bios_jp.bin to $biosdir"
rp_module_licence="https://github.com/devmiyax/yabause/blob/minimum_linux/yabause/COPYING"
rp_module_section="lr"
rp_module_flags=""

function sources_lr-yabasanshiro() {
    #gitPullOrClone "$md_build" https://github.com/devmiyax/yabause.git minimum_linux
    gitPullOrClone "$md_build" https://github.com/libretro/yabause.git yabasanshiro
    cd "$md_build/yabause"
}

function build_lr-yabasanshiro() {
    if isPlatform "odroid-n2"; then
        make -j5 -C yabause/src/libretro/ platform=odroid-n2
    elif isPlatform "odroid-xu"; then
        make -j5 -C yabause/src/libretro/ platform=odroid BOARD="ODROID-XU3"
    elif isPlatform "rockpro64"; then       
        make -j5 -C yabause/src/libretro/ platform=rockpro64
    else
        exit
    fi
    md_ret_require="$md_build/yabause/src/libretro/yabasanshiro_libretro.so"
}

function install_lr-yabasanshiro() {
    md_ret_files=(
        'yabause/src/libretro/yabasanshiro_libretro.so'
    )
}

function install_bin_lr-yabasanshiro() {
    downloadAndExtract "$__gitbins_url/lr-yabasanshiro.tar.gz" "$md_inst" 1
}

function configure_lr-yabasanshiro() {    
    mkRomDir "saturn"
    ensureSystemretroconfig "saturn"
    addEmulator 1 "$md_id" "saturn" "$md_inst/yabasanshiro_libretro.so"
    addSystem "saturn"
    
    # set core options
    setRetroArchCoreOption "${dir_name}yabasanshiro_addon_cart" "4M_extended_ram"
    setRetroArchCoreOption "${dir_name}yabasanshiro_force_hle_bios" "disabled"
    setRetroArchCoreOption "${dir_name}yabasanshiro_frameskip" "disabled"
    setRetroArchCoreOption "${dir_name}yabasanshiro_multitap_port1" "disabled"
    setRetroArchCoreOption "${dir_name}yabasanshiro_multitap_port2" "disabled"
    setRetroArchCoreOption "${dir_name}yabasanshiro_polygon_mode" "perspective_correction"
    setRetroArchCoreOption "${dir_name}yabasanshiro_resolution_mode" "original"
    setRetroArchCoreOption "${dir_name}yabasanshiro_rbg_use_compute_shader" "disabled"
    setRetroArchCoreOption "${dir_name}yabasanshiro_sh2coretype" "dynarec"
    setRetroArchCoreOption "${dir_name}yabasanshiro_videoformattype" "NTSC"
}

function gui_lr-yabasanshiro() {
    while true; do
        local options=()
            [[ -e "$home/.config/au_lr-yabasanshiro" ]] && options+=(A "Disable lr-yabasanshiro AutoUpdate") || options+=(A "Enable lr-yabasanshiro AutoUpdate")
        local cmd=(dialog --backtitle "$__backtitle" --menu "Choose an option" 22 76 16)
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        [[ -z "$choice" ]] && break
        case "$choice" in
            A)
                if [[ -e "$home/.config/au_service" ]]; then
                    if [[ -e "$home/.config/au_lr-yabasanshiro" ]]; then
                        rm -rf "$home/.config/au_lr-yabasanshiro"
                        printMsgs "dialog" "Disabled lr-yabasanshiro AutoUpdate"
                    else
                        touch "$home/.config/au_lr-yabasanshiro"
                        printMsgs "dialog" "Enabled lr-yabasanshiro AutoUpdate\n\nThe update will occur daily at 05:00 UTC."
                    fi
                else
                    printMsgs "dialog" "ERROR\n\nAutoUpdate Service must be enabled."
                fi
                ;;
        esac
    done
}
