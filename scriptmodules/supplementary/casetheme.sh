#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="casetheme"
rp_module_desc="Install themes for OGST display"
rp_module_section="config"

function depends_casetheme() {
    if isPlatform "x11"; then
        getDepends feh
    else
        getDepends fbi
    fi
}

function install_theme_casetheme() {
    local theme="$1"
    local repo="$2"
    if [[ -z "$repo" ]]; then
        repo="Retro-Arena"
    fi
    if [[ -z "$theme" ]]; then
        theme="retroarena"
        repo="Retro-Arena"
    fi
    mkdir -p "$datadir/casetheme"
    gitPullOrClone "$datadir/$theme" "https://github.com/$repo/ogst-$theme.git"
    rm -rf "$datadir/casetheme"
    mv "$datadir/$theme" "/$datadir/casetheme"
    rm -rf "$datadir/casetheme/.git"
    rm -rf "$datadir/casetheme/.gitattributes"
    chown -R $user:$user "$datadir/casetheme"
}

function gui_casetheme() {
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
        local i=1
        for theme in "${themes[@]}"; do
            theme=($theme)
            repo="${theme[0]}"
            theme="${theme[1]}"
            status+=("n")
            options+=("$i" "Install $repo/$theme")
            ((i++))
        done
        local cmd=(dialog --default-item "$default" --backtitle "$__backtitle" --menu "Choose an option" 22 76 16)
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        default="$choice"
        [[ -z "$choice" ]] && break
        case "$choice" in
            *)
                theme=(${themes[choice-1]})
                repo="${theme[0]}"
                theme="${theme[1]}"
                if [[ ! "${status[choice]}" == "i" ]]; then
                    rp_callModule casetheme install_theme "$theme" "$repo"
                    printMsgs "dialog" "$repo/$theme case theme installed"
                fi
                ;;
        esac
    done
}
