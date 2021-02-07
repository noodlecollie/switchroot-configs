#!/bin/bash

if [[ $EUID -ne 0 ]]; then
	>&2 echo "This script must be run as root"
	exit 1
fi

read -p "Enter swapfile size (default 1G): " swapFileSize
if [ -z "$swapFileSize" ]
then
	swapFileSize="1G"
fi

echo "Allocating swap file of size $swapFileSize"

if ! fallocate -l $swapFileSize /swapfile ; then
	>&2 echo "Failed to allocate swap file."
	exit 1
fi

if ! chmod 600 /swapfile ; then
	>&2 echo "Failed to change permissions on swap file."
	exit 1
fi

if ! mkswap /swapfile ; then
	>&2 echo "Failed to apply swap file."
	exit 1
fi

if ! swapon /swapfile ; then
	>&2 echo "Failed to enable swap file."
	exit 1
fi

echo "Swap file created successfully. Paste the following line into /etc/fstab:"
echo "/swapfile swap swap defaults 0 0"
