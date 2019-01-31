#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="launchingvideos"
rp_module_desc="Install Launching Video Packs"
rp_module_section="config"

function install_theme_launchingvideos() {
    local theme="$1"
    local repo="$2"
    if [[ -z "$repo" ]]; then
        repo="Retro-Arena"
    fi
    if [[ -z "$theme" ]]; then
        theme="retroarena"
        repo="Retro-Arena"
    fi
    gitPullOrClone "$datadir/launchingvideos-$theme" "https://github.com/$repo/launchvids-$theme.git"
    rm -rf "$datadir/launchingvideos"
    ln -sf "$datadir/launchingvideos-$theme" "$datadir/launchingvideos"
    chown -R $user:$user "$datadir/launchingvideos-$theme"
    chown -R $user:$user "$datadir/launchingvideos"
    
    # enable on install
    touch "$home/.config/launchingvideos"
}

function uninstall_theme_launchingvideos() {
    local theme="$1"
    if [[ -d "$datadir/launchingvideos-$theme" ]]; then
        rm -rf "$datadir/launchingvideos-$theme"
        rm -rf "$datadir/launchingvideos"
    fi

    # disable when all themes are uninstalled
    if ! ls $datadir/launchingvideos-* 1> /dev/null 2>&1; then
        rm -rf "$home/.config/launchingvideos"
    fi
}

function gui_launchingvideos() {
    local themes=(
        'Retro-Arena retroarena'
        'Retro-Arena supersimple'
    )
    while true; do
        local theme
        local installed_themes=()
        local repo
        local options=()
        local status=()
        local default

        status+=("n")
        options+=(E "Enable Launching Videos (default)")
        options+=(D "Disable Launching Videos")

        local i=1
        for theme in "${themes[@]}"; do
            theme=($theme)
            repo="${theme[0]}"
            theme="${theme[1]}"
            if [[ -d "$datadir/launchingvideos-$theme" ]]; then
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
            E)
                touch "$home/.config/launchingvideos"
                printMsgs "dialog" "Enabled Launching Videos\n\nThis also disabled Launching Images."
                ;;
            D)
                rm -rf "$home/.config/launchingvideos"
                printMsgs "dialog" "Disabled Launching Videos\n\nThis also enabled Launching Images."
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
                            rp_callModule launchingvideos install_theme "$theme" "$repo"
                            ;;
                        2)
                            rp_callModule launchingvideos uninstall_theme "$theme"
                            ;;
                    esac
                else
                    rp_callModule launchingvideos install_theme "$theme" "$repo"
                fi
                ;;
        esac
    done
}
