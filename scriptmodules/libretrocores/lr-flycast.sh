#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="lr-flycast"
rp_module_desc="Dreamcast emu - flycast port for libretro"
rp_module_help="Dreamcast ROM Extensions: .cdi .gdi .chd (chdman v5)\nAtomiswave/Naomi ROM Extensions: .bin .dat .zip (Mame 0.198+)\n\nCopy ROM files to:\n$romdir/dreamcast\n$romdir/atomiswave\n$romdir/naomi\n\nCopy BIOS files to: $biosdir/dc\ndc_boot.bin, dc_flash.bin, airlbios.zip, awbios.zip, f355bios.zip, f355dlx.zip, hod2bios.zip, naomi.zip\n\nCheck http://bit.do/lr-flycast for more information."
rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/flycast-emulator/master/LICENSE"
rp_module_section="lr"

function sources_lr-flycast() {
    local branch"master"
    local commit=""
    isPlatform "rockpro64" && commit=("aefaf1068f5bc70b9e0a5eb6b0143288153d7031")
    gitPullOrClone "$md_build" https://github.com/libretro/flycast.git "$branch" "$commit"
    isPlatform "rockpro64" && applyPatch "$md_data/buildfix.patch"
}

function build_lr-flycast() {
    make clean
    if isPlatform "rockpro64"; then
        make platform=rockpro64 ARCH=arm
    elif isPlatform "odroid-n2"; then
        make platform=odroid-n2
    else
        make platform=odroid BOARD="ODROID-XU3" ARCH=arm
    fi
    md_ret_require="$md_build/flycast_libretro.so"
}

function install_lr-flycast() {
    md_ret_files=(
        'flycast_libretro.so'
    )
}

function install_bin_lr-flycast() {
    downloadAndExtract "$__gitbins_url/lr-flycast.tar.gz" "$md_inst" 1
}

function configure_lr-flycast() {    
    # bios
    mkUserDir "$biosdir/dc"
    
    local system
    for system in atomiswave dreamcast naomi; do
        mkRomDir "$system"
        ensureSystemretroconfig "$system"
        iniConfig " = " "" "$configdir/$system/retroarch.cfg"
        iniSet "video_shared_context" "true"
        addEmulator 1 "$md_id" "$system" "$md_inst/flycast_libretro.so </dev/null"
        addSystem "$system"
    done

    # set core options
    setRetroArchCoreOption "${dir_name}flycast_allow_service_buttons" "enabled"
    setRetroArchCoreOption "${dir_name}flycast_alpha_sorting" "per-triangle (normal)"
    setRetroArchCoreOption "${dir_name}flycast_analog_stick_deadzone" "15%"
    setRetroArchCoreOption "${dir_name}flycast_boot_to_bios" "disabled"
    setRetroArchCoreOption "${dir_name}flycast_broadcast" "NTSC"
    setRetroArchCoreOption "${dir_name}flycast_cable_type" "TV (RGB)"
    setRetroArchCoreOption "${dir_name}flycast_cpu_mode" "dynamic_recompiler"
    setRetroArchCoreOption "${dir_name}flycast_digital_triggers" "disabled"
    setRetroArchCoreOption "${dir_name}flycast_div_matching" "auto"
    setRetroArchCoreOption "${dir_name}flycast_enable_dsp" "disabled"
    setRetroArchCoreOption "${dir_name}flycast_enable_purupuru" "enabled"
    setRetroArchCoreOption "${dir_name}flycast_enable_rtt" "disabled"
    setRetroArchCoreOption "${dir_name}flycast_enable_rttb" "disabled"
    setRetroArchCoreOption "${dir_name}flycast_framerate" "fullspeed"
    setRetroArchCoreOption "${dir_name}flycast_gdrom_fast_loading" "disabled"
    setRetroArchCoreOption "${dir_name}flycast_internal_resolution" "640x480"
    setRetroArchCoreOption "${dir_name}flycast_mipmapping" "enabled"
    setRetroArchCoreOption "${dir_name}flycast_region" "USA"
    setRetroArchCoreOption "${dir_name}flycast_render_to_texture_upscaling" "1x"
    setRetroArchCoreOption "${dir_name}flycast_screen_rotation" "horizontal"
    setRetroArchCoreOption "${dir_name}flycast_synchronous_rendering" "enabled"
    setRetroArchCoreOption "${dir_name}flycast_system" "auto"
    setRetroArchCoreOption "${dir_name}flycast_texupscale" "off"
    setRetroArchCoreOption "${dir_name}flycast_texupscale_max_filtered_texture_size" "1024"
    setRetroArchCoreOption "${dir_name}flycast_threaded_rendering" "enabled"
    setRetroArchCoreOption "${dir_name}flycast_trigger_deadzone" "0%"
    setRetroArchCoreOption "${dir_name}flycast_vmu1_pixel_off_color" "DEFAULT_OFF 01"
    setRetroArchCoreOption "${dir_name}flycast_vmu1_pixel_on_color" "DEFAULT_ON 00"
    setRetroArchCoreOption "${dir_name}flycast_vmu1_screen_display" "disabled"
    setRetroArchCoreOption "${dir_name}flycast_vmu1_screen_opacity" "100%"
    setRetroArchCoreOption "${dir_name}flycast_vmu1_screen_position" "Upper Left"
    setRetroArchCoreOption "${dir_name}flycast_vmu1_screen_size_mult" "1x"
    setRetroArchCoreOption "${dir_name}flycast_vmu2_pixel_off_color" "DEFAULT_OFF 01"
    setRetroArchCoreOption "${dir_name}flycast_vmu2_pixel_on_color" "DEFAULT_ON 00"
    setRetroArchCoreOption "${dir_name}flycast_vmu2_screen_display" "disabled"
    setRetroArchCoreOption "${dir_name}flycast_vmu2_screen_opacity" "100%"
    setRetroArchCoreOption "${dir_name}flycast_vmu2_screen_position" "Upper Left"
    setRetroArchCoreOption "${dir_name}flycast_vmu2_screen_size_mult" "1x"
    setRetroArchCoreOption "${dir_name}flycast_vmu3_pixel_off_color" "DEFAULT_OFF 01"
    setRetroArchCoreOption "${dir_name}flycast_vmu3_pixel_on_color" "DEFAULT_ON 00"
    setRetroArchCoreOption "${dir_name}flycast_vmu3_screen_display" "disabled"
    setRetroArchCoreOption "${dir_name}flycast_vmu3_screen_opacity" "100%"
    setRetroArchCoreOption "${dir_name}flycast_vmu3_screen_position" "Upper Left"
    setRetroArchCoreOption "${dir_name}flycast_vmu3_screen_size_mult" "1x"
    setRetroArchCoreOption "${dir_name}flycast_vmu4_pixel_off_color" "DEFAULT_OFF 01"
    setRetroArchCoreOption "${dir_name}flycast_vmu4_pixel_on_color" "DEFAULT_ON 00"
    setRetroArchCoreOption "${dir_name}flycast_vmu4_screen_display" "disabled"
    setRetroArchCoreOption "${dir_name}flycast_vmu4_screen_opacity" "100%"
    setRetroArchCoreOption "${dir_name}flycast_vmu4_screen_position" "Upper Left"
    setRetroArchCoreOption "${dir_name}flycast_vmu4_screen_size_mult" "1x"
    setRetroArchCoreOption "${dir_name}flycast_volume_modifier_enable" "enabled"
    setRetroArchCoreOption "${dir_name}flycast_widescreen_hack" "disabled"
    
    # copy configs
    cp -R "$scriptdir/configs/all/retroarch/config/flycast/." "$md_conf_root/all/retroarch/config/flycast"

    if isPlatform="odroid-n2"; then
        sed -i -e 's/flycast_internal_resolution = "640x480"/flycast_internal_resolution = "1280x960"/g' "$md_conf_root/all/retroarch-core-options.cfg"    
        cd "/opt/retroarena/configs/all/retroarch/config/flycast"
        find . -type f -name "*.opt" -print0 | xargs -0 sed -i '' -e 's/640x480/1280x960/g'
        cd -
    fi
}
