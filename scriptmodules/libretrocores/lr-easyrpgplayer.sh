#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="lr-easyrpgplayer"
rp_module_desc="Easy RPG player for libretro"
rp_module_help="You need to unzip your RPG Maker games into subdirectories in $romdir/$md_id/games. Obtain the translated RPG Maker 2000 RTP by Don Miguel and extract it to $romdir/$md_id/data/rtp2000. Obtain the translated RPG Maker 2003 RTP by Advocate and extract it to $romdir/$md_id/data/rtp2003/."
rp_module_licence="GPL3 https://raw.githubusercontent.com/EasyRPG/Player/master/COPYING"
rp_module_section="lr"
rp_module_flags="!odroid-xu"

function depends_lr-easyrpgplayer() {
    getDepends libsdl2-dev libsdl2-mixer-dev libpng12-dev libfreetype6-dev libboost-dev libpixman-1-dev libexpat1-dev zlib1g-dev autoconf automake libicu-dev libtool
}

function sources_lr-easyrpgplayer() {
    gitPullOrClone "$md_build" https://github.com/libretro/easyrpg-libretro.git
}

function build_lr-easyrpgplayer() {
    cmake . -DPLAYER_TARGET_PLATFORM=libretro -DBUILD_SHARED_LIBS=ON
    make clean
    make
 
    md_ret_require="$md_build/easyrpg_libretro.so"
     }

function install_lr-easyrpgplayer() {
    md_ret_files=(
        'easyrpg_libretro.so'
            )
}

function install_bin_lr-easyrpgplayer() {
    downloadAndExtract "$__gitbins_url/lr-easyrpgplayer.tar.gz" "$md_inst" 1
}

function configure_lr-easyrpgplayer() {
    
    mkRomDir "easyrpgplayer"
    mkRomDir "easyrpgplayer/data/"
    mkRomDir "easyrpgplayer/rtp2000"
    mkRomDir "easyrpgplayer/rtp2003"
    mkRomDir "easyrpgplayer/games/"
	ensureSystemretroconfig "easyrpgplayer"
    
	addEmulator 1 "$md_id" "easyrpgplayer" "$md_inst/easyrpg_libretro.so"
         
    addSystem "easyrpgplayer"
    
    chown $user:$user -R "$romdir/easyrpgplayer"
}
