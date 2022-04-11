# SPDX-License-Identifier: GPL-2.0-or-later

PKG_NAME="_imagemagick"
PKG_VERSION="6.9.11-60"
PKG_SHA256="d32a11dc92ae03b4c85314dec51d68c7a69da49868391f50182d22602b334e1b"
PKG_LICENSE="ImageMagick License"
PKG_SITE="https://imagemagick.org"
PKG_URL="https://github.com/ImageMagick/ImageMagick6/archive/refs/tags/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="Use ImageMagick to create, edit, compose, or convert digital images."

PKG_CONFIGURE_OPTS_TARGET="--disable-openmp \
                           --prefix=${VDR_PREFIX} \
						   --bindir=${VDR_PREFIX}/bin \
                           --libdir=${VDR_PREFIX}/lib \
                           --libexecdir=${VDR_PREFIX}/bin \
                           --sbindir=${VDR_PREFIX}/sbin \
                            --sysconfdir=${VDR_PREFIX}/etc \
                           "
pre_configure_target() {
  # test if prefix is set
  if [ "x${VDR_PREFIX}" = "x" ]; then
      echo "==> VDR_PREFIX is empty, but must be set"
      exit 1
  fi

  export LDFLAGS="$(echo ${LDFLAGS} | sed -e "s|-Wl,--as-needed||") -L${SYSROOT_PREFIX}${VDR_PREFIX}/lib"
}

