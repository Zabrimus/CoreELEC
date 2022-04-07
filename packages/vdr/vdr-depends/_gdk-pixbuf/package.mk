# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2012 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2016-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="_gdk-pixbuf"
PKG_VERSION="2.42.6"
PKG_SHA256="c4a6b75b7ed8f58ca48da830b9fa00ed96d668d3ab4b1f723dcf902f78bde77f"
PKG_LICENSE="OSS"
PKG_SITE="http://www.gtk.org/"
PKG_URL="https://ftp.gnome.org/pub/gnome/sources/gdk-pixbuf/${PKG_VERSION:0:4}/gdk-pixbuf-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain glib libjpeg-turbo libpng jasper _shared-mime-info tiff libX11"
PKG_DEPENDS_CONFIG="_shared-mime-info"
PKG_LONGDESC="GdkPixbuf is a a GNOME library for image loading and manipulation."

PKG_MESON_OPTS_TARGET="-Ddocs=false \
                       -Dintrospection=disabled \
                       -Dman=false \
                       -Drelocatable=false \
                       --prefix=/opt/vdr \
                       --bindir=/opt/vdr/bin \
                       --libdir=/opt/vdr/lib \
                       --libexecdir=/opt/vdr/bin \
                       --sbindir=/opt/vdr/sbin \
                       --pkg-config-path=$(get_install_dir _shared-mime-info)/opt/vdr/share/pkgconfig \
                       "

pre_configure_target() {
  export LDFLAGS="$(echo ${LDFLAGS} | sed -e "s|-Wl,--as-needed||") -L${SYSROOT_PREFIX}/opt/vdr/lib"
  export CPPFLAGS="-I${SYSROOT_PREFIX}/opt/vdr/include"
  export PKG_CONFIG_PATH="${SYSROOT_PREFIX}/opt/vdr/share/pkgconfig":${PKG_CONFIG_PATH}
}

post_makeinstall_target() {
  cp -a ${INSTALL}/* ${PKG_CONFIG_SYSROOT_DIR}
}