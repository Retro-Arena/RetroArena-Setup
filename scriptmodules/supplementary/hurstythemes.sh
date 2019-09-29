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
        theme="rad"
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

function disable_themerandomizer() {
    rm -rf $home/.config/themerandomizer
    printMsgs "dialog" "Theme Randomizer disabled"
}

function enable_themerandomizer() {
    touch $home/.config/themerandomizer
    printMsgs "dialog" "Theme Randomizer enabled"
}

function gui_hurstythemes() {
    while true; do
        local theme
        local installed_themes=()
        local repo
        local options=()
        local status=()
        local default

        options+=(E "Enable ES bootup theme randomizer")
        options+=(D "Disable ES bootup theme randomizer")
        options+=(F "Mini Sweet Themes Manager (239 Themes)")
        options+=(G "Cool Themes Manager (121 Themes)")
        options+=(H "Spin Themes Manager (172 Themes)")
        options+=(I "16:9 Aspect Themes Manager (87 Themes)")
        options+=(J "5:4 Aspect Themes Manager (4 Themes)")
        options+=(K "Vertical Aspect Themes Manager (2 Themes)")
        options+=(L "Chromey Blue Themes Manager (133 Themes)")
        options+=(M "Chromey Green Themes Manager (133 Themes)")
        options+=(N "Chromey Neon Themes Manager (133 Themes)")
        options+=(O "Hursty's Picks Themes Manager (23 Themes)")
        options+=(P "Handheld (3:2, 4:3) Themes Manager (11 Themes)")
        options+=(Q "Slick Themes Manager (29 Themes)")
        options+=(R "Hyper Themes Manager (177 Themes)")
        options+=(S "Mario Themes Manager (22 Themes)")        

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
        local cmd=(dialog --default-item "$default" --backtitle "Hursty's ES Themes Installer" --menu "Hursty's ES Themes Installer - (1242 Themes as at 24 September 2019)" 22 76 16)
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        default="$choice"
        [[ -z "$choice" ]] && break
        case "$choice" in
            E)  #enable ES bootup theme randomizer
                enable_themerandomizer
                ;;
            D)  #disable ES bootup theme randomizer
                disable_themerandomizer
                ;;
            F)  #mini sweet themes only
                sweet_themes
                ;;
            G)  #cool themes only
                cool_themes
                ;;
            H)  #spin themes only
                spin_themes
                ;;
            I)  #16:9 themes only
                16x9_themes
                ;;
            J)  #4:3 themes only
                5x4_themes
                ;;
            K)  #vertical themes only
                vertical_themes
                ;;
            L)  #chromey blue themes only
                chromeyblue_themes
                ;;
            M)  #chromey green themes only
                chromeygreen_themes
                ;;
            N)  #chromey neon themes only
                chromeyneon_themes
                ;;
            O)  #hursty's picks
                hurstypicks_themes
                ;;
            P)  #handheld themes
                handheld_themes
                ;;
            Q)  #slick themes
                slick_themes
                ;;
            R)  #hyper themes
                hyper_themes
                ;;
            S)  #mario themes
                mario_themes
                ;;                
            *)  #install or update themes
                theme=(${themes[choice-1]})
                repo="${theme[0]}"
                theme="${theme[1]}"
#                if [[ "${status[choice]}" == "i" ]]; then
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

function sweet_themes() {
    local themes=(
    'RetroHursty69 300Sweet'
    'RetroHursty69 AdventureTimeSweet'
    'RetroHursty69 AladdinSweet'
    'RetroHursty69 AlienSweet'
    'RetroHursty69 AmericanDadSweet'
    'RetroHursty69 AngryBirdSweet'
    'RetroHursty69 AnimalCrossingSweet'
    'RetroHursty69 AntManSweet'
    'RetroHursty69 AssassinsSweet'
    'RetroHursty69 AstroBoySweet'
    'RetroHursty69 AustinPowersSweet'
    'RetroHursty69 AvatarSweet'
    'RetroHursty69 BackFutureSweet'
    'RetroHursty69 BanjoSweet'
    'RetroHursty69 BatmanSweet'
    'RetroHursty69 BattletoadsSweet'
    'RetroHursty69 BayonettaSweet'
    'RetroHursty69 BeautyBeastSweet'
    'RetroHursty69 BeavisButtHeadSweet'
    'RetroHursty69 BeetleJuiceSweet'
    'RetroHursty69 BettyBoopSweet'
    'RetroHursty69 BioshockSweet'
    'RetroHursty69 BloodyRoarSweet'
    'RetroHursty69 BombermanSweet'
    'RetroHursty69 BreathofFireSweet'
    'RetroHursty69 BrianLaraSweet'
    'RetroHursty69 BubbleBobbleSweet'
    'RetroHursty69 BuffySweet'
    'RetroHursty69 BugsLifeSweet'
    'RetroHursty69 CODSweet'
    'RetroHursty69 CaptAmericaSweet'
    'RetroHursty69 CarsSweet'
    'RetroHursty69 CastlevaniaSweet'
    'RetroHursty69 ChronoTriggerSweet'
    'RetroHursty69 ChuckySweet'
    'RetroHursty69 ChunLiSweet'
    'RetroHursty69 ContraSweet'
    'RetroHursty69 CrashBandiSweet'
    'RetroHursty69 CrazyTaxiSweet'
    'RetroHursty69 CupheadSweet'
    'RetroHursty69 DKCountrySweet'
    'RetroHursty69 DarkstalkersSweet'
    'RetroHursty69 DayTentacleSweet'
    'RetroHursty69 DeadpoolSweet'
    'RetroHursty69 DeadorAliveSweet'
    'RetroHursty69 DevilMayCrySweet'
    'RetroHursty69 DiabloSweet'
    'RetroHursty69 DieHardSweet'
    'RetroHursty69 DigDugSweet'
    'RetroHursty69 DigimonSweet'
    'RetroHursty69 DoomSweet'
    'RetroHursty69 DoraemonSweet'
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
    'RetroHursty69 EvilDeadSweet'
    'RetroHursty69 FamilyGuySweet'
    'RetroHursty69 Fantastic4Sweet'
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
    'RetroHursty69 Friday13thSweet'
    'RetroHursty69 FullThrottleSweet'
    'RetroHursty69 FuturamaSweet'
    'RetroHursty69 FuryRoadSweet'
    'RetroHursty69 FroggerSweet'
    'RetroHursty69 FZeroSweet'
    'RetroHursty69 GEXSweet'
    'RetroHursty69 GOWSweet'
    'RetroHursty69 GTASweet'
    'RetroHursty69 GhostbustersSweet'
    'RetroHursty69 GhostRiderSweet'
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
    'RetroHursty69 ITSweet'
    'RetroHursty69 JetSetSweet'
    'RetroHursty69 JetsonsSweet'
    'RetroHursty69 JudgeDreddSweet'
    'RetroHursty69 JurassicParkSweet'
    'RetroHursty69 KOFSweet'
    'RetroHursty69 KillerInstinctSweet'
    'RetroHursty69 KillLaKillSweet'
    'RetroHursty69 KindomHeartsSweet'
    'RetroHursty69 KirbySweet'
    'RetroHursty69 KlonoaSweet'
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
    'RetroHursty69 MooMesaSweet'
    'RetroHursty69 MortalKombatSweet'
    'RetroHursty69 MuppetsSweet'
    'RetroHursty69 MysticalNinjaSweet'
    'RetroHursty69 NinjaGaidenSweet'
    'RetroHursty69 OddWorldSweet'
    'RetroHursty69 OptimusSweet'
    'RetroHursty69 OutrunSweet'
    'RetroHursty69 OverwatchSweet'
    'RetroHursty69 PaRappaSweet'
    'RetroHursty69 PacmanSweet'
    'RetroHursty69 PaperMarioSweet'
    'RetroHursty69 ParodiusSweet'
    'RetroHursty69 PepsiManSweet'
    'RetroHursty69 PersonaSweet'
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
    'RetroHursty69 SawSweet'
    'RetroHursty69 ScoobyDooSweet'
    'RetroHursty69 ShaneWarneSweet'
    'RetroHursty69 ShrekSweet'
    'RetroHursty69 SilentHillSweet'
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
    'RetroHursty69 StrangerThingsSweet'
    'RetroHursty69 StreetsRageSweet'
    'RetroHursty69 SuicideSquadSweet'
    'RetroHursty69 SupermanSweet'
    'RetroHursty69 TMNTSweet'
    'RetroHursty69 TeamFortress2Sweet'
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
    'RetroHursty69 UpSweet'
    'RetroHursty69 VenomSweet'
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
    'RetroHursty69 YuGiOhSweet'
    'RetroHursty69 ZeldaSweet'
    'RetroHursty69 ZombiesAteSweet'
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
            *)  #install or update themes
                theme=(${themes[choice-1]})
                repo="${theme[0]}"
                theme="${theme[1]}"
#                if [[ "${status[choice]}" == "i" ]]; then
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

function cool_themes() {
    local themes=(
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
    'RetroHursty69 KingdomHeartsCool'
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
    'RetroHursty69 SubScorpionCool'
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
            *)  #install or update themes
                theme=(${themes[choice-1]})
                repo="${theme[0]}"
                theme="${theme[1]}"
#                if [[ "${status[choice]}" == "i" ]]; then
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

function spin_themes() {
    local themes=(
    'RetroHursty69 AdventureTimeSpin'
    'RetroHursty69 AkumaSpin'
    'RetroHursty69 AladdinSpin'
    'RetroHursty69 AlexKiddSpin'
    'RetroHursty69 AlvinSpin'
    'RetroHursty69 AmigoSpin'
    'RetroHursty69 AngryBirdsSpin'
    'RetroHursty69 AntManSpin'
    'RetroHursty69 AquamanSpin'
    'RetroHursty69 ArcadePunksSpin'
    'RetroHursty69 ArthurSpin'
    'RetroHursty69 AstroBoySpin'
    'RetroHursty69 BatmanSpin'
    'RetroHursty69 BirdoSpin'
    'RetroHursty69 BisonSpin'
    'RetroHursty69 BlankaSpin'    
    'RetroHursty69 BombermanSpin'
    'RetroHursty69 BOrchidSpin'    
    'RetroHursty69 BowserSpin'
    'RetroHursty69 BubbleBobbleSpin'
    'RetroHursty69 CaptainAmericaSpin'
    'RetroHursty69 CharizardSpin'
    'RetroHursty69 ChunLiSpin'
    'RetroHursty69 CODSpin'
    'RetroHursty69 CrashBandicootSpin'
    'RetroHursty69 CupHeadSpin'
    'RetroHursty69 DarthSpin'
    'RetroHursty69 DeadpoolSpin'
    'RetroHursty69 DiddyKongSpin'
    'RetroHursty69 DigDugSpin'
    'RetroHursty69 DigimonSpin'
    'RetroHursty69 DixieKongSpin'
    'RetroHursty69 DonaldDuckSpin'
    'RetroHursty69 DonkeyKongSpin'
    'RetroHursty69 DoomSpin'
    'RetroHursty69 DoraSpin'
    'RetroHursty69 DoreamonSpin'
    'RetroHursty69 DragonballZSpin'
    'RetroHursty69 DrBonesSpin'
    'RetroHursty69 DrEggmanSpin'
    'RetroHursty69 DrMarioSpin'
    'RetroHursty69 DuckHuntSpin'
    'RetroHursty69 DukeNukemSpin'
    'RetroHursty69 EarthwormJimSpin'
    'RetroHursty69 ETSpin'
    'RetroHursty69 FalloutSpin'
    'RetroHursty69 FatalFurySpin'
    'RetroHursty69 FinalFantasySpin'
    'RetroHursty69 FortnightSpin'
    'RetroHursty69 FreddySpin'
    'RetroHursty69 FroggerSpin'
    'RetroHursty69 FZeroSpin'
    'RetroHursty69 GameWatchSpin'
    'RetroHursty69 GarfieldSpin'
    'RetroHursty69 GexSpin'
    'RetroHursty69 GhoulsNGhostsSpin'
    'RetroHursty69 GodOfWarSpin'
    'RetroHursty69 GoombaSpin'
    'RetroHursty69 GrimFandangoSpin'
    'RetroHursty69 GTASpin'
    'RetroHursty69 HalfLifeSpin'
    'RetroHursty69 HaloSpin'
    'RetroHursty69 HarleyQuinnSpin'
    'RetroHursty69 HulkSpin'
    'RetroHursty69 IncrediblesSpin'
    'RetroHursty69 IncineroarSpin'
    'RetroHursty69 IndianaJonesSpin'
    'RetroHursty69 IronManSpin'
    'RetroHursty69 JasonSpin'
    'RetroHursty69 JetSetRadioSpin'
    'RetroHursty69 JinSpin'
    'RetroHursty69 JuggernautSpin'
    'RetroHursty69 KamekSpin'
    'RetroHursty69 KillerInstinctSpin'
    'RetroHursty69 KindomHeartsSpin'
    'RetroHursty69 KingDededeSpin'
    'RetroHursty69 KingRKoolSpin'
    'RetroHursty69 KingSpin'
    'RetroHursty69 KirbySpin'
    'RetroHursty69 KlonoaSpin'
    'RetroHursty69 KOFSpin'
    'RetroHursty69 LarryKoopaSpin'
    'RetroHursty69 LegoSpin'
    'RetroHursty69 LittleBigPlanetSpin'
    'RetroHursty69 LionKingSpin'
    'RetroHursty69 LucarioSpin'
    'RetroHursty69 LudwigSpin'
    'RetroHursty69 LuigiSpin'
    'RetroHursty69 LukeSpin'
    'RetroHursty69 MadHatterSpin'
    'RetroHursty69 MarioSpin'
    'RetroHursty69 MegamanSpin'
    'RetroHursty69 Megatron80sSpin'
    'RetroHursty69 MetalSlugSpin'
    'RetroHursty69 MetroidSpin'
    'RetroHursty69 MickeySpin'
    'RetroHursty69 MileenaSpin'
    'RetroHursty69 MinecraftSpin'
    'RetroHursty69 MonkeyBallSpin'
    'RetroHursty69 MonstersIncSpin'
    'RetroHursty69 MorpheusSpin'
    'RetroHursty69 MortalKombatSpin'
    'RetroHursty69 MrKarateSpin'
    'RetroHursty69 NabbitSpin'
    'RetroHursty69 NightsSpin'
    'RetroHursty69 OddworldSpin'
    'RetroHursty69 OptimusSpin'
    'RetroHursty69 Optimus80sSpin'
    'RetroHursty69 PacmanSpin'
    'RetroHursty69 ParappaSpin'
    'RetroHursty69 ParodiusSpin'
    'RetroHursty69 PikminSpin'
    'RetroHursty69 PokemonSpin'
    'RetroHursty69 PowerPuffSpin'
    'RetroHursty69 PredatorSpin'
    'RetroHursty69 PrincePersiaSpin'
    'RetroHursty69 ProfessorLaytonSpin'
    'RetroHursty69 PunchoutSpin'
    'RetroHursty69 QBertSpin'
    'RetroHursty69 RachetClankSpin'
    'RetroHursty69 RaidenSpin'    
    'RetroHursty69 RaymanSpin'
    'RetroHursty69 RetroArenaSpin'
    'RetroHursty69 ReaperSpin'
    'RetroHursty69 RoboCopSpin'
    'RetroHursty69 RogueSpin'
    'RetroHursty69 ScoobySpin'
    'RetroHursty69 ScorpionSpin'
    'RetroHursty69 SF3Spin'
    'RetroHursty69 ShredderSpin'
    'RetroHursty69 ShrekSpin'
    'RetroHursty69 ShyGuySpin'
    'RetroHursty69 SimpsonsSpin'
    'RetroHursty69 SimsSpin'
    'RetroHursty69 SmashBrosSpin'
    'RetroHursty69 SmurfsSpin'
    'RetroHursty69 SonicSpin'
    'RetroHursty69 SoulCaliburSpin'
    'RetroHursty69 SouthParkSpin'
    'RetroHursty69 SpaceChannel5Spin'
    'RetroHursty69 SpaceInvadersSpin'
    'RetroHursty69 SpidermanSpin'
    'RetroHursty69 SpikeSpin'
    'RetroHursty69 SplattoonSpin'
    'RetroHursty69 SplinterCellSpin'
    'RetroHursty69 SpongeBobSpin'
    'RetroHursty69 SpyroSpin'
    'RetroHursty69 StarFoxSpin'
    'RetroHursty69 StreetFighterSpin'
    'RetroHursty69 StreetsOfRageSpin'
    'RetroHursty69 SubZeroSpin'
    'RetroHursty69 SupermanSpin'
    'RetroHursty69 TailsSpin'
    'RetroHursty69 TekkenSpin'
    'RetroHursty69 TerminatorSpin'
    'RetroHursty69 TJComboSpin'
    'RetroHursty69 TMNTSpin'
    'RetroHursty69 ToadSpin'
    'RetroHursty69 ToyStorySpin'
    'RetroHursty69 WallESpin'
    'RetroHursty69 WaluigiSpin'
    'RetroHursty69 WarioSpin'
    'RetroHursty69 WendyOKoopaSpin'
    'RetroHursty69 WolfSpin'
    'RetroHursty69 WormsSpin'
    'RetroHursty69 WreckItSpin'
    'RetroHursty69 WrestlingSpin'
    'RetroHursty69 XMenSpin'
    'RetroHursty69 YodaSpin'
    'RetroHursty69 YoshiSpin'
    'RetroHursty69 ZeldaSpin'
    'RetroHursty69 ZeroSuitSpin'
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
            *)  #install or update themes
                theme=(${themes[choice-1]})
                repo="${theme[0]}"
                theme="${theme[1]}"
#                if [[ "${status[choice]}" == "i" ]]; then
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

function 16x9_themes() {
    local themes=(
    'RetroHursty69 back2basics'
    'RetroHursty69 batmanburton'
    'RetroHursty69 bitfit'
    'RetroHursty69 bluesteel'
    'RetroHursty69 blueprism'
    'RetroHursty69 bluesmooth'    
    'RetroHursty69 bluray'
    'RetroHursty69 boxalloyblue'
    'RetroHursty69 boxalloyred'
    'RetroHursty69 boxcity'
    'RetroHursty69 cabsnazzy'
    'RetroHursty69 CapcomColorHorizontal'
    'RetroHursty69 CapcomColorSpin'
    'RetroHursty69 CapcomColorVertical'
    'RetroHursty69 cardcrazy'
    'RetroHursty69 circuit'
    'RetroHursty69 comiccrazy'
    'RetroHursty69 corg'
    'RetroHursty69 CosmicRise'
    'RetroHursty69 crisp'
    'RetroHursty69 crisp_light'
    'RetroHursty69 cyber'
    'RetroHursty69 darkswitch'
    'RetroHursty69 disenchantment'
    'RetroHursty69 donkeykonkey'
    'RetroHursty69 dragonballz'
    'RetroHursty69 evilresident'
    'RetroHursty69 fabuloso'
    'RetroHursty69 floyd'
    'RetroHursty69 floyd_arcade'
    'RetroHursty69 floyd_room'
    'RetroHursty69 garfieldism'
    'RetroHursty69 ghostbusters'
    'RetroHursty69 graffiti'
    'RetroHursty69 greenilicious'
    'RetroHursty69 halloweenspecial'
    'RetroHursty69 heman'
    'RetroHursty69 heychromey'
    'RetroHursty69 homerism'
    'RetroHursty69 hurstybluetake2'
    'RetroHursty69 hurstyspin'
    'RetroHursty69 incredibles'
    'RetroHursty69 infinity'
    'RetroHursty69 joysticks'
    'RetroHursty69 license2game'
    'RetroHursty69 lightswitch'
    'RetroHursty69 magazinemadness'
    'RetroHursty69 magazinemadness2'
    'RetroHursty69 marco'
    'RetroHursty69 mariobrosiii'
    'RetroHursty69 mario_melee'
    'RetroHursty69 merryxmas'
    'RetroHursty69 meshy'
    'RetroHursty69 minecraft'
    'RetroHursty69 minions'
    'RetroHursty69 mysticorb'
    'RetroHursty69 NegativeColor'
    'RetroHursty69 NegativeSepia'
    'RetroHursty69 neogeo_only'
    'RetroHursty69 orbpilot'
    'RetroHursty69 pacman'
    'RetroHursty69 pitube'
    'RetroHursty69 primo'
    'RetroHursty69 primo_light'
    'RetroHursty69 realghostbusters'    
    'RetroHursty69 retroboy'
    'RetroHursty69 retroboy2'
    'RetroHursty69 retrogamenews'
    'RetroHursty69 retroroid'
    'RetroHursty69 snapback'
    'RetroHursty69 snazzy'
    'RetroHursty69 soda'
    'RetroHursty69 spaceinvaders'
    'RetroHursty69 stirling'
    'RetroHursty69 stirlingness'
    'RetroHursty69 sublime'
    'RetroHursty69 supersweet'
    'RetroHursty69 swatch'
    'RetroHursty69 sweet_tinkerboard'
    'RetroHursty69 sweeter_tinkerboard'
    'RetroHursty69 tmnt'
    'RetroHursty69 tributeGoT'
    'RetroHursty69 tributeSTrek'
    'RetroHursty69 tributeSWars'
    'RetroHursty69 uniflyered'
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
            *)  #install or update themes
                theme=(${themes[choice-1]})
                repo="${theme[0]}"
                theme="${theme[1]}"
#                if [[ "${status[choice]}" == "i" ]]; then
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

function 5x4_themes() {
    local themes=(
    'RetroHursty69 arcade1up_aspectratio54'
    'RetroHursty69 heychromey_aspectratio54'
    'RetroHursty69 hurstyuparcade_aspectratio54'
    'RetroHursty69 supersweet_aspectratio54'
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
            *)  #install or update themes
                theme=(${themes[choice-1]})
                repo="${theme[0]}"
                theme="${theme[1]}"
#                if [[ "${status[choice]}" == "i" ]]; then
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

function vertical_themes() {
    local themes=(
    'RetroHursty69 vertical_arcade'
    'RetroHursty69 vertical_limit_verticaltheme'
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
            *)  #install or update themes
                theme=(${themes[choice-1]})
                repo="${theme[0]}"
                theme="${theme[1]}"
#                if [[ "${status[choice]}" == "i" ]]; then
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

function chromeyblue_themes() {
    local themes=(
    'RetroHursty69 1943Blue'
    'RetroHursty69 AladdinBlue'
    'RetroHursty69 AlexKiddBlue'
    'RetroHursty69 AngryBirdsBlue'
    'RetroHursty69 AntManBlue'
    'RetroHursty69 AquamanBlue'
    'RetroHursty69 AsteroidsBlue'
    'RetroHursty69 AstroBoyBlue'
    'RetroHursty69 BatmanBlue'
    'RetroHursty69 BombermanBlue'
    'RetroHursty69 BubbleBobbleBlue'
    'RetroHursty69 BumbleBeeBlue'
    'RetroHursty69 CaptainAmericaBlue'
    'RetroHursty69 DarkstalkersBlue'
    'RetroHursty69 DayTentacleBlue'
    'RetroHursty69 DaytonaUsaBlue'
    'RetroHursty69 DeadpoolBlue'
    'RetroHursty69 DigimonBlue'
    'RetroHursty69 DonkeyKongBlue'
    'RetroHursty69 DonkeyKongCountryBlue'
    'RetroHursty69 DrMarioBlue'
    'RetroHursty69 DragonBallZBlue'
    'RetroHursty69 DragonsLairBlue'
    'RetroHursty69 DukeNukemBlue'
    'RetroHursty69 ETBlue'
    'RetroHursty69 EarthwormJimBlue'    
    'RetroHursty69 ElevatorActionBlue'
    'RetroHursty69 FZeroBlue'    
    'RetroHursty69 FalloutBlue'
    'RetroHursty69 FatalFuryBlue'
    'RetroHursty69 FinalFantasyBlue'
    'RetroHursty69 FinalFightBlue'        
    'RetroHursty69 FortniteBlue'
    'RetroHursty69 FroggerBlue'
    'RetroHursty69 FullThrottleBlue'
    'RetroHursty69 GTABlue'
    'RetroHursty69 GalagaBlue'
    'RetroHursty69 GalaxianBlue'
    'RetroHursty69 GameAndWatchBlue'
    'RetroHursty69 GarfieldBlue'
    'RetroHursty69 GauntletBlue'
    'RetroHursty69 GexBlue'
    'RetroHursty69 GhoulsNGhostsBlue'
    'RetroHursty69 GodOfWarBlue'
    'RetroHursty69 GrimFandangoBlue'
    'RetroHursty69 HalfLifeBlue'
    'RetroHursty69 HaloBlue'    
    'RetroHursty69 HarleyQuinnBlue'
    'RetroHursty69 HulkBlue'
    'RetroHursty69 IncrediblesBlue'
    'RetroHursty69 IndianaJonesBlue'
    'RetroHursty69 IronManBlue'
    'RetroHursty69 JetSetRadioBlue'
    'RetroHursty69 KOFBlue'
    'RetroHursty69 KillerInstinctBlue'
    'RetroHursty69 KingKRoolBlue'    
    'RetroHursty69 KingdomHeartsBlue'
    'RetroHursty69 KirbyBlue'
    'RetroHursty69 LegoBlue'
    'RetroHursty69 LittleBigPlanetBlue'
    'RetroHursty69 LuigiBlue'
    'RetroHursty69 ManiacMansionBlue'
    'RetroHursty69 MarioBlue'
    'RetroHursty69 MatrixBlue'
    'RetroHursty69 MegaManBlue'
    'RetroHursty69 MetalSlugBlue'
    'RetroHursty69 MetroidBlue'
    'RetroHursty69 MickeyMouseBlue'    
    'RetroHursty69 MinecraftBlue'
    'RetroHursty69 MonkeyBallBlue'
    'RetroHursty69 MortalKombatBlue'
    'RetroHursty69 OddworldBlue'
    'RetroHursty69 OptimusPrimeBlue'
    'RetroHursty69 OutRunBlue'
    'RetroHursty69 PacmanBlue'
    'RetroHursty69 ParappaBlue'
    'RetroHursty69 PitfallBlue'
    'RetroHursty69 PikminBlue'
    'RetroHursty69 PokemonBlue'
    'RetroHursty69 PowerPuffBlue'
    'RetroHursty69 PredatorBlue'    
    'RetroHursty69 PrincePersiaBlue'
    'RetroHursty69 ProfessorLaytonBlue'
    'RetroHursty69 PunchOutBlue'
    'RetroHursty69 QBertBlue'
    'RetroHursty69 RactchetClankBlue'
    'RetroHursty69 RaymanBlue'
    'RetroHursty69 ResidentEvilBlue'
    'RetroHursty69 RidgeRacerBlue'
    'RetroHursty69 RoboCopBlue'
    'RetroHursty69 SF2Blue'
    'RetroHursty69 SF3rdStrikeBlue'
    'RetroHursty69 ScoobyDooBlue'
    'RetroHursty69 ShenmueBlue'        
    'RetroHursty69 ShrekBlue'
    'RetroHursty69 SimCityBlue'
    'RetroHursty69 SimpsonsBlue'
    'RetroHursty69 SimsBlue'
    'RetroHursty69 SmashBrosBlue'
    'RetroHursty69 SmurfsBlue'
    'RetroHursty69 SonicBlue'
    'RetroHursty69 SoulCaliburBlue'
    'RetroHursty69 SouthParkBlue'
    'RetroHursty69 SpaceAceBlue'
    'RetroHursty69 SpaceChannel5Blue'
    'RetroHursty69 SpaceInvadersBlue'
    'RetroHursty69 SpidermanBlue'
    'RetroHursty69 SplatoonBlue'
    'RetroHursty69 SplinterCellBlue'
    'RetroHursty69 SpongeBobBlue'
    'RetroHursty69 SpyroBlue'
    'RetroHursty69 StarFoxBlue'
    'RetroHursty69 StarWarsBlue'
    'RetroHursty69 StreetFighterBlue'
    'RetroHursty69 StreetsOfRageBlue'
    'RetroHursty69 SupermanBlue'
    'RetroHursty69 TMNTBlue'
    'RetroHursty69 TekkenBlue'
    'RetroHursty69 TerminatorBlue'
    'RetroHursty69 TetrisBlue'
    'RetroHursty69 ToadBlue'
    'RetroHursty69 TombRaiderBlue'
    'RetroHursty69 ToyStoryBlue'
    'RetroHursty69 TronBlue'
    'RetroHursty69 TwistedMetalBlue'
    'RetroHursty69 VirtuaFighterBlue'
    'RetroHursty69 WWEBlue'
    'RetroHursty69 WaluigiBlue'
    'RetroHursty69 WarioBlue'
    'RetroHursty69 WormsBlue'
    'RetroHursty69 XMenBlue'
    'RetroHursty69 YoshiBlue'
    'RetroHursty69 ZeldaBlue'
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
            *)  #install or update themes
                theme=(${themes[choice-1]})
                repo="${theme[0]}"
                theme="${theme[1]}"
#                if [[ "${status[choice]}" == "i" ]]; then
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

function chromeygreen_themes() {
    local themes=(
    'RetroHursty69 1943Green'
    'RetroHursty69 AladdinGreen'
    'RetroHursty69 AlexKiddGreen'
    'RetroHursty69 AngryBirdsGreen'
    'RetroHursty69 AntManGreen'
    'RetroHursty69 AquamanGreen'
    'RetroHursty69 AsteroidsGreen'
    'RetroHursty69 AstroBoyGreen'
    'RetroHursty69 BatmanGreen'
    'RetroHursty69 BombermanGreen'
    'RetroHursty69 BubbleBobbleGreen'
    'RetroHursty69 BumbleBeeGreen'
    'RetroHursty69 CaptainAmericaGreen'
    'RetroHursty69 DarkstalkersGreen'
    'RetroHursty69 DayTentacleGreen'
    'RetroHursty69 DaytonaUsaGreen'
    'RetroHursty69 DeadpoolGreen'
    'RetroHursty69 DigimonGreen'
    'RetroHursty69 DonkeyKongCountryGreen'
    'RetroHursty69 DonkeyKongGreen'
    'RetroHursty69 DrMarioGreen'
    'RetroHursty69 DragonBallZGreen'
    'RetroHursty69 DragonsLairGreen'
    'RetroHursty69 DukeNukemGreen'
    'RetroHursty69 ETGreen'
    'RetroHursty69 EarthwormJimGreen'    
    'RetroHursty69 ElevatorActionGreen'
    'RetroHursty69 FZeroGreen'    
    'RetroHursty69 FalloutGreen'
    'RetroHursty69 FatalFuryGreen'
    'RetroHursty69 FinalFantasyGreen'
    'RetroHursty69 FinalFightGreen'        
    'RetroHursty69 FortniteGreen'
    'RetroHursty69 FroggerGreen'
    'RetroHursty69 FullThrottleGreen'
    'RetroHursty69 GTAGreen'
    'RetroHursty69 GalagaGreen'
    'RetroHursty69 GalaxianGreen'
    'RetroHursty69 GameAndWatchGreen'
    'RetroHursty69 GarfieldGreen'
    'RetroHursty69 GauntletGreen'
    'RetroHursty69 GexGreen'
    'RetroHursty69 GhoulsNGhostsGreen'
    'RetroHursty69 GodOfWarGreen'
    'RetroHursty69 GrimFandangoGreen'
    'RetroHursty69 HalfLifeGreen'
    'RetroHursty69 HaloGreen'    
    'RetroHursty69 HarleyQuinnGreen'
    'RetroHursty69 HulkGreen'
    'RetroHursty69 IncrediblesGreen'
    'RetroHursty69 IndianaJonesGreen'
    'RetroHursty69 IronManGreen'
    'RetroHursty69 JetSetRadioGreen'
    'RetroHursty69 KOFGreen'
    'RetroHursty69 KillerInstinctGreen'
    'RetroHursty69 KingKRoolGreen'    
    'RetroHursty69 KingdomHeartsGreen'
    'RetroHursty69 KirbyGreen'
    'RetroHursty69 LegoGreen'
    'RetroHursty69 LittleBigPlanetGreen'
    'RetroHursty69 LuigiGreen'
    'RetroHursty69 ManiacMansionGreen'
    'RetroHursty69 MarioGreen'
    'RetroHursty69 MatrixGreen'
    'RetroHursty69 MegaManGreen'
    'RetroHursty69 MetalSlugGreen'
    'RetroHursty69 MetroidGreen'
    'RetroHursty69 MickeyMouseGreen'    
    'RetroHursty69 MinecraftGreen'
    'RetroHursty69 MonkeyBallGreen'
    'RetroHursty69 MortalKombatGreen'
    'RetroHursty69 OddworldGreen'
    'RetroHursty69 OptimusPrimeGreen'
    'RetroHursty69 OutRunGreen'
    'RetroHursty69 PacmanGreen'
    'RetroHursty69 ParappaGreen'
    'RetroHursty69 PitfallGreen'
    'RetroHursty69 PikminGreen'
    'RetroHursty69 PokemonGreen'
    'RetroHursty69 PowerPuffGreen'
    'RetroHursty69 PredatorGreen'    
    'RetroHursty69 PrincePersiaGreen'
    'RetroHursty69 ProfessorLaytonGreen'
    'RetroHursty69 PunchOutGreen'
    'RetroHursty69 QBertGreen'
    'RetroHursty69 RactchetClankGreen'
    'RetroHursty69 RaymanGreen'
    'RetroHursty69 ResidentEvilGreen'
    'RetroHursty69 RidgeRacerGreen'
    'RetroHursty69 RoboCopGreen'
    'RetroHursty69 SF2Green'
    'RetroHursty69 SF3rdStrikeGreen'
    'RetroHursty69 ScoobyDooGreen'
    'RetroHursty69 ShenmueGreen'        
    'RetroHursty69 ShrekGreen'
    'RetroHursty69 SimCityGreen'
    'RetroHursty69 SimpsonsGreen'
    'RetroHursty69 SimsGreen'
    'RetroHursty69 SmashBrosGreen'
    'RetroHursty69 SmurfsGreen'
    'RetroHursty69 SonicGreen'
    'RetroHursty69 SoulCaliburGreen'
    'RetroHursty69 SouthParkGreen'
    'RetroHursty69 SpaceAceGreen'
    'RetroHursty69 SpaceChannel5Green'
    'RetroHursty69 SpaceInvadersGreen'
    'RetroHursty69 SpidermanGreen'
    'RetroHursty69 SplatoonGreen'
    'RetroHursty69 SplinterCellGreen'
    'RetroHursty69 SpongeBobGreen'
    'RetroHursty69 SpyroGreen'
    'RetroHursty69 StarFoxGreen'
    'RetroHursty69 StarWarsGreen'
    'RetroHursty69 StreetFighterGreen'
    'RetroHursty69 StreetsOfRageGreen'
    'RetroHursty69 SupermanGreen'
    'RetroHursty69 TMNTGreen'
    'RetroHursty69 TekkenGreen'
    'RetroHursty69 TerminatorGreen'
    'RetroHursty69 TetrisGreen'
    'RetroHursty69 ToadGreen'
    'RetroHursty69 TombRaiderGreen'
    'RetroHursty69 ToyStoryGreen'
    'RetroHursty69 TronGreen'
    'RetroHursty69 TwistedMetalGreen'
    'RetroHursty69 VirtuaFighterGreen'
    'RetroHursty69 WWEGreen'
    'RetroHursty69 WaluigiGreen'
    'RetroHursty69 WarioGreen'
    'RetroHursty69 WormsGreen'
    'RetroHursty69 XMenGreen'
    'RetroHursty69 YoshiGreen'
    'RetroHursty69 ZeldaGreen'
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
            *)  #install or update themes
                theme=(${themes[choice-1]})
                repo="${theme[0]}"
                theme="${theme[1]}"
#                if [[ "${status[choice]}" == "i" ]]; then
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

function chromeyneon_themes() {
    local themes=(
    'RetroHursty69 1943Neon'
    'RetroHursty69 AladdinNeon'
    'RetroHursty69 AlexKiddNeon'
    'RetroHursty69 AngryBirdsNeon'
    'RetroHursty69 AntManNeon'
    'RetroHursty69 AquamanNeon'
    'RetroHursty69 AsteroidsNeon'
    'RetroHursty69 AstroBoyNeon'
    'RetroHursty69 BatmanNeon'
    'RetroHursty69 BombermanNeon'
    'RetroHursty69 BubbleBobbleNeon'
    'RetroHursty69 BumbleBeeNeon'
    'RetroHursty69 CaptainAmericaNeon'
    'RetroHursty69 DarkstalkersNeon'
    'RetroHursty69 DayTentacleNeon'
    'RetroHursty69 DaytonaUsaNeon'
    'RetroHursty69 DeadpoolNeon'
    'RetroHursty69 DigimonNeon'
    'RetroHursty69 DonkeyKongCountryNeon'
    'RetroHursty69 DonkeyKongNeon'
    'RetroHursty69 DrMarioNeon'
    'RetroHursty69 DragonBallZNeon'
    'RetroHursty69 DragonsLairNeon'
    'RetroHursty69 DukeNukemNeon'
    'RetroHursty69 ETNeon'
    'RetroHursty69 EarthwormJimNeon'    
    'RetroHursty69 ElevatorActionNeon'
    'RetroHursty69 FZeroNeon'    
    'RetroHursty69 FalloutNeon'
    'RetroHursty69 FatalFuryNeon'
    'RetroHursty69 FinalFantasyNeon'
    'RetroHursty69 FinalFightNeon'        
    'RetroHursty69 FortniteNeon'
    'RetroHursty69 FroggerNeon'
    'RetroHursty69 FullThrottleNeon'
    'RetroHursty69 GTANeon'
    'RetroHursty69 GalagaNeon'
    'RetroHursty69 GalaxianNeon'
    'RetroHursty69 GameAndWatchNeon'
    'RetroHursty69 GarfieldNeon'
    'RetroHursty69 GauntletNeon'
    'RetroHursty69 GexNeon'
    'RetroHursty69 GhoulsNGhostsNeon'
    'RetroHursty69 GodOfWarNeon'
    'RetroHursty69 GrimFandangoNeon'
    'RetroHursty69 HalfLifeNeon'
    'RetroHursty69 HaloNeon'    
    'RetroHursty69 HarleyQuinnNeon'
    'RetroHursty69 HulkNeon'
    'RetroHursty69 IncrediblesNeon'
    'RetroHursty69 IndianaJonesNeon'
    'RetroHursty69 IronManNeon'
    'RetroHursty69 JetSetRadioNeon'
    'RetroHursty69 KOFNeon'
    'RetroHursty69 KillerInstinctNeon'
    'RetroHursty69 KingKRoolNeon'    
    'RetroHursty69 KingdomHeartsNeon'
    'RetroHursty69 KirbyNeon'
    'RetroHursty69 LegoNeon'
    'RetroHursty69 LittleBigPlanetNeon'
    'RetroHursty69 LuigiNeon'
    'RetroHursty69 ManiacMansionNeon'
    'RetroHursty69 MarioNeon'
    'RetroHursty69 MatrixNeon'
    'RetroHursty69 MegaManNeon'
    'RetroHursty69 MetalSlugNeon'
    'RetroHursty69 MetroidNeon'
    'RetroHursty69 MickeyMouseNeon'    
    'RetroHursty69 MinecraftNeon'
    'RetroHursty69 MonkeyBallNeon'
    'RetroHursty69 MortalKombatNeon'
    'RetroHursty69 OddworldNeon'
    'RetroHursty69 OptimusPrimeNeon'
    'RetroHursty69 OutRunNeon'
    'RetroHursty69 PacmanNeon'
    'RetroHursty69 ParappaNeon'
    'RetroHursty69 PitfallNeon'
    'RetroHursty69 PikminNeon'
    'RetroHursty69 PokemonNeon'
    'RetroHursty69 PowerPuffNeon'
    'RetroHursty69 PredatorNeon'    
    'RetroHursty69 PrincePersiaNeon'
    'RetroHursty69 ProfessorLaytonNeon'
    'RetroHursty69 PunchOutNeon'
    'RetroHursty69 QBertNeon'
    'RetroHursty69 RactchetClankNeon'
    'RetroHursty69 RaymanNeon'
    'RetroHursty69 ResidentEvilNeon'
    'RetroHursty69 RidgeRacerNeon'
    'RetroHursty69 RoboCopNeon'
    'RetroHursty69 SF2Neon'
    'RetroHursty69 SF3rdStrikeNeon'
    'RetroHursty69 ScoobyDooNeon'
    'RetroHursty69 ShenmueNeon'        
    'RetroHursty69 ShrekNeon'
    'RetroHursty69 SimCityNeon'
    'RetroHursty69 SimpsonsNeon'
    'RetroHursty69 SimsNeon'
    'RetroHursty69 SmashBrosNeon'
    'RetroHursty69 SmurfsNeon'
    'RetroHursty69 SonicNeon'
    'RetroHursty69 SoulCaliburNeon'
    'RetroHursty69 SouthParkNeon'
    'RetroHursty69 SpaceAceNeon'
    'RetroHursty69 SpaceChannel5Neon'
    'RetroHursty69 SpaceInvadersNeon'
    'RetroHursty69 SpidermanNeon'
    'RetroHursty69 SplatoonNeon'
    'RetroHursty69 SplinterCellNeon'
    'RetroHursty69 SpongeBobNeon'
    'RetroHursty69 SpyroNeon'
    'RetroHursty69 StarFoxNeon'
    'RetroHursty69 StarWarsNeon'
    'RetroHursty69 StreetFighterNeon'
    'RetroHursty69 StreetsOfRageNeon'
    'RetroHursty69 SupermanNeon'
    'RetroHursty69 TMNTNeon'
    'RetroHursty69 TekkenNeon'
    'RetroHursty69 TerminatorNeon'
    'RetroHursty69 TetrisNeon'
    'RetroHursty69 ToadNeon'
    'RetroHursty69 TombRaiderNeon'
    'RetroHursty69 ToyStoryNeon'
    'RetroHursty69 TronNeon'
    'RetroHursty69 TwistedMetalNeon'
    'RetroHursty69 VirtuaFighterNeon'
    'RetroHursty69 WWENeon'
    'RetroHursty69 WaluigiNeon'
    'RetroHursty69 WarioNeon'
    'RetroHursty69 WormsNeon'
    'RetroHursty69 XMenNeon'
    'RetroHursty69 YoshiNeon'
    'RetroHursty69 ZeldaNeon'
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
            *)  #install or update themes
                theme=(${themes[choice-1]})
                repo="${theme[0]}"
                theme="${theme[1]}"
#                if [[ "${status[choice]}" == "i" ]]; then
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

function hurstypicks_themes() {
    local themes=(
    'RetroHursty69 bluray'
    'RetroHursty69 boxalloyblue'
    'RetroHursty69 boxalloyred'
    'RetroHursty69 cardcrazy'
    'RetroHursty69 circuit'
    'RetroHursty69 corg'
    'RetroHursty69 CosmicRise'
    'RetroHursty69 fabuloso'
    'RetroHursty69 floyd'
    'RetroHursty69 greenilicious'
    'RetroHursty69 heychromey'
    'RetroHursty69 hurstybluetake2'
    'RetroHursty69 lightswitch'
    'RetroHursty69 HyperLuigi'
    'RetroHursty69 HyperMario'        
    'RetroHursty69 magazinemadness'
    'RetroHursty69 magazinemadness2'
    'RetroHursty69 marco'
    'RetroHursty69 mariobrosiii'
    'RetroHursty69 meshy'
    'RetroHursty69 retroroid'
    'RetroHursty69 Slick_Red'
    'RetroHursty69 soda'
    'RetroHursty69 stirling'
    'RetroHursty69 supersweet'
    'RetroHursty69 swatch'
    'RetroHursty69 uniflyered'
    'RetroHursty69 whiteslide'
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
            *)  #install or update themes
                theme=(${themes[choice-1]})
                repo="${theme[0]}"
                theme="${theme[1]}"
#                if [[ "${status[choice]}" == "i" ]]; then
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

function handheld_themes() {
    local themes=(
    'RetroHursty69 BlurayGameHat'
    'RetroHursty69 CarbonGameHat'
    'RetroHursty69 CardCrazyGameHat'
    'RetroHursty69 ChromeyGameHat'
    'RetroHursty69 CircuitGameHat'
    'RetroHursty69 MagazineMadnessGameHat'
    'RetroHursty69 NegativeGameHat'
    'RetroHursty69 RetroroidGameHat'
    'RetroHursty69 SodaGameHat'
    'RetroHursty69 SublimeGameHat'
    'RetroHursty69 SweetBlueGameHat'
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
            *)  #install or update themes
                theme=(${themes[choice-1]})
                repo="${theme[0]}"
                theme="${theme[1]}"
#                if [[ "${status[choice]}" == "i" ]]; then
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
function slick_themes() {
    local themes=(
    'RetroHursty69 Slick_Blue'
    'RetroHursty69 Slick_BlueCube'
    'RetroHursty69 Slick_Bluey'
    'RetroHursty69 Slick_Brick'
    'RetroHursty69 Slick_Brush'
    'RetroHursty69 Slick_Bubble'
    'RetroHursty69 Slick_Castle'
    'RetroHursty69 Slick_CheckerPlate'
    'RetroHursty69 Slick_CityHeights'
    'RetroHursty69 Slick_CityLights'
    'RetroHursty69 Slick_Dazzle'
    'RetroHursty69 Slick_Edge'
    'RetroHursty69 Slick_Fire'
    'RetroHursty69 Slick_Funk'
    'RetroHursty69 Slick_Green'
    'RetroHursty69 Slick_Haze'
    'RetroHursty69 Slick_Lime'
    'RetroHursty69 Slick_Orange'
    'RetroHursty69 Slick_Pacman'
    'RetroHursty69 Slick_Pink'
    'RetroHursty69 Slick_Red'
    'RetroHursty69 Slick_Sick'
    'RetroHursty69 Slick_Smash'
    'RetroHursty69 Slick_Snazzy'
    'RetroHursty69 Slick_Spinny'
    'RetroHursty69 Slick_Steel'
    'RetroHursty69 Slick_Sunset'
    'RetroHursty69 Slick_Swingin'
    'RetroHursty69 Slick_Swish'
    'RetroHursty69 Slick_Tech'
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
            *)  #install or update themes
                theme=(${themes[choice-1]})
                repo="${theme[0]}"
                theme="${theme[1]}"
#                if [[ "${status[choice]}" == "i" ]]; then
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

function hyper_themes() {
    local themes=(
    'RetroHursty69 HyperAladdin'
    'RetroHursty69 HyperAlexKidd'
    'RetroHursty69 HyperAmigo'        
    'RetroHursty69 HyperAngryBirds'
    'RetroHursty69 HyperAnimalCrossing'
    'RetroHursty69 HyperAntMan'
    'RetroHursty69 HyperAstaroth'        
    'RetroHursty69 HyperBanjo'
    'RetroHursty69 HyperBatman'
    'RetroHursty69 HyperBayonetta'
    'RetroHursty69 HyperBenGrimm'        
    'RetroHursty69 HyperBomberman'
    'RetroHursty69 HyperBubbleBobble'
    'RetroHursty69 HyperBubsy'
    'RetroHursty69 HyperC3PO'        
    'RetroHursty69 HyperCaptainAmerica'
    'RetroHursty69 HyperCastlevania'
    'RetroHursty69 HyperChewbacca'        
    'RetroHursty69 HyperChunLi'
    'RetroHursty69 HyperContra'
    'RetroHursty69 HyperCuphead'        
    'RetroHursty69 HyperCrashBandicoot'
    'RetroHursty69 HyperDarkstalkers'
    'RetroHursty69 HyperDarthVader'        
    'RetroHursty69 HyperDayTentacle'        
    'RetroHursty69 HyperDeadOrAlive'
    'RetroHursty69 HyperDeadPool'        
    'RetroHursty69 HyperDevilMayCry'
    'RetroHursty69 HyperDigDug'        
    'RetroHursty69 HyperDonkeyKong'
    'RetroHursty69 HyperDonkeyKongJr'
    'RetroHursty69 HyperDrEggman'
    'RetroHursty69 HyperFulgor'        
    'RetroHursty69 HyperFrogger'
    'RetroHursty69 HyperGodOfWar'        
    'RetroHursty69 HyperGTA1'
    'RetroHursty69 HyperGTA2'
    'RetroHursty69 HyperHalo'
    'RetroHursty69 HyperHanSolo'        
    'RetroHursty69 HyperHarleyQuinn'        
    'RetroHursty69 HyperHulk'
    'RetroHursty69 HyperIndianaJones'        
    'RetroHursty69 HyperIronMan'        
    'RetroHursty69 HyperIvy'        
    'RetroHursty69 HyperJakDaxter'        
    'RetroHursty69 HyperJinKazama'
    'RetroHursty69 HyperKirby'
    'RetroHursty69 HyperLink'
    'RetroHursty69 HyperKOF1'
    'RetroHursty69 HyperKOF2'
    'RetroHursty69 HyperKOF3'
    'RetroHursty69 HyperKOF4'
    'RetroHursty69 HyperKOF5'
    'RetroHursty69 HyperKOF6'
    'RetroHursty69 HyperKOF7'
    'RetroHursty69 HyperKOF8'
    'RetroHursty69 HyperKOF9'
    'RetroHursty69 HyperKOF10'
    'RetroHursty69 HyperKOF11'
    'RetroHursty69 HyperKOF12'
    'RetroHursty69 HyperKOF13'
    'RetroHursty69 HyperKOF14'
    'RetroHursty69 HyperKOF15'
    'RetroHursty69 HyperKOF16'
    'RetroHursty69 HyperKOF17'
    'RetroHursty69 HyperKOF18'
    'RetroHursty69 HyperKOF19'
    'RetroHursty69 HyperKOF20'
    'RetroHursty69 HyperLego'        
    'RetroHursty69 HyperLuigi'
    'RetroHursty69 HyperMameinaBox'
    'RetroHursty69 HyperMario'
    'RetroHursty69 HyperMitsurugi'        
    'RetroHursty69 HyperMK1'
    'RetroHursty69 HyperMK2'
    'RetroHursty69 HyperMK3'
    'RetroHursty69 HyperMK4'
    'RetroHursty69 HyperMK5'
    'RetroHursty69 HyperMK6'
    'RetroHursty69 HyperMK7'
    'RetroHursty69 HyperMK8'
    'RetroHursty69 HyperMK9'
    'RetroHursty69 HyperMK10'
    'RetroHursty69 HyperMK11'
    'RetroHursty69 HyperMK12'
    'RetroHursty69 HyperMK13'
    'RetroHursty69 HyperNeoCortex'
    'RetroHursty69 HyperNintendo1'
    'RetroHursty69 HyperNintendo2'
    'RetroHursty69 HyperNintendo3'
    'RetroHursty69 HyperNintendo4'
    'RetroHursty69 HyperNintendo5'
    'RetroHursty69 HyperNintendo6'
    'RetroHursty69 HyperNintendo7'
    'RetroHursty69 HyperNintendo8'
    'RetroHursty69 HyperNintendo9'
    'RetroHursty69 HyperNintendo10'
    'RetroHursty69 HyperNintendo11'
    'RetroHursty69 HyperNintendo12'
    'RetroHursty69 HyperNintendo13'
    'RetroHursty69 HyperNintendo14'
    'RetroHursty69 HyperNintendo15'
    'RetroHursty69 HyperNintendo16'
    'RetroHursty69 HyperNintendo17'
    'RetroHursty69 HyperNintendo18'
    'RetroHursty69 HyperNintendo19'
    'RetroHursty69 HyperNintendo20'
    'RetroHursty69 HyperNintendo21'
    'RetroHursty69 HyperNintendo22'
    'RetroHursty69 HyperNintendo23'
    'RetroHursty69 HyperNintendo24'
    'RetroHursty69 HyperNintendo25'
    'RetroHursty69 HyperNintendo26'
    'RetroHursty69 HyperNintendo27'
    'RetroHursty69 HyperNintendo28'
    'RetroHursty69 HyperNintendo29'
    'RetroHursty69 HyperNintendo30'
    'RetroHursty69 HyperNintendo31'
    'RetroHursty69 HyperNintendo32'
    'RetroHursty69 HyperNintendo33'
    'RetroHursty69 HyperNintendo34'
    'RetroHursty69 HyperNintendo35'
    'RetroHursty69 HyperNintendo36'
    'RetroHursty69 HyperNintendo37'
    'RetroHursty69 HyperNintendo38'
    'RetroHursty69 HyperNintendo39'
    'RetroHursty69 HyperNintendo40'
    'RetroHursty69 HyperNintendo41'
    'RetroHursty69 HyperNintendo42'
    'RetroHursty69 HyperNintendo43'
    'RetroHursty69 HyperNintendo44'
    'RetroHursty69 HyperNintendo45'
    'RetroHursty69 HyperNintendo46'
    'RetroHursty69 HyperNintendo47'
    'RetroHursty69 HyperNintendo48'
    'RetroHursty69 HyperNintendo49'
    'RetroHursty69 HyperNintendo50'        
    'RetroHursty69 HyperPacman'
    'RetroHursty69 HyperPayDay'
    'RetroHursty69 HyperR2D2'        
    'RetroHursty69 HyperRachet'
    'RetroHursty69 HyperRetroArena'        
    'RetroHursty69 HyperRyu'
    'RetroHursty69 HyperSackBoy'        
    'RetroHursty69 HyperScorpion'
    'RetroHursty69 HyperSonic'
    'RetroHursty69 HyperSpaceInvaders'
    'RetroHursty69 HyperSpiderman'
    'RetroHursty69 HyperSplinterCell'
    'RetroHursty69 HyperSpaceChannel5'        
    'RetroHursty69 HyperSpyro'
    'RetroHursty69 HyperStreetFighter1'
    'RetroHursty69 HyperStreetFighter2'
    'RetroHursty69 HyperStreetFighter3'
    'RetroHursty69 HyperStreetFighter4'
    'RetroHursty69 HyperStreetFighter5'
    'RetroHursty69 HyperStreetFighter6'
    'RetroHursty69 HyperStreetFighter7'
    'RetroHursty69 HyperStreetFighter8'
    'RetroHursty69 HyperStreetFighter9'
    'RetroHursty69 HyperStreetFighter10'
    'RetroHursty69 HyperStreetFighter11'
    'RetroHursty69 HyperTails'
    'RetroHursty69 HyperTaki'        
    'RetroHursty69 HyperTerryBogard'
    'RetroHursty69 HyperThor'        
    'RetroHursty69 HyperTMNT'
    'RetroHursty69 HyperToad'
    'RetroHursty69 HyperXMen1'
    'RetroHursty69 HyperXMen2'
    'RetroHursty69 HyperXMen3'
    'RetroHursty69 HyperXMen4'
    'RetroHursty69 HyperXMen5'
    'RetroHursty69 HyperXMen6'
    'RetroHursty69 HyperXMen7'
    'RetroHursty69 HyperXMen8'
    'RetroHursty69 HyperXMen9'
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
            *)  #install or update themes
                theme=(${themes[choice-1]})
                repo="${theme[0]}"
                theme="${theme[1]}"
#                if [[ "${status[choice]}" == "i" ]]; then
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

function mario_themes() {
    local themes=(
     'RetroHursty69 DrMarioSweet'
     'RetroHursty69 MarioBrosSweet'
     'RetroHursty69 MarioKartSweet'
     'RetroHursty69 MarioPartySweet'
     'RetroHursty69 PaperMarioSweet'
     'RetroHursty69 DrMarioCool'
     'RetroHursty69 MarioBrosCool'
     'RetroHursty69 MarioCool'
     'RetroHursty69 MarioKartCool'
     'RetroHursty69 MarioPartyCool'
     'RetroHursty69 DrMarioSpin'
     'RetroHursty69 MarioSpin'
     'RetroHursty69 mariobrosiii'
     'RetroHursty69 mario_melee'
     'RetroHursty69 DrMarioBlue'
     'RetroHursty69 MarioBlue'
     'RetroHursty69 DrMarioGreen'
     'RetroHursty69 MarioGreen'
     'RetroHursty69 DrMarioNeon'
     'RetroHursty69 MarioNeon'
     'RetroHursty69 mariobrosiii'
     'RetroHursty69 HyperMario'
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
            *)  #install or update themes
                theme=(${themes[choice-1]})
                repo="${theme[0]}"
                theme="${theme[1]}"
#                if [[ "${status[choice]}" == "i" ]]; then
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
