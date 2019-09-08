#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="lr-mess"
rp_module_desc="MESS emulator - MESS Port for libretro"
rp_module_help="see wiki for detailed explanation"
rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/mame/master/LICENSE.md"
rp_module_section="lr"

function depends_lr-mess() {
    depends_lr-mame
}

function sources_lr-mess() {
    gitPullOrClone "$md_build" https://github.com/libretro/mame.git
}

function build_lr-mess() {
    rpSwap on 5000
    local params=($(_get_params_lr-mame) SUBTARGET=mess)
    make clean
    make "${params[@]}" -j1
    rpSwap off
    md_ret_require="$md_build/mess_libretro.so"
}

function install_lr-mess() {
    md_ret_files=(
        'LICENSE.md'
        'mess_libretro.so'
        'README.md'
    )
}

function install_bin_lr-mess() {
    downloadAndExtract "$__gitbins_url/lr-mess.tar.gz" "$md_inst" 1
}

function configure_lr-mess() {
    local module="$1"
    [[ -z "$module" ]] && module="mess_libretro.so"

    local system
    for system in arcadia cdimono1 crvision coleco gb scv; do
        mkRomDir "$system"
        ensureSystemretroconfig "$system"
        addEmulator 1 "$md_id" "$system" "$md_inst/$module"
        addSystem "$system"
    done

    setRetroArchCoreOption "mame_softlists_enable" "enabled"
    setRetroArchCoreOption "mame_softlists_auto_media" "enabled"
    setRetroArchCoreOption "mame_boot_from_cli" "enabled"

    mkdir "$biosdir/mame"
    cp -rv "$md_build/hash" "$biosdir/mame/"
    chown -R $user:$user "$biosdir/mame"
    cp -R "$scriptdir/configs/cdimono1/." "$md_conf_root/cdimono1/"
    cp -R "$scriptdir/configs/scv/." "$md_conf_root/scv/"
}
