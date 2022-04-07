# SPDX-License-Identifier: GPL-2.0-or-later

PKG_NAME="_vdr-plugin-softhdodroid"

PKG_VERSION="03f02196f91922b5a41c79717865268f5a4b077d"
PKG_SHA256="19300dde6b3848c95d4accdacc82cc36bba35fa531fc34276d747051d7789c8f"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/jojo61/vdr-plugin-softhdodroid"
PKG_URL="https://github.com/jojo61/vdr-plugin-softhdodroid/archive/${PKG_VERSION}.zip"
PKG_SOURCE_DIR="vdr-plugin-softhdodroid-${PKG_VERSION}"
PKG_DEPENDS_TARGET="toolchain glm alsa freetype ffmpeg _vdr _glu libdrm opengl-meson"
PKG_NEED_UNPACK="$(get_pkg_directory _vdr)"
PKG_LONGDESC="VDR Output Device (softhdodroid)"
PKG_TOOLCHAIN="manual"

# libglvnd            -> graphics/libglvnd
# opengl-meson        -> Amlogic-ce/devices/Amlogic-ng/packages/opengl-meson
# glm                 -> graphics/glm
# ffmpeg              -> multimedia/ffmpeg
# glu                 -> graphics/glu

pre_configure_target() {
  export LDFLAGS="$(echo ${LDFLAGS} | sed -e "s|-Wl,--as-needed||") -L${SYSROOT_PREFIX}/opt/vdr/lib -L${SYSROOT_PREFIX}/usr/lib"
}

make_target() {
  VDR_DIR=$(get_build_dir _vdr)
  export PKG_CONFIG_PATH=${VDR_DIR}:${PKG_CONFIG_PATH}
  export CPLUS_INCLUDE_PATH=${VDR_DIR}/include

  make KODIBUILD=1
}

makeinstall_target() {
  LOC_DIR=${INSTALL}/$(pkg-config --variable=locdir vdr)
  LIB_DIR=${LOC_DIR}/../../lib/vdr
  VDRDIR=${VDR_DIR}

  make VDRDIR=${VDR_DIR} LOCDIR="${LOC_DIR}" LIBDIR="${LIB_DIR}" KODIBUILD=1 install
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
  zip -qrum9 "${INSTALL}/opt/vdr/config/softhdodroid-sample-config.zip" storage
}

