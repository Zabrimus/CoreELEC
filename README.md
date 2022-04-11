# VDR
VDR and plugins are integrated into the build system of CoreELEC to be able to start and use VDR and to be able to easily switch between VDR and KODI.

It's possible to either create a VDR tar.gz only, which contains VDR, all plugins and all dependant libraries.<br>
The second possibility is to create a CoreELEC image which contains VDR and plugins.


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

## Standalone VDR with all dependent libraries
### Build
```
    git checkout https://github.com/Zabrimus/CoreELEC.git
    ./build.sh
```
In folder build-artifacts a new archive coreelec-vdr.tar.gz will be created, which contains VDR, Plugins 
and all dependant libraries. The installation folder is /opt/vdr. 

### Installation
```
  cd / && tar -xf coreelec-vdr.tar.gz
```

## Images with integrated VDR and plugins
### Build
```
    git checkout https://github.com/Zabrimus/CoreELEC.git
    VDR_PREFIX="/usr/local" make image
```
The installation folder is /usr/local.

### Installation
```
     scp target/CoreELEC-Amlogic-ng.arm-19.4-Matrix_devel_*.tar root@<ip der box>:/storage/.update
     reboot
     
     or
     
     Install the desired image in a micro SD as described in the CoreELEC part of this Readme. 
```

## Install script
In folder /opt/vdr/bin or /usr/local/bin contains an install script
```
  cd /opt/vdr/bin
  ./install.sh
  
  Usage: install.sh [-install-config] [-boot kodi|vdr]
          -i      : Extracts the default configuration into directory /storage/.config/vdropt-sample and copy the sample folder to /storage/.config/vdropt if it does not exists.
          -b kodi : Kodi will be started after booting
          -b vdr  : VDR will be started after booting
```

## Das Verzeichnis-Layout und Dateien

- /usr/local/lib<br>
  contains libraries which are usually not part of CoreELEC
- /usr/local/vdr enthält<br>
  contains VDR and all plugins
- /usr/local/vdr-2.6.1/config
  contains the default configuration files  
- storage/.config/vdropt<br>
  contains the VDR and plugin configuration files. Will never be overwritten by the install process. 
- storage/.config/vdropt-sample<br>
  contains sample configuration files

<br>

- /usr/local/vdr-2.6.1/bin/start_vdr.sh<br>
  Start script of VDR. Reads all configuration files, creates the parameter list and launches VDR.
- /storage/.config/vdropt/enabled-plugins<br>
  Each line contains a plugin name which shall be started.
  The default is <br>
  > softhdodroid<br>
  > satip


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
