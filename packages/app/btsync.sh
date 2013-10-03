#!/usr/bin/env bash

if [ `id -u` -ne 0 ]; then
    echo "ERROR! `basename ${0}` must be executed as root."
    exit 1
fi

IS_INSTALLED=$(pacman -Qqm `basename ${0} .sh`)
if [ $? -ne 0 ]; then
    packer -S --noedit --noconfirm $(basename ${0} .sh)
    systemctl --system daemon-reload

else
    echo "$(basename ${0} .sh) is already installed."
fi

#Configuration is located at /etc/btsync.conf and contains sample data.
#The corresponding systemd-unit is 'btsync.service'
#WebGUI can be accessed at http://localhost:8888
#
#User-specific BTSync configuration
#Helps to set ownership to someone other than root for files that are copied
#with btsync. A default configuration file is automatically created at
#~/.config/btsync/btsync.conf if this file does not exist. You may want to
#change the device_name, webui.login and webui.password settings. You can
#either edit the config file directly or use the
#/usr/share/bittorrent-sync/btsync-makeconfig.sh script, pass it the --help
#flag to learn more about it. Please note that the PIDFile setting in
#  /usr/lib/systemd/system/btsync@.service assumes the default settings of
#  storage_path and pid_file.
#
#  To start btsync, execute:
#
#  $ systemctl start btsync@user
#
#  where 'user' is your username.
