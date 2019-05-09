#!/bin/sh

if grep -q "ODROID-N2" /sys/firmware/devicetree/base/model 2>/dev/null; then
    while pgrep mpv &>/dev/null;
        do sleep 1;
    done
elif grep -q "RockPro64" /sys/firmware/devicetree/base/model 2>/dev/null; then
    while pgrep mpv &>/dev/null;
        do sleep 1;
    done
else
    while pgrep mplayer &>/dev/null;
        do sleep 1;
    done
fi

if [[ -e "$HOME/.config/themerandomizer" ]]; then
    ls /etc/emulationstation/themes > /tmp/themes
    ls /opt/retroarena/configs/all/emulationstation/themes >> /tmp/themes
    themecount=`cat /tmp/themes |wc -l`
    curtheme=`cat /opt/retroarena/configs/all/emulationstation/es_settings.cfg |grep ThemeSet |cut -f4 -d '"'`
    r=$(( $RANDOM % ${themecount} +1 ))
    newtheme=`sed -n "${r}p" /tmp/themes`
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
