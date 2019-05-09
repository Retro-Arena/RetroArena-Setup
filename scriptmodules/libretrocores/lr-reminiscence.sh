#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="lr-reminiscence"
rp_module_desc="REminiscence (FLASHBACK) port for libretro"
rp_module_help="Copy the original FLASHBACK game files to $romdir/ports/reminiscence so you have the file $romdir/ports/reminiscence/DATA/LEVEL1.MAP present."
rp_module_licence="GPL3 https://raw.githubusercontent.com/kanishka-linux/reminiscence/master/LICENSE"
rp_module_section="lr"

function sources_lr-reminiscence() {
    gitPullOrClone "$md_build" https://github.com/libretro/REminiscence.git
}

function build_lr-reminiscence() {
    make clean
    make
}

function install_lr-reminiscence() {
    md_ret_files=(
        'reminiscence_libretro.so'
    )
}

function install_bin_lr-reminiscence() {
    downloadAndExtract "$__gitbins_url/lr-reminiscence.tar.gz" "$md_inst" 1
}

function configure_lr-reminiscence() {
    local script
    setConfigRoot "ports"

    addPort "$md_id" "reminiscence" "REminiscence" "$md_inst/reminiscence_libretro.so"
    local file="$romdir/ports/REminiscence.sh"
    # create folder in ports if one does not exist already
    [[ -d "$romdir/ports/reminiscence" ]] || mkdir "$romdir/ports/reminiscence"
    chown $user:$user "$romdir/ports/reminiscence"
    # custom launch script - if the data files are not found, warn the user
    cat >"$file" << _EOF_
#!/bin/bash
if [[ ! -f "$romdir/ports/reminiscence/DATA/LEVEL1.MAP" ]]; then
    dialog --no-cancel --pause "$md_help" 22 76 15
else
    "$rootdir/supplementary/runcommand/runcommand.sh" 0 _PORT_ reminiscence "$romdir/ports/"
fi
_EOF_
    chown $user:$user "$file"
    chmod +x "$file"

    ensureSystemretroconfig "ports/reminiscence"
}
