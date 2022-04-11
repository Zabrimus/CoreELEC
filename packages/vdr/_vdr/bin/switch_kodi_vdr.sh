#!/bin/sh

if [ "$1" = "kodi" ]; then
  systemctl stop vdropt
  systemctl start kodi_o
else
  systemctl stop kodi_o
  systemctl start vdropt
fi