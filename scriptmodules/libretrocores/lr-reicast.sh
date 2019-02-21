#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="lr-reicast"
rp_module_desc="Dreamcast emu - Reicast port for libretro"
rp_module_help="Dreamcast ROM Extensions: .cdi .gdi .chd (chdman v5)\nAtomiswave/Naomi ROM Extensions: .bin .dat .zip (Mame 0.198+)\n\nCopy ROM files to:\n$romdir/dreamcast\n$romdir/atomiswave\n$romdir/naomi\n\nCopy BIOS files to: $biosdir/dc\ndc_boot.bin, dc_flash.bin, airlbios.zip, awbios.zip, f355bios.zip, f355dlx.zip, hod2bios.zip, naomi.zip\n\nCheck http://bit.do/lr-reicast for more information."

rp_module_licence="GPL2 https://raw.githubusercontent.com/libretro/reicast-emulator/master/LICENSE"
rp_module_section="lr"

function sources_lr-reicast() {
    local branch"master"
    local commit=""
    isPlatform "rockpro64" && commit=("aefaf1068f5bc70b9e0a5eb6b0143288153d7031")
    gitPullOrClone "$md_build" https://github.com/libretro/reicast-emulator.git "$branch" "$commit"
    isPlatform "rockpro64" && applyPatch "$md_data/buildfix.patch"
}

function build_lr-reicast() {
    make clean
    if isPlatform "rockpro64"; then
        make platform=rockpro64 ARCH=arm
    elif isPlatform "odroid-n2"; then
        make platform=odroid-n2
    else
        make platform=odroid BOARD="ODROID-XU3" ARCH=arm
    fi
    md_ret_require="$md_build/reicast_libretro.so"
}

function install_lr-reicast() {
    md_ret_files=(
        'reicast_libretro.so'
    )
}

function install_bin_lr-reicast() {
    downloadAndExtract "$__gitbins_url/lr-reicast.tar.gz" "$md_inst" 1
}

function configure_lr-reicast() {    
    # bios
    mkUserDir "$biosdir/dc"
    
    local system
    for system in atomiswave dreamcast naomi; do
        mkRomDir "$system"
        ensureSystemretroconfig "$system"
        iniConfig " = " "" "$configdir/$system/retroarch.cfg"
        iniSet "video_shared_context" "true"
        addEmulator 1 "$md_id" "$system" "$md_inst/reicast_libretro.so"
        addSystem "$system"
    done
    
    # temp fix
    sed -i -e 's:/opt/retroarena/emulators/retroarch/bin/retroarch:/opt/retroarena/emulators/retroarch/bin/retroarch < /dev/null :g' "$configdir/atomiswave/emulators.cfg"
    sed -i -e 's:/opt/retroarena/emulators/retroarch/bin/retroarch:/opt/retroarena/emulators/retroarch/bin/retroarch < /dev/null :g' "$configdir/dreamcast/emulators.cfg"
    sed -i -e 's:/opt/retroarena/emulators/retroarch/bin/retroarch:/opt/retroarena/emulators/retroarch/bin/retroarch < /dev/null :g' "$configdir/naomi/emulators.cfg"

    # set core options
    setRetroArchCoreOption "${dir_name}reicast_allow_service_buttons" "enabled"
    setRetroArchCoreOption "${dir_name}reicast_alpha_sorting" "per-triangle (normal)"
    setRetroArchCoreOption "${dir_name}reicast_analog_stick_deadzone" "15%"
    setRetroArchCoreOption "${dir_name}reicast_audio_buffer_size" "2048"
    setRetroArchCoreOption "${dir_name}reicast_boot_to_bios" "disabled"
    setRetroArchCoreOption "${dir_name}reicast_broadcast" "NTSC"
    setRetroArchCoreOption "${dir_name}reicast_cable_type" "TV (RGB)"
    setRetroArchCoreOption "${dir_name}reicast_cpu_mode" "dynamic_recompiler"
    setRetroArchCoreOption "${dir_name}reicast_digital_triggers" "disabled"
    setRetroArchCoreOption "${dir_name}reicast_div_matching" "auto"
    setRetroArchCoreOption "${dir_name}reicast_enable_dsp" "disabled"
    setRetroArchCoreOption "${dir_name}reicast_enable_purupuru" "enabled"
    setRetroArchCoreOption "${dir_name}reicast_enable_rtt" "disabled"
    setRetroArchCoreOption "${dir_name}reicast_enable_rttb" "disabled"
    setRetroArchCoreOption "${dir_name}reicast_extra_depth_scale" "auto"
    setRetroArchCoreOption "${dir_name}reicast_framerate" "fullspeed"
    setRetroArchCoreOption "${dir_name}reicast_gdrom_fast_loading" "disabled"
    setRetroArchCoreOption "${dir_name}reicast_internal_resolution" "640x480"
    setRetroArchCoreOption "${dir_name}reicast_mipmapping" "enabled"
    setRetroArchCoreOption "${dir_name}reicast_region" "USA"
    setRetroArchCoreOption "${dir_name}reicast_render_to_texture_upscaling" "1x"
    setRetroArchCoreOption "${dir_name}reicast_screen_rotation" "horizontal"
    setRetroArchCoreOption "${dir_name}reicast_synchronous_rendering" "enabled"
    setRetroArchCoreOption "${dir_name}reicast_system" "auto"
    setRetroArchCoreOption "${dir_name}reicast_texupscale" "off"
    setRetroArchCoreOption "${dir_name}reicast_texupscale_max_filtered_texture_size" "1024"
    setRetroArchCoreOption "${dir_name}reicast_threaded_rendering" "enabled"
    setRetroArchCoreOption "${dir_name}reicast_trigger_deadzone" "0%"
    setRetroArchCoreOption "${dir_name}reicast_vmu1_pixel_off_color" "DEFAULT_OFF 01"
    setRetroArchCoreOption "${dir_name}reicast_vmu1_pixel_on_color" "DEFAULT_ON 00"
    setRetroArchCoreOption "${dir_name}reicast_vmu1_screen_display" "disabled"
    setRetroArchCoreOption "${dir_name}reicast_vmu1_screen_opacity" "100%"
    setRetroArchCoreOption "${dir_name}reicast_vmu1_screen_position" "Upper Left"
    setRetroArchCoreOption "${dir_name}reicast_vmu1_screen_size_mult" "1x"
    setRetroArchCoreOption "${dir_name}reicast_vmu2_pixel_off_color" "DEFAULT_OFF 01"
    setRetroArchCoreOption "${dir_name}reicast_vmu2_pixel_on_color" "DEFAULT_ON 00"
    setRetroArchCoreOption "${dir_name}reicast_vmu2_screen_display" "disabled"
    setRetroArchCoreOption "${dir_name}reicast_vmu2_screen_opacity" "100%"
    setRetroArchCoreOption "${dir_name}reicast_vmu2_screen_position" "Upper Left"
    setRetroArchCoreOption "${dir_name}reicast_vmu2_screen_size_mult" "1x"
    setRetroArchCoreOption "${dir_name}reicast_vmu3_pixel_off_color" "DEFAULT_OFF 01"
    setRetroArchCoreOption "${dir_name}reicast_vmu3_pixel_on_color" "DEFAULT_ON 00"
    setRetroArchCoreOption "${dir_name}reicast_vmu3_screen_display" "disabled"
    setRetroArchCoreOption "${dir_name}reicast_vmu3_screen_opacity" "100%"
    setRetroArchCoreOption "${dir_name}reicast_vmu3_screen_position" "Upper Left"
    setRetroArchCoreOption "${dir_name}reicast_vmu3_screen_size_mult" "1x"
    setRetroArchCoreOption "${dir_name}reicast_vmu4_pixel_off_color" "DEFAULT_OFF 01"
    setRetroArchCoreOption "${dir_name}reicast_vmu4_pixel_on_color" "DEFAULT_ON 00"
    setRetroArchCoreOption "${dir_name}reicast_vmu4_screen_display" "disabled"
    setRetroArchCoreOption "${dir_name}reicast_vmu4_screen_opacity" "100%"
    setRetroArchCoreOption "${dir_name}reicast_vmu4_screen_position" "Upper Left"
    setRetroArchCoreOption "${dir_name}reicast_vmu4_screen_size_mult" "1x"
    setRetroArchCoreOption "${dir_name}reicast_volume_modifier_enable" "enabled"
    setRetroArchCoreOption "${dir_name}reicast_widescreen_hack" "disabled"
}
