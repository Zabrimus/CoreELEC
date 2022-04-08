# SPDX-License-Identifier: GPL-2.0-or-later

PKG_NAME="_vdr-plugin-epg2vdr"
PKG_VERSION="1.2.6"
PKG_SHA256="254d6252dbe1323b6affbd6c0c365ab611b2f11e0e009deb1c0154c57691a446"
PKG_LICENSE="GPL"
PKG_SITE="https://projects.vdr-developer.org/git/vdr-plugin-epg2vdr.git"
PKG_URL="https://projects.vdr-developer.org/git/vdr-plugin-epg2vdr.git/snapshot/vdr-plugin-epg2vdr-${PKG_VERSION}.tar.gz"
PKG_SOURCE_DIR="vdr-plugin-epg2vdr-${PKG_VERSION}"
PKG_DEPENDS_TARGET="toolchain _vdr Python3 util-linux mariadb-connector-c _jansson tinyxml2 libarchive"
PKG_NEED_UNPACK="$(get_pkg_directory _vdr) $(get_pkg_directory Python3) $(get_pkg_directory mariadb-connector-c)"
PKG_LONGDESC="This plugin is used to retrieve EPG data into the VDR. The EPG data was loaded from a mariadb database."
PKG_TOOLCHAIN="manual"

# Python3             -> lang/Python3
# util-linux          -> sysutils/util-linux
# mariadb-connector-c -> databases/mariadb-connector-c
# tinyxml             -> textproc/tinyxml
# jansson             -> vdr-depends/jansson
# tinyxml2            -> textproc/tinyxml2
# libarchive          -> compress/libarchive

pre_configure_target() {
  export LDFLAGS="$(echo ${LDFLAGS} | sed -e "s|-Wl,--as-needed||") -L${SYSROOT_PREFIX}/opt/vdr/lib"
}

make_target() {
  PYTHON_INSTALL_DIR=$(get_install_dir Python3)
  VDR_DIR=$(get_build_dir _vdr)

  export PKG_CONFIG_PATH=${VDR_DIR}:${PYTHON_INSTALL_DIR}/usr/lib/pgkconfig:${PKG_CONFIG_PATH}
  export CPLUS_INCLUDE_PATH=${VDR_DIR}/include

  MARIADB_CFLAGS=$(pkg-config --cflags libmariadb)
  MARIADB_LIBS=$(pkg-config --libs libmariadb)

  PYTHON3_CFLAGS=$(pkg-config --cflags python3)
  PYTHON3_LIBS=$(pkg-config --libs python3)
  PYTHON3_LIBS_EMBED=$(pkg-config --libs python3-embed)

  make PYTHON3_CFLAGS="${PYTHON3_CFLAGS}" PYTHON3_LIBS="${PYTHON3_LIBS}" PYTHON3_LIBS_EMBED="${PYTHON3_LIBS_EMBED}" MARIADB_CFLAGS="${MARIADB_CFLAGS}" MARIADB_LIBS="${MARIADB_LIBS}"
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
    rm -Rf ${INSTALL}/storage/.config/vdropt
  fi

  # create config.zip
  VERSION=$(pkg-config --variable=apiversion vdr)
  cd ${INSTALL}
  mkdir -p ${INSTALL}/opt/vdr/config/
  zip -qrum9 "${INSTALL}/opt/vdr/config/epg2vdr-sample-config.zip" storage
}
