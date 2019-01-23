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
        'bezelprojectlaunch'
        'bgmtoggle'
        'bluetooth'
        'caseconfig'
        'casetheme'
        'configedit'
        'controlreset'
        'esthemes'
        'fancontrol'
        'hurstythemes'
        'filemanager'
        'odroidconfig'
        'retroarch'
        'rpsetup'
        'runcommand'
        'showip'
        'smartkiosk'
        'softreboot'
        'splashscreen'
        'systeminfo'
        'wifi'
    )

    local names=(
        'Display: Bezel Project'
        'System: BGM Toggle'
        'System: Bluetooth'
        'Display: Case Config for OGST'
        'Display: Case Themes for OGST'
        'General: Configuration Editor'
        'System: Controller Reset'
        'Display: ES Themes'
        'System: Fan Control'
        'Display: HurstyS ES Themes'
        'System: File Manager'
        'System: Odroid-Config'
        'General: Retroarch'
        'General: RetroArena-Setup'
        'System: Run Command Configuration'
        'System: Show IP'
        'System: Smart Kiosk'
        'System: Soft Reboot'
        'Display: Splash Screens'
        'System: System Info Utility'
        'System: Wi-Fi'
    )
    
    local descs=(
        'Downloader for RetroArach system bezel packs to be used for various systems'
        'Enable or disable the background music feature.'
        'Register and connect to bluetooth devices. Unregister and remove devices, and display registered and connected devices.'
        'Case image selector for OGST - choose the type of image displayed upon game launch such as console system, boxart, cartart, snap, wheel, screenshot, or marquee.'
        'Case theme selector for OGST - choose different theme packs when Console System is selected in Case Config.'
        'Change common RetroArch options, and manually edit RetroArch configs, global configs, and non-RetroArch configs.'
        'Reset controller configurations to factory default.
        
NOTE: This will cause your system to REBOOT.'
        'Install, uninstall, or update EmulationStation themes.'
        'Change the fan settings to control cooling and fan noise.'
        'Install, uninstall, or update HurstyS ES themes.'
        'Basic ascii file manager for linux allowing you to browse, copy, delete, and move files.
        
NOTE: Requires a keyboard to be connected.'
        'Expand filesystem, configure network, boot, localisation, SSH, etc.
        
NOTE: This menu is EXPERIMENTAL. Use at your own risk and be sure to backup your image!'
        'Launches the RetroArch GUI so you can change RetroArch options.
        
NOTE: Changes will not be saved unless you have enabled the "Save Configuration On Exit" option.'
        'Update Setup Script, install/uninstall Libretro and standalone emulators, ports, drivers, scrapers, and configurations.'
        'Change what appears on the runcommand screen. Enable or disable the menu, enable or disable box art, and change CPU configuration.'
        'Displays your current IP address, as well as other information provided by the command, "ip addr show."'
        'Enables Kiosk mode for RetroArch and EmulationStation. It also disables the Launch Menu. Choose to enable or disable in one setting.
        
NOTE: This will cause your system to REBOOT.'
        'Perform a soft reboot to recover local keyboard function if not functional.
        
NOTE: Typically only needed after exit from PSP games and there is a need to access the terminal by exit from EmulationStation.'
        'Enable or disable the splashscreen on boot. Choose a splashscreen, download new splashscreens, and return splashscreen to default.'
        'View your CPU temps, IP connectivity, and storage to include external storage addons.'
        'Connect to a wireless network.
        
NOTE: Requires a keyboard to be connected.'
    )
    
    local hiddens=(
        'true'
        'false'
        'true'
        'true'
        'true'
        'true'
        'true'
        'true'
        'true'
        'true'
        'true'
        'true'
        'true'
        'true'
        'true'
        'true'
        'false'
        'true'
        'true'
        'true'
        'true'
    )

    setESSystem "RetroArena" "retroarena" "$rpdir" ".rp .sh" "sudo $scriptdir/retroarena_packages.sh settingsmenu launch %ROM% </dev/tty >/dev/tty" "" "retroarena"

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
            su $user -c "\"$emudir/retroarch/bin/retroarch\" --menu --config \"$configdir/all/retroarch.cfg\""
            iniConfig " = " '"' "$configdir/all/retroarch.cfg"
            iniSet "config_save_on_exit" "false"
            ;;
        rpsetup.rp)
            rp_callModule setup gui
            ;;
        odroidconfig.rp)
            odroid-config
            ;;
        filemanager.rp)
            mc
            ;;
        showip.rp)
            local ip="$(ip route get 8.8.8.8 2>/dev/null | awk '{print $NF; exit}')"
            printMsgs "dialog" "Your IP is: $ip\n\nOutput of 'ip addr show':\n\n$(ip addr show)"
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
