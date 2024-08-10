#!/usr/bin/env bash

set -e

app_name=FreeGish
exe_name=gish

if [ $# -lt 2 ]; then
  echo "usage: $0 <version> <macos-target>"
  exit 1
fi

# The following variable should be set to declare
# the minimum MACOSX version required by the application.
# export MACOSX_DEPLOYMENT_TARGET=10.13

if [[ -z $APPLE_DEV_APPLICATION || -z $APPLE_APP_PASSWORD || -z $APPLE_ID ]]; then
  echo "error: to notarize the variables APPLE_DEV_APPLICATION APPLE_APP_PASSWORD and"
  echo "       APPLE_ID must be all defined."
  exit 1
fi

version="$1"
macos_target="$2"
app_name_low="${app_name,,}"

arch="$CPU_TYPE"
if [[ $ARCH == "x86-64" ]]; then
  arch="x86_64"
fi

rm -fr "${app_name}.app"

bash build-bundle.sh $macos_target

app_path="${app_name}.app"

echo "APP PATH: $app_path"

exe_file="$app_path/Contents/MacOS/$exe_name"

# Fortify the runtime
codesign -f -o runtime --deep --timestamp -s "Developer ID Application: ${APPLE_DEV_APPLICATION}" "${app_path}"

hdiutil create -volname "$app_name_low" -srcfolder "${app_path}" -ov -format UDBZ "${app_name_low}-${arch}.dmg"

codesign -s "Developer ID Application: ${APPLE_DEV_APPLICATION}" --timestamp "${app_name_low}-${arch}.dmg"
codesign -v "${app_path}"

echo "Ok to notarize ?"
read ans
if [[ "$ans" == "yes" ]]; then
  xcrun notarytool submit --apple-id "${APPLE_ID}" --team-id "${APPLE_TEAM_ID}" --password "${APPLE_APP_PASSWORD}" --wait "${app_name_low}-${arch}.dmg"
  # to see status of notarization:
  # xcrun notarytool history --apple-id "${APPLE_ID}" --team-id "${APPLE_TEAM_ID}" --password "${APPLE_APP_PASSWORD}"
fi

