#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

rp_module_id="dolphinbar"
rp_module_desc="Dolphin Bar Udev Rules"
rp_module_section="driver"
rp_module_help="Ok, for those of you willing (and able) to try the DolphinBar....
1) take the attached file and copy it to the /etc/udev/rules.d/ (you must be root or use sudo to do it)
2) If you have just the wiimote (no nunchuck) make sure user dolphinbar/controller pair in mode 1. If you want to use your nunchuck as a trigger (like I do, rifle style holder) use mode 2.
3) Make sure you are not using any other composite HID device (dongle), like wireless/bluetooth keyboard and mouse combo, as they most probably interfere with the dolphinbar. (you can experiment later)
4) Reboot the system. Make sure (pull a trigger or pushh a buuton on the controller as soon as your dolphinbar lights up the right led. (I'm not sure how crucial this is, but seems to work the best for me).
I use wireless (with USB dongles) XBOX 360 controllers, and if I don't turn them on during boot it seems to work every time. With controllers on, sometimes it happens that only one axes works (will come to that later)
5) After entering emulation station you might use the dpad on the wiimote and the middle (home) button to navigate. (I did not configure the wiimote as input controller in ES). If it does not work, use your regular controller (you might also need it, or a keyboard) to configure your mame game.)
6. Good game to try is MAME Alien3: The gun
I used the mame menu to configure my input controls (not general but for the game only). What you might want to configure is Player 1 Coin. Also, I configured 1 Player start to the left mouse button (main trigger). NOTE: If using nunchuck, primary trigger is lower and secondary the high button. If the game uses it (liike Alien 3) map the secondary trigger to the Player 1 2nd button
NOTE: Sometimes I receive a stuck axes. For me, using 1st controler analog stick to move the cursor in directions that does not work, unlocks the axes.
Good Luck!"

function install_dolphinbar() {
    # install  to /etc/udev/rules.d/
	cp "$md_data/51-usb-device.rules" /etc/udev/rules.d/
}
