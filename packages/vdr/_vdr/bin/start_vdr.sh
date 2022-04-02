#!/bin/sh

CONF_DIR="XXCONFDIRXX"
BIN_DIR="XXBINDIRXX"

read_plugin_configuration () {
  param=`cat ${CONF_DIR}/conf.d/$1.conf  | sed "s/#.*$//g ; s/^#$//g ; s/ *$//g" | tr '\n' ' ' | sed  "s/\[/-P \\'/ ; s/\]// ; s/ *$/\'/"`
  echo "$param"
}

read_vdr_configuration () {
  param=`cat ${CONF_DIR}/conf.d/vdr.conf | sed "s/#.*$//g ; s/^#$//g ; s/ *$//g" | tr '\n' ' ' | sed 's/\[vdr\]//'`
  echo "$param"
}

arg="vdr $(read_vdr_configuration)"

# read VDR plugin start parameters
file=$(cat ${CONF_DIR}/enabled_plugins)

for line in $file; do
  pluginarg="$(read_plugin_configuration $line)"
  arg="$arg $pluginarg"
done

# really start VDR
sh -c "LD_PRELOAD=/usr/lib/libMali.so LD_LIBRARY_PATH=/usr/local/lib:$LD_LIBRARY_PATH ${BIN_DIR}/$arg"
