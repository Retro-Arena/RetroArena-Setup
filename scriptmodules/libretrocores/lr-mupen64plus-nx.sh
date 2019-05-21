#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="lr-mupen64plus-nx"
rp_module_desc="N64 emu - Highly modified Mupen64Plus port for libretro"
rp_module_help="ROM Extensions: .z64 .n64 .v64\n\nCopy your N64 roms to $romdir/n64"
rp_module_licence="GPL3 https://raw.githubusercontent.com/libretro/mupen64plus-libretro-nx/mupen_next/LICENSE"
rp_module_section="lr"
rp_module_flags=""

function sources_lr-mupen64plus-nx() {
    gitPullOrClone "$md_build" https://github.com/libretro/mupen64plus-libretro-nx.git GLideN64
    isPlatform "rockpro64" && applyPatch "$md_data/rockpro64.patch"
}

function build_lr-mupen64plus-nx() {
    make clean
    local params=()
    if isPlatform "odroid-n2"; then
        params+=(platform=odroid64 BOARD=N2)
    elif isPlatform  "odroid-xu"; then
        params+=(platform=odroid BOARD=ODROID-XU)
    elif isPlatform "rockpro64"; then
        params+=(platform=rockpro64)
    else
        exit
    fi
    make "${params[@]}"
    md_ret_require="$md_build/mupen64plus_next_libretro.so"
}

function install_lr-mupen64plus-nx() {
    md_ret_files=(
        'mupen64plus_next_libretro.so'
        'README.md'
    )
}

function install_bin_lr-mupen64plus-nx() {
    downloadAndExtract "$__gitbins_url/lr-mupen64plus-nx.tar.gz" "$md_inst" 1
}

function configure_lr-mupen64plus-nx() {
    mkRomDir "n64"
    ensureSystemretroconfig "n64"

    addEmulator 0 "$md_id" "n64" "$md_inst/mupen64plus_next_libretro.so"
    addSystem "n64"
    
    # set core options
    setRetroArchCoreOption "${dir_name}mupen64plus-169screensize" "640x360"
    setRetroArchCoreOption "${dir_name}mupen64plus-43screensize" "640x480"
    setRetroArchCoreOption "${dir_name}mupen64plus-alt-map" "False"
    setRetroArchCoreOption "${dir_name}mupen64plus-aspect" "4:3"
    setRetroArchCoreOption "${dir_name}mupen64plus-astick-deadzone" "15"
    setRetroArchCoreOption "${dir_name}mupen64plus-astick-sensitivity" "100"
    setRetroArchCoreOption "${dir_name}mupen64plus-BilinearMode" "standard"
    setRetroArchCoreOption "${dir_name}mupen64plus-CorrectTexrectCoords" "Off"
    setRetroArchCoreOption "${dir_name}mupen64plus-CountPerOp" "0"
    setRetroArchCoreOption "${dir_name}mupen64plus-cpucore" "dynamic_recompiler"
    setRetroArchCoreOption "${dir_name}mupen64plus-d-cbutton" "C3"
    setRetroArchCoreOption "${dir_name}mupen64plus-EnableCopyColorToRDRAM" "Off"
    setRetroArchCoreOption "${dir_name}mupen64plus-EnableCopyDepthToRDRAM" "Software"
    setRetroArchCoreOption "${dir_name}mupen64plus-EnableFBEmulation" "True"
    setRetroArchCoreOption "${dir_name}mupen64plus-EnableFragmentDepthWrite" "False"
    setRetroArchCoreOption "${dir_name}mupen64plus-EnableHWLighting" "False"
    setRetroArchCoreOption "${dir_name}mupen64plus-EnableLegacyBlending" "True"
    setRetroArchCoreOption "${dir_name}mupen64plus-EnableLODEmulation" "True"
    setRetroArchCoreOption "${dir_name}mupen64plus-EnableNativeResTexrects" "False"
    setRetroArchCoreOption "${dir_name}mupen64plus-EnableOverscan" "Disabled"
    setRetroArchCoreOption "${dir_name}mupen64plus-EnableShadersStorage" "True"
    setRetroArchCoreOption "${dir_name}mupen64plus-EnableTextureCache" "True"
    setRetroArchCoreOption "${dir_name}mupen64plus-FrameDuping" "False"
    setRetroArchCoreOption "${dir_name}mupen64plus-Framerate" "Fullspeed"
    setRetroArchCoreOption "${dir_name}mupen64plus-l-cbutton" "C2"
    setRetroArchCoreOption "${dir_name}mupen64plus-MaxTxCacheSize" "8000"
    setRetroArchCoreOption "${dir_name}mupen64plus-NoiseEmulation" "True"
    setRetroArchCoreOption "${dir_name}mupen64plus-OverscanBottom" "0"
    setRetroArchCoreOption "${dir_name}mupen64plus-OverscanLeft" "0"
    setRetroArchCoreOption "${dir_name}mupen64plus-OverscanRight" "0"
    setRetroArchCoreOption "${dir_name}mupen64plus-OverscanTop" "0"
    setRetroArchCoreOption "${dir_name}mupen64plus-pak1" "memory"
    setRetroArchCoreOption "${dir_name}mupen64plus-pak2" "none"
    setRetroArchCoreOption "${dir_name}mupen64plus-pak3" "none"
    setRetroArchCoreOption "${dir_name}mupen64plus-pak4" "none"
    setRetroArchCoreOption "${dir_name}mupen64plus-r-cbutton" "C1"
    setRetroArchCoreOption "${dir_name}mupen64plus-rspmode" "HLE"
    setRetroArchCoreOption "${dir_name}mupen64plus-txEnhancementMode" "None"
    setRetroArchCoreOption "${dir_name}mupen64plus-txFilterIgnoreBG" "True"
    setRetroArchCoreOption "${dir_name}mupen64plus-txFilterMode" "Sharp filtering 2"
    setRetroArchCoreOption "${dir_name}mupen64plus-txHiresEnable" "False"
    setRetroArchCoreOption "${dir_name}mupen64plus-txHiresFullAlphaChannel" "False"
    setRetroArchCoreOption "${dir_name}mupen64plus-u-cbutton" "C4"
    setRetroArchCoreOption "${dir_name}mupen64plus-virefresh" "Auto"
}
