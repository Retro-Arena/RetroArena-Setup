#!/bin/sh

while pgrep fbi &>/dev/null;
do sleep 1;
done

while pgrep mplayer &>/dev/null;
do sleep 1;
done

while pgrep vlc >/dev/null;
do sleep 1;
done

if [[ -e "$HOME/.config/themerandomizer" ]]; then
    # Get list of currently installed themes and count
    ls /etc/emulationstation/themes > /tmp/themes
    ls /opt/retroarena/configs/all/emulationstation/themes >> /tmp/themes
    themecount=`cat /tmp/themes |wc -l`

    # Get the currently used theme name
    curtheme=`cat /opt/retroarena/configs/all/emulationstation/es_settings.cfg |grep ThemeSet |cut -f4 -d '"'`

    # Generate a random number between 1 and theme count
    r=$(( $RANDOM % ${themecount} +1 ))

    # Read the random line in the tmp file to get a new theme name
    newtheme=`sed -n "${r}p" /tmp/themes`

    # Replace the current used theme with a new one
    perl -pi -w -e 's/<string name=\"ThemeSet\" value=\"'${curtheme}'\" \/>/<string name=\"ThemeSet\" value=\"'${newtheme}'\" \/>/g;' /opt/retroarena/configs/all/emulationstation/es_settings.cfg
fi

if [ -a "$HOME/.config/bgmtoggle" ];  then
    (mpg123 -f 18000 -Z /home/pigaming/RetroArena/bgm/*.mp3 >/dev/null 2>&1) &
else
    (mpg123 -f 18000 -Z /home/pigaming/RetroArena/bgm/*.mp3 >/dev/null 2>&1) &
    until pids=$(pidof mpg123)
    do
        sleep 1
    done
    pkill -STOP mpg123
fi

if [ -a $home/.config/ogst* ];  then
    mplayer -quiet -nolirc -nosound -vo fbdev2:/dev/fb1 -vf scale=320:240 "$HOME/RetroArena/casetheme/es.png" &> /dev/null
fi

emulationstation #auto
