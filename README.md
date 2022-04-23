# VDR
VDR and plugins are integrated into the build system of CoreELEC to be able to start and use VDR and to be able to easily switch between VDR and KODI.

It's possible to either create a VDR tar.gz only, which contains VDR, all plugins and all dependant libraries.<br>
The second possibility is to create a CoreELEC image which contains VDR and plugins.


This is still work in progress...

## Current status:

**Following plugins are successfully build and part of the vdr tar**
```
CoreELEC:~/.opt/vdr/bin # ./easyvdrctl.sh --all-status
Plugin             | install | ini     | AutoRun | Stop | Arguments
--------------------------------------------------------------------------------
ac3mode            | yes     | valid   | no      | yes  |
chanman            | yes     | valid   | no      | yes  |
channellists       | yes     | valid   | no      | yes  |
conflictcheckonly  | yes     | valid   | no      | yes  |
control            | yes     | valid   | yes     | yes  |
ddci2              | yes     | valid   | no      | yes  |
dummydevice        | yes     | valid   | no      | yes  |
dvbapi             | yes     | valid   | no      | yes  |
eepg               | yes     | valid   | no      | yes  |
epg2vdr            | yes     | valid   | no      | yes  |
epgfixer           | yes     | valid   | no      | yes  |
epgsearch          | yes     | valid   | no      | yes  |
epgsearchonly      | yes     | valid   | no      | yes  |
epgtableid0        | yes     | valid   | no      | yes  |
filebrowser        | yes     | valid   | no      | yes  |
hello              | yes     | valid   | no      | yes  |
iptv               | yes     | valid   | no      | yes  |
live               | yes     | valid   | no      | yes  |
markad             | yes     | valid   | no      | yes  |
osd2web            | yes     | valid   | no      | yes  |
osddemo            | yes     | valid   | no      | yes  |
osdteletext        | yes     | valid   | no      | yes  |
pictures           | yes     | valid   | no      | yes  |
quickepgsearch     | yes     | valid   | no      | yes  |
restfulapi         | yes     | valid   | no      | yes  |
robotv             | yes     | valid   | no      | yes  |
satip              | yes     | valid   | yes     | yes  |
scraper2vdr        | yes     | valid   | no      | yes  |
skindesigner       | yes     | valid   | no      | yes  |
skinflat           | yes     | valid   | no      | yes  |
skinflatplus       | yes     | valid   | no      | yes  |
skinlcarsng        | yes     | valid   | no      | yes  |
skinnopacity       | yes     | valid   | no      | yes  |
skinsoppalusikka   | yes     | valid   | no      | yes  |
softhdodroid       | yes     | valid   | yes     | yes  | -a hw:CARD=AMLAUGESOUND,DEV=0
status             | yes     | valid   | no      | yes  |
streamdev-client   | yes     | valid   | no      | yes  |
streamdev-server   | yes     | valid   | no      | yes  |
svccli             | yes     | valid   | no      | yes  |
svcsvr             | yes     | valid   | no      | yes  |
svdrpdemo          | yes     | valid   | no      | yes  |
vnsiserver         | yes     | valid   | no      | yes  |
wirbelscan         | yes     | valid   | no      | yes  |
wirbelscancontrol  | yes     | valid   | no      | yes  |
zaphistory         | yes     | valid   | no      | yes  |
```

**Following plugins can't currently be compiled**
- vdr-plugin-skinelchihd<br>
  ``#error ImageMagick Version 7.0 or higher is required``


## Standalone VDR with all dependent libraries (tested with Ubuntu Focal and Debian 11)
### Install all dependencies
```
apt-get install build-essential coreutils squashfuse git curl xfonts-utils xsltproc default-jre \
                libxml-parser-perl libjson-perl libncurses5-dev bc gawk wget zip zstd libparse-yapp-perl \
                gperf lzop unzip patchutils cpio
```
### Build
```
    git checkout https://github.com/Zabrimus/CoreELEC.git
    cd CoreELEC
    git checkout 19.4-Matrix-VDR
    ./build-local.sh -t
```
In folder build-artifacts a new archive coreelec-19-vdr.tar.gz will be created, which contains VDR, Plugins 
and all dependant libraries. The installation folder is /opt/vdr.

The ```build.sh``` is used by Github Workflow and caches at least the ```sources``` folder.<br>

### Installation
```
  cd / && tar -xf coreelec-vdr.tar.gz
```

## Images with integrated VDR and plugins
### Install all dependencies
```
apt-get install build-essential coreutils squashfuse git curl xfonts-utils xsltproc default-jre \
                libxml-parser-perl libjson-perl libncurses5-dev bc gawk wget zip zstd libparse-yapp-perl \
                gperf lzop unzip patchutils cpio
```

### Build
If you want all images including VDR
```
    git checkout https://github.com/Zabrimus/CoreELEC.git
    cd CoreELEC
    git checkout 19.4-Matrix-VDR
    ./build-local.sh -i
```
In folder ```target``` you can find all created CoreELEC images which includes VDR.

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
          -C      : Use with care! All configuration entries of vdropt will be copied to vdropt-sample. And then all entries of vdropt-sample will be copied to vdropt.
          -b kodi : Kodi will be started after booting
          -b vdr  : VDR will be started after booting
```

## Switch OSD languange
To be able to switch the OSD languange you have to
- install Kodi addon: locale
- configure Kodi addon locale and choose your desired language
- create/modify file /storage/.profile with (in my case it's german):<br>
   export LANG="de_DE.UTF-8"<br>
   export LC_ALL="de_DE.UTF-8
- reboot

## Switch Kodi <-> VDR
The install script (parameter -i) tries to modify/create as many default configuration as possible. 
If some configuration files already exists, they will not be overwritten, but the changes needs to be done manually.

### /storage/.config/autostart.sh
The default file will be copied from installation directory, but if the file already exists, a warning will be displayed.
One additional line is necessary
```/storage/.opt/vdr/bin/autostart.sh```
This script prepares some systemd units and paths.

### /storage/.kodi/addons/skin.estuary/xml/DialogButtonMenu.xml
In Kodis default theme estuary, one additional entry will be added to the power menu to switch to VDR. 
If another skin is used, the entry needs to be done manually.
```
<item>
    <label>VDR</label>
    <onclick>System.Exec("/opt/vdr/bin/switch_to_vdr.sh")</onclick>
</item>
```
A whole sample can be found in ```<vdrdir>/config/DialogButtonMenu.xml```

### /storage/.config/vdropt/commands.conf
A new entry is needed, like e.g.
```
Start Kodi       : echo "START_PRG=kodi" > /opt/tmp/switch_kodi_vdr
```

## Das Verzeichnis-Layout und Dateien

- ```/usr/local/lib``` or ```/opt/vdr/lib```<br>
  contains libraries which are usually not part of CoreELEC
- ```/usr/local/vdr``` or ```/opt/vdr/```<br>
  contains VDR and all plugins
- ```/usr/local/vdr-2.6.1/config``` or ```/storage/.config/vdropt/```<br>
  contains the default configuration files  
- ```storage/.config/vdropt```<br>
  contains the VDR and plugin configuration files. Will never be overwritten by the install process. 
- ```storage/.config/vdropt-sample```<br>
  contains sample configuration files

## Start VDR
### \<bindir\>/start_vdr.sh 
Reads the file ```/storage/.config/vdropt/enabled-plugins``` which contains a plugin name on each line and starts VDR 
with all enabled plugins. The plugin configuration are read from ```/storage/.config/vdropt/*.conf```.
### \<bindir\>/start_vdr_easy.sh
Uses the plugin vdr-plugin-easyvdr (see https://www.gen2vdr.de/wirbel/easyvdr/index2.html) to start VDR. 
The configuration entries can be found in the ```/storage/.config/vdropt/*_settings.ini```.
Plugins can be started/stopped at runtime via the OSD.
Additionally the command line tool easyvdrctl.sh (which uses easyvdrctl) can be found in the &lt;bindir&gt;.

## Löschen
Wer sich dazu entscheidet, nach einer Installation alles wieder löschen zu wollen, muss nur die Vezeichnisse
```
/opt/vdr/
/storage/.conf/vdropt
/storage/.conf/vdropt-sampe
/storage/.fonts
```
entfernen und das System ist wieder im Urpsrungszustand.

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
