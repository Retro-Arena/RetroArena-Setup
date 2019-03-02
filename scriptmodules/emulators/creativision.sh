#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="creativision"
rp_module_desc="Vtech Creativision emulator"
rp_module_help="ROM Extensions: .bin .rom \n\n Copy your Creativision games to  $romdir/crvision \n You need to copy the Creativision BIOS files (bioscv.rom cslbios.rom cslbiossm.rom disk.rom laser2001.rom saloram.rom) to the folder $biosdir/crvision"
rp_module_licence="?"
rp_module_section="sa"
rp_module_flags=" !kms"

function depends_creativision() {
    local depends=(libsdl2-dev libsdl2-net-dev autoconf zlib1g-dev libpng-dev)
    getDepends "${depends[@]}"
}

function sources_creativision() {
    gitPullOrClone "$md_build" https://github.com/sikotik/Creativision.git
}

function build_creativision() {
    cd "$md_build"
    mkdir build && cd build
    cmake –G “Unix Makefiles” ../ && make
    md_ret_require="$md_build/build/creatiVision"
}

function install_creativision() {
    md_ret_files=(
        '/build/creatiVision'
    )
}

function configure_creativision() {
    mkRomDir "crvision"
    mkUserDir "$md_conf_root/crvision"
	mkUserDir "$biosdir/crvision"
	
    addEmulator 1 "${md_id}-crvision"  "crvision" "$md_inst/creatiVision -f -b /home/pigaming/RetroArena/BIOS/crvision/bioscv.rom -r %ROM%"
    addEmulator 0 "${md_id}-cslmode"  "crvision" "$md_inst/creatiVision -f -k -2 -b /home/pigaming/RetroArena/BIOS/crvision/cslbios.rom -r %ROM%"
    addEmulator 0 "${md_id}-saloramanager" "crvision" "$md_inst/creatiVision -f -k -3 -b /home/pigaming/RetroArena/BIOS/crvision/saloram.rom -r %ROM%"
    addEmulator 0 "${md_id}-laser2001" "crvision" "$md_inst/creatiVision -f -3 -b /home/pigaming/RetroArena/BIOS/crvision/laser2001.rom -r %ROM%"
    addSystem "crvision"
}
