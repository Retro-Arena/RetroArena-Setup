#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="retroarch"
rp_module_desc="RetroArch v1.8.1 - stable branch"
rp_module_licence="GPL3 https://raw.githubusercontent.com/libretro/RetroArch/master/COPYING"
rp_module_section="core"

function depends_retroarch() {
    local depends=(libudev-dev libxkbcommon-dev libsdl2-dev libasound2-dev libusb-1.0-0-dev libpulse-dev)
    isPlatform "odroid-xu" && depends+=(libavcodec-dev libavformat-dev libavdevice-dev)
    getDepends "${depends[@]}"
	if isPlatform "odroid-n2"; then
	~/RetroArena-Setup/fixmali.sh
	fi
}

function sources_retroarch() {
    if [ "$md_id" == "retroarch" ]; then
        gitPullOrClone "$md_build" https://github.com/libretro/RetroArch.git v1.8.1
        applyPatch "$md_data/01_hotkey_hack.diff"
        applyPatch "$md_data/02_disable_search.diff"
		
    else
        gitPullOrClone "$md_build" https://github.com/libretro/RetroArch.git
        applyPatch "$md_data/01_hotkey_hack.diff"
        applyPatch "$md_data/02_disable_search.diff"
    fi
}

function build_retroarch() {
    local params=(--enable-pulse --enable-sdl2  --disable-al --disable-cdrom --disable-discord --disable-jack --disable-kms --disable-materialui --disable-opengl1 --disable-oss --disable-sdl --disable-qt --disable-videocore --disable-vulkan --disable-vulkan_display --disable-wayland --disable-x11 --disable-xmb)
    isPlatform "gles" && params+=(--enable-opengles --enable-opengles3)
    isPlatform "mali" && params+=(--enable-mali_fbdev)
    isPlatform "kms" && params+=(--enable-kms --enable-egl)
    isPlatform "arm" && params+=(--enable-floathard)
    isPlatform "neon" && params+=(--enable-neon)
       
    ./configure --prefix="$md_inst" "${params[@]}"
    make clean
    make
    md_ret_require="$md_build/retroarch"
}

function install_retroarch() {
    make install
    md_ret_files=(
        'retroarch.cfg'
    )
}

function install_bin_retroarch() {   
    downloadAndExtract "$__gitbins_url/retroarch.tar.gz" "$md_inst" 1
}

function update_assets_retroarch() {
    local dir="$configdir/all/retroarch/assets"
    [[ ! -d "$dir/.git" ]] && rm -rf "$dir"
    gitPullOrClone "$dir" https://github.com/libretro/retroarch-assets.git
    chown -R $user:$user "$dir"
}

function update_cheats_retroarch() {
    local dir="$configdir/all/retroarch/cheats"
    [[ ! -d "$dir/.git" ]] && rm -rf "$dir"
    gitPullOrClone "$dir" https://github.com/Retro-Arena/cheats.git
    chown -R $user:$user "$dir"
}

function update_overlays_retroarch() {
    local dir="$configdir/all/retroarch/overlay"
    [[ ! -d "$dir/.git" ]] && rm -rf "$dir"
    gitPullOrClone "$dir" https://github.com/libretro/common-overlays.git
    chown -R $user:$user "$dir"
}

function update_shaders_retroarch() {
    local dir="$configdir/all/retroarch/shaders"
    [[ ! -d "$dir/.git" ]] && rm -rf "$dir"
    gitPullOrClone "$dir" https://github.com/Retro-Arena/glsl-shaders.git
    chown -R $user:$user "$dir"
}

function configure_retroarch() {
    [[ "$md_mode" == "remove" ]] && return
    
    addUdevInputRules

    # move / symlink the retroarch configuration
    mkUserDir "$home/.config"
    moveConfigDir "$home/.config/retroarch" "$configdir/all/retroarch"

    # move / symlink our old retroarch-joypads folder
    moveConfigDir "$configdir/all/retroarch-joypads" "$configdir/all/retroarch/autoconfig"

    # move / symlink old assets / overlays and shader folder
    moveConfigDir "$md_inst/assets" "$configdir/all/retroarch/assets"
    moveConfigDir "$md_inst/cheats" "$configdir/all/retroarch/cheats"
    moveConfigDir "$md_inst/overlays" "$configdir/all/retroarch/overlay"
    moveConfigDir "$md_inst/shader" "$configdir/all/retroarch/shaders"

    # install assets, cheats and shaders by default
    update_assets_retroarch
    update_cheats_retroarch
    update_shaders_retroarch

    local config="$(mktemp)"

    cp "$md_inst/retroarch.cfg" "$config"

    # query ES A/B key swap configuration
    local es_swap="false"
    getAutoConf "es_swap_a_b" && es_swap="true"

    # configure default options
    iniConfig " = " '"' "$config"
    iniSet "cache_directory" "/tmp/retroarch"
    iniSet "core_options_path" "$configdir/all/retroarch-core-options.cfg"
    iniSet "system_directory" "$biosdir"
    iniSet "config_save_on_exit" "false"
    iniSet "video_scale" "1.0"
    iniSet "video_threaded" "true"
    iniSet "video_smooth" "false"
    iniSet "video_aspect_ratio_auto" "true"
    iniSet "video_shader_enable" "true"
    iniSet "auto_shaders_enable" "true"
    iniSet "audio_out_rate" "44100"

    # enable hotkey ("select" button)
    iniSet "input_enable_hotkey" "nul"
    iniSet "input_exit_emulator" "escape"

    # enable and configure rewind feature
    iniSet "rewind_enable" "false"
    iniSet "rewind_buffer_size" "10"
    iniSet "rewind_granularity" "2"
    iniSet "input_rewind" "r"

    # enable gpu screenshots
    iniSet "video_gpu_screenshot" "true"

    # enable and configure shaders
    iniSet "input_shader_next" "m"
    iniSet "input_shader_prev" "n"

    # configure keyboard mappings
    iniSet "input_player1_a" "x"
    iniSet "input_player1_b" "z"
    iniSet "input_player1_y" "a"
    iniSet "input_player1_x" "s"
    iniSet "input_player1_start" "enter"
    iniSet "input_player1_select" "rshift"
    iniSet "input_player1_l" "q"
    iniSet "input_player1_r" "w"
    iniSet "input_player1_left" "left"
    iniSet "input_player1_right" "right"
    iniSet "input_player1_up" "up"
    iniSet "input_player1_down" "down"

    # input settings
    iniSet "input_joypad_driver" "udev"
    iniSet "input_autodetect_enable" "true"
    iniSet "auto_remaps_enable" "true"
    iniSet "all_users_control_menu" "true"
    iniSet "input_reset_btn" "h0down"

    # visual settings
    iniSet "content_show_add" "false"
    iniSet "content_show_favorites" "false"
    iniSet "content_show_history" "false"
    iniSet "content_show_images" "false"
    iniSet "content_show_music" "false"
    iniSet "content_show_netplay" "false"
    iniSet "content_show_playlists" "false"
    iniSet "content_show_settings" "true"
    iniSet "content_show_settings_password" ""
    iniSet "content_show_video" "false"
    iniSet "kiosk_mode_enable" "false"
    iniSet "kiosk_mode_password" ""
    iniSet "menu_battery_level_enable" "false"
    iniSet "menu_core_enable" "true"
    iniSet "menu_driver" "ozone"
    iniSet "menu_dynamic_wallpaper_enable" "false"
    iniSet "menu_enable_widgets" "false"
    iniSet "menu_entry_hover_color" "ff64ff64"
    iniSet "menu_entry_normal_color" "ffffffff"
    iniSet "menu_font_color_blue" "255"
    iniSet "menu_font_color_green" "255"
    iniSet "menu_font_color_red" "255"
    iniSet "menu_footer_opacity" "1.000000"
    iniSet "menu_framebuffer_opacity" "0.500000"
    iniSet "menu_header_opacity" "1.000000"
    iniSet "menu_horizontal_animation" "true"
    iniSet "menu_left_thumbnails" "0"
    iniSet "menu_linear_filter" "true"
    iniSet "menu_mouse_enable" "true"
    iniSet "menu_navigation_browser_filter_supported_extensions_enable" "true"
    iniSet "menu_navigation_wraparound_enable" "true"
    iniSet "menu_pause_libretro" "true"
    iniSet "menu_pointer_enable" "false"
    iniSet "menu_shader_pipeline" "0"
    iniSet "menu_show_advanced_settings" "true"
    iniSet "menu_show_configurations" "true"
    iniSet "menu_show_core_updater" "false"
    iniSet "menu_show_help" "false"
    iniSet "menu_show_information" "false"
    iniSet "menu_show_latency" "false"
    iniSet "menu_show_legacy_thumbnail_updater" "false"
    iniSet "menu_show_load_content" "false"
    iniSet "menu_show_load_core" "false"
    iniSet "menu_show_online_updater" "false"
    iniSet "menu_show_overlays" "false"
    iniSet "menu_show_quit_retroarch" "true"
    iniSet "menu_show_reboot" "false"
    iniSet "menu_show_restart_retroarch" "false"
    iniSet "menu_show_rewind" "false"
    iniSet "menu_show_shutdown" "true"
    iniSet "menu_show_sublabels" "true"
    iniSet "menu_swap_ok_cancel_buttons" "$es_swap"
    iniSet "menu_throttle_framerate" "true"
    iniSet "menu_thumbnails" "3"
    iniSet "menu_timedate_enable" "true"
    iniSet "menu_timedate_style" "1"
    iniSet "menu_title_color" "ff64ff64"
    iniSet "menu_unified_controls" "true"
    iniSet "menu_use_preferred_system_color_theme" "false"
    iniSet "menu_wallpaper" ""
    iniSet "menu_wallpaper_opacity" "0.500000"
    iniSet "ozone_menu_color_theme" "1"
    iniSet "quick_menu_show_add_to_favorites" "false"
    iniSet "quick_menu_show_cheats" "true"
    iniSet "quick_menu_show_close_content" "true"
    iniSet "quick_menu_show_controls" "true"
    iniSet "quick_menu_show_download_thumbnails" "false"
    iniSet "quick_menu_show_information" "false"
    iniSet "quick_menu_show_options" "true"
    iniSet "quick_menu_show_recording" "false"
    iniSet "quick_menu_show_reset_core_association" "false"
    iniSet "quick_menu_show_restart_content" "true"
    iniSet "quick_menu_show_resume_content" "true"
    iniSet "quick_menu_show_save_content_dir_overrides" "true"
    iniSet "quick_menu_show_save_core_overrides" "true"
    iniSet "quick_menu_show_save_game_overrides" "true"
    iniSet "quick_menu_show_save_load_state" "true"
    iniSet "quick_menu_show_set_core_association" "false"
    iniSet "quick_menu_show_shaders" "true"
    iniSet "quick_menu_show_start_recording" "false"
    iniSet "quick_menu_show_start_streaming" "false"
    iniSet "quick_menu_show_streaming" "false"
    iniSet "quick_menu_show_take_screenshot" "false"
    iniSet "quick_menu_show_undo_save_load_state" "false"
    iniSet "quit_press_twice" "false"
    iniSet "rgui_aspect_ratio" "2"
    iniSet "rgui_aspect_ratio_lock" "1"
    iniSet "rgui_background_filler_thickness_enable" "true"
    iniSet "rgui_border_filler_enable" "false"
    iniSet "rgui_border_filler_thickness_enable" "false"
    iniSet "rgui_browser_directory" "$romdir"
    iniSet "rgui_config_directory" "~/.config/retroarch/config"
    iniSet "rgui_extended_ascii" "false"
    iniSet "rgui_inline_thumbnails" "false"
    iniSet "rgui_internal_upscale_level" "0"
    iniSet "rgui_menu_color_theme" "20"
    iniSet "rgui_menu_theme_preset" ""
    iniSet "rgui_particle_effect" "5"
    iniSet "rgui_show_start_screen" "false"
    iniSet "rgui_swap_thumbnails" "false"
    iniSet "rgui_thumbnail_delay" "0"
    iniSet "rgui_thumbnail_downscaler" "0"
    iniSet "settings_show_achievements" "true"
    iniSet "settings_show_ai_service" "true"
    iniSet "settings_show_audio" "true"
    iniSet "settings_show_configuration" "true"
    iniSet "settings_show_core" "true"
    iniSet "settings_show_directory" "true"
    iniSet "settings_show_drivers" "true"
    iniSet "settings_show_frame_throttle" "true"
    iniSet "settings_show_input" "true"
    iniSet "settings_show_latency" "true"
    iniSet "settings_show_logging" "true"
    iniSet "settings_show_network" "true"
    iniSet "settings_show_onscreen_display" "true"
    iniSet "settings_show_playlists" "false"
    iniSet "settings_show_power_management" "false"
    iniSet "settings_show_recording" "true"
    iniSet "settings_show_saving" "true"
    iniSet "settings_show_user" "true"
    iniSet "settings_show_user_interface" "true"
    iniSet "settings_show_video" "true"
    iniSet "video_font_enable" "true"
    iniSet "video_font_path" ""
    iniSet "video_font_size" "20.000000"
    iniSet "video_message_color" "33ff00"
    iniSet "video_message_pos_x" "0.050000"
    iniSet "video_message_pos_y" "0.050000"
    iniSet "video_msg_bgcolor_blue" "0"
    iniSet "video_msg_bgcolor_enable" "false"
    iniSet "video_msg_bgcolor_green" "0"
    iniSet "video_msg_bgcolor_opacity" "1.000000"
    iniSet "video_msg_bgcolor_red" "0"
   
    copyDefaultConfig "$config" "$configdir/all/retroarch.cfg"
    rm "$config"

    # force settings on existing configs
    _init_config_option_retroarch "menu_driver" "ozone"
    _init_config_option_retroarch "menu_unified_controls" "true"
    _init_config_option_retroarch "quit_press_twice" "false"
    _init_config_option_retroarch "video_shader_enable" "true"

    # remapping hack for old 8bitdo firmware
    addAutoConf "8bitdo_hack" 0
}

function keyboard_retroarch() {
    if [[ ! -f "$configdir/all/retroarch.cfg" ]]; then
        printMsgs "dialog" "No RetroArch configuration file found at $configdir/all/retroarch.cfg"
        return
    fi
    local input
    local options
    local i=1
    local key=()
    while read input; do
        local parts=($input)
        key+=("${parts[0]}")
        options+=("${parts[0]}" $i 2 "${parts[*]:2}" $i 26 16 0)
        ((i++))
    done < <(grep "^[[:space:]]*input_player[0-9]_[a-z]*" "$configdir/all/retroarch.cfg")
    local cmd=(dialog --backtitle "$__backtitle" --form "RetroArch keyboard configuration" 22 48 16)
    local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
    if [[ -n "$choice" ]]; then
        local value
        local values
        readarray -t values <<<"$choice"
        iniConfig " = " "" "$configdir/all/retroarch.cfg"
        i=0
        for value in "${values[@]}"; do
            iniSet "${key[$i]}" "$value" >/dev/null
            ((i++))
        done
    fi
}

function hotkey_retroarch() {
    iniConfig " = " '"' "$configdir/all/retroarch.cfg"
    local cmd=(dialog --backtitle "$__backtitle" --menu "Choose the desired hotkey behaviour." 22 76 16)
    local options=(1 "Hotkeys enabled. (default)"
             2 "Press ALT to enable hotkeys."
             3 "Hotkeys disabled. Press ESCAPE to open RGUI.")
    local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
    if [[ -n "$choice" ]]; then
        case "$choice" in
            1)
                iniSet "input_enable_hotkey" "nul"
                iniSet "input_exit_emulator" "escape"
                iniSet "input_menu_toggle" "F1"
                ;;
            2)
                iniSet "input_enable_hotkey" "alt"
                iniSet "input_exit_emulator" "escape"
                iniSet "input_menu_toggle" "F1"
                ;;
            3)
                iniSet "input_enable_hotkey" "escape"
                iniSet "input_exit_emulator" "nul"
                iniSet "input_menu_toggle" "escape"
                ;;
        esac
    fi
}

function config_retroarch() {
    cp "$scriptdir/configs/all/retroarch.cfg" "$md_conf_root/all"
    cp "$scriptdir/configs/all/retroarch.cfg.bak" "$md_conf_root/all"
    cp "$scriptdir/configs/all/retroarch-core-options.cfg" "$md_conf_root/all"
}

function gui_retroarch() {
    while true; do
        local names=(assets cheats overlays shaders)
        local dirs=(assets cheats overlays shaders)
        local options=()
        local name
        local dir
        local i=1
        for name in "${names[@]}"; do
            if [[ -d "$configdir/all/retroarch/${dirs[i-1]}/.git" ]]; then
                options+=("$i" "Manage $name (installed)")
            else
                options+=("$i" "Manage $name (not installed)")
            fi
            ((i++))
        done
        options+=(
            5 "Configure keyboard for use with RetroArch"
            6 "Configure keyboard hotkey behaviour for RetroArch"
            7 "Reset retroarch and retroarch-core-option configs"
        )
        local cmd=(dialog --backtitle "$__backtitle" --menu "Choose an option" 22 76 16)
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        case "$choice" in
            1|2|3|4)
                name="${names[choice-1]}"
                dir="${dirs[choice-1]}"
                options=(1 "Install/Update $name" 2 "Uninstall $name" )
                cmd=(dialog --backtitle "$__backtitle" --menu "Choose an option for $dir" 12 40 06)
                choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)

                case "$choice" in
                    1)
                        "update_${name}_retroarch"
                        ;;
                    2)
                        rm -rf "$configdir/all/retroarch/$dir"
                        ;;
                    *)
                        continue
                        ;;

                esac
                ;;
            5)
                keyboard_retroarch
                ;;
            6)
                hotkey_retroarch
                ;;
            7)
                config_retroarch
                printMsgs "dialog" "Completed the reset of retroarch and retroarch-core-options configs."
                ;;
            *)
                break
                ;;
        esac

    done
}

function _set_config_option_retroarch() {
    local option="$1"
    local value="$2"
    iniConfig " = " "\"" "$configdir/all/retroarch.cfg"
    iniGet "$option"
    if [[ -z "$ini_value" ]]; then
        iniSet "$option" "$value"
    fi
	
	

}
