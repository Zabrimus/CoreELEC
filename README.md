# VDR
VDR and plugins are integrated into the build system of CoreELEC to be able to start and use VDR and to be able to easily switch between VDR and KODI.

This is still work in progress...

## Aktueller Status:

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
- vdr-plugin-skindesigner

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

## Build 
```
    git checkout https://github.com/Zabrimus/CoreELEC.git
    make oder make image 
```

## Installation
```
     scp target/CoreELEC-Amlogic-ng.arm-19.4-Matrix_devel_*.tar root@<ip der box>:/storage/.update
     reboot der Box
     
     oder
     
     Eines der Images im Verzeichnis target auf SD Karte kopieren und booten. 
```

## Das Verzeichnis-Layout und Dateien

- /usr/local/lib<br>
  enthält alle Libraries, die speziell für VDR erzeugt wurden
- /usr/local/vdr-2.6.1 enthält<br>
  enthält alle VDR Binaries, Plugins und sonstige unveränderliche Dateien
- /usr/local/vdr-2.6.1/config
  enthält die Default Konfiguration der Plugins und VDR, die beim Build erzeugt wurden. Dies können oder werden nach /storage/.config/vdropt-sample extrahiert werden.
- storage/.config/vdropt<br>
  enthält die komplette Konfiguration des VDR und aller Plugins. Wird nicht mehr überschrieben.
- storage/.config/vdropt-sample<br>
  enthält die komplette Beispiel/Default Konfiguration des VDR und aller Plugins. Änderungen können durch das Script
  /usr/local/vdr-2.6.1/bin/extract-vdr-config.sh überschrieben werden.

<br>

- /usr/local/vdr-2.6.1/bin/extract-vdr-config.sh<br>
  Löscht das Verzeichnis /storage/.config/vdropt-sample und extrahiert die Default-Konfiguration. Falls noch kein Verzeichnis /storage/.config/vdropt existiert, wird /storage/.config/vdropt-sample nach /storage/.config/vdropt kopiert.<br>
  Das Script soll eigentlich einmalig nach dem Reboot einer Neuinstallation aufgerufen werden, aber da gibt es noch Probleme mit systemd.
- /usr/local/vdr-2.6.1/bin/start_vdr.sh<br>
  Das Script bereitet die komplette Parameter-Liste für den Aufruf von VDR vor und startet den VDR.
- /storage/.config/vdropt/enabled-plugins<br>
  Enthält pro Zeile den Namen eines Plugins, daß gestartet werden soll. Hier können neue Plugins hinzugefügt oder auch bestehende gelöscht werden.<br>
  Der Default ist <br>
  > softhdodroid<br>
  > satip


## Ersteinrichtung
Solange das Problem mit systemd nicht gelöst wurde, sollte nach Installation des Images/Update-Tar, das Script /usr/local/vdr-2.6.1/bin/extract-vdr-config.sh auf der Shell aufgerufen werden.<br>
Die Konfiguration des VDR und aller Plugins findet sich an den bekannten Stellen.

## Start des VDR
```
systemctl stop kodi
/usr/local/vdr-2.6.1/bin/start_vdr.sh
```

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
