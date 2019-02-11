#!/bin/bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="lr-ppsspp"
rp_module_desc="PlayStation Portable emu - PPSSPP port for libretro"
rp_module_help="ROM Extensions: .iso .pbp .cso\n\nCopy your PlayStation Portable roms to $romdir/psp"
rp_module_licence="GPL2 https://raw.githubusercontent.com/RetroArena/ppsspp/master/LICENSE.TXT"
rp_module_section="lr"
rp_module_flags="!aarch64 !mali"

function depends_lr-ppsspp() {
    depends_ppsspp
}

function sources_lr-ppsspp() {
    sources_ppsspp
}

function build_lr-ppsspp() {
    build_ppsspp
}

function install_lr-ppsspp() {
    md_ret_files=(
        'lr-ppsspp/lib/ppsspp_libretro.so'
        'lr-ppsspp/assets'
    )
}

function install_bin_lr-ppsspp() {
    downloadAndExtract "$__gitbins_url/lr-ppsspp.tar.gz" "$md_inst" 1
}

function configure_lr-ppsspp() {    
    local system
    for system in psp pspminis; do
        mkRomDir "$system"
        ensureSystemretroconfig "$system"        
        addEmulator 1 "$md_id" "$system" "$md_inst/ppsspp_libretro.so"
        addSystem "$system"
    done

    if [[ "$md_mode" == "install" ]]; then
        mkUserDir "$biosdir/PPSSPP"
        cp -Rv "$md_inst/assets/"* "$biosdir/PPSSPP/"
        chown -R $user:$user "$biosdir/PPSSPP"
    fi
    
    # gl2ext.h revert
    local gles2="/usr/include/GLES2"
    if [[ -e "$gles2/gl2ext.h.org" ]]; then
        cp -p "$gles2/gl2ext.h.org" "$gles2/gl2ext.h"
        rm "$gles2/gl2ext.h.org"
    fi
}
