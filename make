#!/bin/bash

if [ -f build.ninja ]
then
	echo "build.ninja detected running ninja instead"
	/usr/bin/ninja "$@"
else
	/usr/bin/make "$@"
fi
