#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="bashwelcometweak"
rp_module_desc="Bash Welcome Tweak (shows additional system info on login)"
rp_module_section="config"

function install_bashwelcometweak() {
    remove_bashwelcometweak
    cat >> "$home/.bashrc" <<\_EOF_
# RETROARENA PROFILE START

function retroarena_welcome() {
    local upSeconds="$(/usr/bin/cut -d. -f1 /proc/uptime)"
    local secs=$((upSeconds%60))
    local mins=$((upSeconds/60%60))
    local hours=$((upSeconds/3600%24))
    local days=$((upSeconds/86400))
    local UPTIME=$(printf "%d days, %02dh%02dm%02ds" "$days" "$hours" "$mins" "$secs")

    # calculate rough CPU and GPU temperatures:
    local cpuTempC
    local cpuTempF
    local gpuTempC
    local gpuTempF
    if [[ -f "/sys/class/thermal/thermal_zone0/temp" ]]; then
        cpuTempC=$(($(cat /sys/class/thermal/thermal_zone0/temp)/1000)) && cpuTempF=$((cpuTempC*9/5+32))
    fi

    if [[ -f "/opt/vc/bin/vcgencmd" ]]; then
        if gpuTempC=$(/opt/vc/bin/vcgencmd measure_temp); then
            gpuTempC=${gpuTempC:5:2}
            gpuTempF=$((gpuTempC*9/5+32))
        else
            gpuTempC=""
        fi
    fi

    local df_out=()
    local line
    while read line; do
        df_out+=("$line")
    done < <(df -h /)

    local rst="$(tput sgr0)"
    local fgblk="${rst}$(tput setaf 0)" # Black - Regular
    local fgred="${rst}$(tput setaf 1)" # Red
    local fggrn="${rst}$(tput setaf 2)" # Green
    local fgylw="${rst}$(tput setaf 3)" # Yellow
    local fgblu="${rst}$(tput setaf 4)" # Blue
    local fgpur="${rst}$(tput setaf 5)" # Purple
    local fgcyn="${rst}$(tput setaf 6)" # Cyan
    local fgwht="${rst}$(tput setaf 7)" # White

    local bld="$(tput bold)"
    local bfgblk="${bld}$(tput setaf 0)"
    local bfgred="${bld}$(tput setaf 1)"
    local bfggrn="${bld}$(tput setaf 2)"
    local bfgylw="${bld}$(tput setaf 3)"
    local bfgblu="${bld}$(tput setaf 4)"
    local bfgpur="${bld}$(tput setaf 5)"
    local bfgcyn="${bld}$(tput setaf 6)"
    local bfgwht="${bld}$(tput setaf 7)"

    local logo=(
        "                  "
        "${fgblu}      ____        "
        "${fgblu}      |  |        "
        "${fgblu}      |  |        "
        "${fgblu}      |  |        "		
        "${fgblu} ____/    \__${fgred}==${fgblu}_  "
        "${fgblu}|               | "
        "${fgblu}| ${fggrn}TheRetroArena ${fgblu}| "
        "${fgblu}|_______________| "
        "${fggrn}theretroarena.com "
        "                  "
        "                  "
        )

    local out
    local i
    for i in "${!logo[@]}"; do
        out+="  ${logo[$i]}  "
        case "$i" in
            0)
                out+="${fggrn}$(date +"%A, %e %B %Y, %r")"
                ;;
            1)
                out+="${fggrn}$(uname -srmo)"
                ;;
            3)
                out+="${fgylw}${df_out[0]}"
                ;;
            4)
                out+="${fgwht}${df_out[1]}"
                ;;
            5)
                out+="${fgred}Uptime.............: ${UPTIME}"
                ;;
            6)
                out+="${fgred}Memory.............: $(grep MemFree /proc/meminfo | awk {'print $2'})kB (Free) / $(grep MemTotal /proc/meminfo | awk {'print $2'})kB (Total)"
                ;;
            7)
                out+="${fgred}Running Processes..: $(ps ax | wc -l | tr -d " ")"
                ;;
            8)
                out+="${fgred}IP Address.........: $(hostname -I | awk '{print $1}')"
                ;;
            9)
                out+="${fgred}Temperature........: CPU: $cpuTempC°C/$cpuTempF°F GPU: $gpuTempC°C/$gpuTempF°F${fgwht}"
                ;;
        esac
        out+="\n"
    done
    echo -e "\n$out"
}

retroarena_welcome
# Common Aliases
alias alsa='alsamixer'
alias autostart='sudo nano /opt/retroarena/configs/all/autostart.sh'
alias configs='cd /opt/retroarena/configs'
alias fixmali='cd mali && sudo ./install.sh && cd ~'
alias fstab='sudo nano /etc/fstab'
alias gitreset='cd RetroArena-Setup && git reset --hard && git clean -f -d && cd ~'
alias ifconfig='ip address'
alias log='sudo nano /dev/shm/runcommand.log'
alias openbeta='rm -rf /home/pigaming/RetroArena-Setup/scriptmodules/admin/setup.sh && wget -P /home/pigaming/RetroArena-Setup/scriptmodules/admin https://github.com/Retro-Arena/base-installer/raw/master/setup.sh'
alias rclocal='sudo nano /etc/rc.local'
alias reboot='sudo reboot -h now'
alias setup='sudo ~/RetroArena-Setup/retroarena_setup.sh && cd ~'
alias shutdown='sudo shutdown -h now'
alias upgrade='sudo apt-get update && sudo apt-get upgrade -y'
# RETROARENA PROFILE END
_EOF_
}

function remove_bashwelcometweak() {
    sed -i '/RETROARENA PROFILE START/,/RETROARENA PROFILE END/d' "$home/.bashrc"
}

function gui_bashwelcometweak() {
    local cmd=(dialog --backtitle "$__backtitle" --menu "Bash Welcome Tweak Configuration" 22 86 16)
    local options=(
        1 "Install Bash Welcome Tweak"
        2 "Remove Bash Welcome Tweak"
    )
    local choice=$("${cmd[@]}" "${options[@]}" 2>&1 >/dev/tty)
    if [[ -n "$choice" ]]; then
        case "$choice" in
            1)
                rp_callModule bashwelcometweak install
                printMsgs "dialog" "Installed Bash Welcome Tweak."
                ;;
            2)
                rp_callModule bashwelcometweak remove
                printMsgs "dialog" "Removed Bash Welcome Tweak."
                ;;
        esac
    fi
}
