# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="cxxtools"
PKG_VERSION="3.0"
PKG_SHA256="c48758af8c8bf993a45492fdd8acaf1109357f1c574810e353d3103277b4296b"
PKG_LICENSE="GPL-2"
PKG_SITE="https://github.com/maekitalo/cxxtools"
PKG_URL="https://github.com/maekitalo/cxxtools/archive/refs/tags/V${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="toolchain:host openssl:host"
PKG_DEPENDS_TARGET="toolchain cxxtools:host openssl"
PKG_LONGDESC="Cxxtools is a collection of general-purpose C++ classes."
PKG_BUILD_FLAGS="+pic"

PKG_CONFIGURE_OPTS_HOST="--disable-demos --with-atomictype=pthread --disable-unittest"
PKG_CONFIGURE_OPTS_TARGET="--enable-static --disable-shared --disable-demos --with-atomictype=pthread --disable-unittest"

post_unpack() {
	cd ${PKG_BUILD} && autoreconf -i
}

post_makeinstall_host() {
  rm -rf ${TOOLCHAIN}/bin/cxxtools-config
}

post_makeinstall_target() {
  cp ${PKG_NAME}-config ${TOOLCHAIN}/bin
  sed -e "s:\(['= ]\)/usr:\\1${PKG_ORIG_SYSROOT_PREFIX}/usr:g" -i ${TOOLCHAIN}/bin/${PKG_NAME}-config
  chmod +x ${TOOLCHAIN}/bin/${PKG_NAME}-config

  rm -rf ${INSTALL}/usr/bin
}
