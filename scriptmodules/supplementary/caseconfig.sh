#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="caseconfig"
rp_module_desc="Install themes for OGST display and case image selector."
rp_module_section="config"
rp_module_flags="!rockpro64 !odroid-n2"

function off_caseconfig() {
    if lsmod | grep -q 'fbtft_device'; then
        sudo rmmod fbtft_device &> /dev/null
    fi
    rm -rf $home/.config/ogst*
    rm -rf "/usr/local/share/ogst/ogst000"
}

function es_caseconfig() {
    if lsmod | grep -q 'fbtft_device'; then
        mplayer -quiet -nolirc -nosound -vo fbdev2:/dev/fb1 -vf scale=320:240 "$datadir/casetheme/es.png" &> /dev/null
    else
        sudo modprobe fbtft_device name=hktft9340 busnum=1 rotate=270 &> /dev/null
        mplayer -quiet -nolirc -nosound -vo fbdev2:/dev/fb1 -vf scale=320:240 "$datadir/casetheme/es.png" &> /dev/null
    fi
    rm -rf $home/.config/ogst*
    touch "/usr/local/share/ogst/ogst000"
}

function selector_caseconfig() {
    while true; do
        local cmd=(dialog --backtitle "$__backtitle" --menu "Choose an option" 22 86 16)
        local options=(
            1 "Console System         retroarena theme (default)"
            2 "Motion Blue Boxart     roms/SYSTEM/boxart/ROM.png"
            3 "Motion Blue Cartart    roms/SYSTEM/cartart/ROM.png"
            4 "Motion Blue Snap       roms/SYSTEM/snap/ROM.png"
            5 "Motion Blue Wheel      roms/SYSTEM/wheel/ROM.png"
            6 "Skyscraper Marquee     roms/SYSTEM/media/marquees/ROM.png"
            7 "Skyscraper Screenshot  roms/SYSTEM/media/screenshots/ROM.png"
            8 "Skraper Marquee        roms/SYSTEM/media/marquee/ROM.png"
            9 "Skraper Screenshot     roms/SYSTEM/media/images/ROM.png"
            10 "Selph's Marquee        roms/SYSTEM/images/ROM-marquee.png"
            11 "Selph's Screenshot     roms/SYSTEM/images/ROM-image.jpg"
            12 "Disable Display        turns off the screen"
        )
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        [[ -z "$choice" ]] && break
        if [[ -n "$choice" ]]; then
            [[ -d /usr/local/share/ogst ]] || mkdir /usr/local/share/ogst
            case "$choice" in
                1)
                    es_caseconfig
                    touch "$home/.config/ogst001"
                    printMsgs "dialog" "Enabled Console System\n\nCase image will load from:\n\n$datadir/casetheme/system-SYSTEM.png"
                    ;;
                2)
                    es_caseconfig
                    touch "$home/.config/ogst002"
                    printMsgs "dialog" "Enabled Motion Blue Boxart\n\nCase image will load from:\n\n$datadir/roms/SYSTEM/boxart/ROM.png"
                    ;;
                3)
                    es_caseconfig
                    touch "$home/.config/ogst003"
                    printMsgs "dialog" "Enabled Motion Blue Cartart\n\nCase image will load from:\n\n$datadir/roms/SYSTEM/cartart/ROM.png"
                    ;;
                4)
                    es_caseconfig
                    touch "$home/.config/ogst004"
                    printMsgs "dialog" "Enabled Motion Blue Snap\n\nCase image will load from:\n\n$datadir/roms/SYSTEM/snap/ROM.png"
                    ;;
                5)
                    es_caseconfig
                    touch "$home/.config/ogst005"
                    printMsgs "dialog" "Enabled Motion Blue Wheel\n\nCase image will load from:\n\n$datadir/roms/SYSTEM/wheel/ROM.png"
                    ;;
                6)
                    es_caseconfig
                    touch "$home/.config/ogst006"
                    printMsgs "dialog" "Enabled Skyscraper Marquee\n\nCase image will load from:\n\n$datadir/roms/SYSTEM/media/marquees/ROM.png"
                    ;;
                7)
                    es_caseconfig
                    touch "$home/.config/ogst007"
                    printMsgs "dialog" "Enabled Skyscraper Screenshot\n\nCase image will load from:\n\n$datadir/roms/SYSTEM/media/screenshots/ROM.png"
                    ;;
                8)
                    es_caseconfig
                    touch "$home/.config/ogst008"
                    printMsgs "dialog" "Enabled Skraper Marquee\n\nCase image will load from:\n\n$datadir/roms/SYSTEM/media/marquee/ROM.png"
                    ;;
                9)
                    es_caseconfig
                    touch "$home/.config/ogst009"
                    printMsgs "dialog" "Enabled Skraper Screenshot\n\nCase image will load from:\n\n$datadir/roms/SYSTEM/media/images/ROM.png"
                    ;;
                10)
                    es_caseconfig
                    touch "$home/.config/ogst010"
                    printMsgs "dialog" "Enabled Selph's Marquee\n\nCase image will load from:\n\n$datadir/roms/SYSTEM/images/ROM-marquee.png"
                    ;;
                11)
                    es_caseconfig
                    touch "$home/.config/ogst011"
                    printMsgs "dialog" "Enabled Selph's Screenshot\n\nCase image will load from:\n\n$datadir/roms/SYSTEM/images/ROM-image.jpg"
                    ;;
                12)
                    off_caseconfig
                    printMsgs "dialog" "The display is now disabled, including subsequent reboots.\n\nTo re-enable the display, select another option."
                    ;;
            esac
        fi
    done
}

function install_theme_caseconfig() {
    local theme="$1"
    local repo="$2"
    if [[ -z "$repo" ]]; then
        repo="Retro-Arena"
    fi
    if [[ -z "$theme" ]]; then
        theme="retroarena"
        repo="Retro-Arena"
    fi
    gitPullOrClone "$datadir/casetheme-$theme" "https://github.com/$repo/ogst-$theme.git"
    rm -rf "$datadir/casetheme"
    ln -sf "$datadir/casetheme-$theme" "$datadir/casetheme"
    chown -R $user:$user "$datadir/casetheme-$theme"
    chown -R $user:$user "$datadir/casetheme"
    
    # enable on install
    es_caseconfig
    touch "$home/.config/ogst001"
}

function uninstall_theme_caseconfig() {
    local theme="$1"
    if [[ -d "$datadir/casetheme-$theme" ]]; then
        rm -rf "$datadir/casetheme-$theme"
        rm -rf "$datadir/casetheme"
    fi
    
    # disable when all themes are uninstalled
    if ! ls $datadir/casetheme-* 1> /dev/null 2>&1; then
        off_caseconfig
    fi
}

function gui_caseconfig() {
    local themes=(
        'Retro-Arena retroarena'
        'Retro-Arena greatest-hits'
        'Retro-Arena wiitro-arena'
        'Retro-Arena hursty'
    )
    while true; do
        local theme
        local installed_themes=()
        local repo
        local options=()
        local status=()
        local default

        status+=("n")
        options+=(C "Case Image Selector")

        local i=1
        for theme in "${themes[@]}"; do
            theme=($theme)
            repo="${theme[0]}"
            theme="${theme[1]}"
            if [[ -d "$datadir/casetheme-$theme" ]]; then
                status+=("i")
                options+=("$i" "Update or Uninstall $repo/$theme (installed)")
                installed_themes+=("$theme $repo")
            else
                status+=("n")
                options+=("$i" "Install $repo/$theme (not installed)")
            fi
            ((i++))
        done
        local cmd=(dialog --default-item "$default" --backtitle "$__backtitle" --menu "Choose an option" 22 76 16)
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        default="$choice"
        [[ -z "$choice" ]] && break
        case "$choice" in
            C)
                selector_caseconfig
                ;;
            *)
                theme=(${themes[choice-1]})
                repo="${theme[0]}"
                theme="${theme[1]}"
                if [[ "${status[choice]}" == "i" ]]; then
                    options=(1 "Update $repo/$theme" 2 "Uninstall $repo/$theme")
                    cmd=(dialog --backtitle "$__backtitle" --menu "Choose an option for theme" 12 40 06)
                    local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
                    case "$choice" in
                        1)
                            rp_callModule caseconfig install_theme "$theme" "$repo"
                            ;;
                        2)
                            rp_callModule caseconfig uninstall_theme "$theme"
                            ;;
                    esac
                else
                    rp_callModule caseconfig install_theme "$theme" "$repo"
                fi
                ;;
        esac
    done
}
