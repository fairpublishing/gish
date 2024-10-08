set -e

get_arch () {
  if [ -z ${CPU_TYPE+x} ]; then
    uname -m
  else
    echo "$CPU_TYPE"
  fi
}

ARCH="$(get_arch)"

if [[ $ARCH == "x86-64" ]]; then
  ARCH="x86_64"
fi

setup_appimagetool() {
  if ! which appimagetool > /dev/null ; then
    if [ ! -e appimagetool ]; then
      if ! wget -O appimagetool "https://github.com/AppImage/AppImageKit/releases/download/continuous/appimagetool-${ARCH}.AppImage" ; then
        echo "Could not download the appimagetool for the arch '${ARCH}'."
        exit 1
      else
        chmod 0755 appimagetool
      fi
    fi
  fi
}

download_appimage_apprun() {
  if [ ! -e AppRun ]; then
    if ! wget -O AppRun "https://github.com/AppImage/AppImageKit/releases/download/continuous/AppRun-${ARCH}" ; then
      echo "Could not download AppRun for the arch '${ARCH}'."
      exit 1
    else
      chmod 0755 AppRun
    fi
  fi
}

build_application() {
  rm -fr .build-appimage
  meson setup --buildtype=release --prefix=/usr .build-appimage
  meson compile -C .build-appimage
}

generate_appimage() {
  local app_name="$1"

  if [ -e "${app_name}.AppDir" ]; then
    rm -rf "${app_name}.AppDir"
  fi
  mkdir "${app_name}.AppDir"

  echo "Creating ${app_name}.AppDir..."

  DESTDIR="$(realpath ${app_name}.AppDir)" meson install --strip -C .build-appimage

  cp AppRun "${app_name}.AppDir/"
  strip "${app_name}.AppDir/AppRun"

  cp resources/freegish.desktop "${app_name}.AppDir/${app_name}.desktop"
  cp resources/freegish.png "${app_name}.AppDir/freegish.png"

  echo "Generating AppImage..."

  ./appimagetool "${app_name}.AppDir" "${app_name}-${ARCH}.AppImage"
}

setup_appimagetool
download_appimage_apprun
build_application
generate_appimage FreeGish
