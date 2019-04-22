if grep -Fq 'disable_menu = "0"' "/opt/retroarena/configs/all/runcommand.cfg"; then
    RALV="$HOME/RetroArena/launchingvideos"
    if [[ -e "$HOME/.config/launchingvideos" ]]; then
        if [[ -e "$RALV/system-exit.mp4" ]];then
            if grep -q "ODROID-N2" /sys/firmware/devicetree/base/model 2>/dev/null; then
                mpv -really-quiet -vo sdl -fs "$RALV/system-exit.mp4" </dev/tty &>/dev/null
            elif grep -q "RockPro64" /sys/firmware/devicetree/base/model 2>/dev/null; then
                mpv -really-quiet -vo sdl -fs "$RALV/system-exit.mp4" </dev/tty &>/dev/null
            else
                mplayer -slave -nogui -really-quiet -vo sdl -fs -zoom "$RALV/system-exit.mp4" </dev/tty &>/dev/null
            fi
        fi
    fi
fi
if [[ -e "$HOME/.config/bgmtoggle" ]];  then
    (sleep 2; pkill -CONT mpg123) &
fi
if [[ -e "$HOME/.config/esreload" ]];  then
    bash /opt/retroarena/configs/all/runcommand-esreload.sh &>/dev/null
fi
