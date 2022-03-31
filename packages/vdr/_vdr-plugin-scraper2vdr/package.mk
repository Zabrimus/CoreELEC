# SPDX-License-Identifier: GPL-2.0-or-later

PKG_NAME="_vdr-plugin-scraper2vdr"
PKG_VERSION="1.0.12"
PKG_SHA256="5e40763e06d218ee0f1993794a1d4b90da7877003ae749d48ee144753d6d26b7"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/horchi/scraper2vdr"
PKG_URL="https://github.com/horchi/scraper2vdr/archive/refs/tags/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain _vdr mariadb-connector-c imagemagick"
PKG_NEED_UNPACK="$(get_pkg_directory _vdr) $(get_pkg_directory Python3) $(get_pkg_directory mariadb-connector-c)"
PKG_LONGDESC="scraper2vdr acts as client and provides scraped metadata for tvshows and movies from epgd to other plugins via its service interface."
PKG_TOOLCHAIN="manual"

# mariadb-connector-c -> databases/mariadb-connector-c
# imagemagick         -> vdr/vdr-depends/imagemagick

make_target() {
  VDR_DIR=$(get_build_dir _vdr)

  export PKG_CONFIG_PATH=${VDR_DIR}:${PKG_CONFIG_PATH}
  export CPLUS_INCLUDE_PATH=${VDR_DIR}/include

  MARIADB_CFLAGS=$(pkg-config --cflags libmariadb)
  MARIADB_LIBS=$(pkg-config --libs libmariadb)

  make MARIADB_CFLAGS="${MARIADB_CFLAGS}" MARIADB_LIBS="${MARIADB_LIBS}" SHELL="sh -x"
}

makeinstall_target() {
  LIB_DIR=${INSTALL}/$(pkg-config --variable=locdir vdr)/../../lib/vdr
  make DESTDIR="${INSTALL}" LIBDIR="${LIB_DIR}" install
}

post_makeinstall_target() {
  mkdir -p ${INSTALL}/storage/.config/vdropt-sample/conf.d
  cp -PR ${PKG_DIR}/config/*.conf ${INSTALL}/storage/.config/vdropt-sample/conf.d/

  if find ${INSTALL}/storage/.config/vdropt -mindepth 1 -maxdepth 1 2>/dev/null | read; then
    cp -ar ${INSTALL}/storage/.config/vdropt/* ${INSTALL}/storage/.config/vdropt-sample
    rm -Rf ${INSTALL}/storage/.config/vdropt/*
  fi
}
