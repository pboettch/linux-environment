#!/bin/bash

X=xdotool

DESKTOP=$($X get_desktop)

WIDTH=$($X getdisplaygeometry | awk '{ print $1; }')
HEIGHT=$($X getdisplaygeometry | awk '{ print $2; }')

# get terminals
TERMS=($($X search --desktop $DESKTOP 'term'))
VIMS=($($X search --desktop $DESKTOP 'vim'))
GITS=($($X search --desktop $DESKTOP 'git'))

POS=0

# 1/4 for the terminal
TERMWIDTH=$(($WIDTH/4))
GITWIDTH=$(($WIDTH/4))

VIMCOLSMAX=3
VIMWIDTH=$(($WIDTH - $TERMWIDTH))

# if git, reserve one column for it
if [ ${#GITS[@]} -gt 0 ]
then
	VIMCOLSMAX=$((VIMCOLSMAX - 1))
	VIMWIDTH=$((VIMWIDTH - $GITWIDTH))
fi

# effective vim columns
VIMCOLS=${#VIMS[@]}
if [ $VIMCOLS -lt 2 ]
then
	VIMCOLS=$VIMCOLSMAX
fi
if [ $VIMCOLS -gt $VIMCOLSMAX ]
then
	VIMCOLS=$VIMCOLSMAX
fi
VIMWIDTH=$((VIMWIDTH / $VIMCOLS))

# align terminals
for W in ${TERMS[@]}
do
	$X windowsize $W $TERMWIDTH $HEIGHT
	$X windowmove $W $POS 55
	POS=$((POS + $TERMWIDTH))
done

# align vims
VIMCOUNT=0
for W in ${VIMS[@]}
do
	$X windowsize $W $VIMWIDTH $HEIGHT
	$X windowmove $W $POS 55
	VIMCOUNT=$(($VIMCOUNT + 1))
	if [ $VIMCOUNT -lt $VIMCOLSMAX ]
	then
		POS=$((POS + $VIMWIDTH))
	fi
done
POS=$(($POS + $VIMWIDTH))

# align gits
for W in ${GITS[@]}
do
	$X windowsize $W $GITWIDTH $HEIGHT
	$X windowmove $W $POS 55
done
