#!/bin/bash

IFS=';'

infobox= ""
infobox="${infobox}\n"
infobox="${infobox}The Fruitbox jukebox software turns RetroArena into a jukebox music machine.\n"
infobox="${infobox}\n"
infobox="${infobox}This utility is used to quickly configure some of the common options for it.\n"
infobox="${infobox}\n"
infobox="${infobox}A special new folder has been created in the /roms directory called \"jukebox/mp3files\" for placing your MP3 files into.\n"
infobox="${infobox}\n"
infobox="${infobox}Once you place your music files into this folder, launching the jukebox will scan the folder and create a jukebox database for them.\n"
infobox="${infobox}\n"
infobox="${infobox}You can also configure your gamepad to use the jukebox. (Note a keyboard is required during gamepad configuration only).\n"
infobox="${infobox}\n"
infobox="${infobox}Here are some of the command jukebox-to-gamepad assignments to setup.\n"
infobox="${infobox}\n"
infobox="${infobox}ButtonQuit       - define your single button to quit the jukebox\n"
infobox="${infobox}ButtonSelect     - define your button to play highlighted song\n"
infobox="${infobox}ButtonPause      - define your button to pause playing\n"
infobox="${infobox}ButtonSkip       - define your button to skip to next song\n"
infobox="${infobox}ButtonRandom     - define your button to randomly play a song\n"
infobox="${infobox}ButtonLeft       - define your d-pad direction for left\n"
infobox="${infobox}ButtonRight      - define your d-pad direction for right\n"
infobox="${infobox}ButtonUp         - define your d-pad direction for up\n"
infobox="${infobox}ButtonDown       - define your d-pad direction for down\n"
infobox="${infobox}ButtonLeftJump   - define your button for page left\n"
infobox="${infobox}ButtonRightJump  - define your button for page right\n"
infobox="${infobox}\n"
infobox="${infobox}***NOTE***\n"
infobox="${infobox}Whenever you add or remove MP3 files, you must remove the current jukebox database file too.  Then launch the jukebox and it will rescan your files and build a new music database.\n\n\n"
infobox="${infobox}Do you want to proceed?"

# Welcome
 dialog --backtitle "RetroArena" --title "Fruitbox Jukebox Config" \
    --yesno "${infobox}" \
    25 80 2>&1 > /dev/tty \
    || exit

function main_menu() {
    local choice

    while true; do
        choice=$(dialog --backtitle "$BACKTITLE" --title " MAIN MENU " \
            --ok-label OK --cancel-label Exit \
            --menu "What action would you like to perform?" 25 100 20 \
            1 "Delete current jukebox music database (jukebox will refresh upon next launch)" \
            2 "Configure gamepad button assignments" \
            3 "Select skin" \
            2>&1 > /dev/tty)

        case "$choice" in
            1) remove_database  ;;
            2) configure_gamepad  ;;
            3) select_skin  ;;
            *) break ;;
        esac
    done
}


function remove_database() {
dialog --infobox "...processing..." 3 20 ; sleep 2

rm /home/pigaming/RetroArena/roms/jukebox/*.db 2> /dev/null

}

function configure_gamepad() {
dialog --infobox "...processing..." 3 20 ; sleep 2

sudo /opt/retroarena/ports/fruitbox/fruitbox --config-buttons

}

function select_skin() {
    local startfb
    local choice
    while true; do
        startfb="/home/pigaming/RetroArena/roms/jukebox/+Start fruitbox.sh"
        choice=$(dialog --backtitle "$BACKTITLE" --title " SELECT SKIN " \
            --ok-label OK --cancel-label Cancel \
            --menu "Which skin would you like to use?" 25 100 20 \
            1 "Granite" \
            2 "MikeTV" \
            3 "Modern (default)" \
            4 "NumberOne" \
            5 "Splat" \
            6 "TouchOne" \
            7 "WallJuke" \
            8 "WallSmall" \
            9 "Wurly" \
            2>&1 > /dev/tty)

        case "$choice" in
            1) 
                sed -i '/skin=/d' $startfb
                sed -i '2i skin=Granite' $startfb
                printMsgs "dialog" "Enabled Granite skin"
                ;;
            2) 
                sed -i '/skin=/d' $startfb
                sed -i '2i skin=MikeTV' $startfb
                printMsgs "dialog" "Enabled MikeTV skin"
                ;;
            3) 
                sed -i '/skin=/d' $startfb
                sed -i '2i skin=Modern' $startfb
                printMsgs "dialog" "Enabled Modern skin"
                ;;
            4) 
                sed -i '/skin=/d' $startfb
                sed -i '2i skin=NumberOne' $startfb
                printMsgs "dialog" "Enabled NumberOne skin"
                ;;
            5) 
                sed -i '/skin=/d' $startfb
                sed -i '2i skin=Splat' $startfb
                printMsgs "dialog" "Enabled Splat skin"
                ;;
            6) 
                sed -i '/skin=/d' $startfb
                sed -i '2i skin=TouchOne' $startfb
                printMsgs "dialog" "Enabled TouchOne skin"
                ;;
            7) 
                sed -i '/skin=/d' $startfb
                sed -i '2i skin=WallJuke' $startfb
                printMsgs "dialog" "Enabled WallJuke skin"
                ;;
            8) 
                sed -i '/skin=/d' $startfb
                sed -i '2i skin=WallSmall' $startfb
                printMsgs "dialog" "Enabled WallSmall skin"
                ;;
            9) 
                sed -i '/skin=/d' $startfb
                sed -i '2i skin=Wurly' $startfb
                printMsgs "dialog" "Enabled Wurly skin"
                ;;
            *) break ;;
        esac
    done
}

main_menu
