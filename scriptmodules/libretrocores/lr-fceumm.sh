#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="lr-fceumm"
rp_module_desc="NES emu - FCEUmm port for libretro"
rp_module_help="ROM Extensions: .nes .zip\n\nCopy your NES roms to $romdir/nes\n\nFor the Famicom Disk System copy your roms to $romdir/fds\n\nFor the Famicom Disk System copy the required BIOS file disksys.rom to $biosdir"
rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/libretro-fceumm/master/Copying"
rp_module_section="lr"

function sources_lr-fceumm() {
    gitPullOrClone "$md_build" https://github.com/libretro/libretro-fceumm.git
}

function build_lr-fceumm() {
    make -f Makefile.libretro clean
    make -f Makefile.libretro
    md_ret_require="$md_build/fceumm_libretro.so"
}

function install_lr-fceumm() {
    md_ret_files=(
        'Authors'
        'changelog.txt'
        'Copying'
        'fceumm_libretro.so'
        'whatsnew.txt'
        'zzz_todo.txt'
    )
}

function install_bin_lr-fceumm() {
    downloadAndExtract "$__gitbins_url/lr-fceumm.tar.gz" "$md_inst" 1
}

function configure_lr-fceumm() {
    mkRomDir "nes"
    mkRomDir "fds"
    mkRomDir "famicom"
    ensureSystemretroconfig "nes"
    ensureSystemretroconfig "fds"
    ensureSystemretroconfig "famicom"

    local def=1
    isPlatform "armv6" && def=0

    addEmulator "$def" "$md_id" "nes" "$md_inst/fceumm_libretro.so"
    addEmulator 0 "$md_id" "fds" "$md_inst/fceumm_libretro.so"
    addEmulator 0 "$md_id" "famicom" "$md_inst/fceumm_libretro.so"
    addSystem "nes"
    addSystem "fds"
    addSystem "famicom"
	
	

}
