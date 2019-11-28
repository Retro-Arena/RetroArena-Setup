#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="lr-dinothawr"
rp_module_desc="Dinothawr - standalone libretro puzzle game"
rp_module_help="Dinothawr game assets are automatically installed to $romdir/ports/dinothawr/"
rp_module_licence="NONCOM https://raw.githubusercontent.com/libretro/Dinothawr/master/LICENSE"
rp_module_section="lr"

function sources_lr-dinothawr() {
    gitPullOrClone "$md_build" https://github.com/libretro/Dinothawr.git
}

function build_lr-dinothawr() {
    make clean
    # libretro-common has an issue with neon
    if isPlatform "neon"; then
        CFLAGS="" make
    else
        make
    fi
    md_ret_require="$md_build/dinothawr_libretro.so"
}

function install_lr-dinothawr() {
    md_ret_files=(
        'dinothawr_libretro.so'
        'dinothawr'
    )
}

function install_bin_lr-dinothawr() {
    downloadAndExtract "$__gitbins_url/lr-dinothawr.tar.gz" "$md_inst" 1
}

function configure_lr-dinothawr() {
    setConfigRoot "ports"

    addPort "$md_id" "dinothawr" "Dinothawr" "$md_inst/dinothawr_libretro.so" "$romdir/ports/dinothawr/dinothawr.game"

    mkRomDir "ports/dinothawr"
    ensureSystemretroconfig "ports/dinothawr"

    cp -Rv "$md_inst/dinothawr" "$romdir/ports"

    chown $user:$user -R "$romdir/ports/dinothawr"
	
	

}
