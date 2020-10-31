#!/bin/sh
# build_app_bundle.sh
# Author: Chad Armstrong (chad@edenwaith.com)
# Date: 17 October 2020
# Note: Run this script in the same directory as the agistudio.app bundle (e.g.
# agistudio-build-Desktop-Debug)

# macdeployqt
echo "macdeployqt"
macdeployqt agistudio.app

# install_name_tool
echo "install_name_tool"
cd agistudio.app/Contents/MacOS
install_name_tool -change Qt3Support.framework/Versions/4/Qt3Support @executable_path/../Frameworks/Qt3Support.framework/Versions/4/Qt3Support ./agistudio
install_name_tool -change QtGui.framework/Versions/4/QtGui @executable_path/../Frameworks/QtGui.framework/Versions/4/QtGui ./agistudio
install_name_tool -change QtCore.framework/Versions/4/QtCore @executable_path/../Frameworks/QtCore.framework/Versions/4/QtCore ./agistudio
cd -

# Copy Info.plist into app bundle
echo "Copy Info.plist"
cp -fv ../src/Info.plist agistudio.app/Contents/Info.plist

# Copy over Help files into the app bundle's Resource folder
echo "Copy help files"
cp -Rfv ../help agistudio.app/Contents/Resources/AGI\ Studio\ Help

# Copy over the template files into the app bundle's Resource folder
echo "Copy template files"
cp -Rfv ../template agistudio.app/Contents/Resources/template

# Rename app bundle
echo "Rename app bundle"
rm -Rfv AGI\ Studio.app # Delete the old app bundle
mv -fv agistudio.app AGI\ Studio.app # Rename agistudio to AGI Studio