#!/bin/sh

# setup_qt_frameworks.sh
# Author: Chad Armstrong (chad@edenwaith.com)
# Date: 1 January 2021
# Description: Use a shell script function to properly set up the structure of a
# QT Mac framework so it can be signed properly

# macdeployqt does not properly create the Mac frameworks, so they do not code
# sign properly.  Set up the QT framework so the anatomy is properly structured.
function setup_framework {
#	$1 is the first parameter, the name of the QT framework (e.g. Qt3Support) 

	FRAMEWORK_NAME=$1
	
	echo "Updating the framework $FRAMEWORK_NAME"
	
	cd "$FRAMEWORK_NAME.framework"

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
	
	# Back out of the framework
	cd ..
}

setup_framework QtGui
setup_framework QtNetwork
setup_framework QtSql
setup_framework QtXml