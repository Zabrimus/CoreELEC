#!/bin/sh

CONF_DIR="XXCONFDIRXX"

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

# /usr/bin/systemctl disable extract-vdr-config.service
