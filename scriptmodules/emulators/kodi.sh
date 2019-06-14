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
    if isPlatform="odroid-xu"; then
        aptInstall kodi-fbdev
        cp "$scriptdir/scriptmodules/emulators/kodi/Kodi.bash" "/usr/bin/kodi"
        cp "$scriptdir/scriptmodules/emulators/kodi/DialogButtonMenu.xml" "/usr/share/kodi/addons/skin.estuary/xml"
    fi
    
    if isPlatform="odroid-n2"; then
        cd /usr
        wget https://github.com/Retro-Arena/binaries/raw/master/odroid-n2/kodi.tar.gz
        tar -xzf kodi.tar.gz --strip-components=1
        rm -rf kodi.tar.gz
        chmod +x /usr/local/bin/kodi*
        chmod +x /usr/local/bin/TexturePacker
        chmod -R +x /usr/local/include/kodi
        chmod -R +x /usr/local/lib/kodi
        chmod -R +x /usr/local/share/kodi
        cd -
    fi

    cp -r "$scriptdir/scriptmodules/emulators/kodi/kodi" "$romdir/"
    chown -R $user:$user "$romdir/kodi"
    moveConfigDir "$home/.kodi" "$md_conf_root/kodi"
    addEmulator 1 "$md_id" "kodi" "kodi %ROM%"
    addSystem "kodi"
}

function remove_kodi() {
    if isPlatform="odroid-xu"; then
        aptRemove kodi-fbdev
        aptRemove kodi-fbdev-bin
        aptRemove kodi-fbdev-data
    fi
    
    if isPlatform="odroid-n2"; then
        rm -rf /usr/local/bin/kodi*
        rm -rf /usr/local/bin/TexturePacker
        rm -rf /usr/local/include/kodi
        rm -rf /usr/local/lib/kodi
        rm -rf /usr/local/share/kodi
    fi

    delSystem kodi
    rm -rf "$romdir/kodi"
}
