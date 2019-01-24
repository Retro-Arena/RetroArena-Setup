#!/bin/bash

IFS=';'

# Welcome
 dialog --backtitle "EmulationStation" --title " EmulationStation Collection List Generator" \
    --yesno "\nThis will add or update the custom collection gamelist that will be used to show games in the custom collections menu items.\n\nPeriodically, as you add and remove roms, re-run this script to keep the gamelists updated.\n\nThis script is only usable if your rom filenames are named according to the No Intro/Hyperspin/EmuMovies naming standard.\n\nAfter adding a new collection list, restart EmulationStation.\n\nThen press START > GAME COLLECTION SETTINGS > CUSTOM GAME COLLECTIONS.\n\nThen enable the new custom collections you wish to see on the menu.\n\nSome themes support collections on the main menu, otherwise you will find them under the Custom Collection menu item.\n\n\n**NOTE**\nThis utility only works with rom files using the No-Intro naming convention (like Emumovies/Hyperspin).\n\n\nDo you want to proceed?" \
    35 80 2>&1 > /dev/tty \
    || exit


function main_menu() {
    local choice

    while true; do
        choice=$(dialog --backtitle "$BACKTITLE" --title " MAIN MENU " \
            --ok-label OK --cancel-label Exit \
            --menu "What collection list do you want to add/update?" 25 75 20 \
            1 "Atari Classics" \
            2 "Banpresto Classics" \
            3 "Barbie Collection" \
            4 "Baseball Collection" \
            5 "Basketball Collection" \
            6 "Batman Collection" \
            7 "Beatem Up Collection" \
            8 "Biking Collection" \
            9 "BMX Collection" \
            10 "Bomberman Collection" \
            11 "Boulder Dash Collection" \
            12 "Bowling Collection" \
            13 "Boxing Collection" \
            14 "Bubble Bobble Collection" \
            15 "Bubsy Collection" \
            16 "Capcom Classics" \
            17 "Castlevania Collection" \
            18 "Cave Classics" \
            19 "Chess Collection" \
            20 "Capcom Play System I" \
            21 "Capcom Play System II" \
            22 "Capcom Play System III" \
            23 "Crash Bandicoot Collection" \
            24 "Darius Collection" \
            25 "Data East Collection" \
            26 "Disney Collection" \
            27 "Donkey Kong Collection" \
            28 "Double Dragon Collection" \
            29 "Earthworm Jim Collection" \
            30 "Fatal Fury Collection" \
            31 "Final Fantasy Collection" \
            32 "Final Fight Collection" \
            33 "Fishing Collection" \
            34 "Football Collection" \
            35 "Frogger Collection" \
            36 "Ghouls n Ghosts Collection" \
            37 "Golf Collection" \
            38 "Handball Collection" \
            39 "Hockey Collection" \
            40 "Indiana Jones Collection" \
            41 "Irem Classics" \
            42 "James Bond Collection" \
            43 "Joust Collection" \
            44 "King of Fighters Collection" \
            45 "Konami Classics" \
            46 "LEGO Collection" \
            47 "Lemmings Collection" \
            48 "Lightgun Classics" \
            49 "Lord of the Rings Collection" \
            50 "Mario Collection" \
            51 "Megaman Collection" \
            52 "Metal Slug Collection" \
            53 "Metroid Collection" \
            54 "Midway Classics" \
            55 "Mortal Kombat Collection" \
            56 "Motocross Collection" \
            57 "Namco Classics" \
            58 "Nintendo Classics" \
            59 "Outrun Collection" \
            60 "Pacman Collection" \
            61 "Poly Game Master Classics" \
            62 "Pinball Collection" \
            63 "Pitfall Collection" \
            64 "Pokemon Collection" \
            65 "Psikyo Classics" \
            66 "Puzzle collection" \
            67 "Robotron Collection" \
            68 "Run and Gun Collection" \
            69 "Sega Classics" \
            70 "Sesame Street Collection" \
            71 "Shmups Collection" \
            72 "Simpsons Collection" \
            73 "Skateboarding Collection" \
            74 "Skiing Collection" \
            75 "SNK Classics" \
            76 "Snowboarding Collection" \
            77 "Soccer Collection" \
            78 "Sonic Collection" \
            79 "Space Invaders Collection" \
            80 "Spiderman Collection" \
            81 "Spongebob Collection" \
            82 "Star Wars Collection" \
            83 "Street Fighter Collection" \
            84 "Super Heroes Collection" \
            85 "Taito Classics" \
            86 "Tecmo Classics" \
            87 "Tennis Collection" \
            88 "Tetris Collection" \
            89 "TMNT Collection" \
            90 "Toki Collection" \
            91 "Track and Field Collection" \
            92 "Trackball Classics" \
            93 "Vector Classics" \
            94 "Volleyball Collection" \
            95 "Williams Classics" \
            96 "Wonderboy Collection" \
            97 "Wrestling Collection" \
            98 "X-Men Collection" \
            99 "Yu-Gi-Oh Collection" \
            100 "Zelda Collection" \
            2>&1 > /dev/tty)

        case "$choice" in
            1) create_list "atari" ;;
            2) create_list "banpresto" ;;
            3) create_list "barbie" ;;
            4) create_list "baseball" ;;
            5) create_list "basketball" ;;
            6) create_list "batman" ;;
            7) create_list "beatemup" ;;
            8) create_list "biking" ;;
            9) create_list "bmx" ;;
            10) create_list "bomberman" ;;
            11) create_list "boulderdash" ;;
            12) create_list "bowling" ;;
            13) create_list "boxing" ;;
            14) create_list "bubblebobble" ;;
            15) create_list "bubsy" ;;
            16) create_list "capcom" ;;
            17) create_list "castlevania" ;;
            18) create_list "cave" ;;
            19) create_list "chess" ;;
            20) create_list "cps1" ;;
            21) create_list "cps2" ;;
            22) create_list "cps3" ;;
            23) create_list "crashbandicoot" ;;
            24) create_list "darius" ;;
            25) create_list "dataeast" ;;
            26) create_list "disney" ;;
            27) create_list "donkeykong" ;;
            28) create_list "doubledragon" ;;
            29) create_list "earthwormjim" ;;
            30) create_list "fatalfury" ;;
            31) create_list "finalfantasy" ;;
            32) create_list "finalfight" ;;
            33) create_list "fishing" ;;
            34) create_list "football" ;;
            35) create_list "frogger" ;;
            36) create_list "ghoulsnghosts" ;;
            37) create_list "golf" ;;
            38) create_list "handball" ;;
            39) create_list "hockey" ;;
            40) create_list "indianajones" ;;
            41) create_list "irem" ;;
            42) create_list "jamesbond" ;;
            43) create_list "joust" ;;
            44) create_list "kof" ;;
            45) create_list "konami" ;;
            46) create_list "lego" ;;
            47) create_list "lemmings" ;;
            48) create_list "lightgun" ;;
            49) create_list "lordoftherings" ;;
            50) create_list "mario" ;;
            51) create_list "megaman" ;;
            52) create_list "metalslug" ;;
            53) create_list "metroid" ;;
            54) create_list "midway" ;;
            55) create_list "mortalkombat" ;;
            56) create_list "motocross" ;;
            57) create_list "namco" ;;
            58) create_list "nintendo" ;;
            59) create_list "outrun" ;;
            60) create_list "pacman" ;;
            61) create_list "pgm" ;;
            62) create_list "pinball" ;;
            63) create_list "pitfall" ;;
            64) create_list "pokemon" ;;
            65) create_list "psikyo" ;;
            66) create_list "puzzle" ;;
            67) create_list "robotron" ;;
            68) create_list "runandgun" ;;
            69) create_list "sega" ;;
            70) create_list "sesamestreet" ;;
            71) create_list "shmups" ;;
            72) create_list "simpsons" ;;
            73) create_list "skateboarding" ;;
            74) create_list "skiing" ;;
            75) create_list "snk" ;;
            76) create_list "snowboarding" ;;
            77) create_list "soccer" ;;
            78) create_list "sonic" ;;
            79) create_list "spaceinvaders" ;;
            80) create_list "spiderman" ;;
            81) create_list "spongebob" ;;
            82) create_list "starwars" ;;
            83) create_list "streetfighter" ;;
            84) create_list "superheroes" ;;
            85) create_list "taito" ;;
            86) create_list "tecmo" ;;
            87) create_list "tennis" ;;
            88) create_list "tetris" ;;
            89) create_list "tmnt" ;;
            90) create_list "toki" ;;
            91) create_list "trackandfield" ;;
            92) create_list "trackball" ;;
            93) create_list "vector" ;;
            94) create_list "volleyball" ;;
            95) create_list "williams" ;;
            96) create_list "wonderboy" ;;
            97) create_list "wrestling" ;;
            98) create_list "x-men" ;;
            99) create_list "yu-gi-oh" ;;
            100) create_list "zelda" ;;
            *)  break ;;
        esac
    done
}

function create_list() {
dialog --infobox "...processing..." 3 20 ; sleep 2
choice=$1
filename="${choice}.txt"

counter=0
while read gname romfolder
do

  if [[ $romfolder = "arcade" ]]; then
    ifexist=`ls /home/pigaming/RetroArena/roms/${romfolder} |grep -w "${gname}.zip"`
    if [[ -f "/home/pigaming/RetroArena/roms/${romfolder}/$ifexist" ]]; then
      echo "/home/pigaming/RetroArena/roms/${romfolder}/${ifexist}" >> /tmp/tempfile.cfg
    else
      :
    fi
  elif [[ $romfolder = "fba" ]]; then
    ifexist=`ls /home/pigaming/RetroArena/roms/${romfolder} |grep -w "${gname}.zip"`
    if [[ -f "/home/pigaming/RetroArena/roms/${romfolder}/$ifexist" ]]; then
      echo "/home/pigaming/RetroArena/roms/${romfolder}/${ifexist}" >> /tmp/tempfile.cfg
     else
      :
    fi
  elif [[ $romfolder = "mame-advmame" ]]; then
    ifexist=`ls /home/pigaming/RetroArena/roms/${romfolder} |grep -w "${gname}.zip"`
    if [[ -f "/home/pigaming/RetroArena/roms/${romfolder}/$ifexist" ]]; then
      echo "/home/pigaming/RetroArena/roms/${romfolder}/${ifexist}" >> /tmp/tempfile.cfg
     else
      :
    fi
  elif [[ $romfolder = "mame-libretro" ]]; then
    ifexist=`ls /home/pigaming/RetroArena/roms/${romfolder} |grep -w "${gname}.zip"`
    if [[ -f "/home/pigaming/RetroArena/roms/${romfolder}/$ifexist" ]]; then
      echo "/home/pigaming/RetroArena/roms/${romfolder}/${ifexist}" >> /tmp/tempfile.cfg
     else
      :
    fi
  elif [[ $romfolder = "mame-mame4all" ]]; then
    ifexist=`ls /home/pigaming/RetroArena/roms/${romfolder} |grep -w "${gname}.zip"`
    if [[ -f "/home/pigaming/RetroArena/roms/${romfolder}/$ifexist" ]]; then
      echo "/home/pigaming/RetroArena/roms/${romfolder}/${ifexist}" >> /tmp/tempfile.cfg
     else
      :
    fi
  else
    ifexist=`ls /home/pigaming/RetroArena/roms/${romfolder} |grep -w "${gname}"`
    if [[ -f "/home/pigaming/RetroArena/roms/${romfolder}/$ifexist" ]]; then
      echo "/home/pigaming/RetroArena/roms/${romfolder}/${ifexist}" >> /tmp/tempfile.cfg
     else
      :
    fi
  fi
done < ./escollections/${filename}

cat /tmp/tempfile.cfg |sort -u > /tmp/custom-${choice}.cfg
cp /tmp/custom-${choice}.cfg /opt/retroarena/configs/all/emulationstation/collections
rm /tmp/tempfile.cfg
rm /tmp/custom-${choice}.cfg
}


# Main

main_menu
