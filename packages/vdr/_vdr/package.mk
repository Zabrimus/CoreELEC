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
PKG_DEPENDS_TARGET="toolchain bzip2 fontconfig freetype libcap _libiconv libjpeg-turbo"
PKG_LONGDESC="A DVB TV server application."
PKG_TOOLCHAIN="manual"

# bzip2            -> compress/bzip2
# fontconfig       -> x11/other/fontconfig
# freetype         -> print/freetype
# libcap           -> devel/libcap
# libiconv         -> addons/addon-depends/libiconv
# libjpeg-turbo    -> graphics/libjpeg-turbo

post_unpack() {
  rm -rf ${PKG_BUILD}/PLUGINS/src/skincurses
}

pre_configure_target() {
  export LDFLAGS="$(echo ${LDFLAGS} | sed -e "s|-Wl,--as-needed||") -L${SYSROOT_PREFIX}/usr/local/lib/iconv"
}

pre_make_target() {
  cat > Make.config <<EOF
  PREFIX = /usr/local/vdr-2.6.1
  VIDEODIR = /storage/videos
  CONFDIR = /storage/.config/vdropt
  LIBS += -liconv
  VDR_USER=root
EOF
}

make_target() {
  make vdr vdr.pc
}

makeinstall_target() {
  PREFIX="/usr/local/vdr-2.6.1"
  CONFDIR="/storage/.config/vdropt"

  make DESTDIR="${INSTALL}" install
  cp -r "`find ${INSTALL}/home -name sysroot`"/* ${INSTALL}

  cat ${PKG_DIR}/bin/start_vdr.sh | sed "s#XXCONFDIRXX#${CONFDIR}# ; s#XXBINDIRXX#${PREFIX}/bin#" > ${INSTALL}/${PREFIX}/bin/start_vdr.sh
  chmod +x ${INSTALL}/${PREFIX}/bin/start_vdr.sh
}

post_makeinstall_target() {
  VDR_DIR=$(get_install_dir _vdr)

  rm -R ${INSTALL}/home

  # move configuration to another folder to prevent overwriting existing configuration after installation
  mv ${VDR_DIR}/storage/.config/vdropt ${VDR_DIR}/storage/.config/vdropt-sample

  mkdir -p ${VDR_DIR}/storage/.config/vdropt-sample/conf.d
  cp -PR ${PKG_DIR}/config/*.conf ${VDR_DIR}/storage/.config/vdropt-sample/conf.d/

  cat >> ${VDR_DIR}/storage/.config/vdropt-sample/enabled_plugins <<EOF
softhddroid
satip
EOF

  cp ${PKG_DIR}/vdropt/README ${VDR_DIR}/storage/.config/vdropt

  if find ${INSTALL}/storage/.config/vdropt -mindepth 1 -maxdepth 1 2>/dev/null | read; then
     cp -ar ${INSTALL}/storage/.config/vdropt/* ${INSTALL}/storage/.config/vdropt-sample
     rm -Rf ${INSTALL}/storage/.config/vdropt/*
  fi
}

# zip -qum9 test.zip test.txt