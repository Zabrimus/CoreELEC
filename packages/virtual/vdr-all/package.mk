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

# Makfile muss angepasst werden
# PKG_DEPENDS_TARGET+=" _vdr-plugin-bgprocess"

# error ImageMagick Version 7.0 or higher is required
# PKG_DEPENDS_TARGET+=" _vdr-plugin-skinelchihd"
