#/bin/bash

set -e

usage() {
  cat << EOF >&2
Usage: $PROGNAME [-t] [-i] [-9] [-0]
-t  : Build tar (Matrix). Version containing only VDR and is installable in an existing Kodi installation
-i  : Build images (Matrix). Images will be created which can be written to an SD card. Contains VDR in /usr/local
-9  : Build images (corelec-19). Images will be created which can be written to an SD card. Contains VDR in /usr/local
-0  : Build images (corelec-20). Images will be created which can be written to an SD card. Contains VDR in /usr/local
EOF
  exit 1
}

create_vdr_tar() {
  #### Checkout the correct branch. Only 19.4-Matrix-VDR is supported
  git checkout 19.4-Matrix-VDR

  #### 1. Pass: build without VDR
  export VDR="no"
  VDR_PREFIX="/opt/vdr" make
  mv target/CoreELEC*.system target/image.pass1

  #### 2. Pass: build with VDR
  export VDR="yes"
  VDR_PREFIX="/opt/vdr" make
  mv target/CoreELEC*.system target/image.pass2

  #### Create Diff
  cd target
  mkdir -p pass1
  mkdir -p pass2
  squashfuse image.pass1 pass1
  squashfuse image.pass2 pass2
  find pass1 | sed -e "s/^pass1//g ; /^\/opt/d" | sort > pass1.filelist
  find pass2 | sed -e "s/^pass2//g ; /^\/opt/d" | sort > pass2.filelist
  diff -u8bBw pass1.filelist pass2.filelist | sed -e '/^\+/!d ; /^\+\/usr\/bin/d ; /^\+\/usr\/share/d ; s/^\+//g ; /^\+\+/d' > libs.diff
  cd ..

  # copy VDR data
  mkdir -p vdr-tar
  mkdir -p vdr-tar/storage/.fonts
  cp -a target/pass2/opt vdr-tar
  cp -a target/pass2/storage/.fonts/* vdr-tar/storage/.fonts/

  # copy extra libs from pass1 to vdr-tar
  while read -r line; do
     NEWFILE=`echo $line | sed -e 's/\/usr\/lib/\/opt\/vdr\/lib/g'`
     mkdir -p vdr-tar/`dirname $NEWFILE`
     if [ ! -d target/pass2/$line ]; then
         cp -a target/pass2/$line vdr-tar/$NEWFILE
     fi
  done <target/libs.diff

  # Cleanup
  rm -f vdr-tar/opt/.opt
  rm -f vdr-tar/opt/vdr/bin/{createcats,cxxtools-config,gdk-*,iconv,pango*,rsvg-convert,tntnet-config,update-mime-database}
  rm -Rf vdr-tar/opt/vdr/include
  rm -Rf vdr-tar/opt/vdr/lib/pkgconfig
  rm -Rf vdr-tar/opt/vdr/share/{doc,mime,pkgconfig,tntnet}

  find vdr-tar/opt/vdr/share/locale/ -not -name "vdr*" -and -not -type d -exec rm {} \;
  find vdr-tar -type d -empty -delete

  # build final archive
  tar -czhf build-artifacts/coreelec-19-vdr.tar.gz -C vdr-tar .
  rm -Rf vdr-tar

  # umount everything
  umount target/pass1 || echo "umount pass1 failed"
  umount target/pass2 || echo "umount pass2 failed"
}

create_vdr_image() {
  if [ "$1" = "Matrix" ]; then
     git checkout 19.4-Matrix-VDR
     SUFFIX="image-Matrix-VDR"
  elif [ "$1" = "19" ]; then
     git checkout coreelec-19-VDR
     SUFFIX="image-19-VDR"
  elif [ "$1" = "20" ]; then
     git checkout coreelec-20-VDR
     SUFFIX="image-20-VDR"
  else
     echo "Unknown image \"$1\". Abort build."
     exit 1
  fi

  export VDR="yes"
  VDR_PREFIX="/usr/local" BUILD_SUFFIX="${SUFFIX}" make image
}

cleanup() {
  mkdir -p build-artifacts
  rm -f build-artifacts/*

  # umount if still mounted
  umount -q target/pass1 || echo "target/pass1 not mounted"
  umount -q target/pass2 || echo "target/pass2 not mounted"
  rm -rf target/*
}

if [ "$#" = "0" ]; then
    usage
fi

cleanup

while getopts ti90 o; do
  case $o in
    (t) create_vdr_tar;;
    (i) create_vdr_image "Matrix";;
    (9) create_vdr_image "19";;
    (0) create_vdr_image "20";;
    (*) usage
  esac
done
