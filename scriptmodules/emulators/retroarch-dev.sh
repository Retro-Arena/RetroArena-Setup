#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="retroarch-dev"
rp_module_desc="RetroArch (master branch) - CAUTION - may cause issues"
rp_module_licence="GPL3 https://raw.githubusercontent.com/libretro/RetroArch/master/COPYING "
rp_module_section="core"

function depends_retroarch-dev() {
    printMsgs "dialog" "NOTE:\n\nIt is normal that retroarch-dev is not mark as installed because it overwrites retroarch.\n\nClick OK to continue."
    depends_retroarch
}

function sources_retroarch-dev() {
    sources_retroarch
}

function build_retroarch-dev() {
    build_retroarch
}

function install_retroarch-dev() {
    install_retroarch
}

function update_assets_retroarch-dev() {
    update_assets_retroarch
}

function update_cheats_retroarch-dev() {
    update_cheats_retroarch
}

function update_overlays_retroarch-dev() {
    update_overlays_retroarch
}

function update_shaders_retroarch-dev() {
    update_shaders_retroarch
}

function configure_retroarch-dev() {
    configure_retroarch
    # rename retroarch-dev to retroarch
    if [[ -d /opt/retroarena/emulators/retroarch ]]; then
        rm -rf /opt/retroarena/emulators/retroarch
        mv /opt/retroarena/emulators/retroarch-dev /opt/retroarena/emulators/retroarch
    else
        mv /opt/retroarena/emulators/retroarch-dev /opt/retroarena/emulators/retroarch
    fi
}

function keyboard_retroarch-dev() {
    keyboard_retroarch
}

function hotkey_retroarch-dev() {
    hotkey_retroarch
}

function gui_retroarch-dev() {
    gui_retroarch
}
