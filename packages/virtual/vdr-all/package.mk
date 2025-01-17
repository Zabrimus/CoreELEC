# SPDX-License-Identifier: GPL-2.0-or-later

PKG_NAME="vdr-all"
PKG_VERSION=""
PKG_LICENSE="GPL"
PKG_SITE="http://www.tvdr.de"
PKG_URL=""
PKG_DEPENDS_TARGET="toolchain"
PKG_SECTION="virtual"
PKG_LONGDESC="A DVB TV server application."

PKG_DEPENDS_TARGET+=" _vdr"
PKG_DEPENDS_TARGET+=" _vdr-plugin-softhdodroid"
PKG_DEPENDS_TARGET+=" _vdr-plugin-satip"
PKG_DEPENDS_TARGET+=" _vdr-plugin-ddci2"
PKG_DEPENDS_TARGET+=" _vdr-plugin-dummydevice"
PKG_DEPENDS_TARGET+=" _vdr-plugin-dvbapi"
PKG_DEPENDS_TARGET+=" _vdr-plugin-eepg"
PKG_DEPENDS_TARGET+=" _vdr-plugin-epgfixer"
PKG_DEPENDS_TARGET+=" _vdr-plugin-epgsearch"
PKG_DEPENDS_TARGET+=" _vdr-plugin-iptv"
PKG_DEPENDS_TARGET+=" _vdr-plugin-live"
PKG_DEPENDS_TARGET+=" _vdr-plugin-restfulapi"
PKG_DEPENDS_TARGET+=" _vdr-plugin-robotv"
PKG_DEPENDS_TARGET+=" _vdr-plugin-streamdev"
PKG_DEPENDS_TARGET+=" _vdr-plugin-vnsiserver"
PKG_DEPENDS_TARGET+=" _vdr-plugin-wirbelscan"
PKG_DEPENDS_TARGET+=" _vdr-plugin-wirbelscancontrol"
PKG_DEPENDS_TARGET+=" _vdr-plugin-osdteletext"
PKG_DEPENDS_TARGET+=" _vdr-plugin-zaphistory"
PKG_DEPENDS_TARGET+=" _vdr-plugin-epg2vdr"
PKG_DEPENDS_TARGET+=" _vdr-plugin-skindesigner"
PKG_DEPENDS_TARGET+=" _vdr-plugin-scraper2vdr"
PKG_DEPENDS_TARGET+=" _vdr-plugin-ac3mode"
PKG_DEPENDS_TARGET+=" _vdr-plugin-chanman"
PKG_DEPENDS_TARGET+=" _vdr-plugin-channellists"
PKG_DEPENDS_TARGET+=" _vdr-plugin-control"
PKG_DEPENDS_TARGET+=" _vdr-plugin-filebrowser"
PKG_DEPENDS_TARGET+=" _vdr-plugin-markad"
PKG_DEPENDS_TARGET+=" _vdr-plugin-osd2web"
PKG_DEPENDS_TARGET+=" _vdr-plugin-skinflat"
PKG_DEPENDS_TARGET+=" _vdr-plugin-skinlcarsng"
PKG_DEPENDS_TARGET+=" _vdr-plugin-skinnopacity"
PKG_DEPENDS_TARGET+=" _vdr-plugin-skinsoppalusikka"
PKG_DEPENDS_TARGET+=" _vdr-plugin-skinflatplus"
PKG_DEPENDS_TARGET+=" _vdr-plugin-skinelchihd"
PKG_DEPENDS_TARGET+=" _vdr-plugin-tvguideng"
PKG_DEPENDS_TARGET+=" _vdr-plugin-weatherforecast"
PKG_DEPENDS_TARGET+=" _vdr-plugin-systeminfo"
PKG_DEPENDS_TARGET+=" _vdr-plugin-radio"
PKG_DEPENDS_TARGET+=" _vdr-plugin-fritzbox"
PKG_DEPENDS_TARGET+=" _vdr-plugin-devstatus"
PKG_DEPENDS_TARGET+=" _vdr-plugin-tvscraper"
PKG_DEPENDS_TARGET+=" _vdr-plugin-targavfd"
PKG_DEPENDS_TARGET+=" _vdr-plugin-externalplayer"
PKG_DEPENDS_TARGET+=" _vdr-plugin-femon"
PKG_DEPENDS_TARGET+=" _vdr-plugin-svdrpservice"
PKG_DEPENDS_TARGET+=" _vdr-plugin-remoteosd"
PKG_DEPENDS_TARGET+=" _vdr-plugin-zappilot"
PKG_DEPENDS_TARGET+=" _vdr-plugin-dvd"
PKG_DEPENDS_TARGET+=" _vdr-plugin-mp3"
PKG_DEPENDS_TARGET+=" _vdr-plugin-cecremote"
PKG_DEPENDS_TARGET+=" _vdr-plugin-remote"
PKG_DEPENDS_TARGET+=" _vdr-plugin-menuorg"
PKG_DEPENDS_TARGET+=" _vdr-plugin-dbus2vdr"

#PKG_DEPENDS_TARGET+=" _vdr-plugin-easyvdr"
#PKG_DEPENDS_TARGET+=" _vdr-plugin-dynamite"

# Warning: Compiled without libcdio, libcdio_paranoia, libcdda due to compile problems for the mentioned libs
PKG_DEPENDS_TARGET+=" _vdr-plugin-cdplayer"

# Makfile muss angepasst werden
# PKG_DEPENDS_TARGET+=" _vdr-plugin-bgprocess"

post_install() {
  # Fix some links
  cd ${INSTALL}/usr/lib/

  if [ -f libEGL.so.1.1.0 ]; then
     rm libEGL.so.1.1.0
     ln -s /usr/lib/libMali.so libEGL.so.1.1.0
  fi

  if [ -f libGLESv2.so.2.1.0 ]; then
     rm libGLESv2.so.2.1.0
     ln -s /usr/lib/libMali.so libGLESv2.so.2.1.0
  fi

  if [ -f libGLESv1_CM.so.1.2.0 ]; then
     rm libGLESv1_CM.so.1.2.0
     ln -s /usr/lib/libMali.so libGLESv1_CM.so.1.2.0
  fi
}
