#!/bin/bash

PLASMA_DECORATION=12
#DEBUG=echo
DEBUG=


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
TERMWIDTH=$(($WIDTH/10 * 3 - $PLASMA_DECORATION))
GITWIDTH=$(($WIDTH/4 - $PLASMA_DECORATION))

VIMCOLSMIN=2
VIMCOLSMAX=3
VIMWIDTH=$(($WIDTH - $TERMWIDTH))

# if git, reserve one column for it
if [ ${#GITS[@]} -gt 0 ]
then
	VIMCOLSMAX=$((VIMCOLSMAX - 1))
	VIMCOLSMIN=$((VIMCOLSMIN - 1))
	VIMWIDTH=$((VIMWIDTH - $GITWIDTH))
fi

# effective vim columns
VIMCOLS=${#VIMS[@]}
if [ $VIMCOLS -lt $VIMCOLSMIN ]
then
	VIMCOLS=$VIMCOLSMIN
fi
if [ $VIMCOLS -gt $VIMCOLSMAX ]
then
	VIMCOLS=$VIMCOLSMAX
fi
VIMWIDTH=$((VIMWIDTH / $VIMCOLS - $PLASMA_DECORATION))

# align terminals
for W in ${TERMS[@]}
do
	$DEBUG $X windowsize $W $TERMWIDTH $HEIGHT
	$DEBUG $X windowmove $W $POS 55
	POS=$((POS + $TERMWIDTH + $PLASMA_DECORATION))
done

# align vims
VIMCOUNT=0
for W in ${VIMS[@]}
do
	$DEBUG $X windowsize $W $VIMWIDTH $HEIGHT
	$DEBUG $X windowmove $W $POS 55
	VIMCOUNT=$(($VIMCOUNT + 1))
	if [ $VIMCOUNT -lt $VIMCOLSMAX ]
	then
		POS=$((POS + $VIMWIDTH + $PLASMA_DECORATION))
	fi
done

# align gits
for W in ${GITS[@]}
do
	$DEBUG $X windowsize $W $GITWIDTH $HEIGHT
	$DEBUG $X windowmove $W $POS 55
done
