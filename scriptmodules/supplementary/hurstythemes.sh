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
        'RetroHursty69 AladdinSweet'
        'RetroHursty69 AlienSweet'
        'RetroHursty69 AngryBirdSweet'
        'RetroHursty69 AnimalCrossingSweet'
        'RetroHursty69 AssassinsSweet'
        'RetroHursty69 AstroBoySweet'
        'RetroHursty69 AvatarSweet'
        'RetroHursty69 BackFutureSweet'
        'RetroHursty69 BanjoSweet'
        'RetroHursty69 BatmanSweet'
        'RetroHursty69 BattletoadsSweet'
        'RetroHursty69 BayonettaSweet'
        'RetroHursty69 BeautyBeastSweet'
        'RetroHursty69 BeavisButtHeadSweet'
        'RetroHursty69 BioshockSweet'
        'RetroHursty69 BombermanSweet'
        'RetroHursty69 BubbleBobbleSweet'
        'RetroHursty69 BuffySweet'
        'RetroHursty69 BugsLifeSweet'
        'RetroHursty69 CODSweet'
        'RetroHursty69 CaptAmericaSweet'
        'RetroHursty69 CastlevaniaSweet'
        'RetroHursty69 ChronoTriggerSweet'
        'RetroHursty69 ChunLiSweet'
        'RetroHursty69 ContraSweet'
        'RetroHursty69 CrashBandiSweet'
        'RetroHursty69 CrazyTaxiSweet'
        'RetroHursty69 CupheadSweet'
        'RetroHursty69 DKCountrySweet'
        'RetroHursty69 DarkstalkersSweet'
        'RetroHursty69 DayTentacleSweet'
        'RetroHursty69 DevilMayCrySweet'
        'RetroHursty69 DiabloSweet'
        'RetroHursty69 DieHardSweet'
        'RetroHursty69 DigDugSweet'
        'RetroHursty69 DigimonSweet'
        'RetroHursty69 DoomSweet'
        'RetroHursty69 DoubleDragonSweet'
        'RetroHursty69 DrMarioSweet'
        'RetroHursty69 DrWhoSweet'
        'RetroHursty69 DragonballZSweet'
        'RetroHursty69 DragonsLairSweet'
        'RetroHursty69 DuckHuntSweet'
        'RetroHursty69 ETSweet'
        'RetroHursty69 EarthboundSweet'
        'RetroHursty69 DukeNukemSweet'
        'RetroHursty69 EarthwormJimSweet'
        'RetroHursty69 FamilyGuySweet'
        'RetroHursty69 FarCrySweet'
        'RetroHursty69 FalloutSweet'
        'RetroHursty69 FatalFurySweet'
        'RetroHursty69 FelixSweet'
        'RetroHursty69 FinalFantasySweet'
        'RetroHursty69 FindingNemoSweet'
        'RetroHursty69 FlintstonesSweet'
        'RetroHursty69 FortniteSweet'
        'RetroHursty69 ForzaSweet'
        'RetroHursty69 FoxSweet'
        'RetroHursty69 FreddySweet'
        'RetroHursty69 FullThrottleSweet'
        'RetroHursty69 FuturamaSweet'
        'RetroHursty69 FuryRoadSweet'
        'RetroHursty69 FroggerSweet'
        'RetroHursty69 FZeroSweet'
        'RetroHursty69 GEXSweet'
        'RetroHursty69 GOWSweet'
        'RetroHursty69 GTASweet'
        'RetroHursty69 GhostbustersSweet'
        'RetroHursty69 GhoulsSweet'
        'RetroHursty69 GoldenEyeSweet'
        'RetroHursty69 GranTurismoSweet'
        'RetroHursty69 GrimFandangoSweet'
        'RetroHursty69 HalfLifeSweet'
        'RetroHursty69 HaloSweet'
        'RetroHursty69 HalloweenSweet'
        'RetroHursty69 HarryPotterSweet'
        'RetroHursty69 HarvestMoonSweet'
        'RetroHursty69 HelloKittySweet'
        'RetroHursty69 HitmanSweet'
        'RetroHursty69 HulkSweet'
        'RetroHursty69 IncrediblesSweet'
        'RetroHursty69 IndianaJonesSweet'
        'RetroHursty69 InspectorGadgetSweet'
        'RetroHursty69 IronGiantSweet'
        'RetroHursty69 IronManSweet'
        'RetroHursty69 JetSetSweet'
        'RetroHursty69 JetsonsSweet'
        'RetroHursty69 JudgeDreddSweet'
        'RetroHursty69 JurassicParkSweet'
        'RetroHursty69 KOFSweet'
        'RetroHursty69 KillerInstinctSweet'
        'RetroHursty69 KillLaKillSweet'
        'RetroHursty69 KindomHeartsSweet'
        'RetroHursty69 KirbySweet'
        'RetroHursty69 KongSweet'
        'RetroHursty69 KratosSweet'
        'RetroHursty69 LaraCroftSweet'
        'RetroHursty69 LegoSweet'
        'RetroHursty69 LionKingSweet'
        'RetroHursty69 LordRingsSweet'
        'RetroHursty69 LuigiSweet'
        'RetroHursty69 MLPSweet'
        'RetroHursty69 MOTUSweet'
        'RetroHursty69 MarioBrosSweet'
        'RetroHursty69 MarioKartSweet'
        'RetroHursty69 MarioPartySweet'
        'RetroHursty69 MartiMagicSweet'
        'RetroHursty69 MarvelvsCapcomSweet'
        'RetroHursty69 MassEffectSweet'
        'RetroHursty69 MatrixSweet'
        'RetroHursty69 MaxPayneSweet'
        'RetroHursty69 MechWarriorSweet'
        'RetroHursty69 MegaManSweet'
        'RetroHursty69 MeninBlackSweet'
        'RetroHursty69 MetalGearSweet'
        'RetroHursty69 MetalSlugSweet'
        'RetroHursty69 MetroidSweet'
        'RetroHursty69 MillenniumSweet'
        'RetroHursty69 MinecraftSweet'
        'RetroHursty69 MonkeyBallSweet'
        'RetroHursty69 MonsterHunterSweet'
        'RetroHursty69 MonstersIncSweet'
        'RetroHursty69 MortalKombatSweet'
        'RetroHursty69 MuppetsSweet'
        'RetroHursty69 NinjaGaidenSweet'
        'RetroHursty69 OddWorldSweet'
        'RetroHursty69 OptimusSweet'
        'RetroHursty69 OutrunSweet'
        'RetroHursty69 OverwatchSweet'
        'RetroHursty69 PaRappaSweet'
        'RetroHursty69 PacmanSweet'
        'RetroHursty69 ParodiusSweet'
        'RetroHursty69 PepsiManSweet'
        'RetroHursty69 PikminSweet'
        'RetroHursty69 PokemonSweet'
        'RetroHursty69 PopeyeSweet'
        'RetroHursty69 PowerRangersSweet'
        'RetroHursty69 PredatorSweet'
        'RetroHursty69 PrinceofPersiaSweet'
        'RetroHursty69 ProfessorLaytonSweet'
        'RetroHursty69 PunchOutSweet'
        'RetroHursty69 QBertSweet'
        'RetroHursty69 Rainbow6Sweet'
        'RetroHursty69 RachetClankSweet'
        'RetroHursty69 RamboSweet'
        'RetroHursty69 RaymanSweet'
        'RetroHursty69 ReadyPlayer1Sweet'
        'RetroHursty69 RedDeadSweet'
        'RetroHursty69 RenStimpySweet'
        'RetroHursty69 ResidentEvilSweet'
        'RetroHursty69 RoboCopSweet'
        'RetroHursty69 RockBandSweet'
        'RetroHursty69 RogerRabbitSweet'
        'RetroHursty69 RogueSquadronSweet'
        'RetroHursty69 RyuSweet'
        'RetroHursty69 SMWorldSweet'
        'RetroHursty69 SWHothSweet'
        'RetroHursty69 SackBoySweet'
        'RetroHursty69 SamuraiShoSweet'
        'RetroHursty69 ShrekSweet'
        'RetroHursty69 SimCitySweet'
        'RetroHursty69 SimpsonsSweet'
        'RetroHursty69 SimsSweet'
        'RetroHursty69 SmashBrosSweet'
        'RetroHursty69 SmurfsSweet'
        'RetroHursty69 SouthParkSweet'
        'RetroHursty69 SonicSweet'
        'RetroHursty69 SoulCaliburSweet'
        'RetroHursty69 SouljaBoySweet'
        'RetroHursty69 SpaceChannel5Sweet'
        'RetroHursty69 SpeedRacerSweet'
        'RetroHursty69 SpidermanSweet'
        'RetroHursty69 SplinterCellSweet'
        'RetroHursty69 SpongebobSweet'
        'RetroHursty69 SpyroSweet'
        'RetroHursty69 StarTrekSweet'
        'RetroHursty69 StreetsRageSweet'
        'RetroHursty69 SupermanSweet'
        'RetroHursty69 TMNTSweet'
        'RetroHursty69 TekkenSweet'
        'RetroHursty69 TerminatorSweet'
        'RetroHursty69 ToejamEarlSweet'
        'RetroHursty69 TonyHawkSweet'
        'RetroHursty69 TotalRecallSweet'
        'RetroHursty69 ToyStorySweet'
        'RetroHursty69 TronSweet'
        'RetroHursty69 TronLegacySweet'
        'RetroHursty69 TwistedMetalSweet'
        'RetroHursty69 UnchartedSweet'
        'RetroHursty69 ViewtifulJoeSweet'
        'RetroHursty69 VirtuaFighterSweet'
        'RetroHursty69 VirtuaTennisSweet'
        'RetroHursty69 WallESweet'
        'RetroHursty69 WarioSweet'
        'RetroHursty69 WitcherSweet'
        'RetroHursty69 WolfensteinSweet'
        'RetroHursty69 WonderWomanSweet'
        'RetroHursty69 WormsSweet'
        'RetroHursty69 WoWSweet'
        'RetroHursty69 WrestleManiaSweet'
        'RetroHursty69 XMenSweet'
        'RetroHursty69 YoshiSweet'
        'RetroHursty69 ZeldaSweet'
        'RetroHursty69 back2basics'
        'RetroHursty69 batmanburton'
        'RetroHursty69 bluray'
        'RetroHursty69 boxalloyblue'
        'RetroHursty69 boxalloyred'
        'RetroHursty69 boxcity'
        'RetroHursty69 cabsnazzy'
        'RetroHursty69 cardcrazy'
        'RetroHursty69 comiccrazy'
        'RetroHursty69 crisp'
        'RetroHursty69 crisp_light'
        'RetroHursty69 cyber'
        'RetroHursty69 darkswitch'
        'RetroHursty69 disenchantment'
        'RetroHursty69 donkeykonkey'
        'RetroHursty69 dragonballz'
        'RetroHursty69 evilresident'
        'RetroHursty69 garfieldism'
        'RetroHursty69 graffiti'
        'RetroHursty69 greenilicious'
        'RetroHursty69 halloweenspecial'
        'RetroHursty69 heman'
        'RetroHursty69 heychromey'
        'RetroHursty69 homerism'
        'RetroHursty69 hurstyspin'
        'RetroHursty69 incredibles'
        'RetroHursty69 infinity'
        'RetroHursty69 license2game'
        'RetroHursty69 lightswitch'
        'RetroHursty69 magazinemadness'
        'RetroHursty69 mario_melee'
        'RetroHursty69 merryxmas'
        'RetroHursty69 minecraft'
        'RetroHursty69 minions'
        'RetroHursty69 NegativeColor'
        'RetroHursty69 NegativeSepia'
        'RetroHursty69 neogeo_only'
        'RetroHursty69 pacman'
        'RetroHursty69 pitube'
        'RetroHursty69 primo'
        'RetroHursty69 primo_light'
        'RetroHursty69 retrogamenews'
        'RetroHursty69 retroroid'
        'RetroHursty69 snapback'
        'RetroHursty69 snazzy'
        'RetroHursty69 soda'
        'RetroHursty69 spaceinvaders'
        'RetroHursty69 stirling'
        'RetroHursty69 sublime'
        'RetroHursty69 supersweet'
        'RetroHursty69 tmnt'
        'RetroHursty69 tributeGoT'
        'RetroHursty69 tributeSTrek'
        'RetroHursty69 tributeSWars'
        'RetroHursty69 vertical_arcade'
        'RetroHursty69 whiteslide'
        'RetroHursty69 whitewood'
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
