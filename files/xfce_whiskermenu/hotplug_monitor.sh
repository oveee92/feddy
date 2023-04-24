#!/bin/bash

# Managed by Ansible

# This script is called by a unit file, hotplug_hdmi.service

# Determine the user (will be decided by the systemd unit file,
# which is run as a specific user.
X_USER=$(whoami)
export DISPLAY=:0
export XAUTHORITY=/home/$X_USER/.Xauthority
export DBUS_SESSION_BUS_ADDRESS=unix:path=/run/user/1000/bus

function connect () {
    xfce4-panel-profiles load /home/$X_USER/.config/xfce4/panel/profiles/widescreen.tar.bz2
}

function disconnect () {
    xfce4-panel-profiles load /home/$X_USER/.config/xfce4/panel/profiles/laptop_only.tar.bz2
}

# Check whether the HDMI is connected or disconnected
# Can probably be extended further by adding one scenario per connected
# screen. Does not scale well though.
if [ "$(cat /sys/class/drm/card1-HDMI-A-1/status)" = "connected" ] ; then
  connect
elif [ "$(cat /sys/class/drm/card1-HDMI-A-1/status)" = "disconnected" ] ; then
  disconnect
else
  exit
fi
