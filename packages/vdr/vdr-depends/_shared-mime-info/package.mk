# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2018-present Team LibreELEC (https://libreelec.tv)

PKG_NAME="_shared-mime-info"
PKG_VERSION="2.1"
PKG_SHA256="37df6475da31a8b5fc63a54ba0770a3eefa0a708b778cb6366dccee96393cb60"
PKG_LICENSE="GPL2"
PKG_SITE="https://freedesktop.org/wiki/Software/shared-mime-info/"
PKG_URL="https://gitlab.freedesktop.org/xdg/shared-mime-info/-/archive/${PKG_VERSION}/shared-mime-info-${PKG_VERSION}.tar.bz2"
PKG_DEPENDS_TARGET="toolchain glib libxml2 gettext itstool:host"
PKG_LONGDESC="The shared-mime-info package contains the core database of common types."
PKG_BUILD_FLAGS="-parallel -sysroot"

PKG_MESON_OPTS_TARGET="-Dupdate-mimedb=false \
                       --prefix=/opt/vdr \
                       --bindir=/opt/vdr/bin \
                       --libdir=/opt/vdr/lib \
                       --libexecdir=/opt/vdr/bin \
                       --sbindir=/opt/vdr/sbin \
                       "

pre_configure_target() {
  export LDFLAGS="$(echo ${LDFLAGS} | sed -e "s|-Wl,--as-needed||") -L${SYSROOT_PREFIX}/opt/vdr/lib"
}

post_makeinstall_target() {
  cp -a ${INSTALL}/* ${PKG_CONFIG_SYSROOT_DIR}
}