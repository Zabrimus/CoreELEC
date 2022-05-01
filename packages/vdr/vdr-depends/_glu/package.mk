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
                           --prefix=${VDR_PREFIX} \
						   --bindir=${VDR_PREFIX}/bin \
                           --libdir=${VDR_PREFIX}/lib \
                           --libexecdir=${VDR_PREFIX}/bin \
                           --sbindir=${VDR_PREFIX}/sbin \
                           "

pre_configure_target() {
  # test if prefix is set
  if [ "x${VDR_PREFIX}" = "x" ]; then
      echo "==> VDR_PREFIX is empty, but must be set"
      exit 1
  fi

  LIBGLVND_DIR=$(get_install_dir _libglvnd)

  export PKG_CONFIG_PATH=${VDR_DIR}:${SYSROOT_PREFIX}/${VDR_PREFIX}/lib/pkgconfig:${LIBGLVND_DIR}/usr//lib/pkg-config:${PKG_CONFIG_PATH}
  export LDFLAGS="$(echo ${LDFLAGS} | sed -e "s|-Wl,--as-needed||") -L${SYSROOT_PREFIX}${VDR_PREFIX}/lib"
  export CPPFLAGS="-I${SYSROOT_PREFIX}${VDR_PREFIX}/include"
}

