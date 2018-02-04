#!/bin/bash
set -euo pipefail
IFS=$'\n\t'

BASEPATH=$1
MYPATH=$2

DIRECTORY=$(cd "$(dirname "$0")" && pwd)


# check udev rules 
if [ -f "/etc/udev/rules.d/50-atmel-dfu.rules" ];then
    echo "Udev rules found"
else
    echo "Copying udev rules"
    sudo cp ./50-atmel-dfu.rules /etc/udev/rules.d/
fi

# check if we have dfu-programmer
if command -v  df-programmer 2>/dev/null; then
    echo "dfu-programmer is installed"
else
    echo "Installing dfu-programmer"
    git clone https://aur.archlinux.org/dfu-programmer.git /tmp/dfu-programmer
    cd /tmp/dfu-programmer && makepkg -sri
fi

if [ -d "$MYPATH" ]; then
    echo "Already init"
    exit 0
fi


if [ -d "$BASEPATH" ];then
    mkdir "$MYPATH"
    ln -s  "$DIRECTORY"/keymap.c "$MYPATH"
    ln -s  "$DIRECTORY"/rules.mk "$MYPATH"
else
    echo "Cloning qmk firmware first"
    git clone git@github.com:qmk/qmk_firmware.git "$BASEPATH"
    echo "Installing dependencies"
    sudo ~/src/qmk_firmware/util/install_dependencies.sh
    echo "Now init your layout"
    ./kybd.sh "$BASEPATH" "$MYPATH"
fi


