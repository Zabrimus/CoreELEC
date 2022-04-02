# SPDX-License-Identifier: GPL-2.0-or-later

PKG_NAME="librsvg"
PKG_VERSION="2.54"
PKG_SHA256="baf8ebc147f146b4261bb3d0cd0fac944bf8dbb4b1f2347d23341f974dcc3085"
PKG_LICENSE="LGPL 2.1"
PKG_SITE="https://gitlab.gnome.org/GNOME/librsvg"
PKG_URL="${SOURCEFORGE_SRC}/libpng/${PKG_NAME}-${PKG_VERSION}.tar.xz"
PKG_URL="https://download.gnome.org/sources/${PKG_NAME}/${PKG_VERSION}/${PKG_NAME}-${PKG_VERSION}.0.tar.xz"
PKG_DEPENDS_HOST=""
PKG_DEPENDS_TARGET="toolchain cairo _rust _gdk-pixbuf _pango shared-mime-info glib libjpeg-turbo libpng jasper _shared-mime-info tiff freetype gobject-introspection"
PKG_DEPENDS_CONFIG="_shared-mime-info _gdk-pixbuf _pango"
PKG_LONGDESC="A library to render SVG images to Cairo surfaces."
PKG_TOOLCHAIN="configure"
PKG_BUILD_FLAGS=""

PKG_CONFIGURE_OPTS_TARGET="ac_cv_lib_z_zlibVersion=yes \
                           --enable-shared \
                           --disable-static  \
                           --with-sysroot=${SYSROOT_PREFIX} \
                           --target=arm-unknown-linux-gnueabihf \
                           --host=arm-unknown-linux-gnueabihf \
                           --enable-introspection=no \
                           --disable-pixbuf-loader
                           "

PKG_CONFIGURE_OPTS_HOST="-disable-static --enable-shared"

#post_unpack() {
#	rm $(get_build_dir librsvg)/configure
#}

#pre_configure_host() {
#  export CPPFLAGS="${CPPFLAGS} -I${TOOLCHAIN}/include"
#}

pre_configure_target() {
  cd $(get_build_dir librsvg)
  aclocal --install || exit 1
  autoreconf --verbose --force --install || exit 1

  export CPPFLAGS="${CPPFLAGS} -I${SYSROOT_PREFIX}/usr/include"
  . "$(get_build_dir _rust)/cargo/env"

  export PKG_CONFIG_PATH="${SYSROOT_PREFIX}/usr/local/lib/pkgconfig":"${SYSROOT_PREFIX}/usr/local/share/pkgconfig":${PKG_CONFIG_PATH}
  export PATH="${SYSROOT_PREFIX}/usr/local/bin":$PATH
  export LDFLAGS="$(echo ${LDFLAGS} | sed -e "s|-Wl,--as-needed||") -L${SYSROOT_PREFIX}/usr/local/lib"
}

#post_makeinstall_target() {
#  sed -e "s:\([\"'= ]\)/usr:\\1${SYSROOT_PREFIX}/usr:g" \
#      -e "s:libs=\"-lpng16\":libs=\"-lpng16 -lz\":g" \
#      -i ${SYSROOT_PREFIX}/usr/bin/libpng*-config
#
#  rm -rf ${INSTALL}/usr/bin
#}
