# SPDX-License-Identifier: GPL-2.0-or-later

PKG_NAME="_vdr-plugin-live"
PKG_VERSION="b2938deb061a83454d14aeb149c18a87e38e8b25"
PKG_SHA256="f74844fad4f0c3fd828816fd3f094ff740d82d31a164b0cd6384aff9fb7e33b8"
PKG_LICENSE="GPL"
PKG_SITE="http://live.vdr-developer.org/en/index.php"
PKG_URL="https://github.com/MarkusEh/vdr-plugin-live/archive/${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain _vdr tntnet pcre:host pcre libiconv"
PKG_NEED_UNPACK="$(get_pkg_directory _vdr)"
PKG_LONGDESC="Allows a comfortable operation of VDR and some of its plugins trough a web interface."
PKG_TOOLCHAIN="manual"
PKG_BUILD_FLAGS="+pic -parallel"

pre_configure_target() {
  # test if prefix is set
  if [ "x${VDR_PREFIX}" = "x" ]; then
      echo "==> VDR_PREFIX is empty, but must be set"
      exit 1
  fi

  export LDFLAGS="$(echo ${LDFLAGS} | sed -e "s|-Wl,--as-needed||") -L${SYSROOT_PREFIX}${VDR_PREFIX}/lib"
}

make_target() {
  VDR_DIR=$(get_build_dir _vdr)
  export PKG_CONFIG_PATH=${VDR_DIR}:${SYSROOT_PREFIX}/${VDR_PREFIX}/lib/pkgconfig:${PKG_CONFIG_PATH}
  export CPLUS_INCLUDE_PATH=${VDR_DIR}/include

  make
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
  mkdir -p ${INSTALL}${VDR_PREFIX}/config/
  zip -qrum9 "${INSTALL}${VDR_PREFIX}/config/live-sample-config.zip" storage
}
