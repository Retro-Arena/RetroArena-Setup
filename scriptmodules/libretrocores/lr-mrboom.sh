#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="lr-mrboom"
rp_module_desc="Mr.Boom - 8 players Bomberman clone for libretro."
rp_module_help="8 players Bomberman clone for libretro."
rp_module_licence="MIT https://raw.githubusercontent.com/libretro/mrboom-libretro/master/LICENSE"
rp_module_section="lr"

function sources_lr-mrboom() {
     local commit
    isPlatform "mali" && commit=("master ecd8617a3a800915eb4138113e5f2bacc1c7fb2c")
    gitPullOrClone "$md_build" https://github.com/libretro/mrboom-libretro.git ${commit[0]}
}

function build_lr-mrboom() {
    rpSwap on 1000
    make clean
    make
    md_ret_require="$md_build/mrboom_libretro.so"
}

function install_lr-mrboom() {
    md_ret_files=(
        'mrboom_libretro.so'
        'LICENSE'
        'README.md'
    )
}


function configure_lr-mrboom() {
    setConfigRoot "ports"

    addPort "$md_id" "mrboom" "Mr.Boom" "$emudir/retroarch/bin/retroarch -L $md_inst/mrboom_libretro.so --config $md_conf_root/mrboom/retroarch.cfg"

    mkRomDir "ports/mrboom"
    ensureSystemretroconfig "ports/mrboom"
}
