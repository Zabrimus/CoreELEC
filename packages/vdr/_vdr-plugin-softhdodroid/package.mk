# SPDX-License-Identifier: GPL-2.0-or-later

PKG_NAME="_vdr-plugin-softhdodroid"
PKG_VERSION="fa7b4e2f8c56975b1072fbd2de6436ce3662fd8a"
PKG_SHA256="5002335f1efcbfc10386f31eb346fc0b16312dbc4de9b644d7c3fb55c0df9e68"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/jojo61/vdr-plugin-softhdodroid"
PKG_URL="https://github.com/jojo61/vdr-plugin-softhdodroid/archive/${PKG_VERSION}.zip"
PKG_SOURCE_DIR="vdr-plugin-softhdodroid-${PKG_VERSION}"
PKG_DEPENDS_TARGET="toolchain libglvnd opengl-meson libdrm glm ffmpeg _vdr glu"
PKG_NEED_UNPACK="$(get_pkg_directory _vdr)"
PKG_LONGDESC="VDR Output Device (softhdodroid)"
PKG_TOOLCHAIN="manual"

# libglvnd            -> graphics/libglvnd
# opengl-meson        -> Amlogic-ce/devices/Amlogic-ng/packages/opengl-meson
# libdrm              -> graphics/libdrm
# glm                 -> graphics/glm
# ffmpeg              -> multimedia/ffmpeg
# glu                 -> graphics/glu

make_target() {
  VDR_DIR=$(get_build_dir _vdr)
  export PKG_CONFIG_PATH=${VDR_DIR}:${PKG_CONFIG_PATH}
  export CPLUS_INCLUDE_PATH=${VDR_DIR}/include

  make LIBS=-L/var/lib
}

makeinstall_target() {
  LOC_DIR=${INSTALL}/$(pkg-config --variable=locdir vdr)
  LIB_DIR=${LOC_DIR}/../../lib/vdr
  VDRDIR=${VDR_DIR}

  make VDRDIR=${VDR_DIR} LOCDIR="${LOC_DIR}" LIBDIR="${LIB_DIR}" install
}

post_makeinstall_target() {
  mkdir -p ${INSTALL}/storage/.config/vdropt-sample/conf.d
  cp -PR ${PKG_DIR}/config/*.conf ${INSTALL}/storage/.config/vdropt-sample/conf.d/

  if find ${INSTALL}/storage/.config/vdropt -mindepth 1 -maxdepth 1 2>/dev/null | read; then
    cp -ar ${INSTALL}/storage/.config/vdropt/* ${INSTALL}/storage/.config/vdropt-sample
    rm -Rf ${INSTALL}/storage/.config/vdropt/*
  fi
}
