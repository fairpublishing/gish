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
  rm -fr .build-package
  meson setup --buildtype=release --prefix=/ .build-package
  meson compile -C .build-package
}

generate_package() {
  local appname="${1,,}"
  local destdir=".app/$appname"

  if [ -e "$destdir" ]; then
    rm -fr "$destdir"
  fi
  mkdir -p "$destdir"

  echo "Creating ${destdir}..."

  DESTDIR="$(realpath "$destdir")" meson install --strip -C .build-package
  mv "$destdir/bin/gish"* "$destdir" && rm -fr "$destdir/bin"

  pushd ".app"
  tar czf "../$appname-$OSTYPE-$ARCH.tar.gz" "$appname"
  popd

  echo "Created package $appname-$OSTYPE-$ARCH.tar.gz"
}

setup_appimagetool
download_appimage_apprun
build_application
generate_package FreeGish
