#!/usr/bin/env bash

# This file is part of the RetroArena Project
# and is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#
# Core script functionality is based upon The RetroPie Project https://retropie.org.uk Script Modules

rp_module_id="kernel-headers"
rp_module_desc="Linux Kernel Headers"
rp_module_help="This module will download, compile and install the Linux kernel headers for the Odroid XU4, Odroid N2 or RockPro64"
rp_module_section="driver"
rp_module_flags="!x86"

function sources_kernel-headers() {
    if isPlatform "odroid-xu"; then
        gitPullOrClone "$md_build"  https://github.com/Retro-Arena/linux.git odroidxu3-3.10.y
	elif isPlatform "rockpro64"; then
        gitPullOrClone "$md_build" https://github.com/mrfixit2001/rockchip-kernel.git
    elif isPlatform "odroid-n2"; then 
        gitPullOrClone "$md_build"  https://github.com/Retro-Arena/linux.git odroidn2-4.9.y-upstream
	fi
}
function build_kernel-headers() {
    rm -r /lib/modules/$(uname -r)/build
    rm -r /lib/modules/$(uname -r)/source
    make -j5 INSTALL_HDR_PATH=/usr/src/linux-headers-$(uname -r)/ headers_install
    
}

function install_kernel-headers() {
    mv  -T "$md_build" /usr/src/linux-$(uname -r)/
    ln -sfn /usr/src/linux-$(uname -r) /lib/modules/$(uname -r)/build
    ln -sfn /usr/src/linux-$(uname -r) /lib/modules/$(uname -r)/source
}
