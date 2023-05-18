#!/bin/bash -e

if [ -z "$1" ]
then
	echo "please give KEY-ID"
	exit 1
fi

sudo gpg --keyserver "hkps://keyserver.ubuntu.com:443" --recv-keys $1  # to /usr/share/keyrings/*
sudo gpg --yes --output "/etc/apt/trusted.gpg.d/$1.gpg" --export "$1"
