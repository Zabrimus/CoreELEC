# SPDX-License-Identifier: GPL-2.0-or-later

PKG_NAME="_fonts"
PKG_VERSION="1401504b0779f251ed9445c2199173a23fd4bf3b"
PKG_SHA256="a3261e80ae0ffabd1eb07e6a2e3de6966c5ae0db99e32d3ecc419aa159feff80"
PKG_LICENSE="Apache License"
PKG_SITE="https://github.com/Zabrimus/fonts"
PKG_URL="https://github.com/Zabrimus/fonts/archive/${PKG_VERSION}.zip"
PKG_TOOLCHAIN="manual"

unpack() {
  mkdir -p ${PKG_BUILD}/
  cd ${PKG_BUILD}
  unzip ${SOURCES}/${PKG_NAME}/${PKG_NAME}-${PKG_VERSION}.zip
}

make_target() {
    FONTDIR=$(echo ${PKG_NAME}-${PKG_VERSION} | sed -e s:_::g)

	mkdir -p ${INSTALL}/usr/local/share/fonts/android
	cp  ${FONTDIR}/fonts-android-4.3/*.ttf ${INSTALL}/usr/local/share/fonts/android/

	mkdir -p ${INSTALL}/usr/local/share/fonts/sourcesanspro
	cp  ${FONTDIR}/fonts-sourcesanspro/*.ttf ${INSTALL}/usr/local/share/fonts/sourcesanspro/

	mkdir -p ${INSTALL}/usr/local/share/fonts/ds-digital
	cp ${FONTDIR}/fonts-ds-digital/*.ttf ${INSTALL}/usr/local/share/fonts/ds-digital/
}

post_install() {
  mkfontdir ${INSTALL}/usr/local/share/fonts/android
  mkfontscale ${INSTALL}/usr/local/share/fonts/android

  mkfontdir ${INSTALL}/usr/local/share/fonts/sourcesanspro
  mkfontscale ${INSTALL}/usr/local/share/fonts/sourcesanspro

  mkfontdir ${INSTALL}/usr/local/share/fonts/ds-digital
  mkfontscale ${INSTALL}/usr/local/share/fonts/ds-digital
}
