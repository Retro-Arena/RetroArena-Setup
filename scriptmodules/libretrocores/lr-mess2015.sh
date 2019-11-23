#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="lr-mess2015"
rp_module_desc="Arcade emu - MESS 0.160 port for libretro"
rp_module_help="ROM Extension: .zip\n\nCopy your MESS roms to either $romdir/mame-libretro or\n$romdir/arcade"
rp_module_licence="NONCOM https://raw.githubusercontent.com/libretro/mame2015-libretro/master/docs/license.txt"
rp_module_section="lr"

function sources_lr-mess2015() {
    gitPullOrClone "$md_build" https://github.com/libretro/mame2015-libretro.git
}

function build_lr-mess2015() {
    rpSwap on 1200
	local params=(TARGET=mess)
    make clean
    make "${params[@]}"
    rpSwap off
    md_ret_require="$md_build/mess2015_libretro.so"
}

function install_lr-mess2015() {
    md_ret_files=(
        'mess2015_libretro.so'
        'docs/README-original.md'
    )
}

function install_bin_lr-mess2015() {
    downloadAndExtract "$__gitbins_url/lr-mess2015.tar.gz" "$md_inst" 1
}

function configure_lr-mess2015() {
    local system
    for system in gamecom; do
        mkRomDir "$system"
        ensureSystemretroconfig "$system"
        addEmulator 0 "$md_id" "$system" "$md_inst/mess2015_libretro.so"
        addSystem "$system"
    done
	
	if  isPlatform "odroid-n2"; then
   cd ~/mali
   ./install.sh
fi

}
