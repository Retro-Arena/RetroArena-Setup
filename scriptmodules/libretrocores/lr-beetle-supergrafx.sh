#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="lr-beetle-supergrafx"
rp_module_desc="SuperGrafx TG-16 emulator - Mednafen PCE Fast port for libretro"
rp_module_help="ROM Extensions: .pce .ccd .cue .zip\n\nCopy your PC Engine / TurboGrafx roms to $romdir/pcengine\n\nCopy the required BIOS file syscard3.pce to $biosdir"
rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/beetle-supergrafx-libretro/master/COPYING"
rp_module_section="lr"

function sources_lr-beetle-supergrafx() {
    gitPullOrClone "$md_build" https://github.com/libretro/beetle-supergrafx-libretro.git
}

function build_lr-beetle-supergrafx() {
    make clean
    make
    md_ret_require="$md_build/mednafen_supergrafx_libretro.so"
}

function install_lr-beetle-supergrafx() {
    md_ret_files=(
        'mednafen_supergrafx_libretro.so'
    )
}

function install_bin_lr-beetle-supergrafx() {
    downloadAndExtract "$__gitbins_url/lr-beetle-supergrafx.tar.gz" "$md_inst" 1
}

function configure_lr-beetle-supergrafx() {
    local system
    for system in pcengine supergrafx; do
        mkRomDir "$system"
        ensureSystemretroconfig "$system"
        addEmulator 1 "$md_id" "$system" "$md_inst/mednafen_supergrafx_libretro.so"
        addSystem "$system"
    done
	
	if  isPlatform "odroid-n2"; then
   cd ~/mali
   ./install.sh
fi

}
