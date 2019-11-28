#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="lr-superflappybirds"
rp_module_desc="Super Flappy Birds - Multiplayer Flappy Bird Clone"
rp_module_help="https://github.com/IgniparousTempest/libretro-superflappybirds/wiki"
rp_module_licence="GPL3 https://raw.githubusercontent.com/IgniparousTempest/libretro-superflappybirds/master/LICENSE"
rp_module_section="lr"

function depends_lr-superflappybirds() {
    getDepends cmake
}

function sources_lr-superflappybirds() {
    gitPullOrClone "$md_build" https://github.com/IgniparousTempest/libretro-superflappybirds.git
}

function build_lr-superflappybirds() {
    cmake .
    make
    md_ret_require="$md_build/superflappybirds_libretro.so"
}

function install_lr-superflappybirds() {
    md_ret_files=(
        'superflappybirds_libretro.so'
        'resources'
        'LICENSE'
        'README.md'
    )
}

function install_bin_lr-superflappybirds() {
    downloadAndExtract "$__gitbins_url/lr-superflappybirds.tar.gz" "$md_inst" 1
}

function configure_lr-superflappybirds() {
    setConfigRoot "ports"

    addPort "$md_id" "superflappybirds" "Super Flappy Birds" "$md_inst/superflappybirds_libretro.so"

    ensureSystemretroconfig "ports/superflappybirds"
	
	

}
