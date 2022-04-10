# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2011 Anthony Nash (nash.ant@gmail.com)
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="_vdr"
PKG_VERSION="2.6.1"
PKG_SHA256="4717616da8e5320dceb7b44db1e4fa1b01e1d356a73717ec21225387020999c6"
PKG_LICENSE="GPL"
PKG_SITE="http://www.tvdr.de"
PKG_URL="http://git.tvdr.de/?p=vdr.git;a=snapshot;h=refs/tags/${PKG_VERSION};sf=tbz2"
PKG_SOURCE_NAME="${PKG_NAME}-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain bzip2 fontconfig freetype libcap libiconv libjpeg-turbo"
PKG_LONGDESC="A DVB TV server application."
PKG_TOOLCHAIN="manual"

post_unpack() {
  rm -rf ${PKG_BUILD}/PLUGINS/src/skincurses
}

pre_configure_target() {
  # test if prefix is set
  if [ "x${VDR_PREFIX}" = "x" ]; then
      echo "==> VDR_PREFIX is empty, but must be set"
      exit 1
  fi

  export LDFLAGS="$(echo ${LDFLAGS} | sed -e "s|-Wl,--as-needed||") -L${SYSROOT_PREFIX}/usr/lib/iconv -liconv"
}

pre_make_target() {
  PREFIX="${VDR_PREFIX}"

  cat > Make.config <<EOF
  PREFIX = ${PREFIX}
  VIDEODIR = /storage/videos
  CONFDIR = /storage/.config/vdropt
  LIBDIR = ${PREFIX}/lib/vdr
  CACHEDIR = /storage/.cache/vdr
  LIBS += -liconv
  VDR_USER=root
EOF

  # Ein ganz übler Hack. Es ist nicht gelungen pkg-config zu überreden, bei --cflags oder --libs (aber nur nur bei bestimmten Libs),
  # nicht(!) den Wert */sysroot/opt/vdr/opt/vdr zurückzugeben, den es eigentlich nicht geben darf und der beim compile und beim linken
  # ziemliche Problem macht.
  mkdir -p ${SYSROOT_PREFIX}${VDR_PREFIX}/opt
  cd ${SYSROOT_PREFIX}${VDR_PREFIX}/opt
  ln -f -s ../../vdr/ vdr
  cd $(get_build_dir _vdr)
}

make_target() {
  make vdr vdr.pc
}

makeinstall_target() {
  PREFIX="${VDR_PREFIX}"
  CONFDIR="/storage/.config/vdropt"

  make DESTDIR="${INSTALL}" install

  cat ${PKG_DIR}/bin/start_vdr.sh | sed "s#XXCONFDIRXX#${CONFDIR}# ; s#XXBINDIRXX#${PREFIX}/bin# ; s#XXVERSIONXX#${PKG_VERSION}# ; s#XXLIBDIRXX#${PREFIX}/lib#" > ${INSTALL}/${PREFIX}/bin/start_vdr.sh
  chmod +x ${INSTALL}/${PREFIX}/bin/start_vdr.sh

  cat ${PKG_DIR}/bin/install.sh | sed "s#XXVERSIONXX#${PKG_VERSION}# ; s#XXCONFDIRXX#${PREFIX}/conf#" > ${INSTALL}/${PREFIX}/bin/install.sh
  chmod +x ${INSTALL}/${PREFIX}/bin/install.sh

  cat ${PKG_DIR}/bin/switch_kodi_vdr.sh | sed "s#XXVERSIONXX#${PKG_VERSION}# ; s#XXCONFDIRXX#${PREFIX}/conf#" > ${INSTALL}/${PREFIX}/bin/switch_kodi_vdr.sh
  chmod +x ${INSTALL}/${PREFIX}/bin/switch_kodi_vdr.sh
}

post_makeinstall_target() {
  PREFIX="${VDR_PREFIX}"
  VDR_DIR=$(get_install_dir _vdr)

  # move configuration to another folder to prevent overwriting existing configuration after installation
  mv ${VDR_DIR}/storage/.config/vdropt ${VDR_DIR}/storage/.config/vdropt-sample

  mkdir -p ${VDR_DIR}/storage/.config/vdropt-sample/conf.d
  cp -PR ${PKG_DIR}/config/*.conf ${VDR_DIR}/storage/.config/vdropt-sample/conf.d/

  cat >> ${VDR_DIR}/storage/.config/vdropt-sample/enabled_plugins <<EOF
softhdodroid
satip
EOF

  if find ${INSTALL}/storage/.config/vdropt -mindepth 1 -maxdepth 1 2>/dev/null | read; then
     cp -ar ${INSTALL}/storage/.config/vdropt/* ${INSTALL}/storage/.config/vdropt-sample
     rm -Rf ${INSTALL}/storage/.config/vdropt
  fi

  cat ${PKG_DIR}/config/commands.conf | sed "s#XXBINDIRXX#${PREFIX}/bin#" > ${VDR_DIR}/storage/.config/vdropt-sample/commands.conf

  # create config.zip
  mkdir -p ${INSTALL}${PREFIX}/config
  cd ${INSTALL}
  zip -qrum9 ${INSTALL}${PREFIX}/config/vdr-sample-config.zip storage
}

# TODO:
#   systemd/* nach /storage/.config/system.d kopieren
#
# Automatischer Start von VDR ist möglich durch:
#      cd /storage/.config/system.d
#      ln -s vdr.service kodi.service
# Dies ist allerdings etwas schräg. Aber eine andere Lösung habe ich (noch?) nicht gefunden.


