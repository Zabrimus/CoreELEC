# SPDX-License-Identifier: GPL-2.0-or-later

PKG_NAME="_libcdio_paranoia"
PKG_VERSION="493702cfd256d34bc7197c24f00df0625dce47b5"
PKG_SHA256="7132dda3dc47857c014077f4b8f6906dfd6e14a55f79cf09f414115145d108c1"
PKG_LICENSE="GPL3"
PKG_SITE="http://libcddb.sourceforge.net/index.html"
PKG_URL="https://github.com/rocky/libcdio-paranoia/archive/${PKG_VERSION}.zip"
PKG_SOURCE_DIR="libcdio-paranoia-${PKG_VERSION}"
PKG_DEPENDS_TARGET="toolchain"
PKG_LONGDESC="TODO"
PKG_TOOLCHAIN="configure"

PKG_CONFIGURE_OPTS_TARGET="--prefix=${VDR_PREFIX} \
						   --bindir=${VDR_PREFIX}/bin \
                           --libdir=${VDR_PREFIX}/lib \
                           --libexecdir=${VDR_PREFIX}/bin \
                           --sbindir=${VDR_PREFIX}/sbin \
                           --sysconfdir=${VDR_PREFIX}/etc \
                           --disable-cpp-progs \
                           --disable-example-progs \
                           --with-gnu-ld \
                           --with-pic \
                           --host=XXX \
                           "
pre_configure_target() {
  # test if prefix is set
  if [ "x${VDR_PREFIX}" = "x" ]; then
      echo "==> VDR_PREFIX is empty, but must be set"
      exit 1
  fi

  export LDFLAGS="$(echo ${LDFLAGS} | sed -e "s|-Wl,--as-needed||") -L${SYSROOT_PREFIX}${VDR_PREFIX}/lib"

  ./autogen.sh
}
