# SPDX-License-Identifier: GPL-2.0-or-later

PKG_NAME="_vdr-plugin-skindesigner"
PKG_VERSION="1.2.18"
PKG_SHA256="4ac259c2b2c9dadd140a22a7305be8965a9be6dfd7d9829b832ea95a667f1349"
PKG_LICENSE="GPL"
PKG_SITE="https://projects.vdr-developer.org/git/vdr-plugin-skindesigner.git/"
PKG_URL="https://projects.vdr-developer.org/git/vdr-plugin-skindesigner.git/snapshot/vdr-plugin-skindesigner-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain _vdr cairo _librsvg _fonts"
PKG_NEED_UNPACK="$(get_pkg_directory _vdr)"
PKG_LONGDESC="A VDR skinning engine that displays XML based Skins"
PKG_TOOLCHAIN="manual"

pre_configure_target() {
  export LDFLAGS="$(echo ${LDFLAGS} | sed -e "s|-Wl,--as-needed||") -L${SYSROOT_PREFIX}/opt/vdr/lib"
}

make_target() {
  VDR_DIR=$(get_build_dir _vdr)
  export PKG_CONFIG_PATH=${VDR_DIR}:"${SYSROOT_PREFIX}/opt/vdr/lib/pkgconfig":"${SYSROOT_PREFIX}/opt/vdr/share/pkgconfig":${PKG_CONFIG_PATH}
  export CPLUS_INCLUDE_PATH=${VDR_DIR}/include
  export PATH="${SYSROOT_PREFIX}/opt/vdr/bin":$PATH
  SKINDESIGNER_SCRIPTDIR="/storage/.config/vdropt/plugins/skindesigner/scripts"

  make SKINDESIGNER_SCRIPTDIR="${SKINDESIGNER_SCRIPTDIR}"
}

makeinstall_target() {
  LIB_DIR=${INSTALL}/$(pkg-config --variable=locdir vdr)/../../lib/vdr
  PLGRES_DIR="${INSTALL}/storage/.config/vdropt-sample/plugins/skindesigner"
  SKINDESIGNER_SCRIPTDIR="/storage/.config/vdropt/plugins/skindesigner/scripts"

  make DESTDIR="${INSTALL}" LIBDIR="${LIB_DIR}" PLGRESDIR="${PLGRES_DIR}" SKINDESIGNER_SCRIPTDIR="${SKINDESIGNER_SCRIPTDIR}" install

  # install font
  mkdir -p ${INSTALL}/opt/vdr/share/fonts
  cp -r fonts/VDROpenSans ${INSTALL}/opt/vdr/share/fonts
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
  zip -qrum9 "${INSTALL}/opt/vdr/config/skindesigner-sample-config.zip" storage
}

post_install() {
  mkfontdir ${INSTALL}/opt/vdr/share/fonts
  mkfontscale ${INSTALL}/opt/vdr/share/fonts
}
