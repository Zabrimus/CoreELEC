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

# Aktueller Status:
# -----------------
# tools.c:10:10: fatal error: Magick++.h: No such file or directory
#   10 | #include <Magick++.h>
#      |          ^~~~~~~~~~~~
#
# Das liegt an imagemagick, bzw. der Meldung beim configure:
#   checking if g++ supports namespace std... no
#   checking whether the compiler supports ISO C++ standard library... no
#   checking whether C++ compiler is sufficient for Magick++... no (failed tests)
#
# Die Ursache ist noch völlig unklar.
#
# PKG_DEPENDS_TARGET+=" _vdr-plugin-scraper2vdr"

# Aktueller Status:
# -----------------
# rsvg baut nicht. Die folgende Fehlermeldung erscheint beim configure von rsvg:
#      Package 'shared-mime-info', required by 'gdk-pixbuf-2.0', not found
#
# Allerdings bauen sowohl shared-mime-info, als auch gdk-pixbuf-2.0.
# Ob das ein Folgefehler ist oder die eigentliche Ursache ist unklar. Und auch,
# warum das gemeldet wird. Im Build-Plan ist nichts auffälliges zu entdecken.
#
PKG_DEPENDS_TARGET+=" _vdr-plugin-skindesigner"


# Abhängigkeiten:
# openssl             -> security/openssl
# libglvnd            -> graphics/libglvnd
# opengl-meson        -> Amlogic-ce/devices/Amlogic-ng/packages/opengl-meson
# libdrm              -> graphics/libdrm
# glm                 -> graphics/glm
# ffmpeg              -> multimedia/ffmpeg
# glu                 -> graphics/glu
# cairo               -> graphics/cairo
# mariadb-connector-c -> databases/mariadb-connector-c
# tinyxml             -> textproc/tinyxml
# curl                -> web/curl
# avahi               -> network/avahi
# cairo               -> graphics/cairo
# pcre                -> devel/pcre
# curl                -> web/curl
# pcre                -> devel/pcre
# Python3             -> lang/Python3
# util-linux          -> sysutils/util-linux
# tinyxml             -> textproc/tinyxml
# jansson             -> vdr-depends/jansson
# tinyxml2            -> textproc/tinyxml2
# libarchive          -> compress/libarchive
# bzip2               -> compress/bzip2
# fontconfig          -> x11/other/fontconfig
# freetype            -> print/freetype
# libcap              -> devel/libcap
# libjpeg-turbo       -> graphics/libjpeg-turbo

# librsvg             -> vdr/vdr-depends/librsvg
# imagemagick         -> vdr/vdr-depends/imagemagick
# jansson             -> vdr/vdr-depends/jansson
# cxxtools            -> vdr/vdr-depends/_cxxtools (copied from addons/addon-depends/cxxtools)
# tntnet              -> vdr/vdr-depends/_tntnet   (copied from addons/addon-depends/tntnet)
# libiconv            -> vdr/vdr-depends/libiconv  (copied from addons/addon-depends/libiconv)

# librsvg             -> cairo            -> graphics/cairo
#                     -> glib             -> devel/glib
#                     -> libjpeg-turbo    -> graphics/libjpeg-turbo
#                     -> libpng           -> graphics/libpng
#                     -> tiff             -> graphics/tiff
#                     -> freetype         -> print/freetype
#                     -> rust             -> addons/addon-depends/librespot-depends/rust
#                     -> gdk-pixbuf       -> vdr/vdr-depends(_gdk-pixbuf                   (copied from addons/addon-depends/chrome-depends/gdk-pixbuf)
#                     -> pango            -> addons/addon-depends/chrome-depends/pango
#                     -> shared-mime-info -> vdr/vdr-depends/_shared-mime-info             (copied from addons/addon-depends/chrome-depends/shared-mime-info)
#                     -> jasper           -> addons/addon-depends/jasper

# Plan:
# build   make:host                 (wants: )
# build   ccache:host               (wants: make:host)
# build   m4:host                   (wants: ccache:host)
# build   gettext:host              (wants: ccache:host)
# build   autoconf:host             (wants: ccache:host, m4:host, gettext:host)
# build   autoconf-archive:host     (wants: ccache:host)
# build   automake:host             (wants: ccache:host, autoconf:host)
# build   bison:host                (wants: ccache:host, m4:host)
# build   configtools:host          (wants: )
# build   openssl:host              (wants: ccache:host)
# build   pkg-config:host           (wants: ccache:host, gettext:host)
# build   cmake:host                (wants: ccache:host, openssl:host, pkg-config:host)
# build   intltool:host             (wants: ccache:host)
# build   libtool:host              (wants: ccache:host, autoconf:host, automake:host, intltool:host)
# build   autotools:host            (wants: ccache:host, autoconf:host, automake:host, intltool:host, libtool:host, autoconf-archive:host)
# build   flex:host                 (wants: ccache:host, m4:host, autotools:host, bison:host)
# build   zlib:host                 (wants: cmake:host)
# build   bzip2:host                (wants: ccache:host)
# build   libffi:host               (wants: ccache:host, autoconf:host, automake:host, libtool:host, pkg-config:host)
# build   util-linux:host           (wants: ccache:host, autoconf:host, automake:host, intltool:host, libtool:host, pkg-config:host)
# build   xz:host                   (wants: ccache:host)
# build   Python3:host              (wants: zlib:host, bzip2:host, libffi:host, util-linux:host, xz:host)
# build   ninja:host                (wants: Python3:host)
# build   setuptools:host           (wants: Python3:host)
# build   pathlib:host              (wants: Python3:host)
# build   meson:host                (wants: Python3:host, setuptools:host, pathlib:host)
# build   p7zip:host                (wants: ccache:host)
# build   pigz:host                 (wants: make:host, zlib:host)
# build   sed:host                  (wants: ccache:host)
# build   libxml2:host              (wants: zlib:host, Python3:host)
# build   libxslt:host              (wants: libxml2:host)
# build   xmlstarlet:host           (wants: libxml2:host, libxslt:host)
# build   toolchain:host            (wants: autoconf:host, autoconf-archive:host, automake:host, bison:host, configtools:host, cmake:host, flex:host, intltool:host, libtool:host, ninja:host, make:host, meson:host, p7zip:host, pigz:host, sed:host, xmlstarlet:host, xz:host)
# build   zstd:host                 (wants: ccache:host, meson:host, ninja:host)
# build   rsync:host                (wants: autotools:host, zlib:host, zstd:host)
# build   gcc-arm-aarch64-none-linux-gnu:host (wants: ccache:host)
# build   linux:host                (wants: ccache:host, rsync:host, openssl:host, gcc-arm-aarch64-none-linux-gnu:host)
# build   binutils:host             (wants: ccache:host, bison:host, flex:host, linux:host)
# build   gmp:host                  (wants: ccache:host, m4:host)
# build   mpfr:host                 (wants: ccache:host, gmp:host)
# build   mpc:host                  (wants: ccache:host, gmp:host, mpfr:host)
# install gcc:bootstrap             (wants: ccache:host, autoconf:host, binutils:host, gmp:host, mpfr:host, mpc:host, zstd:host)
# install glibc                     (wants: ccache:host, autotools:host, linux:host, gcc:bootstrap, pigz:host, Python3:host)
# build   gcc:host                  (wants: ccache:host, autoconf:host, binutils:host, gmp:host, mpfr:host, mpc:host, zstd:host, glibc)
# install toolchain                 (wants: toolchain:host, gcc:host)
# build   lzo:host                  (wants: toolchain:host)
# build   squashfs-tools:host       (wants: ccache:host, zlib:host, lzo:host, xz:host, zstd:host)
# build   dosfstools:host           (wants: toolchain:host)
# build   libcap:host               (wants: ccache:host)
# build   fakeroot:host             (wants: ccache:host, libcap:host, autoconf:host, libtool:host)
# build   kmod:host                 (wants: toolchain:host)
# build   mtools:host               (wants: toolchain:host)
# build   e2fsprogs:host            (wants: toolchain:host)
# build   populatefs:host           (wants: e2fsprogs:host)
# install tz                        (wants: toolchain)
# install libidn2                   (wants: toolchain)
# install arm-mem                   (wants: toolchain)
# install libc                      (wants: toolchain, glibc, tz, libidn2, arm-mem)
# install gcc                       (wants: toolchain)
# install keyutils                  (wants: toolchain)
# build   dtc:host                  (wants: toolchain:host, zlib:host)
# build   aml-dtbtools:host         (wants: gcc:host, zlib:host, dtc:host)
# install zlib                      (wants: toolchain)
# install dtc                       (wants: toolchain, zlib)
# install aml-dtbtools              (wants: toolchain, zlib, dtc)
# build   mkbootimg:host            (wants: toolchain:host)
# build   glibc:init                (wants: glibc)
# build   arm-mem:init              (wants: toolchain, arm-mem)
# build   libc:init                 (wants: toolchain, glibc:init, arm-mem:init)
# install libtirpc                  (wants: toolchain)
# build   busybox:init              (wants: toolchain, libtirpc)
# build   gcc:init                  (wants: toolchain)
# install libspng                   (wants: toolchain, zlib)
# build   splash-image:init         (wants: toolchain, gcc:init, glibc, libspng, zlib)
# build   util-linux:init           (wants: toolchain)
# build   e2fsprogs:init            (wants: toolchain)
# install dosfstools                (wants: toolchain)
# build   dosfstools:init           (wants: toolchain, dosfstools)
# build   terminus-font:init        (wants: toolchain, Python3:host)
# build   bkeymaps:init             (wants: )
# build   initramfs:init            (wants: libc:init, busybox:init, splash-image:init, util-linux:init, e2fsprogs:init, dosfstools:init, terminus-font:init, bkeymaps:init)
# install linux                     (wants: toolchain, linux:host, kmod:host, xz:host, keyutils, aml-dtbtools:host, aml-dtbtools, gcc-arm-aarch64-none-linux-gnu:host, mkbootimg:host, initramfs:init)
# install RTL8192CU                 (wants: toolchain, linux)
# install RTL8192DU                 (wants: toolchain, linux)
# install RTL8192EU                 (wants: toolchain, linux)
# install RTL8188EU                 (wants: toolchain, linux)
# install RTL8812AU                 (wants: toolchain, linux)
# install RTL8821CU                 (wants: toolchain, linux)
# install gpu-aml                   (wants: toolchain, linux)
# install openvfd-driver            (wants: toolchain, linux)
# install wifi_dummy-aml            (wants: toolchain, linux)
# install media_modules-aml         (wants: toolchain, linux)
# install ap6xxx-aml                (wants: toolchain, linux)
# install ssv6xxx-aml               (wants: toolchain, linux)
# install mt7668-aml                (wants: toolchain, linux)
# install RTL8188FTV-aml            (wants: toolchain, linux)
# install RTL8189ES-aml             (wants: toolchain, linux)
# install RTL8189FS-aml             (wants: toolchain, linux)
# install RTL8723BS-aml             (wants: toolchain, linux)
# install RTL8814AU                 (wants: toolchain, linux)
# install RTL8822BU-aml             (wants: toolchain, linux)
# install RTL8822BS-aml             (wants: toolchain, linux)
# install RTL8822CS-aml             (wants: toolchain, linux)
# install RTL8152-aml               (wants: toolchain, linux)
# install RTL8821CS-aml             (wants: toolchain, linux)
# install qca9377-aml               (wants: toolchain, linux)
# install qca6174-aml               (wants: toolchain, linux)
# install smartchip                 (wants: toolchain, linux)
# install linux-drivers             (wants: toolchain, RTL8192CU, RTL8192DU, RTL8192EU, RTL8188EU, RTL8812AU, RTL8821CU, gpu-aml, openvfd-driver, wifi_dummy-aml, media_modules-aml, ap6xxx-aml, ssv6xxx-aml, mt7668-aml, RTL8188FTV-aml, RTL8189ES-aml, RTL8189FS-aml, RTL8723BS-aml, RTL8814AU, RTL8822BU-aml, RTL8822BS-aml, RTL8822CS-aml, RTL8152-aml, RTL8821CS-aml, qca9377-aml, qca6174-aml, smartchip)
# install kernel-firmware           (wants: )
# install misc-firmware             (wants: toolchain, kernel-firmware)
# install rfkill                    (wants: toolchain)
# install wlan-firmware             (wants: toolchain, rfkill)
# install dvb-firmware              (wants: toolchain)
# install brcmfmac_sdio-firmware-aml (wants: toolchain)
# install rtk_hciattach             (wants: toolchain)
# install rtkbt-firmware-aml        (wants: toolchain, rtk_hciattach)
# install qca-firmware-aml          (wants: toolchain)
# install linux-firmware            (wants: toolchain, misc-firmware, wlan-firmware, dvb-firmware, brcmfmac_sdio-firmware-aml, rtkbt-firmware-aml, qca-firmware-aml)
# build   gcc-linaro-aarch64-elf:host (wants: ccache:host)
# build   gcc-linaro-arm-eabi:host  (wants: ccache:host)
# install u-boot-Odroid_N2          (wants: toolchain, gcc-linaro-aarch64-elf:host, gcc-linaro-arm-eabi:host)
# install u-boot-Odroid_C4          (wants: toolchain, gcc-linaro-aarch64-elf:host, gcc-linaro-arm-eabi:host)
# install u-boot-LePotato           (wants: toolchain, gcc-linaro-aarch64-elf:host, gcc-linaro-arm-eabi:host)
# install u-boot-LaFrite            (wants: toolchain, gcc-linaro-aarch64-elf:host, gcc-linaro-arm-eabi:host)
# install u-boot-Radxa_Zero         (wants: toolchain, gcc-linaro-aarch64-elf:host, gcc-linaro-arm-eabi:host)
# install u-boot-Radxa_Zero2        (wants: toolchain, gcc-linaro-aarch64-elf:host, gcc-linaro-arm-eabi:host)
# install u-boot                    (wants: toolchain, gcc-linaro-aarch64-elf:host, gcc-linaro-arm-eabi:host, u-boot-Odroid_N2, u-boot-Odroid_C4, u-boot-LePotato, u-boot-LaFrite, u-boot-Radxa_Zero, u-boot-Radxa_Zero2)
# build   busybox:host              (wants: toolchain:host)
# install hdparm                    (wants: toolchain)
# install hd-idle                   (wants: toolchain)
# install e2fsprogs                 (wants: toolchain)
# install bzip2                     (wants: toolchain)
# install zip                       (wants: toolchain, bzip2)
# install libcap                    (wants: toolchain)
# install kmod                      (wants: toolchain)
# install util-linux                (wants: toolchain)
# install entropy                   (wants: toolchain)
# install wait-time-sync            (wants: toolchain)
# install systemd                   (wants: toolchain, libcap, kmod, util-linux, entropy, libidn2, wait-time-sync)
# install libusb                    (wants: toolchain, systemd)
# install usbutils                  (wants: toolchain, libusb, systemd)
# build   parted:host               (wants: toolchain:host, util-linux:host)
# install parted                    (wants: toolchain, util-linux, parted:host)
# build   ncurses:host              (wants: ccache:host)
# install ncurses                   (wants: toolchain, zlib, ncurses:host)
# install procps-ng                 (wants: toolchain, ncurses)
# install popt                      (wants: toolchain)
# install crossguid                 (wants: toolchain, util-linux)
# install gptfdisk                  (wants: toolchain, popt, crossguid)
# install libaio                    (wants: toolchain)
# install libdevmapper              (wants: toolchain, libaio, util-linux)
# install json-c                    (wants: toolchain)
# install openssl                   (wants: toolchain)
# install cryptsetup                (wants: toolchain, popt, libdevmapper, util-linux, json-c, openssl)
# install nano                      (wants: toolchain, ncurses)
# install rpcbind                   (wants: toolchain, libtirpc, systemd)
# install busybox                   (wants: toolchain, busybox:host, hdparm, hd-idle, dosfstools, e2fsprogs, zip, usbutils, parted, procps-ng, gptfdisk, libtirpc, cryptsetup, nano, rpcbind)
# install util-macros               (wants: toolchain)
# install liberation-fonts-ttf      (wants: toolchain, util-macros)
# install corefonts                 (wants: toolchain, liberation-fonts-ttf)
# build   pcre:host                 (wants: toolchain:host)
# install pcre                      (wants: toolchain, pcre:host)
# install libffi                    (wants: toolchain)
# install glib                      (wants: toolchain, pcre, zlib, libffi, Python3:host, util-linux)
# install readline                  (wants: toolchain, ncurses)
# install expat                     (wants: toolchain)
# install dbus                      (wants: toolchain, expat, systemd)
# install libmnl                    (wants: toolchain)
# install libnftnl                  (wants: toolchain, libmnl)
# install iptables                  (wants: toolchain, linux:host, libmnl, libnftnl)
# install libnl                     (wants: toolchain)
# install wpa_supplicant            (wants: toolchain, dbus, libnl, openssl)
# install connman                   (wants: toolchain, glib, readline, dbus, iptables, wpa_supplicant)
# install netbase                   (wants: toolchain)
# install ethtool                   (wants: toolchain, libmnl)
# install openssh                   (wants: toolchain, openssl, zlib)
# install iw                        (wants: toolchain, libnl)
# install wireless-regdb            (wants: )
# install rsync                     (wants: toolchain, zlib, openssl)
# install bluez                     (wants: toolchain, dbus, glib, readline, systemd)
# install attr                      (wants: toolchain)
# build   heimdal:host              (wants: toolchain:host, Python3:host, ncurses:host)
# install sqlite                    (wants: toolchain, ncurses)
# install xz                        (wants: toolchain)
# install Python3                   (wants: toolchain, Python3:host, sqlite, expat, zlib, bzip2, xz, openssl, libffi, readline, ncurses, util-linux)
# install gmp                       (wants: toolchain)
# install nettle                    (wants: toolchain, gmp)
# install gnutls                    (wants: toolchain, libidn2, nettle, zlib)
# install libdaemon                 (wants: toolchain)
# install gettext                   (wants: toolchain)
# install avahi                     (wants: toolchain, expat, libdaemon, dbus, connman, gettext)
# install samba                     (wants: toolchain, attr, heimdal:host, e2fsprogs, Python3, zlib, readline, popt, libaio, connman, gnutls, avahi)
# install lzo                       (wants: toolchain)
# install openvpn                   (wants: toolchain, lzo, openssl)
# install wireguard-tools           (wants: toolchain, linux)
# install wireguard-linux-compat    (wants: toolchain, linux, libmnl)
# build   nspr:host                 (wants: ccache:host)
# build   nss:host                  (wants: nspr:host, zlib:host)
# install nspr                      (wants: toolchain, nss:host, nspr:host)
# install nss                       (wants: toolchain, nss:host, nspr, zlib, sqlite)
# install network                   (wants: toolchain, connman, netbase, ethtool, openssh, iw, wireless-regdb, rsync, bluez, samba, openvpn, wireguard-tools, wireguard-linux-compat, nss)
# build   u-boot-tools:host         (wants: gcc:host)
# install u-boot-tools              (wants: toolchain, u-boot-tools:host)
# install u-boot-script             (wants: u-boot-tools)
# install CoreELEC-Debug-Scripts    (wants: )
# install bl301_xxxxxx              (wants: toolchain, gcc-linaro-aarch64-elf:host, gcc-linaro-arm-eabi:host)
# install bl301_221119              (wants: toolchain, gcc-linaro-aarch64-elf:host, gcc-linaro-arm-eabi:host)
# install bl301_091020              (wants: toolchain, gcc-linaro-aarch64-elf:host, gcc-linaro-arm-eabi:host)
# install inject_bl301              (wants: toolchain, bl301_xxxxxx, bl301_221119, bl301_091020)
# install ceemmc                    (wants: toolchain)
# build   nfs-utils:host            (wants: toolchain)
# build   rpcsvc-proto:host         (wants: toolchain)
# install rpcsvc-proto              (wants: toolchain, rpcsvc-proto:host)
# install libevent                  (wants: toolchain, openssl)
# install nfs-utils                 (wants: toolchain, nfs-utils:host, systemd, sqlite, libtirpc, rpcsvc-proto, libevent, libdevmapper)
# install dtb-xml                   (wants: toolchain)
# install rtmpdump                  (wants: toolchain, zlib, openssl)
# install nghttp2                   (wants: toolchain)
# install curl                      (wants: toolchain, zlib, openssl, rtmpdump, libidn2, nghttp2)
# install megatools                 (wants: toolchain, glib, openssl, curl)
# install entware                   (wants: toolchain)
# install misc-packages             (wants: toolchain, u-boot-script, dtc, CoreELEC-Debug-Scripts, inject_bl301, ceemmc, nfs-utils, dtb-xml, megatools, entware)
# install gdb                       (wants: toolchain, zlib, ncurses, expat)
# install edid-decode               (wants: toolchain)
# install memtester                 (wants: toolchain)
# install strace                    (wants: toolchain)
# install debug                     (wants: toolchain, gdb, edid-decode, memtester, strace)
# build   JsonSchemaBuilder:host    (wants: toolchain:host)
# build   libpng:host               (wants: zlib:host)
# build   libjpeg-turbo:host        (wants: toolchain:host)
# build   giflib:host               (wants: zlib:host)
# build   TexturePacker:host        (wants: lzo:host, libpng:host, libjpeg-turbo:host, giflib:host)
# build   swig:host                 (wants: ccache:host)
# install libpng                    (wants: toolchain, zlib)
# install freetype                  (wants: toolchain, zlib, libpng)
# install libxml2                   (wants: toolchain, zlib)
# install fontconfig                (wants: toolchain, util-linux, util-macros, freetype, libxml2, zlib, expat)
# install fribidi                   (wants: toolchain)
# install pixman                    (wants: toolchain, util-macros)
# install opengl-meson              (wants: toolchain)
# install cairo                     (wants: toolchain, zlib, freetype, fontconfig, glib, libpng, pixman, opengl-meson)
# install harfbuzz                  (wants: toolchain, cairo, freetype, glib)
# install libass                    (wants: toolchain, freetype, fontconfig, fribidi, harfbuzz)
# install tinyxml                   (wants: toolchain)
# install libjpeg-turbo             (wants: toolchain)
# install libcdio                   (wants: toolchain)
# install taglib                    (wants: toolchain, cmake:host, zlib)
# install libxslt                   (wants: toolchain, libxml2)
# install rapidjson                 (wants: toolchain)
# install speex                     (wants: toolchain)
# install dav1d                     (wants: toolchain)
# install ffmpeg                    (wants: toolchain, zlib, bzip2, gnutls, speex, dav1d)
# install libdvdcss                 (wants: toolchain)
# install libdvdread                (wants: toolchain, libdvdcss)
# install libdvdnav                 (wants: toolchain, libdvdread)
# install libhdhomerun              (wants: toolchain)
# install libfmt                    (wants: toolchain)
# install libconfuse                (wants: toolchain)
# install libftdi1                  (wants: toolchain, libusb, libconfuse)
# install libusb-compat             (wants: toolchain, libusb)
# install alsa-lib                  (wants: toolchain)
# install lirc                      (wants: toolchain, libftdi1, libusb-compat, libxslt, alsa-lib)
# install libfstrcmp                (wants: toolchain)
# build   flatbuffers:host          (wants: toolchain:host)
# install flatbuffers               (wants: toolchain)
# install libudfread                (wants: toolchain)
# install spdlog                    (wants: toolchain, libfmt)
# install libogg                    (wants: toolchain)
# install flac                      (wants: toolchain, libogg)
# install libvorbis                 (wants: toolchain, libogg)
# install opus                      (wants: toolchain)
# install libsndfile                (wants: toolchain, alsa-lib, flac, libogg, libvorbis, opus)
# install libtool                   (wants: toolchain)
# install soxr                      (wants: toolchain, cmake:host)
# install speexdsp                  (wants: toolchain)
# build   glib:host                 (wants: libffi:host, Python3:host, meson:host, ninja:host)
# install sbc                       (wants: toolchain)
# install pulseaudio                (wants: toolchain, alsa-lib, dbus, libcap, libsndfile, libtool, openssl, soxr, speexdsp, systemd, glib:host, glib, sbc, avahi)
# install p8-platform               (wants: toolchain)
# install libcec                    (wants: toolchain, systemd, p8-platform, swig:host)
# install libgpg-error              (wants: toolchain)
# install libgcrypt                 (wants: toolchain, libgpg-error)
# install libaacs                   (wants: toolchain, libgcrypt)
# install libbdplus                 (wants: toolchain, libgcrypt, libgpg-error, libaacs)
# install libbluray                 (wants: toolchain, fontconfig, freetype, libxml2, libaacs, libbdplus)
# install nss-mdns                  (wants: toolchain, avahi)
# install mariadb-connector-c       (wants: toolchain, zlib, openssl)
# install libplist                  (wants: toolchain, glib)
# install libshairplay              (wants: toolchain, avahi)
# install libnfs                    (wants: toolchain)
# install libmicrohttpd             (wants: toolchain, gnutls)
# install libamcodec                (wants: toolchain)
# install libevdev                  (wants: toolchain)
# install mtdev                     (wants: toolchain)
# install libinput                  (wants: toolchain, systemd, libevdev, mtdev)
# install xkeyboard-config          (wants: toolchain, util-macros)
# install libxkbcommon              (wants: toolchain, xkeyboard-config, libxml2)
# install kodi                      (wants: toolchain, JsonSchemaBuilder:host, TexturePacker:host, Python3, zlib, systemd, lzo, pcre, swig:host, libass, curl, fontconfig, fribidi, tinyxml, libjpeg-turbo, freetype, libcdio, taglib, libxml2, libxslt, rapidjson, sqlite, ffmpeg, crossguid, libdvdnav, libhdhomerun, libfmt, lirc, libfstrcmp, flatbuffers:host, flatbuffers, libudfread, spdlog, dbus, opengl-meson, alsa-lib, pulseaudio, libcec, libbluray, avahi, nss-mdns, mariadb-connector-c, libplist, libshairplay, libnfs, samba, libmicrohttpd, libamcodec, libinput, libxkbcommon)
# install kodi-theme-Estuary        (wants: kodi)
# install texturecache.py           (wants: )
# build   distutilscross:host       (wants: Python3:host, setuptools:host)
# install tiff                      (wants: toolchain, libjpeg-turbo, zlib)
# install Pillow                    (wants: toolchain, Python3, distutilscross:host, zlib, freetype, libjpeg-turbo, tiff)
# install simplejson                (wants: toolchain, Python3, distutilscross:host)
# install pycryptodome              (wants: toolchain, Python3, distutilscross:host)
# build   pixman:host               (wants: toolchain:host)
# build   qemu:host                 (wants: toolchain:host, glib:host, pixman:host, Python3:host, zlib:host)
# build   gobject-introspection:host (wants: libffi:host, glib:host)
# install gobject-introspection     (wants: toolchain, libffi, glib, qemu:host, gobject-introspection:host, Python3)
# install pgi                       (wants: toolchain, Python3)
# install pygobject                 (wants: toolchain, Python3, glib, libffi, gobject-introspection, pgi)
# install dbus-glib                 (wants: toolchain, dbus, glib, expat)
# install dbus-python               (wants: toolchain, Python3, dbus, dbus-glib)
# install bkeymaps                  (wants: toolchain, busybox)
# install CoreELEC-settings         (wants: toolchain, Python3, connman, pygobject, dbus-python, bkeymaps)
# install xmlstarlet                (wants: toolchain, libxml2, libxslt)
# install kodi-platform             (wants: toolchain, tinyxml, kodi, p8-platform)
# install peripheral.joystick       (wants: toolchain, kodi-platform, p8-platform)
# install mediacenter               (wants: toolchain, kodi, kodi-theme-Estuary, texturecache.py, Pillow, simplejson, pycryptodome, CoreELEC-settings, xmlstarlet, peripheral.joystick)
# install alsa-utils                (wants: toolchain, alsa-lib, ncurses, systemd)
# install alsa-topology-conf        (wants: )
# install alsa-ucm-conf             (wants: )
# install alsa                      (wants: toolchain, alsa-lib, alsa-utils, alsa-topology-conf, alsa-ucm-conf)
# install udevil                    (wants: toolchain, systemd, glib)
# install fuse                      (wants: toolchain)
# install fuse-exfat                (wants: toolchain, fuse)
# install diskdev_cmds              (wants: toolchain, openssl)
# install ntfs-3g_ntfsprogs         (wants: toolchain, fuse, libgcrypt)
# install eventlircd                (wants: toolchain, systemd, lirc)
# install libirman                  (wants: toolchain, systemd, lirc)
# build   elfutils:host             (wants: make:host, zlib:host)
# install elfutils                  (wants: toolchain, zlib, elfutils:host)
# install ir-bpf-decoders           (wants: )
# install v4l-utils                 (wants: toolchain, alsa-lib, systemd, elfutils, ir-bpf-decoders)
# install evrepeat                  (wants: toolchain)
# install amremote                  (wants: toolchain, usbutils)
# install remote                    (wants: toolchain, eventlircd, libirman, v4l-utils, evrepeat, amremote)
# install libiconv                  (wants: toolchain)
# install _vdr                      (wants: toolchain, bzip2, fontconfig, freetype, libcap, libiconv, libjpeg-turbo)
# install xtrans                    (wants: toolchain, util-macros)
# install xorgproto                 (wants: toolchain, util-macros)
# install libXau                    (wants: toolchain, util-macros, xorgproto)
# install xcb-proto                 (wants: toolchain, util-macros, Python3:host)
# install libpthread-stubs          (wants: toolchain)
# install libxcb                    (wants: toolchain, util-macros, Python3:host, xcb-proto, libpthread-stubs, libXau)
# install libX11                    (wants: toolchain, util-macros, xtrans, libXau, libxcb, xorgproto)
# install libXext                   (wants: toolchain, util-macros, libX11)
# install libglvnd                  (wants: toolchain, libX11, libXext, xorgproto)
# install libpciaccess              (wants: toolchain, util-macros, zlib)
# install libdrm                    (wants: toolchain, libpciaccess)
# install glm                       (wants: toolchain)
# install glu                       (wants: toolchain, libglvnd, opengl-meson)
# install _vdr-plugin-softhdodroid  (wants: toolchain, libglvnd, opengl-meson, libdrm, glm, ffmpeg, _vdr, glu)
# install _vdr-plugin-satip         (wants: toolchain, _vdr, curl, tinyxml)
# install _vdr-plugin-ddci2         (wants: toolchain, _vdr)
# install _vdr-plugin-dummydevice   (wants: toolchain, _vdr)
# install libdvbcsa                 (wants: toolchain)
# install _vdr-plugin-dvbapi        (wants: toolchain, _vdr, libdvbcsa)
# install _vdr-plugin-eepg          (wants: toolchain, _vdr)
# install _vdr-plugin-epgfixer      (wants: toolchain, _vdr, pcre)
# install _vdr-plugin-epgsearch     (wants: toolchain, _vdr, pcre)
# install _vdr-plugin-iptv          (wants: toolchain, _vdr, curl)
# build   cxxtools:host             (wants: toolchain:host)
# build   tntnet:host               (wants: cxxtools:host, zlib:host)
# install cxxtools                  (wants: toolchain, cxxtools:host)
# install tntnet                    (wants: toolchain, tntnet:host, libtool, cxxtools, zlib)
# install _vdr-plugin-live          (wants: toolchain, _vdr, tntnet, pcre:host, pcre)
# install _vdr-plugin-wirbelscan    (wants: toolchain, _vdr)
# install _vdr-plugin-restfulapi    (wants: toolchain, _vdr, cxxtools, _vdr-plugin-wirbelscan)
# install _vdr-plugin-robotv        (wants: toolchain, _vdr, avahi)
# install _vdr-plugin-streamdev     (wants: toolchain, _vdr, openssl)
# install _vdr-plugin-vnsiserver    (wants: toolchain, _vdr)
# install _vdr-plugin-wirbelscancontrol (wants: toolchain, _vdr, gettext:host, _vdr-plugin-wirbelscan)
# install _vdr-plugin-osdteletext   (wants: toolchain, _vdr, cairo)
# install _vdr-plugin-zaphistory    (wants: toolchain, _vdr)
# install jansson                   (wants: toolchain)
# install tinyxml2                  (wants: toolchain)
# install libarchive                (wants: toolchain)
# install _vdr-plugin-epg2vdr       (wants: toolchain, _vdr, Python3, util-linux, mariadb-connector-c, jansson, tinyxml2, libarchive)
# install vdr-all                   (wants: toolchain, _vdr, _vdr-plugin-softhdodroid, _vdr-plugin-satip, _vdr-plugin-ddci2, _vdr-plugin-dummydevice, _vdr-plugin-dvbapi, _vdr-plugin-eepg, _vdr-plugin-epgfixer, _vdr-plugin-epgsearch, _vdr-plugin-iptv, _vdr-plugin-live, _vdr-plugin-restfulapi, _vdr-plugin-robotv, _vdr-plugin-streamdev, _vdr-plugin-vnsiserver, _vdr-plugin-wirbelscan, _vdr-plugin-wirbelscancontrol, _vdr-plugin-osdteletext, _vdr-plugin-zaphistory, _vdr-plugin-epg2vdr)
# install image                     (wants: toolchain, squashfs-tools:host, dosfstools:host, fakeroot:host, kmod:host, mtools:host, populatefs:host, libc, gcc, linux, linux-drivers, linux-firmware, u-boot, busybox, util-linux, corefonts, network, misc-packages, debug, mediacenter, alsa, udevil, fuse-exfat, diskdev_cmds, ntfs-3g_ntfsprogs, remote, vdr-all)
