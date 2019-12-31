#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="amiberry"
rp_module_desc="Amiga emulator with JIT support (forked from uae4arm)"
rp_module_help="ROM Extension: .adf\n\nCopy your Amiga games to $romdir/amiga\n\nCopy the required BIOS files\nkick13.rom\nkick20.rom\nkick31.rom\nto $biosdir"
rp_module_licence="GPL3 https://raw.githubusercontent.com/midwan/amiberry/master/COPYING"
rp_module_section="sa"
rp_module_flags="!x86"

function _get_platform_bin_amiberry() {
    local choice="$1"
    local amiberry_bin="$__platform-sdl2"
    local amiberry_platform="$__platform-sdl2"
    if isPlatform "odroid-xu"; then
        amiberry_bin="xu4"
        amiberry_platform="xu4"
    elif isPlatform "odroid-n2"; then
        amiberry_bin="n2"
        amiberry_platform="n2"
    elif isPlatform "rockpro64"; then
        amiberry_bin="RK3399"
        amiberry_platform="RK3399"
    fi
    [[ "$choice" == "bin" ]] && echo "$amiberry_bin"
    [[ "$choice" == "platform" ]] && echo "$amiberry_platform"
}

function depends_amiberry() {
    local depends=(libsdl2-dev libsdl2-ttf-dev libsdl2-image-dev libxml2-dev libflac-dev libmpg123-dev libpng-dev libmpeg2-4-dev)
    depends_uae4arm "${depends[@]}"
	if isPlatform "odroid-n2"; then
	~/RetroArena-Setup/fixmali.sh
	fi
}

function sources_amiberry() {
    gitPullOrClone "$md_build" https://github.com/midwan/amiberry.git 
}

function build_amiberry() {
    local amiberry_bin=$(_get_platform_bin_amiberry bin)
    local amiberry_platform=$(_get_platform_bin_amiberry platform)
     cd external/capsimg
    make clean
    ./bootstrap.fs
    ./configure.fs
    make -f Makefile.fs
    cd "$md_build"
    make clean
    CXXFLAGS="" make PLATFORM="$amiberry_platform"
    ln -sf "amiberry" "amiberry-$amiberry_bin"
    md_ret_require="$md_build/amiberry-$amiberry_bin"
}

function install_amiberry() {
    local amiberry_bin=$(_get_platform_bin_amiberry bin)
    md_ret_files=(
        'amiberry'
        "amiberry-$amiberry_bin"
        'data'
        'external/capsimg/capsimg.so'
    )

    cp -R "$md_build/whdboot" "$md_inst/whdboot-dist"
}

function install_bin_amiberry() {
    downloadAndExtract "$__gitbins_url/amiberry.tar.gz" "$md_inst" 1
}

function configure_amiberry() {
    configure_uae4arm

    [[ "$md_mode" == "remove" ]] && return

    # symlink the retroarch config / autoconfigs for amiberry to use
    ln -sf "$configdir/all/retroarch/autoconfig" "$md_inst/controllers"
    ln -sf "$configdir/all/retroarch.cfg" "$md_inst/conf/retroarch.cfg"

    local config_dir="$md_conf_root/amiga/$md_id"

    # create whdboot config area
    moveConfigDir "$md_inst/whdboot" "$config_dir/whdboot"

    # move hostprefs.conf from previous location
    if [[ -f "$config_dir/conf/hostprefs.conf" ]]; then
        mv "$config_dir/conf/hostprefs.conf" "$config_dir/whdboot/hostprefs.conf"
    fi

    # whdload auto-booter user config - copy default configuration
    copyDefaultConfig "$md_inst/whdboot-dist/hostprefs.conf" "$config_dir/whdboot/hostprefs.conf"

    # copy game-data, save-data folders, boot-data.zip and WHDLoad
    cp -R "$md_inst/whdboot-dist/"{game-data,save-data,boot-data.zip,WHDLoad} "$config_dir/whdboot/"

    chown -R $user:$user "$config_dir/whdboot"
	
	
}
