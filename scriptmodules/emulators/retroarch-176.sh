#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="retroarch-176"
rp_module_desc="RetroArch v1.7.6 - for legacy use only"
rp_module_licence="GPL3 https://raw.githubusercontent.com/libretro/RetroArch/master/COPYING"
rp_module_section="core"

function depends_retroarch-176() {
    printMsgs "dialog --cancel-label" "NOTE:\n\nIt is normal that retroarch-176 is not mark as installed because it overwrites retroarch.\n\nClick OK to continue."
    depends_retroarch
}

function install_bin_retroarch-176() {
    downloadAndExtract "$__gitbins_url/retroarch_v176.tar.gz" "$md_inst" 1
}

function update_assets_retroarch-176() {
    update_assets_retroarch
}

function update_cheats_retroarch-176() {
    update_cheats_retroarch
}

function update_overlays_retroarch-176() {
    update_overlays_retroarch
}

function update_shaders_retroarch-176() {
    update_shaders_retroarch
}

function configure_retroarch-176() {
    configure_retroarch
    # rename retroarch-176 to retroarch
    if [[ -d /opt/retroarena/emulators/retroarch ]]; then
        rm -rf /opt/retroarena/emulators/retroarch
        mv /opt/retroarena/emulators/retroarch-176 /opt/retroarena/emulators/retroarch
    else
        mv /opt/retroarena/emulators/retroarch-176 /opt/retroarena/emulators/retroarch
    fi
}

function keyboard_retroarch-176() {
    keyboard_retroarch
}

function hotkey_retroarch-176() {
    hotkey_retroarch
}

function gui_retroarch-176() {
    gui_retroarch
}
