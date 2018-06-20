#!/bin/bash

X=xdotool

DESKTOP=$($X get_desktop)

WIDTH=$($X getdisplaygeometry | awk '{ print $1; }')
HEIGHT=$($X getdisplaygeometry | awk '{ print $2; }')

WINDOWS=($($X search --desktop $DESKTOP 'term'))
WINDOWS=($WINDOWS $($X search --desktop $DESKTOP 'vim'))
COUNT=${#WINDOWS[@]}

if [ $COUNT -gt 4 ]
then
	echo too many windows to create columns
	exit 1
fi

if [ $COUNT -lt 3 ]
then
	COUNT=3
fi

echo $WIDTH

WIDTH=$(($WIDTH/$COUNT))
POS=0

for W in ${WINDOWS[@]}
do
	EFF=$((WIDTH - 8))
	$X windowsize $W $EFF $HEIGHT
	$X windowmove $W $POS 0
	POS=$(($POS + $WIDTH + 8))
done
