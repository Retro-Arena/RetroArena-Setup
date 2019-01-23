#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="fruitbox"
rp_module_desc="Fruitbox - A customisable MP3 Retro Jukebox"
rp_module_help="Copy your .mp3 files to $romdir/jukebox"
rp_module_section="opt"

function depends_fruitbox() {
    getDepends libsm-dev libxcursor-dev libxi-dev libxinerama-dev libxrandr-dev libxpm-dev libvorbis-dev libtheora-dev
}

function sources_fruitbox() {
    gitPullOrClone "$md_build/allegro5" "https://github.com/dos1/allegro5.git"
    gitPullOrClone "$md_build/fruitbox" "https://github.com/Retro-Arena/rpi-fruitbox.git"
    downloadAndExtract "https://ftp.osuosl.org/pub/blfs/conglomeration/mpg123/mpg123-1.24.0.tar.bz2" "$md_build"
    #wget http://odroidarena.com/pub/additional-files/CMakeLists.txt
    #wget http://odroidarena.com/pub/additional-files/Toolchain-odroid.cmake
}

function build_fruitbox() {
    # Build mpg123
    cd "$md_build/mpg123-1.24.0"
    chmod +x configure
    ./configure --with-cpu=arm_fpu --disable-shared
    make -j4 && make install
    cd ..
    
    # Overwrite build files.
    cp -vf "$md_data/CMakeLists.txt" "$md_build/allegro5/"
    #cp -vf "$md_build/CMakeLists.txt" "$md_build/allegro5/"
    #cp -vf "$md_build/Toolchain-odroid.cmake" "$md_build/allegro5/cmake/"
    
    # Build Allegro5
    cd "$md_build/allegro5"
    mkdir build && cd build
    cmake .. -DSHARED=off
    #cmake .. -DCMAKE_TOOLCHAIN_FILE=../cmake/Toolchain-odroid.cmake -DSHARED=off
    make -j4 && make install
    export PKG_CONFIG_PATH=/opt/retroarena/ports/fruitbox/build/allegro5/build/lib/pkgconfig
    ldconfig
    cd ../..

    # Build fruitbox
    cd "$md_build/fruitbox/build"
    make -j4
    
    md_ret_require="$md_build/fruitbox/build/fruitbox"
}

function install_fruitbox() {
    cp -v "$md_build/fruitbox/build/fruitbox" "$md_inst/"
	cp -v "$md_build/fruitbox/skins.txt" "$md_inst/"
	cp -vR "$md_build/fruitbox/skins" "$md_inst/"
}

function configure_fruitbox() {
    mkRomDir "jukebox"

    cat > "$romdir/jukebox/+Start fruitbox.sh" << _EOF_
#!/bin/bash
/opt/retroarena/supplementary/fruitbox/fruitbox --cfg /opt/retroarena/supplementary/fruitbox/skins/Modern/fruitbox.cfg
_EOF_
    chmod a+x "$romdir/jukebox/+Start fruitbox.sh"
    chown $user:$user "$romdir/jukebox/+Start fruitbox.sh"

    addEmulator 0 "$md_id" "jukebox" "fruitbox %ROM%"
    addSystem "jukebox" "Fruitbox Jukebox" ".sh"
}
