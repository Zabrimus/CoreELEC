# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

# copy of graphics/glu

PKG_NAME="_glu"
PKG_VERSION="9.0.2"
PKG_SHA256="6e7280ff585c6a1d9dfcdf2fca489251634b3377bfc33c29e4002466a38d02d4"
PKG_LICENSE="OSS"
PKG_SITE="https://gitlab.freedesktop.org/mesa/glu/"
PKG_URL="https://mesa.freedesktop.org/archive/glu/glu-${PKG_VERSION}.tar.xz"
PKG_DEPENDS_TARGET="toolchain libglvnd opengl-meson"
PKG_NEED_UNPACK="$(get_pkg_directory libglvnd)"
PKG_LONGDESC="libglu is the The OpenGL utility library"
PKG_TOOLCHAIN="autotools"

PKG_CONFIGURE_OPTS_TARGET="--disable-silent-rules \
                           --disable-debug \
                           --disable-osmesa \
                           --with-gnu-ld \
                           --prefix=${VDR_PREFIX} \
						   --bindir=${VDR_PREFIX}/bin \
                           --libdir=${VDR_PREFIX}/lib \
                           --libexecdir=${VDR_PREFIX}/bin \
                           --sbindir=${VDR_PREFIX}/sbin \
                           --enable-libglvnd \
                           "
