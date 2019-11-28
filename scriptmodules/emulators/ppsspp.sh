#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="ppsspp"
rp_module_desc="PlayStation Portable emulator PPSSPP"
rp_module_help="ROM Extensions: .iso .pbp .cso\n\nCopy your PlayStation Portable roms to $romdir/psp"
rp_module_licence="GPL2 https://raw.githubusercontent.com/hrydgard/ppsspp/master/LICENSE.TXT"
rp_module_section="sa"

function depends_ppsspp() {
    local depends=(cmake libsdl2-dev libzip-dev)
    getDepends "${depends[@]}"
}

function sources_ppsspp() {
    gitPullOrClone "$md_build/$md_id" https://github.com/hrydgard/ppsspp.git
    cd "$md_id"
    
    if isPlatform "odroid-xu"; then
        # gl2ext.h fix
        local gles2="/usr/include/GLES2"
        if [[ -e "$gles2/gl2ext.h.org" ]]; then
            cp -p "$gles2/gl2ext.h.org" "$gles2/gl2ext.h"
        else
            cp -p "$gles2/gl2ext.h" "$gles2/gl2ext.h.org"
        fi
        sed -i -e 's:GL_APICALL void GL_APIENTRY glBufferStorageEXT://GL_APICALL void GL_APIENTRY glBufferStorageEXT:g' "$gles2/gl2ext.h"
        sed -i -e 's:GL_APICALL void GL_APIENTRY glCopyImageSubDataOES://GL_APICALL void GL_APIENTRY glCopyImageSubDataOES:g' "$gles2/gl2ext.h"
        sed -i -e 's:GL_APICALL void GL_APIENTRY glBindFragDataLocationIndexedEXT://GL_APICALL void GL_APIENTRY glBindFragDataLocationIndexedEXT:g' "$gles2/gl2ext.h"
        sed -i -e 's:GL_APICALL void GL_APIENTRY glBindFragDataLocationEXT://GL_APICALL void GL_APIENTRY glBindFragDataLocationEXT:g' "$gles2/gl2ext.h"
        sed -i -e 's:GL_APICALL GLint GL_APIENTRY glGetProgramResourceLocationIndexEXT://GL_APICALL GLint GL_APIENTRY glGetProgramResourceLocationIndexEXT:g' "$gles2/gl2ext.h"
        sed -i -e 's:GL_APICALL GLint GL_APIENTRY glGetFragDataIndexEXT://GL_APICALL GLint GL_APIENTRY glGetFragDataIndexEXT:g' "$gles2/gl2ext.h"
    fi
    
    if isPlatform "odroid-n2"; then
        applyPatch "$md_data/cmakelists.patch"
    fi

    if isPlatform "rockpro64"; then
        applyPatch "$md_data/cmakelists.patch"
        applyPatch "$md_data/rockpro64.patch"
    fi
    
    # remove the lines that trigger the ffmpeg build script functions - we will just use the variables from it
    sed -i "/^build_ARMv6$/,$ d" ffmpeg/linux_arm.sh
    sed -i "/^build_ARM64$/,$ d" ffmpeg/linux_arm64.sh
    
    if hasPackage cmake 3.6 lt; then
        cd ..
        mkdir -p cmake
        downloadAndExtract "$__archive_url/cmake-3.6.2.tar.gz" "$md_build/cmake" 1
    fi
}

function build_ffmpeg_ppsspp() {
    cd "$1"
    local arch
    local extra_cflags
    local extra_params
    local MODULES
    local VIDEO_DECODERS
    local AUDIO_DECODERS
    local VIDEO_ENCODERS
    local AUDIO_ENCODERS
    local DEMUXERS
    local MUXERS
    local PARSERS
    local GENERAL
    local OPTS # used by older lr-ppsspp fork
    
    # get the ffmpeg configure variables from the ppsspp ffmpeg distributed script
    if isPlatform "odroid-n2"; then
        source linux_arm64.sh
        arch='aarch64'
    elif isPlatform "rockpro64"; then
        source linux_arm.sh
        arch='armv7'
        extra_params='--arch=arm'
    else
        source linux_arm.sh
        arch='armv7'
    fi
    
    # linux_arm.sh has set -e which we need to switch off
    set +e
    ./configure $extra_params \
        --prefix="./linux/$arch" \
        --extra-cflags="-fasm -Wno-psabi -fno-short-enums -fno-strict-aliasing -finline-limit=300" \
        --disable-shared \
        --enable-static \
        --enable-zlib \
        --enable-pic \
        --disable-everything \
        ${MODULES} \
        ${VIDEO_DECODERS} \
        ${AUDIO_DECODERS} \
        ${VIDEO_ENCODERS} \
        ${AUDIO_ENCODERS} \
        ${DEMUXERS} \
        ${MUXERS} \
        ${PARSERS}
    make clean
    make install
}

function build_cmake_ppsspp() {
    cd "$md_build/cmake"
    ./bootstrap
    make
}

function build_ppsspp() {
    local ppsspp_binary="PPSSPPSDL"
    local cmake="cmake"
    if hasPackage cmake 3.6 lt; then
        build_cmake_ppsspp
        cmake="$md_build/cmake/bin/cmake"
    fi

    # build ffmpeg
    build_ffmpeg_ppsspp "$md_build/$md_id/ffmpeg"

    # build ppsspp
    cd "$md_build/$md_id"
    rm -rf CMakeCache.txt CMakeFiles
    
    local params=()
    if isPlatform "odroid-xu"; then
        params+=(-DUSING_GLES2=ON -DUSING_FBDEV=ON)
    elif isPlatform "odroid-n2"; then
        params+=(-DCMAKE_TOOLCHAIN_FILE="$md_data/odroid-n2.cmake")
    elif isPlatform "rockpro64"; then
        params+=(-DCMAKE_TOOLCHAIN_FILE="$md_data/rockpro64.cmake")
    fi
    
    if [ "$md_id" == "lr-ppsspp" ]; then
        params+=(-DLIBRETRO=On)
        ppsspp_binary="lib/ppsspp_libretro.so"
    fi
    
    "$cmake" "${params[@]}" .
    make clean
    make
    md_ret_require="$md_build/$md_id/$ppsspp_binary"
}

function install_ppsspp() {
    md_ret_files=(
        'ppsspp/assets'
        'ppsspp/PPSSPPSDL'
    )
}

function install_bin_ppsspp() {
    downloadAndExtract "$__gitbins_url/ppsspp.tar.gz" "$md_inst" 1
}

function configure_ppsspp() { 
    local system
    for system in psp pspminis; do
        mkRomDir "$system"
        mkUserDir "$md_conf_root/$system/PSP"
        ln -snf "$romdir/$system" "$md_conf_root/$system/PSP/GAME"
        addEmulator 1 "$md_id" "$system" "$md_inst/PPSSPPSDL --fullscreen %ROM%"
        addSystem "$system"
    done
    
    moveConfigDir "$home/.config/ppsspp" "$md_conf_root/psp"
    ln -snf "$md_conf_root/psp/PSP/SYSTEM" "$md_conf_root/pspminis/PSP/SYSTEM"
	
    if isPlatform "odroid-xu"; then
        # gl2ext.h revert
        local gles2="/usr/include/GLES2"
        if [[ -e "$gles2/gl2ext.h.org" ]]; then
            cp -p "$gles2/gl2ext.h.org" "$gles2/gl2ext.h"
            rm "$gles2/gl2ext.h.org"
        fi
    fi
    
    if isPlatform "odroid-n2"; then
        mkdir -p "$md_conf_root/psp/PSP/SYSTEM"
        cp -R "$scriptdir/configs/psp/PSP/SYSTEM/." "$md_conf_root/psp/PSP/SYSTEM"
        chown -R $user:$user "$md_conf_root/psp/PSP/SYSTEM"
        chmod -R +x "$md_conf_root/psp/PSP/SYSTEM"
    fi
    
    cheats_ppsspp
}

function cheats_ppsspp() {
    mkdir -p "$md_conf_root/psp/PSP/Cheats"
    cp -R "$scriptdir/configs/psp/PSP/Cheats/." "$md_conf_root/psp/PSP/Cheats"
    chown -R $user:$user "$md_conf_root/psp/PSP/Cheats"
    chmod -R +x "$md_conf_root/psp/PSP/Cheats"
}

function gui_ppsspp() {
    while true; do
        local options=(
            1 "Update 60fps performance cheats"
        )
        local cmd=(dialog --backtitle "$__backtitle" --menu "Choose an option" 22 76 16)
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        [[ -z "$choice" ]] && break
        case "$choice" in
            1)
                cheats_ppsspp
                printMsgs "dialog" "60fps cheats have been updated for PPSSPP. Enable in the Home menu, then restart the game with cheats activated."
                ;;
        esac
    done
	
	

}
