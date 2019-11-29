#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="lr-stella"
rp_module_desc="Atari 2600 emulator - Stella port for libretro"
rp_module_help="ROM Extensions: .a26 .bin .rom .zip .gz\n\nCopy your Atari 2600 roms to $romdir/atari2600"
rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/stella-libretro/master/stella/license.txt"
rp_module_section="lr"

function sources_lr-stella() {
    gitPullOrClone "$md_build" https://github.com/libretro/stella2014-libretro.git
}

function build_lr-stella() {
    make clean
    make
    md_ret_require="$md_build/stella2014_libretro.so"
}

function install_lr-stella() {
    md_ret_files=(
        'README.md'
        'stella2014_libretro.so'
    )
}

function install_bin_lr-stella() {
    downloadAndExtract "$__gitbins_url/lr-stella.tar.gz" "$md_inst" 1
}

function configure_lr-stella() {
    mkRomDir "atari2600"
    ensureSystemretroconfig "atari2600"

    addEmulator 1 "$md_id" "atari2600" "$md_inst/stella2014_libretro.so"
    addSystem "atari2600"
	
	

}
