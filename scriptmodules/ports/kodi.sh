#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
# 
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
# 
# See the LICENSE.md file at the top-level directory of this distribution and 
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="kodi"
rp_module_desc="Kodi - Open source home theatre software. Please read the HELP"
rp_module_licence="GPL2 https://raw.githubusercontent.com/xbmc/xbmc/master/LICENSE.GPL"
rp_module_help="This package is provided AS-IS and we will NOT provide support or be held responsible for whatever addons you install"
rp_module_section="opt"
rp_module_flags=" !osmc !xbian !kms"

function _update_hook_kodi() {
    hasPackage kodi && mkdir -p "$md_inst"
}

function depends_kodi() {
    getDepends policykit-1
    addUdevInputRules
}

function install_bin_kodi() {
    __apt_update=0
    aptInstall kodi-fbdev
}

function remove_kodi() {
    aptRemove kodi-fbdev
    aptRemove kodi-fbdev-bin
    aptRemove kodi-fbdev-data
    rp_callModule kodi depends remove
}

function configure_kodi() {
    mkRomDir "kodi"
    cp -r "$scriptdir/scriptmodules/ports/kodi/kodi/" "$romdir/"
    cp "$scriptdir/scriptmodules/ports/kodi/Kodi.bash" /usr/bin/kodi
    cp "$scriptdir/scriptmodules/ports/kodi/DialogButtonMenu.xml" /usr/share/kodi/addons/skin.estuary/xml/
    chown -R $user:$user "$romdir/kodi/"
    moveConfigDir "$home/.kodi" "$md_conf_root/kodi"
    setESSystem "kodi" "kodi" "$romdir/kodi" ".sh" "bash %ROM%" "kodi"
}
