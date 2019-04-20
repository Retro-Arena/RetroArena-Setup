#!/usr/bin/env bash

# This file is part of The RetroArena (TheRA)
#
# The RetroArena (TheRA) is the legal property of its developers, whose names are
# too numerous to list here. Please refer to the COPYRIGHT.md file distributed with this source.
#
# See the LICENSE.md file at the top-level directory of this distribution and
# at https://raw.githubusercontent.com/Retro-Arena/RetroArena-Setup/master/LICENSE.md
#

function setup_env() {

    __ERRMSGS=()
    __INFMSGS=()

    # if no apt-get we need to fail
    [[ -z "$(which apt-get)" ]] && fatalError "Unsupported OS - No apt-get command found"

    __memory_phys=$(free -m | awk '/^Mem:/{print $2}')
    __memory_total=$(free -m -t | awk '/^Total:/{print $2}')

    __has_binaries=0

    get_platform
    get_os_version
    get_retroarena_depends

    __gcc_version=$(gcc -dumpversion)

    # workaround for GCC ABI incompatibility with threaded armv7+ C++ apps built
    # on Raspbian's armv6 userland https://github.com/raspberrypi/firmware/issues/491
    if [[ "$__os_id" == "Raspbian" ]] && compareVersions $__gcc_version lt 5.0.0; then
        __default_cxxflags+=" -U__GCC_HAVE_SYNC_COMPARE_AND_SWAP_2"
    fi

    # set location of binary downloads
    __binary_host="files.retropie.org.uk"
    [[ "$__has_binaries" -eq 1 ]] && __binary_url="https://$__binary_host/binaries/$__os_codename/$__platform"

    __archive_url="https://files.retropie.org.uk/archives"
    
    if isPlatform "odroid-xu"; then
        __gitbins_url="https://github.com/Retro-Arena/binaries/raw/master/odroid-xu4/"
    elif isPlatform "odroid-n2"; then
        __gitbins_url="https://github.com/Retro-Arena/binaries/raw/master/odroid-n2/"
    elif isPlatform "rockpro64"; then
        __gitbins_url="https://github.com/Retro-Arena/binaries/raw/master/rockpro64/"
    fi

    # -pipe is faster but will use more memory - so let's only add it if we have more thans 256M free ram.
    [[ $__memory_phys -ge 512 ]] && __default_cflags+=" -pipe"

    [[ -z "${CFLAGS}" ]] && export CFLAGS="${__default_cflags}"
    [[ -z "${CXXFLAGS}" ]] && export CXXFLAGS="${__default_cxxflags}"
    [[ -z "${ASFLAGS}" ]] && export ASFLAGS="${__default_asflags}"
    [[ -z "${MAKEFLAGS}" ]] && export MAKEFLAGS="${__default_makeflags}"

    # test if we are in a chroot
    if [[ "$(stat -c %d:%i /)" != "$(stat -c %d:%i /proc/1/root/.)" ]]; then
        [[ -z "$QEMU_CPU" && -n "$__qemu_cpu" ]] && export QEMU_CPU=$__qemu_cpu
        __chroot=1
    else
        __chroot=0
    fi

    if [[ -z "$__nodialog" ]]; then
        __nodialog=0
    fi
}

function get_os_version() {
    # make sure lsb_release is installed
    getDepends lsb-release

    # get os distributor id, description, release number and codename
    local os
    mapfile -t os < <(lsb_release -sidrc)
    __os_id="${os[0]}"
    __os_desc="${os[1]}"
    __os_release="${os[2]}"
    __os_codename="${os[3]}"
    
    local error=""
    case "$__os_id" in
        Raspbian|Debian)
            # get major version (8 instead of 8.0 etc)
            __os_debian_ver="${__os_release%%.*}"

            # Debian unstable is not officially supported though
            if [[ "$__os_release" == "unstable" ]]; then
                __os_release=10
            fi

            if compareVersions "$__os_debian_ver" lt 8; then
                error="You need Raspbian/Debian Stretch or newer"
            fi

            # set a platform flag for osmc
            if grep -q "ID=osmc" /etc/os-release; then
                __platform_flags+=" osmc"
            fi

            # and for xbian
            if grep -q "NAME=XBian" /etc/os-release; then
                __platform_flags+=" xbian"
            fi

            # we provide binaries for RPI on Raspbian 9 only
            if isPlatform "rpi" && compareVersions "$__os_debian_ver" gt 8 && compareVersions "$__os_debian_ver" lt 10; then
                __has_binaries=1
            fi
            ;;
        Devuan)
            if isPlatform "rpi"; then
                error="We do not support Devuan on the Raspberry Pi. We recommend you use Raspbian to run RetroArena."
            fi
            # devuan lsb-release version numbers don't match jessie
            case "$__os_codename" in
                jessie)
                    __os_debian_ver="8"
                    ;;
                ascii)
                    __os_debian_ver="9"
                    ;;
                beowolf)
                    __os_debian_ver="10"
                    ;;
                ceres)
                    __os_debian_ver="11"
                    ;;
            esac
            ;;
        LinuxMint)
            if [[ "$__os_desc" != LMDE* ]]; then
                if compareVersions "$__os_release" lt 18; then
                    error="You need Linux Mint 18 or newer"
                elif compareVersions "$__os_release" lt 19; then
                    __os_ubuntu_ver="16.04"
                    __os_debian_ver="8"
                else
                    __os_ubuntu_ver="18.04"
                    __os_debian_ver="9"
                fi
            fi
            ;;
        Ubuntu)
            if compareVersions "$__os_release" lt 16.04; then
                error="You need Ubuntu 16.04 or newer"
            elif compareVersions "$__os_release" lt 16.10; then
                __os_debian_ver="8"
            else
                __os_debian_ver="9"
            fi
            __os_ubuntu_ver="$__os_release"
            ;;
        Deepin)
            if compareVersions "$__os_release" lt 15.5; then
                error="You need Deepin OS 15.5 or newer"
            fi
            __os_debian_ver="9"
            ;;
        elementary)
            if compareVersions "$__os_release" lt 0.4; then
                error="You need Elementary OS 0.4 or newer"
            elif compareVersions "$__os_release" eq 0.4; then
                __os_ubuntu_ver="16.04"
                __os_debian_ver="8"
            else
                __os_ubuntu_ver="18.04"
                __os_debian_ver="9"
            fi
            ;;
        neon)
            __os_ubuntu_ver="$__os_release"
            if compareVersions "$__os_release" lt 16.10; then
                __os_debian_ver="8"
            else
                __os_debian_ver="9"
            fi
            ;;
        *)
            error="Unsupported OS"
            ;;
    esac
    
    [[ -n "$error" ]] && fatalError "$error\n\n$(lsb_release -idrc)"

    # add 32bit/64bit to platform flags
    __platform_flags+=" $(getconf LONG_BIT)bit"

    # configure Raspberry Pi graphics stack
    isPlatform "rpi" && get_rpi_video
}

function get_retroarena_depends() {
    local depends=(git dialog wget gcc g++ build-essential unzip xmlstarlet python-pyudev ca-certificates dos2unix)

    if ! getDepends "${depends[@]}"; then
        fatalError "Unable to install packages required by $0 - ${md_ret_errors[@]}"
    fi

    # make sure we don't have xserver-xorg-legacy installed as it breaks launching x11 apps from ES
    if ! isPlatform "x11" && hasPackage "xserver-xorg-legacy"; then
        aptRemove xserver-xorg-legacy
    fi
}

function get_rpi_video() {
    local pkgconfig="/opt/vc/lib/pkgconfig"

    # detect driver via inserted module / platform driver setup
    if [[ -d "/sys/module/vc4" ]]; then
        __platform_flags+=" mesa kms"
        [[ "$(ls -A /sys/bus/platform/drivers/vc4_firmware_kms/*.firmwarekms 2>/dev/null)" ]] && __platform_flags+=" dispmanx"
    else
        __platform_flags+=" videocore dispmanx"
    fi

    # use our supplied fallback pkgconfig if necessary
    [[ ! -d "$pkgconfig" ]] && pkgconfig="$scriptdir/pkgconfig"

    # set pkgconfig path for vendor libraries
    export PKG_CONFIG_PATH="$pkgconfig"
}

function get_platform() {
    local architecture="$(uname --machine)"
    if [[ -z "$__platform" ]]; then
        case "$(sed -n '/^Hardware/s/^.*: \(.*\)/\1/p' < /proc/cpuinfo)" in
            "Hardkernel ODROID-N2")
                __platform="odroid-n2"
                ;;
            ODROID-XU[34])
                __platform="odroid-xu"
                ;;
            *)
                if grep -q "RockPro64" /sys/firmware/devicetree/base/model 2>/dev/null; then
                    __platform="rockpro64"
                else
                    case $architecture in
                        i686|x86_64|amd64)
                            __platform="x86"
                            ;;
                    esac
                fi
                ;;
        esac
    fi

    if ! fnExists "platform_${__platform}"; then
        fatalError "Unknown platform - please manually set the __platform variable to one of the following: $(compgen -A function platform_ | cut -b10- | paste -s -d' ')"
    fi

    platform_${__platform}
    [[ -z "$__default_cxxflags" ]] && __default_cxxflags="$__default_cflags"
}

function platform_odroid-n2() {
    __default_cflags="-O2 -march=armv8-a+crc -mcpu=cortex-a73 -mtune=cortex-a73.cortex-a53"
    __platform_flags="aarch64 mali gles"
    __default_cflags+=" -ftree-vectorize -funsafe-math-optimizations"
    __default_asflags=""
    __default_makeflags="-j4"
}

function platform_odroid-xu() {
    __default_cflags="-O2 -march=armv7-a -mcpu=cortex-a15 -mtune=cortex-a15.cortex-a7 -mfpu=neon-vfpv4 -mfloat-abi=hard"
    # required for mali-fbdev headers to define GL functions
    __default_cflags+=" -DGL_GLEXT_PROTOTYPES"
    __default_asflags=""
    __default_makeflags="-j2"
    __platform_flags="arm armv7 neon mali gles"
    __has_binaries=0
}

function platform_rockpro64() {
    __default_cflags="-O2 -march=armv8-a+crc -mcpu=cortex-a72 -mtune=cortex-a72.cortex-a53 -mfpu=neon-fp-armv8"
    __platform_flags="arm armv8 neon kms gles"
    __default_cflags+=" -ftree-vectorize -funsafe-math-optimizations"
    # required for mali headers to define GL functions!
    __default_cflags+=" -DGL_GLEXT_PROTOTYPES"
    __default_asflags=""
    __default_makeflags="-j5"
}

function platform_generic-x11() {
    __default_cflags="-O2"
    __default_asflags=""
    __default_makeflags="-j$(nproc)"
    __platform_flags="x11 gl"
}
