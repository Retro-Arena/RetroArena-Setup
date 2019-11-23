#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="advmame-1.4"
rp_module_desc="AdvanceMAME v1.4"
rp_module_help="ROM Extension: .zip\n\nCopy your AdvanceMAME roms to either $romdir/mame-advmame or\n$romdir/arcade"
rp_module_licence="GPL2 https://raw.githubusercontent.com/amadvance/advancemame/master/COPYING"
rp_module_section="sa"
rp_module_flags="!odroid-n2"

function depends_advmame-1.4() {
    local depends=(libsdl1.2-dev)
    getDepends "${depends[@]}"
}

function _sources_patch_advmame-1.4() {
    # update internal names to separate out config files (due to incompatible options)
    sed -i "s/advmame\.rc/$md_id.rc/" advance/v/v.c advance/cfg/cfg.c

    if grep -q "ADVANCE_NAME" advance/osd/emu.h; then
        sed -i "s/ADVANCE_NAME \"advmame\"/ADVANCE_NAME \"$md_id\"/" advance/osd/emu.h
    else
        sed -i "s/ADV_NAME \"advmame\"/ADV_NAME \"$md_id\"/" advance/osd/emu.h
    fi

    if isPlatform "rpi"; then
        if grep -q "MAP_FIXED" advance/linux/vfb.c; then
            sed -i 's/MAP_SHARED | MAP_FIXED,/MAP_SHARED,/' advance/linux/vfb.c
        fi

        # patch advmame to use a fake generated mode with the exact dimensions for fb - avoids need for configuring monitor / clocks.
        # the pi framebuffer doesn't use any of the framebuffer timing configs - it hardware scales from chosen dimensions to actual size
        applyPatch "$scriptdir/scriptmodules/$md_type/advmame/01_rpi_framebuffer.diff"
    fi
}

function sources_advmame-1.4() {
    downloadAndExtract "$__archive_url/advancemame-1.4.tar.gz" "$md_build" 1
    _sources_patch_advmame-1.4 1.4
}

function build_advmame-1.4() {
    ./configure CFLAGS="$CFLAGS -fsigned-char -fno-stack-protector" LDFLAGS="-s -lm -Wl,--no-as-needed" --prefix="$md_inst"
    make clean
    make
}

function install_advmame-1.4() {
    make install
}

function install_bin_advmame-1.4() {
    downloadAndExtract "$__gitbins_url/advmame-1.4.tar.gz" "$md_inst" 1
}

function configure_advmame-1.4() {
    configure_advmame
     cp "$scriptdir/configs/mame-advmame/advmame-1.4.rc" "$md_conf_root/mame-advmame/"
	 
    if  isPlatform "odroid-n2"; then
   cd ~/mali
   ./install.sh
fi
}
