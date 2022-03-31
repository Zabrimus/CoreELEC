# SPDX-License-Identifier: GPL-2.0-or-later
# Copyright (C) 2009-2016 Stephan Raue (stephan@openelec.tv)
# Copyright (C) 2017-present Team LibreELEC (https://libreelec.tv)

# Copy of addons/addon-depends/tntnet

PKG_NAME="_tntnet"
PKG_VERSION="2.2.1"
PKG_SHA256="c83170d08ef04c5868051e1c28c74b9562fe71e9e8263828e755ad5bd3547521"
PKG_LICENSE="GPL-2"
PKG_SITE="http://www.tntnet.org/"
PKG_URL="http://www.tntnet.org/download/tntnet-${PKG_VERSION}.tar.gz"
PKG_DEPENDS_HOST="cxxtools:host zlib:host"
PKG_DEPENDS_TARGET="toolchain tntnet:host libtool _cxxtools zlib"
PKG_LONGDESC="A web application server for C++."

PKG_CONFIGURE_OPTS_HOST="--disable-unittest \
                         --prefix=/usr/local \
                         --libdir=/usr/local/lib \
                         --sbindir=/usr/local/sbin \
						 --bindir=/usr/local/bin \
						 --libexecdir=/usr/local/lib \
 						 --sysconfdir=/usr/local/etc \
                         --with-server=no \
                         --with-sdk=yes \
                         --with-demos=no \
                         --with-epoll=yes \
                         --with-ssl=no \
                         --with-stressjob=no"

PKG_CONFIGURE_OPTS_TARGET="--disable-unittest \
                           --prefix=/usr/local \
                           --libdir=/usr/local/lib \
                           --sbindir=/usr/local/sbin \
						   --bindir=/usr/local/bin \
						   --libexecdir=/usr/local/lib \
 						   --sysconfdir=/usr/local/etc \
                           --with-server=no \
                           --with-sdk=no \
                           --with-demos=no \
                           --with-epoll=yes \
                           --with-ssl=no \
                           --with-stressjob=no"

pre_configure_target() {
  export LDFLAGS="$(echo ${LDFLAGS} | sed -e "s|-Wl,--as-needed||") -L${SYSROOT_PREFIX}/usr/local/lib"
}

post_makeinstall_target() {
  # rm -rf ${INSTALL}/usr/bin/${PKG_NAME}-config
  # cp ${PKG_NAME}-config ${TOOLCHAIN}/bin
  # sed -e "s:\(['= ]\)/usr:\\1${PKG_ORIG_SYSROOT_PREFIX}/usr:g" -i ${TOOLCHAIN}/bin/${PKG_NAME}-config
  # chmod +x ${TOOLCHAIN}/bin/${PKG_NAME}-config

  # rm -rf ${INSTALL}/usr/bin
  # rm -rf ${INSTALL}/usr/share
  echo "Hallo"
}
