#!/bin/bash

if grep -Fxq 'setenv hdmimode "720p60hz"' /media/boot/boot.ini
then
    printMsgs "dialog" 'IMPORTANT NOTE\n\nKodi Leia 18.1 requires the HDMI resolution set to 1080p.\n\nTo enable, go to Options in EmulationStation, launch RetroArena-Setup > Settings > Kodi then select the "Enable 1080p" option.\n\nPlease note that 720p will perform better in majority of emulators than 1080p. There is an option to revert back to 720p.'
else
    kodi
fi
