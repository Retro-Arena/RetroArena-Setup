#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="openbor"
rp_module_desc="OpenBOR - Beat 'em Up Game Engine"
rp_module_help="Place your pak files in $romdir/openbor and launch from ES.\n\nUse a keyboard to configure controls."
rp_module_licence="BSD https://raw.githubusercontent.com/crcerror/OpenBOR-Raspberry/master/LICENSE"
rp_module_section="sa"
rp_module_flags="x11"

function depends_openbor() {
    getDepends libsdl2-gfx-dev libvorbisidec-dev libvpx-dev libogg-dev libsdl2-gfx-1.0-0 libvorbisidec1
}

function sources_openbor() {
    gitPullOrClone "$md_build" https://github.com/crcerror/OpenBOR-Raspberry.git
}

function build_openbor() {
    local params=()
    ! isPlatform "x11" && params+=(BUILD_PANDORA=1)
    make clean-all BUILD_PANDORA=1
    patch -p0 -i ./patch/latest_build.diff
    make "${params[@]}"
    md_ret_require="$md_build/OpenBOR"
    wget -q --show-progress "http://raw.githubusercontent.com/crcerror/OpenBOR-63xx-RetroPie-openbeta/master/libGL-binary/libGL.so.1.gz"
    gunzip -f libGL.so.1.gz
}

function install_openbor() {
    md_ret_files=(
       'OpenBOR'
       'libGL.so.1'
    )
}

function install_bin_openbor() {
    downloadAndExtract "http://github.com/Retro-Arena/xu4-bins/raw/master/openbor.tar.gz" "$md_inst" 1
}

function configure_openbor() {
    mkRomDir "openbor"
    mkUserDir "$configdir/openbor/ScreenShots"
    mkUserDir "$configdir/openbor/Saves"
    addSystem "openbor"
    addEmulator 1 "$md_id" "openbor" "pushd $md_inst; $md_inst/OpenBOR %ROM%; popd"
    ln -snf "/dev/shm" "$md_inst/Logs"
    ln -snf "/home/pigaming/RetroArena/roms/openbor" "$md_inst/Paks"
    ln -snf "$configdir/openbor/ScreenShots" "$md_inst/ScreenShots"
    ln -snf "$configdir/openbor/Saves" "$md_inst/Saves"
}
