#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="gsplus"
rp_module_desc="Apple 2 GS emulator GSplus a modern sdl2 fork of gsport (alpha)"
rp_module_help="ROM Extensions: .gsp\n\nCopy your Apple 2 GS games to $romdir/apple2gs Note The Developer considers this to be an alpha build. Expect bugs Known issue: some games do not detect the emulated joystick"
rp_module_licence="GPL2 https://raw.githubusercontent.com/digarok/gsplus/master/LICENSE.txt"
rp_module_section="sa"

function depends_gsplus() {
    getDepends libpcap0.8-dev libfreetype6-dev libsdl2-dev libsdl2-image-dev
}

function sources_gsplus() {
    gitPullOrClone "$md_build" https://github.com/digarok/gsplus.git
}

function build_gsplus() {
cp "$md_data/vars_armv7-a_sdl2" "$md_build/src/vars"
    cd src
    make clean
    make
}

function install_gsplus() {
    md_ret_files=(
        'gsplus'
    )
}

function install_bin_gsplus() {
    downloadAndExtract "$__gitbins_url/gsplus.tar.gz" "$md_inst" 1
}

function configure_gsplus() {
    mkRomDir "apple2gs"
    mkUserDir "$md_conf_root/apple2gs"
    addEmulator 1 "$md_id" "apple2gs" "$md_inst/gsplus -config %ROM%"
    addSystem "apple2gs"
}
