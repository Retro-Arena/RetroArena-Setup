#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#
__version="3.0.14 PUBLIC"	

[[ "$__debug" -eq 1 ]] && set -x

# main retroarena install location
rootdir="/opt/retroarena"

# if __user is set, try and install for that user, else use SUDO_USER
if [[ -n "$__user" ]]; then
    user="$__user"
    if ! id -u "$__user" &>/dev/null; then
        echo "User $__user not exist"
        exit 1
    fi
else
    user="$SUDO_USER"
    [[ -z "$user" ]] && user="$(id -un)"
fi

home="$(eval echo ~$user)"
datadir="$home/RetroArena"
biosdir="$datadir/BIOS"
romdir="$datadir/roms"
emudir="$rootdir/emulators"
configdir="$rootdir/configs"

scriptdir="$(dirname "$0")"
scriptdir="$(cd "$scriptdir" && pwd)"

__logdir="$scriptdir/logs"
__tmpdir="$scriptdir/tmp"
__builddir="$__tmpdir/build"
__swapdir="$__tmpdir"

# check, if sudo is used
if [[ "$(id -u)" -ne 0 ]]; then
    echo "Script must be run under sudo from the user you want to install for. Try 'sudo $0'"
    exit 1
fi

__backtitle=""

source "$scriptdir/scriptmodules/system.sh"
source "$scriptdir/scriptmodules/helpers.sh"
source "$scriptdir/scriptmodules/inifuncs.sh"
source "$scriptdir/scriptmodules/packages.sh"
source "$scriptdir/scriptmodules/fixes.sh" > /dev/null 2>&1

setup_env

rp_registerAllModules

ensureFBMode 320 240

rp_ret=0
if [[ $# -gt 0 ]]; then
    setupDirectories
    rp_callModule "$@"
    rp_ret=$?
else
    rp_printUsageinfo
fi

printMsgs "console" "${__INFMSGS[@]}"
exit $rp_ret
