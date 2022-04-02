# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2014 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

# copy of addons/addon-depends/chrome-depends/libXft

PKG_NAME="_libXft"
PKG_VERSION="2.3.4"
PKG_SHA256="57dedaab20914002146bdae0cb0c769ba3f75214c4c91bd2613d6ef79fc9abdd"
PKG_LICENSE="OSS"
PKG_SITE="http://www.X.org"
PKG_URL="https://xorg.freedesktop.org/archive/individual/lib/libXft-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain fontconfig freetype libXrender util-macros xorgproto"
PKG_LONGDESC="X FreeType library."
PKG_BUILD_FLAGS="+pic -sysroot"

PKG_CONFIGURE_OPTS_TARGET="--enable-shared \
                           --disable-static \
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

post_makeinstall_target() {
  cp -a ${INSTALL}/* ${PKG_CONFIG_SYSROOT_DIR}
}