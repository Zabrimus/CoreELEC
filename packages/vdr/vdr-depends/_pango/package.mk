# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

# copy of addons/addon-depends/chrome-depends/pango

PKG_NAME="_pango"
PKG_VERSION="1.49.3"
PKG_SHA256="45c403b89910a121ad8eb6d57b5be1d8f19499d39b686435dc6f29b106d2be93"
PKG_LICENSE="GPL"
PKG_SITE="http://www.pango.org/"
PKG_URL="https://download.gnome.org/sources/pango/${PKG_VERSION:0:4}/pango-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain cairo freetype fontconfig fribidi glib harfbuzz libX11 _libXft"
PKG_DEPENDS_CONFIG="_libXft cairo"
PKG_LONGDESC="The Pango library for layout and rendering of internationalized text."
PKG_TOOLCHAIN="meson"
PKG_BUILD_FLAGS="-sysroot"

PKG_MESON_OPTS_TARGET="-Dgtk_doc=false \
                       -Dintrospection=disabled \
                       --prefix=/usr/local \
                       --bindir=/usr/local/bin \
                       --libdir=/usr/local/lib \
                       --libexecdir=/usr/local/bin \
                       --sbindir=/usr/local/sbin"

pre_configure_target() {
  export LDFLAGS="$(echo ${LDFLAGS} | sed -e "s|-Wl,--as-needed||") -L${SYSROOT_PREFIX}/usr/local/lib"
}

post_makeinstall_target() {
  cp -a ${INSTALL}/* ${PKG_CONFIG_SYSROOT_DIR}
}