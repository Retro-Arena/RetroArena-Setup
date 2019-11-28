#!/bin/bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="smw-netplay"
rp_module_desc="Super Mario War (Netplay Build)"
rp_module_section="prt"

function depends_smw-netplay() {
    getDepends libsdl2-2.0-0 libsdl2-image-2.0-0 libsdl2-mixer-2.0-0 libsdl2-dev libsdl2-image-dev libsdl2-mixer-dev 
}

function sources_smw-netplay() {
    gitPullOrClone "$md_build" https://github.com/mmatyas/supermariowar.git
    git submodule update --init
}


function build_smw-netplay() {
    cd "$md_build"
    unzip data.zip
    mkdir Build && cd Build
    cmake .. -DUSE_SDL2_LIBS=1 -DSDL2_FORCE_GLES=1
    make -j 4 smw && make -j 4 smw-server
    sed -i -e '$i \export LD_LIBRARY_PATH=/usr/local/lib' $home/.bashrc

    md_ret_require="$md_build/Build/Binaries/Release"
}

function install_smw-netplay() {
    md_ret_files=(
        '/Build/Binaries/Release/smw'
        '/Build/Binaries/Release/smw-server'
        '/data'
    )
}

 function install_bin_smw-netplay() {
    downloadAndExtract "$__gitbins_url/smw-netplay.tar.gz" "$md_inst" 1
}

function configure_smw-netplay() {
    setConfigRoot "ports"

    addPort "$md_id" "smw-netplay" "Super Mario War Netplay" "$md_inst/smw $md_inst/data"
	
	

}
