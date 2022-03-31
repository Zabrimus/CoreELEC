#!/bin/sh

CONF_DIR="XXCONFDIRXX"
BIN_DIR="XXBINDIRXX"

read_plugin_configuration () {
  param=`cat ${CONF_DIR}/conf.d/$1.conf | tr '\n' ' ' | sed  "s/\[/-P \\'/ ; s/\]// ; s/ *$/\'/"`
  echo "$param"
}

read_vdr_configuration () {
  param=`cat ${CONF_DIR}/conf.d/vdr.conf | tr '\n' ' ' | sed 's/\[vdr\]//'`
  echo "$param"
}

arg="vdr $(read_vdr_configuration)"

# read VDR start param
file=$(cat ${CONF_DIR}/enabled_plugins)

for line in $file; do
  pluginarg="$(read_plugin_configuration $line)"
  arg="$arg $pluginarg"
done

echo "Start: ${BIN_DIR}/${arg}"

# really start VDR
${BIN_DIR}/$arg
