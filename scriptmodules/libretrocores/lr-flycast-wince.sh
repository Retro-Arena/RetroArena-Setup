#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="lr-flycast-wince"
rp_module_desc="Dreamcast emu - flycast port for libretro - wince branch"
rp_module_help="Dreamcast ROM Extensions: .cdi .gdi .chd (chdman v5)\nAtomiswave/Naomi ROM Extensions: .bin .dat .zip (Mame 0.198+)\n\nCopy ROM files to:\n$romdir/dreamcast\n$romdir/atomiswave\n$romdir/naomi\n\nCopy BIOS files to: $biosdir/dc\ndc_boot.bin, dc_flash.bin, airlbios.zip, awbios.zip, f355bios.zip, f355dlx.zip, hod2bios.zip, naomi.zip\n\nCheck http://bit.do/lr-flycast-wince for more information."
rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/flycast-emulator/master/LICENSE"
rp_module_section="lr"
rp_module_flags="!odroid-xu"

function sources_lr-flycast-wince() {
    sources_lr-flycast
}

function build_lr-flycast-wince() {
    build_lr-flycast
}

function install_lr-flycast-wince() {
    install_lr-flycast
}

function install_bin_lr-flycast-wince() {
    downloadAndExtract "$__gitbins_url/lr-flycast-wince.tar.gz" "$md_inst" 1
}

function configure_lr-flycast-wince() {    
    configure_lr-flycast
}
