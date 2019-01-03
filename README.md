RetroArena-Setup
================

General Usage
-------------

Shell script to setup the Odroid-XU4 running Ubuntu with many emulators and games, using EmulationStation as the graphical front end. Bootable pre-made images for the XU4 are available for those that want a ready to go system, downloadable from the releases section of GitHub or via our website at https://theretroarena.com

This script is designed for use on Ubuntu on the Odroid-XU4.

To run the RetroArena Setup Script make sure that your APT repositories are up-to-date and that Git is installed:

```shell
sudo apt-get update
sudo apt-get dist-upgrade
sudo apt-get install git
```

Then you can download the latest RetroArena setup script with

```shell
cd
git clone --depth=1 https://github.com/RetroArena/RetroArena-Setup.git
```

The script is executed with 

```shell
cd RetroArena-Setup
sudo ./retroarena_setup.sh
```

When you first run the script it may install some additional packages that are needed.

Thanks
------

This script just simplifies the usage of the great works of many other people that enjoy the spirit of retrogaming. Many thanks go to them!
