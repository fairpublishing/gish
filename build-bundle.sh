set -e

bundle_name=FreeGish

if [ -z ${1+x} ]; then
  echo "error: please provide the target macOS version"
  echo "usage: $0 <macos-target>"
  exit 1
fi

# The following variable should be set to declare
# the minimum MACOSX version required by the application.
# For Apple Silicon ARM architecture it should be 11, corresponding to
# "Big Sur" released on 2020.
# For Intel x86-64 we can choose 10.11 corresponding to "El Capitan"
# release in 2015.
# See https://en.wikipedia.org/wiki/MacOS_version_history for more
# macOS version information.
export MACOSX_DEPLOYMENT_TARGET="$1"

# Note to build a package for Intel x86-64 when using an ARM macOS:
# source env-x86-64.sh

lhelper create build
source "$(lhelper env-source build)"

build_application() {
  rm -fr .build-bundle
  meson setup -Dbundle=true --buildtype=release --prefix="$PWD/${bundle_name}.app" --bindir=Contents/MacOS -Dmacos_target="$MACOSX_DEPLOYMENT_TARGET" .build-bundle
  meson compile -C .build-bundle
}

generate_bundle() {
  rm -fr "${bundle_name}.app"
  meson install --strip -C .build-bundle
}

build_application
generate_bundle ${bundle_name}
