#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="yabause"
rp_module_desc="Sega Saturn Emulator"
rp_module_help="ROM Extensions: .iso .bin .zip\n\nCopy your Sega Saturn roms to $romdir/saturn\n\nCopy the required BIOS file saturn_bios_us.bin and saturn_bios_jp.bin to $biosdir"
rp_module_licence="https://github.com/devmiyax/yabause/blob/minimum_linux/yabause/COPYING"
rp_module_section="sa"
rp_module_flags=""

function depends_yabause() {
    local depends=(cmake libgles2-mesa-dev libsdl2-dev libboost-filesystem-dev libboost-system-dev libboost-locale-dev libboost-date-time-dev)
    getDepends "${depends[@]}"
}

function sources_yabause() {    
    gitPullOrClone "$md_build" https://github.com/devmiyax/yabause.git minimum_linux
}

function build_yabause() {
    mkdir build
    cd build
    if isPlatform "odroid-n2"; then
        export CFLAGS="-O2 -march=armv8-a+crc -mtune=cortex-a73.cortex-a53 -ftree-vectorize -funsafe-math-optimizations -pipe"
        cmake ../yabause -DYAB_PORTS=xu4 -DYAB_WANT_DYNAREC_DEVMIYAX=ON -DCMAKE_SYSTEM_PROCESSOR="aarch64"
    elif isPlatform "odroid-xu"; then
        export CFLAGS="-O2 -march=armv7-a -mtune=cortex-a15.cortex-a7 -mfpu=neon-vfpv4 -mfloat-abi=hard -ftree-vectorize -funsafe-math-optimizations"
        cmake ../yabause -DYAB_PORTS=xu4 -DYAB_WANT_DYNAREC_DEVMIYAX=ON -DYAB_WANT_ARM7=ON
    elif isPlatform "rockpro64"; then       
        export CFLAGS="-O2 -march=armv8-a+crc -mtune=cortex-a72.cortex-a53 -mfloat-abi=hard -ftree-vectorize -funsafe-math-optimizations -pipe"
        cmake ../yabause -DYAB_PORTS=xu4 -DYAB_WANT_DYNAREC_DEVMIYAX=ON -DYAB_WANT_ARM7=ON -DCMAKE_TOOLCHAIN_FILE=../yabause/src/xu4/rp64.cmake
    else
        exit
    fi
    make
    md_ret_require="$md_build/build/src/xu4/yabasanshiro"
}

function install_yabause() {
    md_ret_files=(
        'build/src/xu4/yabasanshiro'
    )
}

function install_bin_yabause() {
    downloadAndExtract "$__gitbins_url/yabause.tar.gz" "$md_inst" 1
}

function configure_yabause() {
    mkRomDir "saturn"
    addEmulator 1 "${md_id}-1x" "saturn" "$md_inst/yabasanshiro -a -r 3 -b /home/pigaming/RetroArena/BIOS/saturn_bios.bin -i %ROM%"
    addEmulator 1 "${md_id}-2x" "saturn" "$md_inst/yabasanshiro -a -r 2 -b /home/pigaming/RetroArena/BIOS/saturn_bios.bin -i %ROM%"
    addEmulator 1 "${md_id}-3x" "saturn" "$md_inst/yabasanshiro -a -r 1 -b /home/pigaming/RetroArena/BIOS/saturn_bios.bin -i %ROM%"
    addSystem "saturn"
}
