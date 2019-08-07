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
rp_module_flags="!osmc !xbian !rockpro64"

function depends_kodi() {
    local depends
    isPlatform "odroid-n2" && depends+=(liblzo2-dev libpng-dev libgif-dev libjpeg-dev libpcap-dev libcap-dev python2.7-dev libxml2-dev libxslt1-dev libass-dev libcdio-dev libiso9660-10 libiso9660-dev libcrossguid-dev uuid-dev libcurl4-openssl-dev libfstrcmp-dev libssl-dev libsqlite3-dev libtag1-dev libtinyxml-dev libcec-dev libbluetooth-dev libmicrohttpd-dev liblircclient-dev libsmbclient-dev libnfs-dev libinput-dev libxkbcommon-dev libavahi-client-dev libbluray-dev libmysqlclient-dev liblcms2-dev libsndio-dev libcwiid-dev libplist-dev)
    getDepends "${depends[@]}"
}

function install_bin_kodi() {
    if grep -q "ODROID-N2" /sys/firmware/devicetree/base/model 2>/dev/null; then
        aptInstall kodi
        aptInstall aml-libs
        sudo wget https://github.com/Retro-Arena/binaries/raw/master/odroid-n2/kodi-joystick.tar.gz
        sudo tar -xzf kodi-joystick.tar.gz
        sudo mv peripheral.joystick /usr/share/kodi/addons
        sudo rm kodi-joystick.tar.gz
        cp "$scriptdir/scriptmodules/emulators/kodi/kodi-leia.bash" "/usr/bin/kodi"
    else
        printMsgs "dialog" "IMPORTANT NOTE\n\nOnly Kodi Krypton 17.3 is supported for the Odroid-XU4\n\nDo not set two controller profiles for the same controller as it will become unstable and may crash.\n\nLocal and Network LAN based streaming was successfully tested however plugins have not been tested. TheRA is not responsible for any support. The installation comes from the Hard Kernel source therefore it is suggested you seek assistance at the Hard Kernel forums.\n\nDue to issues with how EXT storage is accessed by Kodi all exit options have been removed from the default skin. Changing skins is at the user's discretion and TheRA will not be responsible to troubleshoot issues that may arise. Perform skin changes at your own risk."
        aptInstall kodi-fbdev
        cp "$scriptdir/scriptmodules/emulators/kodi/kodi-krypton.bash" "/usr/bin/kodi"
        cp "$scriptdir/scriptmodules/emulators/kodi/kodi-krypton-menu.xml" "/usr/share/kodi/addons/skin.estuary/xml"
    fi

    cp -r "$scriptdir/scriptmodules/emulators/kodi/kodi" "$romdir/"
    chown -R $user:$user "$romdir/kodi"

    moveConfigDir "$home/.kodi" "$md_conf_root/kodi"
    addEmulator 1 "$md_id" "kodi" "kodi %ROM%"
    addSystem "kodi"
}

function remove_kodi() {
    if grep -q "ODROID-N2" /sys/firmware/devicetree/base/model 2>/dev/null; then
        aptRemove kodi
        aptRemove aml-libs
        sudo rm -rf /usr/share/kodi
    else
        aptRemove kodi-fbdev
        aptRemove kodi-fbdev-bin
        aptRemove kodi-fbdev-data
    fi

    delSystem kodi
    rm -rf "$romdir/kodi"
}
