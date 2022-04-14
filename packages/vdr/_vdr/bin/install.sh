#!/bin/sh

PROGNAME=$0

CONF_DIR="XXCONFDIRXX"

usage() {
  cat << EOF >&2
Usage: $PROGNAME [-install-config] [-boot kodi|vdr]

-i      : Extracts the default configuration into directory /storage/.config/vdropt-sample and copy the sample folder to /storage/.config/vdropt if it does not exists.
-b kodi : Kodi will be started after booting
-b vdr  : VDR will be started after booting
EOF
  exit 1
}

install() {
  # delete old sample configuration if it exists and extract the new one
  rm -Rf /storage/.config/vdropt-sample

  cd /
    for i in `ls ${CONF_DIR}/*-sample-config.zip`; do
       unzip $i
    done

  if [[ ! -d /storage/.config/vdropt ]]; then
    # copy samples to final directory
    cp -a /storage/.config/vdropt-sample /storage/.config/vdropt
  fi
}

boot() {
  if [ "$1" = "kodi" ]; then
      echo "Boot Kodi"

      cd /storage/.config/system.d
      rm -f kodi.service kodi_o.service
      ln -s /usr/lib/systemd/system/kodi.service kodi.service
      ln -s /usr/lib/systemd/system/kodi.service kodi_o.service
  elif [ "$1" = "vdr" ]; then
      echo "Boot VDR"

      cd /storage/.config/system.d
      rm -f kodi.service kodi_o.service
      ln -s vdropt.service kodi.service
      ln -s /usr/lib/systemd/system/kodi.service kodi_o.service
  else
      echo "Unknown Boot parameter"
      exit 1
  fi
}

if [ "$#" = "0" ]; then
    usage
fi

while getopts b:i o; do
  case $o in
    (i) install;;
    (b) boot "$OPTARG";;
    (*) usage
  esac
done




