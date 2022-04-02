# SPDX-License-Identifier: GPL-2.0-or-later

PKG_NAME="imagemagick"
PKG_VERSION="7.1.0-28"
PKG_SHA256="771538be92d6b1314345d9deb2533bd187ff8701f0f129c25c9c634f9b91f8dc"
PKG_LICENSE="ImageMagick License"
PKG_SITE="https://imagemagick.org"
PKG_URL="https://github.com/ImageMagick/ImageMagick/archive/refs/tags/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Use ImageMagick to create, edit, compose, or convert digital images."

PKG_CONFIGURE_OPTS_TARGET="--disable-openmp"

pre_configure_target() {
  export LDFLAGS="$(echo ${LDFLAGS} | sed -e "s|-Wl,--as-needed||") -L${SYSROOT_PREFIX}/usr/local/lib"
}
