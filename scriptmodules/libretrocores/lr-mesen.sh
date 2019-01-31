#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="lr-mesen"
rp_module_desc="NES emulator - Mesen Port for libretro"
rp_module_help="ROM Extensions: .nes .zip\n\nCopy your NES roms to $romdir/nes"
rp_module_licence="GPL2"
rp_module_section="lr"

function sources_lr-mesen() {
    gitPullOrClone "$md_build" "https://github.com/retrontology/Mesen" "xu4"
}

function build_lr-mesen() {
    make clean
    MESENPLATFORM=armv7l make libretro -j7
    md_ret_require="$md_build/mesen_libretro.so"
}

function install_lr-mesen() {
    md_ret_files=(
        'mesen_libretro.so'
    )
}

function configure_lr-mesen() {
    mkRomDir "nes"
    mkRomDir "fds"
    ensureSystemretroconfig "nes"
    ensureSystemretroconfig "fds"

    local def=0
    isPlatform "armv7l" && def=1

    addEmulator "$def" "$md_id" "fds" "$md_inst/mesen_libretro.so"
    addEmulator "$def" "$md_id" "nes" "$md_inst/mesen_libretro.so"
    addSystem "nes"
    addSystem "fds"
}

