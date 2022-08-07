# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="tntnet"
PKG_VERSION="3.0"
PKG_SHA256="bc16249f7af7c7b407ec37bb397fe1eb8b54d2410dd5208531ca58908fc19f48"
PKG_LICENSE="GPL-2"
PKG_SITE="https://github.com/maekitalo/tntnet"
PKG_URL="https://github.com/maekitalo/tntnet/archive/refs/tags/V${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="cxxtools:host zlib:host"
PKG_DEPENDS_TARGET="toolchain tntnet:host libtool cxxtools zlib"
PKG_LONGDESC="A web application server for C++."

PKG_CONFIGURE_OPTS_HOST="--disable-unittest \
                         --with-server=no \
                         --with-sdk=yes \
                         --with-demos=no \
                         --with-epoll=yes \
                         --with-ssl=no \
                         --with-stressjob=no"

PKG_CONFIGURE_OPTS_TARGET="--disable-unittest \
                           --with-sysroot=${SYSROOT_PREFIX} \
                           --with-server=no \
                           --with-sdk=no \
                           --with-demos=no \
                           --with-epoll=yes \
                           --with-ssl=no \
                           --with-stressjob=no"

post_unpack() {
	cd ${PKG_BUILD} && patch -p1 < ${PKG_DIR}/patches/autoreconf.unpack_patch && autoreconf -i
}

post_configure_target() {
  libtool_remove_rpath libtool
}

post_makeinstall_target() {
  rm -rf ${INSTALL}/usr/bin
  rm -rf ${INSTALL}/usr/share
}
