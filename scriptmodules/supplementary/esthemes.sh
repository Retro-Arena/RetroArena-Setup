#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="esthemes"
rp_module_desc="Install themes for EmulationStation"
rp_module_section="config"

function depends_esthemes() {
    if isPlatform "x11"; then
        getDepends feh
    else
        getDepends fbi
    fi
}

function install_theme_esthemes() {
    local theme="$1"
    local repo="$2"
    if [[ -z "$repo" ]]; then
        repo="Retro-Arena"
    fi
    if [[ -z "$theme" ]]; then
        theme="ghc"
        repo="Retro-Arena"
    fi
    mkdir -p "/etc/emulationstation/themes"
    gitPullOrClone "/etc/emulationstation/themes/$theme" "https://github.com/$repo/es-theme-$theme.git"
}

function uninstall_theme_esthemes() {
    local theme="$1"
    if [[ -d "/etc/emulationstation/themes/$theme" ]]; then
        rm -rf "/etc/emulationstation/themes/$theme"
    fi
}

function gui_esthemes() {
    local themes=(
        'Retro-Arena ghc'
        'Retro-Arena greatest-hits'
        'Retro-Arena greatest-hits-vertical'
        'Retro-Arena megaman'
        'Retro-Arena retroarena'
        'Retro-Arena rick-and-morty'
        'Retro-Arena showcase'
        'Retro-Arena unified'
        'Retro-Arena wiitro-arena'
        'ehettervik pixel'
        'ehettervik pixel-metadata'
        'ehettervik pixel-tft'
        'ehettervik luminous'
        'ehettervik minilumi'
        'ehettervik workbench'
        'AmadhiX eudora'
        'AmadhiX eudora-bigshot'
        'AmadhiX eudora-concise'
        'InsecureSpike retroplay-clean-canela'
        'InsecureSpike retroplay-clean-detail-canela'
        'Omnija simpler-turtlepi'
        'Omnija simpler-turtlemini'
        'Omnija metro'
        'lilbud material'
        'mattrixk io'
        'mattrixk metapixel'
        'mattrixk spare'
        'robertybob space'
        'robertybob simplebigart'
        'robertybob tv'
        'HerbFargus tronkyfran'
        'lilbud flat'
        'lilbud flat-dark'
        'lilbud minimal'
        'lilbud switch'
        'FlyingTomahawk futura-V'
        'FlyingTomahawk futura-dark-V'
        'G-rila fundamental'
        'ruckage nes-mini'
        'ruckage famicom-mini'
        'ruckage snes-mini'
        'anthonycaccese crt'
        'anthonycaccese crt-centered'
        'anthonycaccese art-book'
        'anthonycaccese art-book-4-3'
        'anthonycaccese art-book-pocket'
        'anthonycaccese tft'
        'TMNTturtleguy ComicBook'
        'TMNTturtleguy ComicBook_4-3'
        'TMNTturtleguy ComicBook_SE-Wheelart'
        'TMNTturtleguy ComicBook_4-3_SE-Wheelart'
        'ChoccyHobNob cygnus'
        'dmmarti steampunk'
        'dmmarti hurstyblue'
        'dmmarti maximuspie'
        'dmmarti kidz'
        'rxbrad freeplay'
        'rxbrad gbz35'
        'rxbrad gbz35-dark'
        'garaine marioblue'
        'garaine bigwood'
        'MrTomixf Royal_Primicia'
        'lostless playstation'
        'mrharias superdisplay'
        'coinjunkie synthwave'
        'Saracade scv720'
        'chicueloarcade Chicuelo'
        'SuperMagicom nostalgic'
        'lipebello retrorama'
        'lipebello strangerstuff'
        'lipebello spaceoddity'
        'lipebello swineapple'
        'waweedman pii-wii'
        'waweedman Blade-360'
        'waweedman Venom'
        'waweedman Spider-Man'
        'blowfinger77 locomotion'
    )
    while true; do
        local theme
        local installed_themes=()
        local repo
        local options=()
        local status=()
        local default

        status+=("n")
        options+=(U "Update all installed themes")

        local i=1
        for theme in "${themes[@]}"; do
            theme=($theme)
            repo="${theme[0]}"
            theme="${theme[1]}"
            if [[ -d "/etc/emulationstation/themes/$theme" ]]; then
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
            U)
                for theme in "${installed_themes[@]}"; do
                    theme=($theme)
                    rp_callModule esthemes install_theme "${theme[0]}" "${theme[1]}"
                done
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
                            rp_callModule esthemes install_theme "$theme" "$repo"
                            ;;
                        2)
                            rp_callModule esthemes uninstall_theme "$theme"
                            ;;
                    esac
                else
                    rp_callModule esthemes install_theme "$theme" "$repo"
                fi
                ;;
        esac
    done
}
