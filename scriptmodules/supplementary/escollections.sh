#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="escollections"
rp_module_desc="Add or update the custom collection gamelist"
rp_module_section="config"

function gui_escollections() {
    source $scriptdir/scriptmodules/supplementary/escollections/escollections.sh
}
