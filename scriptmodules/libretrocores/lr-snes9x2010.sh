#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="lr-snes9x2010"
rp_module_desc="Super Nintendo emu - Snes9x 1.52 based port for libretro"
rp_module_help="Previously called lr-snes9x-next\n\nROM Extensions: .bin .smc .sfc .fig .swc .mgd .zip\n\nCopy your SNES roms to $romdir/snes"
rp_module_licence="NONCOM https://raw.githubusercontent.com/libretro/snes9x2010/master/docs/snes9x-license.txt"
rp_module_section="lr"

function _update_hook_lr-snes9x2010() {
    # move from old location and update emulators.cfg
    renameModule "lr-snes9x-next" "lr-snes9x2010"
}

function sources_lr-snes9x2010() {
    gitPullOrClone "$md_build" https://github.com/libretro/snes9x2010.git
}

function build_lr-snes9x2010() {
    make -f Makefile.libretro clean
    local platform=""
    isPlatform "arm" && platform+="armv"
    isPlatform "neon" && platform+="neon"
    if [[ -n "$platform" ]]; then
        make -f Makefile.libretro platform="$platform"
    else
        make -f Makefile.libretro
    fi
    md_ret_require="$md_build/snes9x2010_libretro.so"
}

function install_lr-snes9x2010() {
    md_ret_files=(
        'snes9x2010_libretro.so'
        'docs'
    )
}

function install_bin_lr-snes9x2010() {
    downloadAndExtract "$__gitbins_url/lr-snes9x2010.tar.gz" "$md_inst" 1
}

function configure_lr-snes9x2010() {
    local system
    for system in snes sfc sufami snesmsu1 satellaview; do
        mkRomDir "$system"
        ensureSystemretroconfig "$system"
        addEmulator 1 "$md_id" "$system" "$md_inst/snes9x2010_libretro.so"
        addSystem "$system"
    done
}
