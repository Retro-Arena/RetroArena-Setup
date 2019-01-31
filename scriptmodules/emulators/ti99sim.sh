#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="ti99sim"
rp_module_desc="TI-99/SIM - Texas Instruments Home Computer Emulator"
rp_module_help="ROM Extensions: .ctg .dsk .cf7\n\nCopy your TI-99 games to $romdir/ti99\n\nCopy the required BIOS files TI-994A.ctg cf7+.ctg ti-disk.ctg (case sensitive) to $biosdir. \n For Disk Support you will also require a TI Extended Basic cartridge named xb.ctg \n and an Editor Assembler cartridge named ea.ctg in the $romdir/ti99 folder "
rp_module_licence="GPL2 http://www.mrousseau.org/programs/ti99sim/"
rp_module_section="sa"
rp_module_flags=" !kms"

function depends_ti99sim() {
    getDepends libsdl1.2-dev libssl-dev
}

function sources_ti99sim() {
    downloadAndExtract "http://www.mrousseau.org/programs/ti99sim/archives/ti99sim-0.15.0.src.tar.xz" "$md_build" 1
}

function build_ti99sim() {
    make
}

function install_ti99sim() {
    md_ret_files=(
        'bin/ti99sim-sdl'
    )
}

function install_bin_ti99sim() {
    downloadAndExtract "$__gitbins_url/ti99sim.tar.gz" "$md_inst" 1
}

function configure_ti99sim() {
    mkRomDir "ti99"
    moveConfigDir "$home/.ti99sim" "$md_conf_root/ti99/"
    ln -sf "$biosdir/TI-994A.ctg" "$md_inst/TI-994A.ctg"
    ln -sf "$biosdir/ti-disk.ctg" "$md_inst/ti-disk.ctg"
    ln -sf "$biosdir/cf7+.ctg" "$md_inst/cf7+.ctg"

    addEmulator 1 "$md_id-carts" "ti99" "pushd $md_inst; $md_inst/ti99sim-sdl --no-cf7 -f=2 %ROM%; popd"
    addEmulator 0 "$md_id-xbasic+disk" "ti99" "pushd $md_inst; $md_inst/ti99sim-sdl --no-cf7 -f=2 --dsk1=%ROM% "$romdir/ti99/xb.ctg"; popd"
    addEmulator 0 "$md_id-xbasic+cf7" "ti99" "pushd $md_inst; $md_inst/ti99sim-sdl -f=2 --cf7=%ROM% "$romdir/ti99/xb.ctg"; popd"
    addEmulator 0 "$md_id-ea+disk" "ti99" "pushd $md_inst; $md_inst/ti99sim-sdl --no-cf7 -f=2 --dsk1=%ROM% "$romdir/ti99/ea.ctg"; popd"
    addEmulator 0 "$md_id-ea+cf7" "ti99" "pushd $md_inst; $md_inst/ti99sim-sdl -f=2 --cf7=%ROM% "$romdir/ti99/ea.ctg"; popd"
    addSystem "ti99"
}
