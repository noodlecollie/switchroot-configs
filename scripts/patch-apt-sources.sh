#!/bin/bash

if [[ $EUID -ne 0 ]]; then
   echo "This script must be run as root"
   exit 1
fi

echo "Swapping 'turul.canonical' for 'ports.ubuntu' in /etc/apt/sources.list"
sed -E -i 's/turul.canonical/ports.ubuntu/g' /etc/apt/sources.list
echo "Done."
