# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

# Copy of addons/addon-depends/cxxtools

PKG_NAME="_cxxtools"
PKG_VERSION="2.2.1"
PKG_SHA256="8cebb6d6cda7c93cc4f7c0d552a68d50dd5530b699cf87916bb3b708fdc4e342"
PKG_LICENSE="GPL-2"
PKG_SITE="http://www.tntnet.org/cxxtools.html"
PKG_URL="http://www.tntnet.org/download/cxxtools-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="toolchain:host"
PKG_DEPENDS_TARGET="toolchain cxxtools:host"
PKG_LONGDESC="Cxxtools is a collection of general-purpose C++ classes."
PKG_BUILD_FLAGS="+pic"

PKG_CONFIGURE_OPTS_HOST="--disable-demos \
                         --with-atomictype=pthread \
                         --disable-unittest \
                         --prefix=/usr/local"

PKG_CONFIGURE_OPTS_TARGET="--disable-static \
                           --enable-shared \
                           --disable-demos \
                           --with-atomictype=pthread \
                           --disable-unittest \
                           --prefix=/usr/local \
                           --exec-prefix=/usr/local \
                           --bindir=/usr/local/bin \
                           --sbindir=/usr/local/sbin \
                           --sysconfdir=/etc \
                           --libdir=/usr/local/lib \
                           --libexecdir=/usr/local/lib"

pre_configure_target() {
  export LDFLAGS="$(echo ${LDFLAGS} | sed -e "s|-Wl,--as-needed||") -L${SYSROOT_PREFIX}/usr/local/lib"
}

post_makeinstall_host() {
   rm -rf ${INSTALL}/usr/local/bin/cxxtools-config
}

post_makeinstall_target() {
   # chmod +x ${TOOLCHAIN}/bin/cxxtools-config
   echo "post_makeinstall_target"
}
