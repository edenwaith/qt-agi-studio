#!/bin/sh
# build_app_bundle.sh
# Author: Chad Armstrong (chad@edenwaith.com)
# Date: 17 October 2020
# Note: Run this script in the same directory as the agistudio.app bundle

# Print out the current working directory
function cwd {
	PWD=`pwd`
	echo "Current working directory is: $PWD\n"
}

# macdeployqt does not properly create the Mac frameworks, so they do not code
# sign properly.  Set up the QT framework so the anatomy is properly structured.
function setup_framework {
#	$1 is the first parameter, the name of the QT framework (e.g. Qt3Support) 

	FRAMEWORK_NAME=$1

	cwd
	PARENT_DIR=`pwd`
	
	echo "Updating the framework $FRAMEWORK_NAME"
	
	cd "./agistudio.app/Contents/Frameworks/$FRAMEWORK_NAME.framework"

	# Check that if the Resources is not a symlink 
	if [ ! -h "Resources" ]; then
		# If there is an existing Resources folder, it needs to be moved into the Versions/4/ folder
		mv -f Resources Versions/4/
	fi
	
	# Create the Current soft link.  Move into the Versions directory to properly
	# set up the soft link 
	cd Versions
	ln -s 4 Current 
	cd ..
	
	# Create the Resources soft link
	ln -s Versions/Current/Resources Resources
	
	# Create a soft link for the framework executable (Qtwhatever) to 
	ln -s "Versions/Current/$FRAMEWORK_NAME" "$FRAMEWORK_NAME"
	
	# Return to the parent working directory 
	cd "$PARENT_DIR"
	
	cwd
}

# macdeployqt
echo "\nmacdeployqt"
macdeployqt agistudio.app

# install_name_tool
echo "\ninstall_name_tool"
cd agistudio.app/Contents/MacOS
install_name_tool -change Qt3Support.framework/Versions/4/Qt3Support @executable_path/../Frameworks/Qt3Support.framework/Versions/4/Qt3Support ./agistudio
install_name_tool -change QtGui.framework/Versions/4/QtGui @executable_path/../Frameworks/QtGui.framework/Versions/4/QtGui ./agistudio
install_name_tool -change QtCore.framework/Versions/4/QtCore @executable_path/../Frameworks/QtCore.framework/Versions/4/QtCore ./agistudio

# Verify that install_name_tool worked
# otool -L agistudio.app/Contents/MacOS/agistudio

# Return to the parent folder of agistudio.app
cd -

# Add Info.plist file to QT Frameworks so they can be code signed properly
# $ cp ~/Qt5.2.0/5.2.0-beta1/clang_64/lib/QtCore.framework/Contents/Info.plist MyApplication.app/Contents/Frameworks/QtCore.framework/Resources/


# Might also have to add the following key-value pairs to each Info.plist, as well
# - CFBundleIdentifier ("org.qt-project.QtCore")
# - CFBundleVersion ("4.6.4") // Or Perhaps just 4.8, or just grab the CFBundleShortVersionString value

# /usr/libexec/PlistBuddy
# https://marcosantadev.com/manage-plist-files-plistbuddy/
# https://fgimian.github.io/blog/2015/06/27/a-simple-plistbuddy-tutorial/
# /usr/libexec/PlistBuddy -c "Add :test integer 20" ~/Desktop/test.plist

# Add new key-value pair

# Set existing key-value pair 
# /usr/libexec/PlistBuddy -c "Set :CFBundleVersion string 4.8" ./agistudio.app/Contents/Frameworks/QtXml.framework/Resources/Info.plist

# This is not the correct location for the Info.plist.  It will be moved into the Versions/Current/Resource folder, instead



# cd "./agistudio.app/Contents/Frameworks"

cwd

echo "\nCopy and update Info.plist into Qt Frameworks"
cp /Library/Frameworks/Qt3Support.framework/Contents/Info.plist ./agistudio.app/Contents/Frameworks/Qt3Support.framework/Resources/
/usr/libexec/PlistBuddy -c "Add :CFBundleVersion string 4.8" ./agistudio.app/Contents/Frameworks/Qt3Support.framework/Resources/Info.plist
/usr/libexec/PlistBuddy -c "Add :CFBundleIdentifier string org.qt-project.Qt3Support" ./agistudio.app/Contents/Frameworks/Qt3Support.framework/Resources/Info.plist
setup_framework Qt3Support

cp /Library/Frameworks/QtCore.framework/Contents/Info.plist ./agistudio.app/Contents/Frameworks/QtCore.framework/Resources/
/usr/libexec/PlistBuddy -c "Add :CFBundleVersion string 4.8" ./agistudio.app/Contents/Frameworks/QtCore.framework/Resources/Info.plist
/usr/libexec/PlistBuddy -c "Add :CFBundleIdentifier string org.qt-project.QtCore" ./agistudio.app/Contents/Frameworks/QtCore.framework/Resources/Info.plist
setup_framework QtCore

cp /Library/Frameworks/QtGui.framework/Contents/Info.plist ./agistudio.app/Contents/Frameworks/QtGui.framework/Resources/
/usr/libexec/PlistBuddy -c "Add :CFBundleVersion string 4.8" ./agistudio.app/Contents/Frameworks/QtGui.framework/Resources/Info.plist
/usr/libexec/PlistBuddy -c "Add :CFBundleIdentifier string org.qt-project.QtGui" ./agistudio.app/Contents/Frameworks/QtGui.framework/Resources/Info.plist
setup_framework QtGui

cp /Library/Frameworks/QtNetwork.framework/Contents/Info.plist ./agistudio.app/Contents/Frameworks/QtNetwork.framework/Resources/
/usr/libexec/PlistBuddy -c "Add :CFBundleVersion string 4.8" ./agistudio.app/Contents/Frameworks/QtNetwork.framework/Resources/Info.plist
/usr/libexec/PlistBuddy -c "Add :CFBundleIdentifier string org.qt-project.QtNetwork" ./agistudio.app/Contents/Frameworks/QtNetwork.framework/Resources/Info.plist
setup_framework QtNetwork

cp /Library/Frameworks/QtSql.framework/Contents/Info.plist ./agistudio.app/Contents/Frameworks/QtSql.framework/Resources/
/usr/libexec/PlistBuddy -c "Add :CFBundleVersion string 4.8" ./agistudio.app/Contents/Frameworks/QtSql.framework/Resources/Info.plist
/usr/libexec/PlistBuddy -c "Add :CFBundleIdentifier string org.qt-project.QtSql" ./agistudio.app/Contents/Frameworks/QtSql.framework/Resources/Info.plist
setup_framework QtSql

cp /Library/Frameworks/QtXml.framework/Contents/Info.plist ./agistudio.app/Contents/Frameworks/QtXml.framework/Resources/
/usr/libexec/PlistBuddy -c "Add :CFBundleVersion string 4.8" ./agistudio.app/Contents/Frameworks/QtXml.framework/Resources/Info.plist
/usr/libexec/PlistBuddy -c "Add :CFBundleIdentifier string org.qt-project.QtXml" ./agistudio.app/Contents/Frameworks/QtXml.framework/Resources/Info.plist
setup_framework QtXml

# Return to the parent folder of agistudio.app
# cd - 

PWD=`pwd`
echo "Current working directory is: $PWD\n"


# Copy Info.plist into app bundle
echo "\nCopy Info.plist into app bundle"
cp -fv ../src/Info.plist agistudio.app/Contents/Info.plist

# Copy over Help files into the app bundle's Resource folder
echo "\nCopy help files"
cp -Rfv ../help agistudio.app/Contents/Resources/AGI\ Studio\ Help

# Copy over the template files into the app bundle's Resource folder
echo "\nCopy template files"
cp -Rfv ../template agistudio.app/Contents/Resources/template

# Rename app bundle
echo "\n\nRename app bundle"
rm -Rfv AGI\ Studio.app # Delete the old app bundle
mv -f agistudio.app AGI\ Studio.app # Rename agistudio to AGI Studio


# Various ways to code sign the various parts of the app.
# Do this in another app.

#sign app
# codesign --force --verify --verbose --sign "Developer ID Application: My DEVID" ./MyApplication.app

#sign all *.dylib
# find MyApplication.app -name *.dylib | xargs -I $ codesign --force --verify --verbose --sign "Developer ID Application: My DEVID" $

#sign Qt frameworks
# find MyApplication.app -name Qt* -type f | xargs -I $ codesign --force --verify --verbose --sign "Developer ID Application: My DEVID" $