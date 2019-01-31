#!/bin/bash

IFS=';'

# Welcome
 dialog --backtitle "RetroArena" --title "Media Removal Utility" \
    --yesno "\nThis utility will remove extra media files (boxart, cartart, snap, and wheel) for a chosen system where there is not a matching game for it.\n\nIf you keep your media for MAME or Final Burn Alpha in the /roms/arcade folder, there is a special choice just for that.\n\nThis script expects you to be using the following media folders.\n\nboxart\ncartart\nsnap\nwheel\n\nWARNING: Always make a backup copy of your SD card and your roms and media files before making changes to your system.\n\n\nDo you want to proceed?" \
    25 80 2>&1 > /dev/tty \
    || exit


function main_menu() {
    local choice

    while true; do
        choice=$(dialog --backtitle "$BACKTITLE" --title " MAIN MENU " \
            --ok-label OK --cancel-label Exit \
            --menu "Which rom media folders do you wish to clean up?" 25 75 20 \
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
            24 "fba (media in arcade)" \
            25 "fds" \
			26 "fm7" \
            27 "gameandwatch" \
            28 "gamegear" \
            29 "gb" \
            30 "gba" \
            31 "gbc" \
            32 "genesis" \
            33 "intellivision" \
            34 "mame-advmame" \
            35 "mame-advmame (media in arcade)" \
            36 "mame-libretro" \
            37 "mame-libretro (media in arcade)" \
            38 "mame-mame4all" \
            39 "mame-mame4all (media in arcade)" \
			40 "markiii" \
            41 "mastersystem" \
            42 "megadrive" \
            43 "megadrive-japan" \
            44 "msx" \
            45 "msx2" \
			46 "naomi" \
            47 "n64" \
            48 "nds" \
            49 "neogeo" \
            50 "nes" \
            51 "ngp" \
            52 "ngpc" \
			53 "odyssey2" \
            54 "oric" \
			55 "openbor" \
            56 "pc" \
			57 "pc88" \
			58 "pc98" \
            59 "pce-cd" \
            60 "pcengine" \
			61 "pcfx" \
            62 "psp" \
            63 "pspminis" \
            64 "psx" \
            65 "plus4" \
			66 "pokemini" \
			67 "samcoupe" \
			68 "satellaview" \
			69 "saturn" \
			70 "sc-3000" \
            71 "scummvm" \
			72 "sega32x" \
            73 "segacd" \
            74 "sfc" \
            75 "sg-1000" \
			76 "sgb" \
            77 "snes" \
			78 "snesmsu1" \
			79 "sufami" \
            80 "supergrafx" \
            81 "tg16" \
            82 "tg-cd" \
            83 "ti99" \
            84 "trs-80" \
			85 "vic-20" \
            86 "vectrex" \
            87 "videopac" \
            88 "virtualboy" \
            89 "wonderswan" \
            90 "wonderswancolor" \
			91 "x1" \
            92 "x68000" \
            93 "zmachine" \
			94 "zx81" \
            95 "zxspectrum" \
			96 "ports" \
            999 "Exit script" \
            2>&1 > /dev/tty)

        case "$choice" in
            1) remove_media "3do" ;;
			2) remove_media "amiga" ;;
			3) remove_media "amstradcpc" ;;
            4) remove_media "apple2" ;;
			5) remove_media "apple2gs" ;;
			6) remove_media "arcade" ;;
            7) remove_media "atari2600" ;;
            8) remove_media "atari5200" ;;
            9) remove_media "atari7800" ;;
            10) remove_media "atari800" ;;
			11) remove_media "atarijaguar" ;;
            12) remove_media "atarilynx" ;;
            13) remove_media "atarist" ;;
			14) remove_media "atomiswave" ;;
            15) remove_media "c64" ;;
			16) remove_media "c128" ;;
            17) remove_media "coco" ;;
            18) remove_media "coleco" ;;
            19) remove_media "daphne" ;;
            20) remove_media "dragon32" ;;
            21) remove_media "dreamcast" ;;
            22) remove_media "famicom" ;;
            23) remove_media "fba" ;;
            24) remove_media_arcade "fba" ;;
            25) remove_media "fds" ;;
			26) remove_media "fm7" ;;
            27) remove_media "gameandwatch" ;;
            28) remove_media "gamegear" ;;
            29) remove_media "gb" ;;
            30) remove_media "gba" ;;
            31) remove_media "gbc" ;;
            32) remove_media "genesis" ;;
            33) remove_media "intellivision" ;;
            34) remove_media "mame-advmame" ;;
            35) remove_media_arcade "mame-advmame" ;;
            36) remove_media "mame-libretro" ;;
            37) remove_media_arcade "mame-libretro" ;;
            38) remove_media "mame-mame4all" ;;
            39) remove_media_arcade "mame-mame4all" ;;
			40) remove_media "markiii" ;;
            41) remove_media "mastersystem" ;;
            42) remove_media "megadrive" ;;
            43) remove_media "megadrive-japan" ;;
            44) remove_media "msx" ;;
            45) remove_media "msx2" ;;
			46) remove_media "naomi" ;;
            47) remove_media "n64" ;;
            48) remove_media "nds" ;;
            49) remove_media "neogeo" ;;
            50) remove_media "nes" ;;
            51) remove_media "ngp" ;;
            52) remove_media "ngpc" ;;
			53) remove_media "odyssey2" ;;
            54) remove_media "oric" ;;
			55) remove_media "openbor" ;;
            56) remove_media "pc" ;;
			57) remove_media "pc88" ;;
			58) remove_media "pc98" ;;
            59) remove_media "pce-cd" ;;
            60) remove_media "pcengine" ;;
			61) remove_media "pcfx" ;;
            62) remove_media "psp" ;;
            63) remove_media "pspminis" ;;
            64) remove_media "psx" ;;
			65) remove_media "plus4" ;;
            66) remove_media "pokemini" ;;
			67) remove_media "samcoupe" ;;
			68) remove_media "satellaview" ;;
			69) remove_media "saturn" ;;
			70) remove_media "sc-3000" ;;
            71) remove_media "scummvm" ;;
            72) remove_media "sega32x" ;;
            73) remove_media "segacd" ;;
            74) remove_media "sfc" ;;
            75) remove_media "sg-1000" ;;
			76) remove_media "sgb" ;;
            77) remove_media "snes" ;;
			78) remove_media "snesmsu1" ;;
			79) remove_media "sufami" ;;
			80) remove_media "supergrafx" ;;
            81) remove_media "tg16" ;;
            82) remove_media "tg-cd" ;;
            83) remove_media "ti99" ;;
            84) remove_media "trs-80" ;;
			85) remove_media "vic20" ;;
            86) remove_media "vectrex" ;;
            87) remove_media "videopac" ;;
            88) remove_media "virtualboy" ;;
            89) remove_media "wonderswan" ;;
            90) remove_media "wonderswancolor" ;;
			91) remove_media "x1" ;;
            92) remove_media "x68000" ;;
            93) remove_media "zmachine" ;;
			94) remove_media "zx81" ;;
			95) remove_media "zxspectrum" ;;
			96) remove_media "ports" ;;
            999) exit ;;
            *)  break ;;
        esac
    done
}

function remove_media() {
dialog --infobox "...processing..." 3 20 ; sleep 2
choice=$1
directory="/home/pigaming/RetroArena/roms/${choice}"

ls "${directory}/boxart" | sed -e 's/\.jpg$//' | sed -e 's/\.png$//' > /tmp/boxart.txt
ls "${directory}/cartart" | sed -e 's/\.jpg$//' | sed -e 's/\.png$//' > /tmp/cartart.txt
ls "${directory}/snap" | sed -e 's/\.mp4$//' > /tmp/snap.txt
ls "${directory}/wheel" | sed -e 's/\.jpg$//' | sed -e 's/\.png$//' > /tmp/wheel.txt

rm /tmp/remove_media.sh 2> /dev/null

while read bname
do
ifexist=`ls "${directory}" |grep "${bname}"`
if [[ -z $ifexist ]]
then
echo "rm \"${directory}/boxart/${bname}.png\"" >> /tmp/remove_media.sh
echo "rm \"${directory}/boxart/${bname}.jpg\"" >> /tmp/remove_media.sh
fi
done < /tmp/boxart.txt

while read cname
do
ifexist=`ls "${directory}" |grep "${cname}"`
if [[ -z $ifexist ]]
then
echo "rm \"${directory}/cartart/${cname}.png\"" >> /tmp/remove_media.sh
echo "rm \"${directory}/cartart/${cname}.jpg\"" >> /tmp/remove_media.sh
fi
done < /tmp/cartart.txt

while read sname
do
ifexist=`ls "${directory}" |grep "${sname}"`
if [[ -z $ifexist ]]
then
echo "rm \"${directory}/snap/${sname}.mp4\"" >> /tmp/remove_media.sh
fi
done < /tmp/snap.txt

while read wname
do
ifexist=`ls "${directory}" |grep "${wname}"`
if [[ -z $ifexist ]]
then
echo "rm \"${directory}/wheel/${wname}.png\""  >> /tmp/remove_media.sh
echo "rm \"${directory}/wheel/${wname}.jpg\""  >> /tmp/remove_media.sh
fi
done < /tmp/wheel.txt

#execute the removal
chmod 777 /tmp/remove_media.sh
/tmp/remove_media.sh
rm /tmp/remove_media.sh
}

function remove_media_arcade() {
dialog --infobox "...processing..." 3 20 ; sleep 2
choice=$1
arcade="/home/pigaming/RetroArena/roms/arcade"
directory="/home/pigaming/RetroArena/roms/${choice}"

ls "${arcade}/boxart" | sed -e 's/\.jpg$//' | sed -e 's/\.png$//' > /tmp/boxart.txt
ls "${arcade}/cartart" | sed -e 's/\.jpg$//' | sed -e 's/\.png$//' > /tmp/cartart.txt
ls "${arcade}/snap" | sed -e 's/\.mp4$//' > /tmp/snap.txt
ls "${arcade}/wheel" | sed -e 's/\.jpg$//' | sed -e 's/\.png$//' > /tmp/wheel.txt

rm /tmp/remove_media.sh 2> /dev/null

while read bname
do
ifexist=`ls "${directory}" |grep "${bname}"`
if [[ -z $ifexist ]]
then
echo "rm \"${arcade}/boxart/${bname}.png\"" >> /tmp/remove_media.sh
echo "rm \"${arcade}/boxart/${bname}.jpg\"" >> /tmp/remove_media.sh
fi
done < /tmp/boxart.txt

while read cname
do
ifexist=`ls "${directory}" |grep "${cname}"`
if [[ -z $ifexist ]]
then
echo "rm \"${arcade}/cartart/${cname}.png\"" >> /tmp/remove_media.sh
echo "rm \"${arcade}/cartart/${cname}.jpg\"" >> /tmp/remove_media.sh
fi
done < /tmp/cartart.txt

while read sname
do
ifexist=`ls "${directory}" |grep "${sname}"`
if [[ -z $ifexist ]]
then
echo "rm \"${arcade}/snap/${sname}.mp4\"" >> /tmp/remove_media.sh
fi
done < /tmp/snap.txt

while read wname
do
ifexist=`ls "${directory}" |grep "${wname}"`
if [[ -z $ifexist ]]
then
echo "rm \"${arcade}/wheel/${wname}.png\""  >> /tmp/remove_media.sh
echo "rm \"${arcade}/wheel/${wname}.jpg\""  >> /tmp/remove_media.sh
fi
done < /tmp/wheel.txt

#execute the removal
chmod 777 /tmp/remove_media.sh
/tmp/remove_media.sh
rm /tmp/remove_media.sh
}


# Main

main_menu
