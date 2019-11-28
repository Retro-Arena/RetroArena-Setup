#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="lr-freeintv"
rp_module_desc="Intellivision emulator for libretro"
rp_module_help="ROM Extensions: .int .bin\n\nCopy your Intellivision roms to $romdir/intellivision\n\nCopy the required BIOS files exec.bin and grom.bin to $biosdir"
rp_module_licence="GPL3 https://raw.githubusercontent.com/libretro/FreeIntv/master/LICENSE"
rp_module_section="lr"

function sources_lr-freeintv() {
    gitPullOrClone "$md_build" https://github.com/libretro/FreeIntv.git
}

function build_lr-freeintv() {
    make clean
    make
    md_ret_require="$md_build/freeintv_libretro.so"
}

function install_lr-freeintv() {
    md_ret_files=(
        'freeintv_libretro.so'
        'LICENSE'
        'README.md'
    )
}

function install_bin_lr-freeintv() {
    downloadAndExtract "$__gitbins_url/lr-freeintv.tar.gz" "$md_inst" 1
}

function configure_lr-freeintv() {
    mkRomDir "intellivision"
    ensureSystemretroconfig "intellivision"

    addEmulator 1 "$md_id" "intellivision" "$md_inst/freeintv_libretro.so"
    addSystem "intellivision"
	
	

}
