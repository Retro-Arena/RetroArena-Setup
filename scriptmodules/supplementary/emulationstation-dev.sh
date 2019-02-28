#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="emulationstation-dev"
rp_module_desc="EmulationStation (dev branch) - CAUTION - may cause issues"
rp_module_licence="MIT https://raw.githubusercontent.com/Retro-Arena/EmulationStation/master/LICENSE.md"
rp_module_section="core"
rp_module_flags="frontend"

function _get_input_cfg_emulationstation-dev() {
    _get_input_cfg_emulationstation
}

function _update_hook_emulationstation-dev() {
    update_hook_emulationstation
}

function _sort_systems_emulationstation-dev() {
    _sort_systems_emulationstation
}

function _add_system_emulationstation-dev() {
    _add_system_emulationstation
}

function _del_system_emulationstation-dev() {
    _del_system_emulationstation
}

function _add_rom_emulationstation-dev() {
    _add_rom_emulationstation
}

function depends_emulationstation-dev() {
    local depends=(
        libfreeimage-dev libfreetype6-dev
        libcurl4-openssl-dev libasound2-dev cmake libsdl2-dev libsm-dev
        libvlc-dev libvlccore-dev vlc rapidjson-dev
    )

    isPlatform "x11" && depends+=(gnome-terminal)
    isPlatform "rock64" && depends+=(libmali-rk-dev)
    getDepends "${depends[@]}"
}

function sources_emulationstation-dev() {
    local repo="$1"
    local branch="$2"
    [[ -z "$repo" ]] && repo="https://github.com/Retro-Arena/EmulationStation"
    [[ -z "$branch" ]] && branch="dev"
    gitPullOrClone "$md_build" "$repo" "$branch"
}

function build_emulationstation-dev() {    
    build_emulationstation
}

function install_emulationstation-dev() {
    md_ret_files=(
        'CREDITS.md'
        'emulationstation'
        'emulationstation.sh'
        'GAMELISTS.md'
        'README.md'
        'resources'
        'THEMES.md'
    )
}

function init_input_emulationstation-dev() {
    init_input_emulationstation
}

function copy_inputscripts_emulationstation-dev() {
    copy_inputscripts_emulationstation
}

function install_launch_emulationstation-dev() {
    install_launch_emulationstation
}

function clear_input_emulationstation-dev() {
    clear_input_emulationstation
}

function remove_emulationstation-dev() {
    remove_emulationstation
}

function configure_emulationstation-dev() {
    configure_emulationstation
}

function gui_emulationstation-dev() {
    gui_emulationstation
}
