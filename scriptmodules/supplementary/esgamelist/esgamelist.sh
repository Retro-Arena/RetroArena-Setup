#!/bin/bash

IFS=';'

# Welcome
 dialog --backtitle "EmulationStation" --title "EmulationStation Gamelist Cleanup Utility" \
    --yesno "\nThis utility will perform a cleanup in your EmulationStation gamelist.xml file.\n\nThe cleanup utility will only work on gamelist.xml files located within the roms folder also.\n\nThe cleanup utility will perform an audit on the rom files you have installed versus what is listed in the gamelist.xml file.  It will remove all entries from a gamelist.xml file where there is no matching rom file.  This process will create a curated gamelist.xml file only containg entries for rom files it locates in the particular system rom folder.\n\nFor those systems with large romsets like MAME/FBA, the script will take awhile to run.\n\nYou can monitor it's progress with this file:  /tmp/remove.txt\n\n---You must restart EmulationStation after making these changes---\n\nWARNING: Always make a backup copy of your gamelist.xml and media files before making changes to your system.\n\n\nDo you want to proceed?" \
    35 85 2>&1 > /dev/tty \
    || exit

function main_menu() {
    local choice

    while true; do
        choice=$(dialog --backtitle "$BACKTITLE" --title " MAIN MENU " \
            --ok-label OK --cancel-label Exit \
            --menu "Which rom folder gamelist.xml file do you wish to clean up?" 25 75 20 \
            1 "3do" \
            2 "amiga" \
            3 "amstradcpc" \
            4 "apple2" \
			5 "apple2gs" \
            6 "arcade" \
            7 "atari2600" \
            8 "atari5200" \
            9 "atari7800" \
            10 "atari800" \
            11 "atarijaguar" \
            12 "atarilynx" \
            13 "atarist" \
			14 "atomiswave" \
            15 "c64" \
            16 "c128" \
            17 "coco" \
            18 "coleco" \
            19 "daphne" \
            20 "dragon32" \
            21 "dreamcast" \
            22 "famicom" \
            23 "fba" \
            24 "fds" \
			25 "fm7" \
            26 "gameandwatch" \
            27 "gamegear" \
            28 "gb" \
            29 "gba" \
            30 "gbc" \
            31 "intellivision" \
            32 "mame-advmame" \
            33 "mame-libretro" \
            34 "mame-mame4all" \
            35 "markiii" \
            36 "mastersystem" \
            37 "megadrive" \
            38 "megadrive-japan" \
            39 "msx" \
            40 "msx2" \
			41 "naomi" \
            42 "n64" \
            43 "nds" \
            44 "neogeo" \
            45 "nes" \
            46 "ngp" \
            47 "ngpc" \
			48 "odyssey2" \
            49 "oric" \
			50 "openbor" \
            51 "pc" \
            52 "pc88" \
            53 "pc98" \
            54 "pce-cd" \
            55 "pcengine" \
            56 "pcfx" \
            57 "psp" \
            58 "pspminis" \
            59 "psx" \
            60 "plus4" \
			61 "pokemini" \
			62 "samcoupe" \
            63 "satellaview" \
            64 "saturn" \
            65 "sc-3000" \
            66 "scummvm" \
            67 "sega32x" \
            68 "segacd" \
            69 "sfc" \
            70 "sg-1000" \
            71 "sgb" \
            72 "snes" \
            73 "snesmsu1" \
            74 "sufami" \
            75 "supergrafx" \
            76 "tg16" \
            77 "tg-cd" \
            78 "ti99" \
            79 "trs-80" \
            80 "vectrex" \
			81 "vic20" \
            82 "videopac" \
            83 "virtualboy" \
            84 "wonderswan" \
            85 "wonderswancolor" \
			86 "x1" \
            87 "x68000" \
            88 "zmachine" \
            89 "zx81" \
            90 "zxspectrum" \
			91 "ports" \
			92 "genesis" \
            2>&1 > /dev/tty)

        case "$choice" in
            1) clean_gamelist "3do" ;;
            2) clean_gamelist "amiga" ;;
            3) clean_gamelist "amstradcpc" ;;
            4) clean_gamelist "apple2" ;;
			5) clean_gamelist "apple2gs" ;;
            6) clean_gamelist "arcade" ;;
            7) clean_gamelist "atari2600" ;;
            8) clean_gamelist "atari5200" ;;
            9) clean_gamelist "atari7800" ;;
            10) clean_gamelist "atari800" ;;
            11) clean_gamelist "atarijaguar" ;;
            12) clean_gamelist "atarilynx" ;;
            13) clean_gamelist "atarist" ;;
			14) clean_gamelist "atomiswave" ;;
            15) clean_gamelist "c64" ;;
			16) clean_gamelist "c128" ;;
            17) clean_gamelist "coco" ;;
            18) clean_gamelist "coleco" ;;
            19) clean_gamelist "daphne" ;;
            20) clean_gamelist "dragon32" ;;
            21) clean_gamelist "dreamcast" ;;
            22) clean_gamelist "famicom" ;;
            23) clean_gamelist "fba" ;;
            24) clean_gamelist "fds" ;;
			25) clean_gamelist "fm7" ;;
            26) clean_gamelist "gameandwatch" ;;
            27) clean_gamelist "gamegear" ;;
            28) clean_gamelist "gb" ;;
            29) clean_gamelist "gba" ;;
            30) clean_gamelist "gbc" ;;
            31) clean_gamelist "intellivision" ;;
            32) clean_gamelist "mame-advmame" ;;
            33) clean_gamelist "mame-libretro" ;;
            34) clean_gamelist "mame-mame4all" ;;
            35) clean_gamelist "markiii" ;;
            36) clean_gamelist "mastersystem" ;;
            37) clean_gamelist "megadrive" ;;
            38) clean_gamelist "megadrive-japan" ;;
            39) clean_gamelist "msx" ;;
            40) clean_gamelist "msx2" ;;
			41) clean_gamelist "naomi" ;;
            42) clean_gamelist "n64" ;;
            43) clean_gamelist "nds" ;;
            44) clean_gamelist "neogeo" ;;
            45) clean_gamelist "nes" ;;
            46) clean_gamelist "ngp" ;;
            47) clean_gamelist "ngpc" ;;
			48) clean_gamelist "odyssey2" ;;
            49) clean_gamelist "oric" ;;
			50) clean_gamelist "openbor" ;;
            51) clean_gamelist "pc" ;;
            52) clean_gamelist "pc88" ;;
            53) clean_gamelist "pc98" ;;
            54) clean_gamelist "pce-cd" ;;
            55) clean_gamelist "pcengine" ;;
            56) clean_gamelist "pcfx" ;;
            57) clean_gamelist "psp" ;;
            58) clean_gamelist "pspminis" ;;
            59) clean_gamelist "psx" ;;
            60) clean_gamelist "plus4" ;;
			61) clean_gamelist "pokemini" ;;
			62) clean_gamelist "samcoupe" ;;
            63) clean_gamelist "satellaview" ;;
            64) clean_gamelist "saturn" ;;
            65) clean_gamelist "sc-3000" ;;
            66) clean_gamelist "scummvm" ;;
            67) clean_gamelist "sega32x" ;;
            68) clean_gamelist "segacd" ;;
            69) clean_gamelist "sfc" ;;
            70) clean_gamelist "sg-1000" ;;
            71) clean_gamelist "sgb" ;;
            72) clean_gamelist "snes" ;;
            73) clean_gamelist "snesmsu1" ;;
            74) clean_gamelist "sufami" ;;
            75) clean_gamelist "supergrafx" ;;
            76) clean_gamelist "tg16" ;;
            77) clean_gamelist "tg-cd" ;;
            78) clean_gamelist "ti99" ;;
            79) clean_gamelist "trs-80" ;;
            80) clean_gamelist "vectrex" ;;
			81) clean_gamelist "vic20" ;;
            82) clean_gamelist "videopac" ;;
            83) clean_gamelist "virtualboy" ;;
            84) clean_gamelist "wonderswan" ;;
            85) clean_gamelist "wonderswancolor" ;;
			86) clean_gamelist "x1" ;;
            87) clean_gamelist "x68000" ;;
            88) clean_gamelist "zmachine" ;;
            89) clean_gamelist "zx81" ;;
            90) clean_gamelist "zxspectrum" ;;
			91) clean_gamelist "ports" ;;
			92) clean_gamelist "genesis" ;;
            *) break ;;
        esac
    done
}

function clean_gamelist() {
  dialog --infobox "...processing..." 3 20 ; sleep 2
  system=$1
  gamelist_dir="/home/pigaming/RetroArena/roms/${system}"
  original_gamelist="${gamelist_dir}/gamelist.xml"
  clean_gamelist="${gamelist_dir}/gamelist.xml-clean"

  cp "${original_gamelist}" "${original_gamelist}.bkp"
  cat "$original_gamelist" > "$clean_gamelist" 

  while read -r path; do
    full_path="$path"
    [[ "$path" == ./* ]] && full_path="${gamelist_dir}/$path"
    full_path="$(echo "$full_path" | sed 's/&amp;/\&/g')"
    [[ -f "$full_path" ]] && continue

    xmlstarlet ed -L -d "/gameList/game[path=\"$path\"]" "$clean_gamelist"
    echo "The game with <path> = \"$path\" has been removed from xml." >> /tmp/removed.txt
  done < <(xmlstarlet sel -t -v "/gameList/game/path" "$original_gamelist"; echo)

  cp "${clean_gamelist}" "${original_gamelist}"
}



# Main

main_menu
