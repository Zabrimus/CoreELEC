# SPDX-License-Identifier: GPL-2.0
# Copyright (C) 2019-present Team LibreELEC (https://libreelec.tv)

# copy of graphics/libglvnd

PKG_NAME="_libglvnd"
PKG_VERSION="1.3.2"
PKG_SHA256="6f41ace909302e6a063fd9dc04760b391a25a670ba5f4b6edf9e30f21410b673"
PKG_LICENSE="GPL"
PKG_SITE="https://github.com/NVIDIA/libglvnd"
PKG_URL="https://github.com/NVIDIA/libglvnd/archive/v${PKG_VERSION}.tar.gz"
PKG_DEPENDS_TARGET="toolchain libX11 libXext xorgproto"
PKG_LONGDESC="libglvnd is a vendor-neutral dispatch layer for arbitrating OpenGL API calls between multiple vendors."

if [ "${OPENGLES_SUPPORT}" = "no" ]; then
  PKG_MESON_OPTS_TARGET="-Dgles1=false \
                         -Dgles2=false \
                         --prefix=/opt/vdr
						 --bindir=/opt/vdr/bin \
                         --libdir=/opt/vdr/lib \
                         --libexecdir=/opt/vdr/bin \
                         --sbindir=/opt/vdr/sbin \
						 "
fi

if [ "${OPENGLES_SUPPORT}" = "yes" ]; then
  PKG_MESON_OPTS_TARGET="--prefix=/opt/vdr
						 --bindir=/opt/vdr/bin \
                         --libdir=/opt/vdr/lib \
                         --libexecdir=/opt/vdr/bin \
                         --sbindir=/opt/vdr/sbin \
						 "
fi

pre_configure_target() {
  export LDFLAGS="$(echo ${LDFLAGS} | sed -e "s|-Wl,--as-needed||") -L${SYSROOT_PREFIX}/opt/vdr/lib"
}
