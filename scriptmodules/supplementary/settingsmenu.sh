#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="settingsmenu"
rp_module_desc="Settings Menu for EmulationStation"
rp_module_section="core"
rp_module_flags=""

function _update_hook_settingsmenu() {
    # to show as installed when upgrading to retroarena-setup 4.x
    if ! rp_isInstalled "$md_idx" && [[ -f "$configdir/all/emulationstation/gamelists/retroarena/gamelist.xml" ]]; then
        mkdir -p "$md_inst"
        # to stop older scripts removing when launching from retroarena menu in ES due to not using exec or exiting after running retroarena-setup from this module
        touch "$md_inst/.retroarena"
    fi
}

function depends_settingsmenu() {
    getDepends mc
}

function install_bin_settingsmenu() {
    wget -O /usr/bin/odroid-config https://raw.githubusercontent.com/sikotik/odroid-config/master/odroid-config &> /dev/null
    wget -O /usr/bin/init_resize.sh https://raw.githubusercontent.com/sikotik/odroid-config/master/init_resize.sh &> /dev/null
    chmod a+x /usr/bin/init_resize.sh
    chmod a+x /usr/bin/odroid-config
    return
}

function configure_settingsmenu()
{
    [[ "$md_mode" == "remove" ]] && return

    local rpdir="$datadir/settingsmenu"
    mkdir -p "$rpdir"
    cp -r "$md_data/icons" "$rpdir/"
    chown -R $user:$user "$rpdir"

    isPlatform "mali" && rm -f "$rpdir/dispmanx.rp"
    
    # add the gameslist / icons
    local files=(
        "audioswitch"
        "bezelproject"
        "bgmtoggle"
        "bluetooth"
        "configedit"
        "controlreset"
        "escollections"
        "esgamelist"
        "esthemes"
        "filemanager"
        "hurstythemes"
        "launchingvideos"
        "removemedia"
        "retroarch"
        "rpsetup"
        "runcommand"
        "showip"
        "smartkiosk"
        "softreboot"
        "splashscreen"
        "systeminfo"
        "wifi"
    )

    local names=(
        "Sound: Audio Switch"
        "Media: Bezel Project"
        "Sound: BGM Toggle"
        "Network: Bluetooth"
        "System: Configuration Editor"
        "System: Controller Reset"
        "Media: ES Collection List Generator"
        "Media: ES Gamelist Cleanup"
        "Media: ES Themes"
        "System: File Manager"
        "Media: Hursty's ES Themes"
        "Media: Launching Videos"
        "Media: Remove Media"
        "System: Retroarch"
        "System: RetroArena-Setup"
        "System: Runcommand Config"
        "Network: Show IP"
        "System: Smart Kiosk"
        "System: Soft Reboot"
        "Media: Splash Screens"
        "System: System Info Utility"
        "Network: Wi-Fi"
    )
    
    local descs=(
        "Switch between HDMI and USB Audio."
        "Downloader for RetroArach system bezel packs to be used for various systems"
        "Enable or disable the background music feature."
        "Register and connect to bluetooth devices. Unregister and remove devices, and display registered and connected devices."
        "Change common RetroArch options, and manually edit RetroArch configs, global configs, and non-RetroArch configs."
        "Reset controller configurations to factory default.
        
NOTE: This will cause your system to REBOOT."
        "Add or update the custom collection gamelist that will be used to show games in the custom collections menu items.

NOTE: This utility only works with rom files using the No-Intro naming convention like Emumovies or Hyperspin."
        "Perform a cleanup in your EmulationStation 'gamelist.xml' file. The cleanup utility will only work on 'gamelist.xml' files located within the roms folder also.

NOTE: Always make a backup copy of your 'gamelist.xml' and media files before making changes to your system."
        "Install, uninstall, or update EmulationStation themes."
        "Basic ascii file manager for linux allowing you to browse, copy, delete, and move files.
        
NOTE: Requires a keyboard to be connected."
        "Install, uninstall, or update Hursty's ES themes. Also, enable or disable the Theme Randomizer on boot option."
        "Enable, disable, or update Launching Videos, which plays a video instead of an image during game launch."
        "Remove extra media files (boxart, cartart, snap, and wheel) for a chosen system where there is not a matching game for it. If you keep your media for MAME or Final Burn Alpha in the 'roms/arcade' folder, there is a special choice just for that.

NOTE: Always make a backup copy of your SD card and your roms and media files before making changes to your system."
        "Launches the RetroArch GUI so you can change RetroArch options.
        
NOTE: Changes will not be saved unless you have enabled the 'Save Configuration On Exit' option."
        "Update Setup Script, install/uninstall Libretro and standalone emulators, ports, drivers, scrapers, and configurations."
        "Change what appears on the runcommand screen. Enable or disable the menu, enable or disable box art, and change CPU configuration."
        "Displays your current IP address, as well as other information provided by the command, 'ip addr show.'"
        "Enables Kiosk mode for RetroArch and EmulationStation. It also disables the Launch Menu. Choose to enable or disable in one setting.
        
NOTE: This will cause your system to REBOOT."
        "Perform a soft reboot to recover local keyboard function if not functional.
        
NOTE: Typically only needed after exit from PSP games and there is a need to access the terminal by exit from EmulationStation."
        "Enable or disable the splashscreen on boot. Choose a splashscreen, download new splashscreens, and return splashscreen to default."
        "View your CPU temps, IP connectivity, and storage to include external storage addons."
        "Connect to a wireless network.
        
NOTE: Requires a keyboard to be connected."
    )
    
    local hiddens=(
        "true"
        "true"
        "false"
        "true"
        "true"
        "true"
        "true"
        "true"
        "true"
        "true"
        "true"
        "true"
        "true"
        "true"
        "true"
        "true"
        "true"
        "false"
        "true"
        "true"
        "true"
        "true"
    )
    
    if isPlatform "odroid-xu"; then
        files+=(
            "caseconfig"
            "fancontrol"
            "fruitbox"
            "odroidconfig"
        )
        
        names+=(
            "Media: Case Config for OGST"
            "System: Fan Control"
            "Media: Jukebox Config"
            "System: Odroid-Config"
        )
        
        descs+=(
            "Install themes for the OGST Case when 'Console System' is selected. In addition, upon game launch, choose different types of scraped images displayed such as boxart, cartart, snap, wheel, screenshot, marquee, or console system (default). There is also an option to completely disable the display."
            "Change the fan settings to control cooling and fan noise."
            "Configure the default skin and gamepad for Fruitbox jukebox."
            "Expand filesystem, configure network, boot, localisation, SSH, etc.
            
NOTE: This menu is EXPERIMENTAL. Use at your own risk and be sure to backup your image!"
        )
        
        hiddens+=(
            "true"
            "true"
            "true"
            "true"
        )
    fi
    
    if isPlatform "odroid-n2"; then
        files+=(
            "odroidconfig"
        )
        
        names+=(
            "System: Odroid-Config"
        )
        
        descs+=(
            "Set the display resolution to 720p or 1080p. And the ability to expand the filesystem."
        )
        
        hiddens+=(
            "true"
        )
    fi

    setESSystem "RetroArena" "retroarena" "$rpdir" ".rp .sh" "sudo $scriptdir/retroarena_packages.sh settingsmenu launch %ROM% </dev/tty >/dev/tty && clear" "" "retroarena"

    local file
    local name
    local desc
    local image
    local hidden
    local i
    for i in "${!files[@]}"; do
        case "${files[i]}" in
            raspiconfig|splashscreen)
                ! isPlatform "mali" && continue
                ;;
            wifi)
                [[ "$__os_id" != "Ubuntu" ]] && continue
        esac

        file="${files[i]}"
        name="${names[i]}"
        desc="${descs[i]}"
        image="$datadir/settingsmenu/icons/${files[i]}.png"
        hidden="${hiddens[i]}"

        touch "$rpdir/$file.rp"

        local function
        for function in $(compgen -A function _add_rom_); do
            "$function" "retroarena" "RetroArena" "$file.rp" "$name" "$desc" "$image" "$hidden"
        done
    done
}

function remove_settingsmenu() {
    rm -rf "$datadir/settingsmenu"
    rm -rf "$configdir/all/emulationstation/gamelists/retroarena"
    delSystem retroarena
}

function launch_settingsmenu() {
    clear
    local command="$1"
    local basename="${command##*/}"
    local no_ext="${basename%.rp}"
    joy2keyStart
    case "$basename" in
        retroarch.rp)
            joy2keyStop
            cp "$configdir/all/retroarch.cfg" "$configdir/all/retroarch.cfg.bak"
            chown $user:$user "$configdir/all/retroarch.cfg.bak"
            su $user -c "\"$emudir/retroarch/bin/retroarch\" --menu --config \"$configdir/all/retroarch.cfg\"" && sudo bash -c 'echo 0 > /sys/class/graphics/fbcon/cursor_blink'
            iniConfig " = " '"' "$configdir/all/retroarch.cfg"
            iniSet "config_save_on_exit" "false"
            ;;
        rpsetup.rp)
            rp_callModule setup gui
            ;;
        odroidconfig.rp)
            rp_callModule odroidconfig gui
            ;;
        filemanager.rp)
            mc
            ;;
        showip.rp)
            local ip="$(getIPAddress)"
            printMsgs "dialog" "Your IP is: ${ip:-(unknown)}\n\nOutput of 'ip addr show':\n\n$(ip addr show)"
            ;;
        *.rp)
            rp_callModule $no_ext depends
            if fnExists gui_$no_ext; then
                rp_callModule $no_ext gui
            else
                rp_callModule $no_ext configure
            fi
            ;;
        *.sh)
            cd "$datadir/settingsmenu"
            sudo -u "$user" bash "$command"
            ;;
    esac
    joy2keyStop
    clear
}

function gui_settingsmenu() {
    while true; do
        local options=(
            1 "Install default icon set"
            2 "Install cart style 1 icon set"
            3 "Install cart style 2 icon set"
        )
        local cmd=(dialog --default-item "$default" --backtitle "$__backtitle" --menu "Choose an option" 22 76 16)
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        default="$choice"
        [[ -z "$choice" ]] && break
        case "$choice" in
            1)
                rm -rf "$datadir/settingsmenu/icons"
                cp -r "$scriptdir/scriptmodules/supplementary/settingsmenu/icons" "$datadir/settingsmenu/icons"
                chown -R $user:$user "$datadir/settingsmenu/icons"
                printMsgs "dialog" "Settings menu default icons installed\n\nRestart EmulationStation to apply."
                ;;
            2)
                rm -rf "$datadir/settingsmenu/icons"
                cp -r "$scriptdir/scriptmodules/supplementary/settingsmenu/icons_cart" "$datadir/settingsmenu/icons"
                chown -R $user:$user "$datadir/settingsmenu/icons"
                printMsgs "dialog" "Settings menu cart style 1 icons installed.\n\nRestart EmulationStation to apply."
                ;;
            3)
                rm -rf "$datadir/settingsmenu/icons"
                cp -r "$scriptdir/scriptmodules/supplementary/settingsmenu/icons_cart2" "$datadir/settingsmenu/icons"
                chown -R $user:$user "$datadir/settingsmenu/icons"
                printMsgs "dialog" "Settings menu cart style 2 icons installed.\n\nRestart EmulationStation to apply."
                ;;
        esac
    done
}
