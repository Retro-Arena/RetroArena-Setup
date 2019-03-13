#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="hurstythemes"
rp_module_desc="Hursty's ES Theme Installer and Randomizer"
rp_module_section="config"

function depends_hurstythemes() {
    if isPlatform "x11"; then
        getDepends feh
    else
        getDepends fbi
    fi
}

function install_theme_hurstythemes() {
    local theme="$1"
    local repo="$2"
    if [[ -z "$repo" ]]; then
        repo="RetroHursty69"
    fi
    if [[ -z "$theme" ]]; then
        theme="carbon"
        repo="RetroArena"
    fi
    sudo git clone "https://github.com/$repo/es-theme-$theme.git" "/etc/emulationstation/themes/$theme"
}

function uninstall_theme_hurstythemes() {
    local theme="$1"
    if [[ -d "/etc/emulationstation/themes/$theme" ]]; then
        sudo rm -rf "/etc/emulationstation/themes/$theme"
    fi
}

function gui_hurstythemes() {
    local themes=(
        'RetroHursty69 fabuloso'
        'RetroHursty69 hurstybluetake2'
        'RetroHursty69 soda'
        'RetroHursty69 supersweet'
        'RetroHursty69 supersweet_aspectratio54'
        'RetroHursty69 AladdinCool'
        'RetroHursty69 AnimalCrossingCool'
        'RetroHursty69 ArmyMenCool'
        'RetroHursty69 BanjoCool'
        'RetroHursty69 BatmanCool'
        'RetroHursty69 BayonettaCool'
        'RetroHursty69 BombermanCool'
        'RetroHursty69 BowserCool'
        'RetroHursty69 BubbleBobbleCool'
        'RetroHursty69 BubsyCool'
        'RetroHursty69 CastlevaniaCool'
        'RetroHursty69 CaptainAmericaCool'
        'RetroHursty69 ContraCool'
        'RetroHursty69 CrashBandicootCool'
        'RetroHursty69 CupheadCool'
        'RetroHursty69 DarkstalkersCool'
        'RetroHursty69 DayTentacleCool'
        'RetroHursty69 DeadOrAliveCool'
        'RetroHursty69 DevilMayCryCool'
        'RetroHursty69 DKCountryCool'
        'RetroHursty69 DonkeyKongCool'
        'RetroHursty69 DoubleDragonCool'
        'RetroHursty69 DragonballZCool'
        'RetroHursty69 DrMarioCool'
        'RetroHursty69 DuckHuntCool'
        'RetroHursty69 EarthwormJimCool'
        'RetroHursty69 EggmanCool'
        'RetroHursty69 FalloutCool'
        'RetroHursty69 FatalFuryCool'
        'RetroHursty69 FinalFantasyCool'
        'RetroHursty69 FroggerCool'
        'RetroHursty69 FZeroCool'
        'RetroHursty69 GexCool'
        'RetroHursty69 GhoulsNGhostsCool'
        'RetroHursty69 GodOfWarCool'
        'RetroHursty69 GoldenEyeCool'
        'RetroHursty69 GrimFandangoCool'
        'RetroHursty69 GTACool'
        'RetroHursty69 HaloCool'
        'RetroHursty69 HarleyQuinnCool'
        'RetroHursty69 HarryPotterCool'
        'RetroHursty69 HeManCool'
        'RetroHursty69 HulkCool'
        'RetroHursty69 IncrediblesCool'
        'RetroHursty69 IndianaJonesCool'
        'RetroHursty69 InspectorGadgetCool'
        'RetroHursty69 JetSetRadioCool'
        'RetroHursty69 KillerInstinctCool'
        'RetroHursty69 KindomHeartsCool'
        'RetroHursty69 KirbyCool'
        'RetroHursty69 KOFCool'
        'RetroHursty69 LegoCool'
        'RetroHursty69 LittleBigPlanetCool'
        'RetroHursty69 LuigiCool'
        'RetroHursty69 MarioBrosCool'
        'RetroHursty69 MarioCool'
        'RetroHursty69 MarioKartCool'
        'RetroHursty69 MarioPartyCool'
        'RetroHursty69 MegaManCool'
        'RetroHursty69 MetalSlugCool'
        'RetroHursty69 MetroidCool'
        'RetroHursty69 MGSCool'
        'RetroHursty69 MonkeyBallCool'
        'RetroHursty69 MortalKombatCool'
        'RetroHursty69 OddworldCool'
        'RetroHursty69 OutrunCool'
        'RetroHursty69 PacmanCool'
        'RetroHursty69 ParappaCool'
        'RetroHursty69 ParodiusCool'
        'RetroHursty69 PepsiManCool'
        'RetroHursty69 PikminCool'
        'RetroHursty69 PokemonCool'
        'RetroHursty69 PowerRangersCool'
        'RetroHursty69 PredatorCool'
        'RetroHursty69 PrincePersiaCool'
        'RetroHursty69 PunchOutCool'
        'RetroHursty69 QBertCool'
        'RetroHursty69 RachetClankCool'
        'RetroHursty69 RaymanCool'
        'RetroHursty69 RenStimpyCool'
        'RetroHursty69 ResidentEvilCool'
        'RetroHursty69 RobocopCool'
        'RetroHursty69 SamuraiShodownCool'
        'RetroHursty69 ShrekCool'
        'RetroHursty69 SimpsonsCool'
        'RetroHursty69 SimsCool'
        'RetroHursty69 SmashBrosCool'
        'RetroHursty69 SmurfsCool'
        'RetroHursty69 SonicCool'
        'RetroHursty69 SoulCaliburCool'
        'RetroHursty69 SouthParkCool'
        'RetroHursty69 SpaceChannel5Cool'
        'RetroHursty69 SpaceInvadersCool'
        'RetroHursty69 SpiderManCool'
        'RetroHursty69 SplatoonCool'
        'RetroHursty69 SplinterCellCool'
        'RetroHursty69 SpyroCool'
        'RetroHursty69 StarFoxCool'
        'RetroHursty69 StarTrekCool'
        'RetroHursty69 StreetFighterCool'
        'RetroHursty69 StreetsOfRageCool'
        'RetroHursty69 SupermanCool'
        'RetroHursty69 TekkenCool'
        'RetroHursty69 TMNTCool'
        'RetroHursty69 TerminatorCool'
        'RetroHursty69 ToadCool'
        'RetroHursty69 TonyHawkCool'
        'RetroHursty69 ToyStoryCool'
        'RetroHursty69 TwistedMetalCool'
        'RetroHursty69 UnchartedCool'
        'RetroHursty69 WaluigiCool'
        'RetroHursty69 WarioCool'
        'RetroHursty69 WolfensteinCool'
        'RetroHursty69 WolverineCool'
        'RetroHursty69 WormsCool'
        'RetroHursty69 WrestlemaniaCool'
        'RetroHursty69 XMenCool'
        'RetroHursty69 YoshiCool'
        'RetroHursty69 YuGiOhCool'
        'RetroHursty69 ZeldaCool'
    )
    while true; do
        local theme
        local installed_themes=()
        local repo
        local options=()
        local status=()
        local default

        options+=(E "Enable ES bootup theme randomizer")
        options+=(D "Disable ES bootup theme randomizer")

        local i=1
        for theme in "${themes[@]}"; do
            theme=($theme)
            repo="${theme[0]}"
            theme="${theme[1]}"
            if [[ -d "/etc/emulationstation/themes/$theme" ]]; then
                status+=("i")
                options+=("$i" "Update or Uninstall $theme (installed)")
                installed_themes+=("$theme $repo")
            else
                status+=("n")
                options+=("$i" "Install $theme (not installed)")
            fi
            ((i++))
        done
        local cmd=(dialog --default-item "$default" --backtitle "Hursty's ES Themes Installer" --menu "Hursty's ES Themes Installer - Choose an option" 22 76 16)
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        default="$choice"
        [[ -z "$choice" ]] && break
        case "$choice" in
            E)  #enable ES bootup theme randomizer
                touch $home/.config/themerandomizer
                printMsgs "dialog" "Theme Randomizer enabled"
                ;;
            D)  #disable ES bootup theme randomizer
                rm -rf $home/.config/themerandomizer
                printMsgs "dialog" "Theme Randomizer disabled"
                ;;
            *)  #install or update themes
                theme=(${themes[choice-1]})
                repo="${theme[0]}"
                theme="${theme[1]}"
                if [[ -d "/etc/emulationstation/themes/$theme" ]]; then
                    options=(1 "Update $theme" 2 "Uninstall $theme")
                    cmd=(dialog --backtitle "$__backtitle" --menu "Choose an option for theme" 12 40 06)
                    local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
                    case "$choice" in
                        1)
                            install_theme_hurstythemes "$theme" "$repo"
                            ;;
                        2)
                            uninstall_theme_hurstythemes "$theme"
                            ;;
                    esac
                else
                    install_theme_hurstythemes "$theme" "$repo"
                fi
                ;;
        esac
    done
}
