# SPDX-License-Identifier: GPL-2.0-or-later

PKG_NAME="_vdr-plugin-osdteletext"
PKG_VERSION="cae4629f84886015b0619af6fdb1084853b80f93"
PKG_SHA256="4e1a7a8c64fa68a4cd71aace4cdfa195ae4dedd7f2be7c34191982c752ed2207"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/vdr-projects/vdr-plugin-osdteletext"
PKG_URL="https://github.com/vdr-projects/vdr-plugin-osdteletext/archive/${PKG_VERSION}.zip"
PKG_SOURCE_DIR="vdr-plugin-osdteletext-${PKG_VERSION}"
PKG_DEPENDS_TARGET="toolchain _vdr cairo"
PKG_NEED_UNPACK="$(get_pkg_directory _vdr)"
PKG_LONGDESC="Osd-Teletext displays the teletext directly on the OSD."
PKG_TOOLCHAIN="manual"

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
  export PKG_CONFIG_PATH=${VDR_DIR}:${PKG_CONFIG_PATH}
  export CPLUS_INCLUDE_PATH=${VDR_DIR}/include

  make all
}

makeinstall_target() {
  LIB_DIR=${INSTALL}/$(pkg-config --variable=locdir vdr)/../../lib/vdr
  make DESTDIR="${INSTALL}" LIBDIR="${LIB_DIR}" install

  # install font
  mkdir -p ${INSTALL}${VDR_PREFIX}/share/fonts
  cp -r *.ttf ${INSTALL}${VDR_PREFIX}/share/fonts
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
   zip -qrum9 "${INSTALL}${VDR_PREFIX}/config/osdteletext-sample-config.zip" storage
}

post_install() {
  mkfontdir ${INSTALL}${VDR_PREFIX}/share/fonts
  mkfontscale ${INSTALL}${VDR_PREFIX}/share/fonts
}