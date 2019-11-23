#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="lr-px68k"
rp_module_desc="SHARP X68000 Emulator"
rp_module_help="You need to copy a X68000 bios file (iplrom30.dat, iplromco.dat, iplrom.dat, or iplromxv.dat), and the font file (cgrom.dat or cgrom.tmp) to $romdir/BIOS/keropi. Use F12 to access the in emulator menu."
rp_module_section="lr"

function sources_lr-px68k() {
    local commit
    isPlatform "mali" && commit=("master c36fafd35094df918f037bea333d7707e656128a")
    gitPullOrClone "$md_build" https://github.com/libretro/px68k-libretro.git ${commit[0]}
}

function build_lr-px68k() {
    make clean
    make
    md_ret_require="$md_build/px68k_libretro.so"
}

function install_lr-px68k() {
    md_ret_files=(
        'px68k_libretro.so'
        'README.MD'
        'readme.txt'
    )
}

function install_bin_lr-px68k() {
    downloadAndExtract "$__gitbins_url/lr-px68k.tar.gz" "$md_inst" 1
}

function configure_lr-px68k() {
    mkRomDir "x68000"
    ensureSystemretroconfig "x68000"

    mkUserDir "$biosdir/keropi"
    cp -R "$scriptdir/scriptmodules/libretrocores/lr-px68k/keropi/." "$biosdir/keropi"

    addEmulator 1 "$md_id" "x68000" "$md_inst/px68k_libretro.so"
    addSystem "x68000"
	
	if  isPlatform "odroid-n2"; then
   cd ~/mali
   ./install.sh
fi

}
