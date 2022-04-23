#!/bin/sh

# 
# This script will be started once after boot just before Kodi starts
# 
# Default: Start Kodi
#

# create file which will be watched to switch between Kodi and VDR
rm -f /opt/tmp/switch_kodi_vdr
touch /opt/tmp/switch_kodi_vdr

# monitor file changes
systemctl start switch_kodi_vdr.path

# Start either Kodi or VDR on reboot
. /storage/.profile

if [ "${START_PRG}" = "vdr" ]; then
   systemctl stop kodi
   systemctl start vdropt
elif [ "${START_PRG}" = "kodi" ]; then
   systemctl stop vdropt
fi

