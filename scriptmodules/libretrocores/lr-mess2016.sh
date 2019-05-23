#!/bin/bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="lr-mess2016"
rp_module_desc="MESS emulator - MESS Port for libretro"
rp_module_help="see wiki for detailed explanation"
rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/mame2016-libretro/master/LICENSE.md"
rp_module_section="lr"

function sources_lr-mess2016() {
    gitPullOrClone "$md_build" https://github.com/libretro/mame2016-libretro.git
}

function build_lr-mess2016() {
    isPlatform "arm" && applyPatch "$md_data/lr-mame2016.patch"
    rpSwap on 5000
    local params=($(_get_params_lr-mame) SUBTARGET=mess)
    make clean
    make "${params[@]}" -j1
    rpSwap off
    md_ret_require="$md_build/mess2016_libretro.so"
}

function install_lr-mess2016() {
    md_ret_files=(
        'mess2016_libretro.so'
    )
}
function install_bin_lr-mess2016() {
    downloadAndExtract "$__gitbins_url/lr-mess2016.tar.gz" "$md_inst" 1
}

function configure_lr-mess2016() {
    configure_lr-mess "mess2016_libretro.so"
}
