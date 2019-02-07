#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="lr-mupen64plus-nx"
rp_module_desc="N64 emu - Highly modified Mupen64Plus port for libretro"
rp_module_help="ROM Extensions: .z64 .n64 .v64\n\nCopy your N64 roms to $romdir/n64"
rp_module_licence="GPL3 https://raw.githubusercontent.com/libretro/mupen64plus-libretro-nx/mupen_next/LICENSE"
rp_module_section="lr"

function sources_lr-mupen64plus-nx() {
    gitPullOrClone "$md_build" https://github.com/libretro/mupen64plus-libretro-nx.git
}

function build_lr-mupen64plus-nx() {
    make clean
    local params=()
    if isPlatform "rockpro64" || isPlatform "odroid-c1" || isPlatform "odroid-xu"; then
        params+=(platform="$__platform")
    fi
    make "${params[@]}"
    md_ret_require="$md_build/mupen64plus_next_libretro.so"
}

function install_lr-mupen64plus-nx() {
    md_ret_files=(
        'mupen64plus_next_libretro.so'
        'README.md'
    )
}

function configure_lr-mupen64plus-nx() {
    mkRomDir "n64"
    ensureSystemretroconfig "n64"

    addEmulator 0 "$md_id" "n64" "$md_inst/mupen64plus_next_libretro.so"
    addSystem "n64"
}
