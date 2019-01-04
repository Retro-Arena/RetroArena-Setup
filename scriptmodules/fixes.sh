#!/bin/bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

if [[ ! -f $home/.config/update001 ]]; then
    wget -O $configdir/all/autostart.sh https://pastebin.com/raw/dZTkicwt
    dos2unix $configdir/all/autostart.sh
    touch $HOME/.config/update001
fi