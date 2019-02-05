if grep -Fq 'disable_menu = "0"' "/opt/retroarena/configs/all/runcommand.cfg"; then
    RALV="$HOME/RetroArena/launchingvideos"
    if [[ -e "$HOME/.config/launchingvideos" ]]; then
        if [[ -e "$RALV/system-exit.mp4" ]];then
            mplayer -slave -nogui -really-quiet -vo sdl -fs -zoom "$RALV/system-exit.mp4" </dev/tty &>/dev/null
        fi
    fi
fi
if [[ -e "$HOME/.config/bgmtoggle" ]];  then
    (sleep 2; pkill -CONT mpg123) &
fi
