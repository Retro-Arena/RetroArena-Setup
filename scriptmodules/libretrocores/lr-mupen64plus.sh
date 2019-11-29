#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="lr-mupen64plus"
rp_module_desc="N64 emu - Mupen64Plus + GLideN64 for libretro"
rp_module_help="ROM Extensions: .z64 .n64 .v64\n\nCopy your N64 roms to $romdir/n64"
rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/mupen64plus-libretro/master/LICENSE"
rp_module_section="lr"
rp_module_flags=""

function _update_hook_lr-mupen64plus() {
    # retroarch renamed lr-mupen64plus to lr-parallel-n64 and
    # lr-glupen64 to lr-mupen64plus which makes this a little tricky as an update hook

    # we first need to rename lr-mupen64plus to lr-parallel-n64
    # (if it's not the lr-glupen64 fork)
    if [[ -d "$md_inst" ]] && ! grep -q "GLideN64" "$md_inst/README.md"; then
        renameModule "lr-mupen64plus" "lr-parallel-n64"
    fi
    # then we can rename lr-glupen64 to lr-mupen64plus
    renameModule "lr-glupen64" "lr-mupen64plus"
}

function depends_lr-mupen64plus() {
    local depends=(flex bison libpng-dev)
    isPlatform "x11" && depends+=(libglew-dev libglu1-mesa-dev)
    isPlatform "x86" && depends+=(nasm)
    isPlatform "mesa" && depends+=(libgles2-mesa-dev)
    isPlatform "videocore" && depends+=(libraspberrypi-dev)
    getDepends "${depends[@]}"
	if isPlatform "odroid-n2"; then
	~/RetroArena-Setup/fixmali.sh
	fi
}

function sources_lr-mupen64plus() {
    local branch"master"
    local commit=""
    isPlatform "rockpro64" && commit=("4ca2fa8633666e26e2f163dcd3c226b598cb2aa4")
    gitPullOrClone "$md_build" https://github.com/libretro/mupen64plus-libretro.git "$branch" "$commit"
    isPlatform "odroid-xu" && applyPatch "$md_data/odroid.diff"
    isPlatform "rockpro64" && applyPatch "$md_data/rockpro64.patch"
    # mesa workaround; see: https://github.com/libretro/libretro-common/issues/98
    if hasPackage libgles2-mesa-dev 18.2 ge; then
        applyPatch "$md_data/0001-eliminate-conflicting-typedefs.patch"
    fi
}

function build_lr-mupen64plus() {
    rpSwap on 750
    local params=()
    if isPlatform "rockpro64"; then
        params+=(platform="$__platform")
    elif isPlatform "odroid-xu"; then
        params+=(platform="unix odroid")
	elif isPlatform "videocore"; then
        params+=(platform="$__platform")
    elif isPlatform "mesa"; then
        params+=(platform="$__platform-mesa")
    elif isPlatform "odroid-n2"; then 
         params+=(platform=odroid64 BOARD=N2)
    else
        isPlatform "arm" && params+=(WITH_DYNAREC=arm)
        isPlatform "aarch64" && params+=(WITH_DYNAREC=aarch64)
        isPlatform "neon" && params+=(HAVE_NEON=1)
        isPlatform "gles" && params+=(FORCE_GLES3=1)
        isPlatform "kms" && params+=(FORCE_GLES3=1)
    fi
    make clean
    make "${params[@]}"
    rpSwap off
    md_ret_require="$md_build/mupen64plus_libretro.so"
}

function install_lr-mupen64plus() {
    md_ret_files=(
        'mupen64plus_libretro.so'
        'LICENSE'
        'README.md'
        'BUILDING.md'
    )
}

function configure_lr-mupen64plus() {
    mkRomDir "n64"
    ensureSystemretroconfig "n64"

    addEmulator 0 "$md_id" "n64" "$md_inst/mupen64plus_libretro.so"
    addSystem "n64"
	chown -R $user:$user "$romdir/n64"
}
