#!/bin/sh

# delete old sample configuration if it exists and extract the new one
rm -Rf /storage/.config/vdropt-sample

cd /
  for i in `ls /usr/local/vdr-XXVERSIONXX/config/*-sample-config.zip`; do
     unzip $i
  done

if [[ ! -d /storage/.config/vdropt ]]; then
    # copy samples to final directory
    cp -a /storage/.config/vdropt-sample /storage/.config/vdropt
fi

# /usr/bin/systemctl disable extract-vdr-config.service
