#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="lr-snes9x2005"
rp_module_desc="Super Nintendo emu - Snes9x 1.43 based port for libretro"
rp_module_help="Previously called lr-catsfc\n\nROM Extensions: .bin .smc .sfc .fig .swc .mgd .zip\n\nCopy your SNES roms to $romdir/snes"
rp_module_licence="NONCOM https://raw.githubusercontent.com/libretro/snes9x2005/master/copyright"
rp_module_section="lr"

function _update_hook_lr-snes9x2005() {
    # move from old location and update emulators.cfg
    renameModule "lr-catsfc" "lr-snes9x2005"
}

function sources_lr-snes9x2005() {
    gitPullOrClone "$md_build" https://github.com/libretro/snes9x2005.git
}

function build_lr-snes9x2005() {
    make clean
    make
    md_ret_require="$md_build/snes9x2005_libretro.so"
}

function install_lr-snes9x2005() {
    md_ret_files=(
        'snes9x2005_libretro.so'
    )
}

function install_bin_lr-snes9x2005() {
    downloadAndExtract "$__gitbins_url/lr-snes9x2005.tar.gz" "$md_inst" 1
}

function configure_lr-snes9x2005() {
    local system
    for system in snes sfc sufami snesmsu1 satellaview; do
        mkRomDir "$system"
        ensureSystemretroconfig "$system"
        addEmulator 1 "$md_id" "$system" "$md_inst/snes9x2005_libretro.so"
        addSystem "$system"
    done
}
