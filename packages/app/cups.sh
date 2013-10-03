#!/usr/bin/env bash

if [ `id -u` -ne 0 ]; then
    echo "ERROR! `basename ${0}` must be executed as root."
    exit 1
fi

CUPS=""
if [ -f ../desktop/packages-cups.txt ]; then
    CUPS="../desktop/packages-cups.txt"
elif [ -f desktop/packages-cups.txt ]; then
    CUPS="desktop/packages-cups.txt"
fi

if [ -z "${CUPS}" ]; then
    pacman -S --needed --noconfirm `cat ${CUPS}`

    if [ `uname -m` == "x86_64" ]; then
        pacman -S --needed --noconfirm "lib32-libcups"
    fi

    systemctl enable cups.service
fi