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
rp_module_desc="Kodi - Open source home theatre software. Read the Package Help for more information."
rp_module_licence="GPL2 https://raw.githubusercontent.com/xbmc/xbmc/master/LICENSE.GPL"
rp_module_help="The Kodi package is provided AS-IS and WITHOUT support, including for any addons you install.\n\nA keyboard may be required in order to map a gamepad controller.\n\nKnown Issues: Mapping two of the same gamepad controllers will cause instability and may crash."
rp_module_section="opt"
rp_module_flags="!osmc !xbian !kms"

function install_bin_kodi() {
    aptInstall kodi-fbdev
    cp -r "$scriptdir/scriptmodules/emulators/kodi/kodi" "$romdir/"
    cp "$scriptdir/scriptmodules/emulators/kodi/Kodi.bash" "/usr/bin/kodi"
    cp "$scriptdir/scriptmodules/emulators/kodi/DialogButtonMenu.xml" "/usr/share/kodi/addons/skin.estuary/xml"
    mkRomDir "kodi"
    chown -R $user:$user "$romdir/kodi"
    moveConfigDir "$home/.kodi" "$md_conf_root/kodi"
    addEmulator 1 "$md_id" "kodi" "kodi %ROM%"
    addSystem "kodi"
}

function remove_kodi() {
    aptRemove kodi-fbdev
    aptRemove kodi-fbdev-bin
    aptRemove kodi-fbdev-data
    delSystem kodi
    rm -rf "$romdir/kodi"
}
