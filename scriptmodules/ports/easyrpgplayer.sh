#!/bin/bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="easyrpgplayer"
rp_module_desc="EasyRPG Player - RPG Maker 2000 and 2003 Interpreter"
rp_module_licence="GPL3 https://raw.githubusercontent.com/EasyRPG/Player/master/COPYING"
rp_module_help="You need to unzip your RPG Maker games into subdirectories in $romdir/ports/$md_id/games. Obtain the translated RPG Maker 2000 RTP by Don Miguel and extract it to $romdir/ports/$md_id/data/rtp2000. Obtain the translated RPG Maker 2003 RTP by Advocate and extract it to $romdir/ports/$md_id/data/rtp2003/."
rp_module_section="prt"
rp_module_flags="!x86"

function depends_easyrpgplayer() {
    getDepends libsdl2-dev libsdl2-mixer-dev libpng12-dev libfreetype6-dev libboost-dev libpixman-1-dev libexpat1-dev zlib1g-dev autoconf automake libicu-dev libtool
}

function sources_easyrpgplayer() {
    gitPullOrClone "$md_build/liblcf" https://github.com/EasyRPG/liblcf.git 
    gitPullOrClone "$md_build/player" https://github.com/EasyRPG/Player.git
}

function build_easyrpgplayer() {
    cd liblcf
    autoreconf -i
    ./configure --prefix=/usr
    make
    make install
    cd ../player
    autoreconf -i
    ./configure --prefix "$md_inst"
    make
    cd ..
    # No longer needed.
    md_ret_require="$md_build/player/easyrpg-player"
}

function install_easyrpgplayer() {
    cd "$md_build/player"
    make install
}

 function install_bin_easyrpgplayer() {
    downloadAndExtract "$__gitbins_url/easyrpgplayer.tar.gz" "$md_inst" 1
}

function configure_easyrpgplayer() {
    mkRomDir "ports"
    mkRomDir "ports/$md_id"
    mkRomDir "ports/$md_id/data/"
    mkRomDir "ports/$md_id/data/rtp2000"
    mkRomDir "ports/$md_id/data/rtp2003"
    mkRomDir "ports/$md_id/games/"

    addPort "$md_id" "easyrpgplayer" "EasyRPG Player - RPG Maker 2000 and 2003 Interpreter" "cd $romdir/ports/$md_id/games/; RPG2K_RTP_PATH=$romdir/ports/$md_id/data/rtp2000/ RPG2K3_RTP_PATH=$romdir/ports/$md_id/data/rtp2003/ $md_inst/bin/easyrpg-player"
}
