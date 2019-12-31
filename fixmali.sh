#!/bin/sh

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

sudo ln -sfn /usr/lib/aarch64-linux-gnu/libMali.so /usr/lib/aarch64-linux-gnu/libEGL.so.1
sudo ln -sfn /usr/lib/aarch64-linux-gnu/libMali.so /usr/lib/aarch64-linux-gnu/libGLESv1_CM.so.1
sudo ln -sfn /usr/lib/aarch64-linux-gnu/libMali.so /usr/lib/aarch64-linux-gnu/libGLESv2.so.2