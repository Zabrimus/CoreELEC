#/bin/bash

BRANCH=exp-vdr-opt

RUNNER_BUILDDIR=build.CoreELEC-Amlogic-ng.arm-19
RUNNER_CACHE=exp-vdr-opt-build
RUNNER_SOURCES=exp-vdr-opt-sources

restore_build_cache() {
  # restore build-cache
  if [ -d ../build-cache/${RUNNER_CACHE} ]; then
    rm -f ${RUNNER_BUILDDIR}
    ln -s ../build-cache/${RUNNER_CACHE} ${RUNNER_BUILDDIR}
  fi

  if [ -d ../build-cache/${RUNNER_SOURCES} ]; then
    rm -f sources
    ln -s ../build-cache/${RUNNER_SOURCES} sources
  fi
}

create_vdr_tar() {
  clean_build_directory

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

  # Extract VDR archive
  mkdir -p vdr-tar
  cp -a target/pass2/opt vdr-tar

  # copy extra libs from pass1 to vdr-tar
  while read -r line; do
     NEWFILE=`echo $line | sed -e 's/\/usr\/lib/\/opt\/vdr\/lib/g'`
     mkdir -p vdr-tar/`dirname $NEWFILE`
     if [ ! -d target/pass2/$line ]; then
         cp -a target/pass2/$line vdr-tar/$NEWFILE
     fi
  done <target/libs.diff

  # Cleanup
  rm vdr-tar/opt/.opt
  rm vdr-tar/opt/vdr/bin/{createcats,cxxtools-config,gdk-*,iconv,pango*,rsvg-convert,tntnet-config,update-mime-database}
  rm -Rf vdr-tar/opt/vdr/include
  rm -Rf vdr-tar/opt/vdr/lib/pkgconfig
  rm -Rf vdr-tar/opt/vdr/share/{doc,mime,pkgconfig,tntnet}

  find vdr-tar/opt/vdr/share/locale/ -not -name "vdr*" -and -not -type d -exec rm {} \;
  find vdr-tar -type d -empty -delete

  # build final archive
  tar -czhf build-artifacts/coreelec-vdr.tar.gz -C vdr-tar .
  rm -Rf vdr-tar

  # umount everything
  umount target/pass1
  umount target/pass2
}

create_vdr_image() {
  clean_build_directory

  export VDR="yes"
  VDR_PREFIX="/usr/local" make image
}

clean_build_directory() {
  # rm VDR and all dependencies in build directory
  rm -Rf ${RUNNER_BUILDDIR}/build/_*
  rm -Rf ${RUNNER_BUILDDIR}/install_pkg/_*
  rm -Rf ${RUNNER_BUILDDIR}/image/system/opt
  rm -Rf ${RUNNER_BUILDDIR}/image/.stamps/_*
  rm -Rf ${RUNNER_BUILDDIR}/image/.stamps/vdr-all
  rm -Rf ${RUNNER_BUILDDIR}/.stamps/_*
  rm -Rf ${RUNNER_BUILDDIR}/.stamps/vdr-all
}

save_cache() {
  # save build cache
  mkdir -p ../build-cache

  if [ ! -d ../build-cache/${RUNNER_CACHE} ]; then
     mv ${RUNNER_BUILDDIR} ../build-cache/${RUNNER_CACHE}
  else
     rm ${RUNNER_BUILDDIR}
  fi

  if [ ! -d ../build-cache/${RUNNER_SOURCES} ]; then
     mv sources ../build-cache/${RUNNER_SOURCES}
  else
     rm sources
  fi
}

restore_build_cache

mkdir -p build-artifacts
rm build-artifacts/*

rm -f target/*
create_vdr_tar

# Not yet
#rm -f target/*
#create_vdr_image
#mv target/*.tar build-artifacts/CoreELEC-Amlogic-ng.arm-19.4-Matrix_VDR_devel.tar
#mv target/CoreELEC-Amlogic-ng.arm-19.4-Matrix_devel*Odroid_C4.img.gz build-artifacts/CoreELEC-Amlogic-ng.arm-19.4-Matrix_VDR_devel-Odroid_C4.img.gz

clean_build_directory
save_cache
