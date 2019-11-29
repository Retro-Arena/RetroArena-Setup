#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="vice"
rp_module_desc="C64 emulator VICE"
rp_module_help="ROM Extensions: .crt .d64 .g64 .prg .t64 .tap .x64 .zip .vsf\n\nCopy your Commodore 64 games to $romdir/c64"
rp_module_licence="GPL2 http://svn.code.sf.net/p/vice-emu/code/trunk/vice/COPYING"
rp_module_section="sa"

function depends_vice() {
    local depends=(libsdl2-dev libmpg123-dev libpng-dev zlib1g-dev libasound2-dev libvorbis-dev libflac-dev libpcap-dev automake bison flex subversion libjpeg-dev portaudio19-dev texinfo xa65)
    isPlatform "x11" && depends+=(libpulse-dev)
    getDepends "${depends[@]}"
	if isPlatform "odroid-n2"; then
	~/RetroArena-Setup/fixmali.sh
	fi
}

function sources_vice() {
    svn checkout svn://svn.code.sf.net/p/vice-emu/code/trunk/vice/ "$md_build"
}

function build_vice() {
    local params=(--enable-sdlui2 --without-oss --enable-ethernet --enable-x64)
    ! isPlatform "x11" && params+=(--disable-catweasel --without-pulse)
    ./autogen.sh
    ./configure --prefix="$md_inst" "${params[@]}"
    make
    md_ret_require="$md_build/src/x64"
}

function install_vice() {
    make install
}

function install_bin_vice() {
    downloadAndExtract "$__gitbins_url/vice.tar.gz" "$md_inst" 1
}

function configure_vice() {
    # get a list of supported extensions
    local exts="$(getPlatformConfig c64_exts)"

    # install the vice start script
    mkdir -p "$md_inst/bin"
    cat > "$md_inst/bin/vice.sh" << _EOF_
#!/bin/bash

BIN="\${0%/*}/\$1"
ROM="\$2"
PARAMS=("\${@:3}")

romdir="\${ROM%/*}"
ext="\${ROM##*.}"
source "$rootdir/lib/archivefuncs.sh"

archiveExtract "\$ROM" "$exts"

# check successful extraction and if we have at least one file
if [[ \$? == 0 ]]; then
    ROM="\${arch_files[0]}"
    romdir="\$arch_dir"
fi

"\$BIN" -chdir "\$romdir" "\${PARAMS[@]}" "\$ROM"
archiveCleanup
_EOF_

    chmod +x "$md_inst/bin/vice.sh"

    local system
    for system in c64 c128 pet plus4 vic20 ; do
        mkRomDir "$system"
        addSystem "$system"
    done
    
    addEmulator 1 "$md_id-x64" "c64" "$md_inst/bin/vice.sh x64 %ROM%"
    addEmulator 0 "$md_id-x64sc" "c64" "$md_inst/bin/vice.sh x64sc %ROM%"
    addEmulator 1 "$md_id-x128" "c128" "$md_inst/bin/vice.sh x128 %ROM%"
    addEmulator 1 "$md_id-xpet" "pet" "$md_inst/bin/vice.sh xpet %ROM%"
    addEmulator 1 "$md_id-xplus4" "plus4" "$md_inst/bin/vice.sh xplus4 %ROM%"    
    addEmulator 1 "$md_id-xvic" "vic20" "$md_inst/bin/vice.sh xvic %ROM%"
    addEmulator 0 "$md_id-xvic-cart" "vic20" "$md_inst/bin/vice.sh xvic %ROM% -cartgeneric"
    
    [[ "$md_mode" == "remove" ]] && return
    
    # copy configs and symlink the old and new config folders to $md_conf_root/c64/
    moveConfigDir "$home/.vice" "$md_conf_root/c64"
    moveConfigDir "$home/.config/vice" "$md_conf_root/c64"
    
    local config="$(mktemp)"
    echo "[C64]" > "$config"
    iniConfig "=" "" "$config"
    if ! isPlatform "x11"; then
        iniSet "Mouse" "1"
        iniSet "VICIIDoubleSize" "0"
        iniSet "VICIIDoubleScan" "0"
        iniSet "VICIIFilter" "0"
        iniSet "VICIIVideoCache" "0"
        iniSet "SDLWindowWidth" "384"
        iniSet "SDLWindowHeight" "272"
        isPlatform "rpi1" && iniSet "SoundSampleRate" "22050"
        iniSet "SidEngine" "0"
    else
        iniSet "VICIIFullscreen" "1"
    fi
    
    for system in c64 c128 pet plus4 vic20; do
        copyDefaultConfig "$config" "$md_conf_root/$system/sdl-vicerc"
    done   

    rm "$config"

    if ! isPlatform "x11"; then
        # enforce a few settings to ensure a smooth upgrade from sdl1
        iniConfig "=" "" "$md_conf_root/c64/sdl-vicerc"
        iniDel "SDLBitdepth"
        iniSet "VICIIDoubleSize" "0"
        iniSet "VICIIDoubleScan" "0"
        iniSet "SDLWindowWidth" "384"
        iniSet "SDLWindowHeight" "272"
    fi
	
	

}
