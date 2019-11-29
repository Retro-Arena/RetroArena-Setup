#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="love-0.10.2"
rp_module_desc="Love - 2d Game Engine v0.10.2"
rp_module_help="Copy your Love games to $romdir/love"
rp_module_licence="GPL3 https://bitbucket.org/rude/love/raw/7b520c437317626da2102de1aafdad0e67b54bf5/license.txt"
rp_module_section="sa"
rp_module_flags="!odroid-n2"

function depends_love-0.10.2() {
    depends_love
}

function sources_love-0.10.2() {
    hg clone https://bitbucket.org/rude/love/#0.10.2 "$md_build"
}

function build_love-0.10.2() {
    build_love
}

function install_love-0.10.2() {
    install_love
}

function game_data_love-0.10.2() {
    game_data_love
}

function configure_love-0.10.2() {
    configure_love
	
	

}
