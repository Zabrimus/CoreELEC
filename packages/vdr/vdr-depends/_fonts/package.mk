# SPDX-License-Identifier: GPL-2.0-or-later

PKG_NAME="_fonts"
PKG_VERSION="e37c7631ae3d86e5096bfe6d4fff4ed9c6639850"
PKG_SHA256="7a9ac2613389ccbe0e8e9a6ac824063f7c96bd859e3b2fdfb3dd70600b6772d7"
PKG_LICENSE="Apache License"
PKG_SITE="https://github.com/Zabrimus/fonts"
PKG_URL="https://github.com/Zabrimus/fonts/archive/${PKG_VERSION}.zip"
PKG_TOOLCHAIN="manual"

unpack() {
  mkdir -p ${PKG_BUILD}/
  cd ${PKG_BUILD}
  unzip ${SOURCES}/${PKG_NAME}/${PKG_NAME}-${PKG_VERSION}.zip
}

pre_configure_target() {
  #mkdir -p ${PKG_BUILD}/
  #cd ${PKG_BUILD}
  #unzip -f ${SOURCES}/${PKG_NAME}/${PKG_NAME}-${PKG_VERSION}.zip

  # test if prefix is set
  if [ "x${VDR_PREFIX}" = "x" ]; then
      echo "==> VDR_PREFIX is empty, but must be set"
      exit 1
  fi
}

make_target() {
    FONTDIR=$(echo ${PKG_NAME}-${PKG_VERSION} | sed -e s:_::g)

	mkdir -p ${INSTALL}/usr/local/vdrshare/fonts/android
	cp  ${PKG_BUILD}/${FONTDIR}/fonts-android-4.3/{*.ttf,fonts.dir,fonts.scale} ${INSTALL}/usr/local/vdrshare/fonts/android/

	mkdir -p ${INSTALL}/usr/local/vdrshare/fonts/sourcesanspro
	cp ${PKG_BUILD}/${FONTDIR}/fonts-sourcesanspro/{*.ttf,fonts.dir,fonts.scale} ${INSTALL}/usr/local/vdrshare/fonts/sourcesanspro/

	mkdir -p ${INSTALL}/usr/local/vdrshare/fonts/ds-digital
	cp ${PKG_BUILD}/${FONTDIR}/fonts-ds-digital/{*.ttf,fonts.dir,fonts.scale} ${INSTALL}/usr/local/vdrshare/fonts/ds-digital/

	mkdir -p ${INSTALL}/usr/local/vdrshare/fonts/teletext
    cp ${PKG_BUILD}/${FONTDIR}/fonts-teletext/{*.ttf,fonts.dir,fonts.scale} ${INSTALL}/usr/local/vdrshare/fonts/teletext/

#	mkdir -p ${INSTALL}/storage/.fonts/android
#	cp  ${FONTDIR}/fonts-android-4.3/{*.ttf,fonts.dir,fonts.scale} ${INSTALL}/storage/.fonts/android/

#	mkdir -p ${INSTALL}/storage/.fonts/sourcesanspro
#	cp  ${FONTDIR}/fonts-sourcesanspro/{*.ttf,fonts.dir,fonts.scale} ${INSTALL}/storage/.fonts/sourcesanspro/

#	mkdir -p ${INSTALL}/storage/.fonts/ds-digital
#	cp ${FONTDIR}/fonts-ds-digital/{*.ttf,fonts.dir,fonts.scale} ${INSTALL}/storage/.fonts/ds-digital/

#	mkdir -p ${INSTALL}/storage/.fonts/teletext
#    cp ${FONTDIR}/fonts-teletext/{*.ttf,fonts.dir,fonts.scale} ${INSTALL}/storage/.fonts/teletext/
}
