#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root" 
   exit 1
fi

currentDir=`dirname "$(readlink -f "$0")"`
sourcePath="$currentDir/../configs/x11/50-joystick.conf"
destPath="/usr/share/X11/xorg.conf.d/50-joystick.conf"

echo "Copying $sourcePath to $destPath"
cp $sourcePath $destPath
echo "Done."
