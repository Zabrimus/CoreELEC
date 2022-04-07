# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

# copy of graphics/glu

PKG_NAME="_glu"
PKG_VERSION="9.0.1"
PKG_SHA256="d02703066406cdcb54b99119b71f869cb1af2bbd403b928f3191daccca874377"
PKG_LICENSE="OSS"
PKG_SITE="http://gitlab.freedesktop.org/mesa/glu/"
PKG_URL="https://gitlab.freedesktop.org/mesa/glu/-/archive/glu-${PKG_VERSION}/glu-glu-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain _libglvnd opengl-meson"
PKG_NEED_UNPACK="$(get_pkg_directory _libglvnd)"
PKG_LONGDESC="libglu is the The OpenGL utility library"
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--disable-silent-rules \
                           --disable-debug \
                           --disable-osmesa \
                           --with-gnu-ld \
                           --prefix=/opt/vdr \
						   --bindir=/opt/vdr/bin \
                           --libdir=/opt/vdr/lib \
                           --libexecdir=/opt/vdr/bin \
                           --sbindir=/opt/vdr/sbin \
                           "

pre_configure_target() {
  export LDFLAGS="$(echo ${LDFLAGS} | sed -e "s|-Wl,--as-needed||") -L${SYSROOT_PREFIX}/opt/vdr/lib"
  export CPPFLAGS="-I${SYSROOT_PREFIX}/opt/vdr/include"
}

