#!/bin/sh

CONF_DIR="XXCONFDIRXX"
BIN_DIR="XXBINDIRXX"
LIB_DIR="XXLIBDIRXX"

$(BIN_DIR)/easyvdrctl --plugindir "${LIB_DIR}" --inidir "${CONF_DIR}" $@
