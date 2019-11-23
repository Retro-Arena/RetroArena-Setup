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
    gitPullOrClone "$md_build" https://github.com/devmiyax/yabause.git master
}

function build_yabause() {
    mkdir build
    cd build
    if isPlatform "odroid-n2"; then
        export CFLAGS="-O2 -march=armv8-a+crc -mtune=cortex-a73.cortex-a53 -ftree-vectorize -funsafe-math-optimizations -pipe"
        cmake ../yabause -DGIT_EXECUTABLE=/usr/bin/git -DYAB_PORTS=retro_arena -DYAB_WANT_DYNAREC_DEVMIYAX=ON -DCMAKE_TOOLCHAIN_FILE=../yabause/src/retro_arena/n2.cmake
    elif isPlatform "odroid-xu"; then
        export CFLAGS="-O2 -march=armv7-a -mtune=cortex-a15.cortex-a7 -mfpu=neon-vfpv4 -mfloat-abi=hard -ftree-vectorize -funsafe-math-optimizations"
        cmake ../yabause -DGIT_EXECUTABLE=/usr/bin/git -DYAB_PORTS=retro_arena -DYAB_WANT_DYNAREC_DEVMIYAX=ON -DYAB_WANT_ARM7=ON -DCMAKE_TOOLCHAIN_FILE=../yabause/src/retro_arena/xu4.cmake
    elif isPlatform "rockpro64"; then       
        export CFLAGS="-O2 -march=armv8-a+crc -mtune=cortex-a72.cortex-a53 -mfloat-abi=hard -ftree-vectorize -funsafe-math-optimizations -pipe"
        cmake ../yabause -DGIT_EXECUTABLE=/usr/bin/git -DYAB_PORTS=retro_arena -DYAB_WANT_DYNAREC_DEVMIYAX=ON -DYAB_WANT_ARM7=ON -DCMAKE_TOOLCHAIN_FILE=../yabause/src/retro_arena/rp64.cmake
    else
        exit
    fi
    make
    md_ret_require="$md_build/build/src/retro_arena/yabasanshiro"
}

function install_yabause() {
    md_ret_files=(
        'build/src/retro_arena/yabasanshiro'
    )
}

function install_bin_yabause() {
    downloadAndExtract "$__gitbins_url/yabause.tar.gz" "$md_inst" 1
}

function configure_yabause() {
    mkRomDir "saturn"
    addEmulator 1 "${md_id}-1x-bios" "saturn" "$md_inst/yabasanshiro -a -nf -r 3 -b /home/pigaming/RetroArena/BIOS/saturn_bios.bin -i %ROM%"
    addEmulator 0 "${md_id}-1x-bios-fs" "saturn" "$md_inst/yabasanshiro -a -r 3 -b /home/pigaming/RetroArena/BIOS/saturn_bios.bin -i %ROM%"
    addEmulator 0 "${md_id}-1x-hle" "saturn" "$md_inst/yabasanshiro -a -nf -r 3 -i %ROM%"
    addEmulator 0 "${md_id}-1x-hle-fs" "saturn" "$md_inst/yabasanshiro -a -r 3 -i %ROM%"
    addEmulator 0 "${md_id}-2x-bios" "saturn" "$md_inst/yabasanshiro -a -nf -r 2 -b /home/pigaming/RetroArena/BIOS/saturn_bios.bin -i %ROM%"
    addEmulator 0 "${md_id}-2x-bios-fs" "saturn" "$md_inst/yabasanshiro -a -r 2 -b /home/pigaming/RetroArena/BIOS/saturn_bios.bin -i %ROM%"
    addEmulator 0 "${md_id}-2x-hle" "saturn" "$md_inst/yabasanshiro -a -nf -r 2 -i %ROM%"
    addEmulator 0 "${md_id}-2x-hle-fs" "saturn" "$md_inst/yabasanshiro -a -r 2 -i %ROM%"
    addEmulator 0 "${md_id}-720p-bios" "saturn" "$md_inst/yabasanshiro -a -nf -r 4 -b /home/pigaming/RetroArena/BIOS/saturn_bios.bin -i %ROM%"
    addEmulator 0 "${md_id}-720p-bios-fs" "saturn" "$md_inst/yabasanshiro -a -r 4 -b /home/pigaming/RetroArena/BIOS/saturn_bios.bin -i %ROM%"
    addEmulator 0 "${md_id}-720p-hle" "saturn" "$md_inst/yabasanshiro -a -nf -r 4 -i %ROM%"
    addEmulator 0 "${md_id}-720p-hle-fs" "saturn" "$md_inst/yabasanshiro -a -r 4 -i %ROM%"    
    addSystem "saturn"
	
	if  isPlatform "odroid-n2"; then
   cd ~/mali
   ./install.sh
fi

}
