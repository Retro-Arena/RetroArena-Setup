#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="lr-mame2003"
rp_module_desc="Arcade emu - MAME 0.78 port for libretro"
rp_module_help="ROM Extension: .zip\n\nCopy your MAME roms to either $romdir/mame-libretro or\n$romdir/arcade"
rp_module_licence="NONCOM https://raw.githubusercontent.com/libretro/mame2003-libretro/master/LICENSE.md"
rp_module_section="lr"

function _get_dir_name_lr-mame2003() {
    echo "mame2003"
}

function _get_so_name_lr-mame2003() {
    echo "mame2003"
}

function sources_lr-mame2003() {
    gitPullOrClone "$md_build" https://github.com/libretro/mame2003-libretro.git
}

function build_lr-mame2003() {
    rpSwap on 750
    make clean
    local params=()
    isPlatform "arm" && params+=("ARM=1")
    make ARCH="$CFLAGS" "${params[@]}"
    rpSwap off
    md_ret_require="$md_build/$(_get_so_name_${md_id})_libretro.so"
}

function install_lr-mame2003() {
    md_ret_files=(
        "$(_get_so_name_${md_id})_libretro.so"
        'README.md'
        'CHANGELOG.md'
        'metadata'
    )
}

function install_bin_lr-mame2003() {
    downloadAndExtract "$__gitbins_url/lr-mame2003.tar.gz" "$md_inst" 1
}

function configure_lr-mame2003() {
    local dir_name="$(_get_dir_name_${md_id})"

    local mame_dir
    local mame_sub_dir
    for mame_dir in arcade mame-libretro; do
        mkRomDir "$mame_dir"
        mkRomDir "$mame_dir/$dir_name"
        ensureSystemretroconfig "$mame_dir"

        for mame_sub_dir in cfg ctrlr diff hi memcard nvram; do
            mkRomDir "$mame_dir/$dir_name/$mame_sub_dir"
        done
    done

    mkUserDir "$biosdir/$dir_name"
    mkUserDir "$biosdir/$dir_name/samples"

    # copy hiscore.dat and cheat.dat
    cp "$md_inst/metadata/"{hiscore.dat,cheat.dat} "$biosdir/$dir_name/"
    chown $user:$user "$biosdir/$dir_name/"{hiscore.dat,cheat.dat}

    # lr-mame2003-plus also has an artwork folder
    if [[ "$md_id" == "lr-mame2003-plus" ]]; then
        mkUserDir "$biosdir/$dir_name/artwork"
        cp "$md_inst/metadata/artwork/"* "$biosdir/$dir_name/artwork/"
        chown -R $user:$user "$biosdir/$dir_name/artwork"
    fi

    # Set core options   
    setRetroArchCoreOption "${dir_name}_dcs-speedhack" "enabled"
    setRetroArchCoreOption "${dir_name}_samples" "enabled"
    setRetroArchCoreOption "${dir_name}_skip_disclaimer" "enabled"
    setRetroArchCoreOption "${dir_name}_analog" "digital"
    setRetroArchCoreOption "${dir_name}_analogscale" "rsn8887"
    setRetroArchCoreOption "${dir_name}_art_resolution" "1"
    setRetroArchCoreOption "${dir_name}_brightness" "1.0"
    setRetroArchCoreOption "${dir_name}_cheat_input ports" "disabled"
    setRetroArchCoreOption "${dir_name}_core_save_subfolder" "enabled"
    setRetroArchCoreOption "${dir_name}_core_sys_subfolder" "enabled"
    setRetroArchCoreOption "${dir_name}_dcs_speedhack" "enabled"
    setRetroArchCoreOption "${dir_name}_deadzone" "20"
    setRetroArchCoreOption "${dir_name}_display_artwork" "enabled"
    setRetroArchCoreOption "${dir_name}_display_setup" "disabled"
    setRetroArchCoreOption "${dir_name}_frameskip" "0"
    setRetroArchCoreOption "${dir_name}_gamma" "1.0"
    setRetroArchCoreOption "${dir_name}_input_interface" "simultaneous"
    setRetroArchCoreOption "${dir_name}_machine_timing" "enabled"
    setRetroArchCoreOption "${dir_name}_mame_remapping" "disabled"
    setRetroArchCoreOption "${dir_name}_mouse_device" "disabled"
    setRetroArchCoreOption "${dir_name}_nvram_bootstraps" "enabled"
    setRetroArchCoreOption "${dir_name}_sample_rate" "48000"
    setRetroArchCoreOption "${dir_name}_skip_disclaimer" "enabled"
    setRetroArchCoreOption "${dir_name}_skip_warnings" "enabled"
    setRetroArchCoreOption "${dir_name}_tate_mode" "disabled"

    local so_name="$(_get_so_name_${md_id})"
    addEmulator 0 "$md_id" "arcade" "$md_inst/${so_name}_libretro.so"
    addEmulator 1 "$md_id" "mame-libretro" "$md_inst/${so_name}_libretro.so"
    addSystem "arcade"
    addSystem "mame-libretro"
}
