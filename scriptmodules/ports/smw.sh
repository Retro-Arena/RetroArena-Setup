#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="smw"
rp_module_desc="Super Mario War"
rp_module_licence="GPL http://supermariowar.supersanctuary.net/"
rp_module_section="prt"
rp_module_flags="!mali"

function depends_smw() {
    getDepends libsdl1.2-dev libsdl-mixer1.2-dev libsdl-image1.2-dev
}

function sources_smw() {
    gitPullOrClone "$md_build" https://github.com/HerbFargus/Super-Mario-War.git
}

function build_smw() {
    ./configure --prefix="$md_inst"
    make clean
    make
}

function install_smw() {
    make install
}

function configure_smw() {
    addPort "$md_id" "smw" "Super Mario War" "xinit $md_inst/smw"

    moveConfigFile "$home/.smw.options.bin" "$md_conf_root/smw/.smw.options.bin"
}
