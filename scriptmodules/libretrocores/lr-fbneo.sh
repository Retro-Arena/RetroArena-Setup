#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="lr-fbneo"
rp_module_desc="Arcade emu - FinalBurn Neo v0.2.97.44 port for libretro"
rp_module_help="ROM Extension: .zip\n\nCopy your roms to\n$romdir/fbneo or\n$romdir/neogeo or\n$romdir/arcade\n\nFor NeoGeo games the neogeo.zip BIOS is required and must be placed in the same directory as your roms."
rp_module_licence="NONCOM https://raw.githubusercontent.com/libretro/FBNeo/master/src/license.txt"
rp_module_section="lr"

function sources_lr-fbneo() {
    gitPullOrClone "$md_build" https://github.com/libretro/FBNeo.git
}

function build_lr-fbneo() {
    cd src/burner/libretro
    local params=()
    isPlatform "arm" && params+=(USE_CYCLONE=1)
    isPlatform "neon" && params+=(HAVE_NEON=1)
    isPlatform "x86" && isPlatform "64bit" && params+=(USE_X64_DRC=1)
    make clean
    make "${params[@]}"
    md_ret_require="$md_build/src/burner/libretro/fbneo_libretro.so"
}

function install_lr-fbneo() {
    md_ret_files=(
        'fba.chm'
        'src/burner/libretro/fbneo_libretro.so'
        'gamelist.txt'
        'whatsnew.html'
        'preset-example.zip'
        'metadata'
        'dats'
    )
}

function install_bin_lr-fbneo() {
    downloadAndExtract "$__gitbins_url/lr-fbneo.tar.gz" "$md_inst" 1
}

function configure_lr-fbneo() {
    local dir
    for dir in arcade neogeo neocdz fbneo pcengine supergrafx tg16 gamegear mastersystem megadrive sg-1000 coleco msx zxspectrum; do
        mkRomDir "$dir"
        ensureSystemretroconfig "$dir"
    done

    # Create samples directory
    mkUserDir "$biosdir/fbneo"
    mkUserDir "$biosdir/fbneo/samples"

    # copy hiscore.dat
    cp "$md_inst/metadata/hiscore.dat" "$biosdir/fbneo/"
    chown $user:$user "$biosdir/fbneo/hiscore.dat"

    # Set core options
    setRetroArchCoreOption "fbneo-diagnostic-input" "Hold Start"

    addEmulator 0 "$md_id" "arcade" "$md_inst/fbneo_libretro.so"
    addEmulator 0 "$md_id-neocd" "arcade" "$md_inst/fbneo_libretro.so --subsystem neocd"
    addEmulator 1 "$md_id" "neogeo" "$md_inst/fbneo_libretro.so"
    addEmulator 0 "$md_id-neocd" "neogeo" "$md_inst/fbneo_libretro.so --subsystem neocd"
    addEmulator 1 "$md_id-neocd" "neocdz" "$md_inst/fbneo_libretro.so --subsystem neocd"
    addEmulator 1 "$md_id" "fbneo" "$md_inst/fbneo_libretro.so"
    addEmulator 0 "$md_id-neocd" "fbneo" "$md_inst/fbneo_libretro.so --subsystem neocd"
    addEmulator 0 "$md_id-pce" "pcengine" "$md_inst/fbneo_libretro.so --subsystem pce"
    addEmulator 0 "$md_id-sgx" "supergrafx" "$md_inst/fbneo_libretro.so --subsystem sgx"
    addEmulator 0 "$md_id-tg" "tg16" "$md_inst/fbneo_libretro.so --subsystem tg"
    addEmulator 0 "$md_id-gg" "gamegear" "$md_inst/fbneo_libretro.so --subsystem gg"
    addEmulator 0 "$md_id-sms" "mastersystem" "$md_inst/fbneo_libretro.so --subsystem sms"
    addEmulator 0 "$md_id-md" "megadrive" "$md_inst/fbneo_libretro.so --subsystem md"
    addEmulator 0 "$md_id-sg1k" "sg-1000" "$md_inst/fbneo_libretro.so --subsystem sg1k"
    addEmulator 0 "$md_id-cv" "coleco" "$md_inst/fbneo_libretro.so --subsystem cv"
    addEmulator 0 "$md_id-msx" "msx" "$md_inst/fbneo_libretro.so --subsystem msx"
    addEmulator 0 "$md_id-spec" "zxspectrum" "$md_inst/fbneo_libretro.so --subsystem spec"

    addSystem "arcade"
    addSystem "neogeo"
    addSystem "neocdz"
    addSystem "fbneo"
    addSystem "pcengine"
    addSystem "supergrafx"
    addSystem "tg16"
    addSystem "gamegear"
    addSystem "mastersystem"
    addSystem "megadrive"
    addSystem "sg-1000"
    addSystem "coleco"
    addSystem "msx"
    addSystem "zxspectrum"
}

function gui_lr-fbneo() {
    while true; do
        local options=()
            [[ -e "$home/.config/auc_lr-fbneo" ]] && options+=(A "Disable lr-fbneo AutoUpdate") || options+=(A "Enable lr-fbneo AutoUpdate")
        local cmd=(dialog --backtitle "$__backtitle" --menu "Choose an option" 22 76 16)
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        [[ -z "$choice" ]] && break
        case "$choice" in
            A)
                if [[ -e "$home/.config/au_service" ]]; then
                    if [[ -e "$home/.config/auc_lr-fbneo" ]]; then
                        rm -rf "$home/.config/auc_lr-fbneo"
                        printMsgs "dialog" "Disabled lr-fbneo AutoUpdate"
                    else
                        touch "$home/.config/auc_lr-fbneo"
                        printMsgs "dialog" "Enabled lr-fbneo AutoUpdate\n\nThe update will occur daily at 10:00 UTC / 03:00 PT."
                    fi
                else
                    printMsgs "dialog" "ERROR\n\nAutoUpdate Service must be enabled."
                fi
                ;;
        esac
    done
}
