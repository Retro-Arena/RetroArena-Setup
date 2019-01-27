#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="fruitbox"
rp_module_desc="Fruitbox - A customizable MP3 Retro Jukebox. Read the Package Help for more information."
rp_module_help="Copy your .mp3 files to '$romdir/jukebox' then launch Fruitbox from EmulationStation\n\nUsing a keyboard, press 'A' then '0' on your keyboard to play the song on the 'AO' slot.\n\nTo exit, press the 'ESC' button on your keyboard."
rp_module_section="opt"

function depends_fruitbox() {
    getDepends libsm-dev libxcursor-dev libxi-dev libxinerama-dev libxrandr-dev libxpm-dev libvorbis-dev libtheora-dev
}

function sources_fruitbox() {
    gitPullOrClone "$md_build/allegro5" "https://github.com/dos1/allegro5.git"
    gitPullOrClone "$md_build/fruitbox" "https://github.com/Retro-Arena/rpi-fruitbox.git"
    downloadAndExtract "https://ftp.osuosl.org/pub/blfs/conglomeration/mpg123/mpg123-1.24.0.tar.bz2" "$md_build"
}

function build_fruitbox() {
    # Build mpg123
    cd "$md_build/mpg123-1.24.0"
    chmod +x configure
    ./configure --with-cpu=arm_fpu --disable-shared
    make -j4 && make install
    cd ..
    
    # Overwrite build files.
    cp -vf "$md_data/CMakeLists.txt" "$md_build/allegro5/"
    
    # Build Allegro5
    cd "$md_build/allegro5"
    mkdir build && cd build
    cmake .. -DSHARED=off
    make -j4 && make install
    export PKG_CONFIG_PATH=/opt/retroarena/ports/fruitbox/build/allegro5/build/lib/pkgconfig
    ldconfig
    cd ../..

    # Build fruitbox
    cd "$md_build/fruitbox/build"
    make -j4
    md_ret_require="$md_build/fruitbox/build/fruitbox"
}

function install_fruitbox() {
    cp -v "$md_build/fruitbox/build/fruitbox" "$md_inst/"
	cp -v "$md_build/fruitbox/skins.txt" "$md_inst/"
	cp -vR "$md_build/fruitbox/skins" "$md_inst/"
    mkRomDir "jukebox"
    cat > "$romdir/jukebox/+Start Fruitbox.sh" << _EOF_
#!/bin/bash
skin=Modern
if [[ -e "$home/RetroArena/roms/jukebox/fruitbox.db" ]]; then
    rm -rf "$home/RetroArena/roms/jukebox/fruitbox.db"
fi
if [[ -e "$home/.config/fruitbox001" ]]; then
    rm -rf "$home/.config/fruitbox001"
    /opt/retroarena/ports/fruitbox/fruitbox --cfg /opt/retroarena/ports/fruitbox/skins/\$skin/fruitbox.cfg --config-buttons
else
    /opt/retroarena/ports/fruitbox/fruitbox --cfg /opt/retroarena/ports/fruitbox/skins/\$skin/fruitbox.cfg
fi
_EOF_
    chmod a+x "$romdir/jukebox/+Start fruitbox.sh"
    chown $user:$user "$romdir/jukebox/+Start fruitbox.sh"
    addEmulator 0 "$md_id" "jukebox" "fruitbox %ROM%"
    addSystem "jukebox" "Fruitbox Jukebox" ".sh"
    touch "$home/.config/fruitbox001"
}

function remove_fruitbox() {
    rm -rf "$romdir/jukebox"
    delSystem jukebox
}

function skin_fruitbox() {
    while true; do
        local cmd=(dialog --backtitle "$__backtitle" --menu "Choose an option" 22 76 16)
        local options=(
            1 "Granite"
            2 "MikeTV"
            3 "Modern (default)"
            4 "NumberOne"
            5 "Splat"
            6 "TouchOne"
            7 "WallJuke"
            8 "WallSmall"
            9 "Wurly"
        )
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        [[ -z "$choice" ]] && break
        case "$choice" in
            1) 
                sed -i "/skin=/d" "$romdir/jukebox/+Start fruitbox.sh"
                sed -i "2i skin=Granite" "$romdir/jukebox/+Start fruitbox.sh"
                printMsgs "dialog" "Enabled Granite skin"
                ;;
            2) 
                sed -i "/skin=/d" "$romdir/jukebox/+Start fruitbox.sh"
                sed -i "2i skin=MikeTV" "$romdir/jukebox/+Start fruitbox.sh"
                printMsgs "dialog" "Enabled MikeTV skin"
                ;;
            3) 
                sed -i "/skin=/d" "$romdir/jukebox/+Start fruitbox.sh"
                sed -i "2i skin=Modern" "$romdir/jukebox/+Start fruitbox.sh"
                printMsgs "dialog" "Enabled Modern skin"
                ;;
            4) 
                sed -i "/skin=/d" "$romdir/jukebox/+Start fruitbox.sh"
                sed -i "2i skin=NumberOne" "$romdir/jukebox/+Start fruitbox.sh"
                printMsgs "dialog" "Enabled NumberOne skin"
                ;;
            5) 
                sed -i "/skin=/d" "$romdir/jukebox/+Start fruitbox.sh"
                sed -i "2i skin=Splat" "$romdir/jukebox/+Start fruitbox.sh"
                printMsgs "dialog" "Enabled Splat skin"
                ;;
            6) 
                sed -i "/skin=/d" "$romdir/jukebox/+Start fruitbox.sh"
                sed -i "2i skin=TouchOne" "$romdir/jukebox/+Start fruitbox.sh"
                printMsgs "dialog" "Enabled TouchOne skin"
                ;;
            7) 
                sed -i "/skin=/d" "$romdir/jukebox/+Start fruitbox.sh"
                sed -i "2i skin=WallJuke" "$romdir/jukebox/+Start fruitbox.sh"
                printMsgs "dialog" "Enabled WallJuke skin"
                ;;
            8) 
                sed -i "/skin=/d" "$romdir/jukebox/+Start fruitbox.sh"
                sed -i "2i skin=WallSmall" "$romdir/jukebox/+Start fruitbox.sh"
                printMsgs "dialog" "Enabled WallSmall skin"
                ;;
            9) 
                sed -i "/skin=/d" "$romdir/jukebox/+Start fruitbox.sh"
                sed -i "2i skin=Wurly" "$romdir/jukebox/+Start fruitbox.sh"
                printMsgs "dialog" "Enabled Wurly skin"
                ;;
        esac
    done
}

function enable_gamepad_fruitbox() {
    touch "$home/.config/fruitbox001"
}

function disable_gamepad_fruitbox() {
    rm -rf "$home/.config/fruitbox001"
}

function gui_fruitbox() {  
    while true; do
        local options=(
            1 "Select Fruitbox Skin"
            2 "Enable Fruitbox Gamepad Config"
            3 "Disable Fruitbox Gamepad Config"
        )
        local cmd=(dialog --backtitle "$__backtitle" --menu "Choose an option" 22 76 16)
        local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
        [[ -z "$choice" ]] && break
        case "$choice" in
            1)
                skin_fruitbox
                ;;
            2)
                enable_gamepad_fruitbox
                printMsgs "dialog" "Enabled Fruitbox Gamepad Config\n\nThe configure gamepad option will appear next time you start Fruitbox. This is a one-time setting. If you need to reconfigure a gamepad again, re-enable this option.\n\nNOTE: A connected keyboard is required."
                ;;
            3)
                disable_gamepad_fruitbox
                printMsgs "dialog" "Disabled Fruitbox Gamepad Config"
                ;;
        esac
    done
}
