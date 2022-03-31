# VDR
VDR and plugins are integrated into the build system of CoreELEC to be able to start and use VDR and to be able to easily switch between VDR and KODI.

This is still work in progress...

##Aktueller Status:

**Build folgender Plugins erfolgreich**
- vdr-plugin-softhdodroid
- vdr-plugin-satip
- vdr-plugin-ddci2
- vdr-plugin-dummydevice
- vdr-plugin-dvbapi
- vdr-plugin-eepg
- vdr-plugin-epgfixer
- vdr-plugin-epgsearch
- vdr-plugin-iptv
- vdr-plugin-live
- vdr-plugin-restfulapi
- vdr-plugin-robotv
- vdr-plugin-streamdev
- vdr-plugin-vnsiserver
- vdr-plugin-wirbelscan
- vdr-plugin-wirbelscancontrol
- vdr-plugin-osdteletext
- vdr-plugin-zaphistory
- vdr-plugin-epg2vdr

**Aktuelle Probleme**

**vdr-plugin-scraper2vdr:**
```
tools.c:10:10: fatal error: Magick++.h: No such file or directory
  10 | #include <Magick++.h>
     |          ^~~~~~~~~~~~
```
Das liegt an imagemagick, bzw. der Meldung beim configure:
```
   checking if g++ supports namespace std... no
   checking whether the compiler supports ISO C++ standard library... no
   checking whether C++ compiler is sufficient for Magick++... no (failed tests)
```
Die Ursache ist noch völlig unklar.

### Ideen
Vielleicht sollte ich die Abhängigkeiten zu addons/*-depends auflösen und stattdessen speziell für VDR bauen lassen.
Ich weiß nicht, was passiert, wenn man das Addon installiert und wieder deinstalliert.
Wenn die Libs weg sind, führt das zu unschönen Situationen mit dem VDR.


# CoreELEC

CoreELEC is a 'Just enough OS' Linux distribution for running the award-winning [Kodi](https://kodi.tv) software on popular low-cost hardware. CoreELEC is a minor fork of [LibreELEC](https://libreelec.tv), it's built by the community for the community. [CoreELEC website](http://coreelec.org).

**Issues & Support**

Please report issues via the CoreELEC [Forum](https://discourse.coreelec.org).

**Donations**

At this moment we do not accept Donations. We are doing this for fun not for profit.

**License**

CoreELEC original code is released under [GPLv2](https://www.gnu.org/licenses/gpl-2.0.html).

**Copyright**

As CoreELEC includes code from many upstream projects it includes many copyright owners. CoreELEC makes NO claim of copyright on any upstream code. Patches to upstream code have the same license as the upstream project, unless specified otherwise. For a complete copyright list please checkout the source code to examine license headers. Unless expressly stated otherwise all code submitted to the CoreELEC project (in any form) is licensed under [GPLv2](https://www.gnu.org/licenses/gpl-2.0.html). You are absolutely free to retain copyright. To retain copyright simply add a copyright header to each submitted code page. If you submit code that is not your own work it is your responsibility to place a header stating the copyright.
