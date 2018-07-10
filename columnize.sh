#!/bin/bash

PLASMA_DECORATION=12
PLASMA_TASKBAR=70
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

OTHERS=(${VIMS[@]} ${GITS[@]})

POS=0

# 1/4 for the terminal
TERMWIDTH=$(($WIDTH/10 * 3 - $PLASMA_DECORATION))

# other => git, vim
OTHERS_COLSMIN=2
OTHERS_COLSMAX=2

OTHERS_WIDTH=$(($WIDTH - $TERMWIDTH))

# effective vim columns
OTHERS_COLS=${#OTHERS[@]}
if [ $OTHERS_COLS -lt $OTHERS_COLSMIN ]
then
	OTHERS_COLS=$OTHERS_COLSMIN
fi

if [ $OTHERS_COLS -gt $OTHERS_COLSMAX ]
then
	OTHERS_COLS=$OTHERS_COLSMAX
fi
OTHERS_WIDTH=$((OTHERS_WIDTH / $OTHERS_COLS - $PLASMA_DECORATION))

# align terminals
for W in ${TERMS[@]}
do
	$DEBUG $X windowsize $W $TERMWIDTH $HEIGHT
	$DEBUG $X windowmove $W $POS $PLASMA_TASKBAR
	POS=$((POS + $TERMWIDTH + $PLASMA_DECORATION))
done

# align vims
OTHERS_COUNT=0
for W in ${OTHERS[@]}
do
	$DEBUG $X windowsize $W $OTHERS_WIDTH $HEIGHT
	$DEBUG $X windowmove $W $POS $PLASMA_TASKBAR
	OTHERS_COUNT=$((OTHERS_COUNT + 1))
	if [ $OTHERS_COUNT -lt $OTHERS_COLSMAX ] # overlapped everything >= $OTHERS_COLSMAX
	then
		POS=$((POS + $OTHERS_WIDTH + $PLASMA_DECORATION))
	fi
done
